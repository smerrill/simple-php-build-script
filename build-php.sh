#!/bin/bash -eux

PHP_VERSION="php-5.3.26"

mkdir -p {cache,build,src}

[[ -f cache/$PHP_VERSION.tar.gz ]] || {
  wget http://us1.php.net/get/$PHP_VERSION.tar.gz/from/www.php.net/mirror -O cache/$PHP_VERSION.tar.gz
}
[[ -d src/$PHP_VERSION ]] || {
  cd src
  tar xzf ../cache/$PHP_VERSION.tar.gz
  cd ..
}
[[ -d build/$PHP_VERSION ]] || {
  mkdir -p build/$PHP_VERSION/{bin,etc/conf.d,libexec}
}

cd src/$PHP_VERSION

./configure \
--with-config-file-path=../../build/$PHP_VERSION/etc \
--with-config-file-scan-dir=../../build/$PHP_VERSION/etc/conf.d \
--prefix=../../build/$PHP_VERSION \
--libexecdir=../../build/$PHP_VERSION/libexec \
--with-pear \
--with-gd \
--enable-sockets \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--enable-exif \
--enable-zip \
--with-zlib \
--with-zlib-dir=/usr \
--with-kerberos \
--with-openssl \
--with-mcrypt=/usr \
--enable-soap \
--enable-xmlreader \
--with-xsl \
--enable-ftp \
--enable-cgi \
--with-curl=/usr \
--without-tidy \
--with-xmlrpc \
--enable-sysvsem \
--enable-sysvshm \
--enable-shmop \
--with-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-pdo-sqlite \
--enable-pcntl \
--with-readline \
--enable-mbstring \
--disable-debug \
--enable-fpm \
--with-libdir=lib64

make -j9
make install
make clean
