Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbVKRR1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbVKRR1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVKRR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:26:46 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:53723 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932353AbVKRR0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:26:31 -0500
Subject: [PATCH 5/5] slab: fix code formatting
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       manfred@colorfullife.com
Content-Type: text/plain
Message-Id: <iq5uun.820dha.ahpvasdz8jj7gi4zzq25ayi0.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uuh.o9kcui.7v9w5djupiovhrqo6are97fi6.beaver@cs.helsinki.fi>
Date: Fri, 18 Nov 2005 19:20:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The slab allocator code is inconsistent in coding style and messy. For this
patch, I ran Lindent for mm/slab.c and fixed up goofs by hand.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c | 1089 ++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 571 insertions(+), 518 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -130,7 +130,6 @@
 #define	FORCED_DEBUG	0
 #endif
 
-
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
 
@@ -217,12 +216,12 @@ static unsigned long offslab_limit;
  * Slabs are chained into three list: fully used, partial, fully free slabs.
  */
 struct slab {
-	struct list_head	list;
-	unsigned long		colouroff;
-	void			*s_mem;		/* including colour offset */
-	unsigned int		inuse;		/* num of objs active in slab */
-	kmem_bufctl_t		free;
-	unsigned short          nodeid;
+	struct list_head list;
+	unsigned long colouroff;
+	void *s_mem;		/* including colour offset */
+	unsigned int inuse;	/* num of objs active in slab */
+	kmem_bufctl_t free;
+	unsigned short nodeid;
 };
 
 /*
@@ -242,9 +241,9 @@ struct slab {
  * We assume struct slab_rcu can overlay struct slab when destroying.
  */
 struct slab_rcu {
-	struct rcu_head		head;
-	kmem_cache_t		*cachep;
-	void			*addr;
+	struct rcu_head head;
+	kmem_cache_t *cachep;
+	void *addr;
 };
 
 /*
@@ -279,23 +278,23 @@ struct array_cache {
 #define BOOT_CPUCACHE_ENTRIES	1
 struct arraycache_init {
 	struct array_cache cache;
-	void * entries[BOOT_CPUCACHE_ENTRIES];
+	void *entries[BOOT_CPUCACHE_ENTRIES];
 };
 
 /*
  * The slab lists for all objects.
  */
 struct kmem_list3 {
-	struct list_head	slabs_partial;	/* partial list first, better asm code */
-	struct list_head	slabs_full;
-	struct list_head	slabs_free;
-	unsigned long	free_objects;
-	unsigned long	next_reap;
-	int		free_touched;
-	unsigned int 	free_limit;
-	spinlock_t      list_lock;
-	struct array_cache	*shared;	/* shared per node */
-	struct array_cache	**alien;	/* on other nodes */
+	struct list_head slabs_partial;	/* partial list first, better asm code */
+	struct list_head slabs_full;
+	struct list_head slabs_free;
+	unsigned long free_objects;
+	unsigned long next_reap;
+	int free_touched;
+	unsigned int free_limit;
+	spinlock_t list_lock;
+	struct array_cache *shared;	/* shared per node */
+	struct array_cache **alien;	/* on other nodes */
 };
 
 /*
@@ -367,63 +366,63 @@ static inline void kmem_list3_init(struc
  *
  * manages a cache.
  */
-	
+
 struct kmem_cache {
 /* 1) per-cpu data, touched during every alloc/free */
-	struct array_cache	*array[NR_CPUS];
-	unsigned int		batchcount;
-	unsigned int		limit;
-	unsigned int 		shared;
-	unsigned int		objsize;
+	struct array_cache *array[NR_CPUS];
+	unsigned int batchcount;
+	unsigned int limit;
+	unsigned int shared;
+	unsigned int objsize;
 /* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	*nodelists[MAX_NUMNODES];
-	unsigned int	 	flags;	/* constant flags */
-	unsigned int		num;	/* # of objs per slab */
-	spinlock_t		spinlock;
+	struct kmem_list3 *nodelists[MAX_NUMNODES];
+	unsigned int flags;	/* constant flags */
+	unsigned int num;	/* # of objs per slab */
+	spinlock_t spinlock;
 
 /* 3) cache_grow/shrink */
 	/* order of pgs per slab (2^n) */
-	unsigned int		gfporder;
+	unsigned int gfporder;
 
 	/* force GFP flags, e.g. GFP_DMA */
-	gfp_t			gfpflags;
+	gfp_t gfpflags;
 
-	size_t			colour;		/* cache colouring range */
-	unsigned int		colour_off;	/* colour offset */
-	unsigned int		colour_next;	/* cache colouring */
-	kmem_cache_t		*slabp_cache;
-	unsigned int		slab_size;
-	unsigned int		dflags;		/* dynamic flags */
+	size_t colour;		/* cache colouring range */
+	unsigned int colour_off;	/* colour offset */
+	unsigned int colour_next;	/* cache colouring */
+	kmem_cache_t *slabp_cache;
+	unsigned int slab_size;
+	unsigned int dflags;	/* dynamic flags */
 
 	/* constructor func */
-	void (*ctor)(void *, kmem_cache_t *, unsigned long);
+	void (*ctor) (void *, kmem_cache_t *, unsigned long);
 
 	/* de-constructor func */
-	void (*dtor)(void *, kmem_cache_t *, unsigned long);
+	void (*dtor) (void *, kmem_cache_t *, unsigned long);
 
 /* 4) cache creation/removal */
-	const char		*name;
-	struct list_head	next;
+	const char *name;
+	struct list_head next;
 
 /* 5) statistics */
 #if STATS
-	unsigned long		num_active;
-	unsigned long		num_allocations;
-	unsigned long		high_mark;
-	unsigned long		grown;
-	unsigned long		reaped;
-	unsigned long 		errors;
-	unsigned long		max_freeable;
-	unsigned long		node_allocs;
-	unsigned long		node_frees;
-	atomic_t		allochit;
-	atomic_t		allocmiss;
-	atomic_t		freehit;
-	atomic_t		freemiss;
+	unsigned long num_active;
+	unsigned long num_allocations;
+	unsigned long high_mark;
+	unsigned long grown;
+	unsigned long reaped;
+	unsigned long errors;
+	unsigned long max_freeable;
+	unsigned long node_allocs;
+	unsigned long node_frees;
+	atomic_t allochit;
+	atomic_t allocmiss;
+	atomic_t freehit;
+	atomic_t freemiss;
 #endif
 #if DEBUG
-	int			dbghead;
-	int			reallen;
+	int dbghead;
+	int reallen;
 #endif
 };
 
@@ -503,41 +502,42 @@ struct kmem_cache {
  * cachep->objsize - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
  * cachep->objsize - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
  */
-static int obj_dbghead(kmem_cache_t *cachep)
+static int obj_dbghead(kmem_cache_t * cachep)
 {
 	return cachep->dbghead;
 }
 
-static int obj_size(kmem_cache_t *cachep)
+static int obj_size(kmem_cache_t * cachep)
 {
 	return cachep->reallen;
 }
 
-static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_redzone1(kmem_cache_t * cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long*) (objp+obj_dbghead(cachep)-BYTES_PER_WORD);
+	return (unsigned long *)(objp + obj_dbghead(cachep) - BYTES_PER_WORD);
 }
 
-static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_redzone2(kmem_cache_t * cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
-		return (unsigned long*) (objp+cachep->objsize-2*BYTES_PER_WORD);
-	return (unsigned long*) (objp+cachep->objsize-BYTES_PER_WORD);
+		return (unsigned long *)(objp + cachep->objsize -
+					 2 * BYTES_PER_WORD);
+	return (unsigned long *)(objp + cachep->objsize - BYTES_PER_WORD);
 }
 
-static void **dbg_userword(kmem_cache_t *cachep, void *objp)
+static void **dbg_userword(kmem_cache_t * cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
-	return (void**)(objp+cachep->objsize-BYTES_PER_WORD);
+	return (void **)(objp + cachep->objsize - BYTES_PER_WORD);
 }
 
 #else
 
 #define obj_dbghead(x)			0
 
-static int obj_size(kmem_cache_t *cachep)
+static int obj_size(kmem_cache_t * cachep)
 {
 	return cachep->objsize;
 }
@@ -601,6 +601,7 @@ struct cache_sizes malloc_sizes[] = {
 	CACHE(ULONG_MAX)
 #undef CACHE
 };
