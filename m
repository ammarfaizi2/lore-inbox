Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbSLEUxw>; Thu, 5 Dec 2002 15:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbSLEUxw>; Thu, 5 Dec 2002 15:53:52 -0500
Received: from pcls2.std.com ([199.172.62.104]:19364 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id <S267431AbSLEUxm>;
	Thu, 5 Dec 2002 15:53:42 -0500
Date: Thu, 5 Dec 2002 16:01:17 -0500 (EST)
From: Andrew Tannenbaum <trb@TheWorld.com>
Message-Id: <200212052101.QAA79341843@shell.TheWorld.com>
To: linux-kernel@vger.kernel.org
Subject: bug in sysctl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a shar attached below that contains a script to reproduce
this problem.

1. One line summary:
sysctl is returning bad data with multi-word arrays.

2. full description:

The bug is that the /proc/sys interface seems to write data incorrectly.  I
include a simple tsc (test sysctl) script, that writes a set of values.  Notice
that the last value, -62345678 gets shown as -6234567.  In some tests, the
missing digit 8 ends up in the next location.

It could be a read problem, but I don't think so.
Note that the errant data does print 32 items, not 33 (since it is "splitting"
one of them).

I think this bug is on the kernel side, because I am getting odd behavior
whether I use /sbin/sysctl, or whether I write to /proc/sys with my own
programs.

3. keyword: kernel / sysctl

4. version:

Linux localhost.localdomain 2.4.18-w4l-rtl3.1 #2 Wed Jun 26 17:32:45 EDT 2002 i686 unknown

also:
Linux trb-rtl.imt 2.2.18-rtl3.0 #1 Tue Jan 30 14:23:47 CET 2001 i686 unknown

I'm running with RTLinux patches on both these machines, they are
otherwise common.

5. no crash

6. script that triggers problem:
Also see shar attached below.

scbug.o is an lkm that creates an array in /proc/sys/kernel/scbug/scratch
(see associated shar file).

tsc: a small test shell script

<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>

# insmod scbug.o

# cat tsc
sysctl -w kernel/scbug/scratch="91 92 93 94 95 96 97 98 99"

sysctl kernel/scbug/scratch

sysctl -w kernel/scbug/scratch="11111111 -22222222 33333333 -44444444 55555555 -62345678"

sysctl kernel/scbug/scratch

# ./tsc
kernel.scbug.scratch = 91 92 93 94 95 96 97 98 99
kernel.scbug.scratch = 91       92      93      94      95      96      97     98       99      0       0       0       0       0       0       0       0      0
        0       0       0       0       0       0       0       0       0      0
        0       0       0       0
kernel.scbug.scratch = 11111111 -22222222 33333333 -44444444 55555555 -62345678
kernel.scbug.scratch = 11111111 -22222222       33333333        -44444444      55555555 -6234567        97      98      99      0       0       0       0      0
        0       0       0       0       0       0       0       0       0      0
        0       0       0       0       0       0       0       0

-- end of report --



8<--cut here--

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2.1).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 2002-12-05 15:30 EST by <trb@trb-rtl.imt>.
# Source directory was `/home/trb'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#     97 -rw-rw-r-- scbug/Makefile
#   1134 -rw------- scbug/scbug.c
#    209 -rwxr-xr-x scbug/tsc
#   2171 -rw-r--r-- scbug/scbug.rpt
#    402 -rw-rw-r-- scbug/make.out
#
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
  if test "$gettext_dir" = FAILED && test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    set `$dir/gettext --version 2>&1`
    if test "$3" = GNU
    then
      gettext_dir=$dir
    fi
  fi
  if test "$locale_dir" = FAILED && test -f $dir/shar \
     && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
  then
    locale_dir=`$dir/shar --print-text-domain-dir`
  fi
done
IFS="$save_IFS"
if test "$locale_dir" = FAILED || test "$gettext_dir" = FAILED
then
  echo=echo
else
  TEXTDOMAINDIR=$locale_dir
  export TEXTDOMAINDIR
  TEXTDOMAIN=sharutils
  export TEXTDOMAIN
  echo="$gettext_dir/gettext -s"
fi
if touch -am -t 200112312359.59 $$.touch >/dev/null 2>&1 && test ! -f 200112312359.59 -a -f $$.touch; then
  shar_touch='touch -am -t $1$2$3$4$5$6.$7 "$8"'
elif touch -am 123123592001.59 $$.touch >/dev/null 2>&1 && test ! -f 123123592001.59 -a ! -f 123123592001.5 -a -f $$.touch; then
  shar_touch='touch -am $3$4$5$6$1$2.$7 "$8"'
