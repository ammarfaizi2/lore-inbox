Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268403AbTBNNCT>; Fri, 14 Feb 2003 08:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268418AbTBNMxQ>; Fri, 14 Feb 2003 07:53:16 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:23054 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268378AbTBNMwq>;
	Fri, 14 Feb 2003 07:52:46 -0500
Date: Fri, 14 Feb 2003 15:58:00 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: make startup_32 kernel entry point (3/13)
Message-ID: <20030214125800.GC8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This patch marks startup_32 (in head.S) as kernel entry point, 
visws kernel loader uses raw elf kernel images and entry point 
at stext causes jump to wrong address.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-stext

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/Makefile linux-2.5.60/arch/i386/Makefile
--- linux-2.5.60.vanilla/arch/i386/Makefile	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/Makefile	Thu Feb 13 20:42:02 2003
@@ -17,7 +17,7 @@
 
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-LDFLAGS_vmlinux := -e stext
+LDFLAGS_vmlinux :=
 LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 CFLAGS += -pipe
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/head.S linux-2.5.60/arch/i386/kernel/head.S
--- linux-2.5.60.vanilla/arch/i386/kernel/head.S	Tue Jan 14 12:32:27 2003
+++ linux-2.5.60/arch/i386/kernel/head.S	Fri Feb 14 15:02:32 2003
@@ -42,7 +42,7 @@
  *
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
  */
-startup_32:
+ENTRY(startup_32)
 /*
  * Set segments to known values
  */
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/vmlinux.lds.S linux-2.5.60/arch/i386/vmlinux.lds.S
--- linux-2.5.60.vanilla/arch/i386/vmlinux.lds.S	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/vmlinux.lds.S	Thu Feb 13 20:42:02 2003
@@ -6,7 +6,7 @@
 	
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(_start)
+ENTRY(startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {

--mSxgbZZZvrAyzONB--
