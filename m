Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWEIX7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWEIX7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEIX7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:59:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:49104 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932292AbWEIX7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:59:35 -0400
Date: Tue, 9 May 2006 18:58:28 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       mulix@mulix.org
Subject: [PATCH 2/5] mm: bootmem code cleanup
Message-ID: <20060509235828.GF22385@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Muli's comment on the initial series of patches.
Clean-up to remove 80 char/line wrapping and make code more uniform.

This patch has been tested individually and cumulatively on x86_64 and
cross-compile tested on IA64.  Since I have no IA64 hardware, any
testing on that platform would be appreciated

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 1d9d729a821b -r 235bc05ff8b1 include/linux/bootmem.h
--- a/include/linux/bootmem.h	Mon May  8 15:18:59 2006
+++ b/include/linux/bootmem.h	Mon May  8 16:17:49 2006
@@ -41,11 +41,16 @@
 	struct list_head list;
 } bootmem_data_t;
 
-extern unsigned long __init bootmem_bootmap_pages (unsigned long);
-extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
-extern void __init free_bootmem (unsigned long addr, unsigned long size);
-extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
-extern void * __init __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
+extern unsigned long __init bootmem_bootmap_pages(unsigned long);
+extern unsigned long __init init_bootmem(unsigned long addr,
+					 unsigned long memend);
+extern void __init free_bootmem(unsigned long addr, unsigned long size);
+extern void * __init __alloc_bootmem(unsigned long size,
+				     unsigned long align,
+				     unsigned long goal);
+extern void * __init __alloc_bootmem_nopanic(unsigned long size,
+					     unsigned long align,
+					     unsigned long goal);
 extern void * __init __alloc_bootmem_low(unsigned long size,
 					 unsigned long align,
 					 unsigned long goal);
