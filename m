Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbVKRDdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbVKRDdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbVKRDdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:33:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52998 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751520AbVKRDdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:33:12 -0500
Date: Fri, 18 Nov 2005 04:33:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-list@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/reiser4/: possible cleanups
Message-ID: <20051118033310.GQ11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if unused code away


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/estimate.c                  |    2 +-
 fs/reiser4/flush_queue.c               |    2 ++
 fs/reiser4/fsdata.c                    |    9 ++++++---
 fs/reiser4/fsdata.h                    |    3 ---
 fs/reiser4/init_super.c                |    4 +++-
 fs/reiser4/inode.c                     |    7 ++-----
 fs/reiser4/jnode.c                     |    2 ++
 fs/reiser4/key.c                       |    2 ++
 fs/reiser4/key.h                       |    1 -
 fs/reiser4/lock.c                      |    3 +++
 fs/reiser4/oid.c                       |    2 ++
 fs/reiser4/plugin/file/cryptcompress.c |    4 ++++
 fs/reiser4/plugin/file/file.h          |    3 ---
 fs/reiser4/plugin/plugin.c             |   12 ++++++------
 fs/reiser4/plugin/plugin.h             |    2 --
 fs/reiser4/readahead.c                 |    3 +++
 fs/reiser4/readahead.h                 |    1 -
 fs/reiser4/super.c                     |    2 ++
 fs/reiser4/super.h                     |    4 ----
 fs/reiser4/tree.c                      |    2 +-
 fs/reiser4/tree.h                      |    2 --
 fs/reiser4/tree_walk.c                 |    4 ++++
 fs/reiser4/tree_walk.h                 |    2 --
 fs/reiser4/znode.h                     |    4 ----
 24 files changed, 43 insertions(+), 39 deletions(-)

This patch contains the following possible cleanups:
- make needlessly global code static
- #if unused code away


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/flush_queue.c               |    2 ++
 fs/reiser4/fsdata.c                    |    9 ++++++---
 fs/reiser4/fsdata.h                    |    3 ---
 fs/reiser4/init_super.c                |    4 +++-
 fs/reiser4/inode.c                     |    2 ++
 fs/reiser4/jnode.c                     |    2 ++
 fs/reiser4/key.c                       |    2 ++
 fs/reiser4/key.h                       |    1 -
 fs/reiser4/lock.c                      |    3 +++
 fs/reiser4/oid.c                       |    2 ++
 fs/reiser4/plugin/file/cryptcompress.c |    4 ++++
 fs/reiser4/plugin/file/file.h          |    3 ---
 fs/reiser4/plugin/plugin.c             |   12 ++++++------
 fs/reiser4/plugin/plugin.h             |    2 --
 fs/reiser4/readahead.c                 |    3 +++
 fs/reiser4/readahead.h                 |    1 -
 fs/reiser4/super.c                     |    2 ++
 fs/reiser4/super.h                     |    4 ----
 fs/reiser4/tree.c                      |    2 +-
 fs/reiser4/tree.h                      |    2 --
 fs/reiser4/tree_walk.c                 |    4 ++++
 fs/reiser4/tree_walk.h                 |    2 --
 fs/reiser4/znode.c                     |    2 ++
 fs/reiser4/znode.h                     |    4 ----
 24 files changed, 44 insertions(+), 33 deletions(-)

--- linux-2.6.14-rc5-mm1/fs/reiser4/flush_queue.c.old	2005-10-28 22:51:31.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/flush_queue.c	2005-10-28 22:57:29.000000000 +0200
@@ -644,6 +644,7 @@
 	INIT_LIST_HEAD(&atom->flush_queues);
 }
 
+#ifdef REISER4_USE_EFLUSH
 /* get a flush queue for an atom pointed by given jnode (spin-locked) ; returns
  * both atom and jnode locked and found and took exclusive access for flush
  * queue object.  */
@@ -707,6 +708,7 @@
 
 	return 0;
 }
+#endif  /*  REISER4_USE_EFLUSH  */
 
 #if REISER4_DEBUG
 
--- linux-2.6.14-rc5-mm1/fs/reiser4/fsdata.h.old	2005-10-28 22:52:19.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/fsdata.h	2005-10-28 22:54:19.000000000 +0200
@@ -135,8 +135,6 @@
 extern void done_file_fsdata(void);
 extern reiser4_file_fsdata *reiser4_get_file_fsdata(struct file *);
 extern void reiser4_free_file_fsdata(struct file *);
