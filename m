Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTBOLb7>; Sat, 15 Feb 2003 06:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTBOLb7>; Sat, 15 Feb 2003 06:31:59 -0500
Received: from holomorphy.com ([66.224.33.161]:36485 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261456AbTBOLby>;
	Sat, 15 Feb 2003 06:31:54 -0500
Date: Sat, 15 Feb 2003 03:40:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: clean up SLAB_KERNEL non-usage
Message-ID: <20030215114054.GA32256@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
when passing args to slab allocation functions.

 arch/arm/mach-arc/mm.c              |    2 +-
 drivers/block/deadline-iosched.c    |    2 +-
 drivers/md/raid5.c                  |    2 +-
 fs/aio.c                            |    4 ++--
 fs/dcache.c                         |    2 +-
 fs/dcookies.c                       |    2 +-
 fs/exec.c                           |    4 ++--
 fs/jbd/revoke.c                     |    2 +-
 fs/jffs/jffs_fm.c                   |    4 ++--
 fs/jffs2/malloc.c                   |   14 +++++++-------
 fs/mbcache.c                        |    2 +-
 fs/namespace.c                      |    2 +-
 include/asm-arm/proc-armo/pgalloc.h |    2 +-
 kernel/fork.c                       |    8 ++++----
 kernel/signal.c                     |    2 +-
 net/ipv4/inetpeer.c                 |    2 +-
 net/ipv4/ipmr.c                     |    4 ++--
 17 files changed, 30 insertions(+), 30 deletions(-)


diff -urpN linux-2.5.61/arch/arm/mach-arc/mm.c slab-2.5.61/arch/arm/mach-arc/mm.c
--- linux-2.5.61/arch/arm/mach-arc/mm.c	2003-02-14 15:51:42.000000000 -0800
+++ slab-2.5.61/arch/arm/mach-arc/mm.c	2003-02-15 03:26:19.000000000 -0800
@@ -34,7 +34,7 @@ int page_nr;
  */
 static inline pgd_t *alloc_pgd_table(int priority)
 {
-	void *pg2k = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
+	void *pg2k = kmem_cache_alloc(pgd_cache, SLAB_KERNEL);
 
 	if (pg2k)
 		pg2k += MEMC_TABLE_SIZE;
diff -urpN linux-2.5.61/drivers/block/deadline-iosched.c slab-2.5.61/drivers/block/deadline-iosched.c
--- linux-2.5.61/drivers/block/deadline-iosched.c	2003-02-14 15:52:27.000000000 -0800
+++ slab-2.5.61/drivers/block/deadline-iosched.c	2003-02-15 03:25:43.000000000 -0800
@@ -740,7 +740,7 @@ static int deadline_init(request_queue_t
 		list_for_each(entry, &rl->free) {
 			rq = list_entry_rq(entry);
 
-			drq = kmem_cache_alloc(drq_pool, GFP_KERNEL);
+			drq = kmem_cache_alloc(drq_pool, SLAB_KERNEL);
 			if (!drq) {
 				ret = -ENOMEM;
 				break;
diff -urpN linux-2.5.61/drivers/md/raid5.c slab-2.5.61/drivers/md/raid5.c
--- linux-2.5.61/drivers/md/raid5.c	2003-02-14 15:51:20.000000000 -0800
+++ slab-2.5.61/drivers/md/raid5.c	2003-02-15 03:25:59.000000000 -0800
@@ -282,7 +282,7 @@ static int grow_stripes(raid5_conf_t *co
 		return 1;
 	conf->slab_cache = sc;
 	while (num--) {
-		sh = kmem_cache_alloc(sc, GFP_KERNEL);
+		sh = kmem_cache_alloc(sc, SLAB_KERNEL);
 		if (!sh)
 			return 1;
 		memset(sh, 0, sizeof(*sh) + (devs-1)*sizeof(struct r5dev));
diff -urpN linux-2.5.61/fs/aio.c slab-2.5.61/fs/aio.c
--- linux-2.5.61/fs/aio.c	2003-02-14 15:51:43.000000000 -0800
+++ slab-2.5.61/fs/aio.c	2003-02-15 03:29:52.000000000 -0800
@@ -215,7 +215,7 @@ static struct kioctx *ioctx_alloc(unsign
 	if (nr_events > aio_max_nr)
 		return ERR_PTR(-EAGAIN);
 
-	ctx = kmem_cache_alloc(kioctx_cachep, GFP_KERNEL);
+	ctx = kmem_cache_alloc(kioctx_cachep, SLAB_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -384,7 +384,7 @@ static struct kiocb *__aio_get_req(struc
 	struct aio_ring *ring;
 	int okay = 0;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	req = kmem_cache_alloc(kiocb_cachep, SLAB_KERNEL);
 	if (unlikely(!req))
 		return NULL;
 
diff -urpN linux-2.5.61/fs/dcache.c slab-2.5.61/fs/dcache.c
--- linux-2.5.61/fs/dcache.c	2003-02-14 15:51:17.000000000 -0800
+++ slab-2.5.61/fs/dcache.c	2003-02-15 03:28:34.000000000 -0800
@@ -631,7 +631,7 @@ struct dentry * d_alloc(struct dentry * 
 	char * str;
 	struct dentry *dentry;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, SLAB_KERNEL); 
 	if (!dentry)
 		return NULL;
 
diff -urpN linux-2.5.61/fs/dcookies.c slab-2.5.61/fs/dcookies.c
--- linux-2.5.61/fs/dcookies.c	2003-02-14 15:51:06.000000000 -0800
+++ slab-2.5.61/fs/dcookies.c	2003-02-15 03:27:42.000000000 -0800
@@ -89,7 +89,7 @@ static void hash_dcookie(struct dcookie_
 static struct dcookie_struct * alloc_dcookie(struct dentry * dentry,
 	struct vfsmount * vfsmnt)
 {
-	struct dcookie_struct * dcs = kmem_cache_alloc(dcookie_cache, GFP_KERNEL);
+	struct dcookie_struct * dcs = kmem_cache_alloc(dcookie_cache, SLAB_KERNEL);
 	if (!dcs)
 		return NULL;
 
diff -urpN linux-2.5.61/fs/exec.c slab-2.5.61/fs/exec.c
--- linux-2.5.61/fs/exec.c	2003-02-14 15:51:30.000000000 -0800
+++ slab-2.5.61/fs/exec.c	2003-02-15 03:29:32.000000000 -0800
@@ -573,7 +573,7 @@ static inline int de_thread(struct task_
 	if (atomic_read(&oldsighand->count) <= 1)
 		return 0;
 
-	newsighand = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
+	newsighand = kmem_cache_alloc(sighand_cachep, SLAB_KERNEL);
 	if (!newsighand)
 		return -ENOMEM;
 
@@ -586,7 +586,7 @@ static inline int de_thread(struct task_
 	 */
 	newsig = NULL;
 	if (atomic_read(&oldsig->count) > 1) {
-		newsig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
+		newsig = kmem_cache_alloc(signal_cachep, SLAB_KERNEL);
 		if (!newsig) {
 			kmem_cache_free(sighand_cachep, newsighand);
 			return -ENOMEM;
diff -urpN linux-2.5.61/fs/jbd/revoke.c slab-2.5.61/fs/jbd/revoke.c
--- linux-2.5.61/fs/jbd/revoke.c	2003-02-14 15:51:11.000000000 -0800
+++ slab-2.5.61/fs/jbd/revoke.c	2003-02-15 03:28:12.000000000 -0800
@@ -194,7 +194,7 @@ int journal_init_revoke(journal_t *journ
 	
 	J_ASSERT (journal->j_revoke == NULL);
 	
-	journal->j_revoke = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
+	journal->j_revoke = kmem_cache_alloc(revoke_table_cache, SLAB_KERNEL);
 	if (!journal->j_revoke)
 		return -ENOMEM;
 	
diff -urpN linux-2.5.61/fs/jffs/jffs_fm.c slab-2.5.61/fs/jffs/jffs_fm.c
--- linux-2.5.61/fs/jffs/jffs_fm.c	2003-02-14 15:51:46.000000000 -0800
+++ slab-2.5.61/fs/jffs/jffs_fm.c	2003-02-15 03:30:24.000000000 -0800
@@ -706,7 +706,7 @@ struct jffs_fm *jffs_alloc_fm(void)
 {
 	struct jffs_fm *fm;
 
-	fm = kmem_cache_alloc(fm_cache,GFP_KERNEL);
+	fm = kmem_cache_alloc(fm_cache, SLAB_KERNEL);
 	DJM(if (fm) no_jffs_fm++;);
 	
 	return fm;
@@ -724,7 +724,7 @@ struct jffs_node *jffs_alloc_node(void)
 {
 	struct jffs_node *n;
 
-	n = (struct jffs_node *)kmem_cache_alloc(node_cache,GFP_KERNEL);
+	n = (struct jffs_node *)kmem_cache_alloc(node_cache, SLAB_KERNEL);
 	if(n != NULL)
 		no_jffs_node++;
 	return n;
diff -urpN linux-2.5.61/fs/jffs2/malloc.c slab-2.5.61/fs/jffs2/malloc.c
--- linux-2.5.61/fs/jffs2/malloc.c	2003-02-14 15:51:09.000000000 -0800
+++ slab-2.5.61/fs/jffs2/malloc.c	2003-02-15 03:27:30.000000000 -0800
@@ -111,7 +111,7 @@ void jffs2_free_full_dirent(struct jffs2
 
 struct jffs2_full_dnode *jffs2_alloc_full_dnode(void)
 {
-	void *ret = kmem_cache_alloc(full_dnode_slab, GFP_KERNEL);
+	void *ret = kmem_cache_alloc(full_dnode_slab, SLAB_KERNEL);
 	return ret;
 }
 
@@ -122,7 +122,7 @@ void jffs2_free_full_dnode(struct jffs2_
 
 struct jffs2_raw_dirent *jffs2_alloc_raw_dirent(void)
 {
-	return kmem_cache_alloc(raw_dirent_slab, GFP_KERNEL);
+	return kmem_cache_alloc(raw_dirent_slab, SLAB_KERNEL);
 }
 
 void jffs2_free_raw_dirent(struct jffs2_raw_dirent *x)
@@ -132,7 +132,7 @@ void jffs2_free_raw_dirent(struct jffs2_
 
 struct jffs2_raw_inode *jffs2_alloc_raw_inode(void)
 {
-	return kmem_cache_alloc(raw_inode_slab, GFP_KERNEL);
+	return kmem_cache_alloc(raw_inode_slab, SLAB_KERNEL);
 }
 
 void jffs2_free_raw_inode(struct jffs2_raw_inode *x)
@@ -142,7 +142,7 @@ void jffs2_free_raw_inode(struct jffs2_r
 
 struct jffs2_tmp_dnode_info *jffs2_alloc_tmp_dnode_info(void)
 {
-	return kmem_cache_alloc(tmp_dnode_info_slab, GFP_KERNEL);
+	return kmem_cache_alloc(tmp_dnode_info_slab, SLAB_KERNEL);
 }
 
 void jffs2_free_tmp_dnode_info(struct jffs2_tmp_dnode_info *x)
@@ -152,7 +152,7 @@ void jffs2_free_tmp_dnode_info(struct jf
 
 struct jffs2_raw_node_ref *jffs2_alloc_raw_node_ref(void)
 {
-	return kmem_cache_alloc(raw_node_ref_slab, GFP_KERNEL);
+	return kmem_cache_alloc(raw_node_ref_slab, SLAB_KERNEL);
 }
 
 void jffs2_free_raw_node_ref(struct jffs2_raw_node_ref *x)
@@ -162,7 +162,7 @@ void jffs2_free_raw_node_ref(struct jffs
 
 struct jffs2_node_frag *jffs2_alloc_node_frag(void)
 {
-	return kmem_cache_alloc(node_frag_slab, GFP_KERNEL);
+	return kmem_cache_alloc(node_frag_slab, SLAB_KERNEL);
 }
 
 void jffs2_free_node_frag(struct jffs2_node_frag *x)
@@ -172,7 +172,7 @@ void jffs2_free_node_frag(struct jffs2_n
 
 struct jffs2_inode_cache *jffs2_alloc_inode_cache(void)
 {
-	struct jffs2_inode_cache *ret = kmem_cache_alloc(inode_cache_slab, GFP_KERNEL);
+	struct jffs2_inode_cache *ret = kmem_cache_alloc(inode_cache_slab, SLAB_KERNEL);
 	D1(printk(KERN_DEBUG "Allocated inocache at %p\n", ret));
 	return ret;
 }
diff -urpN linux-2.5.61/fs/mbcache.c slab-2.5.61/fs/mbcache.c
--- linux-2.5.61/fs/mbcache.c	2003-02-14 15:52:44.000000000 -0800
+++ slab-2.5.61/fs/mbcache.c	2003-02-15 03:31:05.000000000 -0800
@@ -379,7 +379,7 @@ mb_cache_entry_alloc(struct mb_cache *ca
 	struct mb_cache_entry *ce;
 
 	atomic_inc(&cache->c_entry_count);
-	ce = kmem_cache_alloc(cache->c_entry_cache, GFP_KERNEL);
+	ce = kmem_cache_alloc(cache->c_entry_cache, SLAB_KERNEL);
 	if (ce) {
 		INIT_LIST_HEAD(&ce->e_lru_list);
 		INIT_LIST_HEAD(&ce->e_block_list);
diff -urpN linux-2.5.61/fs/namespace.c slab-2.5.61/fs/namespace.c
--- linux-2.5.61/fs/namespace.c	2003-02-14 15:52:02.000000000 -0800
+++ slab-2.5.61/fs/namespace.c	2003-02-15 03:30:43.000000000 -0800
@@ -41,7 +41,7 @@ static inline unsigned long hash(struct 
 
 struct vfsmount *alloc_vfsmnt(char *name)
 {
-	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
+	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, SLAB_KERNEL); 
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count,1);
diff -urpN linux-2.5.61/include/asm-arm/proc-armo/pgalloc.h slab-2.5.61/include/asm-arm/proc-armo/pgalloc.h
--- linux-2.5.61/include/asm-arm/proc-armo/pgalloc.h	2003-02-14 15:52:27.000000000 -0800
+++ slab-2.5.61/include/asm-arm/proc-armo/pgalloc.h	2003-02-15 03:26:51.000000000 -0800
@@ -13,7 +13,7 @@ extern kmem_cache_t *pte_cache;
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(pte_cache, GFP_KERNEL);
+	return kmem_cache_alloc(pte_cache, SLAB_KERNEL);
 }
 
 static inline void pte_free_kernel(pte_t *pte)
diff -urpN linux-2.5.61/kernel/fork.c slab-2.5.61/kernel/fork.c
--- linux-2.5.61/kernel/fork.c	2003-02-14 15:51:12.000000000 -0800
+++ slab-2.5.61/kernel/fork.c	2003-02-15 03:32:14.000000000 -0800
@@ -205,7 +205,7 @@ static struct task_struct *dup_task_stru
 		if (!ti)
 			return NULL;
 
-		tsk = kmem_cache_alloc(task_struct_cachep, GFP_KERNEL);
+		tsk = kmem_cache_alloc(task_struct_cachep, SLAB_KERNEL);
 		if (!tsk) {
 			free_thread_info(ti);
 			return NULL;
@@ -503,7 +503,7 @@ fail_nomem:
 
 static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
 {
-	struct fs_struct *fs = kmem_cache_alloc(fs_cachep, GFP_KERNEL);
+	struct fs_struct *fs = kmem_cache_alloc(fs_cachep, SLAB_KERNEL);
 	/* We don't need to lock fs - think why ;-) */
 	if (fs) {
 		atomic_set(&fs->count, 1);
@@ -671,7 +671,7 @@ static inline int copy_sighand(unsigned 
 		atomic_inc(&current->sighand->count);
 		return 0;
 	}
-	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
+	sig = kmem_cache_alloc(sighand_cachep, SLAB_KERNEL);
 	tsk->sighand = sig;
 	if (!sig)
 		return -1;
@@ -689,7 +689,7 @@ static inline int copy_signal(unsigned l
 		atomic_inc(&current->signal->count);
 		return 0;
 	}
-	sig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
+	sig = kmem_cache_alloc(signal_cachep, SLAB_KERNEL);
 	tsk->signal = sig;
 	if (!sig)
 		return -1;
diff -urpN linux-2.5.61/kernel/signal.c slab-2.5.61/kernel/signal.c
--- linux-2.5.61/kernel/signal.c	2003-02-14 15:51:31.000000000 -0800
+++ slab-2.5.61/kernel/signal.c	2003-02-15 03:32:55.000000000 -0800
@@ -693,7 +693,7 @@ static int send_signal(int sig, struct s
 	   pass on the info struct.  */
 
 	if (atomic_read(&nr_queued_signals) < max_queued_signals)
-		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
+		q = kmem_cache_alloc(sigqueue_cachep, SLAB_ATOMIC);
 
 	if (q) {
 		atomic_inc(&nr_queued_signals);
diff -urpN linux-2.5.61/net/ipv4/inetpeer.c slab-2.5.61/net/ipv4/inetpeer.c
--- linux-2.5.61/net/ipv4/inetpeer.c	2003-02-14 15:52:38.000000000 -0800
+++ slab-2.5.61/net/ipv4/inetpeer.c	2003-02-15 03:32:46.000000000 -0800
@@ -392,7 +392,7 @@ struct inet_peer *inet_getpeer(__u32 dad
 		return NULL;
 
 	/* Allocate the space outside the locked region. */
-	n = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
+	n = kmem_cache_alloc(peer_cachep, SLAB_ATOMIC);
 	if (n == NULL)
 		return NULL;
 	n->v4daddr = daddr;
diff -urpN linux-2.5.61/net/ipv4/ipmr.c slab-2.5.61/net/ipv4/ipmr.c
--- linux-2.5.61/net/ipv4/ipmr.c	2003-02-14 15:51:45.000000000 -0800
+++ slab-2.5.61/net/ipv4/ipmr.c	2003-02-15 03:31:33.000000000 -0800
@@ -467,7 +467,7 @@ static struct mfc_cache *ipmr_cache_find
  */
 static struct mfc_cache *ipmr_cache_alloc(void)
 {
-	struct mfc_cache *c=kmem_cache_alloc(mrt_cachep, GFP_KERNEL);
+	struct mfc_cache *c=kmem_cache_alloc(mrt_cachep, SLAB_KERNEL);
 	if(c==NULL)
 		return NULL;
 	memset(c, 0, sizeof(*c));
@@ -477,7 +477,7 @@ static struct mfc_cache *ipmr_cache_allo
 
 static struct mfc_cache *ipmr_cache_alloc_unres(void)
 {
-	struct mfc_cache *c=kmem_cache_alloc(mrt_cachep, GFP_ATOMIC);
+	struct mfc_cache *c=kmem_cache_alloc(mrt_cachep, SLAB_ATOMIC);
 	if(c==NULL)
 		return NULL;
 	memset(c, 0, sizeof(*c));