+
 EXPORT_SYMBOL(malloc_sizes);
 
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
@@ -612,31 +613,31 @@ struct cache_names {
 static struct cache_names __initdata cache_names[] = {
 #define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
 #include <linux/kmalloc_sizes.h>
-	{ NULL, }
+	{NULL,}
 #undef CACHE
 };
 
 static struct arraycache_init initarray_cache __initdata =
-	{ { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
+    { {0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 static struct arraycache_init initarray_generic =
-	{ { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
+    { {0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.batchcount	= 1,
-	.limit		= BOOT_CPUCACHE_ENTRIES,
-	.shared		= 1,
-	.objsize	= sizeof(kmem_cache_t),
-	.flags		= SLAB_NO_REAP,
-	.spinlock	= SPIN_LOCK_UNLOCKED,
-	.name		= "kmem_cache",
+	.batchcount = 1,
+	.limit = BOOT_CPUCACHE_ENTRIES,
+	.shared = 1,
+	.objsize = sizeof(kmem_cache_t),
+	.flags = SLAB_NO_REAP,
+	.spinlock = SPIN_LOCK_UNLOCKED,
+	.name = "kmem_cache",
 #if DEBUG
-	.reallen	= sizeof(kmem_cache_t),
+	.reallen = sizeof(kmem_cache_t),
 #endif
 };
 
 /* Guard access to the cache-chain. */
-static struct semaphore	cache_chain_sem;
+static struct semaphore cache_chain_sem;
 static struct list_head cache_chain;
 
 /*
@@ -660,12 +661,12 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t* cachep, void** objpp, int len, int node);
-static void enable_cpucache (kmem_cache_t *cachep);
-static void cache_reap (void *unused);
-static int __node_shrink(kmem_cache_t *cachep, int node);
+static void free_block(kmem_cache_t * cachep, void **objpp, int len, int node);
+static void enable_cpucache(kmem_cache_t * cachep);
+static void cache_reap(void *unused);
+static int __node_shrink(kmem_cache_t * cachep, int node);
 
-static inline struct array_cache *ac_data(kmem_cache_t *cachep)
+static inline struct array_cache *ac_data(kmem_cache_t * cachep)
 {
 	return cachep->array[smp_processor_id()];
 }
@@ -676,9 +677,9 @@ static inline kmem_cache_t *__find_gener
 
 #if DEBUG
 	/* This happens if someone tries to call
- 	* kmem_cache_create(), or __kmalloc(), before
- 	* the generic caches are initialized.
- 	*/
+	 * kmem_cache_create(), or __kmalloc(), before
+	 * the generic caches are initialized.
+	 */
 	BUG_ON(malloc_sizes[INDEX_AC].cs_cachep == NULL);
 #endif
 	while (size > csizep->cs_size)
@@ -698,14 +699,15 @@ kmem_cache_t *kmem_find_general_cachep(s
 {
 	return __find_general_cachep(size, gfpflags);
 }
+
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void cache_estimate(unsigned long gfporder, size_t size, size_t align,
-		 int flags, size_t *left_over, unsigned int *num)
+			   int flags, size_t * left_over, unsigned int *num)
 {
 	int i;
-	size_t wastage = PAGE_SIZE<<gfporder;
+	size_t wastage = PAGE_SIZE << gfporder;
 	size_t extra = 0;
 	size_t base = 0;
 
@@ -714,7 +716,7 @@ static void cache_estimate(unsigned long
 		extra = sizeof(kmem_bufctl_t);
 	}
 	i = 0;
-	while (i*size + ALIGN(base+i*extra, align) <= wastage)
+	while (i * size + ALIGN(base + i * extra, align) <= wastage)
 		i++;
 	if (i > 0)
 		i--;
@@ -723,17 +725,17 @@ static void cache_estimate(unsigned long
 		i = SLAB_LIMIT;
 
 	*num = i;
-	wastage -= i*size;
-	wastage -= ALIGN(base+i*extra, align);
+	wastage -= i * size;
+	wastage -= ALIGN(base + i * extra, align);
 	*left_over = wastage;
 }
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)
 
-static void __slab_error(const char *function, kmem_cache_t *cachep, char *msg)
+static void __slab_error(const char *function, kmem_cache_t * cachep, char *msg)
 {
 	printk(KERN_ERR "slab error in %s(): cache `%s': %s\n",
-		function, cachep->name, msg);
+	       function, cachep->name, msg);
 	dump_stack();
 }
 
@@ -760,9 +762,9 @@ static void __devinit start_cpu_timer(in
 }
 
 static struct array_cache *alloc_arraycache(int node, int entries,
-						int batchcount)
+					    int batchcount)
 {
-	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
+	int memsize = sizeof(void *) * entries + sizeof(struct array_cache);
 	struct array_cache *nc = NULL;
 
 	nc = kmalloc_node(memsize, GFP_KERNEL, node);
@@ -780,7 +782,7 @@ static struct array_cache *alloc_arrayca
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
 	struct array_cache **ac_ptr;
-	int memsize = sizeof(void*)*MAX_NUMNODES;
+	int memsize = sizeof(void *) * MAX_NUMNODES;
 	int i;
 
 	if (limit > 1)
@@ -794,7 +796,7 @@ static inline struct array_cache **alloc
 			}
 			ac_ptr[i] = alloc_arraycache(node, limit, 0xbaadf00d);
 			if (!ac_ptr[i]) {
-				for (i--; i <=0; i--)
+				for (i--; i <= 0; i--)
 					kfree(ac_ptr[i]);
 				kfree(ac_ptr);
 				return NULL;
@@ -812,12 +814,13 @@ static inline void free_alien_cache(stru
 		return;
 
 	for_each_node(i)
-		kfree(ac_ptr[i]);
+	    kfree(ac_ptr[i]);
 
 	kfree(ac_ptr);
 }
 
-static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
+static inline void __drain_alien_cache(kmem_cache_t * cachep,
+				       struct array_cache *ac, int node)
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
@@ -829,9 +832,9 @@ static inline void __drain_alien_cache(k
 	}
 }
 
-static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
+static void drain_alien_cache(kmem_cache_t * cachep, struct kmem_list3 *l3)
 {
-	int i=0;
+	int i = 0;
 	struct array_cache *ac;
 	unsigned long flags;
 
@@ -851,10 +854,10 @@ static void drain_alien_cache(kmem_cache
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
@@ -876,27 +879,27 @@ static int __devinit cpuup_callback(stru
 			 */
 			if (!cachep->nodelists[node]) {
 				if (!(l3 = kmalloc_node(memsize,
-						GFP_KERNEL, node)))
+							GFP_KERNEL, node)))
 					goto bad;
 				kmem_list3_init(l3);
 				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-				  ((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+				    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
 				cachep->nodelists[node] = l3;
 			}
 
 			spin_lock_irq(&cachep->nodelists[node]->list_lock);
 			cachep->nodelists[node]->free_limit =
-				(1 + nr_cpus_node(node)) *
-				cachep->batchcount + cachep->num;
+			    (1 + nr_cpus_node(node)) *
+			    cachep->batchcount + cachep->num;
 			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
 		}
 
 		/* Now we can go ahead with allocating the shared array's
-		  & array cache's */
+		   & array cache's */
 		list_for_each_entry(cachep, &cache_chain, next) {
 			nc = alloc_arraycache(node, cachep->limit,
-					cachep->batchcount);
+					      cachep->batchcount);
 			if (!nc)
 				goto bad;
 			cachep->array[cpu] = nc;
@@ -905,12 +908,13 @@ static int __devinit cpuup_callback(stru
 			BUG_ON(!l3);
 			if (!l3->shared) {
 				if (!(nc = alloc_arraycache(node,
-					cachep->shared*cachep->batchcount,
-					0xbaadf00d)))
-					goto  bad;
+							    cachep->shared *
+							    cachep->batchcount,
+							    0xbaadf00d)))
+					goto bad;
 
 				/* we are serialised from CPU_DEAD or
-				  CPU_UP_CANCELLED by the cpucontrol lock */
+				   CPU_UP_CANCELLED by the cpucontrol lock */
 				l3->shared = nc;
 			}
 		}
@@ -947,13 +951,13 @@ static int __devinit cpuup_callback(stru
 				free_block(cachep, nc->entry, nc->avail, node);
 
 			if (!cpus_empty(mask)) {
-                                spin_unlock(&l3->list_lock);
-                                goto unlock_cache;
-                        }
+				spin_unlock(&l3->list_lock);
+				goto unlock_cache;
+			}
 
 			if (l3->shared) {
 				free_block(cachep, l3->shared->entry,
-						l3->shared->avail, node);
+					   l3->shared->avail, node);
 				kfree(l3->shared);
 				l3->shared = NULL;
 			}
@@ -971,7 +975,7 @@ static int __devinit cpuup_callback(stru
 			} else {
 				spin_unlock(&l3->list_lock);
 			}
-unlock_cache:
+		      unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
 		}
@@ -980,7 +984,7 @@ unlock_cache:
 #endif
 	}
 	return NOTIFY_OK;
-bad:
+      bad:
 	up(&cache_chain_sem);
 	return NOTIFY_BAD;
 }
@@ -990,8 +994,8 @@ static struct notifier_block cpucache_no
 /*
  * swap the static kmem_list3 with kmalloced memory
  */
-static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list,
-		int nodeid)
+static void init_list(kmem_cache_t * cachep, struct kmem_list3 *list,
+		      int nodeid)
 {
 	struct kmem_list3 *ptr;
 
@@ -1060,14 +1064,14 @@ void __init kmem_cache_init(void)
 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());
 
 	cache_estimate(0, cache_cache.objsize, cache_line_size(), 0,
-				&left_over, &cache_cache.num);
+		       &left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
 
-	cache_cache.colour = left_over/cache_cache.colour_off;
+	cache_cache.colour = left_over / cache_cache.colour_off;
 	cache_cache.colour_next = 0;
-	cache_cache.slab_size = ALIGN(cache_cache.num*sizeof(kmem_bufctl_t) +
-				sizeof(struct slab), cache_line_size());
+	cache_cache.slab_size = ALIGN(cache_cache.num * sizeof(kmem_bufctl_t) +
+				      sizeof(struct slab), cache_line_size());
 
 	/* 2+3) create the kmalloc caches */
 	sizes = malloc_sizes;
@@ -1079,14 +1083,18 @@ void __init kmem_cache_init(void)
 	 */
 
 	sizes[INDEX_AC].cs_cachep = kmem_cache_create(names[INDEX_AC].name,
-				sizes[INDEX_AC].cs_size, ARCH_KMALLOC_MINALIGN,
-				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+						      sizes[INDEX_AC].cs_size,
+						      ARCH_KMALLOC_MINALIGN,
+						      (ARCH_KMALLOC_FLAGS |
+						       SLAB_PANIC), NULL, NULL);
 
 	if (INDEX_AC != INDEX_L3)
 		sizes[INDEX_L3].cs_cachep =
-			kmem_cache_create(names[INDEX_L3].name,
-				sizes[INDEX_L3].cs_size, ARCH_KMALLOC_MINALIGN,
-				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+		    kmem_cache_create(names[INDEX_L3].name,
+				      sizes[INDEX_L3].cs_size,
+				      ARCH_KMALLOC_MINALIGN,
+				      (ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL,
+				      NULL);
 
 	while (sizes->cs_size != ULONG_MAX) {
 		/*
@@ -1096,35 +1104,41 @@ void __init kmem_cache_init(void)
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches.
 		 */
-		if(!sizes->cs_cachep)
+		if (!sizes->cs_cachep)
 			sizes->cs_cachep = kmem_cache_create(names->name,
-				sizes->cs_size, ARCH_KMALLOC_MINALIGN,
-				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+							     sizes->cs_size,
+							     ARCH_KMALLOC_MINALIGN,
+							     (ARCH_KMALLOC_FLAGS
+							      | SLAB_PANIC),
+							     NULL, NULL);
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
-			offslab_limit = sizes->cs_size-sizeof(struct slab);
+			offslab_limit = sizes->cs_size - sizeof(struct slab);
 			offslab_limit /= sizeof(kmem_bufctl_t);
 		}
 
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
-			sizes->cs_size, ARCH_KMALLOC_MINALIGN,
-			(ARCH_KMALLOC_FLAGS | SLAB_CACHE_DMA | SLAB_PANIC),
-			NULL, NULL);
+							sizes->cs_size,
+							ARCH_KMALLOC_MINALIGN,
+							(ARCH_KMALLOC_FLAGS |
+							 SLAB_CACHE_DMA |
+							 SLAB_PANIC), NULL,
+							NULL);
 
 		sizes++;
 		names++;
 	}
 	/* 4) Replace the bootstrap head arrays */
 	{
-		void * ptr;
+		void *ptr;
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
 		local_irq_disable();
 		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
 		memcpy(ptr, ac_data(&cache_cache),
-				sizeof(struct arraycache_init));
+		       sizeof(struct arraycache_init));
 		cache_cache.array[smp_processor_id()] = ptr;
 		local_irq_enable();
 
