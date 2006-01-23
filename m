Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWAWQ5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWAWQ5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWAWQ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:57:46 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:39613 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964808AbWAWQ5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:57:24 -0500
Subject: [RFC/PATCH 3/3] slab: update documentation
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: manfred@colorfullife.com, christoph@lameter.com
Cc: linux-kernel@vger.kernel.org
Date: Mon, 23 Jan 2006 18:57:22 +0200
Message-Id: <1138035442.10527.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch updates documentation in mm/slab.c and replaces the redundant
changelog with copyright statements.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  153 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 78 insertions(+), 75 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -1,57 +1,52 @@
 /*
- * linux/mm/slab.c
- * Written by Mark Hemment, 1996/97.
- * (markhe@nextd.demon.co.uk)
- *
- * kmem_cache_destroy() + some cleanup - 1999 Andrea Arcangeli
- *
- * Major cleanup, different bufctl logic, per-cpu arrays
- *	(c) 2000 Manfred Spraul
- *
- * Cleanup, make the head arrays unconditional, preparation for NUMA
- * 	(c) 2002 Manfred Spraul
+ * mm/slab.c - An object-caching memory allocator
+ * Copyright (c) 1996-1997 Mark Hemment
+ * Copyright (c) 1999 Andrea Arcangeli
+ * Copyright (c) 2000, 2002 Manfred Spraul
+ * Copyright (c) 2005 Shai Fultheim
+ * Copyright (c) 2005 Shobhit Dayal
+ * Copyright (c) 2005 Alok N Kataria
+ * Copyright (c) 2005 Christoph Lameter
  *
  * An implementation of the Slab Allocator as described in outline in;
  *	UNIX Internals: The New Frontiers by Uresh Vahalia
  *	Pub: Prentice Hall	ISBN 0-13-101908-2
+ *
  * or with a little more detail in;
  *	The Slab Allocator: An Object-Caching Kernel Memory Allocator
  *	Jeff Bonwick (Sun Microsystems).
  *	Presented at: USENIX Summer 1994 Technical Conference
  *
- * The memory is organized in caches, one cache for each object type.
- * (e.g. inode_cache, dentry_cache, buffer_head, vm_area_struct)
- * Each cache consists out of many slabs (they are small (usually one
- * page long) and always contiguous), and each slab contains multiple
- * initialized objects.
- *
- * This means, that your constructor is used only for newly allocated
- * slabs and you must pass objects with the same intializations to
- * kmem_cache_free.
- *
- * Each cache can only support one memory type (GFP_DMA, GFP_HIGHMEM,
- * normal). If you need a special memory type, then must create a new
- * cache for that memory type.
- *
- * In order to reduce fragmentation, the slabs are sorted in 3 groups:
- *   full slabs with 0 free objects
- *   partial slabs
- *   empty slabs with no allocated objects
- *
- * If partial slabs exist, then new allocations come from these slabs,
- * otherwise from empty slabs or new slabs are allocated.
- *
- * kmem_cache_destroy() CAN CRASH if you try to allocate from the cache
- * during kmem_cache_destroy(). The caller must prevent concurrent allocs.
- *
- * Each cache has a short per-cpu head array, most allocs
- * and frees go into that array, and if that array overflows, then 1/2
- * of the entries in the array are given back into the global cache.
- * The head array is strictly LIFO and should improve the cache hit rates.
- * On SMP, it additionally reduces the spinlock operations.
- *
- * The c_cpuarray may not be read with enabled local interrupts - 
- * it's changed with a smp_call_function().
+ * 	Magazines and Vmem: Extending the Slab Allocator to Many CPUs and
+ * 	Arbitrary Resources
+ * 	Jeff Bonwick, Sun Microsystems
+ * 	Jonathan Adams, California Institute of Technology
+ * 	Presented at: USENIX 2001
+ *
+ * The slab allocator organizes memory in object caches where each
+ * type has its own cache. Examples of types that have their own cache
+ * are struct inode, struct dentry, struct buffer_head, and so
+ * on. There is also a general purpose allocator, kmalloc, which is
+ * backed by number of fixed-size object caches ranging from 32 bytes
+ * up to 128 KB.
+ *
+ * Physical memory is allocated with the page allocator. A slab can
+ * contain one or more contiguous pages that are carved into
+ * equal-sized blocks called buffers. Each object cache has an
+ * optional constructor and destructor which are applied to a buffer
+ * before returning an object from the allocator. The destructor is
+ * applied to an object before the underlying buffer is retured to the
+ * page allocator.
+ *
+ * The object cache is organized into per-CPU and per-NUMA-node
+ * caches. The per-CPU cache improves SMP scalability as most
+ * allocation and free operations are satisfied from it.  Object cache
+ * slabs are stored in three per-NUMA-node lists: the partial list,
+ * the full list, and the free list depending on how many objects are
+ * available for allocation in a slab. Each node also has a shared
+ * array cache that is used to refill the per-CPU caches and an alien
+ * cache that is used to free objects that were allocated on a
+ * different node in a batch.
  *
  * SMP synchronization:
  *  constructors and destructors are called without any locking.
@@ -61,29 +56,48 @@
  *  	and local interrupts are disabled so slab code is preempt-safe.
  *  The non-constant members are protected with a per-cache irq spinlock.
  *
+ * The slab layout is as follows:
+ *
+ * 0 ... PAGE_SIZE << gfp_order
+ * +-------+----------+----------+----------+----------+----------+----------+
+ * |       |          |          |          :          :          |          |
+ * | Mgmt  | Buffer 1 | Buffer 2 |   ....   :   ....   :   ....   | Buffer n |
+ * |       |          |          |          :          :          |          |
+ * +-------+----------+----------+----------+----------+----------+----------+
+ *
+ * Legend:
+ *
+ *   Mgmt	 Slab management and buffer control (optional). Use the
+ *   		 slab_mgmt_size() function to retrieve size of this block.
+ *
+ *   Buffer 1..n Equally-sized buffers. Buffer size is stored in the
+ *   		 buffer_size member of struct kmem_cache.
+ *
+ *
+ * The buffer layout is as follows:
+ *
+ * 0 ... buffer_size
+ * +---------+---+---------------------------------------------------+---+---+
+ * |         :   |                                                   :   :   |
+ * | Padding : R |                       Object                      : R : C |
+ * |         :   |                                                   :   :   |
+ * +---------+---+---------------------------------------------------+---+---+
+ *
+ * Legend:
+ *
+ *   Padding	Empty space to ensure alignment restrictions of this object
+ *		cache.
+ *   Object	The actual object. Use the obj_offset() function to retrieve
+ *   		the start offset of an object and obj_size() function for the
+ *   		object size.
+ *   R		Red-zone word. These two redzone words are BYTES_PER_WORD in
+ *   		size and they are used to detect buffer overruns.
+ *   C		Address of last user of this buffer. This field is
+ *   		BYTES_PER_WORD in size.
+ *
  * Many thanks to Mark Hemment, who wrote another per-cpu slab patch
  * in 2000 - many ideas in the current implementation are derived from
  * his patch.
- *
- * Further notes from the original documentation:
- *
- * 11 April '97.  Started multi-threading - markhe
- *	The global cache-chain is protected by the semaphore 'cache_chain_sem'.
- *	The sem is only needed when accessing/extending the cache-chain, which
- *	can never happen inside an interrupt (kmem_cache_create(),
- *	kmem_cache_shrink() and kmem_cache_reap()).
- *
- *	At present, each engine can be growing a cache.  This should be blocked.
- *
- * 15 March 2005. NUMA slab allocator.
- *	Shai Fultheim <shai@scalex86.org>.
- *	Shobhit Dayal <shobhit@calsoftinc.com>
- *	Alok N Kataria <alokk@calsoftinc.com>
- *	Christoph Lameter <christoph@lameter.com>
- *
- *	Modified the slab allocator to be node aware on NUMA systems.
- *	Each node has its own list of partial, free and full slabs.
- *	All object allocations for a node occur from node specific slab lists.
  */
 
 #include	<linux/config.h>
@@ -506,17 +520,6 @@ struct kmem_cache {
 #define POISON_FREE	0x6b	/* for use-after-free poisoning */
 #define	POISON_END	0xa5	/* end-byte of poisoning */
 
-/* memory layout of objects:
- * 0		: objp
- * 0 .. cachep->obj_offset - BYTES_PER_WORD - 1: padding. This ensures that
- * 		the end of an object is aligned with the end of the real
- * 		allocation. Catches writes behind the end of the allocation.
- * cachep->obj_offset - BYTES_PER_WORD .. cachep->obj_offset - 1:
- * 		redzone word.
- * cachep->obj_offset: The real object.
- * cachep->buffer_size - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
- * cachep->buffer_size - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
- */
 static int obj_offset(struct kmem_cache *cachep)
 {
 	return cachep->obj_offset;