elif touch -am 1231235901 $$.touch >/dev/null 2>&1 && test ! -f 1231235901 -a -f $$.touch; then
  shar_touch='touch -am $3$4$5$6$2 "$8"'
else
  shar_touch=:
  echo
  $echo 'WARNING: not restoring timestamps.  Consider getting and'
  $echo "installing GNU \`touch', distributed in GNU File Utilities..."
  echo
fi
rm -f 200112312359.59 123123592001.59 123123592001.5 1231235901 $$.touch
#
if mkdir _sh01217; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= scbug/Makefile ==============
if test ! -d 'scbug'; then
  $echo 'x -' 'creating directory' 'scbug'
  mkdir 'scbug'
fi
if test -f 'scbug/Makefile' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'scbug/Makefile' '(file already exists)'
else
  $echo 'x -' extracting 'scbug/Makefile' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'scbug/Makefile' &&
bug:	scbug.o
X	insmod scbug.o
X	./tsc
X
scbug.o:
X	gcc -c scbug.c -Wall
X
clean:
X	rmmod scbug
X	rm *.o
SHAR_EOF
  (set 20 02 12 04 16 30 03 'scbug/Makefile'; eval "$shar_touch") &&
  chmod 0664 'scbug/Makefile' ||
  $echo 'restore of' 'scbug/Makefile' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'scbug/Makefile:' 'MD5 check failed'
796e34bfe17a6cb88d7bd613aef34ec2  scbug/Makefile
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'scbug/Makefile'`"
    test 97 -eq "$shar_count" ||
    $echo 'scbug/Makefile:' 'original size' '97,' 'current size' "$shar_count!"
  fi
fi
# ============= scbug/scbug.c ==============
if test -f 'scbug/scbug.c' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'scbug/scbug.c' '(file already exists)'
else
  $echo 'x -' extracting 'scbug/scbug.c' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'scbug/scbug.c' &&
/*
X * sysctl bug prog
X */
X
#define __KERNEL__
#define MODULE
#include <linux/module.h>
X
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/sysctl.h>
#include <linux/ctype.h>
X
#define __KERNEL_SYSCALLS__
#include <linux/unistd.h>
#include <asm/unistd.h>
X
#ifndef VERSION_CODE
#  define VERSION_CODE(vers,rel,seq) ( (vers<<16) | (rel<<8) | seq )
#endif
X
int scratch[32];
X
#define KERN_SCBUG 434 /* a random number, high enough */
enum {SCRATCH=1};
X
/* the scratch array */
static ctl_table scbug_table[] = {
X	{SCRATCH, "scratch", &scratch, 32*sizeof(int), 0644,
X	NULL, &proc_dointvec, &sysctl_intvec, /* fill with 0's */},
X	{0}
X	};
X
/* a directory */
static ctl_table scbug_kern_table[] = {
X	{KERN_SCBUG, "scbug", NULL, 0, 0555, scbug_table},
X	{0}
X	};
X
/* the kernel directory */
static ctl_table scbug_root_table[] = {
X	{CTL_KERN, "kernel", NULL, 0, 0555, scbug_kern_table},
X	{0}
X	};
X
static struct ctl_table_header *scbug_table_header;
X
int init_module(void) 
{
X	scbug_table_header = register_sysctl_table(scbug_root_table, 0);
X	return 0;
}
X
void cleanup_module(void)
{
X	unregister_sysctl_table(scbug_table_header);
}
SHAR_EOF
  (set 20 02 12 04 13 21 59 'scbug/scbug.c'; eval "$shar_touch") &&
  chmod 0600 'scbug/scbug.c' ||
  $echo 'restore of' 'scbug/scbug.c' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'scbug/scbug.c:' 'MD5 check failed'
13c9e91470b69730be09c9718bba008b  scbug/scbug.c
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'scbug/scbug.c'`"
    test 1134 -eq "$shar_count" ||
    $echo 'scbug/scbug.c:' 'original size' '1134,' 'current size' "$shar_count!"
  fi
fi
# ============= scbug/tsc ==============
if test -f 'scbug/tsc' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'scbug/tsc' '(file already exists)'
else
  $echo 'x -' extracting 'scbug/tsc' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'scbug/tsc' &&
sysctl -w kernel/scbug/scratch="91 92 93 94 95 96 97 98 99"
X
sysctl kernel/scbug/scratch
X
sysctl -w kernel/scbug/scratch="11111111 -22222222 33333333 -44444444 55555555 -62345678"
X
sysctl kernel/scbug/scratch
SHAR_EOF
  (set 20 02 12 04 13 16 06 'scbug/tsc'; eval "$shar_touch") &&
  chmod 0755 'scbug/tsc' ||
  $echo 'restore of' 'scbug/tsc' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'scbug/tsc:' 'MD5 check failed'
