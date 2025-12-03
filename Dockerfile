FROM ubuntu:24.04

RUN apt-get update -y && apt-get install -y wget make

WORKDIR /tmp

RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz 

RUN zcat < install-tl-unx.tar.gz | tar xf -

RUN rm -rf install-tl-unx.tar.gz && mv install-tl-* install-tl
WORKDIR /tmp/install-tl

RUN apt-get install -y perl-modules

RUN perl ./install-tl --no-interaction

ENV PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH

COPY jlisting.sty /usr/local/texlive/2025/texmf-dist/tex/latex/listings/
RUN chmod 644 /usr/local/texlive/2025/texmf-dist/tex/latex/listings/jlisting.sty
RUN mktexlsr

USER ubuntu

WORKDIR /home/ubuntu
