Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUDSQhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUDSQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:37:20 -0400
Received: from p508B6729.dip.t-dialin.net ([80.139.103.41]:64274 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261430AbUDSQhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:37:03 -0400
Date: Mon, 19 Apr 2004 18:36:48 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (mips)
Message-ID: <20040419163648.GA24745@linux-mips.org>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYiZ-000564-Vs@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BFYiZ-000564-Vs@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 02:21:47PM +0100, Russell King wrote:

> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/mips/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.
> 
> Please ensure that at least the first two patches have already
> been applied to your tree; they can be found at:
> 
> 	http://lkml.org/lkml/2004/4/18/86
> 	http://lkml.org/lkml/2004/4/18/87
> 
> This patch is part of a larger patch aiming towards getting the
> include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
> can sanely get at things like mm_struct and friends.
> 
> In the event that any of these files fails to build, chances are
> you need to include some other header file rather than pgalloc.h.
> Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
> or asm/tlbflush.h.

It needed a little fixing for one because of recent changed to the IP27
code and to keep things building.  The updated patch against linux-mips.org's
cvs which I'm about to checkin, is below.

  Ralf

Index: arch/mips/baget/baget.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/baget/baget.c,v
retrieving revision 1.4
diff -u -r1.4 baget.c
--- arch/mips/baget/baget.c	6 Aug 2002 00:08:53 -0000	1.4
+++ arch/mips/baget/baget.c	19 Apr 2004 16:28:55 -0000
@@ -12,7 +12,6 @@
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 #include <asm/baget/baget.h>
 
Index: arch/mips/kernel/irixelf.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/irixelf.c,v
retrieving revision 1.54
diff -u -r1.54 irixelf.c
--- arch/mips/kernel/irixelf.c	19 Oct 2003 00:50:08 -0000	1.54
+++ arch/mips/kernel/irixelf.c	19 Apr 2004 16:28:58 -0000
@@ -31,7 +31,6 @@
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mipsregs.h>
 #include <asm/prctl.h>
 
Index: arch/mips/kernel/signal32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal32.c,v
retrieving revision 1.10
diff -u -r1.10 signal32.c
--- arch/mips/kernel/signal32.c	11 Mar 2004 16:46:43 -0000	1.10
+++ arch/mips/kernel/signal32.c	19 Apr 2004 16:28:58 -0000
@@ -21,7 +21,6 @@
 
 #include <asm/asm.h>
 #include <asm/bitops.h>
-#include <asm/pgalloc.h>
 #include <asm/sim.h>
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
Index: arch/mips/kernel/signal_n32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal_n32.c,v
retrieving revision 1.4
diff -u -r1.4 signal_n32.c
--- arch/mips/kernel/signal_n32.c	3 Mar 2004 12:54:20 -0000	1.4
+++ arch/mips/kernel/signal_n32.c	19 Apr 2004 16:28:58 -0000
@@ -29,7 +29,6 @@
 
 #include <asm/asm.h>
 #include <asm/bitops.h>
-#include <asm/pgalloc.h>
 #include <asm/sim.h>
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
Index: arch/mips/kernel/sysirix.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/sysirix.c,v
retrieving revision 1.58
diff -u -r1.58 sysirix.c
--- arch/mips/kernel/sysirix.c	12 Apr 2004 20:23:24 -0000	1.58
+++ arch/mips/kernel/sysirix.c	19 Apr 2004 16:28:58 -0000
@@ -33,7 +33,6 @@
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/inventory.h>
 
Index: arch/mips/mm/fault.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/fault.c,v
retrieving revision 1.52
diff -u -r1.52 fault.c
--- arch/mips/mm/fault.c	18 Dec 2003 21:52:33 -0000	1.52
+++ arch/mips/mm/fault.c	19 Apr 2004 16:28:58 -0000
@@ -22,7 +22,6 @@
 
 #include <asm/branch.h>
 #include <asm/hardirq.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: arch/mips/mm/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.67
diff -u -r1.67 init.c
--- arch/mips/mm/init.c	19 Mar 2004 01:26:10 -0000	1.67
+++ arch/mips/mm/init.c	19 Apr 2004 16:28:58 -0000
@@ -29,9 +29,10 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
Index: arch/mips/mm/ioremap.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/ioremap.c,v
retrieving revision 1.18
diff -u -r1.18 ioremap.c
--- arch/mips/mm/ioremap.c	25 Feb 2004 22:09:29 -0000	1.18
+++ arch/mips/mm/ioremap.c	19 Apr 2004 16:28:58 -0000
@@ -13,7 +13,6 @@
 #include <linux/vmalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 static inline void remap_area_pte(pte_t * pte, unsigned long address,
Index: arch/mips/mm/pgtable-64.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/pgtable-64.c,v
retrieving revision 1.3
diff -u -r1.3 pgtable-64.c
--- arch/mips/mm/pgtable-64.c	27 Aug 2003 17:10:00 -0000	1.3
+++ arch/mips/mm/pgtable-64.c	19 Apr 2004 16:28:58 -0000
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 void pgd_init(unsigned long page)
 {
Index: arch/mips/sgi-ip27/ip27-init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip27/ip27-init.c,v
retrieving revision 1.58
diff -u -r1.58 ip27-init.c
--- arch/mips/sgi-ip27/ip27-init.c	12 Apr 2004 20:23:25 -0000	1.58
+++ arch/mips/sgi-ip27/ip27-init.c	19 Apr 2004 16:29:00 -0000
@@ -15,7 +15,6 @@
 #include <linux/cpumask.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/time.h>
 #include <asm/sn/types.h>
Index: include/asm-mips/pgalloc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pgalloc.h,v
retrieving revision 1.30
diff -u -r1.30 pgalloc.h
--- include/asm-mips/pgalloc.h	14 Aug 2003 15:54:42 -0000	1.30
+++ include/asm-mips/pgalloc.h	19 Apr 2004 16:29:02 -0000
@@ -122,12 +122,6 @@
 
 #endif
 
-/*
- * Used for the b0rked handling of kernel pagetables on the 64-bit kernel.
- */
-extern pte_t kptbl[(PAGE_SIZE << PGD_ORDER)/sizeof(pte_t)];
-extern pmd_t kpmdtbl[PTRS_PER_PMD];
-
 #define check_pgt_cache()	do { } while (0)
 
 #endif /* _ASM_PGALLOC_H */
Index: include/asm-mips/pgtable-64.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pgtable-64.h,v
retrieving revision 1.11
diff -u -r1.11 pgtable-64.h
--- include/asm-mips/pgtable-64.h	5 Jan 2004 23:29:13 -0000	1.11
+++ include/asm-mips/pgtable-64.h	19 Apr 2004 16:29:02 -0000
@@ -216,4 +216,10 @@
 
 typedef pte_t *pte_addr_t;
 
+/*
+ * Used for the b0rked handling of kernel pagetables on the 64-bit kernel.
+ */
+extern pte_t kptbl[(PAGE_SIZE << PGD_ORDER)/sizeof(pte_t)];
+extern pmd_t kpmdtbl[PTRS_PER_PMD];
+
 #endif /* _ASM_PGTABLE_64_H */
