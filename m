Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264440AbUDSNdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUDSNam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:30:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23310 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264421AbUDSNW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:22:58 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, wesolows@foobazco.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (sparc)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYjd-00056M-7G@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:22:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/sparc/ subtree.  This has not been compile tested, so
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

===== arch/sparc/kernel/ioport.c 1.14 vs edited =====
--- 1.14/arch/sparc/kernel/ioport.c	Sun Mar 14 06:54:58 2004
+++ edited/arch/sparc/kernel/ioport.c	Mon Apr 19 13:44:22 2004
@@ -40,7 +40,6 @@
 #include <asm/vaddrs.h>
 #include <asm/oplib.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
===== arch/sparc/kernel/irq.c 1.28 vs edited =====
--- 1.28/arch/sparc/kernel/irq.c	Sun Feb 22 22:34:53 2004
+++ edited/arch/sparc/kernel/irq.c	Mon Apr 19 13:44:22 2004
@@ -43,7 +43,6 @@
 #include <asm/traps.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/hardirq.h>
 #include <asm/pcic.h>
===== arch/sparc/kernel/signal.c 1.27 vs edited =====
--- 1.27/arch/sparc/kernel/signal.c	Wed Mar 31 07:02:53 2004
+++ edited/arch/sparc/kernel/signal.c	Mon Apr 19 13:44:22 2004
@@ -25,7 +25,6 @@
 #include <asm/bitops.h>
 #include <asm/ptrace.h>
 #include <asm/svr4.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>	/* flush_sig_insns */
 
===== arch/sparc/kernel/smp.c 1.16 vs edited =====
--- 1.16/arch/sparc/kernel/smp.c	Tue Mar 16 10:14:48 2004
+++ edited/arch/sparc/kernel/smp.c	Mon Apr 19 13:44:22 2004
@@ -27,7 +27,6 @@
 
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
 #include <asm/hardirq.h>
===== arch/sparc/kernel/sparc-stub.c 1.4 vs edited =====
--- 1.4/arch/sparc/kernel/sparc-stub.c	Fri Sep  6 06:16:41 2002
+++ edited/arch/sparc/kernel/sparc-stub.c	Mon Apr 19 13:44:22 2004
@@ -107,7 +107,6 @@
 #include <asm/traps.h>
 #include <asm/vac-ops.h>
 #include <asm/kgdb.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 
===== arch/sparc/kernel/sun4d_irq.c 1.19 vs edited =====
--- 1.19/arch/sparc/kernel/sun4d_irq.c	Mon Mar 15 00:43:39 2004
+++ edited/arch/sparc/kernel/sun4d_irq.c	Mon Apr 19 13:44:22 2004
@@ -34,7 +34,6 @@
 #include <asm/traps.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sbus.h>
 #include <asm/sbi.h>
===== arch/sparc/kernel/sun4d_smp.c 1.16 vs edited =====
--- 1.16/arch/sparc/kernel/sun4d_smp.c	Tue Mar 16 10:14:48 2004
+++ edited/arch/sparc/kernel/sun4d_smp.c	Mon Apr 19 13:44:22 2004
@@ -26,7 +26,6 @@
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
 #include <asm/hardirq.h>
===== arch/sparc/kernel/sun4m_irq.c 1.10 vs edited =====
--- 1.10/arch/sparc/kernel/sun4m_irq.c	Mon Mar 15 00:43:39 2004
+++ edited/arch/sparc/kernel/sun4m_irq.c	Mon Apr 19 13:44:22 2004
@@ -31,7 +31,6 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/traps.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
 #include <asm/irq.h>
===== arch/sparc/kernel/sun4m_smp.c 1.14 vs edited =====
--- 1.14/arch/sparc/kernel/sun4m_smp.c	Tue Mar 16 10:14:48 2004
+++ edited/arch/sparc/kernel/sun4m_smp.c	Mon Apr 19 13:44:22 2004
@@ -25,7 +25,6 @@
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
 #include <asm/hardirq.h>
===== arch/sparc/mm/btfixup.c 1.2 vs edited =====
--- 1.2/arch/sparc/mm/btfixup.c	Wed Jul 17 01:12:13 2002
+++ edited/arch/sparc/mm/btfixup.c	Mon Apr 19 13:44:22 2004
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <asm/btfixup.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
 #include <asm/system.h>
===== arch/sparc/mm/generic.c 1.8 vs edited =====
--- 1.8/arch/sparc/mm/generic.c	Sat Oct  5 09:36:58 2002
+++ edited/arch/sparc/mm/generic.c	Mon Apr 19 13:44:22 2004
@@ -10,7 +10,6 @@
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
===== arch/sparc/mm/highmem.c 1.4 vs edited =====
--- 1.4/arch/sparc/mm/highmem.c	Tue Jan  6 04:26:21 2004
+++ edited/arch/sparc/mm/highmem.c	Mon Apr 19 13:44:22 2004
@@ -24,7 +24,6 @@
  */
 #include <linux/mm.h>
 #include <linux/highmem.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
===== arch/sparc/mm/io-unit.c 1.8 vs edited =====
--- 1.8/arch/sparc/mm/io-unit.c	Tue Jan  6 04:26:21 2004
+++ edited/arch/sparc/mm/io-unit.c	Mon Apr 19 13:44:22 2004
@@ -13,7 +13,6 @@
 #include <linux/highmem.h>	/* pte_offset_map => kmap_atomic */
 
 #include <asm/scatterlist.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sbus.h>
 #include <asm/io.h>
===== arch/sparc/mm/iommu.c 1.12 vs edited =====
--- 1.12/arch/sparc/mm/iommu.c	Tue Jan  6 04:26:21 2004
+++ edited/arch/sparc/mm/iommu.c	Mon Apr 19 13:44:22 2004
@@ -15,7 +15,6 @@
 #include <linux/highmem.h>	/* pte_offset_map => kmap_atomic */
 
 #include <asm/scatterlist.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sbus.h>
 #include <asm/io.h>
