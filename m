Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVCKXt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVCKXt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVCKXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:49:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261811AbVCKXj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:39:27 -0500
Date: Sat, 12 Mar 2005 00:39:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: [2.6.11-rc5-mm1 patch] fs/reiser4/: possible cleanups
Message-ID: <20050311233924.GT3723@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains possible cleanups including the following:
- make needlessly global code static
- plugin/compress/minilzo.c: many cleanups
- remove or #if 0 the following unused global functions:
  - context.c: check_contexts
  - flush.c: jnode_tostring
  - flush.c: znode_tostring
  - flush.c: pos_tostring
  - flush_queue.c: fq_by_jnode
  - inode.c: get_reiser4_inode_by_key
  - lock.c: lock_mode
  - plugin/cryptcompress.c: set_nrpages_by_inode
  - file.c: readpages_unix_file
  - plugin/item/ctail.c: ctail_make_unprepped_cluster
  - plugin/item/extent_item_ops.c: show_extent
  - plugin/item/tail.c: show_tail
  - tree_walk.c: tree_walk

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Mar 2005

 fs/reiser4/block_alloc.c                 |    2 
 fs/reiser4/cluster.h                     |    3 
 fs/reiser4/context.c                     |    2 
 fs/reiser4/debug.c                       |   13 +
 fs/reiser4/debug.h                       |    2 
 fs/reiser4/flush.c                       |    6 
 fs/reiser4/flush.h                       |    4 
 fs/reiser4/flush_queue.c                 |    7 
 fs/reiser4/inode.c                       |    6 
 fs/reiser4/inode.h                       |    3 
 fs/reiser4/jnode.c                       |    8 -
 fs/reiser4/jnode.h                       |    2 
 fs/reiser4/lock.c                        |    2 
 fs/reiser4/lock.h                        |    1 
 fs/reiser4/page_cache.c                  |    2 
 fs/reiser4/plugin/compress/lzoconf.h     |   23 --
 fs/reiser4/plugin/compress/minilzo.c     |  179 +----------------------
 fs/reiser4/plugin/cryptcompress.c        |   15 -
 fs/reiser4/plugin/file/file.c            |   14 -
 fs/reiser4/plugin/file/funcs.h           |    2 
 fs/reiser4/plugin/item/ctail.c           |    4 
 fs/reiser4/plugin/item/ctail.h           |    1 
 fs/reiser4/plugin/item/extent.h          |    1 
 fs/reiser4/plugin/item/extent_item_ops.c |    2 
 fs/reiser4/plugin/item/tail.c            |    5 
 fs/reiser4/plugin/item/tail.h            |    1 
 fs/reiser4/plugin/object.c               |    2 
 fs/reiser4/plugin/object.h               |    1 
 fs/reiser4/tree_walk.c                   |    4 
 fs/reiser4/txnmgr.h                      |    1 
 fs/reiser4/vfs_ops.c                     |   14 -
 fs/reiser4/wander.c                      |    2 
 fs/reiser4/znode.c                       |    4 
 33 files changed, 66 insertions(+), 272 deletions(-)

--- linux-2.6.11-rc5-mm1-full/fs/reiser4/block_alloc.c.old	2005-03-01 21:18:07.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/block_alloc.c	2005-03-01 21:18:14.000000000 +0100
@@ -932,7 +932,7 @@
 #if REISER4_DEBUG
 
 /* check "allocated" state of given block range */
-void
+static void
 reiser4_check_blocks(const reiser4_block_nr * start, const reiser4_block_nr * len, int desired)
 {
 	sa_check_blocks(start, len, desired);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/context.c.old	2005-03-01 21:18:31.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/context.c	2005-03-01 21:19:08.000000000 +0100
@@ -47,6 +47,7 @@
 /* lock protecting access to active_contexts. */
 spinlock_t active_contexts_lock;
 
+#if 0
 void
 check_contexts(void)
 {
@@ -58,6 +59,7 @@
 	}
 	spin_unlock(&active_contexts_lock);
 }
+#endif  /*  0  */
 
 #endif /* REISER4_DEBUG */
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/debug.h.old	2005-03-01 21:19:25.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/debug.h	2005-03-01 21:19:31.000000000 +0100
@@ -176,8 +176,6 @@
 	REISER4_CHECK_NODE = 0x00000008
 } reiser4_debug_flags;
 
-extern int reiser4_is_debugged(struct super_block *super, __u32 flag);
-
 extern int is_in_reiser4_context(void);
 
 /*
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/debug.c.old	2005-03-01 21:19:38.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/debug.c	2005-03-01 22:54:38.000000000 +0100
@@ -61,6 +61,11 @@
  */
 static spinlock_t panic_guard = SPIN_LOCK_UNLOCKED;
 
+#if REISER4_DEBUG
+static int
+reiser4_is_debugged(struct super_block *super, __u32 flag);
+#endif
+
 /* Your best friend. Call it on each occasion.  This is called by
     fs/reiser4/debug.h:reiser4_panic(). */
 reiser4_internal void
