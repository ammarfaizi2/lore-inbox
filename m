Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSJDQjb>; Fri, 4 Oct 2002 12:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSJDQjb>; Fri, 4 Oct 2002 12:39:31 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:50048 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262469AbSJDQjW>;
	Fri, 4 Oct 2002 12:39:22 -0400
Message-ID: <3D9DC57E.3010809@colorfullife.com>
Date: Fri, 04 Oct 2002 18:44:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-01-rename
Content-Type: multipart/mixed;
 boundary="------------050804040407040301000406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050804040407040301000406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

attached is the first piece from my slab patch:
remove kmem_ from all static function that are only used in slab.c.
Except kmem_cache_slabmgmt, I've renamed it to alloc_slabmgmt().

Patch against 2.5.40, afaics -mm1 doesn't contain any changes in slab.c

Please apply.

--
	Manfred


--------------050804040407040301000406
Content-Type: text/plain;
 name="patch-slab-split-01-rename"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-01-rename"

--- 2.5/mm/slab.c	Fri Oct  4 07:27:15 2002
+++ build-2.5/mm/slab.c	Fri Oct  4 17:57:23 2002
@@ -101,7 +101,7 @@
 #endif
 
 /*
- * Parameters for kmem_cache_reap
+ * Parameters for cache_reap
  */
 #define REAP_SCANLEN	10
 #define REAP_PERFECT	10
@@ -144,7 +144,7 @@
 typedef unsigned int kmem_bufctl_t;
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.
- * Needed to avoid a possible looping condition in kmem_cache_grow().
+ * Needed to avoid a possible looping condition in cache_grow().
  */
 static unsigned long offslab_limit;
 
@@ -414,7 +414,7 @@
 #endif
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void kmem_cache_estimate (unsigned long gfporder, size_t size,
+static void cache_estimate (unsigned long gfporder, size_t size,
 		 int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
@@ -449,7 +449,7 @@
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
 
-	kmem_cache_estimate(0, cache_cache.objsize, 0,
+	cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
@@ -499,7 +499,7 @@
 	} while (sizes->cs_size);
 }
 
-int __init kmem_cpucache_init(void)
+int __init cpucache_init(void)
 {
 #ifdef CONFIG_SMP
 	g_cpucache_up = 1;
@@ -508,7 +508,7 @@
 	return 0;
 }
 
-__initcall(kmem_cpucache_init);
+__initcall(cpucache_init);
 
 /* Interface to system's page allocator. No need to hold the cache-lock.
  */
@@ -552,7 +552,7 @@
 }
 
 #if DEBUG
-static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
+static inline void poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -563,7 +563,7 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
+static inline int check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;
@@ -582,7 +582,7 @@
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
-static void kmem_slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
+static void slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
 {
 	if (cachep->dtor
 #if DEBUG
@@ -609,7 +609,7 @@
 				objp -= BYTES_PER_WORD;
 			}	
 			if ((cachep->flags & SLAB_POISON)  &&
-				kmem_check_poison_obj(cachep, objp))
+				check_poison_obj(cachep, objp))
 				BUG();
 #endif
 		}