-extern reiser4_file_fsdata *create_fsdata(struct file *);
-extern void free_fsdata(reiser4_file_fsdata *);
 
 
 /*
@@ -182,7 +180,6 @@
 extern int init_super_d_info(struct super_block *);
 extern void done_super_d_info(struct super_block *);
 
-extern int file_is_stateless(struct file *);
 extern loff_t get_dir_fpos(struct file *);
 extern int try_to_attach_fsdata(struct file *, struct inode *);
 extern void detach_fsdata(struct file *);
--- linux-2.6.14-rc5-mm1/fs/reiser4/fsdata.c.old	2005-10-28 22:52:34.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/fsdata.c	2005-10-28 22:54:41.000000000 +0200
@@ -18,6 +18,9 @@
 /* spinlock protecting manipulations with dir_cursor's hash table and lists */
 static spinlock_t d_lock = SPIN_LOCK_UNLOCKED;
 
+static reiser4_file_fsdata *create_fsdata(struct file *file);
+static int file_is_stateless(struct file *file);
+static void free_fsdata(reiser4_file_fsdata *fsdata);
 static void kill_cursor(dir_cursor *);
 
 /**
@@ -480,7 +483,7 @@
  * one file system operation. This means that there may be "detached state"
  * for underlying inode.
  */
-int file_is_stateless(struct file *file)
+static int file_is_stateless(struct file *file)
 {
 	return reiser4_get_dentry_fsdata(file->f_dentry)->stateless;
 }
@@ -686,7 +689,7 @@
  *
  * Allocates and initializes reiser4_file_fsdata structure.
  */
-reiser4_file_fsdata *create_fsdata(struct file *file)
+static reiser4_file_fsdata *create_fsdata(struct file *file)
 {
 	reiser4_file_fsdata *fsdata;
 
@@ -706,7 +709,7 @@
  *
  * Dual to create_fsdata(). Free reiser4_file_fsdata.
  */
-void free_fsdata(reiser4_file_fsdata *fsdata)
+static void free_fsdata(reiser4_file_fsdata *fsdata)
 {
 	BUG_ON(fsdata == NULL);
 	kmem_cache_free(file_fsdata_cache, fsdata);
--- linux-2.6.14-rc5-mm1/fs/reiser4/super.h.old	2005-10-28 22:54:56.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/super.h	2005-10-28 23:08:58.000000000 +0200
@@ -428,7 +428,6 @@
 extern __u64 reiser4_free_blocks(const struct super_block *super);
 extern void reiser4_set_free_blocks(const struct super_block *super, __u64 nr);
 extern __u32 reiser4_mkfs_id(const struct super_block *super);
-extern void reiser4_set_mkfs_id(const struct super_block *super, __u32 id);
 
 extern __u64 reiser4_free_committed_blocks(const struct super_block *super);
 
@@ -455,7 +454,6 @@
 				       const reiser4_block_nr * blk);
 extern int reiser4_fill_super(struct super_block *s, void *data, int silent);
 extern int reiser4_done_super(struct super_block *s);
-extern reiser4_plugin * get_default_plugin(pset_member memb);
 
 /* step of fill super */
 extern int init_fs_info(struct super_block *);
@@ -463,7 +461,6 @@
 extern int init_super_data(struct super_block *, char *opt_string);
 extern int init_read_super(struct super_block *, int silent);
 extern int init_root_inode(struct super_block *);
-extern void done_root_inode(struct super_block *);
 
 
 /* Maximal possible object id. */
@@ -477,7 +474,6 @@
 void oid_count_allocated(void);
 void oid_count_released(void);
 long oids_used(const struct super_block *);
-long oids_free(const struct super_block *);
 
 #if REISER4_DEBUG
 void print_fs_info(const char *prefix, const struct super_block *);
--- linux-2.6.14-rc5-mm1/fs/reiser4/init_super.c.old	2005-10-28 22:55:10.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/init_super.c	2005-10-28 22:55:48.000000000 +0200
@@ -665,7 +665,7 @@
 };
 
 /* access to default plugin table */