@@ -303,19 +308,19 @@
 	return result;
 }
 
-/* REISER4_DEBUG */
-#endif
-
 /*
  * check that some bits specified by @flags are set in ->debug_flags of the
  * super block.
  */
-reiser4_internal int
+static int
 reiser4_is_debugged(struct super_block *super, __u32 flag)
 {
 	return get_super_private(super)->debug_flags & flag;
 }
 
+/* REISER4_DEBUG */
+#endif
+
 /* allocate memory. This calls kmalloc(), performs some additional checks, and
    keeps track of how many memory was allocated on behalf of current super
    block. */
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/flush.h.old	2005-03-01 21:21:31.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/flush.h	2005-03-01 21:21:40.000000000 +0100
@@ -260,10 +260,6 @@
 void done_fqs(void);
 
 #if REISER4_DEBUG
-const char *jnode_tostring(jnode * node);
-#endif
-
-#if REISER4_DEBUG
 #define check_preceder(blk) \
 assert("nikita-2588", blk < reiser4_block_count(reiser4_get_current_sb()));
 extern void check_pos(flush_pos_t *pos);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/flush.c.old	2005-03-01 21:22:13.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/flush.c	2005-03-01 22:43:15.000000000 +0100
@@ -433,8 +433,6 @@
 	    extent_is_unallocated(&scan->parent_coord),			\
 	    extent_unit_index(&scan->parent_coord) == index_jnode(scan->node)))
 
-const char *pos_tostring(flush_pos_t * pos);
-
 /* This flush_cnt variable is used to track the number of concurrent flush operations,
    useful for debugging.  It is initialized in txnmgr.c out of laziness (because flush has
    no static initializer function...) */
@@ -563,6 +561,8 @@
 
 const char *coord_tween_tostring(between_enum n);
 
+#if 0
+
 static void
 jnode_tostring_internal(jnode * node, char *buf)
 {
@@ -682,6 +682,8 @@
 	return fmtbuf;
 }
 
+#endif  /*  0  */
+
 #endif /* REISER4_TRACE */
 
 /* TODO LIST (no particular order): */
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/txnmgr.h.old	2005-03-01 21:26:02.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/txnmgr.h	2005-03-01 21:26:06.000000000 +0100
@@ -597,7 +597,6 @@
 };
 
 extern int fq_by_atom(txn_atom *, flush_queue_t **);
-extern int fq_by_jnode(jnode *, flush_queue_t **);
 extern int fq_by_jnode_gfp(jnode *, flush_queue_t **, int);
 extern void fq_put_nolock(flush_queue_t *);
 extern void fq_put(flush_queue_t *);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/flush_queue.c.old	2005-03-01 21:25:07.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/flush_queue.c	2005-03-01 22:07:30.000000000 +0100
@@ -182,7 +182,7 @@
 }
 
 /* destroy flush queue object */
-reiser4_internal void
+static void
 done_fq(flush_queue_t * fq)
 {
 	assert("zam-763", capture_list_empty(ATOM_FQ_LIST(fq)));
@@ -717,11 +717,6 @@
 	return 0;
 }
 
-reiser4_internal int fq_by_jnode(jnode * node, flush_queue_t ** fq)
-{
-        return fq_by_jnode_gfp(node, fq, GFP_KERNEL);
-}
-
 
 #if REISER4_DEBUG
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/inode.h.old	2005-03-01 21:26:31.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/inode.h	2005-03-01 21:27:38.000000000 +0100
@@ -166,8 +166,6 @@
 void loading_init_once(reiser4_inode *);
 void loading_alloc(reiser4_inode *);
 void loading_destroy(reiser4_inode *);
-void loading_down(reiser4_inode *);
-void loading_up(reiser4_inode *);
 
 
 #define I_JNODES (512)	/* inode state bit. Set when in hash table there are more than 0 jnodes of unformatted nodes of
@@ -323,7 +321,6 @@
 extern int setup_inode_ops(struct inode *inode, reiser4_object_create_data *);
 extern struct inode *reiser4_iget(struct super_block *super, const reiser4_key * key, int silent);
 extern void reiser4_iget_complete (struct inode * inode);
-extern int get_reiser4_inode_by_key (struct inode **, const reiser4_key *);
 
 
 extern void inode_set_flag(struct inode *inode, reiser4_file_plugin_flags f);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/inode.c.old	2005-03-01 21:26:50.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/inode.c	2005-03-01 21:27:28.000000000 +0100
@@ -386,12 +386,12 @@
 #endif
 }
 
-void loading_down(reiser4_inode *info)
+static void loading_down(reiser4_inode *info)
 {
 	down(&info->loading);
 }
 
-void loading_up(reiser4_inode *info)
+static void loading_up(reiser4_inode *info)
 {
 	up(&info->loading);
 }