@@ -759,7 +759,7 @@
 	do {
 		unsigned int break_flag = 0;
 cal_wastage:
-		kmem_cache_estimate(cachep->gfporder, size, flags,
+		cache_estimate(cachep->gfporder, size, flags,
 						&left_over, &cachep->num);
 		if (break_flag)
 			break;
@@ -879,7 +879,7 @@
  * This check if the kmem_cache_t pointer is chained in the cache_cache
  * list. -arca
  */
-static int is_chained_kmem_cache(kmem_cache_t * cachep)
+static int is_chained_cache(kmem_cache_t * cachep)
 {
 	struct list_head *p;
 	int ret = 0;
@@ -897,7 +897,7 @@
 	return ret;
 }
 #else
-#define is_chained_kmem_cache(x) 1
+#define is_chained_cache(x) 1
 #endif
 
 #ifdef CONFIG_SMP
@@ -959,7 +959,7 @@
 #define drain_cpu_caches(cachep)	do { } while (0)
 #endif
 
-static int __kmem_cache_shrink(kmem_cache_t *cachep)
+static int __cache_shrink(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
 	int ret;
@@ -984,7 +984,7 @@
 		list_del(&slabp->list);
 
 		spin_unlock_irq(&cachep->spinlock);
-		kmem_slab_destroy(cachep, slabp);
+		slab_destroy(cachep, slabp);
 		spin_lock_irq(&cachep->spinlock);
 	}
 	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
@@ -1001,10 +1001,10 @@
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	if (!cachep || in_interrupt() || !is_chained_kmem_cache(cachep))
+	if (!cachep || in_interrupt() || !is_chained_cache(cachep))
 		BUG();
 
-	return __kmem_cache_shrink(cachep);
+	return __cache_shrink(cachep);
 }
 
 /**
@@ -1036,7 +1036,7 @@
 	list_del(&cachep->next);
 	up(&cache_chain_sem);
 
-	if (__kmem_cache_shrink(cachep)) {
+	if (__cache_shrink(cachep)) {
 		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
 		       cachep);
 		down(&cache_chain_sem);
@@ -1057,7 +1057,7 @@
 }
 
 /* Get the memory for a slab management obj. */
-static inline slab_t * kmem_cache_slabmgmt (kmem_cache_t *cachep,
+static inline slab_t * alloc_slabmgmt (kmem_cache_t *cachep,
 			void *objp, int colour_off, int local_flags)
 {
 	slab_t *slabp;
@@ -1083,7 +1083,7 @@
 	return slabp;
 }
 
-static inline void kmem_cache_init_objs (kmem_cache_t * cachep,
+static inline void cache_init_objs (kmem_cache_t * cachep,
 			slab_t * slabp, unsigned long ctor_flags)
 {
 	int i;
@@ -1111,7 +1111,7 @@
 			objp -= BYTES_PER_WORD;
 		if (cachep->flags & SLAB_POISON)
 			/* need to poison the objs */
-			kmem_poison_obj(cachep, objp);
+			poison_obj(cachep, objp);
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*((unsigned long*)(objp)) != RED_MAGIC1)
 				BUG();
@@ -1130,7 +1130,7 @@
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int kmem_cache_grow (kmem_cache_t * cachep, int flags)
+static int cache_grow (kmem_cache_t * cachep, int flags)
 {
 	slab_t	*slabp;
 	struct page	*page;
@@ -1185,7 +1185,7 @@
 	 * held, but the incrementing c_growing prevents this
 	 * cache from being reaped or shrunk.
 	 * Note: The cache could be selected in for reaping in
-	 * kmem_cache_reap(), but when the final test is made the
+	 * cache_reap(), but when the final test is made the
 	 * growing value will be seen.
 	 */
 
@@ -1194,7 +1194,7 @@
 		goto failed;
 
 	/* Get slab management. */
-	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
+	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
 
 	/* Nasty!!!!!! I hope this is OK. */
@@ -1208,7 +1208,7 @@
 		page++;
 	} while (--i);
 
-	kmem_cache_init_objs(cachep, slabp, ctor_flags);
+	cache_init_objs(cachep, slabp, ctor_flags);
 
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
 	cachep->growing--;
@@ -1237,7 +1237,7 @@
  */
 
 #if DEBUG
-static int kmem_extra_free_checks (kmem_cache_t * cachep,
+static int extra_free_checks (kmem_cache_t * cachep,
 			slab_t *slabp, void * objp)
 {
 	int i;
@@ -1257,7 +1257,7 @@
 }
 #endif
 
-static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
+static inline void cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
@@ -1268,7 +1268,7 @@
 	}
 }
 
-static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
+static inline void * cache_alloc_one_tail (kmem_cache_t *cachep,
 						slab_t *slabp)
 {
 	void *objp;
@@ -1288,7 +1288,7 @@
 	}
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
-		if (kmem_check_poison_obj(cachep, objp))
+		if (check_poison_obj(cachep, objp))
 			BUG();
 	if (cachep->flags & SLAB_RED_ZONE) {
 		/* Set alloc red-zone, and check old one. */
@@ -1309,7 +1309,7 @@
  * caller must guarantee synchronization
  * #define for the goto optimization 8-)
  */
-#define kmem_cache_alloc_one(cachep)				\
+#define cache_alloc_one(cachep)				\
 ({								\
 	struct list_head * slabs_partial, * entry;		\
 	slab_t *slabp;						\
@@ -1327,11 +1327,11 @@
 	}							\
 								\
 	slabp = list_entry(entry, slab_t, list);		\
-	kmem_cache_alloc_one_tail(cachep, slabp);		\
+	cache_alloc_one_tail(cachep, slabp);		\
 })
 
 #ifdef CONFIG_SMP
-void* kmem_cache_alloc_batch(kmem_cache_t* cachep, int flags)
+void* cache_alloc_batch(kmem_cache_t* cachep, int flags)
 {
 	int batchcount = cachep->batchcount;
 	cpucache_t* cc = cc_data(cachep);
@@ -1355,7 +1355,7 @@
 
 		slabp = list_entry(entry, slab_t, list);
 		cc_entry(cc)[cc->avail++] =
-				kmem_cache_alloc_one_tail(cachep, slabp);
+				cache_alloc_one_tail(cachep, slabp);
 	}
 	spin_unlock(&cachep->spinlock);
 
@@ -1365,7 +1365,7 @@
 }
 #endif
 
-static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
+static inline void * __cache_alloc (kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
 	void* objp;
@@ -1373,7 +1373,7 @@
 	if (flags & __GFP_WAIT)
 		might_sleep();
 
-	kmem_cache_alloc_head(cachep, flags);
+	cache_alloc_head(cachep, flags);
 try_again:
 	local_irq_save(save_flags);
 #ifdef CONFIG_SMP
@@ -1386,7 +1386,7 @@
 				objp = cc_entry(cc)[--cc->avail];
 			} else {
 				STATS_INC_ALLOCMISS(cachep);
-				objp = kmem_cache_alloc_batch(cachep,flags);
+				objp = cache_alloc_batch(cachep,flags);
 				local_irq_restore(save_flags);
 				if (!objp)
 					goto alloc_new_slab_nolock;
@@ -1394,12 +1394,12 @@
 			}
 		} else {
 			spin_lock(&cachep->spinlock);
-			objp = kmem_cache_alloc_one(cachep);
+			objp = cache_alloc_one(cachep);
 			spin_unlock(&cachep->spinlock);
 		}
 	}
 #else
