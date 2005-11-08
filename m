Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVKHAsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVKHAsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965652AbVKHAsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:48:22 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44228 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965651AbVKHAsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:48:20 -0500
Message-ID: <436FF5CF.6090507@us.ibm.com>
Date: Mon, 07 Nov 2005 16:48:15 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] Apply CodingStyle to mm/slab.c
References: <436FF51D.8080509@us.ibm.com>
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010404000307060903090903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404000307060903090903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pretty self-explanatory.  Whitespace cleanps, comment fixes,
spelling/typos, etc.

mcd@arrakis:~/linux/source/linux-2.6.14+slab_cleanup/patches $ diffstat
CodingStyle-slab_c.patch
 slab.c |  653
+++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 338 insertions(+), 315 deletions(-)


-Matt

--------------010404000307060903090903
Content-Type: text/x-patch;
 name="CodingStyle-slab_c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CodingStyle-slab_c.patch"

Before doing any functional/structural cleanups, fix a bunch of comments,
whitespace and general CodingStyle issues.

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-07 15:58:06.022235912 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-07 15:58:42.336715272 -0800
@@ -119,7 +119,6 @@
  *
  * FORCED_DEBUG	- 1 enables SLAB_RED_ZONE and SLAB_POISON (if possible)
  */
-
 #ifdef CONFIG_DEBUG_SLAB
 #define	DEBUG		1
 #define	STATS		1
@@ -180,7 +179,7 @@
 			 SLAB_DESTROY_BY_RCU)
 #endif
 
-/*
+/**
  * kmem_bufctl_t:
  *
  * Bufctl's are used for linking objs within a slab
@@ -198,13 +197,13 @@
  * Note: This limit can be raised by introducing a general cache whose size
  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
  */
-
 typedef unsigned int kmem_bufctl_t;
 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
 #define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
-#define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
+#define SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
 
-/* Max number of objs-per-slab for caches which use off-slab slabs.
+/*
+ * Max number of objs-per-slab for caches which use off-slab slabs.
  * Needed to avoid a possible looping condition in cache_grow().
  */
 static unsigned long offslab_limit;
@@ -273,7 +272,8 @@ struct array_cache {
 				 */
 };
 
-/* bootstrap: The caches do not work without cpuarrays anymore,
+/*
+ * bootstrap: The caches do not work without cpuarrays anymore,
  * but the cpuarrays are allocated from the generic caches...
  */
 #define BOOT_CPUCACHE_ENTRIES	1
