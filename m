Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316721AbSFJHcs>; Mon, 10 Jun 2002 03:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSFJHcr>; Mon, 10 Jun 2002 03:32:47 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:39688 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316721AbSFJHcq>; Mon, 10 Jun 2002 03:32:46 -0400
Date: Mon, 10 Jun 2002 09:23:31 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de
Subject: 2.5.21: fixdep starts spitting out 'unaligned traps'
Message-ID: <20020610072331.GA12676@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alpha:/usr/src/linux-2.5.21# make boot
make[1]: Entering directory `/usr/src/linux-2.5.21/scripts'
  gcc -Wp,-MD,.fixdep.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o fixdep fixdep.c
fixdep(12602): unaligned trap at 00000001200018d8: 0000000120001b6a 28 2
  gcc -Wp,-MD,.split-include.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o split-include split-include.c
fixdep(12612): unaligned trap at 00000001200018d8: 0000000120001b6a 28 2
make[1]: Leaving directory `/usr/src/linux-2.5.21/scripts'
Splitting include/linux/autoconf.h -> include/config
make[1]: Entering directory `/usr/src/linux-2.5.21/init'
  gcc -Wp,-MD,.main.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointe
r -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASEN
AME=main   -c -o main.o main.c
fixdep(12630): unaligned trap at 00000001200018d8: 0000000120001b6a 28 2
Generating ../include/linux/compile.h (updated)
  gcc -Wp,-MD,.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-poi
nter -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BA
SENAME=version   -c -o version.o version.c
fixdep(12661): unaligned trap at 00000001200018d8: 0000000120001b6a 28 2
  gcc -Wp,-MD,.do_mounts.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-p
ointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_
BASENAME=do_mounts   -c -o do_mounts.o do_mounts.c

and so on - fixdep has changed, and on my alpha, it now has 'unaligned
traps'.

Of course, 2.5.21 won't compile at all, but still, this is a regression.

This seems to be caused by line 364 of fixdep.c:

alpha:/usr/src/linux-2.5.21# /home/jurriaan/unalign scripts/fixdep scripts/lxdialog/checklist.o /usr/src/linux-2.5.21 gcc -Wp,-MD,scr
ipts/lsdialog/.checklist.o.d -g -c -o scripts/lxdialog/checklist.o scripts/lxdialog/checklist.c
Extra arguments passed to gdb in file /tmp/file4Hb5gq.
Be sure to delete it when you're done.

GNU gdb 2002-04-01-cvs
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "alpha-linux".
fixdep(15767): unaligned trap at 0000000120001d48: 000000012000210a 28 3

Program received signal SIGBUS, Bus error.
0x120001d48 in traps () at scripts/fixdep.c:364
364             if (*(int *)test != INT_CONF) {
(gdb) bt
#0  0x120001d48 in traps () at scripts/fixdep.c:364
#1  0x120001de8 in main (argc=10, argv=0x11ffffc58) at scripts/fixdep.c:375
(gdb)

I'm not expert enough in C to suggest a solution for this, but I'm
willing to test.

Good luck,
Jurriaan
-- 
Everybody need to deviate from the norm
   Rush - Vital Signs
Debian GNU/Linux 2.4.19p8 on Alpha 990 bogomips 5 users load:0.04 0.06 0.07
