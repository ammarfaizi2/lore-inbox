Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269137AbUJQPVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269137AbUJQPVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUJQPVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:21:36 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:50573 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S269172AbUJQPUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:20:32 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A6472BA@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'gcc-bugs@gcc.gnu.org'" <gcc-bugs@gcc.gnu.org>
Cc: "'Bill Davidsen'" <davidsen@tmr.com>, "'Kai Ruottu'" <karuottu@mbnet.fi>,
       "'Dan Kegel'" <dank@kegel.com>,
       "'bertrand marquis'" <bertrand.marquis@sysgo.com>,
       "'Kumar Gala'" <kumar.gala@freescale.com>,
       "'Robb, Sam'" <sam.robb@timesys.com>,
       "'Martin Schaffner'" <schaffner@gmx.li>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
       crossgcc <crossgcc@sources.redhat.com>
Subject: getting memory errors when natively bulding native gnu gcc 3.3.2 
	compiler on PQ2FADS-VR with 32 MB DRAM memory
Date: Sun, 17 Oct 2004 11:19:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to natively build native gnu gcc 3.3.2 compiler from the source
tar ball on PQ2FADS-VR (MPC 8275) 
with 32 MB DRAM memory, running "vanilla" Linux 2.6.8-rc4 kernel (built by
me) with NFS mounted root file system ("/fadsroot") and getting memory
errors (see listing below).

For such (as above) native building I use another "native" gnu gcc 3.3.2
compiler,
which, in turn, was generated via cross-compiling on cygwin
(BIG Thanks to Kai Ruottu for his GREAT help on that!)
and placed on NFS mounted root file system.

Note that on cygwin I already had good working/tested gcc crosscompile for
PQ2FADS-VR (MPC 8275) - I used it
to build U-boot, "vanilla" Linux 2.6.8-rc4 kernel 
(built by me with BIG Help from cross-compiling community and Kumar Gala),
lmbench, ctcs (Cerberus Test Control System).

Prior to attempting to natively build native gnu gcc 3.3.2 compiler
from the source tar ball on PQ2FADS-VR (MPC 8275)
- gnu coreutils, gawk and sed were also cross-compiled on cygwin
and placed on NFS mounted root file system).

root@192:/gcc/gcc-3.3.2# uname -a
Linux 192.168.0.5 2.6.8-rc4 #6 Wed Sep 29 13:33:22 EDT 2004 ppc unknown
unknown
GNU/Linux 

The native crooscompile (built by cross-compiling on cygwin) 
 # gcc -v
Using built-in specs.
Configured with: ./configure --host=powerpc-linux --target=powerpc-linux
--build
=i686-linux --disable-shared : (reconfigured) ./configure
--host=powerpc-linux -
-target=powerpc-linux --build=i686-linux --disable-shared
--prefix=/home/gaiotto
/local : (reconfigured) ./configure --target=powerpc-linux
--host=powerpc-linux
--build=i686-linux --enable-shared --enable-threads --enable-languages=c :
(reco
nfigured) ./configure --target=powerpc-linux --host=powerpc-linux
--build=i686-l
inux --enable-shared --enable-threads --enable-languages=c
--prefix=/home/gaiott
o/local
Thread model: posix
gcc version 3.3.2

I have tried two variants of doing it ( build native gnu gcc 3.3.2 compiler
from the source tar ball):

a) 
make CFLAGS='-O' LIBCFLAGS='-g -O2'LIBCXXFLAGS='-g -O2
-fno-implicit-templates' bootstrap

b) using script (see below listed), which was modified (by me) from the
script,
 originally provided to me (for cross-compiling on cygwin) by Kai Ruottu
(see above).

In either case, I am getting errors (oom-killer: gfp_mask=0x1d2 ... - see
below)  
................
./genpeep ./config/rs6000/rs6000.md > tmp-peep.c
/bin/sh ./move-if-change tmp-peep.c insn-peep.c
echo timestamp > s-peep
/usr/local/bin/powerpc-linux-gcc-3.3.2   -Os -DIN_GCC   -W -Wall
-Wwrite-strings
 -Wstrict-prototypes -Wmissing-prototypes -Wtraditional -pedantic
-Wno-long-long
   -DHAVE_CONFIG_H    -I. -I. -I. -I./. -I./config -I./../include -c
insn-peep.c
 \
  -o insn-peep.o
/usr/local/bin/powerpc-linux-gcc-3.3.2 -c   -Os -DIN_GCC   -W -Wall
-Wwrite-stri
ngs -Wstrict-prototypes -Wmissing-prototypes -Wtraditional -pedantic
-Wno-long-l
ong   -DHAVE_CONFIG_H -DGENERATOR_FILE    -I. -I. -I. -I./. -I./config
-I./../in
clude ./genrecog.c -o genrecog.o
/usr/local/bin/powerpc-linux-gcc-3.3.2   -Os -DIN_GCC   -W -Wall
-Wwrite-strings
 -Wstrict-prototypes -Wmissing-prototypes -Wtraditional -pedantic
