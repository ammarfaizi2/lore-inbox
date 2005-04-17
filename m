Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVDQVR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVDQVR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 17:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVDQVR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 17:17:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:17545 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261457AbVDQVRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 17:17:51 -0400
Date: Sun, 17 Apr 2005 23:20:46 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] rename TEST_VERIFY_AREA to TEST_ACCESS_OK 
Message-ID: <Pine.LNX.4.62.0504172314490.2586@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since verify_area is deprecated and going away completely very soon now 
TEST_VERIFY_AREA is a bad name to use and should be renamed. The patch 
below renames it to TEST_ACCESS_OK which I believe is more appropriate.

Btw: I didn't find anything that actually ever defines TEST_VERIFY_AREA. 
Is this intended as a debug thing to be set by hand if needed or is it 
just some old debug stuff that no longer serves a real purpose?  I guess 
my real question is "should these actually just be removed along with the 
code they wrap instead of just being renamed?"


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/frv/mm/fault.c        |    2 +-
 arch/i386/mm/fault.c       |    2 +-
 arch/m68k/mm/sun3mmu.c     |    2 +-
 include/asm-frv/pgtable.h  |    2 +-
 include/asm-i386/pgtable.h |    2 +-
 include/asm-um/pgtable.h   |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/arch/frv/mm/fault.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/frv/mm/fault.c	2005-04-17 23:11:16.000000000 +0200
@@ -134,7 +134,7 @@
 	default:
 		/* handle write to write protected page */
 	case ESR0_ATXC_WP_EXCEP:
-#ifdef TEST_VERIFY_AREA
+#ifdef TEST_ACCESS_OK
 		if (!(user_mode(__frame)))
 			printk("WP fault at %08lx\n", __frame->pc);
 #endif
--- linux-2.6.12-rc2-mm3-orig/arch/i386/mm/fault.c	2005-04-11 21:20:38.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/i386/mm/fault.c	2005-04-17 23:11:44.000000000 +0200
@@ -317,7 +317,7 @@
 	write = 0;
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
-#ifdef TEST_VERIFY_AREA
+#ifdef TEST_ACCESS_OK
 			if (regs->cs == KERNEL_CS)
 				printk("WP fault at %08lx\n", regs->eip);
 #endif
--- linux-2.6.12-rc2-mm3-orig/arch/m68k/mm/sun3mmu.c	2005-03-02 08:37:51.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/m68k/mm/sun3mmu.c	2005-04-17 23:11:56.000000000 +0200
@@ -50,7 +50,7 @@
 	unsigned long size;
 
 
-#ifdef TEST_VERIFY_AREA
+#ifdef TEST_ACCESS_OK
 	wp_works_ok = 0;
 #endif
 	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
--- linux-2.6.12-rc2-mm3-orig/include/asm-um/pgtable.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-um/pgtable.h	2005-04-17 23:12:17.000000000 +0200
@@ -108,7 +108,7 @@
  * it will (on an i486) warn about kernel memory accesses that are
  * done without a 'access_ok(VERIFY_WRITE,..)'
  */
-#undef TEST_VERIFY_AREA
+#undef TEST_ACCESS_OK
 
 /* page table for 0-4MB for everybody */
 extern unsigned long pg0[1024];
--- linux-2.6.12-rc2-mm3-orig/include/asm-i386/pgtable.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-i386/pgtable.h	2005-04-17 23:12:29.000000000 +0200
@@ -195,7 +195,7 @@
  * it will (on an i486) warn about kernel memory accesses that are
  * done without a 'verify_area(VERIFY_WRITE,..)'
  */
-#undef TEST_VERIFY_AREA
+#undef TEST_ACCESS_OK
 
 /* The boot page tables (all created as a single array) */
 extern unsigned long pg0[];
--- linux-2.6.12-rc2-mm3-orig/include/asm-frv/pgtable.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-frv/pgtable.h	2005-04-17 23:12:42.000000000 +0200
@@ -351,7 +351,7 @@
  * Define this to warn about kernel memory accesses that are
  * done without a 'verify_area(VERIFY_WRITE,..)'
  */
-#undef TEST_VERIFY_AREA
+#undef TEST_ACCESS_OK
 
 #define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)


