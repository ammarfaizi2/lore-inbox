Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbUDSN1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUDSN0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:26:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9230 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264406AbUDSNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:20:40 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, rth@twiddle.net,
       ink@jurassic.park.msu.ru
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (alpha)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYhQ-00055j-CL@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:20:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/alpha/ subtree.  This has not been compile tested, so
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

===== kernel/alpha_ksyms.c 1.37 vs edited =====
--- 1.37/arch/alpha/kernel/alpha_ksyms.c	Thu Mar 18 00:58:10 2004
+++ edited/kernel/alpha_ksyms.c	Mon Apr 19 13:31:55 2004
@@ -29,7 +29,6 @@
 #include <asm/fpu.h>
 #include <asm/irq.h>
 #include <asm/machvec.h>
-#include <asm/pgalloc.h>
 #include <asm/semaphore.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
===== kernel/core_irongate.c 1.13 vs edited =====
--- 1.13/arch/alpha/kernel/core_irongate.c	Fri Feb 13 15:19:31 2004
+++ edited/kernel/core_irongate.c	Mon Apr 19 13:32:41 2004
@@ -302,7 +302,6 @@
 #include <linux/vmalloc.h>
 #include <linux/agp_backend.h>
 #include <linux/agpgart.h>
-#include <asm/pgalloc.h>
 
 #define GET_PAGE_DIR_OFF(addr) (addr >> 22)
 #define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr))
===== kernel/core_marvel.c 1.16 vs edited =====
--- 1.16/arch/alpha/kernel/core_marvel.c	Fri Feb 13 15:19:31 2004
+++ edited/kernel/core_marvel.c	Mon Apr 19 13:32:41 2004
@@ -22,7 +22,6 @@
 #include <asm/ptrace.h>
 #include <asm/smp.h>
 #include <asm/gct.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/rtc.h>
 
===== kernel/core_titan.c 1.22 vs edited =====
--- 1.22/arch/alpha/kernel/core_titan.c	Fri Feb 13 15:19:31 2004
+++ edited/kernel/core_titan.c	Mon Apr 19 13:32:41 2004
@@ -19,7 +19,6 @@
 
 #include <asm/ptrace.h>
 #include <asm/smp.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 #include "proto.h"
===== kernel/machvec_impl.h 1.3 vs edited =====
--- 1.3/arch/alpha/kernel/machvec_impl.h	Thu Jan 16 22:23:45 2003
+++ edited/kernel/machvec_impl.h	Mon Apr 19 13:32:41 2004
@@ -7,7 +7,6 @@
  */
 
 #include <linux/config.h>
-#include <asm/pgalloc.h>
 
 /* Whee.  These systems don't have an HAE:
        IRONGATE, MARVEL, POLARIS, TSUNAMI, TITAN, WILDFIRE
===== kernel/smp.c 1.40 vs edited =====
--- 1.40/arch/alpha/kernel/smp.c	Sun Mar 14 01:57:41 2004
+++ edited/kernel/smp.c	Mon Apr 19 13:32:41 2004
@@ -34,7 +34,6 @@
 #include <asm/irq.h>
 #include <asm/bitops.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
===== mm/numa.c 1.14 vs edited =====
--- 1.14/arch/alpha/mm/numa.c	Tue Mar 30 21:52:19 2004
+++ edited/mm/numa.c	Mon Apr 19 13:32:41 2004
@@ -15,7 +15,6 @@
 #include <linux/initrd.h>
 
 #include <asm/hwrpb.h>
-#include <asm/pgalloc.h>
 
 pg_data_t node_data[MAX_NUMNODES];
 bootmem_data_t node_bdata[MAX_NUMNODES];
===== mm/remap.c 1.1 vs edited =====
--- 1.1/arch/alpha/mm/remap.c	Thu Sep  5 02:10:58 2002
+++ edited/mm/remap.c	Mon Apr 19 13:32:41 2004
@@ -1,5 +1,4 @@
 #include <linux/vmalloc.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
 /* called with the page_table_lock held */