@@ -678,6 +678,7 @@
 	UNLOCK_INODE(info);
 }
 
+#if 0
 reiser4_internal int
 get_reiser4_inode_by_key (struct inode ** result, const reiser4_key * key)
 {
@@ -711,6 +712,7 @@
 	*result = inode;
 	return 0;
 }
+#endif  /*  0  */
 
 
 #if REISER4_DEBUG_OUTPUT
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/znode.c.old	2005-03-01 21:29:37.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/znode.c	2005-03-01 21:29:48.000000000 +0100
@@ -242,10 +242,6 @@
 	return result;
 }
 
-#if REISER4_DEBUG
-extern void jnode_done(jnode * node, reiser4_tree * tree);
-#endif
-
 /* free this znode */
 reiser4_internal void
 zfree(znode * node /* znode to free */ )
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/jnode.h.old	2005-03-01 21:30:40.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/jnode.h	2005-03-01 22:18:00.000000000 +0100
@@ -459,10 +459,8 @@
 #if REISER4_DEBUG
 extern int znode_is_any_locked(const znode * node);
 extern void jnode_list_remove(jnode * node);
-extern int jnode_invariant(const jnode * node, int tlocked, int jlocked);
 #else
 #define jnode_list_remove(node) noop
-#define jnode_invariant(n, t, j) (1)
 #endif
 
 #if REISER4_DEBUG
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/jnode.c.old	2005-03-01 21:29:55.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/jnode.c	2005-03-01 21:33:05.000000000 +0100
@@ -129,6 +129,10 @@
 static int jdelete(jnode * node);
 static int jnode_try_drop(jnode * node);
 
+#if REISER4_DEBUG
+static int jnode_invariant(const jnode * node, int tlocked, int jlocked);
+#endif
+
 /* true if valid page is attached to jnode */
 static inline int jnode_is_parsed (jnode * node)
 {
@@ -272,7 +276,7 @@
 /*
  * Remove jnode from ->all_jnodes list.
  */
-void
+static void
 jnode_done(jnode * node, reiser4_tree * tree)
 {
 	reiser4_super_info_data *sbinfo;
@@ -1887,7 +1891,7 @@
 }
 
 /* debugging aid: check znode invariant and panic if it doesn't hold */
-int
+static int
 jnode_invariant(const jnode * node, int tlocked, int jlocked)
 {
 	char const *failed_msg;
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/lock.h.old	2005-03-01 21:36:03.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/lock.h	2005-03-01 21:36:13.000000000 +0100
@@ -187,7 +187,6 @@
 extern void move_lh(lock_handle * new, lock_handle * old);
 extern void copy_lh(lock_handle * new, lock_handle * old);
 extern void done_lh(lock_handle *);
-extern znode_lock_mode lock_mode(lock_handle *);
 
 extern int prepare_to_sleep(lock_stack * owner);
 extern void go_to_sleep(lock_stack * owner);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/lock.c.old	2005-03-01 21:36:26.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/lock.c	2005-03-01 22:20:39.000000000 +0100
@@ -1154,6 +1154,7 @@
 }
 
 /* What kind of lock? */
+#if 0
 reiser4_internal znode_lock_mode lock_mode(lock_handle * handle)
 {
 	if (handle->owner == NULL) {
@@ -1164,6 +1165,7 @@
 		return ZNODE_WRITE_LOCK;
 	}
 }
+#endif  /*  0  */
 
 /* Transfer a lock handle (presumably so that variables can be moved between stack and
    heap locations). */
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/cryptcompress.c.old	2005-03-01 21:38:22.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/cryptcompress.c	2005-03-01 22:08:42.000000000 +0100
@@ -52,12 +52,9 @@
 int ctail_read_cluster (reiser4_cluster_t *, struct inode *, int);
 reiser4_key * append_cluster_key_ctail(const coord_t *, reiser4_key *);
 int setattr_reserve(reiser4_tree *);
-int reserve_cut_iteration(reiser4_tree *);
 int writepage_ctail(struct page *);
-int truncate_jnodes_range(struct inode *inode, unsigned long from, int count);
 int cut_file_items(struct inode *inode, loff_t new_size, int update_sd, loff_t cur_size);
 int delete_object(struct inode *inode, int mode);
-int ctail_make_unprepped_cluster(reiser4_cluster_t * clust, struct inode * inode);
 int ctail_insert_unprepped_cluster(reiser4_cluster_t * clust, struct inode * inode);
 int hint_is_set(const hint_t *hint);
 reiser4_plugin * get_default_plugin(pset_member memb);
@@ -86,7 +83,7 @@
 }
 
 #if REISER4_DEBUG
-reiser4_internal int
+static int
 crc_generic_check_ok(void)
 {
 	return MIN_CRYPTO_BLOCKSIZE == DC_CHECKSUM_SIZE << 1;
@@ -470,7 +467,7 @@
 }
 #endif
 