-reiser4_plugin *get_default_plugin(pset_member memb)
+static reiser4_plugin *get_default_plugin(pset_member memb)
 {
 	return plugin_by_id(default_plugins[memb].type,
 			    default_plugins[memb].id);
@@ -732,6 +732,7 @@
  *
  * Puts inode of root directory.
  */
+#if 0
 void done_root_inode(struct super_block *super)
 {
 	/* remove unused children of the parent dentry */
@@ -742,6 +743,7 @@
 	/* discard all inodes of filesystem */
 	invalidate_inodes(super);
 }
+#endif  /*  0  */
 
 /*
  * Local variables:
--- linux-2.6.14-rc5-mm1/fs/reiser4/jnode.c.old	2005-10-28 22:58:21.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/jnode.c	2005-10-28 22:58:38.000000000 +0200
@@ -1927,6 +1927,7 @@
 
 #endif				/* REISER4_DEBUG */
 
+#ifdef REISER4_COPY_ON_CAPTURE
 /* this is only used to created jnode during capture copy */
 jnode *jclone(jnode * node)
 {
@@ -1942,6 +1943,7 @@
 	JF_SET(clone, JNODE_CC);
 	return clone;
 }
+#endif  /*  REISER4_COPY_ON_CAPTURE  */
 
 /* Make Linus happy.
    Local variables:
--- linux-2.6.14-rc5-mm1/fs/reiser4/key.h.old	2005-10-28 22:59:04.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/key.h	2005-10-28 22:59:13.000000000 +0200
@@ -364,7 +364,6 @@
 /* size of a buffer suitable to hold human readable key representation */
 #define KEY_BUF_LEN (80)
 
-extern int sprintf_key(char *buffer, const reiser4_key * key);
 #if REISER4_DEBUG
 extern void print_key(const char *prefix, const reiser4_key * key);
 #else
--- linux-2.6.14-rc5-mm1/fs/reiser4/key.c.old	2005-10-28 22:59:20.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/key.c	2005-10-28 22:59:34.000000000 +0200
@@ -126,6 +126,7 @@
 
 #endif
 
+#if 0
 /* like print_key() but outputs key representation into @buffer. */
 int sprintf_key(char *buffer /* buffer to print key into */ ,
 		const reiser4_key * key /* key to print */ )
@@ -146,6 +147,7 @@
 			       (unsigned long long)get_key_objectid(key),
 			       (unsigned long long)get_key_offset(key));
 }
+#endif  /*  0  */
 
 /* Make Linus happy.
    Local variables:
--- linux-2.6.14-rc5-mm1/fs/reiser4/znode.h.old	2005-10-28 22:59:56.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/znode.h	2005-10-28 23:13:08.000000000 +0200
@@ -238,12 +238,8 @@
 
 #if REISER4_DEBUG
 extern void print_znode(const char *prefix, const znode * node);
-extern void print_znodes(const char *prefix, reiser4_tree * tree);
-extern void print_lock_stack(const char *prefix, lock_stack * owner);
 #else
 #define print_znode( p, n ) noop
-#define print_znodes( p, t ) noop
-#define print_lock_stack( p, o ) noop
 #endif
 
 /* Make it look like various znode functions exist instead of treating znodes as
--- linux-2.6.14-rc5-mm1/fs/reiser4/lock.c.old	2005-10-28 23:00:10.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/lock.c	2005-10-28 23:00:26.000000000 +0200
@@ -1259,6 +1259,8 @@
 }
 
 #if REISER4_DEBUG
+
+#if 0
 /* Debugging help */
 void print_lock_stack(const char *prefix, lock_stack * owner)
 {
@@ -1288,6 +1290,7 @@
 
 	spin_unlock_stack(owner);
 }
+#endif  /*  0  */
 
 /*
  * debugging functions
--- linux-2.6.14-rc5-mm1/fs/reiser4/oid.c.old	2005-10-28 23:01:19.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/oid.c	2005-10-28 23:01:36.000000000 +0200
@@ -100,6 +100,7 @@
 		return (long)-1;
 }
 
+#if 0
 /*
  * return number of "free" oids. This is used by statfs(2) to report "free"
  * inodes.
@@ -119,6 +120,7 @@
 	else
 		return (long)-1;
 }
+#endif  /*  0  */
 
 /*
  * Count oid as allocated in atom. This is done after call to oid_allocate()
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/file/file.h.old	2005-10-28 23:01:52.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/plugin/file/file.h	2005-10-28 23:02:36.000000000 +0200
@@ -174,9 +174,6 @@
 extern int readpage_cryptcompress(struct file *, struct page *);
 extern int writepages_cryptcompress(struct address_space *,
 				     struct writeback_control *);
-extern void readpages_cryptcompress(struct file *, struct address_space *,
-				    struct list_head *pages);
-extern sector_t bmap_cryptcompress(struct address_space *, sector_t lblock);
 
 
 /* file plugin operations */
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/file/cryptcompress.c.old	2005-10-28 23:02:05.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/plugin/file/cryptcompress.c	2005-10-28 23:02:51.000000000 +0200
@@ -1010,6 +1010,7 @@
 	return result;
 }
 
