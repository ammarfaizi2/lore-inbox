Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWFZNHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWFZNHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZNHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:07:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15452 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932291AbWFZNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:07:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=L+bn7gHMauXiyKXy1Dlb7S244AuclKqok/Pk3/O+frZAgMOQqIw/TNg3kfUFOicFp58HSjIdj1Soc7r1JTSV1sKkyfBZsbzgA01a1sFSkDXUq/981+BTShTqTnul676hpe2174m3nEluD6zWnQnfl8FzuVuUufAAj/+CYyvDZC8=
Message-ID: <449FDD02.2090307@innova-card.com>
Date: Mon, 26 Jun 2006 15:11:30 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Dave Hansen <haveblue@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up the bootmem allocator
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does _only_ some cleanup in the bootmem allocator by:

	- following the kernel coding style conventions
	- using pfn/page conversion macros
	- removing some not needed parentheses
	- removing some useless included headers
	- limiting to 80 column width

It also removes __init tags in the header file and hopefully make it
easier to read.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/bootmem.h |  101 ++++++++++++++----------
 mm/bootmem.c            |  195 ++++++++++++++++++++++++++---------------------
 2 files changed, 167 insertions(+), 129 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index da2d107..dd733ee 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -41,45 +41,64 @@ typedef struct bootmem_data {
 	struct list_head list;
 } bootmem_data_t;
 
