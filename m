Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVCWJ37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVCWJ37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVCWJ37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:29:59 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:58554 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262894AbVCWJ3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:29:51 -0500
Message-ID: <4241370D.5030902@ribosome.natur.cuni.cz>
Date: Wed, 23 Mar 2005 10:29:49 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050304
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: linux-2.4.30-rc1/include/asm: Too many levels of symbolic links
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I recompiled current kernel to test something, and have realized everything
went well including "make modules_install", but no System.map was generated.
So I dug around and the "make dep" did not work well:

make[2]: Leaving directory `/usr/src/linux-2.4.30-rc1/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.30-rc1'
make update-modverfile
make[1]: Entering directory `/usr/src/linux-2.4.30-rc1'
/usr/src/linux-2.4.30-rc1/include/linux/modversions.h was updated
make[1]: Leaving directory `/usr/src/linux-2.4.30-rc1'
scripts/mkdep -- `find /usr/src/linux-2.4.30-rc1/include/asm /usr/src/linux-2.4.30-rc1/include/linux /usr/src/linux-2.4.30-rc1/include/scsi /usr/src/linux-2.4.30-rc1/include/net /usr/src/linux-2.4.30-rc1/include/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
find: /usr/src/linux-2.4.30-rc1/include/asm: Too many levels of symbolic links
scripts/mkdep -- init/*.c > .depend
aquarius linux-2.4.30-rc1 # ls -la /usr/src/linux-2.4.30-rc1/include/asm
lrwxrwxrwx  1 root root 8 Mar 23 10:21 /usr/src/linux-2.4.30-rc1/include/asm -> asm-i386
aquarius linux-2.4.30-rc1 # ls -la /usr/src/linux-2.4.30-rc1/include/asm-i386/
total 692
drwxr-xr-x   2  573  573  1741 Mar 23 10:20 .
drwxr-xr-x  28  573  573   397 Mar 23 10:21 ..
-rw-r--r--   1  573  573   764 Jun 16  1995 a.out.h
-rw-rw-r--   1 root root  4974 Mar 23 10:20 acpi.h
-rw-r--r--   1  573  573  2528 Nov 17 12:54 apic.h
-rw-r--r--   1  573  573  9610 Aug 25  2003 apicdef.h
-rw-r--r--   1  573  573  5066 Nov 22  2001 atomic.h
-rw-r--r--   1  573  573  9568 Aug  8  2004 bitops.h
-rw-r--r--   1  573  573   409 Apr 16  1997 boot.h
-rw-r--r--   1  573  573  5739 Aug  3  2002 bugs.h
-rw-r--r--   1  573  573  1479 Jun 13  2003 byteorder.h
[cut]

aquarius linux-2.4.30-rc1 # find --version
GNU find version 4.2.18
Features enabled: D_TYPE O_NOFOLLOW(enabled) 
aquarius linux-2.4.30-rc1 # uname -a
Linux aquarius 2.6.11.5 #2 SMP Wed Mar 23 09:56:22 CET 2005 i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux
aquarius linux-2.4.30-rc1 # 

Executing the same command from bash session gives:

aquarius linux-2.4.30-rc1 # find /usr/src/linux-2.4.30-rc1/include/asm /usr/src/linux-2.4.30-rc1/include/linux /usr/src/linux-2.4.30-rc1/include/scsi /usr/src/linux-2.4.30-rc1/include/net /usr/src/linux-2.4.30-rc1/include/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print 
find: /usr/src/linux-2.4.30-rc1/include/asm: Too many levels of symbolic links
/usr/src/linux-2.4.30-rc1/include/linux/usb_gadget.h
/usr/src/linux-2.4.30-rc1/include/linux/usb_ch9.h
/usr/src/linux-2.4.30-rc1/include/linux/tty_ldisc.h
/usr/src/linux-2.4.30-rc1/include/linux/tty.h
/usr/src/linux-2.4.30-rc1/include/linux/sysctl.h
/usr/src/linux-2.4.30-rc1/include/linux/swap.h
/usr/src/linux-2.4.30-rc1/include/linux/stallion.h
/usr/src/linux-2.4.30-rc1/include/linux/spinlock.h
[cut]
aquarius linux-2.4.30-rc1 # ls -la /usr/src/linux-2.4.30-rc1/include
total 88
drwxr-xr-x  28  573  573   397 Mar 23 10:21 .
drwxr-xr-x  15  573  573   337 Mar 23 10:26 ..
drwxrwxr-x   3  573  573   530 Nov 17 12:54 acpi
lrwxrwxrwx   1 root root     8 Mar 23 10:21 asm -> asm-i386
drwxr-xr-x   2  573  573  1673 Feb 18  2004 asm-alpha
drwxr-xr-x  24  573  573  1871 Nov 28  2003 asm-arm
drwxr-xr-x   2  573  573  1304 Feb 18  2004 asm-cris
drwxr-xr-x   2  573  573   112 Jun 13  2003 asm-generic
drwxr-xr-x   2  573  573  1741 Mar 23 10:20 asm-i386
drwxr-xr-x   3  573  573  1646 Aug  8  2004 asm-ia64
drwxr-xr-x   2  573  573  4096 Aug  8  2004 asm-m68k
drwxr-xr-x  20  573  573  8192 Jan 19 15:10 asm-mips
drwxr-xr-x  13  573  573  4096 Jan 19 15:10 asm-mips64
drwxr-xr-x   2  573  573  1567 Nov 28  2003 asm-parisc
drwxr-xr-x   2  573  573  4096 Mar 23 10:20 asm-ppc
drwxrwxr-x   3  573  573  1744 Aug  8  2004 asm-ppc64
drwxr-xr-x   2  573  573  1418 Nov 17 12:54 asm-s390
drwxr-xr-x   2  573  573  1382 Nov 17 12:54 asm-s390x
drwxr-xr-x   2  573  573  4096 Feb 18  2004 asm-sh
drwxrwxr-x   2  573  573  1216 Aug  8  2004 asm-sh64
drwxr-xr-x   2  573  573  4096 Mar 23 10:20 asm-sparc
drwxr-xr-x   2  573  573  4096 Mar 23 10:20 asm-sparc64
drwxrwxr-x   2  573  573  1773 Mar 23 10:20 asm-x86_64
drwxr-xr-x  14  573  573 16384 Mar 23 10:26 linux
drwxr-xr-x   2  573  573   152 Nov 29  2002 math-emu
drwxr-xr-x   5  573  573   955 Mar 23 10:20 net
drwxr-xr-x   2  573  573   211 Nov 17 12:54 pcmcia
drwxr-xr-x   2  573  573    83 Nov 17 12:54 scsi
drwxr-xr-x   2  573  573   432 Feb 18  2004 video
aquarius linux-2.4.30-rc1 # 

This is a gentoo box. I cannot comment on the find(1) binary features (see above).
Any clues?

-- 
Martin Mokrejs
Email: 'bW9rcmVqc21Acmlib3NvbWUubmF0dXIuY3VuaS5jeg==\n'.decode('base64')
GPG key is at http://www.natur.cuni.cz/~mmokrejs
