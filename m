Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289866AbSBEXZd>; Tue, 5 Feb 2002 18:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289871AbSBEXZY>; Tue, 5 Feb 2002 18:25:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48901 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289866AbSBEXZO>; Tue, 5 Feb 2002 18:25:14 -0500
Date: Tue, 5 Feb 2002 23:25:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Fix export of simple_strtol
Message-ID: <20020205232506.H27706@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It appears that we have a certain amount of randomness about which symbols
are exported where.  (Maybe someone should feed this into /dev/random ?) 8)

Both simple_strtoul and simple_strtol appear in linux/lib/vsprintf.c yet
we have simple_strtoul exported by kernel/ksyms.c, and simple_strtol
exported by some architecture specific ksyms.c files.

The following patch rectifies this by exporting simple_strtol in
kernel/ksyms.c and removing it from the machine specific files.

[Georg Nikodym pointed this out and sent an initial patch to add
 it to the main kernel ksyms file, I fixed up the architecture
 specific files].

--- ref/arch/cris/kernel/ksyms.c	Mon Nov  5 21:42:03 2001
+++ linux/arch/cris/kernel/ksyms.c	Tue Feb  5 23:14:46 2002
@@ -36,7 +36,6 @@
 
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(simple_strtol);
 EXPORT_SYMBOL(strstr);
 
 EXPORT_SYMBOL(strchr);
--- ref/arch/i386/kernel/i386_ksyms.c	Fri Nov 16 10:30:00 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Tue Feb  5 23:15:36 2002
@@ -93,7 +93,6 @@
 
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(simple_strtol);
 EXPORT_SYMBOL(strstr);
 
 EXPORT_SYMBOL(strncpy_from_user);
--- ref/arch/mips/kernel/mips_ksyms.c	Mon Sep  3 22:16:37 2001
+++ linux/arch/mips/kernel/mips_ksyms.c	Tue Feb  5 23:15:48 2002
@@ -51,7 +51,6 @@
 EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL(simple_strtol);
 EXPORT_SYMBOL_NOVERS(strcat);
 EXPORT_SYMBOL_NOVERS(strchr);
 EXPORT_SYMBOL_NOVERS(strlen);
--- ref/arch/mips64/kernel/mips64_ksyms.c	Mon Aug 27 15:05:27 2001
+++ linux/arch/mips64/kernel/mips64_ksyms.c	Tue Feb  5 23:16:02 2002
@@ -48,7 +48,6 @@
 EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL(simple_strtol);
 EXPORT_SYMBOL_NOVERS(strcat);
 EXPORT_SYMBOL_NOVERS(strchr);
 EXPORT_SYMBOL_NOVERS(strlen);
--- ref/arch/sh/kernel/sh_ksyms.c	Fri Sep 28 20:33:47 2001
+++ linux/arch/sh/kernel/sh_ksyms.c	Tue Feb  5 23:16:13 2002
@@ -39,8 +39,6 @@
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy);
 
-EXPORT_SYMBOL(simple_strtol);
-
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
--- ref/kernel/ksyms.c	Tue Jan 15 16:03:04 2002
+++ linux/kernel/ksyms.c	Tue Feb  5 23:14:33 2002
@@ -470,6 +470,7 @@
 EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoul);
+EXPORT_SYMBOL(simple_strtol);
 EXPORT_SYMBOL(system_utsname);	/* UTS data */
 EXPORT_SYMBOL(uts_sem);		/* UTS semaphore */
 #ifndef __mips__


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