@@ -301,11 +301,11 @@ struct kmem_list3 {
 /*
  * Need this for bootstrapping a per node allocator.
  */
-#define NUM_INIT_LISTS (2 * MAX_NUMNODES + 1)
+#define NUM_INIT_LISTS	(2 * MAX_NUMNODES + 1)
 struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
-#define	CACHE_CACHE 0
-#define	SIZE_AC 1
-#define	SIZE_L3 (1 + MAX_NUMNODES)
+#define	CACHE_CACHE	0
+#define	SIZE_AC		1
+#define	SIZE_L3		(1 + MAX_NUMNODES)
 
 /*
  * This function must be completely optimized away if
@@ -318,10 +318,10 @@ static __always_inline int index_of(cons
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 
-#define CACHE(x) \
-	if (size <=x) \
-		return i; \
-	else \
+#define CACHE(x)		\
+	if (size <= x)		\
+		return i;	\
+	else			\
 		i++;
 #include "linux/kmalloc_sizes.h"
 #undef CACHE
@@ -349,16 +349,16 @@ static inline void kmem_list3_init(struc
 	parent->free_touched = 0;
 }
 
-#define MAKE_LIST(cachep, listp, slab, nodeid)	\
-	do {	\
-		INIT_LIST_HEAD(listp);		\
-		list_splice(&(cachep->nodelists[nodeid]->slab), listp); \
+#define MAKE_LIST(cachep, listp, slab, nodeid)				\
+	do {								\
+		INIT_LIST_HEAD(listp);					\
+		list_splice(&(cachep->nodelists[nodeid]->slab), listp);	\
 	} while (0)
 
-#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)			\
-	do {					\
+#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)				\
+	do {								\
 	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
-	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
+	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid);\
 	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
 	} while (0)
 
@@ -367,7 +367,6 @@ static inline void kmem_list3_init(struc
  *
  * manages a cache.
  */
-	
 struct kmem_cache_s {
 /* 1) per-cpu data, touched during every alloc/free */
 	struct array_cache	*array[NR_CPUS];
@@ -428,10 +427,11 @@ struct kmem_cache_s {
 };
 
 #define CFLGS_OFF_SLAB		(0x80000000UL)
-#define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
+#define OFF_SLAB(x)		((x)->flags & CFLGS_OFF_SLAB)
 
 #define BATCHREFILL_LIMIT	16
-/* Optimization question: fewer reaps means less 
+/*
+ * Optimization question: fewer reaps means less 
  * probability for unnessary cpucache drain/refill cycles.
  *
  * OTHO the cpuarrays can contain lots of objects,
@@ -447,14 +447,13 @@ struct kmem_cache_s {
 #define	STATS_INC_GROWN(x)	((x)->grown++)
 #define	STATS_INC_REAPED(x)	((x)->reaped++)
 #define	STATS_SET_HIGH(x)	do { if ((x)->num_active > (x)->high_mark) \
-					(x)->high_mark = (x)->num_active; \
+					(x)->high_mark = (x)->num_active;  \
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
 #define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
 #define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
-#define	STATS_SET_FREEABLE(x, i) \
-				do { if ((x)->max_freeable < i) \
-					(x)->max_freeable = i; \
+#define	STATS_SET_FREEABLE(x,i)	do { if ((x)->max_freeable < i)	\
+					(x)->max_freeable = i;	\
 				} while (0)
 
 #define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
@@ -471,9 +470,7 @@ struct kmem_cache_s {
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
 #define	STATS_INC_NODEFREES(x)	do { } while (0)
-#define	STATS_SET_FREEABLE(x, i) \
-				do { } while (0)
-
+#define	STATS_SET_FREEABLE(x,i)	do { } while (0)
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
 #define STATS_INC_FREEHIT(x)	do { } while (0)
@@ -481,7 +478,8 @@ struct kmem_cache_s {
 #endif
 
 #if DEBUG
-/* Magic nums for obj red zoning.
+/*
+ * Magic nums for obj red zoning.
  * Placed in the first word before and the first word after an obj.
  */
 #define	RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
@@ -492,7 +490,8 @@ struct kmem_cache_s {
 #define POISON_FREE	0x6b	/* for use-after-free poisoning */
 #define	POISON_END	0xa5	/* end-byte of poisoning */
 
-/* memory layout of objects:
+/*
+ * memory layout of objects:
  * 0		: objp
  * 0 .. cachep->dbghead - BYTES_PER_WORD - 1: padding. This ensures that
  * 		the end of an object is aligned with the end of the real
@@ -530,10 +529,10 @@ static unsigned long *dbg_redzone2(kmem_
 static void **dbg_userword(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
-	return (void**)(objp+cachep->objsize-BYTES_PER_WORD);
+	return (void **)(objp+cachep->objsize-BYTES_PER_WORD);
 }
 
-#else
+#else /* !DEBUG */
 
 #define obj_dbghead(x)			0
 #define obj_reallen(cachep)		(cachep->objsize)
@@ -541,7 +540,7 @@ static void **dbg_userword(kmem_cache_t 
 #define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
 
-#endif
+#endif /* DEBUG */
 
 /*
  * Maximum size of an obj (in 2^order pages)
@@ -565,7 +564,8 @@ static void **dbg_userword(kmem_cache_t 
 #define	BREAK_GFP_ORDER_LO	0
 static int slab_break_gfp_order = BREAK_GFP_ORDER_LO;
 
-/* Macros for storing/retrieving the cachep and or slab from the
+/*
+ * Macros for storing/retrieving the cachep and or slab from the
  * global 'mem_map'. These are used to find the slab an obj belongs to.
  * With kfree(), these are used to find the cache which an obj belongs to.
  */
@@ -574,7 +574,7 @@ static int slab_break_gfp_order = BREAK_
 #define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
 
-/* These are the default caches for kmalloc. Custom caches can have other sizes. */
+/* These are the default kmalloc caches. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
 #include <linux/kmalloc_sizes.h>
@@ -640,7 +640,7 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t* cachep, void** objpp, int len, int node);
+static void free_block(kmem_cache_t *cachep, void **objpp, int len, int node);
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
 static int __node_shrink(kmem_cache_t *cachep, int node);
@@ -655,19 +655,19 @@ static inline kmem_cache_t *__find_gener
 	struct cache_sizes *csizep = malloc_sizes;
 
 #if DEBUG
-	/* This happens if someone tries to call
- 	* kmem_cache_create(), or __kmalloc(), before
- 	* the generic caches are initialized.
- 	*/
+	/*
+	 * This happens if someone calls kmem_cache_create() or __kmalloc()
+	 * before the generic caches are initialized
+	 */
 	BUG_ON(malloc_sizes[INDEX_AC].cs_cachep == NULL);
 #endif
 	while (size > csizep->cs_size)
 		csizep++;
 
 	/*
-	 * Really subtle: The last entry with cs->cs_size==ULONG_MAX
-	 * has cs_{dma,}cachep==NULL. Thus no special case
-	 * for large kmalloc calls required.
+	 * Really subtle: The last entry with cs->cs_size == ULONG_MAX has
+	 * cs_{dma,}cachep == NULL, thus no special case for large kmalloc
+	 * calls is required.
 	 */
 	if (unlikely(gfpflags & GFP_DMA))
 		return csizep->cs_dmacachep;
@@ -680,9 +680,9 @@ kmem_cache_t *kmem_find_general_cachep(s
 }
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
-/* Cal the num objs, wastage, and bytes left over for a given slab size. */
+/* Calculate the num objs, wastage, & bytes left over for a given slab size. */
 static void cache_estimate(unsigned long gfporder, size_t size, size_t align,
-		 int flags, size_t *left_over, unsigned int *num)
+			   int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
 	size_t wastage = PAGE_SIZE<<gfporder;
@@ -718,7 +718,7 @@ static void __slab_error(const char *fun
 }
 
 /*
- * Initiate the reap timer running on the target CPU.  We run at around 1 to 2Hz
+ * Initiate the reap timer running on the target CPU.  We run at around 1-2Hz
  * via the workqueue/eventd.
  * Add the CPU number into the expiration time to minimize the possibility of
  * the CPUs getting into lockstep and contending for the global cache chain
@@ -740,9 +740,9 @@ static void __devinit start_cpu_timer(in
 }
 
 static struct array_cache *alloc_arraycache(int node, int entries,
-						int batchcount)
+					    int batchcount)
 {
-	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
+	int memsize = sizeof(void *) * entries + sizeof(struct array_cache);
 	struct array_cache *nc = NULL;
 
 	nc = kmalloc_node(memsize, GFP_KERNEL, node);
@@ -760,7 +760,7 @@ static struct array_cache *alloc_arrayca
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
 	struct array_cache **ac_ptr;
-	int memsize = sizeof(void*)*MAX_NUMNODES;
+	int memsize = sizeof(void *) * MAX_NUMNODES;
 	int i;
 
 	if (limit > 1)
@@ -797,7 +797,8 @@ static inline void free_alien_cache(stru
 	kfree(ac_ptr);
 }
 
-static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
+static inline void __drain_alien_cache(kmem_cache_t *cachep,
+				       struct array_cache *ac, int node)
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
@@ -825,16 +826,16 @@ static void drain_alien_cache(kmem_cache
 	}
 }
 #else
-#define alloc_alien_cache(node, limit) do { } while (0)
-#define free_alien_cache(ac_ptr) do { } while (0)
-#define drain_alien_cache(cachep, l3) do { } while (0)
+#define alloc_alien_cache(node, limit)	do { } while (0)
+#define free_alien_cache(ac_ptr)	do { } while (0)
+#define drain_alien_cache(cachep, l3)	do { } while (0)
 #endif
 
 static int __devinit cpuup_callback(struct notifier_block *nfb,
-				  unsigned long action, void *hcpu)
+				    unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
-	kmem_cache_t* cachep;
+	kmem_cache_t *cachep;
 	struct kmem_list3 *l3 = NULL;
 	int node = cpu_to_node(cpu);
 	int memsize = sizeof(struct kmem_list3);
@@ -843,14 +844,15 @@ static int __devinit cpuup_callback(stru
 	switch (action) {
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
-		/* we need to do this right in the beginning since
+		/*
+		 * we need to do this right in the beginning since
 		 * alloc_arraycache's are going to use this list.
 		 * kmalloc_node allows us to add the slab to the right
 		 * kmem_list3 and not this cpu's kmem_list3
 		 */
-
 		list_for_each_entry(cachep, &cache_chain, next) {
-			/* setup the size64 kmemlist for cpu before we can
+			/*
+			 * setup the size64 kmemlist for cpu before we can
 			 * begin anything. Make sure some other cpu on this
 			 * node has not already allocated this
 			 */
@@ -872,8 +874,7 @@ static int __devinit cpuup_callback(stru
 			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
 		}
 
-		/* Now we can go ahead with allocating the shared array's
-		  & array cache's */
+		/* Now we can allocate the shared arrays & array caches */
 		list_for_each_entry(cachep, &cache_chain, next) {
 			nc = alloc_arraycache(node, cachep->limit,
 					cachep->batchcount);
@@ -889,8 +890,10 @@ static int __devinit cpuup_callback(stru
 					0xbaadf00d)))
 					goto  bad;
 
-				/* we are serialised from CPU_DEAD or
-				  CPU_UP_CANCELLED by the cpucontrol lock */
+				/*
+				 * we are serialised from CPU_DEAD or
+				 * CPU_UP_CANCELLED by the cpucontrol lock
+				 */
 				l3->shared = nc;
 			}
 		}
@@ -970,8 +973,7 @@ static struct notifier_block cpucache_no
 /*
  * swap the static kmem_list3 with kmalloced memory
  */
-static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list,
-		int nodeid)
+static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list, int nodeid)
 {
 	struct kmem_list3 *ptr;
 
@@ -986,7 +988,8 @@ static void init_list(kmem_cache_t *cach
 	local_irq_enable();
 }
 
-/* Initialisation.
+/*
+ * Initialization.
  * Called after the gfp() functions have been enabled, and before smp_init().
  */
 void __init kmem_cache_init(void)
@@ -1009,7 +1012,8 @@ void __init kmem_cache_init(void)
 	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
 		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
 
-	/* Bootstrap is tricky, because several objects are allocated
+	/*
+	 * Bootstrap is tricky, because several objects are allocated
 	 * from caches that do not exist yet:
 	 * 1) initialize the cache_cache cache: it contains the kmem_cache_t
 	 *    structures of all caches, except cache_cache itself: cache_cache
@@ -1040,7 +1044,7 @@ void __init kmem_cache_init(void)
 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());
 
 	cache_estimate(0, cache_cache.objsize, cache_line_size(), 0,
-				&left_over, &cache_cache.num);
+		       &left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
 
@@ -1053,11 +1057,11 @@ void __init kmem_cache_init(void)
 	sizes = malloc_sizes;
 	names = cache_names;
 
-	/* Initialize the caches that provide memory for the array cache
+	/*
+	 * Initialize the caches that provide memory for the array cache
 	 * and the kmem_list3 structures first.
 	 * Without this, further allocations will bug
 	 */
-
 	sizes[INDEX_AC].cs_cachep = kmem_cache_create(names[INDEX_AC].name,
 				sizes[INDEX_AC].cs_size, ARCH_KMALLOC_MINALIGN,
 				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
@@ -1104,7 +1108,7 @@ void __init kmem_cache_init(void)
 		local_irq_disable();
 		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
 		memcpy(ptr, ac_data(&cache_cache),
-				sizeof(struct arraycache_init));
+		       sizeof(struct arraycache_init));
 		cache_cache.array[smp_processor_id()] = ptr;
 		local_irq_enable();
 
@@ -1114,7 +1118,7 @@ void __init kmem_cache_init(void)
 		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)
 				!= &initarray_generic.cache);
 		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
