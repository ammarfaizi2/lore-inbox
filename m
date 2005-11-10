Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVKJX4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVKJX4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVKJX4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:56:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:45545 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932145AbVKJX4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:56:45 -0500
Message-ID: <4373DE31.6070903@us.ibm.com>
Date: Thu, 10 Nov 2005 15:56:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] CodingStyle-ify mm/slab.c
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080301060704020305050006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080301060704020305050006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

mm/slab.c is MESSY.  Tabs where there should be spaces, spaces where there
should be tabs.  Long lines, bad formatting, spelling errors, etc.
Everything you'd expect from such an oft-patched file.  Let's start with
CodingStyle fixes.

Oh, and since I forgot to mention it in the 0/9 email, all these patches
are against 2.6.14.

-Matt

--------------080301060704020305050006
Content-Type: text/x-patch;
 name="CodingStyle-slab_c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CodingStyle-slab_c.patch"

Before doing any functional/structural cleanups, fix a bunch of comments,
whitespace and general CodingStyle issues.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:09:37.824838784 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:34:13.565492104 -0800
@@ -50,7 +50,7 @@
  * The head array is strictly LIFO and should improve the cache hit rates.
  * On SMP, it additionally reduces the spinlock operations.
  *
- * The c_cpuarray may not be read with enabled local interrupts - 
+ * The c_cpuarray may not be read with enabled local interrupts -
  * it's changed with a smp_call_function().
  *
  * SMP synchronization:
@@ -73,7 +73,7 @@
  *	can never happen inside an interrupt (kmem_cache_create(),
  *	kmem_cache_shrink() and kmem_cache_reap()).
  *
- *	At present, each engine can be growing a cache.  This should be blocked.
+ *	At present each engine can be growing a cache.  This should be blocked.
  *
  * 15 March 2005. NUMA slab allocator.
  *	Shai Fultheim <shai@scalex86.org>.
@@ -86,53 +86,52 @@
  *	All object allocations for a node occur from node specific slab lists.
  */
 
-#include	<linux/config.h>
-#include	<linux/slab.h>
-#include	<linux/mm.h>
-#include	<linux/swap.h>
-#include	<linux/cache.h>
-#include	<linux/interrupt.h>
-#include	<linux/init.h>
-#include	<linux/compiler.h>
-#include	<linux/seq_file.h>
-#include	<linux/notifier.h>
-#include	<linux/kallsyms.h>
-#include	<linux/cpu.h>
-#include	<linux/sysctl.h>
-#include	<linux/module.h>
-#include	<linux/rcupdate.h>
-#include	<linux/string.h>
-#include	<linux/nodemask.h>
-
-#include	<asm/uaccess.h>
-#include	<asm/cacheflush.h>
-#include	<asm/tlbflush.h>
-#include	<asm/page.h>
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/cache.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/seq_file.h>
+#include <linux/notifier.h>
+#include <linux/kallsyms.h>
+#include <linux/cpu.h>
+#include <linux/sysctl.h>
+#include <linux/module.h>
+#include <linux/rcupdate.h>
+#include <linux/string.h>
+#include <linux/nodemask.h>
+
+#include <asm/uaccess.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/page.h>
 
 /*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
- *		  0 for faster, smaller code (especially in the critical paths).
+ *		  0 for faster, smaller code (especially in the critical paths)
  *
  * STATS	- 1 to collect stats for /proc/slabinfo.
- *		  0 for faster, smaller code (especially in the critical paths).
+ *		  0 for faster, smaller code (especially in the critical paths)
  *
  * FORCED_DEBUG	- 1 enables SLAB_RED_ZONE and SLAB_POISON (if possible)
  */
-
 #ifdef CONFIG_DEBUG_SLAB
-#define	DEBUG		1
-#define	STATS		1
-#define	FORCED_DEBUG	1
+#define DEBUG		1
+#define STATS		1
+#define FORCED_DEBUG	1
 #else
-#define	DEBUG		0
-#define	STATS		0
-#define	FORCED_DEBUG	0
+#define DEBUG		0
+#define STATS		0
+#define FORCED_DEBUG	0
 #endif
 
 
 /* Shouldn't this be in a header file somewhere? */
-#define	BYTES_PER_WORD		sizeof(void *)
+#define BYTES_PER_WORD		sizeof(void *)
 
 #ifndef cache_line_size
 #define cache_line_size()	L1_CACHE_BYTES
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
@@ -220,7 +219,7 @@ struct slab {
 	struct list_head	list;
 	unsigned long		colouroff;
 	void			*s_mem;		/* including colour offset */
-	unsigned int		inuse;		/* num of objs active in slab */
+	unsigned int		inuse;		/* # of objs active in slab */
 	kmem_bufctl_t		free;
 	unsigned short          nodeid;
 };
@@ -264,36 +263,38 @@ struct array_cache {
 	unsigned int limit;
 	unsigned int batchcount;
 	unsigned int touched;
-	spinlock_t lock;
-	void *entry[0];		/*
-				 * Must have this definition in here for the proper
-				 * alignment of array_cache. Also simplifies accessing
-				 * the entries.
-				 * [0] is for gcc 2.95. It should really be [].
-				 */
+	spinlock_t   lock;
+	/*
+	 * Must have this definition in here for the proper alignment of
+	 * array_cache.  Also simplifies accessing the entries.
+	 * [0] is for gcc 2.95. It should really be [].
+	 */
+	void         *entry[0];
 };
 
-/* bootstrap: The caches do not work without cpuarrays anymore,
+/*
+ * bootstrap: The caches do not work without cpuarrays anymore,
  * but the cpuarrays are allocated from the generic caches...
  */
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
+	/* place the partial list first for better assembly code */
+	struct list_head	slabs_partial;
 	struct list_head	slabs_full;
 	struct list_head	slabs_free;
-	unsigned long	free_objects;
-	unsigned long	next_reap;
-	int		free_touched;
-	unsigned int 	free_limit;
-	spinlock_t      list_lock;
+	unsigned long		free_objects;
+	unsigned long		next_reap;
+	int			free_touched;
+	unsigned int		free_limit;
+	spinlock_t		list_lock;
 	struct array_cache	*shared;	/* shared per node */
 	struct array_cache	**alien;	/* on other nodes */
 };