-reiser4_internal int
+static int
 new_cluster(reiser4_cluster_t * clust, struct inode * inode)
 {
 	return (clust_to_off(clust->index, inode) >= inode->i_size);
@@ -508,6 +505,7 @@
 	return;
 }
 
+#if 0
 reiser4_internal void
 set_nrpages_by_inode(reiser4_cluster_t * clust, struct inode * inode)
 {
@@ -516,6 +514,7 @@
 
 	clust->nr_pages = count_to_nrpages(fsize_to_count(clust, inode));
 }
+#endif  /*  0  */
 
 /* plugin->key_by_inode() */
 /* see plugin/plugin.h for details */
@@ -1332,7 +1331,7 @@
 }
 
 /* collect unlocked cluster pages */
-reiser4_internal int
+static int
 grab_cluster_pages(struct inode * inode, reiser4_cluster_t * clust)
 {
 	int i;
@@ -1407,7 +1406,7 @@
 }
 
 #if REISER4_DEBUG
-reiser4_internal int
+static int
 window_ok(reiser4_slide_t * win, struct inode * inode)
 {
 	assert ("edward-1115", win != NULL);
@@ -1417,7 +1416,7 @@
 		(win->off + win->count + win->delta <= inode_cluster_size(inode));
 }
 
-reiser4_internal int
+static int
 cluster_ok(reiser4_cluster_t * clust, struct inode * inode)
 {
 	assert("edward-279", clust != NULL);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/page_cache.c.old	2005-03-01 21:38:37.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/page_cache.c	2005-03-01 22:08:00.000000000 +0100
@@ -660,7 +660,7 @@
 #define JNODE_GANG_SIZE (16)
 
 /* find all eflushed jnodes from range specified and invalidate them */
-reiser4_internal int
+static int
 truncate_jnodes_range(struct inode *inode, pgoff_t from, pgoff_t count)
 {
 	reiser4_inode *info;
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/compress/lzoconf.h.old	2005-03-01 21:41:06.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/compress/lzoconf.h	2005-03-01 22:26:43.000000000 +0100
@@ -409,38 +409,15 @@
     (int)sizeof(lzo_compress_t))
 LZO_EXTERN(int) __lzo_init2(unsigned,int,int,int,int,int,int,int,int,int);
 
-/* version functions (useful for shared libraries) */
-LZO_EXTERN(unsigned) lzo_version(void);
-LZO_EXTERN(const char *) lzo_version_string(void);
-LZO_EXTERN(const char *) lzo_version_date(void);
-LZO_EXTERN(const lzo_charp) _lzo_version_string(void);
-LZO_EXTERN(const lzo_charp) _lzo_version_date(void);
-
-/* string functions */
-LZO_EXTERN(int)
-lzo_memcmp(const lzo_voidp _s1, const lzo_voidp _s2, lzo_uint _len);
-LZO_EXTERN(lzo_voidp)
-lzo_memcpy(lzo_voidp _dest, const lzo_voidp _src, lzo_uint _len);
-LZO_EXTERN(lzo_voidp)
-lzo_memmove(lzo_voidp _dest, const lzo_voidp _src, lzo_uint _len);
-LZO_EXTERN(lzo_voidp)
-lzo_memset(lzo_voidp _s, int _c, lzo_uint _len);
-
 /* checksum functions */
 LZO_EXTERN(lzo_uint32)
-lzo_adler32(lzo_uint32 _adler, const lzo_byte *_buf, lzo_uint _len);
-LZO_EXTERN(lzo_uint32)
 lzo_crc32(lzo_uint32 _c, const lzo_byte *_buf, lzo_uint _len);
 
 /* misc. */
-LZO_EXTERN(lzo_bool) lzo_assert(int _expr);
-LZO_EXTERN(int) _lzo_config_check(void);
 typedef union { lzo_bytep p; lzo_uint u; } __lzo_pu_u;
 typedef union { lzo_bytep p; lzo_uint32 u32; } __lzo_pu32_u;
 typedef union { void *vp; lzo_bytep bp; lzo_uint32 u32; long l; } lzo_align_t;
 
-/* align a char pointer on a boundary that is a multiple of `size' */
-LZO_EXTERN(unsigned) __lzo_align_gap(const lzo_voidp _ptr, lzo_uint _size);
 #define LZO_PTR_ALIGN_UP(_ptr,_size) \
     ((_ptr) + (lzo_uint) __lzo_align_gap((const lzo_voidp)(_ptr),(lzo_uint)(_size)))
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/compress/minilzo.c.old	2005-03-01 21:41:20.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/compress/minilzo.c	2005-03-01 22:39:25.000000000 +0100
@@ -151,18 +151,6 @@
 #  undef HAVE_MEMCMP
 #endif
 
-#if !defined(HAVE_MEMCMP)
-#  undef memcmp
-#  define memcmp    lzo_memcmp
-#endif
-#if !defined(HAVE_MEMCPY)
-#  undef memcpy
-#  define memcpy    lzo_memcpy
-#endif
-#if !defined(HAVE_MEMMOVE)
-#  undef memmove
-#  define memmove   lzo_memmove
-#endif
 #if !defined(HAVE_MEMSET)
 #  undef memset
 #  define memset    lzo_memset
@@ -297,9 +285,6 @@
 #  endif
 #endif
 
-__LZO_EXTERN_C int __lzo_init_done;
-__LZO_EXTERN_C const lzo_byte __lzo_copyright[];
-LZO_EXTERN(const lzo_byte *) lzo_copyright(void);
 __LZO_EXTERN_C const lzo_uint32 _lzo_crc32_table[256];
 
 #define _LZO_STRINGIZE(x)           #x
@@ -428,9 +413,6 @@
 #define PTR_DIFF(a,b)       ((lzo_ptrdiff_t) (PTR(a) - PTR(b)))
 #define pd(a,b)             ((lzo_uint) ((a)-(b)))
 
-LZO_EXTERN(lzo_ptr_t)
-__lzo_ptr_linear(const lzo_voidp ptr);
-
 typedef union
 {
     char            a_char;
@@ -488,7 +470,7 @@
 
 #endif
 
-LZO_PUBLIC(lzo_ptr_t)
+static lzo_ptr_t
 __lzo_ptr_linear(const lzo_voidp ptr)
 {
     lzo_ptr_t p;
@@ -502,7 +484,7 @@
     return p;
 }
 
-LZO_PUBLIC(unsigned)
+static unsigned
 __lzo_align_gap(const lzo_voidp ptr, lzo_uint size)
 {
     lzo_ptr_t p, s, n;
@@ -649,12 +631,6 @@
 
 #endif
 
-LZO_PUBLIC(lzo_bool)
-lzo_assert(int expr)
-{
-    return (expr) ? 1 : 0;
-}
-
 /* If you use the LZO library in a product, you *must* keep this
  * copyright string in the executable of your product.
  */
@@ -737,41 +713,6 @@
     "$Copyright: LZO (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002 Markus Franz Xaver Johannes Oberhumer $\n";
 #endif
 
-LZO_PUBLIC(const lzo_byte *)
-lzo_copyright(void)
-{
-    return __lzo_copyright;
-}
-
-LZO_PUBLIC(unsigned)
-lzo_version(void)
-{
-    return LZO_VERSION;
-}
-
-LZO_PUBLIC(const char *)
-lzo_version_string(void)
-{
-    return LZO_VERSION_STRING;
-}
-
-LZO_PUBLIC(const char *)
-lzo_version_date(void)
-{
-    return LZO_VERSION_DATE;
-}
-
-LZO_PUBLIC(const lzo_charp)
-_lzo_version_string(void)
-{
-    return LZO_VERSION_STRING;
-}
-
-LZO_PUBLIC(const lzo_charp)
-_lzo_version_date(void)
-{
-    return LZO_VERSION_DATE;
-}
 
 #define LZO_BASE 65521u
 #define LZO_NMAX 5552
@@ -782,109 +723,7 @@
 #define LZO_DO8(buf,i)  LZO_DO4(buf,i); LZO_DO4(buf,i+4);
 #define LZO_DO16(buf,i) LZO_DO8(buf,i); LZO_DO8(buf,i+8);
 
-LZO_PUBLIC(lzo_uint32)
-lzo_adler32(lzo_uint32 adler, const lzo_byte *buf, lzo_uint len)
-{
-    lzo_uint32 s1 = adler & 0xffff;
-    lzo_uint32 s2 = (adler >> 16) & 0xffff;
-    int k;
-
-    if (buf == NULL)
-	return 1;
-
-    while (len > 0)
-    {
-	k = len < LZO_NMAX ? (int) len : LZO_NMAX;
-	len -= k;
-	if (k >= 16) do
-	{
-	    LZO_DO16(buf,0);
-	    buf += 16;
-	    k -= 16;
-	} while (k >= 16);
-	if (k != 0) do
-	{
-	    s1 += *buf++;
-	    s2 += s1;
-	} while (--k > 0);
-	s1 %= LZO_BASE;
-	s2 %= LZO_BASE;
-    }
-    return (s2 << 16) | s1;
-}
-
-LZO_PUBLIC(int)
-lzo_memcmp(const lzo_voidp s1, const lzo_voidp s2, lzo_uint len)
-{
-#if (LZO_UINT_MAX <= SIZE_T_MAX) && defined(HAVE_MEMCMP)
-    return memcmp(s1,s2,len);
-#else
-    const lzo_byte *p1 = (const lzo_byte *) s1;
-    const lzo_byte *p2 = (const lzo_byte *) s2;
-    int d;
-
-    if (len > 0) do
-    {
-	d = *p1 - *p2;
-	if (d != 0)
-	    return d;
-	p1++;
-	p2++;
-    }
-    while (--len > 0);
-    return 0;
-#endif
-}
-
-LZO_PUBLIC(lzo_voidp)
-lzo_memcpy(lzo_voidp dest, const lzo_voidp src, lzo_uint len)
-{
-#if (LZO_UINT_MAX <= SIZE_T_MAX) && defined(HAVE_MEMCPY)
-    return memcpy(dest,src,len);
-#else
-    lzo_byte *p1 = (lzo_byte *) dest;
-    const lzo_byte *p2 = (const lzo_byte *) src;
-
-    if (len <= 0 || p1 == p2)
-	return dest;
-    do
-	*p1++ = *p2++;
-    while (--len > 0);
-    return dest;
-#endif
-}
-
-LZO_PUBLIC(lzo_voidp)
-lzo_memmove(lzo_voidp dest, const lzo_voidp src, lzo_uint len)
-{
-#if (LZO_UINT_MAX <= SIZE_T_MAX) && defined(HAVE_MEMMOVE)
-    return memmove(dest,src,len);
-#else
-    lzo_byte *p1 = (lzo_byte *) dest;
-    const lzo_byte *p2 = (const lzo_byte *) src;
-
-    if (len <= 0 || p1 == p2)
-	return dest;
-
-    if (p1 < p2)
-    {
-	do
-	    *p1++ = *p2++;
-	while (--len > 0);
-    }
-    else
-    {
-	p1 += len;
-	p2 += len;
-	do
-	    *--p1 = *--p2;
-	while (--len > 0);
-    }
-    return dest;
-#endif
-}
-
-LZO_PUBLIC(lzo_voidp)
+static lzo_voidp
 lzo_memset(lzo_voidp s, int c, lzo_uint len)
 {
 #if (LZO_UINT_MAX <= SIZE_T_MAX) && defined(HAVE_MEMSET)
@@ -1169,7 +1008,7 @@
     return r;
 }
 
-LZO_PUBLIC(int)
+static int
 _lzo_config_check(void)
 {
     lzo_bool r = 1;
@@ -1324,16 +1163,12 @@
 
 #undef COMPILE_TIME_ASSERT
 
-int __lzo_init_done = 0;
-
 LZO_PUBLIC(int)
 __lzo_init2(unsigned v, int s1, int s2, int s3, int s4, int s5,
 			int s6, int s7, int s8, int s9)
 {
     int r;
 
-    __lzo_init_done = 1;
-
     if (v == 0)
 	return LZO_E_ERROR;
 
@@ -2549,8 +2384,10 @@
 #  define COPY4(dst,src)    __COPY4((lzo_ptr_t)(dst),(lzo_ptr_t)(src))
 #endif
 
+#if 0
+
 #if defined(DO_DECOMPRESS)
-LZO_PUBLIC(int)
+static int
 DO_DECOMPRESS  ( const lzo_byte *in , lzo_uint  in_len,
 		       lzo_byte *out, lzo_uintp out_len,
 		       lzo_voidp wrkmem )
@@ -2943,5 +2780,7 @@
 #endif
 }
 
+#endif  /*  0  */
+
 /***** End of minilzo.c *****/
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/cluster.h.old	2005-03-01 22:00:45.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/cluster.h	2005-03-01 22:02:02.000000000 +0100
@@ -231,8 +231,6 @@
 void truncate_page_cluster(struct inode * inode, cloff_t start);
 void set_hint_cluster(struct inode * inode, hint_t * hint, unsigned long index, znode_lock_mode mode);
 int get_disk_cluster_locked(reiser4_cluster_t * clust, struct inode * inode, znode_lock_mode lock_mode);
-void set_nrpages_by_inode(reiser4_cluster_t * clust, struct inode * inode);
-int grab_cluster_pages(struct inode * inode, reiser4_cluster_t * clust);
 void reset_cluster_params(reiser4_cluster_t * clust);
 int prepare_page_cluster(struct inode *inode, reiser4_cluster_t *clust, int capture);
 void release_cluster_pages(reiser4_cluster_t * clust, int from);
@@ -241,7 +239,6 @@
 int tfm_cluster_is_uptodate (tfm_cluster_t * tc);
 void tfm_cluster_set_uptodate (tfm_cluster_t * tc);
 void tfm_cluster_clr_uptodate (tfm_cluster_t * tc);
-int new_cluster(reiser4_cluster_t * clust, struct inode * inode);
 unsigned long clust_by_coord(const coord_t * coord, struct inode * inode);
 
 static inline int
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/file/funcs.h.old	2005-03-01 22:03:07.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/file/funcs.h	2005-03-01 22:03:14.000000000 +0100
@@ -11,8 +11,6 @@
 int finish_conversion(struct inode *inode);
 
 void hint_init_zero(hint_t *);
-int find_file_item(hint_t *, const reiser4_key *, znode_lock_mode,
-		   ra_info_t *, struct inode *);
 int find_file_item_nohint(coord_t *, lock_handle *, const reiser4_key *,
 			  znode_lock_mode, struct inode *);
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/file/file.c.old	2005-03-01 22:03:23.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/file/file.c	2005-03-01 22:08:17.000000000 +0100
@@ -317,7 +317,7 @@
 	}
 }
 
-reiser4_internal int
+static int
 find_file_item(hint_t *hint, /* coord, lock handle and seal are here */
 	       const reiser4_key *key, /* key of position in a file of next read/write */
 	       znode_lock_mode lock_mode, /* which lock (read/write) to put on returned node */
@@ -490,7 +490,7 @@
 }
 
 /* estimate and reserve space needed to cut one item and update one stat data */
-reiser4_internal int reserve_cut_iteration(reiser4_tree *tree)
+static int reserve_cut_iteration(reiser4_tree *tree)
 {
 	__u64 estimate = estimate_one_item_removal(tree)
 		+ estimate_one_insert_into_item(tree);
@@ -2535,16 +2535,6 @@
 	return result;
 }
 
-/* plugin->u.file.can_add_link = common_file_can_add_link */
-/* VS-FIXME-HANS: why does this always resolve to extent pointer?  this wrapper serves what purpose?  get rid of it. */
-/* plugin->u.file.readpages method */
-reiser4_internal void
-readpages_unix_file(struct file *file, struct address_space *mapping,
-		    struct list_head *pages)
-{
-	assert("vs-1740", 0);
-}
-
 /* plugin->u.file.init_inode_data */
 reiser4_internal void
 init_inode_data_unix_file(struct inode *inode,
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/ctail.h.old	2005-03-01 22:05:38.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/ctail.h	2005-03-01 22:05:48.000000000 +0100
@@ -52,7 +52,6 @@
 		     carry_kill_data *, reiser4_key * smallest_removed, reiser4_key *new_first);
 int ctail_ok(const coord_t * coord);
 int check_ctail(const coord_t * coord, const char **error);
-int coord_is_unprepped_ctail(const coord_t * coord);
 
 /* plugin->u.item.s.* */
 int read_ctail(struct file *, flow_t *, hint_t *);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/ctail.c.old	2005-03-01 22:05:56.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/ctail.c	2005-03-01 23:12:44.000000000 +0100
@@ -61,7 +61,7 @@
 	return get_key_offset(item_key_by_coord(coord, &key)) >> PAGE_CACHE_SHIFT;
 }
 
-reiser4_internal int
+static int
 coord_is_unprepped_ctail(const coord_t * coord)
 {
 	assert("edward-1233", coord != NULL);
@@ -1063,6 +1063,7 @@
 }
 
 /* Create a disk cluster of special 'minimal' format */
+#if 0
 int ctail_make_unprepped_cluster(reiser4_cluster_t * clust, struct inode * inode)
 {
 	char buf[UCTAIL_NR_UNITS];
@@ -1119,6 +1120,7 @@
 #endif
 	return 0;
 }
+#endif  /*  0  */
 
 static int
 do_convert_ctail(flush_pos_t * pos, crc_write_mode_t mode)
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/extent.h.old	2005-03-01 22:09:18.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/extent.h	2005-03-01 22:09:23.000000000 +0100
@@ -118,7 +118,6 @@
 reiser4_key *unit_key_extent(const coord_t *, reiser4_key *);
 reiser4_key *max_unit_key_extent(const coord_t *, reiser4_key *);
 void print_extent(const char *, coord_t *);
-void show_extent(struct seq_file *m, coord_t *coord);
 int utmost_child_extent(const coord_t * coord, sideof side, jnode ** child);
 int utmost_child_real_block_extent(const coord_t * coord, sideof side, reiser4_block_nr * block);
 void item_stat_extent(const coord_t * coord, void *vp);
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/extent_item_ops.c.old	2005-03-01 22:09:31.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/extent_item_ops.c	2005-03-01 22:09:50.000000000 +0100
@@ -62,6 +62,7 @@
 }
 
 /* item_plugin->b.show */