-				sizeof(struct arraycache_init));
+		       sizeof(struct arraycache_init));
 		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
 						ptr;
 		local_irq_enable();
@@ -1124,17 +1128,15 @@ void __init kmem_cache_init(void)
 		int node;
 		/* Replace the static kmem_list3 structures for the boot cpu */
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
-				numa_node_id());
+			  numa_node_id());
 
 		for_each_online_node(node) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
-					&initkmem_list3[SIZE_AC+node], node);
+				  &initkmem_list3[SIZE_AC+node], node);
 
-			if (INDEX_AC != INDEX_L3) {
+			if (INDEX_AC != INDEX_L3)
 				init_list(malloc_sizes[INDEX_L3].cs_cachep,
-						&initkmem_list3[SIZE_L3+node],
-						node);
-			}
+					  &initkmem_list3[SIZE_L3+node], node);
 		}
 	}
 
@@ -1150,12 +1152,14 @@ void __init kmem_cache_init(void)
 	/* Done! */
 	g_cpucache_up = FULL;
 
-	/* Register a cpu startup notifier callback
+	/*
+	 * Register a cpu startup notifier callback
 	 * that initializes ac_data for all new cpus
 	 */
 	register_cpu_notifier(&cpucache_notifier);
 
-	/* The reap timers are started later, with a module init call:
+	/*
+	 * The reap timers are started later, with a module init call:
 	 * That part of the kernel is not yet operational.
 	 */
 }
@@ -1164,16 +1168,12 @@ static int __init cpucache_init(void)
 {
 	int cpu;
 
-	/* 
-	 * Register the timers that return unneeded
-	 * pages to gfp.
-	 */
+	/* Register the timers that return unneeded pages to gfp */
 	for_each_online_cpu(cpu)
 		start_cpu_timer(cpu);
 
 	return 0;
 }
-
 __initcall(cpucache_init);
 
 /*
@@ -1190,11 +1190,10 @@ static void *kmem_getpages(kmem_cache_t 
 	int i;
 
 	flags |= cachep->gfpflags;
-	if (likely(nodeid == -1)) {
+	if (likely(nodeid == -1))
 		page = alloc_pages(flags, cachep->gfporder);
-	} else {
+	else
 		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
-	}
 	if (!page)
 		return NULL;
 	addr = page_address(page);
@@ -1215,7 +1214,7 @@ static void *kmem_getpages(kmem_cache_t 
  */
 static void kmem_freepages(kmem_cache_t *cachep, void *addr)
 {
-	unsigned long i = (1<<cachep->gfporder);
+	unsigned long i = (1 << cachep->gfporder);
 	struct page *page = virt_to_page(addr);
 	const unsigned long nr_freed = i;
 
@@ -1234,7 +1233,7 @@ static void kmem_freepages(kmem_cache_t 
 
 static void kmem_rcu_free(struct rcu_head *head)
 {
-	struct slab_rcu *slab_rcu = (struct slab_rcu *) head;
+	struct slab_rcu *slab_rcu = (struct slab_rcu *)head;
 	kmem_cache_t *cachep = slab_rcu->cachep;
 
 	kmem_freepages(cachep, slab_rcu->addr);
@@ -1246,11 +1245,11 @@ static void kmem_rcu_free(struct rcu_hea
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
-				unsigned long caller)
+			    unsigned long caller)
 {
 	int size = obj_reallen(cachep);
 
-	addr = (unsigned long *)&((char*)addr)[obj_dbghead(cachep)];
+	addr = (unsigned long *)&((char *)addr)[obj_dbghead(cachep)];
 
 	if (size < 5*sizeof(unsigned long))
 		return;
@@ -1272,7 +1271,6 @@ static void store_stackinfo(kmem_cache_t
 					break;
 			}
 		}
-
 	}
 	*addr++=0x87654321;
 }
