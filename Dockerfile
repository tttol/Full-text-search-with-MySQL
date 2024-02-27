FROM mysql:8.0-debian

RUN apt-get update && \
    apt-get install -y \
    git \
    build-essential \
    cmake \
    libmecab-dev \
    mecab \
    mecab-ipadic-utf8

# Clone the MeCab plugin source code
RUN git clone https://github.com/mysql/mysql-server.git /usr/src/mysql-server

# Build the MeCab plugin
WORKDIR /usr/src/mysql-server/plugin/fulltext
RUN cmake . && make mecab_parser

# Copy the built plugin to the MySQL plugin directory
RUN cp mecab_parser.so /usr/lib/mysql/plugin/