+#if 0
 reiser4_internal void
 show_extent(struct seq_file *m, coord_t *coord)
 {
@@ -69,6 +70,7 @@
 	ext = extent_by_coord(coord);
 	seq_printf(m, "%llu %llu", extent_get_start(ext), extent_get_width(ext));
 }
+#endif  /*  0  */
 
 
 #if REISER4_DEBUG_OUTPUT
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/tail.h.old	2005-03-01 22:10:44.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/tail.h	2005-03-01 22:10:53.000000000 +0100
@@ -37,7 +37,6 @@
 int get_block_address_tail(const coord_t *coord,
 			   sector_t block, struct buffer_head *bh);
 
-void show_tail(struct seq_file *m, coord_t *coord);
 int item_balance_dirty_pages(struct address_space *mapping, const flow_t *f,
 			     hint_t *hint, int back_to_dirty, int set_hint);
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/tail.c.old	2005-03-01 22:11:01.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/item/tail.c	2005-03-01 22:11:25.000000000 +0100
@@ -66,11 +66,6 @@
 	return 1;
 }
 
-reiser4_internal void show_tail(struct seq_file *m, coord_t *coord)
-{
-	seq_printf(m, "length: %i", item_length_by_coord(coord));
-}
-
 /* plugin->u.item.b.print
    plugin->u.item.b.check */
 
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/object.h.old	2005-03-01 22:11:40.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/object.h	2005-03-01 22:11:45.000000000 +0100
@@ -24,7 +24,6 @@
 extern reiser4_block_nr estimate_update_common(const struct inode *inode);
 extern int prepare_write_common (struct file *, struct page *, unsigned, unsigned);
 extern int key_by_inode_and_offset_common(struct inode *, loff_t, reiser4_key *);
