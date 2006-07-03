Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWGCV5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWGCV5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWGCV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:56:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29088 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932130AbWGCV4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:56:16 -0400
Date: Mon, 3 Jul 2006 14:56:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060703215605.7566.19179.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 6/8] Fix MAX_NR_ZONES array initializations in various arches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix array initialization in lots of arches

The number of zones may now be reduced from 4 to 2 for many arches. Fix the
array initialization so that it is not initializing 3 elements.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/arch/sh64/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/sh64/mm/init.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-mm6/arch/sh64/mm/init.c	2006-07-03 14:30:12.661342570 -0700
@@ -110,7 +110,7 @@ void show_mem(void)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 	pgd_init((unsigned long)swapper_pg_dir);
 	pgd_init((unsigned long)swapper_pg_dir +
Index: linux-2.6.17-mm6/arch/m32r/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/m32r/mm/init.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-mm6/arch/m32r/mm/init.c	2006-07-03 14:30:12.656460059 -0700
@@ -100,7 +100,7 @@ void free_initrd_mem(unsigned long, unsi
 #ifndef CONFIG_DISCONTIGMEM
 unsigned long __init zone_sizes_init(void)
 {
-	unsigned long  zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long  zones_size[MAX_NR_ZONES] = {0, };
 	unsigned long  max_dma;
 	unsigned long  low;
 	unsigned long  start_pfn;
Index: linux-2.6.17-mm6/arch/parisc/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/parisc/mm/init.c	2006-07-03 13:47:13.329549726 -0700
+++ linux-2.6.17-mm6/arch/parisc/mm/init.c	2006-07-03 14:30:12.660366068 -0700
@@ -809,7 +809,7 @@ void __init paging_init(void)
 	flush_tlb_all_local(NULL);
 
 	for (i = 0; i < npmem_ranges; i++) {
-		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0 };
+		unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 
 		/* We have an IOMMU, so all memory can go into a single
 		   ZONE_DMA zone. */
Index: linux-2.6.17-mm6/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/kernel/setup.c	2006-07-03 13:47:12.664551790 -0700
+++ linux-2.6.17-mm6/arch/i386/kernel/setup.c	2006-07-03 14:31:05.813329367 -0700
@@ -1201,7 +1201,7 @@ static unsigned long __init setup_memory
 
 void __init zone_sizes_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 	unsigned int max_dma, low;
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
Index: linux-2.6.17-mm6/arch/m68knommu/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/m68knommu/mm/init.c	2006-07-03 13:47:12.941878389 -0700
+++ linux-2.6.17-mm6/arch/m68knommu/mm/init.c	2006-07-03 14:30:12.657436561 -0700
@@ -136,7 +136,7 @@ void paging_init(void)
 #endif
 
 	{
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 		zones_size[ZONE_DMA] = 0 >> PAGE_SHIFT;
 		zones_size[ZONE_NORMAL] = (end_mem - PAGE_OFFSET) >> PAGE_SHIFT;
Index: linux-2.6.17-mm6/arch/mips/sgi-ip27/ip27-memory.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/mips/sgi-ip27/ip27-memory.c	2006-07-03 13:47:13.274865608 -0700
+++ linux-2.6.17-mm6/arch/mips/sgi-ip27/ip27-memory.c	2006-07-03 14:30:12.659389566 -0700
@@ -508,7 +508,7 @@ extern unsigned long setup_zero_pages(vo
 
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 	unsigned node;
 
 	pagetable_init();
Index: linux-2.6.17-mm6/arch/frv/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/frv/mm/init.c	2006-07-03 13:47:12.538583018 -0700
+++ linux-2.6.17-mm6/arch/frv/mm/init.c	2006-07-03 14:30:12.654507055 -0700
@@ -98,7 +98,7 @@ void show_mem(void)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 	/* allocate some pages for kernel housekeeping tasks */
 	empty_bad_page_table	= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
Index: linux-2.6.17-mm6/arch/h8300/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/h8300/mm/init.c	2006-07-03 13:47:12.550301044 -0700
+++ linux-2.6.17-mm6/arch/h8300/mm/init.c	2006-07-03 14:30:12.655483557 -0700
@@ -138,7 +138,7 @@ void paging_init(void)
 #endif
 
 	{
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 		zones_size[ZONE_DMA]     = 0 >> PAGE_SHIFT;
 		zones_size[ZONE_NORMAL]  = (end_mem - PAGE_OFFSET) >> PAGE_SHIFT;
Index: linux-2.6.17-mm6/arch/mips/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/mips/mm/init.c	2006-07-03 13:47:13.195768937 -0700
+++ linux-2.6.17-mm6/arch/mips/mm/init.c	2006-07-03 14:30:12.658413063 -0700
@@ -141,7 +141,7 @@ extern void pagetable_init(void);
 
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 	unsigned long max_dma, high, low;
 
 	pagetable_init();
Index: linux-2.6.17-mm6/arch/alpha/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/alpha/mm/init.c	2006-07-03 13:47:11.897021133 -0700
+++ linux-2.6.17-mm6/arch/alpha/mm/init.c	2006-07-03 14:31:05.814305869 -0700
@@ -270,7 +270,7 @@ callback_init(void * kernel_end)
 void
 paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 	unsigned long dma_pfn, high_pfn;
 
 	dma_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
Index: linux-2.6.17-mm6/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/mm/discontig.c	2006-07-03 13:47:12.735836444 -0700
+++ linux-2.6.17-mm6/arch/i386/mm/discontig.c	2006-07-03 14:31:05.815282371 -0700
@@ -354,7 +354,7 @@ void __init zone_sizes_init(void)
 
 
 	for_each_online_node(nid) {
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
 		unsigned long *zholes_size;
 		unsigned int max_dma;
 