-extern unsigned long __init bootmem_bootmap_pages (unsigned long);
-extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
-extern void __init free_bootmem (unsigned long addr, unsigned long size);
-extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
-extern void * __init __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
-extern void * __init __alloc_bootmem_low(unsigned long size,
-					 unsigned long align,
-					 unsigned long goal);
-extern void * __init __alloc_bootmem_low_node(pg_data_t *pgdat,
-					      unsigned long size,
-					      unsigned long align,
-					      unsigned long goal);
-extern void * __init __alloc_bootmem_core(struct bootmem_data *bdata,
-		unsigned long size, unsigned long align, unsigned long goal,
-		unsigned long limit);
+extern unsigned long bootmem_bootmap_pages(unsigned long);
+extern unsigned long init_bootmem(unsigned long addr, unsigned long memend);
+extern void free_bootmem(unsigned long addr, unsigned long size);
+extern void * __alloc_bootmem(unsigned long size,
+			      unsigned long align,
+			      unsigned long goal);
+extern void * __alloc_bootmem_nopanic(unsigned long size,
+				      unsigned long align,
+				      unsigned long goal);
+extern void * __alloc_bootmem_low(unsigned long size,
+				  unsigned long align,
+				  unsigned long goal);
+extern void * __alloc_bootmem_low_node(pg_data_t *pgdat,
+				       unsigned long size,
+				       unsigned long align,
+				       unsigned long goal);
+extern void * __alloc_bootmem_core(struct bootmem_data *bdata,
+				   unsigned long size,
+				   unsigned long align,
+				   unsigned long goal,
+				   unsigned long limit);
+
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
-extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
+extern void reserve_bootmem(unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
-	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem(x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
-	__alloc_bootmem_low((x), SMP_CACHE_BYTES, 0)
+	__alloc_bootmem_low(x, SMP_CACHE_BYTES, 0)
 #define alloc_bootmem_pages(x) \
-	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem(x, PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
-	__alloc_bootmem_low((x), PAGE_SIZE, 0)
+	__alloc_bootmem_low(x, PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
-extern unsigned long __init free_all_bootmem (void);
-extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
-extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
-extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
-extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
-extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
+
+extern unsigned long free_all_bootmem(void);
+extern unsigned long free_all_bootmem_node(pg_data_t *pgdat);
+extern void * __alloc_bootmem_node(pg_data_t *pgdat,
+				   unsigned long size,
+				   unsigned long align,
+				   unsigned long goal);
+extern unsigned long init_bootmem_node(pg_data_t *pgdat,
+				       unsigned long freepfn,
+				       unsigned long startpfn,
+				       unsigned long endpfn);
+extern void reserve_bootmem_node(pg_data_t *pgdat,
+				 unsigned long physaddr,
+				 unsigned long size);
+extern void free_bootmem_node(pg_data_t *pgdat,
+			      unsigned long addr,
+			      unsigned long size);
+
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node(pgdat, x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_pages_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node(pgdat, x, PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages_node(pgdat, x) \
-	__alloc_bootmem_low_node((pgdat), (x), PAGE_SIZE, 0)
+	__alloc_bootmem_low_node(pgdat, x, PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
 #ifdef CONFIG_HAVE_ARCH_ALLOC_REMAP
@@ -89,19 +108,19 @@ static inline void *alloc_remap(int nid,
 {
 	return NULL;
 }
-#endif
+#endif	/* CONFIG_HAVE_ARCH_ALLOC_REMAP */
 
-extern unsigned long __initdata nr_kernel_pages;
-extern unsigned long __initdata nr_all_pages;
+extern unsigned long nr_kernel_pages;
+extern unsigned long nr_all_pages;
 
-extern void *__init alloc_large_system_hash(const char *tablename,
-					    unsigned long bucketsize,
-					    unsigned long numentries,
-					    int scale,
-					    int flags,
-					    unsigned int *_hash_shift,
-					    unsigned int *_hash_mask,
-					    unsigned long limit);
+extern void *alloc_large_system_hash(const char *tablename,
+				     unsigned long bucketsize,
+				     unsigned long numentries,
+				     int scale,
+				     int flags,
+				     unsigned int *_hash_shift,
+				     unsigned int *_hash_mask,
+				     unsigned long limit);
 
 #define HASH_HIGHMEM	0x00000001	/* Consider highmem? */
 #define HASH_EARLY	0x00000002	/* Allocating during early boot? */
@@ -114,7 +133,7 @@ #define HASHDIST_DEFAULT 1
 #else
 #define HASHDIST_DEFAULT 0
 #endif
-extern int __initdata hashdist;		/* Distribute hashes across NUMA nodes? */
+extern int hashdist;		/* Distribute hashes across NUMA nodes? */
 
 
 #endif /* _LINUX_BOOTMEM_H */
diff --git a/mm/bootmem.c b/mm/bootmem.c
index d213fed..a8fb272 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -8,17 +8,14 @@
  *  free memory collector. It's used to deal with reserved
  *  system memory and memory holes as well.
  */
-
-#include <linux/mm.h>
-#include <linux/kernel_stat.h>
-#include <linux/swap.h>
-#include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/mmzone.h>
+#include <linux/bootmem.h>
+#include <linux/pfn.h>
 #include <linux/module.h>
-#include <asm/dma.h>
+
 #include <asm/io.h>
+
 #include "internal.h"
 
 /*
@@ -43,7 +40,7 @@ unsigned long saved_max_pfn;
 #endif
 
 /* return the number of _pages_ that will be allocated for the boot bitmap */
-unsigned long __init bootmem_bootmap_pages (unsigned long pages)
+unsigned long __init bootmem_bootmap_pages(unsigned long pages)
 {
 	unsigned long mapsize;
 
@@ -56,7 +53,7 @@ unsigned long __init bootmem_bootmap_pag
 /*
  * link bdata in order
  */
-static void link_bootmem(bootmem_data_t *bdata)
+static void __init link_bootmem(bootmem_data_t *bdata)
 {
 	bootmem_data_t *ent;
 	if (list_empty(&bdata_list)) {
@@ -71,22 +68,32 @@ static void link_bootmem(bootmem_data_t 
 		}
 	}
 	list_add_tail(&bdata->list, &bdata_list);
-	return;
 }
 
+/*
+ * Given an initialised bdata, it returns the size of the boot bitmap
+ */
+static unsigned long __init get_mapsize(bootmem_data_t *bdata)
+{
+	unsigned long mapsize;
+	unsigned long start = PFN_DOWN(bdata->node_boot_start);
+	unsigned long end = bdata->node_low_pfn;
+
+	mapsize = ((end - start) + 7) / 8;
+	return ALIGN(mapsize, sizeof(long));
+}
 
 /*
  * Called once to set up the allocator itself.
  */
-static unsigned long __init init_bootmem_core (pg_data_t *pgdat,
+static unsigned long __init init_bootmem_core(pg_data_t *pgdat,
 	unsigned long mapstart, unsigned long start, unsigned long end)
 {
 	bootmem_data_t *bdata = pgdat->bdata;
-	unsigned long mapsize = ((end - start)+7)/8;
+	unsigned long mapsize;
 
-	mapsize = ALIGN(mapsize, sizeof(long));
-	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
-	bdata->node_boot_start = (start << PAGE_SHIFT);
+	bdata->node_bootmem_map = phys_to_virt(PFN_PHYS(mapstart));
+	bdata->node_boot_start = PFN_PHYS(start);
 	bdata->node_low_pfn = end;
 	link_bootmem(bdata);
 
@@ -94,6 +101,7 @@ static unsigned long __init init_bootmem
 	 * Initially all pages are reserved - setup_arch() has to
 	 * register free RAM areas explicitly.
 	 */
+	mapsize = get_mapsize(bdata);
 	memset(bdata->node_bootmem_map, 0xff, mapsize);
 
 	return mapsize;
@@ -104,22 +112,22 @@ static unsigned long __init init_bootmem
  * might be used for boot-time allocations - or it might get added
  * to the free page pool later on.
  */
-static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
+					unsigned long size)
 {
+	unsigned long sidx, eidx;
 	unsigned long i;
+
 	/*
 	 * round up, partially reserved pages are considered
 	 * fully reserved.
 	 */
-	unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long eidx = (addr + size - bdata->node_boot_start + 
-							PAGE_SIZE-1)/PAGE_SIZE;
-	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
-
 	BUG_ON(!size);
-	BUG_ON(sidx >= eidx);
-	BUG_ON((addr >> PAGE_SHIFT) >= bdata->node_low_pfn);
-	BUG_ON(end > bdata->node_low_pfn);
+	BUG_ON(PFN_DOWN(addr) >= bdata->node_low_pfn);
+	BUG_ON(PFN_UP(addr + size) > bdata->node_low_pfn);
+
+	sidx = PFN_DOWN(addr - bdata->node_boot_start);
+	eidx = PFN_UP(addr + size - bdata->node_boot_start);
 
 	for (i = sidx; i < eidx; i++)
 		if (test_and_set_bit(i, bdata->node_bootmem_map)) {
@@ -129,20 +137,18 @@ #endif
 		}
 }
 
-static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
+				     unsigned long size)
 {
+	unsigned long sidx, eidx;
 	unsigned long i;
-	unsigned long start;
+
 	/*
 	 * round down end of usable mem, partially free pages are
 	 * considered reserved.
 	 */
-	unsigned long sidx;
-	unsigned long eidx = (addr + size - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long end = (addr + size)/PAGE_SIZE;
-
 	BUG_ON(!size);
-	BUG_ON(end > bdata->node_low_pfn);
+	BUG_ON(PFN_DOWN(addr + size) > bdata->node_low_pfn);
 
 	if (addr < bdata->last_success)
 		bdata->last_success = addr;
@@ -150,8 +156,8 @@ static void __init free_bootmem_core(boo
 	/*
 	 * Round up the beginning of the address.
 	 */
-	start = (addr + PAGE_SIZE-1) / PAGE_SIZE;
-	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
+	sidx = PFN_UP(addr) - PFN_DOWN(bdata->node_boot_start);
+	eidx = PFN_DOWN(addr + size - bdata->node_boot_start);
 
 	for (i = sidx; i < eidx; i++) {
 		if (unlikely(!test_and_clear_bit(i, bdata->node_bootmem_map)))
@@ -176,11 +182,13 @@ void * __init
 __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
 	      unsigned long align, unsigned long goal, unsigned long limit)
 {
-	unsigned long offset, remaining_size, areasize, preferred;
-	unsigned long i, start = 0, incr, eidx, end_pfn = bdata->node_low_pfn;
+	unsigned long offset, areasize, preferred;
+	unsigned long i, start, incr, eidx;
+	unsigned long end_pfn;
+	unsigned long remaining_size;
 	void *ret;
 
-	if(!size) {
+	if (!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
 		BUG();
 	}
@@ -189,23 +197,22 @@ __alloc_bootmem_core(struct bootmem_data
 	if (limit && bdata->node_boot_start >= limit)
 		return NULL;
 
-        limit >>=PAGE_SHIFT;
+	end_pfn = bdata->node_low_pfn;
+	limit = PFN_DOWN(limit);
 	if (limit && end_pfn > limit)
 		end_pfn = limit;
 
-	eidx = end_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	eidx = end_pfn - PFN_DOWN(bdata->node_boot_start);
 	offset = 0;
-	if (align &&
-	    (bdata->node_boot_start & (align - 1UL)) != 0)
-		offset = (align - (bdata->node_boot_start & (align - 1UL)));
-	offset >>= PAGE_SHIFT;
+	if (align && (bdata->node_boot_start & (align - 1UL)) != 0)
+		offset = align - (bdata->node_boot_start & (align - 1UL));
+	offset = PFN_DOWN(offset);
 
 	/*
 	 * We try to allocate bootmem pages above 'goal'
 	 * first, then we try to allocate lower pages.
 	 */
-	if (goal && (goal >= bdata->node_boot_start) && 
-	    ((goal >> PAGE_SHIFT) < end_pfn)) {
+	if (goal && goal >= bdata->node_boot_start && PFN_DOWN(goal) < end_pfn) {
 		preferred = goal - bdata->node_boot_start;
 
 		if (bdata->last_success >= preferred)
@@ -214,11 +221,11 @@ __alloc_bootmem_core(struct bootmem_data
 	} else
 		preferred = 0;
 
-	preferred = ALIGN(preferred, align) >> PAGE_SHIFT;
-	preferred += offset;
-	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
+	preferred = PFN_DOWN(ALIGN(preferred, align)) + offset;
+	areasize = (size + PAGE_SIZE-1) / PAGE_SIZE;
 	incr = align >> PAGE_SHIFT ? : 1;
 
+	start = 0;
 restart_scan:
 	for (i = preferred; i < eidx; i += incr) {
 		unsigned long j;
@@ -231,7 +238,7 @@ restart_scan:
 		for (j = i + 1; j < i + areasize; ++j) {
 			if (j >= eidx)
 				goto fail_block;
-			if (test_bit (j, bdata->node_bootmem_map))
+			if (test_bit(j, bdata->node_bootmem_map))
 				goto fail_block;
 		}
 		start = i;
@@ -247,7 +254,7 @@ restart_scan:
 	return NULL;
 
 found:
-	bdata->last_success = start << PAGE_SHIFT;
+	bdata->last_success = PFN_PHYS(start);
 	BUG_ON(start >= eidx);
 
 	/*
@@ -259,19 +266,21 @@ found:
 	    bdata->last_offset && bdata->last_pos+1 == start) {
 		offset = ALIGN(bdata->last_offset, align);
 		BUG_ON(offset > PAGE_SIZE);
-		remaining_size = PAGE_SIZE-offset;
+		remaining_size = PAGE_SIZE - offset;
 		if (size < remaining_size) {
 			areasize = 0;
 			/* last_pos unchanged */
-			bdata->last_offset = offset+size;
-			ret = phys_to_virt(bdata->last_pos*PAGE_SIZE + offset +
-						bdata->node_boot_start);
+			bdata->last_offset = offset + size;
+			ret = phys_to_virt(bdata->last_pos * PAGE_SIZE +
+					   offset +
+					   bdata->node_boot_start);
 		} else {
 			remaining_size = size - remaining_size;
-			areasize = (remaining_size+PAGE_SIZE-1)/PAGE_SIZE;
-			ret = phys_to_virt(bdata->last_pos*PAGE_SIZE + offset +
-						bdata->node_boot_start);
-			bdata->last_pos = start+areasize-1;
+			areasize = (remaining_size + PAGE_SIZE-1) / PAGE_SIZE;
+			ret = phys_to_virt(bdata->last_pos * PAGE_SIZE +
+					   offset +
+					   bdata->node_boot_start);
+			bdata->last_pos = start + areasize - 1;
 			bdata->last_offset = remaining_size;
 		}
 		bdata->last_offset &= ~PAGE_MASK;
@@ -284,7 +293,7 @@ found:
 	/*
 	 * Reserve the area now:
 	 */
-	for (i = start; i < start+areasize; i++)
+	for (i = start; i < start + areasize; i++)
 		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
 			BUG();
 	memset(ret, 0, size);
@@ -305,8 +314,8 @@ static unsigned long __init free_all_boo
 
 	count = 0;
 	/* first extant page of the node */
-	pfn = bdata->node_boot_start >> PAGE_SHIFT;
-	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	pfn = PFN_DOWN(bdata->node_boot_start);
+	idx = bdata->node_low_pfn - pfn;
 	map = bdata->node_bootmem_map;
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
 	if (bdata->node_boot_start == 0 ||
@@ -335,7 +344,7 @@ static unsigned long __init free_all_boo
 				}
 			}
 		} else {
-			i+=BITS_PER_LONG;
+			i += BITS_PER_LONG;
 		}
 		pfn += BITS_PER_LONG;
 	}
@@ -347,9 +356,10 @@ static unsigned long __init free_all_boo
 	 */
 	page = virt_to_page(bdata->node_bootmem_map);
 	count = 0;
-	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
-		count++;
+	idx = (get_mapsize(bdata) + PAGE_SIZE-1) >> PAGE_SHIFT;
+	for (i = 0; i < idx; i++, page++) {
 		__free_pages_bootmem(page, 0);
+		count++;
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
@@ -357,64 +367,72 @@ static unsigned long __init free_all_boo
 	return total;
 }
 
-unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
+unsigned long __init init_bootmem_node(pg_data_t *pgdat, unsigned long freepfn,
+				unsigned long startpfn, unsigned long endpfn)
 {
-	return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
+	return init_bootmem_core(pgdat, freepfn, startpfn, endpfn);
 }
 
-void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
+				 unsigned long size)
 {
 	reserve_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
+			      unsigned long size)
 {
 	free_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-unsigned long __init free_all_bootmem_node (pg_data_t *pgdat)
+unsigned long __init free_all_bootmem_node(pg_data_t *pgdat)
 {
-	return(free_all_bootmem_core(pgdat));
+	return free_all_bootmem_core(pgdat);
 }
 
-unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
+unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
 {
 	max_low_pfn = pages;
 	min_low_pfn = start;
-	return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
+	return init_bootmem_core(NODE_DATA(0), start, 0, pages);
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
-	return(free_all_bootmem_core(NODE_DATA(0)));
+	return free_all_bootmem_core(NODE_DATA(0));
 }
 
-void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align,
+				      unsigned long goal)
 {
 	bootmem_data_t *bdata;
 	void *ptr;
 
-	list_for_each_entry(bdata, &bdata_list, list)
-		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 0)))
-			return(ptr);
+	list_for_each_entry(bdata, &bdata_list, list) {
+		ptr = __alloc_bootmem_core(bdata, size, align, goal, 0);
+		if (ptr)
+			return ptr;
+	}
 	return NULL;
 }
 
-void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem(unsigned long size, unsigned long align,
+			      unsigned long goal)
 {
 	void *mem = __alloc_bootmem_nopanic(size,align,goal);
+
 	if (mem)
 		return mem;
 	/*
@@ -426,8 +444,8 @@ void * __init __alloc_bootmem(unsigned l
 }
 
 
-void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size, unsigned long align,
-				   unsigned long goal)
+void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
+				   unsigned long align, unsigned long goal)
 {
 	void *ptr;
 
@@ -440,16 +458,17 @@ void * __init __alloc_bootmem_node(pg_da
 
 #define LOW32LIMIT 0xffffffff
 
-void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
+				  unsigned long goal)
 {
 	bootmem_data_t *bdata;
 	void *ptr;
 
-	list_for_each_entry(bdata, &bdata_list, list)
-		if ((ptr = __alloc_bootmem_core(bdata, size,
-						 align, goal, LOW32LIMIT)))
-			return(ptr);
-
+	list_for_each_entry(bdata, &bdata_list, list) {
+		ptr = __alloc_bootmem_core(bdata, size, align, goal, LOW32LIMIT);
+		if (ptr)
+			return ptr;
+	}
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
 	 */
-- 
1.4.0.g64e8