-Wno-long-long
   -DHAVE_CONFIG_H -DGENERATOR_FILE  -o genrecog \
 genrecog.o rtl.o read-rtl.o bitmap.o ggc-none.o gensupport.o
insn-conditions.o
print-rtl1.o \
    errors.o ../libiberty/libiberty.a
./genrecog ./config/rs6000/rs6000.md > tmp-recog.c
./config/rs6000/altivec.md:1618: warning: operand 3 missing mode?
./config/rs6000/altivec.md:1628: warning: operand 3 missing mode?
./config/rs6000/altivec.md:1638: warning: operand 3 missing mode?
./config/rs6000/altivec.md:1648: warning: operand 3 missing mode?
/bin/sh ./move-if-change tmp-recog.c insn-recog.c
echo timestamp > s-recog
/usr/local/bin/powerpc-linux-gcc-3.3.2   -Os -DIN_GCC   -W -Wall
-Wwrite-strings
 -Wstrict-prototypes -Wmissing-prototypes -Wtraditional -pedantic
-Wno-long-long
   -DHAVE_CONFIG_H    -I. -I. -I. -I./. -I./config -I./../include -c
insn-recog.
c \
  -o insn-recog.o

oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 4, high 12, batch 2
cpu 0 cold: low 0, high 4, batch 2
Normal per-cpu: empty
HighMem per-cpu: empty

Free pages:         360kB (0kB HighMem)
Active:6908 inactive:0 dirty:0 writeback:0 unstable:0 free:90 slab:525
mapped:69
08 pagetables:39
DMA free:360kB min:180kB low:360kB high:540kB active:27632kB inactive:0kB
presen
t:32768kB
protections[]: 90 90 90
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB
present:
0kB
protections[]: 0 0 0
DMA: 8*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB
0*2048kB
0*4096kB = 392kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 9807 (cc1).
powerpc-linux-gcc-3.3.2: Internal error: Terminated (program cc1)
Please submit a full bug report.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
make[1]: *** [insn-recog.o] Error 1
make[1]: Leaving directory `/gcc/gcc-3.3.2/gcc'
make: *** [all-gcc] Error 2
root@192:/gcc/gcc-3.3.2#

Here is more info re my board, 

 ps
  PID TTY          TIME CMD
    1 ?        00:00:02 bash
    2 ?        00:00:00 ksoftirqd/0
    3 ?        00:00:00 events/0
    4 ?        00:00:00 khelper
    5 ?        00:00:00 kblockd/0
    6 ?        00:00:00 pdflush
    7 ?        00:00:00 pdflush
    8 ?        00:05:10 kswapd0
    9 ?        00:00:00 aio/0
   10 ?        00:00:38 rpciod
   11 ?        00:00:00 bash
 9810 ?        00:00:00 ps

# mount
rootfs on / type rootfs (rw)
/dev/root on / type nfs
(rw,v2,rsize=4096,wsize=4096,hard,udp,nolock,addr=192.168.0.4)
none on /proc type proc (rw,nodiratime)

Here is the script mentioned in b) (way above).

#!/bin/sh
AR=/usr/local/bin/powerpc-linux-ar \
CC=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
CFLAGS=-Os \
CXXFLAGS=-Os \
NM=/usr/local/bin/powerpc-linux-nm \
RANLIB=/usr/local/bin/powerpc-linux-ranlib \
AR_FOR_BUILD=/usr/local/bin/powerpc-linux-ar \
CC_FOR_BUILD=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
GCC_FOR_BUILD=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
NM_FOR_BUILD=/usr/local/bin/powerpc-linux-nm \
RANLIB_FOR_BUILD=/usr/local/bin/powerpc-linux-ranlib \
AR_FOR_TARGET=/usr/local/bin/powerpc-linux-ar \
CC_FOR_TARGET=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
GCC_FOR_TARGET=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
CXX_FOR_TARGET=/usr/local/bin/powerpc-linux-g++.exe \
OLDCC=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
NM_FOR_TARGET=/usr/local/bin/powerpc-linux-nm \
RANLIB_FOR_TARGET=/usr/local/bin/powerpc-linux-ranlib \
./configure --build=ppc-linux-gnu --host=ppc-linux-gnu
--target=ppc-linux-gnu --
prefix=/usr --with-threads --enable-shared
#
make all-build-libiberty
make all-gcc LANGUAGES="c c++ objc gcov proto"