@@ -1281,7 +1279,7 @@ static void store_stackinfo(kmem_cache_t
 static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
 {
 	int size = obj_reallen(cachep);
-	addr = &((char*)addr)[obj_dbghead(cachep)];
+	addr = &((char *)addr)[obj_dbghead(cachep)];
 
 	memset(addr, val, size);
 	*(unsigned char *)(addr+size-1) = POISON_END;
@@ -1291,9 +1289,8 @@ static void dump_line(char *data, int of
 {
 	int i;
 	printk(KERN_ERR "%03x:", offset);
-	for (i=0;i<limit;i++) {
+	for (i = 0; i < limit; i++)
 		printk(" %02x", (unsigned char)data[offset+i]);
-	}
 	printk("\n");
 }
 #endif
@@ -1318,13 +1315,13 @@ static void print_objinfo(kmem_cache_t *
 				(unsigned long)*dbg_userword(cachep, objp));
 		printk("\n");
 	}
-	realobj = (char*)objp+obj_dbghead(cachep);
+	realobj = (char *)objp + obj_dbghead(cachep);
 	size = obj_reallen(cachep);
-	for (i=0; i<size && lines;i+=16, lines--) {
+	for (i = 0; i < size && lines; i += 16, lines--) {
 		int limit;
 		limit = 16;
-		if (i+limit > size)
-			limit = size-i;
+		if (i + limit > size)
+			limit = size - i;
 		dump_line(realobj, i, limit);
 	}
 }
@@ -1335,27 +1332,27 @@ static void check_poison_obj(kmem_cache_
 	int size, i;
 	int lines = 0;
 
-	realobj = (char*)objp+obj_dbghead(cachep);
+	realobj = (char *)objp + obj_dbghead(cachep);
 	size = obj_reallen(cachep);
 
-	for (i=0;i<size;i++) {
+	for (i = 0; i < size; i++) {
 		char exp = POISON_FREE;
-		if (i == size-1)
+		if (i == size - 1)
 			exp = POISON_END;
 		if (realobj[i] != exp) {
 			int limit;
 			/* Mismatch ! */
 			/* Print header */
 			if (lines == 0) {
-				printk(KERN_ERR "Slab corruption: start=%p, len=%d\n",
-						realobj, size);
+				printk(KERN_ERR "Slab corruption: start=%p, "
+				       "len=%d\n", realobj, size);
 				print_objinfo(cachep, objp, 0);
 			}
 			/* Hexdump the affected line */
-			i = (i/16)*16;
+			i = (i / 16) * 16;
 			limit = 16;
-			if (i+limit > size)
-				limit = size-i;
+			if (i + limit > size)
+				limit = size - i;
 			dump_line(realobj, i, limit);
 			i += 16;
 			lines++;
@@ -1365,36 +1362,35 @@ static void check_poison_obj(kmem_cache_
 		}
 	}
 	if (lines != 0) {
-		/* Print some data about the neighboring objects, if they
-		 * exist:
-		 */
+		/* Print data about the neighboring objects, if they exist */
 		struct slab *slabp = GET_PAGE_SLAB(virt_to_page(objp));
 		int objnr;
 
-		objnr = (objp-slabp->s_mem)/cachep->objsize;
+		objnr = (objp - slabp->s_mem) / cachep->objsize;
 		if (objnr) {
-			objp = slabp->s_mem+(objnr-1)*cachep->objsize;
-			realobj = (char*)objp+obj_dbghead(cachep);
+			objp = slabp->s_mem + (objnr - 1) * cachep->objsize;
+			realobj = (char *)objp + obj_dbghead(cachep);
 			printk(KERN_ERR "Prev obj: start=%p, len=%d\n",
-						realobj, size);
+			       realobj, size);
 			print_objinfo(cachep, objp, 2);
 		}
-		if (objnr+1 < cachep->num) {
-			objp = slabp->s_mem+(objnr+1)*cachep->objsize;
-			realobj = (char*)objp+obj_dbghead(cachep);
+		if (objnr + 1 < cachep->num) {
+			objp = slabp->s_mem + (objnr + 1) * cachep->objsize;
+			realobj = (char *)objp + obj_dbghead(cachep);
 			printk(KERN_ERR "Next obj: start=%p, len=%d\n",
-						realobj, size);
+			       realobj, size);
 			print_objinfo(cachep, objp, 2);
 		}
 	}
 }
 #endif
 
-/* Destroy all the objs in a slab, and release the mem back to the system.
+/*
+ * Destroy all the objs in a slab, and release the mem back to the system.
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
-static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy(kmem_cache_t *cachep, struct slab *slabp)
 {
 	void *addr = slabp->s_mem - slabp->colouroff;
 
@@ -1406,7 +1402,8 @@ static void slab_destroy (kmem_cache_t *
 		if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
 			if ((cachep->objsize%PAGE_SIZE)==0 && OFF_SLAB(cachep))
-				kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE,1);
+				kernel_map_pages(virt_to_page(objp),
+						 cachep->objsize/PAGE_SIZE, 1);
 			else
 				check_poison_obj(cachep, objp);
 #else
@@ -1422,13 +1419,13 @@ static void slab_destroy (kmem_cache_t *
 							"was overwritten");
 		}
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
-			(cachep->dtor)(objp+obj_dbghead(cachep), cachep, 0);
+			(cachep->dtor)(objp + obj_dbghead(cachep), cachep, 0);
 	}
 #else
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
-			void* objp = slabp->s_mem+cachep->objsize*i;
+			void *objp = slabp->s_mem + cachep->objsize * i;
 			(cachep->dtor)(objp, cachep, 0);
 		}
 	}
@@ -1437,7 +1434,7 @@ static void slab_destroy (kmem_cache_t *
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
 		struct slab_rcu *slab_rcu;
 
-		slab_rcu = (struct slab_rcu *) slabp;
+		slab_rcu = (struct slab_rcu *)slabp;
 		slab_rcu->cachep = cachep;
 		slab_rcu->addr = addr;
 		call_rcu(&slab_rcu->head, kmem_rcu_free);
@@ -1448,17 +1445,19 @@ static void slab_destroy (kmem_cache_t *
 	}
 }
 
-/* For setting up all the kmem_list3s for cache whose objsize is same
-   as size of kmem_list3. */
+/*
+ * For setting up all the kmem_list3s for cache whose objsize is same
+ * as size of kmem_list3.
+ */
 static inline void set_up_list3s(kmem_cache_t *cachep, int index)
 {
 	int node;
 
 	for_each_online_node(node) {
-		cachep->nodelists[node] = &initkmem_list3[index+node];
+		cachep->nodelists[node] = &initkmem_list3[index + node];
 		cachep->nodelists[node]->next_reap = jiffies +
 			REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+			((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 	}
 }
 
@@ -1495,10 +1494,10 @@ static inline void set_up_list3s(kmem_ca
  * cacheline.  This can be beneficial if you're counting cycles as closely
  * as davem.
  */
-kmem_cache_t *
-kmem_cache_create (const char *name, size_t size, size_t align,
-	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
-	void (*dtor)(void*, kmem_cache_t *, unsigned long))
+kmem_cache_t *kmem_cache_create(const char *name, size_t size, size_t align,
+				unsigned long flags,
+				void (*ctor)(void *, kmem_cache_t *, unsigned long),
+				void (*dtor)(void *, kmem_cache_t *, unsigned long))
 {
 	size_t left_over, slab_size, ralign;
 	kmem_cache_t *cachep = NULL;
@@ -1550,7 +1549,8 @@ kmem_cache_create (const char *name, siz
 	if (flags & ~CREATE_MASK)
 		BUG();
 
-	/* Check that size is in terms of words.  This is needed to avoid
+	/*
+	 * Check that size is in terms of words.  This is needed to avoid
 	 * unaligned accesses for some archs when redzoning is used, and makes
 	 * sure any on-slab bufctl's are also correctly aligned.
 	 */
@@ -1562,7 +1562,8 @@ kmem_cache_create (const char *name, siz
 	/* calculate out the final buffer alignment: */
 	/* 1) arch recommendation: can be overridden for debug */
 	if (flags & SLAB_HWCACHE_ALIGN) {
-		/* Default alignment: as specified by the arch code.
+		/*
+		 * Default alignment: as specified by the arch code.
 		 * Except if an object is really small, then squeeze multiple
 		 * objects into one cacheline.
 		 */
@@ -1584,7 +1585,8 @@ kmem_cache_create (const char *name, siz
 		if (ralign > BYTES_PER_WORD)
 			flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
 	}
-	/* 4) Store it. Note that the debug code below can reduce
+	/*
+	 * 4) Store it. Note that the debug code below can reduce
 	 *    the alignment to BYTES_PER_WORD.
 	 */
 	align = ralign;
@@ -1607,7 +1609,8 @@ kmem_cache_create (const char *name, siz
 		size += 2*BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
-		/* user store requires word alignment and
+		/*
+		 * user store requires word alignment and
 		 * one word storage behind the end of the real
 		 * object.
 		 */
@@ -1669,7 +1672,7 @@ cal_wastage:
 			}
 
 			/*
-			 * Large num of objs is good, but v. large slabs are
+			 * Large num of objs is good, but very large slabs are
 			 * currently bad for the gfp()s.
 			 */
 			if (cachep->gfporder >= slab_break_gfp_order)
@@ -1731,14 +1734,16 @@ next:
 		enable_cpucache(cachep);
 	} else {
 		if (g_cpucache_up == NONE) {
-			/* Note: the first kmem_cache_create must create
+			/*
+			 * Note: the first kmem_cache_create must create
 			 * the cache that's used by kmalloc(24), otherwise
 			 * the creation of further caches will BUG().
 			 */
 			cachep->array[smp_processor_id()] =
 				&initarray_generic.cache;
 
-			/* If the cache that's used by
+			/*
+			 * If the cache that's used by
 			 * kmalloc(sizeof(kmem_list3)) is the first cache,
 			 * then we need to set up all its list3s, otherwise
 			 * the creation of further caches will BUG().
@@ -1792,9 +1797,11 @@ next:
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
 			char tmp;
-			/* This happens when the module gets unloaded and doesn't
-			   destroy its slab cache and noone else reuses the vmalloc
-			   area of the module. Print a warning. */
+			/*
+			 * This happens when the module gets unloaded & doesn't
+			 * destroy its slab cache and noone else reuses the
+			 * vmalloc area of the module.  Print a warning.
+			 */
 			if (__get_user(tmp,pc->name)) { 
 				printk("SLAB: cache with size %d has lost its name\n", 
 					pc->objsize); 
@@ -1850,16 +1857,16 @@ static inline void check_spinlock_acquir
 }
 
 #else
-#define check_irq_off()	do { } while(0)
-#define check_irq_on()	do { } while(0)
-#define check_spinlock_acquired(x) do { } while(0)
-#define check_spinlock_acquired_node(x, y) do { } while(0)
+#define check_irq_off()				do { } while(0)
+#define check_irq_on()				do { } while(0)
+#define check_spinlock_acquired(x)		do { } while(0)
+#define check_spinlock_acquired_node(x, y)	do { } while(0)
 #endif
 
 /*
  * Waits for all CPUs to execute func().
  */
-static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
+static void smp_call_function_all_cpus(void (*func)(void *arg), void *arg)
 {
 	check_irq_on();
 	preempt_disable();
@@ -1874,12 +1881,12 @@ static void smp_call_function_all_cpus(v
 	preempt_enable();
 }
 
-static void drain_array_locked(kmem_cache_t* cachep,
-				struct array_cache *ac, int force, int node);
+static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
+			       int force, int node);
 
 static void do_drain(void *arg)
 {
-	kmem_cache_t *cachep = (kmem_cache_t*)arg;
+	kmem_cache_t *cachep = (kmem_cache_t *)arg;
 	struct array_cache *ac;
 	int node = numa_node_id();
 
@@ -1899,7 +1906,7 @@ static void drain_cpu_caches(kmem_cache_
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	for_each_online_node(node)  {
+	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
 		if (l3) {
 			spin_lock(&l3->list_lock);
@@ -1942,6 +1949,13 @@ static int __node_shrink(kmem_cache_t *c
 	return ret;
 }
 
+/**
+ * __cache_shrink - Release all free slabs
+ * @cachep: The cache to shrink.
+ *
+ * Return 1 if there are still partial or full slabs belonging to this cache
+ * Return 0 if there are no more slabs belonging to this cache
+ */
 static int __cache_shrink(kmem_cache_t *cachep)
 {
 	int ret = 0, i = 0;
@@ -1994,7 +2008,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * The caller must guarantee that noone will allocate memory from the cache
  * during the kmem_cache_destroy().
  */
-int kmem_cache_destroy(kmem_cache_t * cachep)
+int kmem_cache_destroy(kmem_cache_t *cachep)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2007,9 +2021,7 @@ int kmem_cache_destroy(kmem_cache_t * ca
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
-	/*
-	 * the chain is never empty, cache_cache is never destroyed
-	 */
+	/* the chain is never empty, cache_cache is never destroyed */
 	list_del(&cachep->next);
 	up(&cache_chain_sem);
 
@@ -2045,8 +2057,8 @@ int kmem_cache_destroy(kmem_cache_t * ca
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
-			int colour_off, gfp_t local_flags)
+static struct slab *alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
+				   int colour_off, gfp_t local_flags)
 {
 	struct slab *slabp;
 	
@@ -2056,28 +2068,28 @@ static struct slab* alloc_slabmgmt(kmem_
 		if (!slabp)
 			return NULL;
 	} else {
-		slabp = objp+colour_off;
+		slabp = objp + colour_off;
 		colour_off += cachep->slab_size;
 	}
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;
-	slabp->s_mem = objp+colour_off;
+	slabp->s_mem = objp + colour_off;
 
 	return slabp;
 }
 
 static inline kmem_bufctl_t *slab_bufctl(struct slab *slabp)
 {
-	return (kmem_bufctl_t *)(slabp+1);
+	return (kmem_bufctl_t *)(slabp + 1);
 }
 
-static void cache_init_objs(kmem_cache_t *cachep,
-			struct slab *slabp, unsigned long ctor_flags)
+static void cache_init_objs(kmem_cache_t *cachep, struct slab *slabp,
+			    unsigned long ctor_flags)
 {
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem+cachep->objsize*i;
+		void *objp = slabp->s_mem + cachep->objsize * i;
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -2095,7 +2107,8 @@ static void cache_init_objs(kmem_cache_t
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
 		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
-			cachep->ctor(objp+obj_dbghead(cachep), cachep, ctor_flags);
+			cachep->ctor(objp + obj_dbghead(cachep), cachep,
+				     ctor_flags);
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
@@ -2105,15 +2118,17 @@ static void cache_init_objs(kmem_cache_t
 				slab_error(cachep, "constructor overwrote the"
 							" start of an object");
 		}
-		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep) && cachep->flags & SLAB_POISON)
-	       		kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 0);
+		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep) &&
+		    cachep->flags & SLAB_POISON)
+	       		kernel_map_pages(virt_to_page(objp),
+					 cachep->objsize / PAGE_SIZE, 0);
 #else
 		if (cachep->ctor)
 			cachep->ctor(objp, cachep, ctor_flags);
 #endif
-		slab_bufctl(slabp)[i] = i+1;
+		slab_bufctl(slabp)[i] = i + 1;
 	}
-	slab_bufctl(slabp)[i-1] = BUFCTL_END;
+	slab_bufctl(slabp)[i - 1] = BUFCTL_END;
 	slabp->free = 0;
 }
 
@@ -2133,7 +2148,6 @@ static void set_slab_attr(kmem_cache_t *
 	int i;
 	struct page *page;
 
-	/* Nasty!!!!!! I hope this is OK. */
 	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
 	do {
@@ -2149,14 +2163,15 @@ static void set_slab_attr(kmem_cache_t *
  */
 static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
 {
-	struct slab	*slabp;
-	void		*objp;
-	size_t		 offset;
-	unsigned int	 local_flags;
-	unsigned long	 ctor_flags;
+	struct slab *slabp;
+	void *objp;
+	size_t offset;
+	unsigned int local_flags;
+	unsigned long ctor_flags;
 	struct kmem_list3 *l3;
 
-	/* Be lazy and only check for valid flags here,
+	/*
+	 * Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
 	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
@@ -2191,22 +2206,20 @@ static int cache_grow(kmem_cache_t *cach
 		local_irq_enable();
 
 	/*
-	 * The test for missing atomic flag is performed here, rather than
-	 * the more obvious place, simply to reduce the critical path length
-	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
-	 * will eventually be caught here (where it matters).
+	 * Ensure caller isn't asking for DMA memory if the slab wasn't created
+	 * with the SLAB_DMA flag.
+	 * Also ensure the caller *is* asking for DMA memory if the slab was
+	 * created with the SLAB_DMA flag.
 	 */
 	kmem_flagcheck(cachep, flags);
 
-	/* Get mem for the objs.
-	 * Attempt to allocate a physical page from 'nodeid',
-	 */
+	/* Get mem for the objects by allocating a physical page from 'nodeid' */
 	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
-		goto failed;
+		goto out_nomem;
 
 	/* Get slab management. */
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
-		goto opps1;
+		goto out_freepages;
 
 	slabp->nodeid = nodeid;
 	set_slab_attr(cachep, slabp, objp);
@@ -2225,16 +2238,15 @@ static int cache_grow(kmem_cache_t *cach
 	l3->free_objects += cachep->num;
 	spin_unlock(&l3->list_lock);
 	return 1;
-opps1:
+out_freepages:
 	kmem_freepages(cachep, objp);
-failed:
+out_nomem:
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	return 0;
 }
 
 #if DEBUG
-
 /*
  * Perform extra freeing checks:
  * - detect bad pointers.
@@ -2247,18 +2259,19 @@ static void kfree_debugcheck(const void 
 
 	if (!virt_addr_valid(objp)) {
 		printk(KERN_ERR "kfree_debugcheck: out of range ptr %lxh.\n",
-			(unsigned long)objp);	
+		       (unsigned long)objp);	
 		BUG();	
 	}
 	page = virt_to_page(objp);
 	if (!PageSlab(page)) {
-		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n", (unsigned long)objp);
+		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n",
+		       (unsigned long)objp);
 		BUG();
 	}
 }
 
 static void *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
-					void *caller)
+				   void *caller)
 {
 	struct page *page;
 	unsigned int objnr;
@@ -2272,17 +2285,20 @@ static void *cache_free_debugcheck(kmem_
 		printk(KERN_ERR "mismatch in kmem_cache_free: expected cache %p, got %p\n",
 				GET_PAGE_CACHE(page),cachep);
 		printk(KERN_ERR "%p is %s.\n", cachep, cachep->name);
-		printk(KERN_ERR "%p is %s.\n", GET_PAGE_CACHE(page), GET_PAGE_CACHE(page)->name);
+		printk(KERN_ERR "%p is %s.\n", GET_PAGE_CACHE(page),
+		       GET_PAGE_CACHE(page)->name);
 		WARN_ON(1);
 	}
 	slabp = GET_PAGE_SLAB(page);
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE || *dbg_redzone2(cachep, objp) != RED_ACTIVE) {
+		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE ||
+		    *dbg_redzone2(cachep, objp) != RED_ACTIVE) {
 			slab_error(cachep, "double free, or memory outside"
 						" object was overwritten");
 			printk(KERN_ERR "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
-					objp, *dbg_redzone1(cachep, objp), *dbg_redzone2(cachep, objp));
+			       objp, *dbg_redzone1(cachep, objp),
+			       *dbg_redzone2(cachep, objp));
 		}
 		*dbg_redzone1(cachep, objp) = RED_INACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_INACTIVE;
@@ -2293,27 +2309,30 @@ static void *cache_free_debugcheck(kmem_
 	objnr = (objp-slabp->s_mem)/cachep->objsize;
 
 	BUG_ON(objnr >= cachep->num);
-	BUG_ON(objp != slabp->s_mem + objnr*cachep->objsize);
+	BUG_ON(objp != slabp->s_mem + objnr * cachep->objsize);
 
 	if (cachep->flags & SLAB_DEBUG_INITIAL) {
-		/* Need to call the slab's constructor so the
+		/*
+		 * Need to call the slab's constructor so the
 		 * caller can perform a verify of its state (debugging).
 		 * Called without the cache-lock held.
 		 */
-		cachep->ctor(objp+obj_dbghead(cachep),
-					cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
+		cachep->ctor(objp + obj_dbghead(cachep), cachep,
+			     SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
 	}
 	if (cachep->flags & SLAB_POISON && cachep->dtor) {
-		/* we want to cache poison the object,
+		/*
+		 * we want to cache poison the object,
 		 * call the destruction callback
 		 */
-		cachep->dtor(objp+obj_dbghead(cachep), cachep, 0);
+		cachep->dtor(objp + obj_dbghead(cachep), cachep, 0);
 	}
 	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
 		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep)) {
 			store_stackinfo(cachep, objp, (unsigned long)caller);
-	       		kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 0);
+	       		kernel_map_pages(virt_to_page(objp),
+					 cachep->objsize / PAGE_SIZE, 0);
 		} else {
 			poison_obj(cachep, objp, POISON_FREE);
 		}
@@ -2337,10 +2356,13 @@ static void check_slabp(kmem_cache_t *ca
 	}
 	if (entries != cachep->num - slabp->inuse) {
 bad:
-		printk(KERN_ERR "slab: Internal list corruption detected in cache '%s'(%d), slabp %p(%d). Hexdump:\n",
-				cachep->name, cachep->num, slabp, slabp->inuse);
-		for (i=0;i<sizeof(slabp)+cachep->num*sizeof(kmem_bufctl_t);i++) {
-			if ((i%16)==0)
+		printk(KERN_ERR "slab: Internal list corruption detected in "
+		       "cache '%s'(%d), slabp %p(%d). Hexdump:\n",
+		       cachep->name, cachep->num, slabp, slabp->inuse);
+		for (i = 0;
+		     i < sizeof(slabp) + cachep->num * sizeof(kmem_bufctl_t);
+		     i++) {
+			if ((i % 16) == 0)
 				printk("\n%03x:", i);
 			printk(" %02x", ((unsigned char*)slabp)[i]);
 		}
@@ -2349,9 +2371,9 @@ bad:
 	}
 }
 #else
-#define kfree_debugcheck(x) do { } while(0)
-#define cache_free_debugcheck(x,objp,z) (objp)
-#define check_slabp(x,y) do { } while(0)
+#define kfree_debugcheck(x)			do { } while(0)
+#define cache_free_debugcheck(x,objp,z)		(objp)
+#define check_slabp(x,y)			do { } while(0)
 #endif
 
 static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
@@ -2365,7 +2387,8 @@ static void *cache_alloc_refill(kmem_cac
 retry:
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
-		/* if there was little recent activity on this
+		/*
+		 * if there was little recent activity on this
 		 * cache, then perform only a partial refill.
 		 * Otherwise we could generate refill bouncing.
 		 */
@@ -2383,9 +2406,8 @@ retry:
 				batchcount = shared_array->avail;
 			shared_array->avail -= batchcount;
 			ac->avail = batchcount;
-			memcpy(ac->entry,
-				&(shared_array->entry[shared_array->avail]),
-				sizeof(void*)*batchcount);
+			memcpy(ac->entry, &(shared_array->entry[shared_array->avail]),
+			       sizeof(void *) * batchcount);
 			shared_array->touched = 1;
 			goto alloc_done;
 		}
@@ -2441,20 +2463,20 @@ alloc_done:
 		int x;
 		x = cache_grow(cachep, flags, numa_node_id());
 
-		// cache_grow can reenable interrupts, then ac could change.
+		/* cache_grow can reenable interrupts, then ac could change. */
 		ac = ac_data(cachep);
-		if (!x && ac->avail == 0)	// no objects in sight? abort
+		if (!x && ac->avail == 0) /* no objects in sight? abort      */
 			return NULL;
 
-		if (!ac->avail)		// objects refilled by interrupt?
+		if (!ac->avail)		  /* objects refilled by interrupt?  */
 			goto retry;
 	}
 	ac->touched = 1;
 	return ac->entry[--ac->avail];
 }
 
-static inline void
-cache_alloc_debugcheck_before(kmem_cache_t *cachep, gfp_t flags)
+static inline void cache_alloc_debugcheck_before(kmem_cache_t *cachep,
+						 gfp_t flags)
 {
 	might_sleep_if(flags & __GFP_WAIT);
 #if DEBUG
@@ -2463,16 +2485,16 @@ cache_alloc_debugcheck_before(kmem_cache
 }
 
 #if DEBUG
-static void *
-cache_alloc_debugcheck_after(kmem_cache_t *cachep,
-			gfp_t flags, void *objp, void *caller)
+static void *cache_alloc_debugcheck_after(kmem_cache_t *cachep, gfp_t flags,
+					  void *objp, void *caller)
 {
 	if (!objp)	
 		return objp;
  	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
 		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
-			kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 1);
+			kernel_map_pages(virt_to_page(objp),
+					 cachep->objsize / PAGE_SIZE, 1);
 		else
 			check_poison_obj(cachep, objp);
 #else
@@ -2484,18 +2506,20 @@ cache_alloc_debugcheck_after(kmem_cache_
 		*dbg_userword(cachep, objp) = caller;
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE || *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
-			slab_error(cachep, "double free, or memory outside"
-						" object was overwritten");
+		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE ||
+		    *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
+			slab_error(cachep, "double free, or memory outside "
+				   "object was overwritten");
 			printk(KERN_ERR "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
-					objp, *dbg_redzone1(cachep, objp), *dbg_redzone2(cachep, objp));
+			       objp, *dbg_redzone1(cachep, objp),
+			       *dbg_redzone2(cachep, objp));
 		}
 		*dbg_redzone1(cachep, objp) = RED_ACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_ACTIVE;
 	}
 	objp += obj_dbghead(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
-		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+		unsigned long ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 
 		if (!(flags & __GFP_WAIT))
 			ctor_flags |= SLAB_CTOR_ATOMIC;
@@ -2529,7 +2553,7 @@ static inline void *____cache_alloc(kmem
 static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
 {
 	unsigned long save_flags;
-	void* objp;
+	void *objp;
 
 	cache_alloc_debugcheck_before(cachep, flags);
 
@@ -2537,7 +2561,7 @@ static inline void *__cache_alloc(kmem_c
 	objp = ____cache_alloc(cachep, flags);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					__builtin_return_address(0));
+					    __builtin_return_address(0));
 	prefetchw(objp);
 	return objp;
 }
@@ -2616,7 +2640,8 @@ done:
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects, int node)
+static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects,
+		       int node)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2633,7 +2658,6 @@ static void free_block(kmem_cache_t *cac
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 
-
 #if DEBUG
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache "
@@ -2657,7 +2681,8 @@ static void free_block(kmem_cache_t *cac
 				list_add(&slabp->list, &l3->slabs_free);
 			}
 		} else {
-			/* Unconditionally move a slab to the end of the
+			/*
+			 * Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
@@ -2681,13 +2706,12 @@ static void cache_flusharray(kmem_cache_
 	spin_lock(&l3->list_lock);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
-		int max = shared_array->limit-shared_array->avail;
+		int max = shared_array->limit - shared_array->avail;
 		if (max) {
 			if (batchcount > max)
 				batchcount = max;
 			memcpy(&(shared_array->entry[shared_array->avail]),
-					ac->entry,
-					sizeof(void*)*batchcount);
+			       ac->entry, sizeof(void *) * batchcount);
 			shared_array->avail += batchcount;
 			goto free_done;
 		}
@@ -2716,11 +2740,11 @@ free_done:
 	spin_unlock(&l3->list_lock);
 	ac->avail -= batchcount;
 	memmove(ac->entry, &(ac->entry[batchcount]),
-			sizeof(void*)*ac->avail);
+		sizeof(void *) * ac->avail);
 }
 
 
-/*
+/**
  * __cache_free
  * Release an obj back to its cache. If the obj has a constructed
  * state, it must be in this state _before_ it is released.
@@ -2734,7 +2758,8 @@ static inline void __cache_free(kmem_cac
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
-	/* Make sure we are not freeing a object from another
+	/*
+	 * Make sure we are not freeing a object from another
 	 * node to the array cache on this cpu.
 	 */
 #ifdef CONFIG_NUMA
@@ -2744,23 +2769,21 @@ static inline void __cache_free(kmem_cac
 		if (unlikely(slabp->nodeid != numa_node_id())) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
-			struct kmem_list3 *l3 = cachep->nodelists[numa_node_id()];
+			struct kmem_list3 *l3 =
+				cachep->nodelists[numa_node_id()];
 
 			STATS_INC_NODEFREES(cachep);
 			if (l3->alien && l3->alien[nodeid]) {
 				alien = l3->alien[nodeid];
 				spin_lock(&alien->lock);
 				if (unlikely(alien->avail == alien->limit))
-					__drain_alien_cache(cachep,
-							alien, nodeid);
+					__drain_alien_cache(cachep, alien, nodeid);
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
-				spin_lock(&(cachep->nodelists[nodeid])->
-						list_lock);
+				spin_lock(&(cachep->nodelists[nodeid])->list_lock);
 				free_block(cachep, &objp, 1, nodeid);
-				spin_unlock(&(cachep->nodelists[nodeid])->
-						list_lock);
+				spin_unlock(&(cachep->nodelists[nodeid])->list_lock);
 			}
 			return;
 		}
@@ -2792,8 +2815,7 @@ void *kmem_cache_alloc(kmem_cache_t *cac
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 /**
- * kmem_ptr_validate - check if an untrusted pointer might
- *	be a slab entry.
+ * kmem_ptr_validate - check if an untrusted pointer might be a slab entry.
  * @cachep: the cache we're checking against
  * @ptr: pointer to validate
  *
@@ -2807,7 +2829,7 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  */
 int fastcall kmem_ptr_validate(kmem_cache_t *cachep, void *ptr)
 {
-	unsigned long addr = (unsigned long) ptr;
+	unsigned long addr = (unsigned long)ptr;
 	unsigned long min_addr = PAGE_OFFSET;
 	unsigned long align_mask = BYTES_PER_WORD-1;
 	unsigned long size = cachep->objsize;
@@ -2856,7 +2878,8 @@ void *kmem_cache_alloc_node(kmem_cache_t
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
-		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
+		printk(KERN_WARNING "slab: not allocating in inactive node %d "
+		       "for cache %s\n", nodeid, cachep->name);
 		return __cache_alloc(cachep,flags);
 	}
 
@@ -2867,7 +2890,8 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
+	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
+					   __builtin_return_address(0));
 
 	return ptr;
 }
@@ -2910,10 +2934,9 @@ void *__kmalloc(size_t size, gfp_t flags
 {
 	kmem_cache_t *cachep;
 
-	/* If you want to save a few bytes .text space: replace
-	 * __ with kmem_.
-	 * Then kmalloc uses the uninlined functions instead of the inline
-	 * functions.
+	/*
+	 * If you want to save a few bytes .text space: replace __ with kmem_
+	 * Then kmalloc uses the uninlined functions vs. the inline functions
 	 */
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
@@ -2934,7 +2957,7 @@ EXPORT_SYMBOL(__kmalloc);
 void *__alloc_percpu(size_t size, size_t align)
 {
 	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
+	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
 
 	if (!pdata)
 		return NULL;
@@ -3023,7 +3046,7 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
-	__cache_free(c, (void*)objp);
+	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(kfree);
@@ -3036,8 +3059,7 @@ EXPORT_SYMBOL(kfree);
  * Don't free memory not originally allocated by alloc_percpu()
  * The complemented objp is to check for that.
  */
-void
-free_percpu(const void *objp)
+void free_percpu(const void *objp)
 {
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
@@ -3080,40 +3102,39 @@ static int alloc_kmemlist(kmem_cache_t *
 		if (!(new_alien = alloc_alien_cache(node, cachep->limit)))
 			goto fail;
 #endif
-		if (!(new = alloc_arraycache(node, (cachep->shared*
-				cachep->batchcount), 0xbaadf00d)))
+		if (!(new = alloc_arraycache(node, cachep->shared *
+					     cachep->batchcount, 0xbaadf00d)))
 			goto fail;
 		if ((l3 = cachep->nodelists[node])) {
 
 			spin_lock_irq(&l3->list_lock);
 
 			if ((nc = cachep->nodelists[node]->shared))
-				free_block(cachep, nc->entry,
-							nc->avail, node);
+				free_block(cachep, nc->entry, nc->avail, node);
 
 			l3->shared = new;
 			if (!cachep->nodelists[node]->alien) {
 				l3->alien = new_alien;
 				new_alien = NULL;
 			}
-			l3->free_limit = (1 + nr_cpus_node(node))*
-				cachep->batchcount + cachep->num;
+			l3->free_limit = cachep->num +
+				(1 + nr_cpus_node(node)) * cachep->batchcount;
 			spin_unlock_irq(&l3->list_lock);
 			kfree(nc);
 			free_alien_cache(new_alien);
 			continue;
 		}
 		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
-						GFP_KERNEL, node)))
+					GFP_KERNEL, node)))
 			goto fail;
 
 		kmem_list3_init(l3);
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+			((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 		l3->shared = new;
 		l3->alien = new_alien;
-		l3->free_limit = (1 + nr_cpus_node(node))*
-			cachep->batchcount + cachep->num;
+		l3->free_limit = cachep->num +
+			(1 + nr_cpus_node(node)) * cachep->batchcount;
 		cachep->nodelists[node] = l3;
 	}
 	return err;
@@ -3141,16 +3162,17 @@ static void do_ccupdate_local(void *info
 
 
 static int do_tune_cpucache(kmem_cache_t *cachep, int limit, int batchcount,
-				int shared)
+			    int shared)
 {
 	struct ccupdate_struct new;
 	int i, err;
 
-	memset(&new.new,0,sizeof(new.new));
+	memset(&new.new, 0, sizeof(new.new));
 	for_each_online_cpu(i) {
 		new.new[i] = alloc_arraycache(cpu_to_node(i), limit, batchcount);
 		if (!new.new[i]) {
-			for (i--; i >= 0; i--) kfree(new.new[i]);
+			for (i--; i >= 0; i--)
+				kfree(new.new[i]);
 			return -ENOMEM;
 		}
 	}
@@ -3178,7 +3200,7 @@ static int do_tune_cpucache(kmem_cache_t
 	err = alloc_kmemlist(cachep);
 	if (err) {
 		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
-				cachep->name, -err);
+		       cachep->name, -err);
 		BUG();
 	}
 	return 0;
@@ -3190,7 +3212,8 @@ static void enable_cpucache(kmem_cache_t
 	int err;
 	int limit, shared;
 
-	/* The head array serves three purposes:
+	/*
+	 * The head array serves three purposes:
 	 * - create a LIFO ordering, i.e. return objects that are cache-warm
 	 * - reduce the number of spinlock operations.
 	 * - reduce the number of linked list operations on the slab and 
@@ -3209,7 +3232,8 @@ static void enable_cpucache(kmem_cache_t
 	else
 		limit = 120;
 
-	/* Cpu bound tasks (e.g. network routing) can exhibit cpu bound
+	/*
+	 * Cpu bound tasks (e.g. network routing) can exhibit cpu bound
 	 * allocation behaviour: Most allocs on one cpu, most free operations
 	 * on another cpu. For these cases, an efficient object passing between
 	 * cpus is necessary. This is provided by a shared array. The array
@@ -3224,7 +3248,8 @@ static void enable_cpucache(kmem_cache_t
 #endif
 
 #if DEBUG
-	/* With debugging enabled, large batchcount lead to excessively
+	/*
+	 * With debugging enabled, large batchcount lead to excessively
 	 * long periods with disabled local interrupts. Limit the 
 	 * batchcount
 	 */
@@ -3234,11 +3259,11 @@ static void enable_cpucache(kmem_cache_t
 	err = do_tune_cpucache(cachep, limit, (limit+1)/2, shared);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
-					cachep->name, -err);
+		       cachep->name, -err);
 }
 
-static void drain_array_locked(kmem_cache_t *cachep,
-				struct array_cache *ac, int force, int node)
+static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
+			       int force, int node)
 {
 	int tofree;
 
@@ -3246,14 +3271,14 @@ static void drain_array_locked(kmem_cach
 	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
-		tofree = force ? ac->avail : (ac->limit+4)/5;
+		tofree = force ? ac->avail : (ac->limit + 4) / 5;
 		if (tofree > ac->avail) {
-			tofree = (ac->avail+1)/2;
+			tofree = (ac->avail + 1) / 2;
 		}
 		free_block(cachep, ac->entry, tofree, node);
 		ac->avail -= tofree;
 		memmove(ac->entry, &(ac->entry[tofree]),
-					sizeof(void*)*ac->avail);
+			sizeof(void *) * ac->avail);
 	}
 }
 
@@ -3275,7 +3300,8 @@ static void cache_reap(void *unused)
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+		schedule_delayed_work(&__get_cpu_var(reap_work),
+				      REAPTIMEOUT_CPUC + smp_processor_id());
 		return;
 	}
 
@@ -3314,7 +3340,8 @@ static void cache_reap(void *unused)
 			goto next_unlock;
 		}
 
-		tofree = (l3->free_limit+5*searchp->num-1)/(5*searchp->num);
+		tofree = 5 * searchp->num;
+		tofree = (l3->free_limit + tofree - 1) / tofree;
 		do {
 			p = l3->slabs_free.next;
 			if (p == &(l3->slabs_free))
@@ -3325,10 +3352,10 @@ static void cache_reap(void *unused)
 			list_del(&slabp->list);
 			STATS_INC_REAPED(searchp);
 
-			/* Safe to drop the lock. The slab is no longer
-			 * linked to the cache.
-			 * searchp cannot disappear, we hold
-			 * cache_chain_lock
+			/*
+			 * Safe to drop the lock:
+			 * The slab is no longer linked to the cache
+			 * searchp cannot disappear, we hold cache_chain_lock
 			 */
 			l3->free_objects -= searchp->num;
 			spin_unlock_irq(&l3->list_lock);
@@ -3344,7 +3371,8 @@ next:
 	up(&cache_chain_sem);
 	drain_remote_pages();
 	/* Setup the next iteration */
-	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+	schedule_delayed_work(&__get_cpu_var(reap_work),
+			      REAPTIMEOUT_CPUC + smp_processor_id());
 }
 
 #ifdef CONFIG_PROC_FS
@@ -3388,8 +3416,8 @@ static void *s_next(struct seq_file *m, 
 {
 	kmem_cache_t *cachep = p;
 	++*pos;
-	return cachep->next.next == &cache_chain ? NULL
-		: list_entry(cachep->next.next, kmem_cache_t, next);
+	return cachep->next.next == &cache_chain ? NULL :
+		list_entry(cachep->next.next, kmem_cache_t, next);
 }
 
 static void s_stop(struct seq_file *m, void *p)
@@ -3401,11 +3429,9 @@ static int s_show(struct seq_file *m, vo
 {
 	kmem_cache_t *cachep = p;
 	struct list_head *q;
-	struct slab	*slabp;
-	unsigned long	active_objs;
-	unsigned long	num_objs;
-	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs, free_objects = 0, shared_avail = 0;
+	struct slab *slabp;
+	unsigned long active_objs, num_objs, active_slabs = 0;
+	unsigned long num_slabs, free_objects = 0, shared_avail = 0;
 	const char *name;
 	char *error = NULL;
 	int node;
@@ -3432,7 +3458,7 @@ static int s_show(struct seq_file *m, vo
 		list_for_each(q,&l3->slabs_partial) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse == cachep->num && !error)
-				error = "slabs_partial inuse accounting error";
+				error = "slabs_partial/inuse accounting error";
 			if (!slabp->inuse && !error)
 				error = "slabs_partial/inuse accounting error";
 			active_objs += slabp->inuse;
@@ -3458,14 +3484,14 @@ static int s_show(struct seq_file *m, vo
 	if (error)
 		printk(KERN_ERR "slab: cache %s error: %s\n", name, error);
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
-		name, active_objs, num_objs, cachep->objsize,
-		cachep->num, (1<<cachep->gfporder));
+	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d", name, active_objs,
+		   num_objs, cachep->objsize, cachep->num,
+		   (1<<cachep->gfporder));
 	seq_printf(m, " : tunables %4u %4u %4u",
-			cachep->limit, cachep->batchcount,
-			cachep->shared);
+		   cachep->limit, cachep->batchcount,
+		   cachep->shared);
 	seq_printf(m, " : slabdata %6lu %6lu %6lu",
-			active_slabs, num_slabs, shared_avail);
+		   active_slabs, num_slabs, shared_avail);
 #if STATS
 	{	/* list3 stats */
 		unsigned long high = cachep->high_mark;
@@ -3478,9 +3504,9 @@ static int s_show(struct seq_file *m, vo
 		unsigned long node_frees = cachep->node_frees;
 
 		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu \
-				%4lu %4lu %4lu %4lu",
-				allocs, high, grown, reaped, errors,
-				max_freeable, node_allocs, node_frees);
+				%4lu %4lu %4lu %4lu", allocs, high, grown,
+			   reaped, errors, max_freeable, node_allocs,
+			   node_frees);
 	}
 	/* cpu stats */
 	{
@@ -3490,7 +3516,7 @@ static int s_show(struct seq_file *m, vo
 		unsigned long freemiss = atomic_read(&cachep->freemiss);
 
 		seq_printf(m, " : cpustat %6lu %6lu %6lu %6lu",
-			allochit, allocmiss, freehit, freemiss);
+			   allochit, allocmiss, freehit, freemiss);
 	}
 #endif
 	seq_putc(m, '\n');
@@ -3511,7 +3537,6 @@ static int s_show(struct seq_file *m, vo
  * num-pages-per-slab
  * + further values on SMP and with statistics enabled
  */
-
 struct seq_operations slabinfo_op = {
 	.start	= s_start,
 	.next	= s_next,
@@ -3528,7 +3553,7 @@ struct seq_operations slabinfo_op = {
  * @ppos: unused
  */
 ssize_t slabinfo_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos)
+		       size_t count, loff_t *ppos)
 {
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
 	int limit, batchcount, shared, res;
@@ -3555,10 +3580,8 @@ ssize_t slabinfo_write(struct file *file
 		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
 
 		if (!strcmp(cachep->name, kbuf)) {
-			if (limit < 1 ||
-			    batchcount < 1 ||
-			    batchcount > limit ||
-			    shared < 0) {
+			if (limit < 1 || batchcount < 1 ||
+			    batchcount > limit || shared < 0) {
 				res = 0;
 			} else {
 				res = do_tune_cpucache(cachep, limit,
@@ -3572,7 +3595,7 @@ ssize_t slabinfo_write(struct file *file
 		res = count;
 	return res;
 }
-#endif
+#endif /* CONFIG_PROC_FS */
 
 /**
  * ksize - get the actual amount of memory allocated for a given object
@@ -3595,7 +3618,7 @@ unsigned int ksize(const void *objp)
 }
 
 
-/*
+/**
  * kstrdup - allocate space for and copy an existing string
  *
  * @s: the string to duplicate

--------------010404000307060903090903--