-extern int setattr_reserve_common(reiser4_tree *);
 extern int setattr_common(struct inode *, struct iattr *);
 extern int cut_tree_worker_common(tap_t * tap, const reiser4_key * from_key,
 				  const reiser4_key * to_key, reiser4_key * smallest_removed,
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/object.c.old	2005-03-01 22:11:52.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/plugin/object.c	2005-03-01 22:12:02.000000000 +0100
@@ -912,7 +912,7 @@
 	return dplug->attach(child, parent);
 }
 
-reiser4_internal int
+static int
 setattr_reserve_common(reiser4_tree *tree)
 {
  	assert("vs-1096", is_grab_enabled(get_current_context()));
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/tree_walk.c.old	2005-03-01 22:13:40.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/tree_walk.c	2005-03-01 22:58:31.000000000 +0100
@@ -926,6 +926,8 @@
 	int                    node_completed:1;
 };
 
+#if 0
+
 /* it locks the root node, handles the restarts inside */
 static int lock_tree_root (lock_handle * lock, znode_lock_mode mode)
 {
@@ -1220,6 +1222,8 @@
 	return ret;
 }
 
+#endif  /*  0  */
+
 
 /*
    Local variables:
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/vfs_ops.c.old	2005-03-01 22:14:23.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/vfs_ops.c	2005-03-01 22:15:51.000000000 +0100
@@ -67,7 +67,7 @@
 
 extern struct dentry_operations reiser4_dentry_operation;
 
-struct file_system_type reiser4_fs_type;
+static struct file_system_type reiser4_fs_type;
 
 /* ->statfs() VFS method in reiser4 super_operations */
 static int
