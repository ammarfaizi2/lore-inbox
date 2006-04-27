Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWD0Udl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWD0Udl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWD0Udl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:33:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26887 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751410AbWD0Udk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:33:40 -0400
Date: Thu, 27 Apr 2006 22:33:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/gfs2/: possible cleanups
Message-ID: <20060427203336.GM3570@stusta.de>
References: <20060427014141.06b88072.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427014141.06b88072.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 01:41:41AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm3:
>...
>  git-gfs2.patch
>...
>  git trees
>...


This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 unused functions
- remove the following global function that was both unused and 
  unimplemented:
  - super.c: gfs2_do_upgrade()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW: Please add a MAINTAINERS entry.

 fs/gfs2/bmap.c                 |    3 +-
 fs/gfs2/bmap.h                 |    2 -
 fs/gfs2/dir.c                  |    8 +++---
 fs/gfs2/eaops.c                |    2 -
 fs/gfs2/eaops.h                |    1 
 fs/gfs2/eattr.c                |    3 ++
 fs/gfs2/eattr.h                |    2 -
 fs/gfs2/glock.c                |   25 +++++++++++++--------
 fs/gfs2/glock.h                |   12 ----------
 fs/gfs2/lm.c                   |    2 +
 fs/gfs2/lm.h                   |    1 
 fs/gfs2/locking/dlm/lock.c     |   10 ++++----
 fs/gfs2/locking/dlm/lock_dlm.h |    4 ---
 fs/gfs2/locking/dlm/main.c     |    4 +--
 fs/gfs2/locking/nolock/main.c  |    8 +++---
 fs/gfs2/lvb.c                  |    2 +
 fs/gfs2/lvb.h                  |    1 
 fs/gfs2/ondisk.c               |   38 +++++++++++++++++++++++++++++----
 fs/gfs2/quota.c                |    2 +
 fs/gfs2/quota.h                |    2 -
 fs/gfs2/super.c                |    8 +-----
 fs/gfs2/super.h                |    2 -
 include/linux/gfs2_ondisk.h    |   14 ------------
 23 files changed, 79 insertions(+), 77 deletions(-)

--- linux-2.6.17-rc2-mm1-full/fs/gfs2/bmap.h.old	2006-04-27 20:54:02.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/bmap.h	2006-04-27 20:54:10.000000000 +0200
@@ -13,8 +13,6 @@
 typedef int (*gfs2_unstuffer_t) (struct gfs2_inode * ip,
 				 struct buffer_head * dibh, uint64_t block,
 				 void *private);
