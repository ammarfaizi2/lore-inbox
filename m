Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWGDPlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWGDPlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWGDPlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:41:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13116 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932177AbWGDPlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:41:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=YJkoYx1nBFHk82OwjabXwXgLC6dJWy4rOmOBhtM9xlIZrXApe4vEWZob/xMAVJvuJQjhd5tT5FJto/iXk9+2alSCgTNvRGdtvf7UhakW3/78FCARcDzwGrZHvIs3c3yGVk2o1n5qx2Cc8EW2K96UDN+Lkk1zez7DnJnfiDFxO5c=
Message-ID: <44AA8D4B.5010900@innova-card.com>
Date: Tue, 04 Jul 2006 17:46:19 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Franck <vagabon.xyz@gmail.com>
Subject: [PATCH 7/7] bootmem: miscellaneous coding style fixes
References: <44AA89D2.8010307@innova-card.com>
In-Reply-To: <44AA89D2.8010307@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes various coding style issues, specially when spaces
are useless. For example '*' go next to the function name.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>

---
 include/linux/bootmem.h |   95 ++++++++++++++++++++++++-----------------------
 mm/bootmem.c            |   81 ++++++++++++++++++++++------------------
 2 files changed, 93 insertions(+), 83 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index fe48c5e..dadc865 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -38,29 +38,30 @@ typedef struct bootmem_data {
 	struct list_head list;
 } bootmem_data_t;
 
-extern unsigned long bootmem_bootmap_pages (unsigned long);
-extern unsigned long init_bootmem (unsigned long addr, unsigned long memend);
-extern void free_bootmem (unsigned long addr, unsigned long size);
-extern void * __alloc_bootmem (unsigned long size,
-			       unsigned long align,
-			       unsigned long goal);
-extern void * __alloc_bootmem_nopanic (unsigned long size,
-				       unsigned long align,
-				       unsigned long goal);
-extern void * __alloc_bootmem_low(unsigned long size,
+extern unsigned long bootmem_bootmap_pages(unsigned long);
+extern unsigned long init_bootmem(unsigned long addr, unsigned long memend);
+extern void free_bootmem(unsigned long addr, unsigned long size);
+extern void *__alloc_bootmem(unsigned long size,
+			     unsigned long align,
+			     unsigned long goal);
+extern void *__alloc_bootmem_nopanic(unsigned long size,
+				     unsigned long align,
+				     unsigned long goal);
+extern void *__alloc_bootmem_low(unsigned long size,
+				 unsigned long align,
+				 unsigned long goal);
+extern void *__alloc_bootmem_low_node(pg_data_t *pgdat,
+				      unsigned long size,
+				      unsigned long align,
+				      unsigned long goal);
+extern void *__alloc_bootmem_core(struct bootmem_data *bdata,
+				  unsigned long size,
 				  unsigned long align,
-				  unsigned long goal);
-extern void * __alloc_bootmem_low_node(pg_data_t *pgdat,
-				       unsigned long size,
-				       unsigned long align,
-				       unsigned long goal);
-extern void * __alloc_bootmem_core(struct bootmem_data *bdata,
-				   unsigned long size,
-				   unsigned long align,
-				   unsigned long goal,
-				   unsigned long limit);
+				  unsigned long goal,
+				  unsigned long limit);
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
-				    unsigned long size,
-				    unsigned long align,
-				    unsigned long goal);
-extern unsigned long init_bootmem_node (pg_data_t *pgdat,
-					unsigned long freepfn,
-					unsigned long startpfn,
-					unsigned long endpfn);
-extern void reserve_bootmem_node (pg_data_t *pgdat,
-				  unsigned long physaddr,
-				  unsigned long size);
-extern void free_bootmem_node (pg_data_t *pgdat,
-			       unsigned long addr,
-			       unsigned long size);
-extern unsigned long free_all_bootmem_node (pg_data_t *pgdat);
+
+extern unsigned long free_all_bootmem(void);
+extern unsigned long free_all_bootmem_node(pg_data_t *pgdat);
+extern void *__alloc_bootmem_node(pg_data_t *pgdat,
+				  unsigned long size,
+				  unsigned long align,
+				  unsigned long goal);
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
 	__alloc_bootmem_node(pgdat, x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
@@ -102,19 +105,19 @@ static inline void *alloc_remap(int nid,
 {
 	return NULL;
 }
-#endif
+#endif /* CONFIG_HAVE_ARCH_ALLOC_REMAP */
 
 extern unsigned long nr_kernel_pages;
 extern unsigned long nr_all_pages;
 
-extern void * alloc_large_system_hash(const char *tablename,
-				      unsigned long bucketsize,
-				      unsigned long numentries,
-				      int scale,
-				      int flags,
-				      unsigned int *_hash_shift,
-				      unsigned int *_hash_mask,
-				      unsigned long limit);
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
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 3368a14..e8cbe99 100644
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
@@ -187,7 +188,7 @@ __alloc_bootmem_core(struct bootmem_data
 	unsigned long i, start = 0, incr, eidx, end_pfn;
 	void *ret;
 
-	if(!size) {
+	if (!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
 		BUG();
 	}
@@ -236,7 +237,7 @@ restart_scan:
 		for (j = i + 1; j < i + areasize; ++j) {
 			if (j >= eidx)
 				goto fail_block;
-			if (test_bit (j, bdata->node_bootmem_map))
+			if (test_bit(j, bdata->node_bootmem_map))
 				goto fail_block;
 		}
 		start = i;
@@ -264,19 +265,21 @@ found:
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
@@ -289,7 +292,7 @@ found:
 	/*
 	 * Reserve the area now:
 	 */
-	for (i = start; i < start+areasize; i++)
+	for (i = start; i < start + areasize; i++)
 		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
 			BUG();
 	memset(ret, 0, size);
@@ -340,7 +343,7 @@ static unsigned long __init free_all_boo
 				}
 			}
 		} else {
-			i+=BITS_PER_LONG;
+			i += BITS_PER_LONG;
 		}
 		pfn += BITS_PER_LONG;
 	}
@@ -363,51 +366,51 @@ static unsigned long __init free_all_boo
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
@@ -416,9 +419,11 @@ void * __init __alloc_bootmem_nopanic(un
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
 
@@ -426,6 +431,7 @@ void * __init __alloc_bootmem(unsigned l
 			      unsigned long goal)
 {
 	void *mem = __alloc_bootmem_nopanic(size,align,goal);
+
 	if (mem)
 		return mem;
 	/*
@@ -444,7 +450,7 @@ void * __init __alloc_bootmem_node(pg_da
 
 	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
 	if (ptr)
-		return (ptr);
+		return ptr;
 
 	return __alloc_bootmem(size, align, goal);
 }
@@ -457,10 +463,11 @@ void * __init __alloc_bootmem_low(unsign
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
1.4.1.g35c6