+#if 0
 /* plugin->readpages() */
 void
 readpages_cryptcompress(struct file *file, struct address_space *mapping,
@@ -1033,6 +1034,7 @@
 
 	return;
 }
+#endif  /*  0  */
 
 /* how much pages will be captured */
 static int cluster_nrpages_to_capture(reiser4_cluster_t * clust)
@@ -3357,6 +3359,7 @@
 /* plugin->u.file.release */
 /* plugin->u.file.get_block */
 
+#if 0
 /* implentation of vfs' bmap method of struct address_space_operations for
    cryptcompress plugin
 */
@@ -3418,6 +3421,7 @@
 		return result;
 	}
 }
+#endif  /*  0  */
 
 /* this is implementation of delete method of file plugin for cryptcompress
  */
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/plugin.h.old	2005-10-28 23:05:17.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/plugin/plugin.h	2005-10-28 23:05:23.000000000 +0200
@@ -677,8 +677,6 @@
 /* stores plugin reference in reiser4-specific part of inode */
 extern int set_object_plugin(struct inode *inode, reiser4_plugin_id id);
 extern int setup_plugins(struct super_block *super, reiser4_plugin ** area);
-extern reiser4_plugin *lookup_plugin(const char *type_label,
-				     const char *plug_label);
 extern int init_plugins(void);
 
 /* builtin plugins */
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/plugin.c.old	2005-10-28 23:05:32.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/plugin/plugin.c	2005-10-28 23:19:52.000000000 +0200
@@ -186,14 +186,8 @@
 /* initialise plugin sub-system. Just call this once on reiser4 startup. */
 int init_plugins(void);
 int setup_plugins(struct super_block *super, reiser4_plugin ** area);
-reiser4_plugin *lookup_plugin(const char *type_label, const char *plug_label);
 int locate_plugin(struct inode *inode, plugin_locator * loc);
 
-/* internal functions. */
-
-static reiser4_plugin_type find_type(const char *label);
-static reiser4_plugin *find_plugin(reiser4_plugin_type_data * ptype,
-				   const char *label);
 
 /**
  * init_plugins - initialize plugins
@@ -257,6 +251,7 @@
 	return id < plugins[type_id].builtin_num;
 }
 
+#if 0
 /* lookup plugin by scanning tables */
 reiser4_plugin *lookup_plugin(const char *type_label /* plugin type label */ ,
 			      const char *plug_label /* plugin label */ )
@@ -274,6 +269,7 @@
 		result = NULL;
 	return result;
 }
+#endif  /*  0  */
 
 /* return plugin by its @type_id and @id.
 
@@ -329,6 +325,8 @@
 	return &plugins[type_id].plugins_list;
 }
 
+#if 0
+
 /* find plugin type by label */
 static reiser4_plugin_type find_type(const char *label	/* plugin type
 							 * label */ )
@@ -370,6 +368,8 @@
 	return NULL;
 }
 
+#endif  /*  0  */
+
 int grab_plugin(struct inode *self, struct inode *ancestor, pset_member memb)
 {
 	reiser4_plugin *plug;
--- linux-2.6.14-rc5-mm1/fs/reiser4/readahead.h.old	2005-10-28 23:07:37.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/readahead.h	2005-10-28 23:07:45.000000000 +0200
@@ -32,7 +32,6 @@
 	loff_t slow_start;	/* enlarging r/a size algorithm. */
 };
 
-extern int reiser4_file_readahead(struct file *, loff_t, size_t);
 extern void reiser4_readdir_readahead_init(struct inode *dir, tap_t * tap);
 
 /* __READAHEAD_H__ */
--- linux-2.6.14-rc5-mm1/fs/reiser4/readahead.c.old	2005-10-28 23:07:53.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/readahead.c	2005-10-28 23:20:32.000000000 +0200
@@ -112,6 +112,8 @@
 	done_lh(&next_lh);
 }
 
