Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVDGMTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVDGMTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVDGMTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:19:09 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:36490 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262437AbVDGMS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:18:56 -0400
Message-ID: <4255252D.4050708@ribosome.natur.cuni.cz>
Date: Thu, 07 Apr 2005 14:18:53 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050407
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: find: /usr/src/linux-2.4.30/include/asm: Too many levels of symbolic
 links
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  again I've hit some wird problem doing "make dep" for 2.4 kernel:

I've extracted the linxu-2.4.30.tar.gz file, copied .config from
previous src-tree, ran `make oldconfig', did `make menuconfig',
and finally `make dep':

[cut]
make[2]: Leaving directory `/usr/src/linux-2.4.30/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.30'
make update-modverfile
make[1]: Entering directory `/usr/src/linux-2.4.30'
/usr/src/linux-2.4.30/include/linux/modversions.h was not updated
make[1]: Leaving directory `/usr/src/linux-2.4.30'
scripts/mkdep -- `find /usr/src/linux-2.4.30/include/asm /usr/src/linux-2.4.30/include/linux /usr/src/linux-2.4.30/include/scsi /usr/src/linux-2.4.30/include/net /usr/src/linux-2.4.30/include/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
find: /usr/src/linux-2.4.30/include/asm: Too many levels of symbolic links
scripts/mkdep -- init/*.c > .depend
# 


Executing `find /usr/src/linux-2.4.30/include/asm /usr/src/linux-2.4.30/include/linux /usr/src/linux-2.4.30/include/scsi /usr/src/linux-2.4.30/include/net /usr/src/linux-2.4.30/include/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` works just fine.


aquarius linux-2.4.30 # scripts/mkdep -- `find /usr/src/linux-2.4.30/include/asm /usr/src/linux-2.4.30/include/linux /usr/src/linux-2.4.30/include/scsi /usr/src/linux-2.4.30/include/net /usr/src/linux-2.4.30/include/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print`
find: /usr/src/linux-2.4.30/include/asm: Too many levels of symbolic links
mkdep: HPATH not set in environment.  Don't bypass the top level Makefile.
aquarius linux-2.4.30 # 

aquarius linux-2.4.30 # ls -la /usr/src/linux-2.4.30/include/asm
lrwxrwxrwx  1 root root 8 Apr  7 14:07 /usr/src/linux-2.4.30/include/asm -> asm-i386
aquarius linux-2.4.30 # ls -la /usr/src/linux-2.4.30/include/asm-i
asm-i386/ asm-ia64/ 
aquarius linux-2.4.30 # ls -la /usr/src/linux-2.4.30/include/asm-i386/
total 692
drwxr-xr-x   2 573 573  1741 Apr  4 03:42 .
drwxr-xr-x  28 573 573   397 Apr  7 14:07 ..
-rw-r--r--   1 573 573   764 Jun 16  1995 a.out.h
-rw-rw-r--   1 573 573  4974 Apr  4 03:42 acpi.h
-rw-r--r--   1 573 573  2528 Nov 17 12:54 apic.h
-rw-r--r--   1 573 573  9610 Aug 25  2003 apicdef.h
-rw-r--r--   1 573 573  5066 Nov 22  2001 atomic.h
-rw-r--r--   1 573 573  9568 Aug  8  2004 bitops.h
-rw-r--r--   1 573 573   409 Apr 16  1997 boot.h
[cut]
There are no symlinks under /usr/src/linux-2.4.30/include/asm-i386/

Any clues? :( Please Cc: me in replies.
-- 
Martin Mokrejs
Email: 'bW9rcmVqc21Acmlib3NvbWUubmF0dXIuY3VuaS5jeg==\n'.decode('base64')
GPG key is at http://www.natur.cuni.cz/~mmokrejs
