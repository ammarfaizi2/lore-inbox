Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUDSN1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUDSN1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:27:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12302 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264411AbUDSNVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:21:21 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com,
       linux-ia64@linuxia64.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (ia64)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYi5-00055v-NZ@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:21:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/ia64/ subtree.  This has not been compile tested, so
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

===== arch/ia64/kernel/irq.c 1.37 vs edited =====
--- 1.37/arch/ia64/kernel/irq.c	Sat Feb 28 01:13:48 2004
+++ edited/arch/ia64/kernel/irq.c	Mon Apr 19 13:35:16 2004
@@ -42,7 +42,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 
===== arch/ia64/kernel/smp.c 1.30 vs edited =====
--- 1.30/arch/ia64/kernel/smp.c	Thu Mar 25 19:53:03 2004
+++ edited/arch/ia64/kernel/smp.c	Mon Apr 19 13:35:16 2004
@@ -39,7 +39,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
===== arch/ia64/kernel/smpboot.c 1.49 vs edited =====
--- 1.49/arch/ia64/kernel/smpboot.c	Thu Mar 25 19:53:03 2004
+++ edited/arch/ia64/kernel/smpboot.c	Mon Apr 19 13:35:16 2004
@@ -38,7 +38,6 @@
 #include <asm/machvec.h>
 #include <asm/mca.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
===== arch/ia64/mm/contig.c 1.4 vs edited =====
--- 1.4/arch/ia64/mm/contig.c	Fri Mar 12 05:59:24 2004
+++ edited/arch/ia64/mm/contig.c	Mon Apr 19 13:36:06 2004
@@ -21,7 +21,6 @@
 #include <linux/swap.h>
 
 #include <asm/meminit.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
===== arch/ia64/mm/discontig.c 1.13 vs edited =====
--- 1.13/arch/ia64/mm/discontig.c	Fri Mar 12 06:15:26 2004
+++ edited/arch/ia64/mm/discontig.c	Mon Apr 19 13:36:06 2004
@@ -16,7 +16,6 @@
 #include <linux/bootmem.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
===== arch/ia64/mm/hugetlbpage.c 1.23 vs edited =====
--- 1.23/arch/ia64/mm/hugetlbpage.c	Sat Apr 17 19:19:31 2004
+++ edited/arch/ia64/mm/hugetlbpage.c	Mon Apr 19 13:36:06 2004
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
===== arch/ia64/mm/tlb.c 1.21 vs edited =====
--- 1.21/arch/ia64/mm/tlb.c	Mon Jan  5 15:40:36 2004
+++ edited/arch/ia64/mm/tlb.c	Mon Apr 19 13:36:06 2004
@@ -19,7 +19,6 @@
 
 #include <asm/delay.h>
 #include <asm/mmu_context.h>
-#include <asm/pgalloc.h>
 #include <asm/pal.h>
 #include <asm/tlbflush.h>
 
===== arch/ia64/sn/kernel/sn2/cache.c 1.6 vs edited =====
--- 1.6/arch/ia64/sn/kernel/sn2/cache.c	Thu Feb 12 15:55:56 2004
+++ edited/arch/ia64/sn/kernel/sn2/cache.c	Mon Apr 19 13:36:06 2004
@@ -7,7 +7,7 @@
  *
  */
 #include <linux/module.h>
-#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
 
 /**
  * sn_flush_all_caches - flush a range of address from all caches (incl. L4)
