Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTAKGgm>; Sat, 11 Jan 2003 01:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbTAKGgm>; Sat, 11 Jan 2003 01:36:42 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:32460 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267131AbTAKGgl>;
	Sat, 11 Jan 2003 01:36:41 -0500
Date: Fri, 10 Jan 2003 22:45:26 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200301110645.h0B6jQRu026921@napali.hpl.hp.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: make AT_SYSINFO platform-independent
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about moving the AT_SYSINFO macro from asm-i386/elf.h to
linux/elf.h?  Several architectures can benefit from it (certainly
pa-risc and ia64) and since glibc also defines it in a
non-platformspecific fashion, there really is no point not doing the
same in the kernel.  I suppose it would be nice if we could renumber
it from 32 to 18, but that would require updating glibc, which is
probably too painful.

	--david

===== include/asm-i386/elf.h 1.5 vs edited =====
--- 1.5/include/asm-i386/elf.h	Thu Jan  2 07:22:48 2003
+++ edited/include/asm-i386/elf.h	Fri Jan 10 22:40:15 2003
@@ -96,12 +96,6 @@
 
 #define ELF_PLATFORM  (system_utsname.machine)
 
-/*
- * Architecture-neutral AT_ values in 0-17, leave some room
- * for more of them, start the x86-specific ones at 32.
- */
-#define AT_SYSINFO	32
-
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
 
===== include/linux/elf.h 1.16 vs edited =====
--- 1.16/include/linux/elf.h	Thu Dec 26 14:07:53 2002
+++ edited/include/linux/elf.h	Fri Jan 10 22:40:45 2003
@@ -182,6 +182,7 @@
 #define AT_PLATFORM 15  /* string identifying CPU for optimizations */
 #define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
 #define AT_CLKTCK 17	/* frequency at which times() increments */
+#define AT_SYSINFO	32	/* pointer to kernel's sysinfo */
 
 typedef struct dynamic{
   Elf32_Sword d_tag;
