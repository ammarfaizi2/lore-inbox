Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262151AbSJFTi2>; Sun, 6 Oct 2002 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262156AbSJFTi2>; Sun, 6 Oct 2002 15:38:28 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:45280 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262151AbSJFTi0>; Sun, 6 Oct 2002 15:38:26 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it a bug ?
Date: Sun, 6 Oct 2002 21:43:29 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Rebert Luc <lucrebert@altern.org>
MIME-Version: 1.0
Message-Id: <200210062141.12037.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H4SK2MKBFUPCE6A8WDQ0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H4SK2MKBFUPCE6A8WDQ0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Rebert,

> I have try many times to compile a kernel 2.4.18 and 2.4.19 for my k6-2=
 (it
> is a desktop computer i don't need pcmia as a module or compiled in the
> kernel so i haven't stick it) but every time there si a bug when i make
> "make modules_install" I can see this bug !!!  Can you help me please ?=
 I
> think it's a bug, what do you think about this ?

> depmod: *** Unresolved symbols in /lib/modules/2.4.18/kernel/fs/binfmt_=
elf.o
> depmod:         empty_zero_page
> depmod:         get_user_pages
> make: *** [_modinst_post] Error 1

for 2.4.18 this is true, but I think it cannot be true for 2.4.19. The mi=
ssing=20
things were added in 2.4.19-pre1. Patch attached for 2.4.18.

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


--------------Boundary-00=_H4SK2MKBFUPCE6A8WDQ0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fixit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fixit.patch"

diff -Naur -X /home/marcelo/lib/dontdiff tmp/linux/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- tmp/linux/arch/i386/kernel/i386_ksyms.c	Mon Feb 25 20:28:49 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Mon Feb 25 20:04:47 2002
@@ -73,6 +73,7 @@
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(gdt);
+EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
diff -Naur -X /home/marcelo/lib/dontdiff tmp/linux/mm/memory.c linux/mm/memory.c
--- tmp/linux/mm/memory.c	Mon Feb 25 20:28:51 2002
+++ linux/mm/memory.c	Mon Feb 25 20:04:48 2002
@@ -44,6 +44,7 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/module.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -523,6 +523,8 @@
 	i = -EFAULT;
 	goto out;
 }
+
+EXPORT_SYMBOL(get_user_pages);
 
 /*
  * Force in an entire range of pages from the current process's user VA,

--------------Boundary-00=_H4SK2MKBFUPCE6A8WDQ0--