@@ -301,11 +302,11 @@ struct kmem_list3 {
 /*
  * Need this for bootstrapping a per node allocator.
  */
-#define NUM_INIT_LISTS (2 * MAX_NUMNODES + 1)
+#define NUM_INIT_LISTS	(2 * MAX_NUMNODES + 1)
 struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
-#define	CACHE_CACHE 0
-#define	SIZE_AC 1
-#define	SIZE_L3 (1 + MAX_NUMNODES)
+#define CACHE_CACHE	0
+#define SIZE_AC		1
+#define SIZE_L3		(1 + MAX_NUMNODES)
 
 /*
  * This function must be completely optimized away if
@@ -318,10 +319,10 @@ static __always_inline int index_of(cons
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
@@ -349,17 +350,17 @@ static inline void kmem_list3_init(struc
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
-	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
-	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
-	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
+#define MAKE_ALL_LISTS(cachep, ptr, nodeid)				\
+	do {								\
+	MAKE_LIST((cachep), &(ptr)->slabs_full, slabs_full, nodeid);	\
+	MAKE_LIST((cachep), &(ptr)->slabs_partial, slabs_partial, nodeid);\
+	MAKE_LIST((cachep), &(ptr)->slabs_free, slabs_free, nodeid);	\
 	} while (0)
 
 /*
@@ -367,7 +368,6 @@ static inline void kmem_list3_init(struc
  *
  * manages a cache.
  */
-	
 struct kmem_cache_s {
 /* 1) per-cpu data, touched during every alloc/free */
 	struct array_cache	*array[NR_CPUS];
@@ -428,10 +428,11 @@ struct kmem_cache_s {
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
@@ -441,20 +442,19 @@ struct kmem_cache_s {
 #define REAPTIMEOUT_LIST3	(4*HZ)
 
 #if STATS
-#define	STATS_INC_ACTIVE(x)	((x)->num_active++)
-#define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
-#define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
-#define	STATS_INC_GROWN(x)	((x)->grown++)
-#define	STATS_INC_REAPED(x)	((x)->reaped++)
-#define	STATS_SET_HIGH(x)	do { if ((x)->num_active > (x)->high_mark) \
-					(x)->high_mark = (x)->num_active; \
+#define STATS_INC_ACTIVE(x)	((x)->num_active++)
+#define STATS_DEC_ACTIVE(x)	((x)->num_active--)
+#define STATS_INC_ALLOCED(x)	((x)->num_allocations++)
+#define STATS_INC_GROWN(x)	((x)->grown++)
+#define STATS_INC_REAPED(x)	((x)->reaped++)
+#define STATS_SET_HIGH(x)	do { if ((x)->num_active > (x)->high_mark) \
+					(x)->high_mark = (x)->num_active;  \
 				} while (0)
-#define	STATS_INC_ERR(x)	((x)->errors++)
-#define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
-#define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
-#define	STATS_SET_FREEABLE(x, i) \
-				do { if ((x)->max_freeable < i) \
-					(x)->max_freeable = i; \
+#define STATS_INC_ERR(x)	((x)->errors++)
+#define STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
+#define STATS_INC_NODEFREES(x)	((x)->node_frees++)
+#define STATS_SET_FREEABLE(x,i)	do { if ((x)->max_freeable < i)	\
+					(x)->max_freeable = i;	\
 				} while (0)
 
 #define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
@@ -462,18 +462,16 @@ struct kmem_cache_s {
 #define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
 #define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
 #else
-#define	STATS_INC_ACTIVE(x)	do { } while (0)
-#define	STATS_DEC_ACTIVE(x)	do { } while (0)
-#define	STATS_INC_ALLOCED(x)	do { } while (0)
-#define	STATS_INC_GROWN(x)	do { } while (0)
-#define	STATS_INC_REAPED(x)	do { } while (0)
-#define	STATS_SET_HIGH(x)	do { } while (0)
-#define	STATS_INC_ERR(x)	do { } while (0)
-#define	STATS_INC_NODEALLOCS(x)	do { } while (0)
-#define	STATS_INC_NODEFREES(x)	do { } while (0)
-#define	STATS_SET_FREEABLE(x, i) \
-				do { } while (0)
-
+#define STATS_INC_ACTIVE(x)	do { } while (0)
+#define STATS_DEC_ACTIVE(x)	do { } while (0)
+#define STATS_INC_ALLOCED(x)	do { } while (0)
+#define STATS_INC_GROWN(x)	do { } while (0)
+#define STATS_INC_REAPED(x)	do { } while (0)
+#define STATS_SET_HIGH(x)	do { } while (0)
+#define STATS_INC_ERR(x)	do { } while (0)
+#define STATS_INC_NODEALLOCS(x)	do { } while (0)
+#define STATS_INC_NODEFREES(x)	do { } while (0)
+#define STATS_SET_FREEABLE(x,i)	do { } while (0)
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
 #define STATS_INC_FREEHIT(x)	do { } while (0)
@@ -481,27 +479,28 @@ struct kmem_cache_s {
 #endif
 
 #if DEBUG
-/* Magic nums for obj red zoning.
+/*
+ * Magic nums for obj red zoning.
  * Placed in the first word before and the first word after an obj.
  */
-#define	RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
-#define	RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
+#define RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
+#define RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
 
 /* ...and for poisoning */
-#define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
+#define POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
 #define POISON_FREE	0x6b	/* for use-after-free poisoning */
-#define	POISON_END	0xa5	/* end-byte of poisoning */
+#define POISON_END	0xa5	/* end-byte of poisoning */
 
-/* memory layout of objects:
+/*
+ * memory layout of objects:
  * 0		: objp
- * 0 .. cachep->dbghead - BYTES_PER_WORD - 1: padding. This ensures that
+ * 0 .. cachep->dbghead - BYTES_PER_WORD-1: padding. This ensures that
  * 		the end of an object is aligned with the end of the real
  * 		allocation. Catches writes behind the end of the allocation.
- * cachep->dbghead - BYTES_PER_WORD .. cachep->dbghead - 1:
- * 		redzone word.
+ * cachep->dbghead - BYTES_PER_WORD .. cachep->dbghead - 1: redzone word.
  * cachep->dbghead: The real object.
- * cachep->objsize - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
- * cachep->objsize - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
+ * cachep->objsize - 2*BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
+ * cachep->objsize - 1*BYTES_PER_WORD: last caller addr [BYTES_PER_WORD long]
  */
 static int obj_dbghead(kmem_cache_t *cachep)
 {
@@ -516,24 +515,24 @@ static int obj_reallen(kmem_cache_t *cac
 static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long*) (objp+obj_dbghead(cachep)-BYTES_PER_WORD);
+	return (unsigned long *) (objp + obj_dbghead(cachep) - BYTES_PER_WORD);
 }
 
 static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
-		return (unsigned long*) (objp+cachep->objsize-2*BYTES_PER_WORD);
-	return (unsigned long*) (objp+cachep->objsize-BYTES_PER_WORD);
+		return (objp + cachep->objsize - 2 * BYTES_PER_WORD);
+	return (objp + cachep->objsize - BYTES_PER_WORD);
 }
 
 static void **dbg_userword(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
-	return (void**)(objp+cachep->objsize-BYTES_PER_WORD);
+	return (void **)(objp + cachep->objsize - BYTES_PER_WORD);
 }
 
-#else
+#else /* !DEBUG */
 
 #define obj_dbghead(x)			0
 #define obj_reallen(cachep)		(cachep->objsize)
@@ -541,40 +540,41 @@ static void **dbg_userword(kmem_cache_t 
 #define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
 
-#endif
+#endif /* DEBUG */
 
 /*
  * Maximum size of an obj (in 2^order pages)
  * and absolute limit for the gfp order.
  */
 #if defined(CONFIG_LARGE_ALLOCS)
-#define	MAX_OBJ_ORDER	13	/* up to 32Mb */
-#define	MAX_GFP_ORDER	13	/* up to 32Mb */
+#define MAX_OBJ_ORDER	13	/* up to 32Mb */
+#define MAX_GFP_ORDER	13	/* up to 32Mb */
 #elif defined(CONFIG_MMU)
-#define	MAX_OBJ_ORDER	5	/* 32 pages */
-#define	MAX_GFP_ORDER	5	/* 32 pages */
+#define MAX_OBJ_ORDER	5	/* 32 pages */
+#define MAX_GFP_ORDER	5	/* 32 pages */
 #else
-#define	MAX_OBJ_ORDER	8	/* up to 1Mb */
-#define	MAX_GFP_ORDER	8	/* up to 1Mb */
+#define MAX_OBJ_ORDER	8	/* up to 1Mb */
+#define MAX_GFP_ORDER	8	/* up to 1Mb */
 #endif
 
 /*
  * Do not go above this order unless 0 objects fit into the slab.
  */
-#define	BREAK_GFP_ORDER_HI	1
-#define	BREAK_GFP_ORDER_LO	0
+#define BREAK_GFP_ORDER_HI	1
+#define BREAK_GFP_ORDER_LO	0
 static int slab_break_gfp_order = BREAK_GFP_ORDER_LO;
 
-/* Macros for storing/retrieving the cachep and or slab from the
+/*
+ * Macros for storing/retrieving the cachep and or slab from the
  * global 'mem_map'. These are used to find the slab an obj belongs to.
  * With kfree(), these are used to find the cache which an obj belongs to.
  */
-#define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
-#define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
-#define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
-#define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
+#define SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
+#define GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
+#define SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
+#define GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
 
-/* These are the default caches for kmalloc. Custom caches can have other sizes. */
+/* These are the default kmalloc caches. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
 #include <linux/kmalloc_sizes.h>
@@ -616,7 +616,7 @@ static kmem_cache_t cache_cache = {
 };
 
 /* Guard access to the cache-chain. */
-static struct semaphore	cache_chain_sem;
+static struct semaphore cache_chain_sem;
 static struct list_head cache_chain;
 
 /*
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
@@ -680,12 +680,12 @@ kmem_cache_t *kmem_find_general_cachep(s
 }
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
-/* Cal the num objs, wastage, and bytes left over for a given slab size. */
+/* Calculate the num objs, wastage, & bytes left over for a given slab size. */
 static void cache_estimate(unsigned long gfporder, size_t size, size_t align,
-		 int flags, size_t *left_over, unsigned int *num)
+			   int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
-	size_t wastage = PAGE_SIZE<<gfporder;
+	size_t wastage = PAGE_SIZE << gfporder;
 	size_t extra = 0;
 	size_t base = 0;
 
@@ -694,7 +694,7 @@ static void cache_estimate(unsigned long
 		extra = sizeof(kmem_bufctl_t);
 	}
 	i = 0;
-	while (i*size + ALIGN(base+i*extra, align) <= wastage)
+	while (i * size + ALIGN(base + i * extra, align) <= wastage)
 		i++;
 	if (i > 0)
 		i--;
@@ -703,8 +703,8 @@ static void cache_estimate(unsigned long
 		i = SLAB_LIMIT;
 
 	*num = i;
-	wastage -= i*size;
-	wastage -= ALIGN(base+i*extra, align);
+	wastage -= i * size;
+	wastage -= ALIGN(base + i * extra, align);
 	*left_over = wastage;
 }
 
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
@@ -774,7 +774,7 @@ static inline struct array_cache **alloc
 			}
 			ac_ptr[i] = alloc_arraycache(node, limit, 0xbaadf00d);
 			if (!ac_ptr[i]) {
-				for (i--; i <=0; i--)
+				for (i--; i <= 0; i--)
 					kfree(ac_ptr[i]);
 				kfree(ac_ptr);
 				return NULL;
@@ -797,7 +797,8 @@ static inline void free_alien_cache(stru
 	kfree(ac_ptr);
 }
 
-static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
+static inline void __drain_alien_cache(kmem_cache_t *cachep,
+				       struct array_cache *ac, int node)
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
@@ -811,7 +812,7 @@ static inline void __drain_alien_cache(k
 
 static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
 {
-	int i=0;
+	int i = 0;
 	struct array_cache *ac;
 	unsigned long flags;
 
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
@@ -843,24 +844,25 @@ static int __devinit cpuup_callback(stru
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
 			if (!cachep->nodelists[node]) {
-				if (!(l3 = kmalloc_node(memsize,
-						GFP_KERNEL, node)))
+				if (!(l3 = kmalloc_node(memsize, GFP_KERNEL,
+							node)))
 					goto bad;
 				kmem_list3_init(l3);
 				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-				  ((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+				  ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
 				cachep->nodelists[node] = l3;
 			}
@@ -872,11 +874,10 @@ static int __devinit cpuup_callback(stru
 			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
 		}
 
-		/* Now we can go ahead with allocating the shared array's
-		  & array cache's */
+		/* Now we can allocate the shared arrays & array caches */
 		list_for_each_entry(cachep, &cache_chain, next) {
 			nc = alloc_arraycache(node, cachep->limit,
-					cachep->batchcount);
+					      cachep->batchcount);
 			if (!nc)
 				goto bad;
 			cachep->array[cpu] = nc;
@@ -885,12 +886,14 @@ static int __devinit cpuup_callback(stru
 			BUG_ON(!l3);
 			if (!l3->shared) {
 				if (!(nc = alloc_arraycache(node,
-					cachep->shared*cachep->batchcount,
+					cachep->shared * cachep->batchcount,
 					0xbaadf00d)))
-					goto  bad;
+					goto bad;
 
-				/* we are serialised from CPU_DEAD or
-				  CPU_UP_CANCELLED by the cpucontrol lock */
+				/*
+				 * we are serialised from CPU_DEAD or
+				 * CPU_UP_CANCELLED by the cpucontrol lock
+				 */
 				l3->shared = nc;
 			}
 		}
@@ -927,13 +930,13 @@ static int __devinit cpuup_callback(stru
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
@@ -1026,7 +1030,7 @@ void __init kmem_cache_init(void)
 	 *    kmalloc cache with kmalloc allocated arrays.
 	 * 5) Replace the __init data for kmem_list3 for cache_cache and
 	 *    the other cache's with kmalloc allocated memory.
-	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
+	 * 6) Resize head arrays of the kmalloc caches to their final sizes.
 	 */
 
 	/* 1) create the cache_cache */
@@ -1040,24 +1044,24 @@ void __init kmem_cache_init(void)
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
+	cache_cache.slab_size = ALIGN(cache_cache.num * sizeof(kmem_bufctl_t) +
 				sizeof(struct slab), cache_line_size());
 
 	/* 2+3) create the kmalloc caches */
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
@@ -1097,26 +1101,26 @@ void __init kmem_cache_init(void)
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
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
 		local_irq_disable();
-		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)
-				!= &initarray_generic.cache);
+		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep) !=
+		       &initarray_generic.cache);
 		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
-				sizeof(struct arraycache_init));
+		       sizeof(struct arraycache_init));
 		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
-						ptr;
+			ptr;
 		local_irq_enable();
 	}
 	/* 5) Replace the bootstrap kmem_list3's */
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
@@ -1190,16 +1190,15 @@ static void *kmem_getpages(kmem_cache_t 
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
 
-	i = (1 << cachep->gfporder);
+	i = 1 << cachep->gfporder;
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_add(i, &slab_reclaim_pages);
 	add_page_state(nr_slab, i);
@@ -1215,7 +1214,7 @@ static void *kmem_getpages(kmem_cache_t 
  */
 static void kmem_freepages(kmem_cache_t *cachep, void *addr)
 {
-	unsigned long i = (1<<cachep->gfporder);
+	unsigned long i = 1 << cachep->gfporder;
 	struct page *page = virt_to_page(addr);
 	const unsigned long nr_freed = i;
 
@@ -1228,13 +1227,13 @@ static void kmem_freepages(kmem_cache_t 
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
@@ -1246,19 +1245,19 @@ static void kmem_rcu_free(struct rcu_hea
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
-				unsigned long caller)
+			    unsigned long caller)
 {
 	int size = obj_reallen(cachep);
 
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
@@ -1266,34 +1265,32 @@ static void store_stackinfo(kmem_cache_t
 		while (!kstack_end(sptr)) {
 			svalue = *sptr++;
 			if (kernel_text_address(svalue)) {
-				*addr++=svalue;
+				*addr++ = svalue;
 				size -= sizeof(unsigned long);
 				if (size <= sizeof(unsigned long))
 					break;
 			}
 		}
-
 	}
-	*addr++=0x87654321;
+	*addr++ = 0x87654321;
 }
 #endif
 
 static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
 {
 	int size = obj_reallen(cachep);
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
+	for (i = 0; i < limit; i++)
 		printk(" %02x", (unsigned char)data[offset+i]);
-	}
 	printk("\n");
 }
 #endif
@@ -1307,24 +1304,24 @@ static void print_objinfo(kmem_cache_t *
 
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
 
@@ -1405,8 +1401,10 @@ static void slab_destroy (kmem_cache_t *
 
 		if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-			if ((cachep->objsize%PAGE_SIZE)==0 && OFF_SLAB(cachep))
-				kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE,1);
+			if ((cachep->objsize % PAGE_SIZE) == 0 &&
+			    OFF_SLAB(cachep))
+				kernel_map_pages(virt_to_page(objp),
+						 cachep->objsize/PAGE_SIZE, 1);
 			else
 				check_poison_obj(cachep, objp);
 #else
@@ -1422,13 +1420,13 @@ static void slab_destroy (kmem_cache_t *
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
@@ -1437,7 +1435,7 @@ static void slab_destroy (kmem_cache_t *
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
 		struct slab_rcu *slab_rcu;
 
-		slab_rcu = (struct slab_rcu *) slabp;
+		slab_rcu = (struct slab_rcu *)slabp;
 		slab_rcu->cachep = cachep;
 		slab_rcu->addr = addr;
 		call_rcu(&slab_rcu->head, kmem_rcu_free);
@@ -1448,17 +1446,19 @@ static void slab_destroy (kmem_cache_t *
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
 
@@ -1477,9 +1477,9 @@ static inline void set_up_list3s(kmem_ca
  * and the @dtor is run before the pages are handed back.
  *
  * @name must be valid until the cache is destroyed. This implies that
- * the module calling this has to destroy the cache before getting 
+ * the module calling this has to destroy the cache before getting
  * unloaded.
- * 
+ *
  * The flags are
  *
  * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
@@ -1495,10 +1495,10 @@ static inline void set_up_list3s(kmem_ca
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
@@ -1532,7 +1532,7 @@ kmem_cache_create (const char *name, siz
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
+	if (size < 4096 || fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
@@ -1550,24 +1550,26 @@ kmem_cache_create (const char *name, siz
 	if (flags & ~CREATE_MASK)
 		BUG();
 
-	/* Check that size is in terms of words.  This is needed to avoid
+	/*
+	 * Check that size is in terms of words.  This is needed to avoid
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
 	/* 1) arch recommendation: can be overridden for debug */
 	if (flags & SLAB_HWCACHE_ALIGN) {
-		/* Default alignment: as specified by the arch code.
+		/*
+		 * Default alignment: as specified by the arch code.
 		 * Except if an object is really small, then squeeze multiple
 		 * objects into one cacheline.
 		 */
 		ralign = cache_line_size();
-		while (size <= ralign/2)
+		while (size <= ralign / 2)
 			ralign /= 2;
 	} else {
 		ralign = BYTES_PER_WORD;
@@ -1584,7 +1586,8 @@ kmem_cache_create (const char *name, siz
 		if (ralign > BYTES_PER_WORD)
 			flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
 	}
-	/* 4) Store it. Note that the debug code below can reduce
+	/*
+	 * 4) Store it. Note that the debug code below can reduce
 	 *    the alignment to BYTES_PER_WORD.
 	 */
 	align = ralign;
@@ -1604,10 +1607,11 @@ kmem_cache_create (const char *name, siz
 
 		/* add space for red zone words */
 		cachep->dbghead += BYTES_PER_WORD;
-		size += 2*BYTES_PER_WORD;
+		size += 2 * BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
-		/* user store requires word alignment and
+		/*
+		 * user store requires word alignment and
 		 * one word storage behind the end of the real
 		 * object.
 		 */
@@ -1615,7 +1619,8 @@ kmem_cache_create (const char *name, siz
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
-	if (size >= malloc_sizes[INDEX_L3+1].cs_size && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
+	if (size >= malloc_sizes[INDEX_L3+1].cs_size &&
+	    cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
 		cachep->dbghead += PAGE_SIZE - size;
 		size = PAGE_SIZE;
 	}
@@ -1623,7 +1628,7 @@ kmem_cache_create (const char *name, siz
 #endif
 
 	/* Determine if the slab management is 'on' or 'off' slab. */
-	if (size >= (PAGE_SIZE>>3))
+	if (size >= (PAGE_SIZE >> 3))
 		/*
 		 * Size is large, assume best to place the slab management obj
 		 * off-slab (should allow better packing of objs).
@@ -1635,12 +1640,12 @@ kmem_cache_create (const char *name, siz
 	if ((flags & SLAB_RECLAIM_ACCOUNT) && size <= PAGE_SIZE) {
 		/*
 		 * A VFS-reclaimable slab tends to have most allocations
-		 * as GFP_NOFS and we really don't want to have to be allocating
+		 * as GFP_NOFS & we really don't want to have to be allocating
 		 * higher-order pages when we are unable to shrink dcache.
 		 */
 		cachep->gfporder = 0;
 		cache_estimate(cachep->gfporder, size, align, flags,
-					&left_over, &cachep->num);
+			       &left_over, &cachep->num);
 	} else {
 		/*
 		 * Calculate size (in pages) of slabs, and the num of objs per
@@ -1653,7 +1658,7 @@ kmem_cache_create (const char *name, siz
 			unsigned int break_flag = 0;
 cal_wastage:
 			cache_estimate(cachep->gfporder, size, align, flags,
-						&left_over, &cachep->num);
+				       &left_over, &cachep->num);
 			if (break_flag)
 				break;
 			if (cachep->gfporder >= MAX_GFP_ORDER)
@@ -1661,7 +1666,7 @@ cal_wastage:
 			if (!cachep->num)
 				goto next;
 			if (flags & CFLGS_OFF_SLAB &&
-					cachep->num > offslab_limit) {
+			    cachep->num > offslab_limit) {
 				/* This num of objs will cause problems. */
 				cachep->gfporder--;
 				break_flag++;
@@ -1669,14 +1674,14 @@ cal_wastage:
 			}
 
 			/*
-			 * Large num of objs is good, but v. large slabs are
+			 * Large num of objs is good, but very large slabs are
 			 * currently bad for the gfp()s.
 			 */
 			if (cachep->gfporder >= slab_break_gfp_order)
 				break;
 
-			if ((left_over*8) <= (PAGE_SIZE<<cachep->gfporder))
-				break;	/* Acceptable internal fragmentation. */
+			if ((left_over * 8) <= (PAGE_SIZE << cachep->gfporder))
+				break;  /* Acceptable internal fragmentation */
 next:
 			cachep->gfporder++;
 		} while (1);
@@ -1731,14 +1736,16 @@ next:
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
@@ -1759,10 +1766,9 @@ next:
 			} else {
 				int node;
 				for_each_online_node(node) {
-
 					cachep->nodelists[node] =
 						kmalloc_node(sizeof(struct kmem_list3),
-								GFP_KERNEL, node);
+							     GFP_KERNEL, node);
 					BUG_ON(!cachep->nodelists[node]);
 					kmem_list3_init(cachep->nodelists[node]);
 				}
@@ -1779,7 +1785,7 @@ next:
 		ac_data(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
-	} 
+	}
 
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
@@ -1792,20 +1798,23 @@ next:
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
 			char tmp;
-			/* This happens when the module gets unloaded and doesn't
-			   destroy its slab cache and noone else reuses the vmalloc
-			   area of the module. Print a warning. */
-			if (__get_user(tmp,pc->name)) { 
-				printk("SLAB: cache with size %d has lost its name\n", 
-					pc->objsize); 
-				continue; 
-			} 	
-			if (!strcmp(pc->name,name)) { 
-				printk("kmem_cache_create: duplicate cache %s\n",name); 
-				up(&cache_chain_sem); 
+			/*
+			 * This happens when the module gets unloaded & doesn't
+			 * destroy its slab cache and noone else reuses the
+			 * vmalloc area of the module.  Print a warning.
+			 */
+			if (__get_user(tmp,pc->name)) {
+				printk("%s: cache with size %d has lost its name\n",
+				       __FUNCTION__, pc->objsize);
+				continue;
+			}
+			if (!strcmp(pc->name,name)) {
+				printk("%s: duplicate cache %s\n",
+				       __FUNCTION__, name);
+				up(&cache_chain_sem);
 				unlock_cpu_hotplug();
-				BUG(); 
-			}	
+				BUG();
+			}
 		}
 		set_fs(old_fs);
 	}
@@ -1850,16 +1859,16 @@ static inline void check_spinlock_acquir
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
@@ -1874,12 +1883,12 @@ static void smp_call_function_all_cpus(v
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
 
@@ -1899,7 +1908,7 @@ static void drain_cpu_caches(kmem_cache_
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	for_each_online_node(node)  {
+	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
 		if (l3) {
 			spin_lock(&l3->list_lock);
@@ -1937,11 +1946,17 @@ static int __node_shrink(kmem_cache_t *c
 		slab_destroy(cachep, slabp);
 		spin_lock_irq(&l3->list_lock);
 	}
-	ret = !list_empty(&l3->slabs_full) ||
-		!list_empty(&l3->slabs_partial);
+	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
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
@@ -1958,7 +1973,7 @@ static int __cache_shrink(kmem_cache_t *
 			spin_unlock_irq(&l3->list_lock);
 		}
 	}
-	return (ret ? 1 : 0);
+	return ret ? 1 : 0;
 }
 
 /**
@@ -1994,7 +2009,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * The caller must guarantee that noone will allocate memory from the cache
  * during the kmem_cache_destroy().
  */
-int kmem_cache_destroy(kmem_cache_t * cachep)
+int kmem_cache_destroy(kmem_cache_t *cachep)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2007,9 +2022,7 @@ int kmem_cache_destroy(kmem_cache_t * ca
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
-	/*
-	 * the chain is never empty, cache_cache is never destroyed
-	 */
+	/* the chain is never empty, cache_cache is never destroyed */
 	list_del(&cachep->next);
 	up(&cache_chain_sem);
 
@@ -2045,8 +2058,8 @@ int kmem_cache_destroy(kmem_cache_t * ca
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
-			int colour_off, gfp_t local_flags)
+static struct slab *alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
+				   int colour_off, gfp_t local_flags)
 {
 	struct slab *slabp;
 	
@@ -2056,28 +2069,28 @@ static struct slab* alloc_slabmgmt(kmem_
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
@@ -2095,7 +2108,8 @@ static void cache_init_objs(kmem_cache_t
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
 		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
-			cachep->ctor(objp+obj_dbghead(cachep), cachep, ctor_flags);
+			cachep->ctor(objp + obj_dbghead(cachep), cachep,
+				     ctor_flags);
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
@@ -2105,15 +2119,17 @@ static void cache_init_objs(kmem_cache_t
 				slab_error(cachep, "constructor overwrote the"
 							" start of an object");
 		}
-		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep) && cachep->flags & SLAB_POISON)
-	       		kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 0);
+		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep) &&
+		    cachep->flags & SLAB_POISON)
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
 
@@ -2133,7 +2149,6 @@ static void set_slab_attr(kmem_cache_t *
 	int i;
 	struct page *page;
 
-	/* Nasty!!!!!! I hope this is OK. */
 	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
 	do {
@@ -2149,15 +2164,16 @@ static void set_slab_attr(kmem_cache_t *
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
- 	 * keeping it out of the critical path in kmem_cache_alloc().
+	/*
+	 * Be lazy and only check for valid flags here,
+	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
 	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
 		BUG();
@@ -2191,22 +2207,20 @@ static int cache_grow(kmem_cache_t *cach
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
@@ -2225,16 +2239,15 @@ static int cache_grow(kmem_cache_t *cach
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
@@ -2247,18 +2260,19 @@ static void kfree_debugcheck(const void 
 
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
 
 static void *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
-					void *caller)
+				   void *caller)
 {
 	struct page *page;
 	unsigned int objnr;
@@ -2269,20 +2283,25 @@ static void *cache_free_debugcheck(kmem_
 	page = virt_to_page(objp);
 
 	if (GET_PAGE_CACHE(page) != cachep) {
-		printk(KERN_ERR "mismatch in kmem_cache_free: expected cache %p, got %p\n",
-				GET_PAGE_CACHE(page),cachep);
+		printk(KERN_ERR "mismatch in kmem_cache_free: "
+		       "expected cache %p, got %p\n",
+		       GET_PAGE_CACHE(page), cachep);
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
-						" object was overwritten");
-			printk(KERN_ERR "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
-					objp, *dbg_redzone1(cachep, objp), *dbg_redzone2(cachep, objp));
+				   " object was overwritten");
+			printk(KERN_ERR "%p: redzone 1: 0x%lx, "
+			       "redzone 2: 0x%lx.\n", objp,
+			       *dbg_redzone1(cachep, objp),
+			       *dbg_redzone2(cachep, objp));
 		}
 		*dbg_redzone1(cachep, objp) = RED_INACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_INACTIVE;
@@ -2293,27 +2312,30 @@ static void *cache_free_debugcheck(kmem_
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
+			kernel_map_pages(virt_to_page(objp),
+					 cachep->objsize / PAGE_SIZE, 0);
 		} else {
 			poison_obj(cachep, objp, POISON_FREE);
 		}
@@ -2337,10 +2359,13 @@ static void check_slabp(kmem_cache_t *ca
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
@@ -2349,9 +2374,9 @@ bad:
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
@@ -2365,7 +2390,8 @@ static void *cache_alloc_refill(kmem_cac
 retry:
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
-		/* if there was little recent activity on this
+		/*
+		 * if there was little recent activity on this
 		 * cache, then perform only a partial refill.
 		 * Otherwise we could generate refill bouncing.
 		 */
@@ -2384,8 +2410,8 @@ retry:
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
@@ -2420,7 +2446,7 @@ retry:
 #if DEBUG
 			slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
 #endif
-		       	slabp->free = next;
+			slabp->free = next;
 		}
 		check_slabp(cachep, slabp);
 
@@ -2441,20 +2467,20 @@ alloc_done:
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
@@ -2463,16 +2489,16 @@ cache_alloc_debugcheck_before(kmem_cache
 }
 
 #if DEBUG
-static void *
-cache_alloc_debugcheck_after(kmem_cache_t *cachep,
-			gfp_t flags, void *objp, void *caller)
+static void *cache_alloc_debugcheck_after(kmem_cache_t *cachep, gfp_t flags,
+					  void *objp, void *caller)
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
@@ -2484,24 +2510,27 @@ cache_alloc_debugcheck_after(kmem_cache_
 		*dbg_userword(cachep, objp) = caller;
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE || *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
-			slab_error(cachep, "double free, or memory outside"
-						" object was overwritten");
-			printk(KERN_ERR "%p: redzone 1: 0x%lx, redzone 2: 0x%lx.\n",
-					objp, *dbg_redzone1(cachep, objp), *dbg_redzone2(cachep, objp));
+		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE ||
+		    *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
+			slab_error(cachep, "double free, or memory outside "
+				   "object was overwritten");
+			printk(KERN_ERR "%p: redzone 1: 0x%lx, "
+			       "redzone 2: 0x%lx.\n", objp,
+			       *dbg_redzone1(cachep, objp),
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
@@ -2529,7 +2558,7 @@ static inline void *____cache_alloc(kmem
 static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
 {
 	unsigned long save_flags;
-	void* objp;
+	void *objp;
 
 	cache_alloc_debugcheck_before(cachep, flags);
 
@@ -2537,7 +2566,7 @@ static inline void *__cache_alloc(kmem_c
 	objp = ____cache_alloc(cachep, flags);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					__builtin_return_address(0));
+					    __builtin_return_address(0));
 	prefetchw(objp);
 	return objp;
 }
@@ -2549,74 +2578,75 @@ static inline void *__cache_alloc(kmem_c
 static void *__cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
 {
 	struct list_head *entry;
- 	struct slab *slabp;
- 	struct kmem_list3 *l3;
- 	void *obj;
- 	kmem_bufctl_t next;
- 	int x;
+	struct slab *slabp;
+	struct kmem_list3 *l3;
+	void *obj;
+	kmem_bufctl_t next;
+	int x;
 
- 	l3 = cachep->nodelists[nodeid];
- 	BUG_ON(!l3);
+	l3 = cachep->nodelists[nodeid];
+	BUG_ON(!l3);
 
 retry:
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
+	obj =  slabp->s_mem + slabp->free * cachep->objsize;
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
 
- 	spin_unlock(&l3->list_lock);
- 	goto done;
+	spin_unlock(&l3->list_lock);
+	goto done;
 
 must_grow:
- 	spin_unlock(&l3->list_lock);
- 	x = cache_grow(cachep, flags, nodeid);
+	spin_unlock(&l3->list_lock);
+	x = cache_grow(cachep, flags, nodeid);
 
- 	if (!x)
- 		return NULL;
+	if (!x)
+		return NULL;
 
- 	goto retry;
+	goto retry;
 done:
- 	return obj;
+	return obj;
 }
 #endif
 
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects, int node)
+static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects,
+		       int node)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2633,7 +2663,6 @@ static void free_block(kmem_cache_t *cac
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 
-
 #if DEBUG
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache "
@@ -2657,7 +2686,8 @@ static void free_block(kmem_cache_t *cac
 				list_add(&slabp->list, &l3->slabs_free);
 			}
 		} else {
-			/* Unconditionally move a slab to the end of the
+			/*
+			 * Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
@@ -2681,13 +2711,12 @@ static void cache_flusharray(kmem_cache_
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
@@ -2716,11 +2745,11 @@ free_done:
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
@@ -2734,7 +2763,8 @@ static inline void __cache_free(kmem_cac
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
-	/* Make sure we are not freeing a object from another
+	/*
+	 * Make sure we are not freeing a object from another
 	 * node to the array cache on this cpu.
 	 */
 #ifdef CONFIG_NUMA
@@ -2744,23 +2774,21 @@ static inline void __cache_free(kmem_cac
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
@@ -2792,8 +2820,7 @@ void *kmem_cache_alloc(kmem_cache_t *cac
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 /**
- * kmem_ptr_validate - check if an untrusted pointer might
- *	be a slab entry.
+ * kmem_ptr_validate - check if an untrusted pointer might be a slab entry.
  * @cachep: the cache we're checking against
  * @ptr: pointer to validate
  *
@@ -2807,7 +2834,7 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  */
 int fastcall kmem_ptr_validate(kmem_cache_t *cachep, void *ptr)
 {
-	unsigned long addr = (unsigned long) ptr;
+	unsigned long addr = (unsigned long)ptr;
 	unsigned long min_addr = PAGE_OFFSET;
 	unsigned long align_mask = BYTES_PER_WORD-1;
 	unsigned long size = cachep->objsize;
@@ -2856,7 +2883,8 @@ void *kmem_cache_alloc_node(kmem_cache_t
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
-		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
+		printk(KERN_WARNING "slab: not allocating in inactive node %d "
+		       "for cache %s\n", nodeid, cachep->name);
 		return __cache_alloc(cachep,flags);
 	}
 
@@ -2867,7 +2895,8 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
+	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
+					   __builtin_return_address(0));
 
 	return ptr;
 }
@@ -2910,10 +2939,9 @@ void *__kmalloc(size_t size, gfp_t flags
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
@@ -2934,7 +2962,7 @@ EXPORT_SYMBOL(__kmalloc);
 void *__alloc_percpu(size_t size, size_t align)
 {
 	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
+	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
 
 	if (!pdata)
 		return NULL;
@@ -2958,7 +2986,7 @@ void *__alloc_percpu(size_t size, size_t
 	}
 
 	/* Catch derefs w/o wrappers */
-	return (void *) (~(unsigned long) pdata);
+	return (void *)(~(unsigned long) pdata);
 
 unwind_oom:
 	while (--i >= 0) {
@@ -3023,7 +3051,7 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
-	__cache_free(c, (void*)objp);
+	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(kfree);
@@ -3036,11 +3064,10 @@ EXPORT_SYMBOL(kfree);
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
@@ -3080,40 +3107,38 @@ static int alloc_kmemlist(kmem_cache_t *
 		if (!(new_alien = alloc_alien_cache(node, cachep->limit)))
 			goto fail;
 #endif
-		if (!(new = alloc_arraycache(node, (cachep->shared*
-				cachep->batchcount), 0xbaadf00d)))
+		if (!(new = alloc_arraycache(node, cachep->shared *
+					     cachep->batchcount, 0xbaadf00d)))
 			goto fail;
 		if ((l3 = cachep->nodelists[node])) {
-
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
@@ -3141,16 +3166,18 @@ static void do_ccupdate_local(void *info
 
 
 static int do_tune_cpucache(kmem_cache_t *cachep, int limit, int batchcount,
-				int shared)
+			    int shared)
 {
 	struct ccupdate_struct new;
 	int i, err;
 
-	memset(&new.new,0,sizeof(new.new));
+	memset(&new.new, 0, sizeof(new.new));
 	for_each_online_cpu(i) {
-		new.new[i] = alloc_arraycache(cpu_to_node(i), limit, batchcount);
+		new.new[i] = alloc_arraycache(cpu_to_node(i), limit,
+					      batchcount);
 		if (!new.new[i]) {
-			for (i--; i >= 0; i--) kfree(new.new[i]);
+			for (i--; i >= 0; i--)
+				kfree(new.new[i]);
 			return -ENOMEM;
 		}
 	}
@@ -3178,7 +3205,7 @@ static int do_tune_cpucache(kmem_cache_t
 	err = alloc_kmemlist(cachep);
 	if (err) {
 		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
-				cachep->name, -err);
+		       cachep->name, -err);
 		BUG();
 	}
 	return 0;
@@ -3190,10 +3217,11 @@ static void enable_cpucache(kmem_cache_t
 	int err;
 	int limit, shared;
 
-	/* The head array serves three purposes:
+	/*
+	 * The head array serves three purposes:
 	 * - create a LIFO ordering, i.e. return objects that are cache-warm
 	 * - reduce the number of spinlock operations.
-	 * - reduce the number of linked list operations on the slab and 
+	 * - reduce the number of linked list operations on the slab and
 	 *   bufctl chains: array operations are cheaper.
 	 * The numbers are guessed, we should auto-tune as described by
 	 * Bonwick.
@@ -3209,7 +3237,8 @@ static void enable_cpucache(kmem_cache_t
 	else
 		limit = 120;
 
-	/* Cpu bound tasks (e.g. network routing) can exhibit cpu bound
+	/*
+	 * Cpu bound tasks (e.g. network routing) can exhibit cpu bound
 	 * allocation behaviour: Most allocs on one cpu, most free operations
 	 * on another cpu. For these cases, an efficient object passing between
 	 * cpus is necessary. This is provided by a shared array. The array
@@ -3224,21 +3253,22 @@ static void enable_cpucache(kmem_cache_t
 #endif
 
 #if DEBUG
-	/* With debugging enabled, large batchcount lead to excessively
-	 * long periods with disabled local interrupts. Limit the 
+	/*
+	 * With debugging enabled, large batchcount lead to excessively
+	 * long periods with disabled local interrupts. Limit the
 	 * batchcount
 	 */
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
+static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
+			       int force, int node)
 {
 	int tofree;
 
@@ -3246,14 +3276,14 @@ static void drain_array_locked(kmem_cach
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
 
@@ -3275,7 +3305,8 @@ static void cache_reap(void *unused)
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+		schedule_delayed_work(&__get_cpu_var(reap_work),
+				      REAPTIMEOUT_CPUC + smp_processor_id());
 		return;
 	}
 
@@ -3298,7 +3329,7 @@ static void cache_reap(void *unused)
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+				   numa_node_id());
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
@@ -3307,14 +3338,15 @@ static void cache_reap(void *unused)
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+					   numa_node_id());
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
 			goto next_unlock;
 		}
 
-		tofree = (l3->free_limit+5*searchp->num-1)/(5*searchp->num);
+		tofree = 5 * searchp->num;
+		tofree = (l3->free_limit + tofree - 1) / tofree;
 		do {
 			p = l3->slabs_free.next;
 			if (p == &(l3->slabs_free))
@@ -3325,10 +3357,10 @@ static void cache_reap(void *unused)
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
@@ -3344,7 +3376,8 @@ next:
 	up(&cache_chain_sem);
 	drain_remote_pages();
 	/* Setup the next iteration */
-	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+	schedule_delayed_work(&__get_cpu_var(reap_work),
+			      REAPTIMEOUT_CPUC + smp_processor_id());
 }
 
 #ifdef CONFIG_PROC_FS
@@ -3388,8 +3421,8 @@ static void *s_next(struct seq_file *m, 
 {
 	kmem_cache_t *cachep = p;
 	++*pos;
-	return cachep->next.next == &cache_chain ? NULL
-		: list_entry(cachep->next.next, kmem_cache_t, next);
+	return cachep->next.next == &cache_chain ? NULL :
+		list_entry(cachep->next.next, kmem_cache_t, next);
 }
 
 static void s_stop(struct seq_file *m, void *p)
@@ -3401,11 +3434,9 @@ static int s_show(struct seq_file *m, vo
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
@@ -3432,7 +3463,7 @@ static int s_show(struct seq_file *m, vo
 		list_for_each(q,&l3->slabs_partial) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse == cachep->num && !error)
-				error = "slabs_partial inuse accounting error";
+				error = "slabs_partial/inuse accounting error";
 			if (!slabp->inuse && !error)
 				error = "slabs_partial/inuse accounting error";
 			active_objs += slabp->inuse;
@@ -3449,23 +3480,23 @@ static int s_show(struct seq_file *m, vo
 
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
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
-		name, active_objs, num_objs, cachep->objsize,
-		cachep->num, (1<<cachep->gfporder));
+	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d", name, active_objs,
+		   num_objs, cachep->objsize, cachep->num,
+		   (1 << cachep->gfporder));
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
@@ -3478,9 +3509,9 @@ static int s_show(struct seq_file *m, vo
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
@@ -3490,7 +3521,7 @@ static int s_show(struct seq_file *m, vo
 		unsigned long freemiss = atomic_read(&cachep->freemiss);
 
 		seq_printf(m, " : cpustat %6lu %6lu %6lu %6lu",
-			allochit, allocmiss, freehit, freemiss);
+			   allochit, allocmiss, freehit, freemiss);
 	}
 #endif
 	seq_putc(m, '\n');
@@ -3511,7 +3542,6 @@ static int s_show(struct seq_file *m, vo
  * num-pages-per-slab
  * + further values on SMP and with statistics enabled
  */
-
 struct seq_operations slabinfo_op = {
 	.start	= s_start,
 	.next	= s_next,
@@ -3528,17 +3558,17 @@ struct seq_operations slabinfo_op = {
  * @ppos: unused
  */
 ssize_t slabinfo_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos)
+		       size_t count, loff_t *ppos)
 {
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
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
@@ -3555,14 +3585,12 @@ ssize_t slabinfo_write(struct file *file
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
-							batchcount, shared);
+						       batchcount, shared);
 			}
 			break;
 		}
@@ -3572,7 +3600,7 @@ ssize_t slabinfo_write(struct file *file
 		res = count;
 	return res;
 }
-#endif
+#endif /* CONFIG_PROC_FS */
 
 /**
  * ksize - get the actual amount of memory allocated for a given object
@@ -3595,7 +3623,7 @@ unsigned int ksize(const void *objp)
 }
 
 
-/*
+/**
  * kstrdup - allocate space for and copy an existing string
  *
  * @s: the string to duplicate

--------------080301060704020305050006--
