Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264427AbUDSN2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUDSN2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:28:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264415AbUDSNVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:21:52 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, ralf@gnu.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (mips)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYiZ-000564-Vs@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:21:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/mips/ subtree.  This has not been compile tested, so
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

===== arch/mips/baget/baget.c 1.2 vs edited =====
--- 1.2/arch/mips/baget/baget.c	Tue Apr 15 04:10:11 2003
+++ edited/arch/mips/baget/baget.c	Mon Apr 19 13:38:40 2004
@@ -12,7 +12,6 @@
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 #include <asm/baget/baget.h>
 
===== arch/mips/kernel/irixelf.c 1.9 vs edited =====
--- 1.9/arch/mips/kernel/irixelf.c	Mon Apr 12 18:54:53 2004
+++ edited/arch/mips/kernel/irixelf.c	Mon Apr 19 13:38:40 2004
@@ -31,7 +31,6 @@
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mipsregs.h>
 #include <asm/prctl.h>
 
===== arch/mips/kernel/signal32.c 1.15 vs edited =====
--- 1.15/arch/mips/kernel/signal32.c	Sat Apr 17 19:19:30 2004
+++ edited/arch/mips/kernel/signal32.c	Mon Apr 19 13:38:40 2004
@@ -21,7 +21,6 @@
 
 #include <asm/asm.h>
 #include <asm/bitops.h>
-#include <asm/pgalloc.h>
 #include <asm/sim.h>
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
===== arch/mips/kernel/signal_n32.c 1.2 vs edited =====
--- 1.2/arch/mips/kernel/signal_n32.c	Thu Feb 19 20:53:00 2004
+++ edited/arch/mips/kernel/signal_n32.c	Mon Apr 19 13:38:40 2004
@@ -29,7 +29,6 @@
 
 #include <asm/asm.h>
 #include <asm/bitops.h>
-#include <asm/pgalloc.h>
 #include <asm/sim.h>
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
===== arch/mips/kernel/sysirix.c 1.23 vs edited =====
--- 1.23/arch/mips/kernel/sysirix.c	Wed Mar 31 14:31:23 2004
+++ edited/arch/mips/kernel/sysirix.c	Mon Apr 19 13:38:40 2004
@@ -33,7 +33,6 @@
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/inventory.h>
 
===== arch/mips/mm/fault.c 1.9 vs edited =====
--- 1.9/arch/mips/mm/fault.c	Thu Feb 19 20:53:00 2004
+++ edited/arch/mips/mm/fault.c	Mon Apr 19 13:38:40 2004
@@ -22,7 +22,6 @@
 
 #include <asm/branch.h>
 #include <asm/hardirq.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== arch/mips/mm/init.c 1.1 vs edited =====
--- 1.1/arch/mips/mm/init.c	Sat Feb 21 01:33:01 2004
+++ edited/arch/mips/mm/init.c	Mon Apr 19 13:38:40 2004
@@ -29,7 +29,6 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
 #include <asm/tlb.h>
===== arch/mips/mm/ioremap.c 1.5 vs edited =====
--- 1.5/arch/mips/mm/ioremap.c	Thu Oct  2 08:11:59 2003
+++ edited/arch/mips/mm/ioremap.c	Mon Apr 19 13:38:40 2004
@@ -13,7 +13,6 @@
 #include <linux/vmalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 static inline void remap_area_pte(pte_t * pte, unsigned long address,
===== arch/mips/mm/pgtable-64.c 1.2 vs edited =====
--- 1.2/arch/mips/mm/pgtable-64.c	Thu Feb 19 20:53:00 2004
+++ edited/arch/mips/mm/pgtable-64.c	Mon Apr 19 13:38:40 2004
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 void pgd_init(unsigned long page)
 {
===== arch/mips/sgi-ip27/ip27-init.c 1.10 vs edited =====
--- 1.10/arch/mips/sgi-ip27/ip27-init.c	Thu Feb 19 20:53:02 2004
+++ edited/arch/mips/sgi-ip27/ip27-init.c	Mon Apr 19 13:38:40 2004
@@ -14,7 +14,6 @@
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <asm/cpu.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sn/types.h>
 #include <asm/sn/sn0/addrs.h>
===== arch/mips/sgi-ip27/ip27-memory.c 1.8 vs edited =====
--- 1.8/arch/mips/sgi-ip27/ip27-memory.c	Thu Feb 19 20:53:02 2004
+++ edited/arch/mips/sgi-ip27/ip27-memory.c	Mon Apr 19 13:38:40 2004
@@ -20,7 +20,6 @@
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/sn/types.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/hub.h>