@@ -1132,11 +1146,11 @@ void __init kmem_cache_init(void)
 
 		local_irq_disable();
 		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)
-				!= &initarray_generic.cache);
+		       != &initarray_generic.cache);
 		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
-				sizeof(struct arraycache_init));
+		       sizeof(struct arraycache_init));
 		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
-						ptr;
+		    ptr;
 		local_irq_enable();
 	}
 	/* 5) Replace the bootstrap kmem_list3's */
@@ -1144,16 +1158,16 @@ void __init kmem_cache_init(void)
 		int node;
 		/* Replace the static kmem_list3 structures for the boot cpu */
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
-				numa_node_id());
+			  numa_node_id());
 
 		for_each_online_node(node) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
-					&initkmem_list3[SIZE_AC+node], node);
+				  &initkmem_list3[SIZE_AC + node], node);
 
 			if (INDEX_AC != INDEX_L3) {
 				init_list(malloc_sizes[INDEX_L3].cs_cachep,
-						&initkmem_list3[SIZE_L3+node],
-						node);
+					  &initkmem_list3[SIZE_L3 + node],
+					  node);
 			}
 		}
 	}
@@ -1163,7 +1177,7 @@ void __init kmem_cache_init(void)
 		kmem_cache_t *cachep;
 		down(&cache_chain_sem);
 		list_for_each_entry(cachep, &cache_chain, next)
-			enable_cpucache(cachep);
+		    enable_cpucache(cachep);
 		up(&cache_chain_sem);
 	}
 
@@ -1189,7 +1203,7 @@ static int __init cpucache_init(void)
 	 * pages to gfp.
 	 */
 	for_each_online_cpu(cpu)
-		start_cpu_timer(cpu);
+	    start_cpu_timer(cpu);
 
 	return 0;
 }
@@ -1203,7 +1217,7 @@ __initcall(cpucache_init);
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
  */
