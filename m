Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbUDSN2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbUDSN2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:28:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16910 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264416AbUDSNWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:22:02 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (parisc)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYik-000567-AF@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:21:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/parisc/ subtree.  This has not been compile tested, so
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

===== arch/parisc/hpux/sys_hpux.c 1.10 vs edited =====
--- 1.10/arch/parisc/hpux/sys_hpux.c	Wed Feb 25 10:31:12 2004
+++ edited/arch/parisc/hpux/sys_hpux.c	Mon Apr 19 13:39:57 2004
@@ -32,7 +32,6 @@
 #include <linux/vfs.h>
 
 #include <asm/errno.h>
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 
 unsigned long hpux_brk(unsigned long addr)
===== arch/parisc/kernel/cache.c 1.9 vs edited =====
--- 1.9/arch/parisc/kernel/cache.c	Sun Apr 18 17:13:09 2004
+++ edited/arch/parisc/kernel/cache.c	Mon Apr 19 13:39:57 2004
@@ -24,7 +24,6 @@
 #include <asm/tlbflush.h>
 #include <asm/system.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 
 int split_tlb;
===== arch/parisc/kernel/init_task.c 1.7 vs edited =====
--- 1.7/arch/parisc/kernel/init_task.c	Wed Feb  4 05:41:56 2004
+++ edited/arch/parisc/kernel/init_task.c	Mon Apr 19 13:39:57 2004
@@ -30,7 +30,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
===== arch/parisc/kernel/pci-dma.c 1.9 vs edited =====
--- 1.9/arch/parisc/kernel/pci-dma.c	Sun Mar 14 19:17:06 2004
+++ edited/arch/parisc/kernel/pci-dma.c	Mon Apr 19 13:39:57 2004
@@ -29,7 +29,6 @@
 #include <asm/dma.h>    /* for DMA_CHUNK_SIZE */
 #include <asm/io.h>
 #include <asm/page.h>	/* get_order */
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 
 static struct proc_dir_entry * proc_gsc_root = NULL;
===== arch/parisc/kernel/signal.c 1.13 vs edited =====
--- 1.13/arch/parisc/kernel/signal.c	Thu Dec 18 05:48:39 2003
+++ edited/arch/parisc/kernel/signal.c	Mon Apr 19 13:39:57 2004
@@ -30,7 +30,6 @@
 #include <asm/ucontext.h>
 #include <asm/rt_sigframe.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_COMPAT
===== arch/parisc/kernel/smp.c 1.10 vs edited =====
--- 1.10/arch/parisc/kernel/smp.c	Sun Mar 14 01:57:41 2004
+++ edited/arch/parisc/kernel/smp.c	Mon Apr 19 13:39:55 2004
@@ -39,7 +39,7 @@
 #include <asm/bitops.h>
 #include <asm/current.h>
 #include <asm/delay.h>
-#include <asm/pgalloc.h>	/* for flush_tlb_all() proto/macro */
+#include <asm/tlbflush.h>	/* for flush_tlb_all() proto/macro */
 
 #include <asm/io.h>
 #include <asm/irq.h>		/* for CPU_IRQ_REGION and friends */
===== arch/parisc/mm/ioremap.c 1.2 vs edited =====
--- 1.2/arch/parisc/mm/ioremap.c	Thu Oct  2 08:11:59 2003
+++ edited/arch/parisc/mm/ioremap.c	Mon Apr 19 13:39:57 2004
@@ -12,7 +12,6 @@
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 
 static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
 	unsigned long phys_addr, unsigned long flags)
===== arch/parisc/mm/kmap.c 1.4 vs edited =====
--- 1.4/arch/parisc/mm/kmap.c	Wed Feb  4 05:42:01 2004
+++ edited/arch/parisc/mm/kmap.c	Mon Apr 19 13:39:57 2004
@@ -34,7 +34,6 @@
 #include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 
 #include <asm/io.h>
 #include <asm/page.h>		/* get_order */
