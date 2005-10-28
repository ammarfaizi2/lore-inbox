Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030634AbVJ1TRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030634AbVJ1TRY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVJ1TRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:17:24 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:35314 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030635AbVJ1TRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:17:03 -0400
Subject: [PATCH 3/3] fs: use struct kmem_cache instead of kmem_cache_t
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ip33zd.j5osbv.bposp7c08qwp6f6pckzvq8u7u.beaver@cs.helsinki.fi>
In-Reply-To: <ip33z8.9nchrp.cwl9eft5uvbyy7ldhjjcddapd.beaver@cs.helsinki.fi>
Date: Fri, 28 Oct 2005 22:11:37 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts fs/ to use struct kmem_cache instead of kmem_cache_t
typedef.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 adfs/super.c              |    4 ++--
 affs/super.c              |    4 ++--
 afs/super.c               |    6 +++---
 aio.c                     |    4 ++--
 befs/linuxvfs.c           |    4 ++--
 bfs/inode.c               |    4 ++--
 bio.c                     |    4 ++--
 block_dev.c               |    4 ++--
 buffer.c                  |    4 ++--
 cifs/cifsfs.c             |   14 +++++++-------
 cifs/transport.c          |    2 +-
 coda/inode.c              |    4 ++--
 dcache.c                  |    6 +++---
 dcookies.c                |    2 +-
 devfs/base.c              |    2 +-
 dnotify.c                 |    2 +-
 dquot.c                   |    2 +-
 efs/super.c               |    4 ++--
 eventpoll.c               |    4 ++--
 ext2/super.c              |    4 ++--
 ext3/super.c              |    4 ++--
 fat/cache.c               |    4 ++--
 fat/inode.c               |    4 ++--
 fcntl.c                   |    2 +-
 freevxfs/vxfs_inode.c     |    2 +-
 fuse/dev.c                |    2 +-
 fuse/inode.c              |    4 ++--
 hfs/super.c               |    4 ++--
 hfsplus/super.c           |    4 ++--
 hpfs/super.c              |    4 ++--
 hugetlbfs/inode.c         |    4 ++--
 inode.c                   |    4 ++--
 inotify.c                 |    4 ++--
 isofs/inode.c             |    4 ++--
 jbd/journal.c             |    4 ++--
 jbd/revoke.c              |    4 ++--
 jffs/inode-v23.c          |    4 ++--
 jffs/jffs_fm.c            |    4 ++--
 jffs2/malloc.c            |   14 +++++++-------
 jffs2/super.c             |    4 ++--
 jfs/jfs_metapage.c        |    4 ++--
 jfs/super.c               |    4 ++--
 locks.c                   |    4 ++--
 mbcache.c                 |    2 +-
 minix/inode.c             |    4 ++--
 namespace.c               |    2 +-
 ncpfs/inode.c             |    4 ++--
 nfs/direct.c              |    2 +-
 nfs/inode.c               |    4 ++--
 nfs/pagelist.c            |    2 +-
 nfs/read.c                |    2 +-
 nfs/write.c               |    2 +-
 nfsd/nfs4state.c          |   10 +++++-----
 ntfs/ntfs.h               |   10 +++++-----
 ntfs/super.c              |   12 ++++++------
 proc/inode.c              |    4 ++--
 qnx4/inode.c              |    4 ++--
 reiserfs/super.c          |    4 ++--
 relayfs/inode.c           |    4 ++--
 romfs/inode.c             |    4 ++--
 smbfs/inode.c             |    4 ++--
 smbfs/request.c           |    2 +-
 sysfs/mount.c             |    2 +-
 sysfs/sysfs.h             |    2 +-
 sysv/inode.c              |    4 ++--
 udf/super.c               |    4 ++--
 ufs/super.c               |    4 ++--
 xfs/linux-2.6/xfs_buf.c   |    2 +-
 xfs/linux-2.6/xfs_super.c |    2 +-
 69 files changed, 141 insertions(+), 141 deletions(-)

Index: 2.6/fs/adfs/super.c
===================================================================
--- 2.6.orig/fs/adfs/super.c
+++ 2.6/fs/adfs/super.c
@@ -212,7 +212,7 @@ static int adfs_statfs(struct super_bloc
 	return 0;
 }
 