@@ -241,7 +241,7 @@
 /*
  * initializer for dentry_fsdata_slab called during boot or module load.
  */
-reiser4_internal int init_dentry_fsdata(void)
+static int init_dentry_fsdata(void)
 {
 	dentry_fsdata_slab = kmem_cache_create("dentry_fsdata",
 					       sizeof (reiser4_dentry_fsdata),
@@ -255,7 +255,7 @@
 /*
  * dual to init_dentry_fsdata(). Called on module unload.
  */
-reiser4_internal void done_dentry_fsdata(void)
+static void done_dentry_fsdata(void)
 {
 	kmem_cache_destroy(dentry_fsdata_slab);
 }
@@ -303,7 +303,7 @@
 /*
  * initialize file_fsdata_slab. This is called during boot or module load.
  */
-reiser4_internal int init_file_fsdata(void)
+static int init_file_fsdata(void)
 {
 	file_fsdata_slab = kmem_cache_create("file_fsdata",
 					     sizeof (reiser4_file_fsdata),
@@ -317,7 +317,7 @@
 /*
  * dual to init_file_fsdata(). Called during module unload.
  */
-reiser4_internal void done_file_fsdata(void)
+static void done_file_fsdata(void)
 {
 	kmem_cache_destroy(file_fsdata_slab);
 }
@@ -438,7 +438,7 @@
 }
 
 /* initialize slab cache where reiser4 inodes will live */
-reiser4_internal int
+static int
 init_inodecache(void)
 {
 	inode_cache = kmem_cache_create("reiser4_inode",
@@ -1332,7 +1332,7 @@
 MODULE_LICENSE("GPL");
 
 /* description of the reiser4 file system type in the VFS eyes. */
-struct file_system_type reiser4_fs_type = {
+static struct file_system_type reiser4_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "reiser4",
 	.fs_flags = FS_REQUIRES_DEV,
--- linux-2.6.11-rc5-mm1-full/fs/reiser4/wander.c.old	2005-03-01 22:16:07.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/wander.c	2005-03-01 22:16:22.000000000 +0100
@@ -1345,7 +1345,7 @@
 /* Allocate wandered blocks for current atom's OVERWRITE SET and immediately
    submit IO for allocated blocks.  We assume that current atom is in a stage
    when any atom fusion is impossible and atom is unlocked and it is safe. */
-reiser4_internal int
+static int
 alloc_wandered_blocks(struct commit_handle *ch, flush_queue_t * fq)
 {
 	reiser4_block_nr block;