4078f361f00fc594865b9822b144fb91  scbug/tsc
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'scbug/tsc'`"
    test 209 -eq "$shar_count" ||
    $echo 'scbug/tsc:' 'original size' '209,' 'current size' "$shar_count!"
  fi
fi
# ============= scbug/scbug.rpt ==============
if test -f 'scbug/scbug.rpt' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'scbug/scbug.rpt' '(file already exists)'
else
  $echo 'x -' extracting 'scbug/scbug.rpt' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'scbug/scbug.rpt' &&
1. One line summary:
sysctl is returning bad data with multi-word arrays.
X
2. full description:
X
The bug is that the /proc/sys interface seems to write data incorrectly.  I
include a simple tsc (test sysctl) script, that writes a set of values.  Notice
that the last value, -62345678 gets written as -6234567.  (In some tests, the
missing 8 ends up in the next location.)
X
It could be a read problem, but I don't think so.
Note that the errant data does print 32 items, not 33 (since it is "splitting"
one of them).
X
I think this bug is on the kernel side, because I am getting odd behavior
whether I use /sbin/sysctl, or whether I write to /proc/sys with my own
programs.
X
3. keyword: kernel / sysctl
X
4. version:
X
# uname -a
Linux localhost.localdomain 2.4.18-w4l-rtl3.1 #2 Wed Jun 26 17:32:45 EDT 2002 i686 unknown
also:
Linux trb-rtl.imt 2.2.18-rtl3.0 #1 Tue Jan 30 14:23:47 CET 2001 i686 unknown
X
5. no crash
X
6. script that triggers problem:
This is shell output, split it up by hand, it's not too long.
X
scbug.o is an lkm that creates an array in /proc/sys/kernel/scbug/scratch
(see associated shar file).
X
tsc: a small test shell script
X
<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>
X
# insmod scbug.o
X
# cat tsc
sysctl -w kernel/scbug/scratch="91 92 93 94 95 96 97 98 99"
X
sysctl kernel/scbug/scratch
X
sysctl -w kernel/scbug/scratch="11111111 -22222222 33333333 -44444444 55555555 -62345678"
X
sysctl kernel/scbug/scratch
X
# ./tsc
kernel.scbug.scratch = 91 92 93 94 95 96 97 98 99
kernel.scbug.scratch = 91       92      93      94      95      96      97     98       99      0       0       0       0       0       0       0       0      0
X        0       0       0       0       0       0       0       0       0      0
X        0       0       0       0
kernel.scbug.scratch = 11111111 -22222222 33333333 -44444444 55555555 -62345678
kernel.scbug.scratch = 11111111 -22222222       33333333        -44444444      55555555 -6234567        97      98      99      0       0       0       0      0
X        0       0       0       0       0       0       0       0       0      0
X        0       0       0       0       0       0       0       0
X
#
SHAR_EOF
  (set 20 02 12 05 15 30 26 'scbug/scbug.rpt'; eval "$shar_touch") &&
  chmod 0644 'scbug/scbug.rpt' ||
  $echo 'restore of' 'scbug/scbug.rpt' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'scbug/scbug.rpt:' 'MD5 check failed'
5cbb8ce9a2f7a248f131a2617e829618  scbug/scbug.rpt
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'scbug/scbug.rpt'`"
    test 2171 -eq "$shar_count" ||
    $echo 'scbug/scbug.rpt:' 'original size' '2171,' 'current size' "$shar_count!"
  fi
fi
# ============= scbug/make.out ==============
if test -f 'scbug/make.out' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'scbug/make.out' '(file already exists)'
else
  $echo 'x -' extracting 'scbug/make.out' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'scbug/make.out' &&
gcc -c scbug.c -Wall
insmod scbug.o
X./tsc
kernel.scbug.scratch = 91 92 93 94 95 96 97 98 99
kernel.scbug.scratch = 91	92	93	94	95	96	97	98	99	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
kernel.scbug.scratch = 11111111 -22222222 33333333 -44444444 55555555 -62345678
kernel.scbug.scratch = 11111111	-22222222	33333333	-44444444	55555555	-6234567	97	98	99	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
SHAR_EOF
  (set 20 02 12 04 15 44 25 'scbug/make.out'; eval "$shar_touch") &&
  chmod 0664 'scbug/make.out' ||
  $echo 'restore of' 'scbug/make.out' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'scbug/make.out:' 'MD5 check failed'
2bcd64fa1bc631ec3f1bd07bad71cc16  scbug/make.out
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'scbug/make.out'`"
    test 402 -eq "$shar_count" ||
    $echo 'scbug/make.out:' 'original size' '402,' 'current size' "$shar_count!"
  fi
fi
rm -fr _sh01217
exit 0