-static kmem_cache_t *adfs_inode_cachep;
+static struct kmem_cache *adfs_inode_cachep;
 
 static struct inode *adfs_alloc_inode(struct super_block *sb)
 {
@@ -228,7 +228,7 @@ static void adfs_destroy_inode(struct in
 	kmem_cache_free(adfs_inode_cachep, ADFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct adfs_inode_info *ei = (struct adfs_inode_info *) foo;
 
Index: 2.6/fs/affs/super.c
===================================================================
--- 2.6.orig/fs/affs/super.c
+++ 2.6/fs/affs/super.c
@@ -66,7 +66,7 @@ affs_write_super(struct super_block *sb)
 	pr_debug("AFFS: write_super() at %lu, clean=%d\n", get_seconds(), clean);
 }
 
-static kmem_cache_t * affs_inode_cachep;
+static struct kmem_cache * affs_inode_cachep;
 
 static struct inode *affs_alloc_inode(struct super_block *sb)
 {
@@ -83,7 +83,7 @@ static void affs_destroy_inode(struct in
 	kmem_cache_free(affs_inode_cachep, AFFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct affs_inode_info *ei = (struct affs_inode_info *) foo;
 
Index: 2.6/fs/afs/super.c
===================================================================
--- 2.6.orig/fs/afs/super.c
+++ 2.6/fs/afs/super.c
@@ -35,7 +35,7 @@ struct afs_mount_params {
 	struct afs_volume	*volume;
 };
 
-static void afs_i_init_once(void *foo, kmem_cache_t *cachep,
+static void afs_i_init_once(void *foo, struct kmem_cache *cachep,
 			    unsigned long flags);
 
 static struct super_block *afs_get_sb(struct file_system_type *fs_type,
@@ -65,7 +65,7 @@ static struct super_operations afs_super
 	.put_super	= afs_put_super,
 };
 
-static kmem_cache_t *afs_inode_cachep;
+static struct kmem_cache *afs_inode_cachep;
 static atomic_t afs_count_active_inodes;
 
 /*****************************************************************************/
@@ -382,7 +382,7 @@ static void afs_put_super(struct super_b
 /*
  * initialise an inode cache slab element prior to any use
  */
-static void afs_i_init_once(void *_vnode, kmem_cache_t *cachep,
+static void afs_i_init_once(void *_vnode, struct kmem_cache *cachep,
 			    unsigned long flags)
 {
 	struct afs_vnode *vnode = (struct afs_vnode *) _vnode;
Index: 2.6/fs/aio.c
===================================================================
--- 2.6.orig/fs/aio.c
+++ 2.6/fs/aio.c
@@ -46,8 +46,8 @@ atomic_t aio_nr = ATOMIC_INIT(0);	/* cur
 unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
 /*----end sysctl variables---*/
 
-static kmem_cache_t	*kiocb_cachep;
-static kmem_cache_t	*kioctx_cachep;
+static struct kmem_cache	*kiocb_cachep;
+static struct kmem_cache	*kioctx_cachep;
 
 static struct workqueue_struct *aio_wq;
 
Index: 2.6/fs/befs/linuxvfs.c
===================================================================
--- 2.6.orig/fs/befs/linuxvfs.c
+++ 2.6/fs/befs/linuxvfs.c
@@ -62,7 +62,7 @@ static const struct super_operations bef
 };
 
 /* slab cache for befs_inode_info objects */
-static kmem_cache_t *befs_inode_cachep;
+static struct kmem_cache *befs_inode_cachep;
 
 static struct file_operations befs_dir_operations = {
 	.read		= generic_read_dir,
@@ -296,7 +296,7 @@ befs_destroy_inode(struct inode *inode)
         kmem_cache_free(befs_inode_cachep, BEFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
         struct befs_inode_info *bi = (struct befs_inode_info *) foo;
 	
Index: 2.6/fs/bfs/inode.c
===================================================================
--- 2.6.orig/fs/bfs/inode.c
+++ 2.6/fs/bfs/inode.c
@@ -228,7 +228,7 @@ static void bfs_write_super(struct super
 	unlock_kernel();
 }
 
-static kmem_cache_t * bfs_inode_cachep;
+static struct kmem_cache * bfs_inode_cachep;
 
 static struct inode *bfs_alloc_inode(struct super_block *sb)
 {
@@ -244,7 +244,7 @@ static void bfs_destroy_inode(struct ino
 	kmem_cache_free(bfs_inode_cachep, BFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct bfs_inode_info *bi = foo;
 
Index: 2.6/fs/bio.c
===================================================================
--- 2.6.orig/fs/bio.c
+++ 2.6/fs/bio.c
@@ -29,7 +29,7 @@
 
 #define BIO_POOL_SIZE 256
 
-static kmem_cache_t *bio_slab;
+static struct kmem_cache *bio_slab;
 
 #define BIOVEC_NR_POOLS 6
 
@@ -43,7 +43,7 @@ mempool_t *bio_split_pool;
 struct biovec_slab {
 	int nr_vecs;
 	char *name; 
-	kmem_cache_t *slab;
+	struct kmem_cache *slab;
 };
 
 /*
Index: 2.6/fs/block_dev.c
===================================================================
--- 2.6.orig/fs/block_dev.c
+++ 2.6/fs/block_dev.c
@@ -238,7 +238,7 @@ static int block_fsync(struct file *filp
  */
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(bdev_lock);
-static kmem_cache_t * bdev_cachep;
+static struct kmem_cache * bdev_cachep;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
@@ -256,7 +256,7 @@ static void bdev_destroy_inode(struct in
 	kmem_cache_free(bdev_cachep, bdi);
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct bdev_inode *ei = (struct bdev_inode *) foo;
 	struct block_device *bdev = &ei->bdev;
Index: 2.6/fs/buffer.c
===================================================================
--- 2.6.orig/fs/buffer.c
+++ 2.6/fs/buffer.c
@@ -3015,7 +3015,7 @@ asmlinkage long sys_bdflush(int func, lo
 /*
  * Buffer-head allocation
  */
-static kmem_cache_t *bh_cachep;
+static struct kmem_cache *bh_cachep;
 
 /*
  * Once the number of bh's in the machine exceeds this level, we start
@@ -3068,7 +3068,7 @@ void free_buffer_head(struct buffer_head
 EXPORT_SYMBOL(free_buffer_head);
 
 static void
-init_buffer_head(void *data, kmem_cache_t *cachep, unsigned long flags)
+init_buffer_head(void *data, struct kmem_cache *cachep, unsigned long flags)
 {
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 			    SLAB_CTOR_CONSTRUCTOR) {
Index: 2.6/fs/cifs/cifsfs.c
===================================================================
--- 2.6.orig/fs/cifs/cifsfs.c
+++ 2.6/fs/cifs/cifsfs.c
@@ -78,7 +78,7 @@ extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
 extern mempool_t *cifs_mid_poolp;
 
-extern kmem_cache_t *cifs_oplock_cachep;
+extern struct kmem_cache *cifs_oplock_cachep;
 
 static int
 cifs_read_super(struct super_block *sb, void *data,
@@ -227,11 +227,11 @@ static int cifs_permission(struct inode 
 		return generic_permission(inode, mask, NULL);
 }
 
-static kmem_cache_t *cifs_inode_cachep;
-static kmem_cache_t *cifs_req_cachep;
-static kmem_cache_t *cifs_mid_cachep;
-kmem_cache_t *cifs_oplock_cachep;
-static kmem_cache_t *cifs_sm_req_cachep;
+static struct kmem_cache *cifs_inode_cachep;
+static struct kmem_cache *cifs_req_cachep;
+static struct kmem_cache *cifs_mid_cachep;
+struct kmem_cache *cifs_oplock_cachep;
+static struct kmem_cache *cifs_sm_req_cachep;
 mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
 mempool_t *cifs_mid_poolp;
@@ -607,7 +607,7 @@ struct file_operations cifs_dir_ops = {
 };
 
 static void
-cifs_init_once(void *inode, kmem_cache_t * cachep, unsigned long flags)
+cifs_init_once(void *inode, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct cifsInodeInfo *cifsi = inode;
 
Index: 2.6/fs/cifs/transport.c
===================================================================
--- 2.6.orig/fs/cifs/transport.c
+++ 2.6/fs/cifs/transport.c
@@ -33,7 +33,7 @@
 #include "cifs_debug.h"
   
 extern mempool_t *cifs_mid_poolp;
-extern kmem_cache_t *cifs_oplock_cachep;
+extern struct kmem_cache *cifs_oplock_cachep;
 
 static struct mid_q_entry *
 AllocMidQEntry(struct smb_hdr *smb_buffer, struct cifsSesInfo *ses)
Index: 2.6/fs/coda/inode.c
===================================================================
--- 2.6.orig/fs/coda/inode.c
+++ 2.6/fs/coda/inode.c
@@ -36,7 +36,7 @@ static void coda_clear_inode(struct inod
 static void coda_put_super(struct super_block *);
 static int coda_statfs(struct super_block *sb, struct kstatfs *buf);
 
-static kmem_cache_t * coda_inode_cachep;
+static struct kmem_cache * coda_inode_cachep;
 
 static struct inode *coda_alloc_inode(struct super_block *sb)
 {
@@ -56,7 +56,7 @@ static void coda_destroy_inode(struct in
 	kmem_cache_free(coda_inode_cachep, ITOC(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct coda_inode_info *ei = (struct coda_inode_info *) foo;
 
Index: 2.6/fs/dcache.c
===================================================================
--- 2.6.orig/fs/dcache.c
+++ 2.6/fs/dcache.c
@@ -44,7 +44,7 @@ static seqlock_t rename_lock __cacheline
 
 EXPORT_SYMBOL(dcache_lock);
 
-static kmem_cache_t *dentry_cache; 
+static struct kmem_cache *dentry_cache; 
 
 #define DNAME_INLINE_LEN (sizeof(struct dentry)-offsetof(struct dentry,d_iname))
 
@@ -1701,10 +1701,10 @@ static void __init dcache_init(unsigned 
 }
 
 /* SLAB cache for __getname() consumers */
-kmem_cache_t *names_cachep;
+struct kmem_cache *names_cachep;
 
 /* SLAB cache for file structures */
-kmem_cache_t *filp_cachep;
+struct kmem_cache *filp_cachep;
 
 EXPORT_SYMBOL(d_genocide);
 
Index: 2.6/fs/dcookies.c
===================================================================
--- 2.6.orig/fs/dcookies.c
+++ 2.6/fs/dcookies.c
@@ -36,7 +36,7 @@ struct dcookie_struct {
 
 static LIST_HEAD(dcookie_users);
 static DECLARE_MUTEX(dcookie_sem);
-static kmem_cache_t * dcookie_cache;
+static struct kmem_cache * dcookie_cache;
 static struct list_head * dcookie_hashtable;
 static size_t hash_size;
 
Index: 2.6/fs/devfs/base.c
===================================================================
--- 2.6.orig/fs/devfs/base.c
+++ 2.6/fs/devfs/base.c
@@ -827,7 +827,7 @@ struct fs_info {		/*  This structure is 
 };
 
 static struct fs_info fs_info = {.devfsd_buffer_lock = SPIN_LOCK_UNLOCKED };
-static kmem_cache_t *devfsd_buf_cache;
+static struct kmem_cache *devfsd_buf_cache;
 #ifdef CONFIG_DEVFS_DEBUG
 static unsigned int devfs_debug_init __initdata = DEBUG_NONE;
 static unsigned int devfs_debug = DEBUG_NONE;
Index: 2.6/fs/dnotify.c
===================================================================
--- 2.6.orig/fs/dnotify.c
+++ 2.6/fs/dnotify.c
@@ -23,7 +23,7 @@
 
 int dir_notify_enable = 1;
 
-static kmem_cache_t *dn_cache;
+static struct kmem_cache *dn_cache;
 
 static void redo_inode_mask(struct inode *inode)
 {
Index: 2.6/fs/dquot.c
===================================================================
--- 2.6.orig/fs/dquot.c
+++ 2.6/fs/dquot.c
@@ -129,7 +129,7 @@ static struct quota_format_type *quota_f
 static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 
 /* SLAB cache for dquot structures */
-static kmem_cache_t *dquot_cachep;
+static struct kmem_cache *dquot_cachep;
 
 int register_quota_format(struct quota_format_type *fmt)
 {
Index: 2.6/fs/efs/super.c
===================================================================
--- 2.6.orig/fs/efs/super.c
+++ 2.6/fs/efs/super.c
@@ -52,7 +52,7 @@ static struct pt_types sgi_pt_types[] = 
 };
 
 
-static kmem_cache_t * efs_inode_cachep;
+static struct kmem_cache * efs_inode_cachep;
 
 static struct inode *efs_alloc_inode(struct super_block *sb)
 {
@@ -68,7 +68,7 @@ static void efs_destroy_inode(struct ino
 	kmem_cache_free(efs_inode_cachep, INODE_INFO(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct efs_inode_info *ei = (struct efs_inode_info *) foo;
 
Index: 2.6/fs/eventpoll.c
===================================================================
--- 2.6.orig/fs/eventpoll.c
+++ 2.6/fs/eventpoll.c
@@ -280,10 +280,10 @@ static struct semaphore epsem;
 static struct poll_safewake psw;
 
 /* Slab cache used to allocate "struct epitem" */
-static kmem_cache_t *epi_cache;
+static struct kmem_cache *epi_cache;
 
 /* Slab cache used to allocate "struct eppoll_entry" */
-static kmem_cache_t *pwq_cache;
+static struct kmem_cache *pwq_cache;
 
 /* Virtual fs used to allocate inodes for eventpoll files */
 static struct vfsmount *eventpoll_mnt;
Index: 2.6/fs/ext2/super.c
===================================================================
--- 2.6.orig/fs/ext2/super.c
+++ 2.6/fs/ext2/super.c
@@ -136,7 +136,7 @@ static void ext2_put_super (struct super
 	return;
 }
 
-static kmem_cache_t * ext2_inode_cachep;
+static struct kmem_cache * ext2_inode_cachep;
 
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
@@ -157,7 +157,7 @@ static void ext2_destroy_inode(struct in
 	kmem_cache_free(ext2_inode_cachep, EXT2_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct ext2_inode_info *ei = (struct ext2_inode_info *) foo;
 
Index: 2.6/fs/ext3/super.c
===================================================================
--- 2.6.orig/fs/ext3/super.c
+++ 2.6/fs/ext3/super.c
@@ -432,7 +432,7 @@ static void ext3_put_super (struct super
 	return;
 }
 
-static kmem_cache_t *ext3_inode_cachep;
+static struct kmem_cache *ext3_inode_cachep;
 
 /*
  * Called inside transaction, so use GFP_NOFS
@@ -458,7 +458,7 @@ static void ext3_destroy_inode(struct in
 	kmem_cache_free(ext3_inode_cachep, EXT3_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct ext3_inode_info *ei = (struct ext3_inode_info *) foo;
 
Index: 2.6/fs/fat/cache.c
===================================================================
--- 2.6.orig/fs/fat/cache.c
+++ 2.6/fs/fat/cache.c
@@ -34,9 +34,9 @@ static inline int fat_max_cache(struct i
 	return FAT_MAX_CACHE;
 }
 
-static kmem_cache_t *fat_cache_cachep;
+static struct kmem_cache *fat_cache_cachep;
 
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct fat_cache *cache = (struct fat_cache *)foo;
 
Index: 2.6/fs/fat/inode.c
===================================================================
--- 2.6.orig/fs/fat/inode.c
+++ 2.6/fs/fat/inode.c
@@ -399,7 +399,7 @@ static void fat_put_super(struct super_b
 	kfree(sbi);
 }
 
-static kmem_cache_t *fat_inode_cachep;
+static struct kmem_cache *fat_inode_cachep;
 
 static struct inode *fat_alloc_inode(struct super_block *sb)
 {
@@ -415,7 +415,7 @@ static void fat_destroy_inode(struct ino
 	kmem_cache_free(fat_inode_cachep, MSDOS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct msdos_inode_info *ei = (struct msdos_inode_info *)foo;
 
Index: 2.6/fs/fcntl.c
===================================================================
--- 2.6.orig/fs/fcntl.c
+++ 2.6/fs/fcntl.c
@@ -528,7 +528,7 @@ int send_sigurg(struct fown_struct *fown
 }
 
 static DEFINE_RWLOCK(fasync_lock);
-static kmem_cache_t *fasync_cache;
+static struct kmem_cache *fasync_cache;
 
 /*
  * fasync_helper() is used by some character device drivers (mainly mice)
Index: 2.6/fs/freevxfs/vxfs_inode.c
===================================================================
--- 2.6.orig/fs/freevxfs/vxfs_inode.c
+++ 2.6/fs/freevxfs/vxfs_inode.c
@@ -55,7 +55,7 @@ static struct file_operations vxfs_file_
 };
 
 
-kmem_cache_t		*vxfs_inode_cachep;
+struct kmem_cache		*vxfs_inode_cachep;
 
 
 #ifdef DIAGNOSTIC
Index: 2.6/fs/fuse/dev.c
===================================================================
--- 2.6.orig/fs/fuse/dev.c
+++ 2.6/fs/fuse/dev.c
@@ -19,7 +19,7 @@
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 
-static kmem_cache_t *fuse_req_cachep;
+static struct kmem_cache *fuse_req_cachep;
 
 static inline struct fuse_conn *fuse_get_conn(struct file *file)
 {
Index: 2.6/fs/fuse/inode.c
===================================================================
--- 2.6.orig/fs/fuse/inode.c
+++ 2.6/fs/fuse/inode.c
@@ -23,7 +23,7 @@ MODULE_DESCRIPTION("Filesystem in Usersp
 MODULE_LICENSE("GPL");
 
 spinlock_t fuse_lock;
-static kmem_cache_t *fuse_inode_cachep;
+static struct kmem_cache *fuse_inode_cachep;
 
 #define FUSE_SUPER_MAGIC 0x65735546
 
@@ -518,7 +518,7 @@ static struct file_system_type fuse_fs_t
 	.kill_sb	= kill_anon_super,
 };
 
-static void fuse_inode_init_once(void *foo, kmem_cache_t *cachep,
+static void fuse_inode_init_once(void *foo, struct kmem_cache *cachep,
 				 unsigned long flags)
 {
 	struct inode * inode = foo;
Index: 2.6/fs/hfs/super.c
===================================================================
--- 2.6.orig/fs/hfs/super.c
+++ 2.6/fs/hfs/super.c
@@ -25,7 +25,7 @@
 #include "hfs_fs.h"
 #include "btree.h"
 
-static kmem_cache_t *hfs_inode_cachep;
+static struct kmem_cache *hfs_inode_cachep;
 
 MODULE_LICENSE("GPL");
 
@@ -427,7 +427,7 @@ static struct file_system_type hfs_fs_ty
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
-static void hfs_init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+static void hfs_init_once(void *p, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct hfs_inode_info *i = p;
 
Index: 2.6/fs/hfsplus/super.c
===================================================================
--- 2.6.orig/fs/hfsplus/super.c
+++ 2.6/fs/hfsplus/super.c
@@ -441,7 +441,7 @@ MODULE_AUTHOR("Brad Boyer");
 MODULE_DESCRIPTION("Extended Macintosh Filesystem");
 MODULE_LICENSE("GPL");
 
-static kmem_cache_t *hfsplus_inode_cachep;
+static struct kmem_cache *hfsplus_inode_cachep;
 
 static struct inode *hfsplus_alloc_inode(struct super_block *sb)
 {
@@ -472,7 +472,7 @@ static struct file_system_type hfsplus_f
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
-static void hfsplus_init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+static void hfsplus_init_once(void *p, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct hfsplus_inode_info *i = p;
 
Index: 2.6/fs/hpfs/super.c
===================================================================
--- 2.6.orig/fs/hpfs/super.c
+++ 2.6/fs/hpfs/super.c
@@ -158,7 +158,7 @@ static int hpfs_statfs(struct super_bloc
 	return 0;
 }
 
-static kmem_cache_t * hpfs_inode_cachep;
+static struct kmem_cache * hpfs_inode_cachep;
 
 static struct inode *hpfs_alloc_inode(struct super_block *sb)
 {
@@ -175,7 +175,7 @@ static void hpfs_destroy_inode(struct in
 	kmem_cache_free(hpfs_inode_cachep, hpfs_i(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct hpfs_inode_info *ei = (struct hpfs_inode_info *) foo;
 
Index: 2.6/fs/hugetlbfs/inode.c
===================================================================
--- 2.6.orig/fs/hugetlbfs/inode.c
+++ 2.6/fs/hugetlbfs/inode.c
@@ -531,7 +531,7 @@ static void hugetlbfs_put_super(struct s
 	}
 }
 
-static kmem_cache_t *hugetlbfs_inode_cachep;
+static struct kmem_cache *hugetlbfs_inode_cachep;
 
 static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 {
@@ -543,7 +543,7 @@ static struct inode *hugetlbfs_alloc_ino
 	return &p->vfs_inode;
 }
 
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct hugetlbfs_inode_info *ei = (struct hugetlbfs_inode_info *)foo;
 
Index: 2.6/fs/inode.c
===================================================================
--- 2.6.orig/fs/inode.c
+++ 2.6/fs/inode.c
@@ -97,7 +97,7 @@ DECLARE_MUTEX(iprune_sem);
  */
 struct inodes_stat_t inodes_stat;
 
-static kmem_cache_t * inode_cachep;
+static struct kmem_cache * inode_cachep;
 
 static struct inode *alloc_inode(struct super_block *sb)
 {
@@ -211,7 +211,7 @@ void inode_init_once(struct inode *inode
 
 EXPORT_SYMBOL(inode_init_once);
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct inode * inode = (struct inode *) foo;
 
Index: 2.6/fs/inotify.c
===================================================================
--- 2.6.orig/fs/inotify.c
+++ 2.6/fs/inotify.c
@@ -39,8 +39,8 @@
 static atomic_t inotify_cookie;
 static atomic_t inotify_watches;
 
-static kmem_cache_t *watch_cachep;
-static kmem_cache_t *event_cachep;
+static struct kmem_cache *watch_cachep;
+static struct kmem_cache *event_cachep;
 
 static struct vfsmount *inotify_mnt;
 
Index: 2.6/fs/isofs/inode.c
===================================================================
--- 2.6.orig/fs/isofs/inode.c
+++ 2.6/fs/isofs/inode.c
@@ -58,7 +58,7 @@ static void isofs_put_super(struct super
 static void isofs_read_inode(struct inode *);
 static int isofs_statfs (struct super_block *, struct kstatfs *);
 
-static kmem_cache_t *isofs_inode_cachep;
+static struct kmem_cache *isofs_inode_cachep;
 
 static struct inode *isofs_alloc_inode(struct super_block *sb)
 {
@@ -74,7 +74,7 @@ static void isofs_destroy_inode(struct i
 	kmem_cache_free(isofs_inode_cachep, ISOFS_I(inode));
 }
 
-static void init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct iso_inode_info *ei = foo;
 
Index: 2.6/fs/jbd/journal.c
===================================================================
--- 2.6.orig/fs/jbd/journal.c
+++ 2.6/fs/jbd/journal.c
@@ -1614,7 +1614,7 @@ void * __jbd_kmalloc (const char *where,
 /*
  * Journal_head storage management
  */
-static kmem_cache_t *journal_head_cache;
+static struct kmem_cache *journal_head_cache;
 #ifdef CONFIG_JBD_DEBUG
 static atomic_t nr_journal_heads = ATOMIC_INIT(0);
 #endif
@@ -1917,7 +1917,7 @@ static void __exit remove_jbd_proc_entry
 
 #endif
 
-kmem_cache_t *jbd_handle_cache;
+struct kmem_cache *jbd_handle_cache;
 
 static int __init journal_init_handle_cache(void)
 {
Index: 2.6/fs/jbd/revoke.c
===================================================================
--- 2.6.orig/fs/jbd/revoke.c
+++ 2.6/fs/jbd/revoke.c
@@ -70,8 +70,8 @@
 #include <linux/init.h>
 #endif
 
-static kmem_cache_t *revoke_record_cache;
-static kmem_cache_t *revoke_table_cache;
+static struct kmem_cache *revoke_record_cache;
+static struct kmem_cache *revoke_table_cache;
 
 /* Each revoke record represents one single revoked block.  During
    journal replay, this involves recording the transaction ID of the
Index: 2.6/fs/jffs/inode-v23.c
===================================================================
--- 2.6.orig/fs/jffs/inode-v23.c
+++ 2.6/fs/jffs/inode-v23.c
@@ -61,8 +61,8 @@ static struct file_operations jffs_dir_o
 static struct inode_operations jffs_dir_inode_operations;
 static struct address_space_operations jffs_address_operations;
 
-kmem_cache_t     *node_cache = NULL;
-kmem_cache_t     *fm_cache = NULL;
+struct kmem_cache     *node_cache = NULL;
+struct kmem_cache     *fm_cache = NULL;
 
 /* Called by the VFS at mount time to initialize the whole file system.  */
 static int jffs_fill_super(struct super_block *sb, void *data, int silent)
Index: 2.6/fs/jffs/jffs_fm.c
===================================================================
--- 2.6.orig/fs/jffs/jffs_fm.c
+++ 2.6/fs/jffs/jffs_fm.c
@@ -28,8 +28,8 @@ static int jffs_mark_obsolete(struct jff
 static struct jffs_fm *jffs_alloc_fm(void);
 static void jffs_free_fm(struct jffs_fm *n);
 
-extern kmem_cache_t     *fm_cache;
-extern kmem_cache_t     *node_cache;
+extern struct kmem_cache     *fm_cache;
+extern struct kmem_cache     *node_cache;
 
 #if CONFIG_JFFS_FS_VERBOSE > 0
 void
Index: 2.6/fs/jffs2/malloc.c
===================================================================
--- 2.6.orig/fs/jffs2/malloc.c
+++ 2.6/fs/jffs2/malloc.c
@@ -28,13 +28,13 @@
 
 /* These are initialised to NULL in the kernel startup code.
    If you're porting to other operating systems, beware */
-static kmem_cache_t *full_dnode_slab;
-static kmem_cache_t *raw_dirent_slab;
-static kmem_cache_t *raw_inode_slab;
-static kmem_cache_t *tmp_dnode_info_slab;
-static kmem_cache_t *raw_node_ref_slab;
-static kmem_cache_t *node_frag_slab;
-static kmem_cache_t *inode_cache_slab;
+static struct kmem_cache *full_dnode_slab;
+static struct kmem_cache *raw_dirent_slab;
+static struct kmem_cache *raw_inode_slab;
+static struct kmem_cache *tmp_dnode_info_slab;
+static struct kmem_cache *raw_node_ref_slab;
+static struct kmem_cache *node_frag_slab;
+static struct kmem_cache *inode_cache_slab;
 
 int __init jffs2_create_slab_caches(void)
 {
Index: 2.6/fs/jffs2/super.c
===================================================================
--- 2.6.orig/fs/jffs2/super.c
+++ 2.6/fs/jffs2/super.c
@@ -29,7 +29,7 @@
 
 static void jffs2_put_super(struct super_block *);
 
-static kmem_cache_t *jffs2_inode_cachep;
+static struct kmem_cache *jffs2_inode_cachep;
 
 static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
@@ -45,7 +45,7 @@ static void jffs2_destroy_inode(struct i
 	kmem_cache_free(jffs2_inode_cachep, JFFS2_INODE_INFO(inode));
 }
 
-static void jffs2_i_init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void jffs2_i_init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct jffs2_inode_info *ei = (struct jffs2_inode_info *) foo;
 
Index: 2.6/fs/jfs/jfs_metapage.c
===================================================================
--- 2.6.orig/fs/jfs/jfs_metapage.c
+++ 2.6/fs/jfs/jfs_metapage.c
@@ -74,7 +74,7 @@ static inline void lock_metapage(struct 
 }
 
 #define METAPOOL_MIN_PAGES 32
-static kmem_cache_t *metapage_cache;
+static struct kmem_cache *metapage_cache;
 static mempool_t *metapage_mempool;
 
 #define MPS_PER_PAGE (PAGE_CACHE_SIZE >> L2PSIZE)
@@ -181,7 +181,7 @@ static inline void remove_metapage(struc
 
 #endif
 
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct metapage *mp = (struct metapage *)foo;
 
Index: 2.6/fs/jfs/super.c
===================================================================
--- 2.6.orig/fs/jfs/super.c
+++ 2.6/fs/jfs/super.c
@@ -43,7 +43,7 @@ MODULE_DESCRIPTION("The Journaled Filesy
 MODULE_AUTHOR("Steve Best/Dave Kleikamp/Barry Arndt, IBM");
 MODULE_LICENSE("GPL");
 
-static kmem_cache_t * jfs_inode_cachep;
+static struct kmem_cache * jfs_inode_cachep;
 
 static struct super_operations jfs_super_operations;
 static struct export_operations jfs_export_operations;
@@ -608,7 +608,7 @@ static struct file_system_type jfs_fs_ty
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
-static void init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct jfs_inode_info *jfs_ip = (struct jfs_inode_info *) foo;
 
Index: 2.6/fs/locks.c
===================================================================
--- 2.6.orig/fs/locks.c
+++ 2.6/fs/locks.c
@@ -145,7 +145,7 @@ EXPORT_SYMBOL(file_lock_list);
 
 static LIST_HEAD(blocked_list);
 
-static kmem_cache_t *filelock_cache;
+static struct kmem_cache *filelock_cache;
 
 /* Allocate an empty lock structure. */
 static struct file_lock *locks_alloc_lock(void)
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(locks_init_lock);
  * Initialises the fields of the file lock which are invariant for
  * free file_locks.
  */
-static void init_once(void *foo, kmem_cache_t *cache, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache *cache, unsigned long flags)
 {
 	struct file_lock *lock = (struct file_lock *) foo;
 
Index: 2.6/fs/mbcache.c
===================================================================
--- 2.6.orig/fs/mbcache.c
+++ 2.6/fs/mbcache.c
@@ -85,7 +85,7 @@ struct mb_cache {
 #ifndef MB_CACHE_INDEXES_COUNT
 	int				c_indexes_count;
 #endif
-	kmem_cache_t			*c_entry_cache;
+	struct kmem_cache			*c_entry_cache;
 	struct list_head		*c_block_hash;
 	struct list_head		*c_indexes_hash[0];
 };
Index: 2.6/fs/minix/inode.c
===================================================================
--- 2.6.orig/fs/minix/inode.c
+++ 2.6/fs/minix/inode.c
@@ -51,7 +51,7 @@ static void minix_put_super(struct super
 	return;
 }
 
-static kmem_cache_t * minix_inode_cachep;
+static struct kmem_cache * minix_inode_cachep;
 
 static struct inode *minix_alloc_inode(struct super_block *sb)
 {
@@ -67,7 +67,7 @@ static void minix_destroy_inode(struct i
 	kmem_cache_free(minix_inode_cachep, minix_i(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct minix_inode_info *ei = (struct minix_inode_info *) foo;
 
Index: 2.6/fs/namespace.c
===================================================================
--- 2.6.orig/fs/namespace.c
+++ 2.6/fs/namespace.c
@@ -41,7 +41,7 @@ static inline int sysfs_init(void)
 
 static struct list_head *mount_hashtable;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
-static kmem_cache_t *mnt_cache; 
+static struct kmem_cache *mnt_cache; 
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
Index: 2.6/fs/ncpfs/inode.c
===================================================================
--- 2.6.orig/fs/ncpfs/inode.c
+++ 2.6/fs/ncpfs/inode.c
@@ -41,7 +41,7 @@ static void ncp_delete_inode(struct inod
 static void ncp_put_super(struct super_block *);
 static int  ncp_statfs(struct super_block *, struct kstatfs *);
 
-static kmem_cache_t * ncp_inode_cachep;
+static struct kmem_cache * ncp_inode_cachep;
 
 static struct inode *ncp_alloc_inode(struct super_block *sb)
 {
@@ -57,7 +57,7 @@ static void ncp_destroy_inode(struct ino
 	kmem_cache_free(ncp_inode_cachep, NCP_FINFO(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct ncp_inode_info *ei = (struct ncp_inode_info *) foo;
 
Index: 2.6/fs/nfs/direct.c
===================================================================
--- 2.6.orig/fs/nfs/direct.c
+++ 2.6/fs/nfs/direct.c
@@ -57,7 +57,7 @@
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define MAX_DIRECTIO_SIZE	(4096UL << PAGE_SHIFT)
 
-static kmem_cache_t *nfs_direct_cachep;
+static struct kmem_cache *nfs_direct_cachep;
 
 /*
  * This represents a set of asynchronous requests that we're waiting on
Index: 2.6/fs/nfs/inode.c
===================================================================
--- 2.6.orig/fs/nfs/inode.c
+++ 2.6/fs/nfs/inode.c
@@ -1998,7 +1998,7 @@ extern int nfs_init_directcache(void);
 extern void nfs_destroy_directcache(void);
 #endif
 
-static kmem_cache_t * nfs_inode_cachep;
+static struct kmem_cache * nfs_inode_cachep;
 
 static struct inode *nfs_alloc_inode(struct super_block *sb)
 {
@@ -2023,7 +2023,7 @@ static void nfs_destroy_inode(struct ino
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct nfs_inode *nfsi = (struct nfs_inode *) foo;
 
Index: 2.6/fs/nfs/pagelist.c
===================================================================
--- 2.6.orig/fs/nfs/pagelist.c
+++ 2.6/fs/nfs/pagelist.c
@@ -21,7 +21,7 @@
 
 #define NFS_PARANOIA 1
 
-static kmem_cache_t *nfs_page_cachep;
+static struct kmem_cache *nfs_page_cachep;
 
 static inline struct nfs_page *
 nfs_page_alloc(void)
Index: 2.6/fs/nfs/read.c
===================================================================
--- 2.6.orig/fs/nfs/read.c
+++ 2.6/fs/nfs/read.c
@@ -37,7 +37,7 @@ static int nfs_pagein_one(struct list_he
 static void nfs_readpage_result_partial(struct nfs_read_data *, int);
 static void nfs_readpage_result_full(struct nfs_read_data *, int);
 
-static kmem_cache_t *nfs_rdata_cachep;
+static struct kmem_cache *nfs_rdata_cachep;
 mempool_t *nfs_rdata_mempool;
 
 #define MIN_POOL_READ	(32)
Index: 2.6/fs/nfs/write.c
===================================================================
--- 2.6.orig/fs/nfs/write.c
+++ 2.6/fs/nfs/write.c
@@ -83,7 +83,7 @@ static int nfs_wait_on_requests(struct i
 static int nfs_flush_inode(struct inode *inode, unsigned long idx_start,
 			   unsigned int npages, int how);
 
-static kmem_cache_t *nfs_wdata_cachep;
+static struct kmem_cache *nfs_wdata_cachep;
 mempool_t *nfs_wdata_mempool;
 static mempool_t *nfs_commit_mempool;
 
Index: 2.6/fs/nfsd/nfs4state.c
===================================================================
--- 2.6.orig/fs/nfsd/nfs4state.c
+++ 2.6/fs/nfsd/nfs4state.c
@@ -83,10 +83,10 @@ static void nfs4_set_recdir(char *recdir
  */
 static DECLARE_MUTEX(client_sema);
 
-static kmem_cache_t *stateowner_slab = NULL;
-static kmem_cache_t *file_slab = NULL;
-static kmem_cache_t *stateid_slab = NULL;
-static kmem_cache_t *deleg_slab = NULL;
+static struct kmem_cache *stateowner_slab = NULL;
+static struct kmem_cache *file_slab = NULL;
+static struct kmem_cache *stateid_slab = NULL;
+static struct kmem_cache *deleg_slab = NULL;
 
 void
 nfs4_lock_state(void)
@@ -991,7 +991,7 @@ alloc_init_file(struct inode *ino)
 }
 
 static void
-nfsd4_free_slab(kmem_cache_t **slab)
+nfsd4_free_slab(struct kmem_cache **slab)
 {
 	int status;
 
Index: 2.6/fs/ntfs/ntfs.h
===================================================================
--- 2.6.orig/fs/ntfs/ntfs.h
+++ 2.6/fs/ntfs/ntfs.h
@@ -50,11 +50,11 @@ typedef enum {
 /* Global variables. */
 
 /* Slab caches (from super.c). */
-extern kmem_cache_t *ntfs_name_cache;
-extern kmem_cache_t *ntfs_inode_cache;
-extern kmem_cache_t *ntfs_big_inode_cache;
-extern kmem_cache_t *ntfs_attr_ctx_cache;
-extern kmem_cache_t *ntfs_index_ctx_cache;
+extern struct kmem_cache *ntfs_name_cache;
+extern struct kmem_cache *ntfs_inode_cache;
+extern struct kmem_cache *ntfs_big_inode_cache;
+extern struct kmem_cache *ntfs_attr_ctx_cache;
+extern struct kmem_cache *ntfs_index_ctx_cache;
 
 /* The various operations structs defined throughout the driver files. */
 extern struct address_space_operations ntfs_aops;
Index: 2.6/fs/ntfs/super.c
===================================================================
--- 2.6.orig/fs/ntfs/super.c
+++ 2.6/fs/ntfs/super.c
@@ -2987,14 +2987,14 @@ err_out_now:
  * strings of the maximum length allowed by NTFS, which is NTFS_MAX_NAME_LEN
  * (255) Unicode characters + a terminating NULL Unicode character.
  */
-kmem_cache_t *ntfs_name_cache;
+struct kmem_cache *ntfs_name_cache;
 
 /* Slab caches for efficient allocation/deallocation of inodes. */
-kmem_cache_t *ntfs_inode_cache;
-kmem_cache_t *ntfs_big_inode_cache;
+struct kmem_cache *ntfs_inode_cache;
+struct kmem_cache *ntfs_big_inode_cache;
 
 /* Init once constructor for the inode slab cache. */
-static void ntfs_big_inode_init_once(void *foo, kmem_cache_t *cachep,
+static void ntfs_big_inode_init_once(void *foo, struct kmem_cache *cachep,
 		unsigned long flags)
 {
 	ntfs_inode *ni = (ntfs_inode *)foo;
@@ -3008,8 +3008,8 @@ static void ntfs_big_inode_init_once(voi
  * Slab caches to optimize allocations and deallocations of attribute search
  * contexts and index contexts, respectively.
  */
-kmem_cache_t *ntfs_attr_ctx_cache;
-kmem_cache_t *ntfs_index_ctx_cache;
+struct kmem_cache *ntfs_attr_ctx_cache;
+struct kmem_cache *ntfs_index_ctx_cache;
 
 /* Driver wide semaphore. */
 DECLARE_MUTEX(ntfs_lock);
Index: 2.6/fs/proc/inode.c
===================================================================
--- 2.6.orig/fs/proc/inode.c
+++ 2.6/fs/proc/inode.c
@@ -84,7 +84,7 @@ static void proc_read_inode(struct inode
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 }
 
-static kmem_cache_t * proc_inode_cachep;
+static struct kmem_cache * proc_inode_cachep;
 
 static struct inode *proc_alloc_inode(struct super_block *sb)
 {
@@ -108,7 +108,7 @@ static void proc_destroy_inode(struct in
 	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct proc_inode *ei = (struct proc_inode *) foo;
 
Index: 2.6/fs/qnx4/inode.c
===================================================================
--- 2.6.orig/fs/qnx4/inode.c
+++ 2.6/fs/qnx4/inode.c
@@ -516,7 +516,7 @@ static void qnx4_read_inode(struct inode
 	brelse(bh);
 }
 
-static kmem_cache_t *qnx4_inode_cachep;
+static struct kmem_cache *qnx4_inode_cachep;
 
 static struct inode *qnx4_alloc_inode(struct super_block *sb)
 {
@@ -532,7 +532,7 @@ static void qnx4_destroy_inode(struct in
 	kmem_cache_free(qnx4_inode_cachep, qnx4_i(inode));
 }
 
-static void init_once(void *foo, kmem_cache_t * cachep,
+static void init_once(void *foo, struct kmem_cache * cachep,
 		      unsigned long flags)
 {
 	struct qnx4_inode_info *ei = (struct qnx4_inode_info *) foo;
Index: 2.6/fs/reiserfs/super.c
===================================================================
--- 2.6.orig/fs/reiserfs/super.c
+++ 2.6/fs/reiserfs/super.c
@@ -492,7 +492,7 @@ static void reiserfs_put_super(struct su
 	return;
 }
 
-static kmem_cache_t *reiserfs_inode_cachep;
+static struct kmem_cache *reiserfs_inode_cachep;
 
 static struct inode *reiserfs_alloc_inode(struct super_block *sb)
 {
@@ -509,7 +509,7 @@ static void reiserfs_destroy_inode(struc
 	kmem_cache_free(reiserfs_inode_cachep, REISERFS_I(inode));
 }
 
-static void init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct reiserfs_inode_info *ei = (struct reiserfs_inode_info *)foo;
 
Index: 2.6/fs/relayfs/inode.c
===================================================================
--- 2.6.orig/fs/relayfs/inode.c
+++ 2.6/fs/relayfs/inode.c
@@ -26,7 +26,7 @@
 
 static struct vfsmount *		relayfs_mount;
 static int				relayfs_mount_count;
-static kmem_cache_t *			relayfs_inode_cachep;
+static struct kmem_cache *		relayfs_inode_cachep;
 
 static struct backing_dev_info		relayfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -511,7 +511,7 @@ static void relayfs_destroy_inode(struct
 	kmem_cache_free(relayfs_inode_cachep, RELAYFS_I(inode));
 }
 
-static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+static void init_once(void *p, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct relayfs_inode_info *i = p;
 	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
Index: 2.6/fs/romfs/inode.c
===================================================================
--- 2.6.orig/fs/romfs/inode.c
+++ 2.6/fs/romfs/inode.c
@@ -550,7 +550,7 @@ romfs_read_inode(struct inode *i)
 	}
 }
 
-static kmem_cache_t * romfs_inode_cachep;
+static struct kmem_cache * romfs_inode_cachep;
 
 static struct inode *romfs_alloc_inode(struct super_block *sb)
 {
@@ -566,7 +566,7 @@ static void romfs_destroy_inode(struct i
 	kmem_cache_free(romfs_inode_cachep, ROMFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct romfs_inode_info *ei = (struct romfs_inode_info *) foo;
 
Index: 2.6/fs/smbfs/inode.c
===================================================================
--- 2.6.orig/fs/smbfs/inode.c
+++ 2.6/fs/smbfs/inode.c
@@ -51,7 +51,7 @@ static void smb_put_super(struct super_b
 static int  smb_statfs(struct super_block *, struct kstatfs *);
 static int  smb_show_options(struct seq_file *, struct vfsmount *);
 
-static kmem_cache_t *smb_inode_cachep;
+static struct kmem_cache *smb_inode_cachep;
 
 static struct inode *smb_alloc_inode(struct super_block *sb)
 {
@@ -67,7 +67,7 @@ static void smb_destroy_inode(struct ino
 	kmem_cache_free(smb_inode_cachep, SMB_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct smb_inode_info *ei = (struct smb_inode_info *) foo;
 	unsigned long flagmask = SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR;
Index: 2.6/fs/smbfs/request.c
===================================================================
--- 2.6.orig/fs/smbfs/request.c
+++ 2.6/fs/smbfs/request.c
@@ -25,7 +25,7 @@
 #define ROUND_UP(x) (((x)+3) & ~3)
 
 /* cache for request structures */
-static kmem_cache_t *req_cachep;
+static struct kmem_cache *req_cachep;
 
 static int smb_request_send_req(struct smb_request *req);
 
Index: 2.6/fs/sysfs/mount.c
===================================================================
--- 2.6.orig/fs/sysfs/mount.c
+++ 2.6/fs/sysfs/mount.c
@@ -16,7 +16,7 @@
 
 struct vfsmount *sysfs_mount;
 struct super_block * sysfs_sb = NULL;
-kmem_cache_t *sysfs_dir_cachep;
+struct kmem_cache *sysfs_dir_cachep;
 
 static struct super_operations sysfs_ops = {
 	.statfs		= simple_statfs,
Index: 2.6/fs/sysfs/sysfs.h
===================================================================
--- 2.6.orig/fs/sysfs/sysfs.h
+++ 2.6/fs/sysfs/sysfs.h
@@ -1,6 +1,6 @@
 
 extern struct vfsmount * sysfs_mount;
-extern kmem_cache_t *sysfs_dir_cachep;
+extern struct kmem_cache *sysfs_dir_cachep;
 
 extern struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent *);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
Index: 2.6/fs/sysv/inode.c
===================================================================
--- 2.6.orig/fs/sysv/inode.c
+++ 2.6/fs/sysv/inode.c
@@ -300,7 +300,7 @@ static void sysv_delete_inode(struct ino
 	unlock_kernel();
 }
 
-static kmem_cache_t *sysv_inode_cachep;
+static struct kmem_cache *sysv_inode_cachep;
 
 static struct inode *sysv_alloc_inode(struct super_block *sb)
 {
@@ -317,7 +317,7 @@ static void sysv_destroy_inode(struct in
 	kmem_cache_free(sysv_inode_cachep, SYSV_I(inode));
 }
 
-static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+static void init_once(void *p, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct sysv_inode_info *si = (struct sysv_inode_info *)p;
 
Index: 2.6/fs/udf/super.c
===================================================================
--- 2.6.orig/fs/udf/super.c
+++ 2.6/fs/udf/super.c
@@ -113,7 +113,7 @@ static struct file_system_type udf_fstyp
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
-static kmem_cache_t * udf_inode_cachep;
+static struct kmem_cache * udf_inode_cachep;
 
 static struct inode *udf_alloc_inode(struct super_block *sb)
 {
@@ -129,7 +129,7 @@ static void udf_destroy_inode(struct ino
 	kmem_cache_free(udf_inode_cachep, UDF_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct udf_inode_info *ei = (struct udf_inode_info *) foo;
 
Index: 2.6/fs/ufs/super.c
===================================================================
--- 2.6.orig/fs/ufs/super.c
+++ 2.6/fs/ufs/super.c
@@ -1153,7 +1153,7 @@ static int ufs_statfs (struct super_bloc
 	return 0;
 }
 
-static kmem_cache_t * ufs_inode_cachep;
+static struct kmem_cache * ufs_inode_cachep;
 
 static struct inode *ufs_alloc_inode(struct super_block *sb)
 {
@@ -1170,7 +1170,7 @@ static void ufs_destroy_inode(struct ino
 	kmem_cache_free(ufs_inode_cachep, UFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void * foo, struct kmem_cache * cachep, unsigned long flags)
 {
 	struct ufs_inode_info *ei = (struct ufs_inode_info *) foo;
 
Index: 2.6/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- 2.6.orig/fs/xfs/linux-2.6/xfs_buf.c
+++ 2.6/fs/xfs/linux-2.6/xfs_buf.c
@@ -62,7 +62,7 @@
  * File wide globals
  */
 
-STATIC kmem_cache_t *pagebuf_zone;
+STATIC struct kmem_cache *pagebuf_zone;
 STATIC kmem_shaker_t pagebuf_shake;
 STATIC int xfsbufd_wakeup(int, unsigned int);
 STATIC void pagebuf_delwri_queue(xfs_buf_t *, int);
Index: 2.6/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- 2.6.orig/fs/xfs/linux-2.6/xfs_super.c
+++ 2.6/fs/xfs/linux-2.6/xfs_super.c
@@ -301,7 +301,7 @@ linvfs_destroy_inode(
 STATIC void
 linvfs_inode_init_once(
 	void			*data,
-	kmem_cache_t		*cachep,
+	struct kmem_cache	*cachep,
 	unsigned long		flags)
 {
 	vnode_t			*vp = (vnode_t *)data;
