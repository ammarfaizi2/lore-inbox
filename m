Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTBNUFc>; Fri, 14 Feb 2003 15:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbTBNUFb>; Fri, 14 Feb 2003 15:05:31 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31801 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S267308AbTBNUFa>; Fri, 14 Feb 2003 15:05:30 -0500
Date: Fri, 14 Feb 2003 20:16:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Trivial <trivial@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill __beep
Message-ID: <Pine.LNX.4.44.0302142014200.8901-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__beep() is used nowhere, and should not be defined in pgtable.h.

 asm-i386/bug.h     |    3 +--
 asm-i386/pgtable.h |    2 --
 asm-parisc/bug.h   |    5 +----
 asm-sh/pgtable.h   |    2 --
 4 files changed, 2 insertions(+), 10 deletions(-)

Hugh

--- 2.5.60/include/asm-i386/bug.h	Tue Jan 14 12:17:45 2003
+++ linux/include/asm-i386/bug.h	Fri Feb 14 19:54:02 2003
@@ -4,8 +4,7 @@
 #include <linux/config.h>
 
 /*
- * Tell the user there is some problem. Beep too, so we can
- * see^H^H^Hhear bugs in early bootup as well!
+ * Tell the user there is some problem.
  * The offending file and line are encoded after the "officially
  * undefined" opcode for parsing in the trap handler.
  */
--- 2.5.60/include/asm-i386/pgtable.h	Mon Feb 10 20:12:52 2003
+++ linux/include/asm-i386/pgtable.h	Fri Feb 14 19:54:02 2003
@@ -49,8 +49,6 @@
 
 #endif
 
-#define __beep() asm("movb $0x3,%al; outb %al,$0x61")
-
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
--- 2.5.60/include/asm-parisc/bug.h	Tue Jan 14 12:17:45 2003
+++ linux/include/asm-parisc/bug.h	Fri Feb 14 19:54:02 2003
@@ -2,10 +2,7 @@
 #define _PARISC_BUG_H
 
 /*
- * Tell the user there is some problem. Beep too, so we can
- * see^H^H^Hhear bugs in early bootup as well!
- *
- * We don't beep yet.  prumpf
+ * Tell the user there is some problem.
  */
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
--- 2.5.60/include/asm-sh/pgtable.h	Mon Sep 16 05:51:51 2002
+++ linux/include/asm-sh/pgtable.h	Fri Feb 14 19:54:02 2003
@@ -98,8 +98,6 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define __beep() asm("")
-
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)

