Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292386AbSBBUwJ>; Sat, 2 Feb 2002 15:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292384AbSBBUvx>; Sat, 2 Feb 2002 15:51:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:22999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S292385AbSBBUvq>; Sat, 2 Feb 2002 15:51:46 -0500
Date: Sat, 2 Feb 2002 21:49:17 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem building the kernel with CONFIG_AIC7XXX_BUILD_FIRMWARE
Message-ID: <Pine.NEB.4.44.0202022137300.9676-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

building kernel 2.5.3-dj1 fails with CONFIG_AIC7XXX_BUILD_FIRMWARE enabled
with the following error (but it seems that this problem also exists in
the 2.4 kernels):

<--  snip  -->

...
make[5]: Entering directory
`/home/bunk/linux/kernel-2.5/linux/drivers/scsi/aic7xxx/aicasm'
yacc -d aicasm_gram.y
mv y.tab.c aicasm_gram.c
lex  -t aicasm_scan.l > aicasm_scan.c
gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c
 -o aicasm
aicasm_gram.y:1485: warning: type mismatch with previous implicit declaration
/usr/share/bison/bison.simple:946: warning: previous implicit declaration
of `yyerror'
aicasm_gram.y:1485: warning: `yyerror' was previously implicitly declared
to return `int'
In file included from aicasm_symbol.c:47:
aicdb.h:1: db3/db_185.h: No such file or directory
make[5]: *** [aicasm] Error 1

<--  snip  -->

The problem is that the -dj1 patch ships with a
drivers/scsi/aic7xxx/aicasm/aicdb.h file although this is a generated
file.

The real problem is that there's a "clean" target in the Makefile in this
directory that removed this file - unfortunately this "clean" target never
gets executed because in the Linux kernel the "clean" target in one
directory doesn't execute call the "clean" target in the Makefiles in the
subdirectories.

cu
Adrian




