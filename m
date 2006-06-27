Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWF0MuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWF0MuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWF0MuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:50:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932484AbWF0MuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:50:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=UCKicAOdIx/KJvU5Y1l94oudoapuhg3R65rIM/1BppmslpgbGcbol98i4Xj04206QJC4Tu/+DK5yD+eC8pl6VqOKflGxFN0n8TCU/cWdvxFxWIVCKiYqo6mAB45MT/r7VWgOFVnJ69AHVjaTSYO/WuYSzsR9sA2yeuhn95yPpP0=
Message-ID: <44A12A91.5030704@innova-card.com>
Date: Tue, 27 Jun 2006 14:54:41 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] bootmem: miscellaneous coding style fixes
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/bootmem.h |   29 +++++++++-------
 mm/bootmem.c            |   84 ++++++++++++++++++++++++++---------------------
 2 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index fe48c5e..a532d00 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -38,13 +38,13 @@ typedef struct bootmem_data {
 	struct list_head list;
 } bootmem_data_t;
 
-extern unsigned long bootmem_bootmap_pages (unsigned long);
-extern unsigned long init_bootmem (unsigned long addr, unsigned long memend);
-extern void free_bootmem (unsigned long addr, unsigned long size);
-extern void * __alloc_bootmem (unsigned long size,
+extern unsigned long bootmem_bootmap_pages(unsigned long);
+extern unsigned long init_bootmem(unsigned long addr, unsigned long memend);
+extern void free_bootmem(unsigned long addr, unsigned long size);
+extern void * __alloc_bootmem(unsigned long size,
 			       unsigned long align,
 			       unsigned long goal);
-extern void * __alloc_bootmem_nopanic (unsigned long size,
+extern void * __alloc_bootmem_nopanic(unsigned long size,
 				       unsigned long align,
 				       unsigned long goal);
 extern void * __alloc_bootmem_low(unsigned long size,
@@ -59,8 +59,9 @@ extern void * __alloc_bootmem_core(struc
 				   unsigned long align,
 				   unsigned long goal,
 				   unsigned long limit);
+
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
-extern void reserve_bootmem (unsigned long addr, unsigned long size);
+extern void reserve_bootmem(unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
 	__alloc_bootmem(x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
@@ -70,22 +71,24 @@ #define alloc_bootmem_pages(x) \
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_low(x, PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
-extern unsigned long free_all_bootmem (void);
-extern void * __alloc_bootmem_node (pg_data_t *pgdat,
+
+extern unsigned long free_all_bootmem(void);
+extern unsigned long free_all_bootmem_node(pg_data_t *pgdat);
+extern void * __alloc_bootmem_node(pg_data_t *pgdat,
 				    unsigned long size,
 				    unsigned long align,
 				    unsigned long goal);
-extern unsigned long init_bootmem_node (pg_data_t *pgdat,
+extern unsigned long init_bootmem_node(pg_data_t *pgdat,
 					unsigned long freepfn,
 					unsigned long startpfn,
 					unsigned long endpfn);
-extern void reserve_bootmem_node (pg_data_t *pgdat,
+extern void reserve_bootmem_node(pg_data_t *pgdat,
 				  unsigned long physaddr,
 				  unsigned long size);
-extern void free_bootmem_node (pg_data_t *pgdat,
+extern void free_bootmem_node(pg_data_t *pgdat,
 			       unsigned long addr,
 			       unsigned long size);
-extern unsigned long free_all_bootmem_node (pg_data_t *pgdat);
+
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node(pgdat, x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
@@ -102,7 +105,7 @@ static inline void *alloc_remap(int nid,
 {
 	return NULL;
 }
-#endif
+#endif /* CONFIG_HAVE_ARCH_ALLOC_REMAP */
 
 extern unsigned long nr_kernel_pages;
 extern unsigned long nr_all_pages;
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 3368a14..0956c18 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -40,7 +40,7 @@ unsigned long saved_max_pfn;
 #endif
 
 /* return the number of _pages_ that will be allocated for the boot bitmap */
-unsigned long __init bootmem_bootmap_pages (unsigned long pages)
+unsigned long __init bootmem_bootmap_pages(unsigned long pages)
 {
 	unsigned long mapsize;
 
@@ -50,12 +50,14 @@ unsigned long __init bootmem_bootmap_pag
 
 	return mapsize;
 }
+
 /*
  * link bdata in order
  */
 static void __init link_bootmem(bootmem_data_t *bdata)
 {
 	bootmem_data_t *ent;
+
 	if (list_empty(&bdata_list)) {
 		list_add(&bdata->list, &bdata_list);
 		return;
@@ -68,7 +70,6 @@ static void __init link_bootmem(bootmem_
 		}
 	}
 	list_add_tail(&bdata->list, &bdata_list);
-	return;
 }
 
 /*
@@ -87,7 +88,7 @@ static unsigned long __init get_mapsize(
 /*
  * Called once to set up the allocator itself.
  */
-static unsigned long __init init_bootmem_core (pg_data_t *pgdat,
+static unsigned long __init init_bootmem_core(pg_data_t *pgdat,
 	unsigned long mapstart, unsigned long start, unsigned long end)
 {
 	bootmem_data_t *bdata = pgdat->bdata;
@@ -184,10 +185,10 @@ __alloc_bootmem_core(struct bootmem_data
 	      unsigned long align, unsigned long goal, unsigned long limit)
 {
 	unsigned long offset, remaining_size, areasize, preferred;
-	unsigned long i, start = 0, incr, eidx, end_pfn;
+	unsigned long i, start, incr, eidx, end_pfn;
 	void *ret;
 
-	if(!size) {
+	if (!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
 		BUG();
 	}
@@ -224,6 +225,7 @@ __alloc_bootmem_core(struct bootmem_data
 	areasize = (size + PAGE_SIZE-1) / PAGE_SIZE;
 	incr = align >> PAGE_SHIFT ? : 1;
 
+	start = 0;
 restart_scan:
 	for (i = preferred; i < eidx; i += incr) {
 		unsigned long j;
@@ -236,7 +238,7 @@ restart_scan:
 		for (j = i + 1; j < i + areasize; ++j) {
 			if (j >= eidx)
 				goto fail_block;
-			if (test_bit (j, bdata->node_bootmem_map))
+			if (test_bit(j, bdata->node_bootmem_map))
 				goto fail_block;
 		}
 		start = i;
@@ -264,19 +266,21 @@ found:
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
@@ -289,7 +293,7 @@ found:
 	/*
 	 * Reserve the area now:
 	 */
-	for (i = start; i < start+areasize; i++)
+	for (i = start; i < start + areasize; i++)
 		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
 			BUG();
 	memset(ret, 0, size);
@@ -340,7 +344,7 @@ static unsigned long __init free_all_boo
 				}
 			}
 		} else {
-			i+=BITS_PER_LONG;
+			i += BITS_PER_LONG;
 		}
 		pfn += BITS_PER_LONG;
 	}
@@ -363,51 +367,51 @@ static unsigned long __init free_all_boo
 	return total;
 }
 
-unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn,
+unsigned long __init init_bootmem_node(pg_data_t *pgdat, unsigned long freepfn,
 				unsigned long startpfn, unsigned long endpfn)
 {
-	return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
+	return init_bootmem_core(pgdat, freepfn, startpfn, endpfn);
 }
 
-void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr,
-				  unsigned long size)
+void __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
+				 unsigned long size)
 {
 	reserve_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr,
-			       unsigned long size)
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
 
 void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align,
@@ -416,9 +420,11 @@ void * __init __alloc_bootmem_nopanic(un
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
 
@@ -426,6 +432,7 @@ void * __init __alloc_bootmem(unsigned l
 			      unsigned long goal)
 {
 	void *mem = __alloc_bootmem_nopanic(size,align,goal);
+
 	if (mem)
 		return mem;
 	/*
@@ -444,7 +451,7 @@ void * __init __alloc_bootmem_node(pg_da
 
 	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
 	if (ptr)
-		return (ptr);
+		return ptr;
 
 	return __alloc_bootmem(size, align, goal);
 }
@@ -457,10 +464,11 @@ void * __init __alloc_bootmem_low(unsign
 	bootmem_data_t *bdata;
 	void *ptr;
 
-	list_for_each_entry(bdata, &bdata_list, list)
-		if ((ptr = __alloc_bootmem_core(bdata, size,
-						 align, goal, LOW32LIMIT)))
-			return(ptr);
+	list_for_each_entry(bdata, &bdata_list, list) {
+		ptr = __alloc_bootmem_core(bdata, size, align, goal, LOW32LIMIT);
+		if (ptr)
+			return ptr;
+	}
 
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
-- 
1.4.0.g64e8