-int gfs2_unstuffer_sync(struct gfs2_inode *ip, struct buffer_head *dibh,
-			uint64_t block, void *private);
 int gfs2_unstuff_dinode(struct gfs2_inode *ip, gfs2_unstuffer_t unstuffer,
 			void *private);
 
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/bmap.c.old	2006-04-27 20:54:18.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/bmap.c	2006-04-27 20:54:34.000000000 +0200
@@ -59,7 +59,7 @@ struct strip_mine {
  *
  * Returns: errno
  */
-
+#if 0
 int gfs2_unstuffer_sync(struct gfs2_inode *ip, struct buffer_head *dibh,
 			uint64_t block, void *private)
 {
@@ -77,6 +77,7 @@ int gfs2_unstuffer_sync(struct gfs2_inod
 
 	return error;
 }
+#endif  /*  0  */
 
 /**
  * gfs2_unstuff_dinode - Unstuff a dinode when the data has grown too big
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/dir.c.old	2006-04-27 20:54:49.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/dir.c	2006-04-27 20:55:04.000000000 +0200
@@ -669,10 +669,10 @@ static void dirent_del(struct gfs2_inode
  * Takes a dent from which to grab space as an argument. Returns the
  * newly created dent.
  */
-struct gfs2_dirent *gfs2_init_dirent(struct inode *inode,
-				     struct gfs2_dirent *dent,
-				     const struct qstr *name,
-				     struct buffer_head *bh)
+static struct gfs2_dirent *gfs2_init_dirent(struct inode *inode,
+					    struct gfs2_dirent *dent,
+					    const struct qstr *name,
+					    struct buffer_head *bh)
 {
 	struct gfs2_inode *ip = inode->u.generic_ip;
 	struct gfs2_dirent *ndent;
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/eaops.h.old	2006-04-27 20:56:40.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/eaops.h	2006-04-27 20:56:45.000000000 +0200
@@ -21,7 +21,6 @@ struct gfs2_eattr_operations {
 
 unsigned int gfs2_ea_name2type(const char *name, char **truncated_name);
 
-extern struct gfs2_eattr_operations gfs2_user_eaops;
 extern struct gfs2_eattr_operations gfs2_system_eaops;
 
 extern struct gfs2_eattr_operations *gfs2_ea_ops[];
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/eaops.c.old	2006-04-27 20:56:54.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/eaops.c	2006-04-27 20:57:00.000000000 +0200
@@ -167,7 +167,7 @@ static int system_eo_remove(struct gfs2_
 	return gfs2_ea_remove_i(ip, er);
 }
 
-struct gfs2_eattr_operations gfs2_user_eaops = {
+static struct gfs2_eattr_operations gfs2_user_eaops = {
 	.eo_get = user_eo_get,
 	.eo_set = user_eo_set,
 	.eo_remove = user_eo_remove,
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/eattr.h.old	2006-04-27 20:58:49.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/eattr.h	2006-04-27 20:58:54.000000000 +0200
@@ -61,8 +61,6 @@ struct gfs2_ea_location {
 	struct gfs2_ea_header *el_prev;
 };
 
-int gfs2_ea_repack(struct gfs2_inode *ip);
-
 int gfs2_ea_get_i(struct gfs2_inode *ip, struct gfs2_ea_request *er);
 int gfs2_ea_set_i(struct gfs2_inode *ip, struct gfs2_ea_request *er);
 int gfs2_ea_remove_i(struct gfs2_inode *ip, struct gfs2_ea_request *er);
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/eattr.c.old	2006-04-27 20:59:01.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/eattr.c	2006-04-27 21:16:12.000000000 +0200
@@ -358,6 +358,7 @@ static int ea_remove_unstuffed(struct gf
 	return error;
 }
 
+#if 0
 
 static int gfs2_ea_repack_i(struct gfs2_inode *ip)
 {
@@ -382,6 +383,8 @@ int gfs2_ea_repack(struct gfs2_inode *ip
 	return error;
 }
 
+#endif  /*  0  */
+
 struct ea_list {
 	struct gfs2_ea_request *ei_er;
 	unsigned int ei_size;
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/glock.h.old	2006-04-27 21:00:00.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/glock.h	2006-04-27 21:03:10.000000000 +0200
@@ -73,8 +73,6 @@ static inline int gfs2_glock_is_blocking
 	return ret;
 }
 
-struct gfs2_glock *gfs2_glock_find(struct gfs2_sbd *sdp,
-				   struct lm_lockname *name);
 int gfs2_glock_get(struct gfs2_sbd *sdp,
 		   uint64_t number, struct gfs2_glock_operations *glops,
 		   int create, struct gfs2_glock **glp);
@@ -85,15 +83,11 @@ void gfs2_holder_init(struct gfs2_glock 
 void gfs2_holder_reinit(unsigned int state, unsigned flags,
 			struct gfs2_holder *gh);
 void gfs2_holder_uninit(struct gfs2_holder *gh);
-struct gfs2_holder *gfs2_holder_get(struct gfs2_glock *gl, unsigned int state,
-				    int flags, gfp_t gfp_flags);
-void gfs2_holder_put(struct gfs2_holder *gh);
 
 void gfs2_glock_xmote_th(struct gfs2_glock *gl, unsigned int state, int flags);
 void gfs2_glock_drop_th(struct gfs2_glock *gl);
 
 void gfs2_glmutex_lock(struct gfs2_glock *gl);
-int gfs2_glmutex_trylock(struct gfs2_glock *gl);
 void gfs2_glmutex_unlock(struct gfs2_glock *gl);
 
 int gfs2_glock_nq(struct gfs2_holder *gh);
@@ -101,9 +95,6 @@ int gfs2_glock_poll(struct gfs2_holder *
 int gfs2_glock_wait(struct gfs2_holder *gh);
 void gfs2_glock_dq(struct gfs2_holder *gh);
 
-void gfs2_glock_prefetch(struct gfs2_glock *gl, unsigned int state, int flags);
-void gfs2_glock_force_drop(struct gfs2_glock *gl);
-
 int gfs2_glock_be_greedy(struct gfs2_glock *gl, unsigned int time);
 
 void gfs2_glock_dq_uninit(struct gfs2_holder *gh);
@@ -148,7 +139,6 @@ static inline int gfs2_glock_nq_init(str
 
 int gfs2_lvb_hold(struct gfs2_glock *gl);
 void gfs2_lvb_unhold(struct gfs2_glock *gl);
-void gfs2_lvb_sync(struct gfs2_glock *gl);
 
 void gfs2_glock_cb(lm_fsdata_t *fsdata, unsigned int type, void *data);
 
@@ -161,6 +151,4 @@ void gfs2_reclaim_glock(struct gfs2_sbd 
 void gfs2_scand_internal(struct gfs2_sbd *sdp);
 void gfs2_gl_hash_clear(struct gfs2_sbd *sdp, int wait);
 
-int gfs2_dump_lockstate(struct gfs2_sbd *sdp);
-
 #endif /* __GLOCK_DOT_H__ */
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/glock.c.old	2006-04-27 21:00:13.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/glock.c	2006-04-27 21:03:23.000000000 +0200
@@ -47,6 +47,8 @@ struct greedy {
 
 typedef void (*glock_examiner) (struct gfs2_glock * gl);
 
+static int gfs2_dump_lockstate(struct gfs2_sbd *sdp);
+
 /**
  * relaxed_state_ok - is a requested lock compatible with the current lock mode?
  * @actual: the current state of the lock
@@ -228,8 +230,8 @@ static struct gfs2_glock *search_bucket(
  * Returns: NULL, or the struct gfs2_glock with the requested number
  */
 
-struct gfs2_glock *gfs2_glock_find(struct gfs2_sbd *sdp,
-				   struct lm_lockname *name)
+static struct gfs2_glock *gfs2_glock_find(struct gfs2_sbd *sdp,
+					  struct lm_lockname *name)
 {
 	struct gfs2_gl_hash_bucket *bucket = &sdp->sd_gl_hash[gl_hash(name)];
 	struct gfs2_glock *gl;
@@ -421,8 +423,9 @@ void gfs2_holder_uninit(struct gfs2_hold
  * Returns: the holder structure, NULL on ENOMEM
  */
 
-struct gfs2_holder *gfs2_holder_get(struct gfs2_glock *gl, unsigned int state,
-				    int flags, gfp_t gfp_flags)
+static struct gfs2_holder *gfs2_holder_get(struct gfs2_glock *gl,
+					   unsigned int state,
+					   int flags, gfp_t gfp_flags)
 {
 	struct gfs2_holder *gh;
 
@@ -442,7 +445,7 @@ struct gfs2_holder *gfs2_holder_get(stru
  *
  */
 
-void gfs2_holder_put(struct gfs2_holder *gh)
+static void gfs2_holder_put(struct gfs2_holder *gh)
 {
 	gfs2_holder_uninit(gh);
 	kfree(gh);
@@ -674,7 +677,7 @@ void gfs2_glmutex_lock(struct gfs2_glock
  * Returns: 1 if the glock is acquired
  */
 
-int gfs2_glmutex_trylock(struct gfs2_glock *gl)
+static int gfs2_glmutex_trylock(struct gfs2_glock *gl)
 {
 	int acquired = 1;
 
@@ -1301,7 +1304,8 @@ void gfs2_glock_dq(struct gfs2_holder *g
  *
  */
 
-void gfs2_glock_prefetch(struct gfs2_glock *gl, unsigned int state, int flags)
+static void gfs2_glock_prefetch(struct gfs2_glock *gl, unsigned int state,
+				int flags)
 {
 	struct gfs2_glock_operations *glops = gl->gl_ops;
 
@@ -1329,7 +1333,7 @@ void gfs2_glock_prefetch(struct gfs2_glo
  * @gl: the glock
  *
  */
-
+#if 0
 void gfs2_glock_force_drop(struct gfs2_glock *gl)
 {
 	struct gfs2_holder gh;
@@ -1345,6 +1349,7 @@ void gfs2_glock_force_drop(struct gfs2_g
 	wait_for_completion(&gh.gh_wait);
 	gfs2_holder_uninit(&gh);
 }
+#endif  /*  0  */
 
 static void greedy_work(void *data)
 {
@@ -1697,6 +1702,7 @@ void gfs2_lvb_unhold(struct gfs2_glock *
 	gfs2_glock_put(gl);
 }
 
+#if 0
 void gfs2_lvb_sync(struct gfs2_glock *gl)
 {
 	gfs2_glmutex_lock(gl);
@@ -1707,6 +1713,7 @@ void gfs2_lvb_sync(struct gfs2_glock *gl
 
 	gfs2_glmutex_unlock(gl);
 }
+#endif  /*  0  */
 
 static void blocking_cb(struct gfs2_sbd *sdp, struct lm_lockname *name,
 			unsigned int state)
@@ -2308,7 +2315,7 @@ static int dump_glock(struct gfs2_glock 
  *
  */
 
-int gfs2_dump_lockstate(struct gfs2_sbd *sdp)
+static int gfs2_dump_lockstate(struct gfs2_sbd *sdp)
 {
 	struct gfs2_gl_hash_bucket *bucket;
 	struct gfs2_glock *gl;
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/dlm/lock_dlm.h.old	2006-04-27 21:03:37.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/dlm/lock_dlm.h	2006-04-27 21:04:52.000000000 +0200
@@ -162,12 +162,8 @@ int16_t gdlm_make_lmstate(int16_t);
 void gdlm_queue_delayed(struct gdlm_lock *);
 void gdlm_submit_delayed(struct gdlm_ls *);
 int gdlm_release_all_locks(struct gdlm_ls *);
-int gdlm_create_lp(struct gdlm_ls *, struct lm_lockname *, struct gdlm_lock **);
 void gdlm_delete_lp(struct gdlm_lock *);
-int gdlm_add_lvb(struct gdlm_lock *);
-void gdlm_del_lvb(struct gdlm_lock *);
 unsigned int gdlm_do_lock(struct gdlm_lock *);
-unsigned int gdlm_do_unlock(struct gdlm_lock *);
 
 int gdlm_get_lock(lm_lockspace_t *, struct lm_lockname *, lm_lock_t **);
 void gdlm_put_lock(lm_lock_t *);
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/dlm/lock.c.old	2006-04-27 21:03:50.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/dlm/lock.c	2006-04-27 21:05:02.000000000 +0200
@@ -158,8 +158,8 @@ static inline void make_strname(struct l
 	str->namelen = GDLM_STRNAME_BYTES;
 }
 
-int gdlm_create_lp(struct gdlm_ls *ls, struct lm_lockname *name,
-		   struct gdlm_lock **lpp)
+static int gdlm_create_lp(struct gdlm_ls *ls, struct lm_lockname *name,
+			  struct gdlm_lock **lpp)
 {
 	struct gdlm_lock *lp;
 
@@ -276,7 +276,7 @@ unsigned int gdlm_do_lock(struct gdlm_lo
 	return LM_OUT_ASYNC;
 }
 
-unsigned int gdlm_do_unlock(struct gdlm_lock *lp)
+static unsigned int gdlm_do_unlock(struct gdlm_lock *lp)
 {
 	struct gdlm_ls *ls = lp->ls;
 	unsigned int lkf = 0;
@@ -378,7 +378,7 @@ void gdlm_cancel(lm_lock_t *lock)
 		clear_bit(LFL_DLM_CANCEL, &lp->flags);
 }
 
-int gdlm_add_lvb(struct gdlm_lock *lp)
+static int gdlm_add_lvb(struct gdlm_lock *lp)
 {
 	char *lvb;
 
@@ -391,7 +391,7 @@ int gdlm_add_lvb(struct gdlm_lock *lp)
 	return 0;
 }
 
-void gdlm_del_lvb(struct gdlm_lock *lp)
+static void gdlm_del_lvb(struct gdlm_lock *lp)
 {
 	kfree(lp->lvb);
 	lp->lvb = NULL;
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/dlm/main.c.old	2006-04-27 21:05:38.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/dlm/main.c	2006-04-27 21:07:01.000000000 +0200
@@ -16,7 +16,7 @@ extern int gdlm_drop_period;
 
 extern struct lm_lockops gdlm_ops;
 
-int __init init_lock_dlm(void)
+static int __init init_lock_dlm(void)
 {
 	int error;
 
@@ -48,7 +48,7 @@ int __init init_lock_dlm(void)
 	return 0;
 }
 
-void __exit exit_lock_dlm(void)
+static void __exit exit_lock_dlm(void)
 {
 	gdlm_plock_exit();
 	gdlm_sysfs_exit();
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/nolock/main.c.old	2006-04-27 21:07:22.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/locking/nolock/main.c	2006-04-27 21:08:01.000000000 +0200
@@ -21,7 +21,7 @@ struct nolock_lockspace {
 	unsigned int nl_lvb_size;
 };
 
-struct lm_lockops nolock_ops;
+static struct lm_lockops nolock_ops;
 
 static int nolock_mount(char *table_name, char *host_data,
 			lm_callback_t cb, lm_fsdata_t *fsdata,
@@ -208,7 +208,7 @@ static void nolock_recovery_done(lm_lock
 {
 }
 
-struct lm_lockops nolock_ops = {
+static struct lm_lockops nolock_ops = {
 	.lm_proto_name = "lock_nolock",
 	.lm_mount = nolock_mount,
 	.lm_others_may_mount = nolock_others_may_mount,
@@ -229,7 +229,7 @@ struct lm_lockops nolock_ops = {
 	.lm_owner = THIS_MODULE,
 };
 
-int __init init_nolock(void)
+static int __init init_nolock(void)
 {
 	int error;
 
@@ -245,7 +245,7 @@ int __init init_nolock(void)
 	return 0;
 }
 
-void __exit exit_nolock(void)
+static void __exit exit_nolock(void)
 {
 	gfs_unregister_lockproto(&nolock_ops);
 }
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/lvb.h.old	2006-04-27 21:08:19.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/lvb.h	2006-04-27 21:08:25.000000000 +0200
@@ -14,7 +14,6 @@
 
 void gfs2_quota_lvb_in(struct gfs2_quota_lvb *qb, char *lvb);
 void gfs2_quota_lvb_out(struct gfs2_quota_lvb *qb, char *lvb);
-void gfs2_quota_lvb_print(struct gfs2_quota_lvb *qb);
 
 #endif /* __LVB_DOT_H__ */
 
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/lvb.c.old	2006-04-27 21:08:33.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/lvb.c	2006-04-27 21:08:45.000000000 +0200
@@ -43,6 +43,7 @@ void gfs2_quota_lvb_out(struct gfs2_quot
 	str->qb_value = cpu_to_be64(qb->qb_value);
 }
 
+#if 0
 void gfs2_quota_lvb_print(struct gfs2_quota_lvb *qb)
 {
 	pv(qb, qb_magic, "%u");
@@ -50,4 +51,5 @@ void gfs2_quota_lvb_print(struct gfs2_qu
 	pv(qb, qb_warn, "%llu");
 	pv(qb, qb_value, "%lld");
 }
+#endif  /*  0  */
 
--- linux-2.6.17-rc2-mm1-full/include/linux/gfs2_ondisk.h.old	2006-04-27 21:09:03.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/include/linux/gfs2_ondisk.h	2006-04-27 21:20:13.000000000 +0200
@@ -450,22 +450,8 @@ extern void gfs2_quota_change_in(struct 
 
 /* Printing functions */
 
-extern void gfs2_inum_print(struct gfs2_inum *no);
-extern void gfs2_meta_header_print(struct gfs2_meta_header *mh);
-extern void gfs2_sb_print(struct gfs2_sb *sb);
 extern void gfs2_rindex_print(struct gfs2_rindex *ri);
-extern void gfs2_rgrp_print(struct gfs2_rgrp *rg);
-extern void gfs2_quota_print(struct gfs2_quota *qu);
 extern void gfs2_dinode_print(struct gfs2_dinode *di);
-extern void gfs2_dirent_print(struct gfs2_dirent *de, char *name);
-extern void gfs2_leaf_print(struct gfs2_leaf *lf);
-extern void gfs2_ea_header_print(struct gfs2_ea_header *ea, char *name);
-extern void gfs2_log_header_print(struct gfs2_log_header *lh);
-extern void gfs2_log_descriptor_print(struct gfs2_log_descriptor *ld);
-extern void gfs2_inum_range_print(struct gfs2_inum_range *ir);
-extern void gfs2_statfs_change_print(struct gfs2_statfs_change *sc);
-extern void gfs2_unlinked_tag_print(struct gfs2_unlinked_tag *ut);
-extern void gfs2_quota_change_print(struct gfs2_quota_change *qc);
 
 #endif /* __KERNEL__ */
 
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/ondisk.c.old	2006-04-27 21:20:28.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/ondisk.c	2006-04-27 21:49:09.000000000 +0200
@@ -28,7 +28,7 @@
  * @count: the number of bytes
  *
  */
-
+#if 0
 static void print_array(char *title, char *buf, int count)
 {
 	int x;
@@ -42,6 +42,7 @@ static void print_array(char *title, cha
 	if (x % 16)
 		printk("\n");
 }
+#endif  /*  0  */
 
 /*
  * gfs2_xxx_in - read in an xxx struct
@@ -72,7 +73,7 @@ void gfs2_inum_out(const struct gfs2_inu
 	str->no_addr = cpu_to_be64(no->no_addr);
 }
 
-void gfs2_inum_print(struct gfs2_inum *no)
+static void gfs2_inum_print(struct gfs2_inum *no)
 {
 	pv(no, no_formal_ino, "%llu");
 	pv(no, no_addr, "%llu");
@@ -96,7 +97,7 @@ static void gfs2_meta_header_out(struct 
 	str->mh_format = cpu_to_be32(mh->mh_format);
 }
 
-void gfs2_meta_header_print(struct gfs2_meta_header *mh)
+static void gfs2_meta_header_print(struct gfs2_meta_header *mh)
 {
 	pv(mh, mh_magic, "0x%.8X");
 	pv(mh, mh_type, "%u");
@@ -121,6 +122,7 @@ void gfs2_sb_in(struct gfs2_sb *sb, char
 	memcpy(sb->sb_locktable, str->sb_locktable, GFS2_LOCKNAME_LEN);
 }
 
+#if 0
 void gfs2_sb_print(struct gfs2_sb *sb)
 {
 	gfs2_meta_header_print(&sb->sb_header);
@@ -136,6 +138,7 @@ void gfs2_sb_print(struct gfs2_sb *sb)
 	pv(sb, sb_lockproto, "%s");
 	pv(sb, sb_locktable, "%s");
 }
+#endif  /*  0  */
 
 void gfs2_rindex_in(struct gfs2_rindex *ri, char *buf)
 {
@@ -149,6 +152,7 @@ void gfs2_rindex_in(struct gfs2_rindex *
 
 }
 
+#if 0
 void gfs2_rindex_out(struct gfs2_rindex *ri, char *buf)
 {
 	struct gfs2_rindex *str = (struct gfs2_rindex *)buf;
@@ -163,6 +167,8 @@ void gfs2_rindex_out(struct gfs2_rindex 
 	memset(str->ri_reserved, 0, sizeof(str->ri_reserved));
 }
 
+#endif  /*  0  */
+
 void gfs2_rindex_print(struct gfs2_rindex *ri)
 {
 	pv(ri, ri_addr, "%llu");
@@ -196,6 +202,7 @@ void gfs2_rgrp_out(struct gfs2_rgrp *rg,
 	memset(&str->rg_reserved, 0, sizeof(str->rg_reserved));
 }
 
+#if 0
 void gfs2_rgrp_print(struct gfs2_rgrp *rg)
 {
 	gfs2_meta_header_print(&rg->rg_header);
@@ -205,6 +212,7 @@ void gfs2_rgrp_print(struct gfs2_rgrp *r
 
 	pa(rg, rg_reserved, 36);
 }
+#endif  /*  0  */
 
 void gfs2_quota_in(struct gfs2_quota *qu, char *buf)
 {
@@ -215,6 +223,8 @@ void gfs2_quota_in(struct gfs2_quota *qu
 	qu->qu_value = be64_to_cpu(str->qu_value);
 }
 
+#if 0
+
 void gfs2_quota_out(struct gfs2_quota *qu, char *buf)
 {
 	struct gfs2_quota *str = (struct gfs2_quota *)buf;
@@ -231,6 +241,8 @@ void gfs2_quota_print(struct gfs2_quota 
 	pv(qu, qu_value, "%lld");
 }
 
+#endif  /*  0  */
+
 void gfs2_dinode_in(struct gfs2_dinode *di, char *buf)
 {
 	struct gfs2_dinode *str = (struct gfs2_dinode *)buf;
@@ -327,6 +339,8 @@ void gfs2_dinode_print(struct gfs2_dinod
 	pv(di, di_eattr, "%llu");
 }
 
+#if 0
+
 void gfs2_dirent_print(struct gfs2_dirent *de, char *name)
 {
 	char buf[GFS2_FNAMESIZE + 1];
@@ -394,6 +408,8 @@ void gfs2_ea_header_print(struct gfs2_ea
 	printk(KERN_INFO "  name = %s\n", buf);
 }
 
+#endif  /*  0  */
+
 void gfs2_log_header_in(struct gfs2_log_header *lh, char *buf)
 {
 	struct gfs2_log_header *str = (struct gfs2_log_header *)buf;
@@ -406,6 +422,8 @@ void gfs2_log_header_in(struct gfs2_log_
 	lh->lh_hash = be32_to_cpu(str->lh_hash);
 }
 
+#if 0
+
 void gfs2_log_header_print(struct gfs2_log_header *lh)
 {
 	gfs2_meta_header_print(&lh->lh_header);
@@ -427,6 +445,8 @@ void gfs2_log_descriptor_print(struct gf
 	pa(ld, ld_reserved, 32);
 }
 
+#endif  /*  0  */
+
 void gfs2_inum_range_in(struct gfs2_inum_range *ir, char *buf)
 {
 	struct gfs2_inum_range *str = (struct gfs2_inum_range *)buf;
@@ -443,11 +463,13 @@ void gfs2_inum_range_out(struct gfs2_inu
 	str->ir_length = cpu_to_be64(ir->ir_length);
 }
 
+#if 0
 void gfs2_inum_range_print(struct gfs2_inum_range *ir)
 {
 	pv(ir, ir_start, "%llu");
 	pv(ir, ir_length, "%llu");
 }
+#endif  /*  0  */
 
 void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, char *buf)
 {
@@ -467,12 +489,14 @@ void gfs2_statfs_change_out(struct gfs2_
 	str->sc_dinodes = cpu_to_be64(sc->sc_dinodes);
 }
 
+#if 0
 void gfs2_statfs_change_print(struct gfs2_statfs_change *sc)
 {
 	pv(sc, sc_total, "%lld");
 	pv(sc, sc_free, "%lld");
 	pv(sc, sc_dinodes, "%lld");
 }
+#endif  /*  0  */
 
 void gfs2_unlinked_tag_in(struct gfs2_unlinked_tag *ut, char *buf)
 {
@@ -491,12 +515,16 @@ void gfs2_unlinked_tag_out(struct gfs2_u
 	str->__pad = 0;
 }
 
+#if 0
+
 void gfs2_unlinked_tag_print(struct gfs2_unlinked_tag *ut)
 {
 	gfs2_inum_print(&ut->ut_inum);
 	pv(ut, ut_flags, "%u");
 }
 
+#endif  /*  0  */
+
 void gfs2_quota_change_in(struct gfs2_quota_change *qc, char *buf)
 {
 	struct gfs2_quota_change *str = (struct gfs2_quota_change *)buf;
@@ -506,6 +534,8 @@ void gfs2_quota_change_in(struct gfs2_qu
 	qc->qc_id = be32_to_cpu(str->qc_id);
 }
 
+#if 0
+
 void gfs2_quota_change_print(struct gfs2_quota_change *qc)
 {
 	pv(qc, qc_change, "%lld");
@@ -513,5 +543,5 @@ void gfs2_quota_change_print(struct gfs2
 	pv(qc, qc_id, "%u");
 }
 
-
+#endif  /*  0  */
 
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/quota.h.old	2006-04-27 21:11:20.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/quota.h	2006-04-27 21:11:26.000000000 +0200
@@ -24,8 +24,6 @@ void gfs2_quota_change(struct gfs2_inode
 
 int gfs2_quota_sync(struct gfs2_sbd *sdp);
 int gfs2_quota_refresh(struct gfs2_sbd *sdp, int user, uint32_t id);
-int gfs2_quota_read(struct gfs2_sbd *sdp, int user, uint32_t id,
-		    struct gfs2_quota *q);
 
 int gfs2_quota_init(struct gfs2_sbd *sdp);
 void gfs2_quota_scan(struct gfs2_sbd *sdp);
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/quota.c.old	2006-04-27 21:11:33.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/quota.c	2006-04-27 21:11:55.000000000 +0200
@@ -1086,6 +1086,7 @@ int gfs2_quota_refresh(struct gfs2_sbd *
 	return error;
 }
 
+#if 0
 int gfs2_quota_read(struct gfs2_sbd *sdp, int user, uint32_t id,
 		    struct gfs2_quota *q)
 {
@@ -1121,6 +1122,7 @@ int gfs2_quota_read(struct gfs2_sbd *sdp
 
 	return error;
 }
+#endif  /*  0  */
 
 int gfs2_quota_init(struct gfs2_sbd *sdp)
 {
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/super.h.old	2006-04-27 21:12:13.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/super.h	2006-04-27 21:13:03.000000000 +0200
@@ -14,7 +14,6 @@ void gfs2_tune_init(struct gfs2_tune *gt
 
 int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb *sb, int silent);
 int gfs2_read_sb(struct gfs2_sbd *sdp, struct gfs2_glock *gl, int silent);
-int gfs2_do_upgrade(struct gfs2_sbd *sdp, struct gfs2_glock *gl_sb);
 
 static inline unsigned int gfs2_jindex_size(struct gfs2_sbd *sdp)
 {
@@ -46,7 +45,6 @@ int gfs2_statfs_sync(struct gfs2_sbd *sd
 int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc);
 int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc);
 
-int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp, struct gfs2_holder *t_gh);
 int gfs2_freeze_fs(struct gfs2_sbd *sdp);
 void gfs2_unfreeze_fs(struct gfs2_sbd *sdp);
 
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/super.c.old	2006-04-27 21:12:26.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/super.c	2006-04-27 21:13:14.000000000 +0200
@@ -264,11 +264,6 @@ int gfs2_read_sb(struct gfs2_sbd *sdp, s
 	return 0;
 }
 
-int gfs2_do_upgrade(struct gfs2_sbd *sdp, struct gfs2_glock *sb_gl)
-{
-	return 0;
-}
-
 /**
  * gfs2_jindex_hold - Grab a lock on the jindex
  * @sdp: The GFS2 superblock
@@ -837,7 +832,8 @@ struct lfcc {
  * Returns: errno
  */
 
-int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp, struct gfs2_holder *t_gh)
+static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp,
+				    struct gfs2_holder *t_gh)
 {
 	struct gfs2_inode *ip;
 	struct gfs2_holder ji_gh;
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/lm.h.old	2006-04-27 22:05:59.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/lm.h	2006-04-27 22:06:03.000000000 +0200
@@ -26,7 +26,6 @@ unsigned int gfs2_lm_unlock(struct gfs2_
 void gfs2_lm_cancel(struct gfs2_sbd *sdp, lm_lock_t *lock);
 int gfs2_lm_hold_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char **lvbp);
 void gfs2_lm_unhold_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char *lvb);
-void gfs2_lm_sync_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char *lvb);
 int gfs2_lm_plock_get(struct gfs2_sbd *sdp,
 		     struct lm_lockname *name,
 		     struct file *file, struct file_lock *fl);
--- linux-2.6.17-rc2-mm1-full/fs/gfs2/lm.c.old	2006-04-27 22:06:11.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/gfs2/lm.c	2006-04-27 22:06:24.000000000 +0200
@@ -188,11 +188,13 @@ void gfs2_lm_unhold_lvb(struct gfs2_sbd 
 		sdp->sd_lockstruct.ls_ops->lm_unhold_lvb(lock, lvb);
 }
 
+#if 0
 void gfs2_lm_sync_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char *lvb)
 {
 	if (likely(!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
 		sdp->sd_lockstruct.ls_ops->lm_sync_lvb(lock, lvb);
 }
+#endif  /*  0  */
 
 int gfs2_lm_plock_get(struct gfs2_sbd *sdp, struct lm_lockname *name,
 		      struct file *file, struct file_lock *fl)