+#if 0
+
 static inline loff_t get_max_readahead(struct reiser4_file_ra_state *ra)
 {
 	/* NOTE: ra->max_window_size is initialized in
@@ -360,6 +362,7 @@
       out:
 	return 0;
 }
+#endif  /*  0  */
 
 void reiser4_readdir_readahead_init(struct inode *dir, tap_t * tap)
 {
--- linux-2.6.14-rc5-mm1/fs/reiser4/super.c.old	2005-10-28 23:09:05.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/super.c	2005-10-28 23:09:20.000000000 +0200
@@ -120,6 +120,7 @@
 	return get_super_private(super)->mkfs_id;
 }
 
+#if 0
 /* set mkfs unique identifier */
 void reiser4_set_mkfs_id(const struct super_block *super, __u32 id)
 {
@@ -127,6 +128,7 @@
 	assert("vpf-224", is_reiser4_super(super));
 	get_super_private(super)->mkfs_id = id;
 }
+#endif  /*  0  */
 
 /* amount of free blocks in file system */
 __u64 reiser4_free_committed_blocks(const struct super_block *super)
--- linux-2.6.14-rc5-mm1/fs/reiser4/tree.h.old	2005-10-28 23:09:35.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/tree.h	2005-10-28 23:09:44.000000000 +0200
@@ -168,8 +168,6 @@
 #define spin_ordering_pred_epoch(tree) (1)
 SPIN_LOCK_FUNCTIONS(epoch, reiser4_tree, epoch_lock);
 
-extern void init_tree_0(reiser4_tree *);
-
 extern int init_tree(reiser4_tree * tree,
 		     const reiser4_block_nr * root_block, tree_level height,
 		     node_plugin * default_plugin);
--- linux-2.6.14-rc5-mm1/fs/reiser4/tree.c.old	2005-10-28 23:09:52.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/tree.c	2005-10-28 23:10:01.000000000 +0200
@@ -1814,7 +1814,7 @@
 }
 
 /* first step of reiser4 tree initialization */
-void init_tree_0(reiser4_tree * tree)
+static void init_tree_0(reiser4_tree * tree)
 {
 	assert("zam-683", tree != NULL);
 	rw_tree_init(tree);
--- linux-2.6.14-rc5-mm1/fs/reiser4/tree_walk.h.old	2005-10-28 23:11:08.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/tree_walk.h	2005-10-28 23:11:19.000000000 +0200
@@ -105,8 +105,6 @@
 	 * node or extent processing functions. */
 	int (*before) (void *);
 };
-extern int tree_walk(const reiser4_key *, int, struct tree_walk_actor *,
-		     void *);
 
 #if REISER4_DEBUG
 int check_sibling_list(znode * node);
--- linux-2.6.14-rc5-mm1/fs/reiser4/tree_walk.c.old	2005-10-28 23:11:38.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/reiser4/tree_walk.c	2005-10-28 23:12:13.000000000 +0200
@@ -910,6 +910,8 @@
 	assert("nikita-3281", check_sibling_list(before));
 }
 
+#if 0
+
 struct tw_handle {
 	/* A key for tree walking (re)start, updated after each successful tree
 	 * node processing */
@@ -1237,6 +1239,8 @@
 	return ret;
 }
 
+#endif  /*  0  */
+
 /*
    Local variables:
    c-indentation-style: "K&R"
--- linux-2.6.15-rc1-mm1-full/fs/reiser4/estimate.c.old	2005-11-18 00:32:58.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/reiser4/estimate.c	2005-11-18 00:33:17.000000000 +0100
@@ -70,7 +70,7 @@
 }
 
 /* returnes max number of nodes can be occupied by disk cluster */
-reiser4_block_nr estimate_cluster(struct inode * inode, int unprepped)
+static reiser4_block_nr estimate_cluster(struct inode * inode, int unprepped)
 {
 	int per_cluster;
 	per_cluster = (unprepped ? 1 : cluster_nrpages(inode));
--- linux-2.6.15-rc1-mm1-full/fs/reiser4/inode.c.old	2005-11-18 00:21:42.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/reiser4/inode.c	2005-11-18 00:34:36.000000000 +0100
@@ -109,17 +109,14 @@
 		return 255;
 }
 
+#if REISER4_USE_COLLISION_LIMIT
 /* Maximal number of hash collisions for this directory. */
 int max_hash_collisions(const struct inode *dir /* inode queried */ )
 {
 	assert("nikita-1711", dir != NULL);
-#if REISER4_USE_COLLISION_LIMIT
 	return reiser4_inode_data(dir)->plugin.max_collisions;
-#else
-	(void)dir;
-	return ~0;
-#endif
 }
+#endif  /*  REISER4_USE_COLLISION_LIMIT  */
 
 /* Install file, inode, and address_space operation on @inode, depending on
    its mode. */

