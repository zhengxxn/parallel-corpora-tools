#/bin/bash

# Parameters:
#	directory that contains multiple parallel files with language codes as extensions
#	source language code
#	target language code

dir=$1
src=$2
trg=$3

mkdir -p $dir/output
mkdir -p $dir/output/removed

cat $dir/*.$src > $dir/output/corpus.$src
cat $dir/*.$trg > $dir/output/corpus.$trg


./1-find-equal-lines.sh \
    $dir/output/corpus.$src \
    $dir/output/corpus.$trg

./2-unique-parallel.sh \
    $dir/output/corpus.$src.c \
    $dir/output/corpus.$trg.c \
    $src \
    $trg

./3-identify-language.sh \
    $dir/output/corpus.$src.c.up.nor.up.nor.nonalpha.nonmatch.reptok \
    $dir/output/corpus.$trg.c.up.nor.up.nor.nonalpha.nonmatch.reptok \
    $src \
    $trg

./4-moses-scripts-subword-nmt.sh \
    $dir \
    $src \
    $trg