-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *kmem_getpages(kmem_cache_t * cachep, gfp_t flags, int nodeid)
 {
 	struct page *page;
 	void *addr;
@@ -1229,9 +1243,9 @@ static void *kmem_getpages(kmem_cache_t 
 /*
  * Interface to system's page release.
  */
-static void kmem_freepages(kmem_cache_t *cachep, void *addr)
+static void kmem_freepages(kmem_cache_t * cachep, void *addr)
 {
-	unsigned long i = (1<<cachep->gfporder);
+	unsigned long i = (1 << cachep->gfporder);
 	struct page *page = virt_to_page(addr);
 	const unsigned long nr_freed = i;
 
@@ -1244,13 +1258,13 @@ static void kmem_freepages(kmem_cache_t 
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
-	if (cachep->flags & SLAB_RECLAIM_ACCOUNT) 
-		atomic_sub(1<<cachep->gfporder, &slab_reclaim_pages);
+	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
+		atomic_sub(1 << cachep->gfporder, &slab_reclaim_pages);
 }
 
 static void kmem_rcu_free(struct rcu_head *head)
 {
-	struct slab_rcu *slab_rcu = (struct slab_rcu *) head;
+	struct slab_rcu *slab_rcu = (struct slab_rcu *)head;
 	kmem_cache_t *cachep = slab_rcu->cachep;
 
 	kmem_freepages(cachep, slab_rcu->addr);
@@ -1261,20 +1275,20 @@ static void kmem_rcu_free(struct rcu_hea
 #if DEBUG
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
-				unsigned long caller)
+static void store_stackinfo(kmem_cache_t * cachep, unsigned long *addr,
+			    unsigned long caller)
 {
 	int size = obj_size(cachep);
 
-	addr = (unsigned long *)&((char*)addr)[obj_dbghead(cachep)];
+	addr = (unsigned long *)&((char *)addr)[obj_dbghead(cachep)];
 
-	if (size < 5*sizeof(unsigned long))
+	if (size < 5 * sizeof(unsigned long))
 		return;
 
-	*addr++=0x12345678;
-	*addr++=caller;
-	*addr++=smp_processor_id();
-	size -= 3*sizeof(unsigned long);
+	*addr++ = 0x12345678;
+	*addr++ = caller;
+	*addr++ = smp_processor_id();
+	size -= 3 * sizeof(unsigned long);
 	{
 		unsigned long *sptr = &caller;
 		unsigned long svalue;
@@ -1282,7 +1296,7 @@ static void store_stackinfo(kmem_cache_t
 		while (!kstack_end(sptr)) {
 			svalue = *sptr++;
 			if (kernel_text_address(svalue)) {
-				*addr++=svalue;
+				*addr++ = svalue;
 				size -= sizeof(unsigned long);
 				if (size <= sizeof(unsigned long))
 					break;
@@ -1290,25 +1304,25 @@ static void store_stackinfo(kmem_cache_t
 		}
 
 	}
-	*addr++=0x87654321;
+	*addr++ = 0x87654321;
 }
 #endif
 
-static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
+static void poison_obj(kmem_cache_t * cachep, void *addr, unsigned char val)
 {
 	int size = obj_size(cachep);
-	addr = &((char*)addr)[obj_dbghead(cachep)];
+	addr = &((char *)addr)[obj_dbghead(cachep)];
 
 	memset(addr, val, size);
-	*(unsigned char *)(addr+size-1) = POISON_END;
+	*(unsigned char *)(addr + size - 1) = POISON_END;
 }
 
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
 	printk(KERN_ERR "%03x:", offset);
-	for (i=0;i<limit;i++) {
-		printk(" %02x", (unsigned char)data[offset+i]);
+	for (i = 0; i < limit; i++) {
+		printk(" %02x", (unsigned char)data[offset + i]);
 	}
 	printk("\n");
 }
@@ -1316,62 +1330,63 @@ static void dump_line(char *data, int of
 
 #if DEBUG
 
-static void print_objinfo(kmem_cache_t *cachep, void *objp, int lines)
+static void print_objinfo(kmem_cache_t * cachep, void *objp, int lines)
 {
 	int i, size;
 	char *realobj;
 
 	if (cachep->flags & SLAB_RED_ZONE) {
 		printk(KERN_ERR "Redzone: 0x%lx/0x%lx.\n",
-			*dbg_redzone1(cachep, objp),
-			*dbg_redzone2(cachep, objp));
+		       *dbg_redzone1(cachep, objp),
+		       *dbg_redzone2(cachep, objp));
 	}
 
 	if (cachep->flags & SLAB_STORE_USER) {
 		printk(KERN_ERR "Last user: [<%p>]",
-				*dbg_userword(cachep, objp));
+		       *dbg_userword(cachep, objp));
 		print_symbol("(%s)",
-				(unsigned long)*dbg_userword(cachep, objp));
+			     (unsigned long)*dbg_userword(cachep, objp));
 		printk("\n");
 	}
-	realobj = (char*)objp+obj_dbghead(cachep);
+	realobj = (char *)objp + obj_dbghead(cachep);
 	size = obj_size(cachep);
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
 
-static void check_poison_obj(kmem_cache_t *cachep, void *objp)
+static void check_poison_obj(kmem_cache_t * cachep, void *objp)
 {
 	char *realobj;
 	int size, i;
 	int lines = 0;
 
-	realobj = (char*)objp+obj_dbghead(cachep);
+	realobj = (char *)objp + obj_dbghead(cachep);
 	size = obj_size(cachep);
 
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
+				printk(KERN_ERR
+				       "Slab corruption: start=%p, len=%d\n",
+				       realobj, size);
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
@@ -1387,19 +1402,19 @@ static void check_poison_obj(kmem_cache_
 		struct slab *slabp = page_get_slab(virt_to_page(objp));
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
@@ -1410,7 +1425,7 @@ static void check_poison_obj(kmem_cache_
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
-static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy(kmem_cache_t * cachep, struct slab *slabp)
 {
 	void *addr = slabp->s_mem - slabp->colouroff;
 
@@ -1421,8 +1436,11 @@ static void slab_destroy (kmem_cache_t *
 
 		if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-			if ((cachep->objsize%PAGE_SIZE)==0 && OFF_SLAB(cachep))
-				kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE,1);
+			if ((cachep->objsize % PAGE_SIZE) == 0
+			    && OFF_SLAB(cachep))
+				kernel_map_pages(virt_to_page(objp),
+						 cachep->objsize / PAGE_SIZE,
+						 1);
 			else
 				check_poison_obj(cachep, objp);
 #else
@@ -1432,20 +1450,20 @@ static void slab_destroy (kmem_cache_t *
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
 				slab_error(cachep, "start of a freed object "
-							"was overwritten");
+					   "was overwritten");
 			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
 				slab_error(cachep, "end of a freed object "
-							"was overwritten");
+					   "was overwritten");
 		}
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
-			(cachep->dtor)(objp+obj_dbghead(cachep), cachep, 0);
+			(cachep->dtor) (objp + obj_dbghead(cachep), cachep, 0);
 	}
 #else
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
-			void* objp = slabp->s_mem+cachep->objsize*i;
-			(cachep->dtor)(objp, cachep, 0);
+			void *objp = slabp->s_mem + cachep->objsize * i;
+			(cachep->dtor) (objp, cachep, 0);
 		}
 	}
 #endif
@@ -1453,7 +1471,7 @@ static void slab_destroy (kmem_cache_t *
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
 		struct slab_rcu *slab_rcu;
 
-		slab_rcu = (struct slab_rcu *) slabp;
+		slab_rcu = (struct slab_rcu *)slabp;
 		slab_rcu->cachep = cachep;
 		slab_rcu->addr = addr;
 		call_rcu(&slab_rcu->head, kmem_rcu_free);
@@ -1466,15 +1484,15 @@ static void slab_destroy (kmem_cache_t *
 
 /* For setting up all the kmem_list3s for cache whose objsize is same
    as size of kmem_list3. */
-static inline void set_up_list3s(kmem_cache_t *cachep, int index)
+static inline void set_up_list3s(kmem_cache_t * cachep, int index)
 {
 	int node;
 
 	for_each_online_node(node) {
-		cachep->nodelists[node] = &initkmem_list3[index+node];
+		cachep->nodelists[node] = &initkmem_list3[index + node];
 		cachep->nodelists[node]->next_reap = jiffies +
-			REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+		    REAPTIMEOUT_LIST3 +
+		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 	}
 }
 
@@ -1486,12 +1504,12 @@ static inline void set_up_list3s(kmem_ca
  * high order pages for slabs.  When the gfp() functions are more friendly
  * towards high-order requests, this should be changed.
  */
-static inline size_t calculate_slab_order(kmem_cache_t *cachep, size_t size,
+static inline size_t calculate_slab_order(kmem_cache_t * cachep, size_t size,
 					  size_t align, gfp_t flags)
 {
 	size_t left_over = 0;
 
-	for ( ; ; cachep->gfporder++) {
+	for (;; cachep->gfporder++) {
 		unsigned int num;
 		size_t remainder;
 
@@ -1571,14 +1593,13 @@ kmem_cache_create (const char *name, siz
 	 * Sanity checks... these are all serious usage bugs.
 	 */
 	if ((!name) ||
-		in_interrupt() ||
-		(size < BYTES_PER_WORD) ||
-		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
-		(dtor && !ctor)) {
-			printk(KERN_ERR "%s: Early error in slab %s\n",
-					__FUNCTION__, name);
-			BUG();
-		}
+	    in_interrupt() ||
+	    (size < BYTES_PER_WORD) ||
+	    (size > (1 << MAX_OBJ_ORDER) * PAGE_SIZE) || (dtor && !ctor)) {
+		printk(KERN_ERR "%s: Early error in slab %s\n",
+		       __FUNCTION__, name);
+		BUG();
+	}
 
 	down(&cache_chain_sem);
 
@@ -1598,11 +1619,11 @@ kmem_cache_create (const char *name, siz
 		set_fs(old_fs);
 		if (res) {
 			printk("SLAB: cache with size %d has lost its name\n",
-					pc->objsize);
+			       pc->objsize);
 			continue;
 		}
 
-		if (!strcmp(pc->name,name)) {
+		if (!strcmp(pc->name, name)) {
 			printk("kmem_cache_create: duplicate cache %s\n", name);
 			dump_stack();
 			goto oops;
@@ -1614,10 +1635,9 @@ kmem_cache_create (const char *name, siz
 	if ((flags & SLAB_DEBUG_INITIAL) && !ctor) {
 		/* No constructor, but inital state check requested */
 		printk(KERN_ERR "%s: No con, but init state check "
-				"requested - %s\n", __FUNCTION__, name);
+		       "requested - %s\n", __FUNCTION__, name);
 		flags &= ~SLAB_DEBUG_INITIAL;
 	}
-
 #if FORCED_DEBUG
 	/*
 	 * Enable redzoning and last user accounting, except for caches with
@@ -1625,8 +1645,9 @@ kmem_cache_create (const char *name, siz
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
-		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
+	if ((size < 4096
+	     || fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD)))
+		flags |= SLAB_RED_ZONE | SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
 #endif
@@ -1647,9 +1668,9 @@ kmem_cache_create (const char *name, siz
 	 * unaligned accesses for some archs when redzoning is used, and makes
 	 * sure any on-slab bufctl's are also correctly aligned.
 	 */
-	if (size & (BYTES_PER_WORD-1)) {
-		size += (BYTES_PER_WORD-1);
-		size &= ~(BYTES_PER_WORD-1);
+	if (size & (BYTES_PER_WORD - 1)) {
+		size += (BYTES_PER_WORD - 1);
+		size &= ~(BYTES_PER_WORD - 1);
 	}
 
 	/* calculate out the final buffer alignment: */
@@ -1660,7 +1681,7 @@ kmem_cache_create (const char *name, siz
 		 * objects into one cacheline.
 		 */
 		ralign = cache_line_size();
-		while (size <= ralign/2)
+		while (size <= ralign / 2)
 			ralign /= 2;
 	} else {
 		ralign = BYTES_PER_WORD;
@@ -1669,13 +1690,13 @@ kmem_cache_create (const char *name, siz
 	if (ralign < ARCH_SLAB_MINALIGN) {
 		ralign = ARCH_SLAB_MINALIGN;
 		if (ralign > BYTES_PER_WORD)
-			flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
+			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
 	/* 3) caller mandated alignment: disables debug if necessary */
 	if (ralign < align) {
 		ralign = align;
 		if (ralign > BYTES_PER_WORD)
-			flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
+			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
 	/* 4) Store it. Note that the debug code below can reduce
 	 *    the alignment to BYTES_PER_WORD.
@@ -1697,7 +1718,7 @@ kmem_cache_create (const char *name, siz
 
 		/* add space for red zone words */
 		cachep->dbghead += BYTES_PER_WORD;
-		size += 2*BYTES_PER_WORD;
+		size += 2 * BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
 		/* user store requires word alignment and
@@ -1708,7 +1729,8 @@ kmem_cache_create (const char *name, siz
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
-	if (size >= malloc_sizes[INDEX_L3+1].cs_size && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
+	if (size >= malloc_sizes[INDEX_L3 + 1].cs_size
+	    && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
 		cachep->dbghead += PAGE_SIZE - size;
 		size = PAGE_SIZE;
 	}
@@ -1716,7 +1738,7 @@ kmem_cache_create (const char *name, siz
 #endif
 
 	/* Determine if the slab management is 'on' or 'off' slab. */
-	if (size >= (PAGE_SIZE>>3))
+	if (size >= (PAGE_SIZE >> 3))
 		/*
 		 * Size is large, assume best to place the slab management obj
 		 * off-slab (should allow better packing of objs).
@@ -1733,7 +1755,7 @@ kmem_cache_create (const char *name, siz
 		 */
 		cachep->gfporder = 0;
 		cache_estimate(cachep->gfporder, size, align, flags,
-					&left_over, &cachep->num);
+			       &left_over, &cachep->num);
 	} else
 		left_over = calculate_slab_order(cachep, size, align, flags);
 
@@ -1743,8 +1765,8 @@ kmem_cache_create (const char *name, siz
 		cachep = NULL;
 		goto oops;
 	}
-	slab_size = ALIGN(cachep->num*sizeof(kmem_bufctl_t)
-				+ sizeof(struct slab), align);
+	slab_size = ALIGN(cachep->num * sizeof(kmem_bufctl_t)
+			  + sizeof(struct slab), align);
 
 	/*
 	 * If the slab has been placed off-slab, and we have enough space then
@@ -1757,14 +1779,15 @@ kmem_cache_create (const char *name, siz
 
 	if (flags & CFLGS_OFF_SLAB) {
 		/* really off slab. No need for manual alignment */
-		slab_size = cachep->num*sizeof(kmem_bufctl_t)+sizeof(struct slab);
+		slab_size =
+		    cachep->num * sizeof(kmem_bufctl_t) + sizeof(struct slab);
 	}
 
 	cachep->colour_off = cache_line_size();
 	/* Offset must be a multiple of the alignment. */
 	if (cachep->colour_off < align)
 		cachep->colour_off = align;
-	cachep->colour = left_over/cachep->colour_off;
+	cachep->colour = left_over / cachep->colour_off;
 	cachep->slab_size = slab_size;
 	cachep->flags = flags;
 	cachep->gfpflags = 0;
@@ -1791,7 +1814,7 @@ kmem_cache_create (const char *name, siz
 			 * the creation of further caches will BUG().
 			 */
 			cachep->array[smp_processor_id()] =
-				&initarray_generic.cache;
+			    &initarray_generic.cache;
 
 			/* If the cache that's used by
 			 * kmalloc(sizeof(kmem_list3)) is the first cache,
@@ -1805,8 +1828,7 @@ kmem_cache_create (const char *name, siz
 				g_cpucache_up = PARTIAL_AC;
 		} else {
 			cachep->array[smp_processor_id()] =
-				kmalloc(sizeof(struct arraycache_init),
-						GFP_KERNEL);
+			    kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
 			if (g_cpucache_up == PARTIAL_AC) {
 				set_up_list3s(cachep, SIZE_L3);
@@ -1816,16 +1838,18 @@ kmem_cache_create (const char *name, siz
 				for_each_online_node(node) {
 
 					cachep->nodelists[node] =
-						kmalloc_node(sizeof(struct kmem_list3),
-								GFP_KERNEL, node);
+					    kmalloc_node(sizeof
+							 (struct kmem_list3),
+							 GFP_KERNEL, node);
 					BUG_ON(!cachep->nodelists[node]);
-					kmem_list3_init(cachep->nodelists[node]);
+					kmem_list3_init(cachep->
+							nodelists[node]);
 				}
 			}
 		}
 		cachep->nodelists[numa_node_id()]->next_reap =
-			jiffies + REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+		    jiffies + REAPTIMEOUT_LIST3 +
+		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
 		BUG_ON(!ac_data(cachep));
 		ac_data(cachep)->avail = 0;
@@ -1834,18 +1858,19 @@ kmem_cache_create (const char *name, siz
 		ac_data(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
-	} 
+	}
 
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
 	unlock_cpu_hotplug();
-oops:
+      oops:
 	if (!cachep && (flags & SLAB_PANIC))
 		panic("kmem_cache_create(): failed to create slab `%s'\n",
-			name);
+		      name);
 	up(&cache_chain_sem);
 	return cachep;
 }
+
 EXPORT_SYMBOL(kmem_cache_create);
 
 #if DEBUG
@@ -1859,7 +1884,7 @@ static void check_irq_on(void)
 	BUG_ON(irqs_disabled());
 }
 
-static void check_spinlock_acquired(kmem_cache_t *cachep)
+static void check_spinlock_acquired(kmem_cache_t * cachep)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
@@ -1867,7 +1892,7 @@ static void check_spinlock_acquired(kmem
 #endif
 }
 
-static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+static inline void check_spinlock_acquired_node(kmem_cache_t * cachep, int node)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
@@ -1900,12 +1925,12 @@ static void smp_call_function_all_cpus(v
 	preempt_enable();
 }
 
-static void drain_array_locked(kmem_cache_t* cachep,
-				struct array_cache *ac, int force, int node);
+static void drain_array_locked(kmem_cache_t * cachep,
+			       struct array_cache *ac, int force, int node);
 
 static void do_drain(void *arg)
 {
-	kmem_cache_t *cachep = (kmem_cache_t*)arg;
+	kmem_cache_t *cachep = (kmem_cache_t *) arg;
 	struct array_cache *ac;
 	int node = numa_node_id();
 
@@ -1917,7 +1942,7 @@ static void do_drain(void *arg)
 	ac->avail = 0;
 }
 
-static void drain_cpu_caches(kmem_cache_t *cachep)
+static void drain_cpu_caches(kmem_cache_t * cachep)
 {
 	struct kmem_list3 *l3;
 	int node;
@@ -1925,7 +1950,7 @@ static void drain_cpu_caches(kmem_cache_
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	for_each_online_node(node)  {
+	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
 		if (l3) {
 			spin_lock(&l3->list_lock);
@@ -1938,7 +1963,7 @@ static void drain_cpu_caches(kmem_cache_
 	spin_unlock_irq(&cachep->spinlock);
 }
 
-static int __node_shrink(kmem_cache_t *cachep, int node)
+static int __node_shrink(kmem_cache_t * cachep, int node)
 {
 	struct slab *slabp;
 	struct kmem_list3 *l3 = cachep->nodelists[node];
@@ -1963,12 +1988,11 @@ static int __node_shrink(kmem_cache_t *c
 		slab_destroy(cachep, slabp);
 		spin_lock_irq(&l3->list_lock);
 	}
-	ret = !list_empty(&l3->slabs_full) ||
-		!list_empty(&l3->slabs_partial);
+	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
 	return ret;
 }
 
-static int __cache_shrink(kmem_cache_t *cachep)
+static int __cache_shrink(kmem_cache_t * cachep)
 {
 	int ret = 0, i = 0;
 	struct kmem_list3 *l3;
@@ -1994,13 +2018,14 @@ static int __cache_shrink(kmem_cache_t *
  * Releases as many slabs as possible for a cache.
  * To help debugging, a zero exit status indicates all slabs were released.
  */
-int kmem_cache_shrink(kmem_cache_t *cachep)
+int kmem_cache_shrink(kmem_cache_t * cachep)
 {
 	if (!cachep || in_interrupt())
 		BUG();
 
 	return __cache_shrink(cachep);
 }
+
 EXPORT_SYMBOL(kmem_cache_shrink);
 
 /**
@@ -2042,7 +2067,7 @@ int kmem_cache_destroy(kmem_cache_t * ca
 	if (__cache_shrink(cachep)) {
 		slab_error(cachep, "Can't free all objects");
 		down(&cache_chain_sem);
-		list_add(&cachep->next,&cache_chain);
+		list_add(&cachep->next, &cache_chain);
 		up(&cache_chain_sem);
 		unlock_cpu_hotplug();
 		return 1;
@@ -2052,7 +2077,7 @@ int kmem_cache_destroy(kmem_cache_t * ca
 		synchronize_rcu();
 
 	for_each_online_cpu(i)
-		kfree(cachep->array[i]);
+	    kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
 	for_each_online_node(i) {
@@ -2068,42 +2093,43 @@ int kmem_cache_destroy(kmem_cache_t * ca
 
 	return 0;
 }
+
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
-			int colour_off, gfp_t local_flags)
+static struct slab *alloc_slabmgmt(kmem_cache_t * cachep, void *objp,
+				   int colour_off, gfp_t local_flags)
 {
 	struct slab *slabp;
-	
+
 	if (OFF_SLAB(cachep)) {
 		/* Slab management obj is off-slab. */
 		slabp = kmem_cache_alloc(cachep->slabp_cache, local_flags);
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
+	return (kmem_bufctl_t *) (slabp + 1);
 }
 
-static void cache_init_objs(kmem_cache_t *cachep,
-			struct slab *slabp, unsigned long ctor_flags)
+static void cache_init_objs(kmem_cache_t * cachep,
+			    struct slab *slabp, unsigned long ctor_flags)
 {
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem+cachep->objsize*i;
+		void *objp = slabp->s_mem + cachep->objsize * i;
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -2121,29 +2147,32 @@ static void cache_init_objs(kmem_cache_t
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
 		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
-			cachep->ctor(objp+obj_dbghead(cachep), cachep, ctor_flags);
+			cachep->ctor(objp + obj_dbghead(cachep), cachep,
+				     ctor_flags);
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
 				slab_error(cachep, "constructor overwrote the"
-							" end of an object");
+					   " end of an object");
 			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
 				slab_error(cachep, "constructor overwrote the"
-							" start of an object");
+					   " start of an object");
 		}
-		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep) && cachep->flags & SLAB_POISON)
-	       		kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 0);
+		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep)
+		    && cachep->flags & SLAB_POISON)
+			kernel_map_pages(virt_to_page(objp),
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
 
-static void kmem_flagcheck(kmem_cache_t *cachep, gfp_t flags)
+static void kmem_flagcheck(kmem_cache_t * cachep, gfp_t flags)
 {
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
@@ -2154,7 +2183,7 @@ static void kmem_flagcheck(kmem_cache_t 
 	}
 }
 
-static void set_slab_attr(kmem_cache_t *cachep, struct slab *slabp, void *objp)
+static void set_slab_attr(kmem_cache_t * cachep, struct slab *slabp, void *objp)
 {
 	int i;
 	struct page *page;
@@ -2173,19 +2202,19 @@ static void set_slab_attr(kmem_cache_t *
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static int cache_grow(kmem_cache_t * cachep, gfp_t flags, int nodeid)
 {
-	struct slab	*slabp;
-	void		*objp;
-	size_t		 offset;
-	gfp_t	 	 local_flags;
-	unsigned long	 ctor_flags;
+	struct slab *slabp;
+	void *objp;
+	size_t offset;
+	gfp_t local_flags;
+	unsigned long ctor_flags;
 	struct kmem_list3 *l3;
 
 	/* Be lazy and only check for valid flags here,
- 	 * keeping it out of the critical path in kmem_cache_alloc().
+	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
-	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
+	if (flags & ~(SLAB_DMA | SLAB_LEVEL_MASK | SLAB_NO_GROW))
 		BUG();
 	if (flags & SLAB_NO_GROW)
 		return 0;
@@ -2251,9 +2280,9 @@ static int cache_grow(kmem_cache_t *cach
 	l3->free_objects += cachep->num;
 	spin_unlock(&l3->list_lock);
 	return 1;
-opps1:
+      opps1:
 	kmem_freepages(cachep, objp);
-failed:
+      failed:
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	return 0;
@@ -2273,18 +2302,19 @@ static void kfree_debugcheck(const void 
 
 	if (!virt_addr_valid(objp)) {
 		printk(KERN_ERR "kfree_debugcheck: out of range ptr %lxh.\n",
-			(unsigned long)objp);	
-		BUG();	
+		       (unsigned long)objp);
+		BUG();
 	}
 	page = virt_to_page(objp);
 	if (!PageSlab(page)) {
-		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n", (unsigned long)objp);
+		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n",
+		       (unsigned long)objp);
 		BUG();
 	}
 }
 
-static void *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
-					void *caller)
+static void *cache_free_debugcheck(kmem_cache_t * cachep, void *objp,
+				   void *caller)
 {
 	struct page *page;
 	unsigned int objnr;
@@ -2295,20 +2325,26 @@ static void *cache_free_debugcheck(kmem_
 	page = virt_to_page(objp);
 
 	if (page_get_cache(page) != cachep) {
-		printk(KERN_ERR "mismatch in kmem_cache_free: expected cache %p, got %p\n",
-				page_get_cache(page),cachep);
+		printk(KERN_ERR
+		       "mismatch in kmem_cache_free: expected cache %p, got %p\n",
+		       page_get_cache(page), cachep);
 		printk(KERN_ERR "%p is %s.\n", cachep, cachep->name);
-		printk(KERN_ERR "%p is %s.\n", page_get_cache(page), page_get_cache(page)->name);
+		printk(KERN_ERR "%p is %s.\n", page_get_cache(page),
+		       page_get_cache(page)->name);
 		WARN_ON(1);
 	}
 	slabp = page_get_slab(page);
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE || *dbg_redzone2(cachep, objp) != RED_ACTIVE) {
-			slab_error(cachep, "double free, or memory outside"
-						" object was overwritten");
-			printk(KERN_ERR "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
-					objp, *dbg_redzone1(cachep, objp), *dbg_redzone2(cachep, objp));
+		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE
+		    || *dbg_redzone2(cachep, objp) != RED_ACTIVE) {
+			slab_error(cachep,
+				   "double free, or memory outside"
+				   " object was overwritten");
+			printk(KERN_ERR
+			       "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
+			       objp, *dbg_redzone1(cachep, objp),
+			       *dbg_redzone2(cachep, objp));
 		}
 		*dbg_redzone1(cachep, objp) = RED_INACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_INACTIVE;
@@ -2316,30 +2352,31 @@ static void *cache_free_debugcheck(kmem_
 	if (cachep->flags & SLAB_STORE_USER)
 		*dbg_userword(cachep, objp) = caller;
 
-	objnr = (objp-slabp->s_mem)/cachep->objsize;
+	objnr = (objp - slabp->s_mem) / cachep->objsize;
 
 	BUG_ON(objnr >= cachep->num);
-	BUG_ON(objp != slabp->s_mem + objnr*cachep->objsize);
+	BUG_ON(objp != slabp->s_mem + objnr * cachep->objsize);
 
 	if (cachep->flags & SLAB_DEBUG_INITIAL) {
 		/* Need to call the slab's constructor so the
 		 * caller can perform a verify of its state (debugging).
 		 * Called without the cache-lock held.
 		 */
-		cachep->ctor(objp+obj_dbghead(cachep),
-					cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
+		cachep->ctor(objp + obj_dbghead(cachep),
+			     cachep, SLAB_CTOR_CONSTRUCTOR | SLAB_CTOR_VERIFY);
 	}
 	if (cachep->flags & SLAB_POISON && cachep->dtor) {
 		/* we want to cache poison the object,
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
+			kernel_map_pages(virt_to_page(objp),
+					 cachep->objsize / PAGE_SIZE, 0);
 		} else {
 			poison_obj(cachep, objp, POISON_FREE);
 		}
@@ -2350,11 +2387,11 @@ static void *cache_free_debugcheck(kmem_
 	return objp;
 }
 
-static void check_slabp(kmem_cache_t *cachep, struct slab *slabp)
+static void check_slabp(kmem_cache_t * cachep, struct slab *slabp)
 {
 	kmem_bufctl_t i;
 	int entries = 0;
-	
+
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
 		entries++;
@@ -2362,13 +2399,16 @@ static void check_slabp(kmem_cache_t *ca
 			goto bad;
 	}
 	if (entries != cachep->num - slabp->inuse) {
-bad:
-		printk(KERN_ERR "slab: Internal list corruption detected in cache '%s'(%d), slabp %p(%d). Hexdump:\n",
-				cachep->name, cachep->num, slabp, slabp->inuse);
-		for (i=0;i<sizeof(slabp)+cachep->num*sizeof(kmem_bufctl_t);i++) {
-			if ((i%16)==0)
+	      bad:
+		printk(KERN_ERR
+		       "slab: Internal list corruption detected in cache '%s'(%d), slabp %p(%d). Hexdump:\n",
+		       cachep->name, cachep->num, slabp, slabp->inuse);
+		for (i = 0;
+		     i < sizeof(slabp) + cachep->num * sizeof(kmem_bufctl_t);
+		     i++) {
+			if ((i % 16) == 0)
 				printk("\n%03x:", i);
-			printk(" %02x", ((unsigned char*)slabp)[i]);
+			printk(" %02x", ((unsigned char *)slabp)[i]);
 		}
 		printk("\n");
 		BUG();
@@ -2380,7 +2420,7 @@ bad:
 #define check_slabp(x,y) do { } while(0)
 #endif
 
-static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
+static void *cache_alloc_refill(kmem_cache_t * cachep, gfp_t flags)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2388,7 +2428,7 @@ static void *cache_alloc_refill(kmem_cac
 
 	check_irq_off();
 	ac = ac_data(cachep);
-retry:
+      retry:
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
 		/* if there was little recent activity on this
@@ -2410,8 +2450,8 @@ retry:
 			shared_array->avail -= batchcount;
 			ac->avail = batchcount;
 			memcpy(ac->entry,
-				&(shared_array->entry[shared_array->avail]),
-				sizeof(void*)*batchcount);
+			       &(shared_array->entry[shared_array->avail]),
+			       sizeof(void *) * batchcount);
 			shared_array->touched = 1;
 			goto alloc_done;
 		}
@@ -2439,7 +2479,7 @@ retry:
 
 			/* get obj pointer */
 			ac->entry[ac->avail++] = slabp->s_mem +
-				slabp->free*cachep->objsize;
+			    slabp->free * cachep->objsize;
 
 			slabp->inuse++;
 			next = slab_bufctl(slabp)[slabp->free];
@@ -2447,7 +2487,7 @@ retry:
 			slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
 			WARN_ON(numa_node_id() != slabp->nodeid);
 #endif
-		       	slabp->free = next;
+			slabp->free = next;
 		}
 		check_slabp(cachep, slabp);
 
@@ -2459,9 +2499,9 @@ retry:
 			list_add(&slabp->list, &l3->slabs_partial);
 	}
 
-must_grow:
+      must_grow:
 	l3->free_objects -= ac->avail;
-alloc_done:
+      alloc_done:
 	spin_unlock(&l3->list_lock);
 
 	if (unlikely(!ac->avail)) {
@@ -2473,7 +2513,7 @@ alloc_done:
 		if (!x && ac->avail == 0)	// no objects in sight? abort
 			return NULL;
 
-		if (!ac->avail)		// objects refilled by interrupt?
+		if (!ac->avail)	// objects refilled by interrupt?
 			goto retry;
 	}
 	ac->touched = 1;
@@ -2481,7 +2521,7 @@ alloc_done:
 }
 
 static inline void
-cache_alloc_debugcheck_before(kmem_cache_t *cachep, gfp_t flags)
+cache_alloc_debugcheck_before(kmem_cache_t * cachep, gfp_t flags)
 {
 	might_sleep_if(flags & __GFP_WAIT);
 #if DEBUG
@@ -2490,16 +2530,16 @@ cache_alloc_debugcheck_before(kmem_cache
 }
 
 #if DEBUG
-static void *
-cache_alloc_debugcheck_after(kmem_cache_t *cachep,
-			gfp_t flags, void *objp, void *caller)
+static void *cache_alloc_debugcheck_after(kmem_cache_t * cachep,
+					  gfp_t flags, void *objp, void *caller)
 {
-	if (!objp)	
+	if (!objp)
 		return objp;
- 	if (cachep->flags & SLAB_POISON) {
+	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
 		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
-			kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 1);
+			kernel_map_pages(virt_to_page(objp),
+					 cachep->objsize / PAGE_SIZE, 1);
 		else
 			check_poison_obj(cachep, objp);
 #else
@@ -2511,33 +2551,37 @@ cache_alloc_debugcheck_after(kmem_cache_
 		*dbg_userword(cachep, objp) = caller;
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE || *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
-			slab_error(cachep, "double free, or memory outside"
-						" object was overwritten");
-			printk(KERN_ERR "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
-					objp, *dbg_redzone1(cachep, objp), *dbg_redzone2(cachep, objp));
+		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE
+		    || *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
+			slab_error(cachep,
+				   "double free, or memory outside"
+				   " object was overwritten");
+			printk(KERN_ERR
+			       "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
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
 
 		cachep->ctor(objp, cachep, ctor_flags);
-	}	
+	}
 	return objp;
 }
 #else
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *____cache_alloc(kmem_cache_t * cachep, gfp_t flags)
 {
-	void* objp;
+	void *objp;
 	struct array_cache *ac;
 
 	check_irq_off();
@@ -2553,10 +2597,10 @@ static inline void *____cache_alloc(kmem
 	return objp;
 }
 
-static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *__cache_alloc(kmem_cache_t * cachep, gfp_t flags)
 {
 	unsigned long save_flags;
-	void* objp;
+	void *objp;
 
 	cache_alloc_debugcheck_before(cachep, flags);
 
@@ -2564,7 +2608,7 @@ static inline void *__cache_alloc(kmem_c
 	objp = ____cache_alloc(cachep, flags);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					__builtin_return_address(0));
+					    __builtin_return_address(0));
 	prefetchw(objp);
 	return objp;
 }
@@ -2573,77 +2617,78 @@ static inline void *__cache_alloc(kmem_c
 /*
  * A interface to enable slab creation on nodeid
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *__cache_alloc_node(kmem_cache_t * cachep, gfp_t flags, int nodeid)
 {
 	struct list_head *entry;
- 	struct slab *slabp;
- 	struct kmem_list3 *l3;
- 	void *obj;
- 	kmem_bufctl_t next;
- 	int x;
-
- 	l3 = cachep->nodelists[nodeid];
- 	BUG_ON(!l3);
-
-retry:
- 	spin_lock(&l3->list_lock);
- 	entry = l3->slabs_partial.next;
- 	if (entry == &l3->slabs_partial) {
- 		l3->free_touched = 1;
- 		entry = l3->slabs_free.next;
- 		if (entry == &l3->slabs_free)
- 			goto must_grow;
- 	}
-
- 	slabp = list_entry(entry, struct slab, list);
- 	check_spinlock_acquired_node(cachep, nodeid);
- 	check_slabp(cachep, slabp);
-
- 	STATS_INC_NODEALLOCS(cachep);
- 	STATS_INC_ACTIVE(cachep);
- 	STATS_SET_HIGH(cachep);
-
- 	BUG_ON(slabp->inuse == cachep->num);
-
- 	/* get obj pointer */
- 	obj =  slabp->s_mem + slabp->free*cachep->objsize;
- 	slabp->inuse++;
- 	next = slab_bufctl(slabp)[slabp->free];
-#if DEBUG
- 	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-#endif
- 	slabp->free = next;
- 	check_slabp(cachep, slabp);
- 	l3->free_objects--;
- 	/* move slabp to correct slabp list: */
- 	list_del(&slabp->list);
-
- 	if (slabp->free == BUFCTL_END) {
- 		list_add(&slabp->list, &l3->slabs_full);
- 	} else {
- 		list_add(&slabp->list, &l3->slabs_partial);
- 	}
-
- 	spin_unlock(&l3->list_lock);
- 	goto done;
-
-must_grow:
- 	spin_unlock(&l3->list_lock);
- 	x = cache_grow(cachep, flags, nodeid);
-
- 	if (!x)
- 		return NULL;
-
- 	goto retry;
-done:
- 	return obj;
+	struct slab *slabp;
+	struct kmem_list3 *l3;
+	void *obj;
+	kmem_bufctl_t next;
+	int x;
+
+	l3 = cachep->nodelists[nodeid];
+	BUG_ON(!l3);
+
+      retry:
+	spin_lock(&l3->list_lock);
+	entry = l3->slabs_partial.next;
+	if (entry == &l3->slabs_partial) {
+		l3->free_touched = 1;
+		entry = l3->slabs_free.next;
+		if (entry == &l3->slabs_free)
+			goto must_grow;
+	}
+
+	slabp = list_entry(entry, struct slab, list);
+	check_spinlock_acquired_node(cachep, nodeid);
+	check_slabp(cachep, slabp);
+
+	STATS_INC_NODEALLOCS(cachep);
+	STATS_INC_ACTIVE(cachep);
+	STATS_SET_HIGH(cachep);
+
+	BUG_ON(slabp->inuse == cachep->num);
+
+	/* get obj pointer */
+	obj = slabp->s_mem + slabp->free * cachep->objsize;
+	slabp->inuse++;
+	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+#endif
+	slabp->free = next;
+	check_slabp(cachep, slabp);
+	l3->free_objects--;
+	/* move slabp to correct slabp list: */
+	list_del(&slabp->list);
+
+	if (slabp->free == BUFCTL_END) {
+		list_add(&slabp->list, &l3->slabs_full);
+	} else {
+		list_add(&slabp->list, &l3->slabs_partial);
+	}
+
+	spin_unlock(&l3->list_lock);
+	goto done;
+
+      must_grow:
+	spin_unlock(&l3->list_lock);
+	x = cache_grow(cachep, flags, nodeid);
+
+	if (!x)
+		return NULL;
+
+	goto retry;
+      done:
+	return obj;
 }
 #endif
 
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects, int node)
+static void free_block(kmem_cache_t * cachep, void **objpp, int nr_objects,
+		       int node)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2666,7 +2711,7 @@ static void free_block(kmem_cache_t *cac
 
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache "
-					"'%s', objp %p\n", cachep->name, objp);
+			       "'%s', objp %p\n", cachep->name, objp);
 			BUG();
 		}
 #endif
@@ -2695,7 +2740,7 @@ static void free_block(kmem_cache_t *cac
 	}
 }
 
-static void cache_flusharray(kmem_cache_t *cachep, struct array_cache *ac)
+static void cache_flusharray(kmem_cache_t * cachep, struct array_cache *ac)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2710,20 +2755,19 @@ static void cache_flusharray(kmem_cache_
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
 	}
 
 	free_block(cachep, ac->entry, batchcount, node);
-free_done:
+      free_done:
 #if STATS
 	{
 		int i = 0;
@@ -2745,10 +2789,9 @@ free_done:
 	spin_unlock(&l3->list_lock);
 	ac->avail -= batchcount;
 	memmove(ac->entry, &(ac->entry[batchcount]),
-			sizeof(void*)*ac->avail);
+		sizeof(void *) * ac->avail);
 }
 
-
 /*
  * __cache_free
  * Release an obj back to its cache. If the obj has a constructed
@@ -2756,7 +2799,7 @@ free_done:
  *
  * Called with disabled ints.
  */
-static inline void __cache_free(kmem_cache_t *cachep, void *objp)
+static inline void __cache_free(kmem_cache_t * cachep, void *objp)
 {
 	struct array_cache *ac = ac_data(cachep);
 
@@ -2773,7 +2816,8 @@ static inline void __cache_free(kmem_cac
 		if (unlikely(slabp->nodeid != numa_node_id())) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
-			struct kmem_list3 *l3 = cachep->nodelists[numa_node_id()];
+			struct kmem_list3 *l3 =
+			    cachep->nodelists[numa_node_id()];
 
 			STATS_INC_NODEFREES(cachep);
 			if (l3->alien && l3->alien[nodeid]) {
@@ -2781,15 +2825,15 @@ static inline void __cache_free(kmem_cac
 				spin_lock(&alien->lock);
 				if (unlikely(alien->avail == alien->limit))
 					__drain_alien_cache(cachep,
-							alien, nodeid);
+							    alien, nodeid);
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
-						list_lock);
+					  list_lock);
 				free_block(cachep, &objp, 1, nodeid);
 				spin_unlock(&(cachep->nodelists[nodeid])->
-						list_lock);
+					    list_lock);
 			}
 			return;
 		}
@@ -2814,10 +2858,11 @@ static inline void __cache_free(kmem_cac
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+void *kmem_cache_alloc(kmem_cache_t * cachep, gfp_t flags)
 {
 	return __cache_alloc(cachep, flags);
 }
+
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 /**
@@ -2834,11 +2879,11 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  *
  * Currently only used for dentry validation.
  */
-int fastcall kmem_ptr_validate(kmem_cache_t *cachep, void *ptr)
+int fastcall kmem_ptr_validate(kmem_cache_t * cachep, void *ptr)
 {
-	unsigned long addr = (unsigned long) ptr;
+	unsigned long addr = (unsigned long)ptr;
 	unsigned long min_addr = PAGE_OFFSET;
-	unsigned long align_mask = BYTES_PER_WORD-1;
+	unsigned long align_mask = BYTES_PER_WORD - 1;
 	unsigned long size = cachep->objsize;
 	struct page *page;
 
@@ -2858,7 +2903,7 @@ int fastcall kmem_ptr_validate(kmem_cach
 	if (unlikely(page_get_cache(page) != cachep))
 		goto out;
 	return 1;
-out:
+      out:
 	return 0;
 }
 
@@ -2875,7 +2920,7 @@ out:
  * New and improved: it will now make sure that the object gets
  * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t * cachep, gfp_t flags, int nodeid)
 {
 	unsigned long save_flags;
 	void *ptr;
@@ -2885,8 +2930,10 @@ void *kmem_cache_alloc_node(kmem_cache_t
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
-		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
-		return __cache_alloc(cachep,flags);
+		printk(KERN_WARNING
+		       "slab: not allocating in inactive node %d for cache %s\n",
+		       nodeid, cachep->name);
+		return __cache_alloc(cachep, flags);
 	}
 
 	cache_alloc_debugcheck_before(cachep, flags);
@@ -2896,10 +2943,13 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
+	ptr =
+	    cache_alloc_debugcheck_after(cachep, flags, ptr,
+					 __builtin_return_address(0));
 
 	return ptr;
 }
+
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 void *kmalloc_node(size_t size, gfp_t flags, int node)
@@ -2911,6 +2961,7 @@ void *kmalloc_node(size_t size, gfp_t fl
 		return NULL;
 	return kmem_cache_alloc_node(cachep, flags, node);
 }
+
 EXPORT_SYMBOL(kmalloc_node);
 #endif
 
@@ -2949,6 +3000,7 @@ void *__kmalloc(size_t size, gfp_t flags
 		return NULL;
 	return __cache_alloc(cachep, flags);
 }
+
 EXPORT_SYMBOL(__kmalloc);
 
 #ifdef CONFIG_SMP
@@ -2962,7 +3014,7 @@ EXPORT_SYMBOL(__kmalloc);
 void *__alloc_percpu(size_t size)
 {
 	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
+	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
 
 	if (!pdata)
 		return NULL;
@@ -2986,9 +3038,9 @@ void *__alloc_percpu(size_t size)
 	}
 
 	/* Catch derefs w/o wrappers */
-	return (void *) (~(unsigned long) pdata);
+	return (void *)(~(unsigned long)pdata);
 
-unwind_oom:
+      unwind_oom:
 	while (--i >= 0) {
 		if (!cpu_possible(i))
 			continue;
@@ -2997,6 +3049,7 @@ unwind_oom:
 	kfree(pdata);
 	return NULL;
 }
+
 EXPORT_SYMBOL(__alloc_percpu);
 #endif
 
@@ -3008,7 +3061,7 @@ EXPORT_SYMBOL(__alloc_percpu);
  * Free an object which was previously allocated from this
  * cache.
  */
-void kmem_cache_free(kmem_cache_t *cachep, void *objp)
+void kmem_cache_free(kmem_cache_t * cachep, void *objp)
 {
 	unsigned long flags;
 
@@ -3016,6 +3069,7 @@ void kmem_cache_free(kmem_cache_t *cache
 	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
+
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
@@ -3030,6 +3084,7 @@ void *kzalloc(size_t size, gfp_t flags)
 		memset(ret, 0, size);
 	return ret;
 }
+
 EXPORT_SYMBOL(kzalloc);
 
 /**
@@ -3051,9 +3106,10 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = page_get_cache(virt_to_page(objp));
-	__cache_free(c, (void*)objp);
+	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
+
 EXPORT_SYMBOL(kfree);
 
 #ifdef CONFIG_SMP
@@ -3064,38 +3120,40 @@ EXPORT_SYMBOL(kfree);
  * Don't free memory not originally allocated by alloc_percpu()
  * The complemented objp is to check for that.
  */
-void
-free_percpu(const void *objp)
+void free_percpu(const void *objp)
 {
 	int i;
-	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
+	struct percpu_data *p = (struct percpu_data *)(~(unsigned long)objp);
 
 	/*
 	 * We allocate for all cpus so we cannot use for online cpu here.
 	 */
 	for_each_cpu(i)
-		kfree(p->ptrs[i]);
+	    kfree(p->ptrs[i]);
 	kfree(p);
 }
+
 EXPORT_SYMBOL(free_percpu);
 #endif
 
-unsigned int kmem_cache_size(kmem_cache_t *cachep)
+unsigned int kmem_cache_size(kmem_cache_t * cachep)
 {
 	return obj_size(cachep);
 }
+
 EXPORT_SYMBOL(kmem_cache_size);
 
-const char *kmem_cache_name(kmem_cache_t *cachep)
+const char *kmem_cache_name(kmem_cache_t * cachep)
 {
 	return cachep->name;
 }
+
 EXPORT_SYMBOL_GPL(kmem_cache_name);
 
 /*
  * This initializes kmem_list3 for all nodes.
  */
-static int alloc_kmemlist(kmem_cache_t *cachep)
+static int alloc_kmemlist(kmem_cache_t * cachep)
 {
 	int node;
 	struct kmem_list3 *l3;
@@ -3108,44 +3166,44 @@ static int alloc_kmemlist(kmem_cache_t *
 		if (!(new_alien = alloc_alien_cache(node, cachep->limit)))
 			goto fail;
 #endif
-		if (!(new = alloc_arraycache(node, (cachep->shared*
-				cachep->batchcount), 0xbaadf00d)))
+		if (!(new = alloc_arraycache(node, (cachep->shared *
+						    cachep->batchcount),
+					     0xbaadf00d)))
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
+			l3->free_limit = (1 + nr_cpus_node(node)) *
+			    cachep->batchcount + cachep->num;
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
+		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 		l3->shared = new;
 		l3->alien = new_alien;
-		l3->free_limit = (1 + nr_cpus_node(node))*
-			cachep->batchcount + cachep->num;
+		l3->free_limit = (1 + nr_cpus_node(node)) *
+		    cachep->batchcount + cachep->num;
 		cachep->nodelists[node] = l3;
 	}
 	return err;
-fail:
+      fail:
 	err = -ENOMEM;
 	return err;
 }
@@ -3167,18 +3225,19 @@ static void do_ccupdate_local(void *info
 	new->new[smp_processor_id()] = old;
 }
 
-
-static int do_tune_cpucache(kmem_cache_t *cachep, int limit, int batchcount,
-				int shared)
+static int do_tune_cpucache(kmem_cache_t * cachep, int limit, int batchcount,
+			    int shared)
 {
 	struct ccupdate_struct new;
 	int i, err;
 
-	memset(&new.new,0,sizeof(new.new));
+	memset(&new.new, 0, sizeof(new.new));
 	for_each_online_cpu(i) {
-		new.new[i] = alloc_arraycache(cpu_to_node(i), limit, batchcount);
+		new.new[i] =
+		    alloc_arraycache(cpu_to_node(i), limit, batchcount);
 		if (!new.new[i]) {
-			for (i--; i >= 0; i--) kfree(new.new[i]);
+			for (i--; i >= 0; i--)
+				kfree(new.new[i]);
 			return -ENOMEM;
 		}
 	}
@@ -3206,14 +3265,13 @@ static int do_tune_cpucache(kmem_cache_t
 	err = alloc_kmemlist(cachep);
 	if (err) {
 		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
-				cachep->name, -err);
+		       cachep->name, -err);
 		BUG();
 	}
 	return 0;
 }
 
-
-static void enable_cpucache(kmem_cache_t *cachep)
+static void enable_cpucache(kmem_cache_t * cachep)
 {
 	int err;
 	int limit, shared;
@@ -3259,14 +3317,14 @@ static void enable_cpucache(kmem_cache_t
 	if (limit > 32)
 		limit = 32;
 #endif
-	err = do_tune_cpucache(cachep, limit, (limit+1)/2, shared);
+	err = do_tune_cpucache(cachep, limit, (limit + 1) / 2, shared);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
-					cachep->name, -err);
+		       cachep->name, -err);
 }
 
-static void drain_array_locked(kmem_cache_t *cachep,
-				struct array_cache *ac, int force, int node)
+static void drain_array_locked(kmem_cache_t * cachep,
+			       struct array_cache *ac, int force, int node)
 {
 	int tofree;
 
@@ -3274,14 +3332,14 @@ static void drain_array_locked(kmem_cach
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
 
@@ -3304,13 +3362,14 @@ static void cache_reap(void *unused)
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
+		schedule_delayed_work(&__get_cpu_var(reap_work),
+				      REAPTIMEOUT_CPUC);
 		return;
 	}
 
 	list_for_each(walk, &cache_chain) {
 		kmem_cache_t *searchp;
-		struct list_head* p;
+		struct list_head *p;
 		int tofree;
 		struct slab *slabp;
 
@@ -3327,7 +3386,7 @@ static void cache_reap(void *unused)
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+				   numa_node_id());
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
@@ -3336,14 +3395,16 @@ static void cache_reap(void *unused)
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+					   numa_node_id());
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
 			goto next_unlock;
 		}
 
-		tofree = (l3->free_limit+5*searchp->num-1)/(5*searchp->num);
+		tofree =
+		    (l3->free_limit + 5 * searchp->num -
+		     1) / (5 * searchp->num);
 		do {
 			p = l3->slabs_free.next;
 			if (p == &(l3->slabs_free))
@@ -3363,10 +3424,10 @@ static void cache_reap(void *unused)
 			spin_unlock_irq(&l3->list_lock);
 			slab_destroy(searchp, slabp);
 			spin_lock_irq(&l3->list_lock);
-		} while(--tofree > 0);
-next_unlock:
+		} while (--tofree > 0);
+	      next_unlock:
 		spin_unlock_irq(&l3->list_lock);
-next:
+	      next:
 		cond_resched();
 	}
 	check_irq_on();
@@ -3401,7 +3462,7 @@ static inline void print_slabinfo_header
 	seq_putc(m, '\n');
 }
 
-static void *s_start(struct seq_file *m, loff_t *pos)
+static void *s_start(struct seq_file *m, loff_t * pos)
 {
 	loff_t n = *pos;
 	struct list_head *p;
@@ -3418,12 +3479,12 @@ static void *s_start(struct seq_file *m,
 	return list_entry(p, kmem_cache_t, next);
 }
 
-static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+static void *s_next(struct seq_file *m, void *p, loff_t * pos)
 {
 	kmem_cache_t *cachep = p;
 	++*pos;
 	return cachep->next.next == &cache_chain ? NULL
-		: list_entry(cachep->next.next, kmem_cache_t, next);
+	    : list_entry(cachep->next.next, kmem_cache_t, next);
 }
 
 static void s_stop(struct seq_file *m, void *p)
@@ -3435,11 +3496,11 @@ static int s_show(struct seq_file *m, vo
 {
 	kmem_cache_t *cachep = p;
 	struct list_head *q;
-	struct slab	*slabp;
-	unsigned long	active_objs;
-	unsigned long	num_objs;
-	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs, free_objects = 0, shared_avail = 0;
+	struct slab *slabp;
+	unsigned long active_objs;
+	unsigned long num_objs;
+	unsigned long active_slabs = 0;
+	unsigned long num_slabs, free_objects = 0, shared_avail = 0;
 	const char *name;
 	char *error = NULL;
 	int node;
@@ -3456,14 +3517,14 @@ static int s_show(struct seq_file *m, vo
 
 		spin_lock(&l3->list_lock);
 
-		list_for_each(q,&l3->slabs_full) {
+		list_for_each(q, &l3->slabs_full) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse != cachep->num && !error)
 				error = "slabs_full accounting error";
 			active_objs += cachep->num;
 			active_slabs++;
 		}
-		list_for_each(q,&l3->slabs_partial) {
+		list_for_each(q, &l3->slabs_partial) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse == cachep->num && !error)
 				error = "slabs_partial inuse accounting error";
@@ -3472,7 +3533,7 @@ static int s_show(struct seq_file *m, vo
 			active_objs += slabp->inuse;
 			active_slabs++;
 		}
-		list_for_each(q,&l3->slabs_free) {
+		list_for_each(q, &l3->slabs_free) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse && !error)
 				error = "slabs_free/inuse accounting error";
@@ -3483,25 +3544,24 @@ static int s_show(struct seq_file *m, vo
 
 		spin_unlock(&l3->list_lock);
 	}
-	num_slabs+=active_slabs;
-	num_objs = num_slabs*cachep->num;
+	num_slabs += active_slabs;
+	num_objs = num_slabs * cachep->num;
 	if (num_objs - active_objs != free_objects && !error)
 		error = "free_objects accounting error";
 
-	name = cachep->name; 
+	name = cachep->name;
 	if (error)
 		printk(KERN_ERR "slab: cache %s error: %s\n", name, error);
 
 	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
-		name, active_objs, num_objs, cachep->objsize,
-		cachep->num, (1<<cachep->gfporder));
+		   name, active_objs, num_objs, cachep->objsize,
+		   cachep->num, (1 << cachep->gfporder));
 	seq_printf(m, " : tunables %4u %4u %4u",
-			cachep->limit, cachep->batchcount,
-			cachep->shared);
+		   cachep->limit, cachep->batchcount, cachep->shared);
 	seq_printf(m, " : slabdata %6lu %6lu %6lu",
-			active_slabs, num_slabs, shared_avail);
+		   active_slabs, num_slabs, shared_avail);
 #if STATS
-	{	/* list3 stats */
+	{			/* list3 stats */
 		unsigned long high = cachep->high_mark;
 		unsigned long allocs = cachep->num_allocations;
 		unsigned long grown = cachep->grown;
@@ -3512,9 +3572,7 @@ static int s_show(struct seq_file *m, vo
 		unsigned long node_frees = cachep->node_frees;
 
 		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu \
-				%4lu %4lu %4lu %4lu",
-				allocs, high, grown, reaped, errors,
-				max_freeable, node_allocs, node_frees);
+				%4lu %4lu %4lu %4lu", allocs, high, grown, reaped, errors, max_freeable, node_allocs, node_frees);
 	}
 	/* cpu stats */
 	{
@@ -3524,7 +3582,7 @@ static int s_show(struct seq_file *m, vo
 		unsigned long freemiss = atomic_read(&cachep->freemiss);
 
 		seq_printf(m, " : cpustat %6lu %6lu %6lu %6lu",
-			allochit, allocmiss, freehit, freemiss);
+			   allochit, allocmiss, freehit, freemiss);
 	}
 #endif
 	seq_putc(m, '\n');
@@ -3547,10 +3605,10 @@ static int s_show(struct seq_file *m, vo
  */
 
 struct seq_operations slabinfo_op = {
-	.start	= s_start,
-	.next	= s_next,
-	.stop	= s_stop,
-	.show	= s_show,
+	.start = s_start,
+	.next = s_next,
+	.stop = s_stop,
+	.show = s_show,
 };
 
 #define MAX_SLABINFO_WRITE 128
@@ -3561,18 +3619,18 @@ struct seq_operations slabinfo_op = {
  * @count: data length
  * @ppos: unused
  */
-ssize_t slabinfo_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos)
+ssize_t slabinfo_write(struct file *file, const char __user * buffer,
+		       size_t count, loff_t * ppos)
 {
-	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
+	char kbuf[MAX_SLABINFO_WRITE + 1], *tmp;
 	int limit, batchcount, shared, res;
 	struct list_head *p;
-	
+
 	if (count > MAX_SLABINFO_WRITE)
 		return -EINVAL;
 	if (copy_from_user(&kbuf, buffer, count))
 		return -EFAULT;
-	kbuf[MAX_SLABINFO_WRITE] = '\0'; 
+	kbuf[MAX_SLABINFO_WRITE] = '\0';
 
 	tmp = strchr(kbuf, ' ');
 	if (!tmp)
@@ -3585,18 +3643,17 @@ ssize_t slabinfo_write(struct file *file
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
 	res = -EINVAL;
-	list_for_each(p,&cache_chain) {
+	list_for_each(p, &cache_chain) {
 		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
 
 		if (!strcmp(cachep->name, kbuf)) {
 			if (limit < 1 ||
 			    batchcount < 1 ||
-			    batchcount > limit ||
-			    shared < 0) {
+			    batchcount > limit || shared < 0) {
 				res = 0;
 			} else {
 				res = do_tune_cpucache(cachep, limit,
-							batchcount, shared);
+						       batchcount, shared);
 			}
 			break;
 		}
@@ -3628,7 +3685,6 @@ unsigned int ksize(const void *objp)
 	return obj_size(page_get_cache(virt_to_page(objp)));
 }
 
-
 /*
  * kstrdup - allocate space for and copy an existing string
  *
@@ -3649,4 +3705,5 @@ char *kstrdup(const char *s, gfp_t gfp)
 		memcpy(buf, s, len);
 	return buf;
 }
+
 EXPORT_SYMBOL(kstrdup);
