Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbUDSNdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUDSN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:29:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22542 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264419AbUDSNWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:22:45 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (sh)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYjS-00056J-TY@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:22:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** SH does not appear to have a maintainer listed ***

This patch cleans up needless includes of asm/pgalloc.h from the
arch/sh/ subtree.  This has not been compile tested, so
needs the architecture maintainers (or willing volunteers) to
test.

Please ensure that at least the first two patches have already
been applied to your tree; they can be found at:

	http://lkml.org/lkml/2004/4/18/86
	http://lkml.org/lkml/2004/4/18/87

This patch is part of a larger patch aiming towards getting the
include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
can sanely get at things like mm_struct and friends.

In the event that any of these files fails to build, chances are
you need to include some other header file rather than pgalloc.h.
Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
or asm/tlbflush.h.

===== arch/sh/kernel/irq.c 1.17 vs edited =====
--- 1.17/arch/sh/kernel/irq.c	Fri Feb 13 15:19:28 2004
+++ edited/arch/sh/kernel/irq.c	Mon Apr 19 13:42:59 2004
@@ -35,7 +35,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
-#include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <linux/irq.h>
===== arch/sh/mm/cache-sh3.c 1.11 vs edited =====
--- 1.11/arch/sh/mm/cache-sh3.c	Fri Feb 13 15:19:29 2004
+++ edited/arch/sh/mm/cache-sh3.c	Mon Apr 19 13:42:59 2004
@@ -17,7 +17,6 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
===== arch/sh/mm/cache-sh4.c 1.7 vs edited =====
--- 1.7/arch/sh/mm/cache-sh4.c	Tue Mar 23 10:05:27 2004
+++ edited/arch/sh/mm/cache-sh4.c	Mon Apr 19 13:42:59 2004
@@ -19,7 +19,6 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
===== arch/sh/mm/fault-nommu.c 1.1 vs edited =====
--- 1.1/arch/sh/mm/fault-nommu.c	Sun May  4 16:29:54 2003
+++ edited/arch/sh/mm/fault-nommu.c	Mon Apr 19 13:42:59 2004
@@ -25,7 +25,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
===== arch/sh/mm/fault.c 1.12 vs edited =====
--- 1.12/arch/sh/mm/fault.c	Fri Feb 13 15:19:29 2004
+++ edited/arch/sh/mm/fault.c	Mon Apr 19 13:42:59 2004
@@ -25,7 +25,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
===== arch/sh/mm/hugetlbpage.c 1.6 vs edited =====
--- 1.6/arch/sh/mm/hugetlbpage.c	Mon Apr 12 18:55:12 2004
+++ edited/arch/sh/mm/hugetlbpage.c	Mon Apr 19 13:42:59 2004
@@ -19,7 +19,6 @@
 #include <linux/sysctl.h>
 
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
===== arch/sh/mm/init.c 1.17 vs edited =====
--- 1.17/arch/sh/mm/init.c	Tue Mar 23 10:05:27 2004
+++ edited/arch/sh/mm/init.c	Mon Apr 19 13:42:59 2004
@@ -30,7 +30,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
 #include <asm/tlb.h>
===== arch/sh/mm/ioremap.c 1.8 vs edited =====
--- 1.8/arch/sh/mm/ioremap.c	Tue Mar 23 10:05:27 2004
+++ edited/arch/sh/mm/ioremap.c	Mon Apr 19 13:42:59 2004
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
===== arch/sh/mm/pg-sh4.c 1.1 vs edited =====
--- 1.1/arch/sh/mm/pg-sh4.c	Sun May  4 16:29:55 2003
+++ edited/arch/sh/mm/pg-sh4.c	Mon Apr 19 13:42:59 2004
@@ -20,7 +20,6 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
===== arch/sh/mm/tlb-sh3.c 1.2 vs edited =====
--- 1.2/arch/sh/mm/tlb-sh3.c	Mon Jan 19 06:22:17 2004
+++ edited/arch/sh/mm/tlb-sh3.c	Mon Apr 19 13:42:59 2004
@@ -24,7 +24,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
===== arch/sh/mm/tlb-sh4.c 1.2 vs edited =====
--- 1.2/arch/sh/mm/tlb-sh4.c	Tue Mar 23 10:05:26 2004
+++ edited/arch/sh/mm/tlb-sh4.c	Mon Apr 19 13:42:59 2004
@@ -24,7 +24,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