-	objp = kmem_cache_alloc_one(cachep);
+	objp = cache_alloc_one(cachep);
 #endif
 	local_irq_restore(save_flags);
 	return objp;
@@ -1411,7 +1411,7 @@
 #ifdef CONFIG_SMP
 alloc_new_slab_nolock:
 #endif
-	if (kmem_cache_grow(cachep, flags))
+	if (cache_grow(cachep, flags))
 		/* Someone may have stolen our objs.  Doesn't matter, we'll
 		 * just come back here again.
 		 */
@@ -1449,7 +1449,7 @@
 # define CHECK_PAGE(pg)	do { } while (0)
 #endif
 
-static inline void kmem_cache_free_one(kmem_cache_t *cachep, void *objp)
+static inline void cache_free_one(kmem_cache_t *cachep, void *objp)
 {
 	slab_t* slabp;
 
@@ -1481,8 +1481,8 @@
 			BUG();
 	}
 	if (cachep->flags & SLAB_POISON)
-		kmem_poison_obj(cachep, objp);
-	if (kmem_extra_free_checks(cachep, slabp, objp))
+		poison_obj(cachep, objp);
+	if (extra_free_checks(cachep, slabp, objp))
 		return;
 #endif
 	{
@@ -1503,7 +1503,7 @@
 			if (list_empty(&cachep->slabs_free))
 				list_add(&slabp->list, &cachep->slabs_free);
 			else
-				kmem_slab_destroy(cachep, slabp);
+				slab_destroy(cachep, slabp);
 		} else if (unlikely(inuse == cachep->num)) {
 			/* Was full. */
 			list_del(&slabp->list);
@@ -1517,7 +1517,7 @@
 							void** objpp, int len)
 {
 	for ( ; len > 0; len--, objpp++)
-		kmem_cache_free_one(cachep, *objpp);
+		cache_free_one(cachep, *objpp);
 }
 
 static void free_block (kmem_cache_t* cachep, void** objpp, int len)
@@ -1529,10 +1529,10 @@
 #endif
 
 /*
- * __kmem_cache_free
+ * __cache_free
  * called with disabled ints
  */
-static inline void __kmem_cache_free (kmem_cache_t *cachep, void* objp)
+static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
 #ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
@@ -1555,7 +1555,7 @@
 		free_block(cachep, &objp, 1);
 	}
 #else
-	kmem_cache_free_one(cachep, objp);
+	cache_free_one(cachep, objp);
 #endif
 }
 
@@ -1569,7 +1569,7 @@
  */
 void * kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
-	return __kmem_cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags);
 }
 
 /**
@@ -1600,7 +1600,7 @@
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
+		return __cache_alloc(flags & GFP_DMA ?
 			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
 	}
 	return NULL;
@@ -1624,7 +1624,7 @@
 #endif
 
 	local_irq_save(flags);
-	__kmem_cache_free(cachep, objp);
+	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
 
@@ -1645,7 +1645,7 @@
 	local_irq_save(flags);
 	CHECK_PAGE(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
-	__kmem_cache_free(c, (void*)objp);
+	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }
 
@@ -1677,7 +1677,7 @@
 #ifdef CONFIG_SMP
 
 /* called with cache_chain_sem acquired.  */
-static int kmem_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
+static int tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
 {
 	ccupdate_struct_t new;
 	int i;
@@ -1749,7 +1749,7 @@
 	else
 		limit = 252;
 
-	err = kmem_tune_cpucache(cachep, limit, limit/2);
+	err = tune_cpucache(cachep, limit, limit/2);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
 					cachep->name, -err);
@@ -1775,12 +1775,12 @@
 #endif
 
 /**
- * kmem_cache_reap - Reclaim memory from caches.
+ * cache_reap - Reclaim memory from caches.
  * @gfp_mask: the type of memory required.
  *
  * Called from do_try_to_free_pages() and __alloc_pages()
  */
-int kmem_cache_reap (int gfp_mask)
+int cache_reap (int gfp_mask)
 {
 	slab_t *slabp;
 	kmem_cache_t *searchp;
@@ -1894,7 +1894,7 @@
 		 * cache.
 		 */
 		spin_unlock_irq(&best_cachep->spinlock);
-		kmem_slab_destroy(best_cachep, slabp);
+		slab_destroy(best_cachep, slabp);
 		spin_lock_irq(&best_cachep->spinlock);
 	}
 	spin_unlock_irq(&best_cachep->spinlock);
@@ -2105,7 +2105,7 @@
 		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
 
 		if (!strcmp(cachep->name, kbuf)) {
-			res = kmem_tune_cpucache(cachep, limit, batchcount);
+			res = tune_cpucache(cachep, limit, batchcount);
 			break;
 		}
 	}


--------------050804040407040301000406--