@@ -54,8 +59,10 @@
 					      unsigned long align,
 					      unsigned long goal);
 extern void * __init __alloc_bootmem_core(struct bootmem_data *bdata,
-		unsigned long size, unsigned long align, unsigned long goal,
-		unsigned long limit);
+					  unsigned long size,
+					  unsigned long align,
+					  unsigned long goal,
+					  unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
@@ -67,12 +74,22 @@
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_low((x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
-extern unsigned long __init free_all_bootmem (void);
-extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
-extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
-extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
-extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
-extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
+extern unsigned long __init free_all_bootmem(void);
+extern void * __init __alloc_bootmem_node(pg_data_t *pgdat,
+					  unsigned long size,
+					  unsigned long align,
+					  unsigned long goal);
+extern unsigned long __init init_bootmem_node(pg_data_t *pgdat,
+					      unsigned long freepfn,
+					      unsigned long startpfn,
+					      unsigned long endpfn);
+extern void __init reserve_bootmem_node(pg_data_t *pgdat,
+					unsigned long physaddr,
+					unsigned long size);
+extern void __init free_bootmem_node(pg_data_t *pgdat,
+				     unsigned long addr,
+				     unsigned long size);
+extern unsigned long __init free_all_bootmem_node(pg_data_t *pgdat);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
diff -r 1d9d729a821b -r 235bc05ff8b1 mm/bootmem.c
--- a/mm/bootmem.c	Mon May  8 15:18:59 2006
+++ b/mm/bootmem.c	Mon May  8 16:17:49 2006
@@ -43,7 +43,7 @@
 #endif
 
 /* return the number of _pages_ that will be allocated for the boot bitmap */
-unsigned long __init bootmem_bootmap_pages (unsigned long pages)
+unsigned long __init bootmem_bootmap_pages(unsigned long pages)
 {
 	unsigned long mapsize;
 
@@ -78,8 +78,8 @@
 /*
  * Called once to set up the allocator itself.
  */
-static unsigned long __init init_bootmem_core (pg_data_t *pgdat,
-	unsigned long mapstart, unsigned long start, unsigned long end)
+static unsigned long __init init_bootmem_core(pg_data_t *pgdat,
+		unsigned long mapstart, unsigned long start, unsigned long end)
 {
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
@@ -104,7 +104,8 @@
  * might be used for boot-time allocations - or it might get added
  * to the free page pool later on.
  */
-static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init reserve_bootmem_core(bootmem_data_t *bdata,
+		unsigned long addr, unsigned long size)
 {
 	unsigned long i;
 	/*
@@ -129,7 +130,8 @@
 		}
 }
 
-static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
+		unsigned long size)
 {
 	unsigned long i;
 	unsigned long start;
@@ -172,9 +174,9 @@
  *
  * NOTE:  This function is _not_ reentrant.
  */
-void * __init
-__alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
-	      unsigned long align, unsigned long goal, unsigned long limit)
+void * __init __alloc_bootmem_core(struct bootmem_data *bdata,
+		unsigned long size, unsigned long align, unsigned long goal,
+		unsigned long limit)
 {
 	unsigned long offset, remaining_size, areasize, preferred;
 	unsigned long i, start = 0, incr, eidx, end_pfn = bdata->node_low_pfn;
@@ -347,7 +349,9 @@
 	 */
 	page = virt_to_page(bdata->node_bootmem_map);
 	count = 0;
-	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
+	for (i = 0; i < ((bdata->node_low_pfn -
+			  (bdata->node_boot_start >> PAGE_SHIFT)) / 8 +
+			 PAGE_SIZE - 1) / PAGE_SIZE; i++, page++) {
 		count++;
 		__free_pages_bootmem(page, 0);
 	}
@@ -357,27 +361,30 @@
 	return total;
 }
 
-unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
+unsigned long __init init_bootmem_node(pg_data_t *pgdat, unsigned long freepfn,
+		unsigned long startpfn, unsigned long endpfn)
 {
 	return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
 }
 
-void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
+		unsigned long size)
 {
 	reserve_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
+	unsigned long size)
 {
 	free_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-unsigned long __init free_all_bootmem_node (pg_data_t *pgdat)
+unsigned long __init free_all_bootmem_node(pg_data_t *pgdat)
 {
 	return(free_all_bootmem_core(pgdat));
 }
 
-unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
+unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
 {
 	max_low_pfn = pages;
 	min_low_pfn = start;
@@ -385,34 +392,36 @@
 }
 
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
-void __init reserve_bootmem (unsigned long addr, unsigned long size)
+void __init reserve_bootmem(unsigned long addr, unsigned long size)
 {
 	reserve_bootmem_core(NODE_DATA(0)->bdata, addr, size);
 }
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
-void __init free_bootmem (unsigned long addr, unsigned long size)
+void __init free_bootmem(unsigned long addr, unsigned long size)
 {
 	free_bootmem_core(NODE_DATA(0)->bdata, addr, size);
 }
 
-unsigned long __init free_all_bootmem (void)
+unsigned long __init free_all_bootmem(void)
 {
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
-void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align,
+		unsigned long goal)
 {
 	bootmem_data_t *bdata;
 	void *ptr;
 
 	list_for_each_entry(bdata, &bdata_list, list)
 		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 0)))
-			return(ptr);
+			return ptr;
 	return NULL;
 }
 
-void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem(unsigned long size, unsigned long align,
+		unsigned long goal)
 {
 	void *mem = __alloc_bootmem_nopanic(size,align,goal);
 	if (mem)
@@ -426,21 +435,22 @@
 }
 
 
-void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size, unsigned long align,
-				   unsigned long goal)
+void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
+		unsigned long align, unsigned long goal)
 {
 	void *ptr;
 
 	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
 	if (ptr)
-		return (ptr);
+		return ptr;
 
 	return __alloc_bootmem(size, align, goal);
 }
 
 #define LOW32LIMIT 0xffffffff
 
-void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
+		unsigned long goal)
 {
 	bootmem_data_t *bdata;
 	void *ptr;
@@ -448,7 +458,7 @@
 	list_for_each_entry(bdata, &bdata_list, list)
 		if ((ptr = __alloc_bootmem_core(bdata, size,
 						 align, goal, LOW32LIMIT)))
-			return(ptr);
+			return ptr;
 
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
@@ -459,7 +469,7 @@
 }
 
 void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
-				       unsigned long align, unsigned long goal)
+		unsigned long align, unsigned long goal)
 {
 	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
 }
