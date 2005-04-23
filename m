Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVDWE2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDWE2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVDWE2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 00:28:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34052 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261481AbVDWEZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 00:25:23 -0400
Date: Sat, 23 Apr 2005 06:25:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: xfs-masters@oss.sgi.com, nathans@sgi.com
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/xfs/: possible cleanups
Message-ID: <20050423042516.GX4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the obsolete support/qsort.c
- debug.c: remove the read-only global variable doass
           (replaced by a #define)
- #if 0 the following unused global functions:
  - quota/xfs_dquot.c: xfs_qm_dqwarn
  - xfs_bmap_btree.c: xfs_bmbt_lookup_le
  - xfs_fsops.c: xfs_fs_log_dummy
  - xfs_inode.c: xfs_inobp_bwcheck
  - xfs_trans.c: xfs_trans_callback
  - xfs_trans_inode.c: xfs_trans_ihold_release

Please check which of these changes do make sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/xfs/Makefile                |    1 
 fs/xfs/linux-2.6/xfs_linux.h   |    1 
 fs/xfs/quota/xfs_dquot.c       |    4 
 fs/xfs/quota/xfs_dquot.h       |    1 
 fs/xfs/quota/xfs_dquot_item.c  |    6 -
 fs/xfs/quota/xfs_qm.c          |   31 ++++--
 fs/xfs/quota/xfs_qm.h          |    8 -
 fs/xfs/quota/xfs_qm_bhv.c      |    2 
 fs/xfs/quota/xfs_qm_syscalls.c |    3 
 fs/xfs/quota/xfs_trans_dquot.c |    4 
 fs/xfs/support/debug.c         |    1 
 fs/xfs/support/debug.h         |    4 
 fs/xfs/support/qsort.c         |  155 ---------------------------------
 fs/xfs/support/qsort.h         |   41 --------
 fs/xfs/support/uuid.c          |    2 
 fs/xfs/support/uuid.h          |    1 
 fs/xfs/xfs_alloc.c             |    4 
 fs/xfs/xfs_attr.c              |  118 ++++++++++++-------------
 fs/xfs/xfs_attr.h              |    6 -
 fs/xfs/xfs_attr_leaf.c         |   24 +++--
 fs/xfs/xfs_attr_leaf.h         |   12 --
 fs/xfs/xfs_bit.c               |    2 
 fs/xfs/xfs_bmap.c              |    6 -
 fs/xfs/xfs_bmap.h              |   13 --
 fs/xfs/xfs_bmap_btree.c        |    2 
 fs/xfs/xfs_bmap_btree.h        |   23 ----
 fs/xfs/xfs_btree.c             |    5 -
 fs/xfs/xfs_btree.h             |   10 --
 fs/xfs/xfs_buf_item.c          |   24 ++---
 fs/xfs/xfs_da_btree.c          |    8 +
 fs/xfs/xfs_da_btree.h          |    3 
 fs/xfs/xfs_dir2.c              |    7 +
 fs/xfs/xfs_dir2.h              |    6 -
 fs/xfs/xfs_dir2_data.c         |    7 +
 fs/xfs/xfs_dir2_data.h         |    8 -
 fs/xfs/xfs_dir2_leaf.c         |    7 +
 fs/xfs/xfs_dir2_leaf.h         |    7 -
 fs/xfs/xfs_dir2_node.c         |    2 
 fs/xfs/xfs_dir2_node.h         |    4 
 fs/xfs/xfs_dir_leaf.c          |    4 
 fs/xfs/xfs_dir_leaf.h          |    2 
 fs/xfs/xfs_error.c             |    2 
 fs/xfs/xfs_error.h             |    3 
 fs/xfs/xfs_extfree_item.c      |    4 
 fs/xfs/xfs_fsops.c             |    2 
 fs/xfs/xfs_iget.c              |    7 +
 fs/xfs/xfs_inode.c             |    8 +
 fs/xfs/xfs_inode.h             |    4 
 fs/xfs/xfs_inode_item.c        |    2 
 fs/xfs/xfs_log.c               |    6 -
 fs/xfs/xfs_log_priv.h          |   11 --
 fs/xfs/xfs_log_recover.c       |   18 +--
 fs/xfs/xfs_mount.c             |    5 -
 fs/xfs/xfs_mount.h             |    3 
 fs/xfs/xfs_rename.c            |    2 
 fs/xfs/xfs_trans.c             |    4 
 fs/xfs/xfs_trans.h             |    3 
 fs/xfs/xfs_trans_inode.c       |    2 
 fs/xfs/xfs_vfsops.c            |   11 +-
 fs/xfs/xfs_vnodeops.c          |    4 
 60 files changed, 207 insertions(+), 473 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_dquot.h.old	2005-04-23 04:35:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_dquot.h	2005-04-23 04:35:10.000000000 +0200
@@ -211,7 +211,6 @@
 					xfs_disk_dquot_t *);
 extern void		xfs_qm_adjust_dqlimits(xfs_mount_t *,
 					xfs_disk_dquot_t *);
-extern int		xfs_qm_dqwarn(xfs_disk_dquot_t *, uint);
 extern int		xfs_qm_dqget(xfs_mount_t *, xfs_inode_t *,
 					xfs_dqid_t, uint, uint, xfs_dquot_t **);
 extern void		xfs_qm_dqput(xfs_dquot_t *);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_dquot.c.old	2005-04-23 04:34:02.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_dquot.c	2005-04-23 04:34:50.000000000 +0200
@@ -101,7 +101,7 @@
  * is the d_id field. The idea is to fill in the entire q_core
  * when we read in the on disk dquot.
  */
-xfs_dquot_t *
+STATIC xfs_dquot_t *
 xfs_qm_dqinit(
 	xfs_mount_t  *mp,
 	xfs_dqid_t   id,
@@ -373,6 +373,7 @@
 /*
  * Increment or reset warnings of a given dquot.
  */
+#if 0
 int
 xfs_qm_dqwarn(
 	xfs_disk_dquot_t	*d,
@@ -430,6 +431,7 @@
 #endif
 	return (warned);
 }
+#endif  /*  0  */
 
 
 /*
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_dquot_item.c.old	2005-04-23 04:35:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_dquot_item.c	2005-04-23 04:35:52.000000000 +0200
@@ -428,7 +428,7 @@
 /*
  * This is the ops vector for dquots
  */
-struct xfs_item_ops xfs_dquot_item_ops = {
+STATIC struct xfs_item_ops xfs_dquot_item_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_qm_dquot_logitem_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_qm_dquot_logitem_format,
@@ -646,7 +646,7 @@
 	return;
 }
 
-struct xfs_item_ops xfs_qm_qoffend_logitem_ops = {
+STATIC struct xfs_item_ops xfs_qm_qoffend_logitem_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_qm_qoff_logitem_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_qm_qoff_logitem_format,
@@ -669,7 +669,7 @@
 /*
  * This is the ops vector shared by all quotaoff-start log items.
  */
-struct xfs_item_ops xfs_qm_qoff_logitem_ops = {
+STATIC struct xfs_item_ops xfs_qm_qoff_logitem_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_qm_qoff_logitem_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_qm_qoff_logitem_format,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm.h.old	2005-04-23 04:37:53.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm.h	2005-04-23 04:42:56.000000000 +0200
@@ -184,11 +184,9 @@
 
 extern void		xfs_mount_reset_sbqflags(xfs_mount_t *);
 
-extern int		xfs_qm_init_quotainfo(xfs_mount_t *);
 extern void		xfs_qm_destroy_quotainfo(xfs_mount_t *);
 extern int		xfs_qm_mount_quotas(xfs_mount_t *, int);
 extern void		xfs_qm_mount_quotainit(xfs_mount_t *, uint);
-extern int		xfs_qm_quotacheck(xfs_mount_t *);
 extern void		xfs_qm_unmount_quotadestroy(xfs_mount_t *);
 extern int		xfs_qm_unmount_quotas(xfs_mount_t *);
 extern int		xfs_qm_write_sb_changes(xfs_mount_t *, __int64_t);
@@ -199,7 +197,6 @@
 extern int		xfs_qm_dqattach(xfs_inode_t *, uint);
 extern void		xfs_qm_dqdetach(xfs_inode_t *);
 extern int		xfs_qm_dqpurge_all(xfs_mount_t *, uint);
-extern void		xfs_qm_dqrele_all_inodes(xfs_mount_t *, uint);
 
 /* vop stuff */
 extern int		xfs_qm_vop_dqalloc(xfs_mount_t *, xfs_inode_t *,
@@ -215,14 +212,9 @@
 					xfs_dquot_t *, xfs_dquot_t *, uint);
 
 /* list stuff */
-extern void		xfs_qm_freelist_init(xfs_frlist_t *);
-extern void		xfs_qm_freelist_destroy(xfs_frlist_t *);
-extern void		xfs_qm_freelist_insert(xfs_frlist_t *, xfs_dquot_t *);
 extern void		xfs_qm_freelist_append(xfs_frlist_t *, xfs_dquot_t *);
 extern void		xfs_qm_freelist_unlink(xfs_dquot_t *);
 extern int		xfs_qm_freelist_lock_nowait(xfs_qm_t *);
-extern int		xfs_qm_mplist_nowait(xfs_mount_t *);
-extern int		xfs_qm_dqhashlock_nowait(xfs_dquot_t *);
 
 /* system call interface */
 extern int		xfs_qm_quotactl(bhv_desc_t *, int, int, xfs_caddr_t);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm.c.old	2005-04-23 04:37:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm.c	2005-04-23 04:42:26.000000000 +0200
@@ -79,9 +79,9 @@
 mutex_t xfs_Gqm_lock;
 struct xfs_qm	*xfs_Gqm;
 
-kmem_zone_t	*qm_dqzone;
-kmem_zone_t	*qm_dqtrxzone;
-kmem_shaker_t	xfs_qm_shaker;
+kmem_zone_t		*qm_dqzone;
+kmem_zone_t		*qm_dqtrxzone;
+STATIC kmem_shaker_t	xfs_qm_shaker;
 
 STATIC void	xfs_qm_list_init(xfs_dqlist_t *, char *, int);
 STATIC void	xfs_qm_list_destroy(xfs_dqlist_t *);
@@ -89,6 +89,13 @@
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_shake(int, unsigned int);
 
+STATIC int	xfs_qm_dqhashlock_nowait(xfs_dquot_t *dqp);
+STATIC void	xfs_qm_freelist_destroy(xfs_frlist_t *ql);
+STATIC void	xfs_qm_freelist_init(xfs_frlist_t *ql);
+STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *mp);
+STATIC int	xfs_qm_mplist_nowait(xfs_mount_t *mp);
+STATIC int	xfs_qm_quotacheck(xfs_mount_t *mp);
+
 #ifdef DEBUG
 extern mutex_t	qcheck_lock;
 #endif
@@ -184,7 +191,7 @@
 /*
  * Destroy the global quota manager when its reference count goes to zero.
  */
-void
+STATIC void
 xfs_qm_destroy(
 	struct xfs_qm	*xqm)
 {
@@ -509,7 +516,7 @@
  * Flush all dquots of the given file system to disk. The dquots are
  * _not_ purged from memory here, just their data written to disk.
  */
-int
+STATIC int
 xfs_qm_dqflush_all(
 	xfs_mount_t	*mp,
 	int		flags)
@@ -1149,7 +1156,7 @@
  * This initializes all the quota information that's kept in the
  * mount structure
  */
-int
+STATIC int
 xfs_qm_init_quotainfo(
 	xfs_mount_t	*mp)
 {
@@ -1871,7 +1878,7 @@
  * Walk thru all the filesystem inodes and construct a consistent view
  * of the disk quota world. If the quotacheck fails, disable quotas.
  */
-int
+STATIC int
 xfs_qm_quotacheck(
 	xfs_mount_t	*mp)
 {
@@ -2751,7 +2758,7 @@
 }
 
 /* ------------- list stuff -----------------*/
-void
+STATIC void
 xfs_qm_freelist_init(xfs_frlist_t *ql)
 {
 	ql->qh_next = ql->qh_prev = (xfs_dquot_t *) ql;
@@ -2760,7 +2767,7 @@
 	ql->qh_nelems = 0;
 }
 
-void
+STATIC void
 xfs_qm_freelist_destroy(xfs_frlist_t *ql)
 {
 	xfs_dquot_t	*dqp, *nextdqp;
@@ -2786,7 +2793,7 @@
 	ASSERT(ql->qh_nelems == 0);
 }
 
-void
+STATIC void
 xfs_qm_freelist_insert(xfs_frlist_t *ql, xfs_dquot_t *dq)
 {
 	dq->dq_flnext = ql->qh_next;
@@ -2816,7 +2823,7 @@
 	xfs_qm_freelist_insert((xfs_frlist_t *)ql->qh_prev, dq);
 }
 
-int
+STATIC int
 xfs_qm_dqhashlock_nowait(
 	xfs_dquot_t *dqp)
 {
@@ -2836,7 +2843,7 @@
 	return (locked);
 }
 
-int
+STATIC int
 xfs_qm_mplist_nowait(
 	xfs_mount_t	*mp)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm_bhv.c.old	2005-04-23 04:42:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm_bhv.c	2005-04-23 04:42:45.000000000 +0200
@@ -359,7 +359,7 @@
 }
 
 
-struct xfs_qmops xfs_qmcore_xfs = {
+STATIC struct xfs_qmops xfs_qmcore_xfs = {
 	.xfs_qminit		= xfs_qm_newmount,
 	.xfs_qmdone		= xfs_qm_unmount_quotadestroy,
 	.xfs_qmmount		= xfs_qm_endmount,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm_syscalls.c.old	2005-04-23 04:43:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_qm_syscalls.c	2005-04-23 04:43:47.000000000 +0200
@@ -91,6 +91,7 @@
 STATIC void	xfs_qm_export_dquot(xfs_mount_t *, xfs_disk_dquot_t *,
 					fs_disk_quota_t *);
 
+STATIC void	xfs_qm_dqrele_all_inodes(struct xfs_mount *mp, uint flags);
 
 /*
  * The main distribution switch of all XFS quotactl system calls.
@@ -1000,7 +1001,7 @@
  * AFTER this, in the case of quotaoff. This also gets called from
  * xfs_rootumount.
  */
-void
+STATIC void
 xfs_qm_dqrele_all_inodes(
 	struct xfs_mount *mp,
 	uint		 flags)
--- linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_trans_dquot.c.old	2005-04-23 04:43:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/quota/xfs_trans_dquot.c	2005-04-23 04:44:21.000000000 +0200
@@ -187,7 +187,7 @@
 /*
  * Wrap around mod_dquot to account for both user and group quotas.
  */
-void
+STATIC void
 xfs_trans_mod_dquot_byino(
 	xfs_trans_t	*tp,
 	xfs_inode_t	*ip,
@@ -368,7 +368,7 @@
  * Unreserve just the reservations done by this transaction.
  * dquot is still left locked at exit.
  */
-void
+STATIC void
 xfs_trans_apply_dquot_deltas(
 	xfs_trans_t		*tp)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/support/debug.h.old	2005-04-23 04:48:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/support/debug.h	2005-04-23 04:50:09.000000000 +0200
@@ -49,11 +49,13 @@
 # define STATIC static
 #endif
 
+#define DOASS 1
+
 #ifdef DEBUG
 # ifdef lint
 #  define ASSERT(EX)	((void)0) /* avoid "constant in conditional" babble */
 # else
-#  define ASSERT(EX) ((!doass||(EX))?((void)0):assfail(#EX, __FILE__, __LINE__))
+#  define ASSERT(EX) ((!DOASS||(EX))?((void)0):assfail(#EX, __FILE__, __LINE__))
 # endif	/* lint */
 #else
 # define ASSERT(x)	((void)0)
--- linux-2.6.12-rc2-mm3-full/fs/xfs/support/debug.c.old	2005-04-23 04:50:24.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/support/debug.c	2005-04-23 04:50:29.000000000 +0200
@@ -36,7 +36,6 @@
 #include <linux/sched.h>
 #include <linux/kernel.h>
 
-int			doass = 1;
 static char		message[256];	/* keep it off the stack */
 static DEFINE_SPINLOCK(xfs_err_lock);
 
--- linux-2.6.12-rc2-mm3-full/fs/xfs/support/uuid.h.old	2005-04-23 04:50:44.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/support/uuid.h	2005-04-23 04:50:49.000000000 +0200
@@ -37,7 +37,6 @@
 } uuid_t;
 
 void uuid_init(void);
-void uuid_create_nil(uuid_t *uuid);
 int uuid_is_nil(uuid_t *uuid);
 int uuid_equal(uuid_t *uuid1, uuid_t *uuid2);
 void uuid_getnodeuniq(uuid_t *uuid, int fsid [2]);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/support/uuid.c.old	2005-04-23 04:50:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/support/uuid.c	2005-04-23 04:51:13.000000000 +0200
@@ -63,7 +63,7 @@
 	fsid[1] =  INT_GET(*(u_int32_t*)(uu  ), ARCH_CONVERT);
 }
 
-void
+static void
 uuid_create_nil(uuid_t *uuid)
 {
 	memset(uuid, 0, sizeof(*uuid));
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_alloc.c.old	2005-04-23 04:51:32.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_alloc.c	2005-04-23 04:51:50.000000000 +0200
@@ -59,7 +59,7 @@
 #define	XFSA_FIXUP_BNO_OK	1
 #define	XFSA_FIXUP_CNT_OK	2
 
-int
+STATIC int
 xfs_alloc_search_busy(xfs_trans_t *tp,
 		    xfs_agnumber_t agno,
 		    xfs_agblock_t bno,
@@ -2562,7 +2562,7 @@
 /*
  * returns non-zero if any of (agno,bno):len is in a busy list
  */
-int
+STATIC int
 xfs_alloc_search_busy(xfs_trans_t *tp,
 		    xfs_agnumber_t agno,
 		    xfs_agblock_t bno,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr.h.old	2005-04-23 04:52:32.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr.h	2005-04-23 04:55:30.000000000 +0200
@@ -72,14 +72,10 @@
 #define ATTR_NAMECOUNT	4
 extern struct attrnames attr_user;
 extern struct attrnames attr_secure;
-extern struct attrnames attr_system;
 extern struct attrnames attr_trusted;
 extern struct attrnames *attr_namespaces[ATTR_NAMECOUNT];
 
 #define ATTR_SYSCOUNT	2
-extern struct attrnames posix_acl_access;
-extern struct attrnames posix_acl_default;
-extern struct attrnames *attr_system_names[ATTR_SYSCOUNT];
 
 extern attrnames_t *attr_lookup_namespace(char *, attrnames_t **, int);
 extern int attr_generic_list(struct vnode *, void *, size_t, int, ssize_t *);
@@ -184,8 +180,6 @@
 			 struct attrlist_cursor_kern *, struct cred *);
 int xfs_attr_inactive(struct xfs_inode *dp);
 
-int xfs_attr_node_get(struct xfs_da_args *);
-int xfs_attr_leaf_get(struct xfs_da_args *);
 int xfs_attr_shortform_getvalue(struct xfs_da_args *);
 int xfs_attr_fetch(struct xfs_inode *, char *, int,
 			char *, int *, int, struct cred *);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr.c.old	2005-04-23 04:52:51.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr.c	2005-04-23 06:01:16.000000000 +0200
@@ -86,6 +86,7 @@
 STATIC int xfs_attr_leaf_addname(xfs_da_args_t *args);
 STATIC int xfs_attr_leaf_removename(xfs_da_args_t *args);
 STATIC int xfs_attr_leaf_list(xfs_attr_list_context_t *context);
+STATIC int xfs_attr_leaf_get(xfs_da_args_t *args);
 
 /*
  * Internal routines when attribute list is more than one block.
@@ -95,6 +96,7 @@
 STATIC int xfs_attr_node_list(xfs_attr_list_context_t *context);
 STATIC int xfs_attr_fillstate(xfs_da_state_t *state);
 STATIC int xfs_attr_refillstate(xfs_da_state_t *state);
+STATIC int xfs_attr_node_get(xfs_da_args_t *args);
 
 /*
  * Routines to manipulate out-of-line attribute values.
@@ -1102,7 +1104,7 @@
  * This leaf block cannot have a "remote" value, we only call this routine
  * if bmap_one_block() says there is only one block (ie: no remote blks).
  */
-int
+STATIC int
 xfs_attr_leaf_get(xfs_da_args_t *args)
 {
 	xfs_dabuf_t *bp;
@@ -1707,7 +1709,7 @@
  * block, ie: both true Btree attr lists and for single-leaf-blocks with
  * "remote" values taking up more blocks.
  */
-int
+STATIC int
 xfs_attr_node_get(xfs_da_args_t *args)
 {
 	xfs_da_state_t *state;
@@ -2398,7 +2400,7 @@
 	return xfs_acl_vhasacl_default(vp);
 }
 
-struct attrnames posix_acl_access = {
+STATIC struct attrnames posix_acl_access = {
 	.attr_name	= "posix_acl_access",
 	.attr_namelen	= sizeof("posix_acl_access") - 1,
 	.attr_get	= posix_acl_access_get,
@@ -2407,7 +2409,7 @@
 	.attr_exists	= posix_acl_access_exists,
 };
 
-struct attrnames posix_acl_default = {
+STATIC struct attrnames posix_acl_default = {
 	.attr_name	= "posix_acl_default",
 	.attr_namelen	= sizeof("posix_acl_default") - 1,
 	.attr_get	= posix_acl_default_get,
@@ -2416,7 +2418,7 @@
 	.attr_exists	= posix_acl_default_exists,
 };
 
-struct attrnames *attr_system_names[] =
+STATIC struct attrnames *attr_system_names[] =
 	{ &posix_acl_access, &posix_acl_default };
 
 
@@ -2480,6 +2482,59 @@
 }
 
 STATIC int
+attr_system_set(
+	struct vnode *vp, char *name, void *data, size_t size, int xflags)
+{
+	attrnames_t	*namesp;
+	int		error;
+
+	if (xflags & ATTR_CREATE)
+		return -EINVAL;
+
+	namesp = attr_lookup_namespace(name, attr_system_names, ATTR_SYSCOUNT);
+	if (!namesp)
+		return -EOPNOTSUPP;
+	error = namesp->attr_set(vp, name, data, size, xflags);
+	if (!error)
+		error = vn_revalidate(vp);
+	return error;
+}
+
+STATIC int
+attr_system_get(
+	struct vnode *vp, char *name, void *data, size_t size, int xflags)
+{
+	attrnames_t	*namesp;
+
+	namesp = attr_lookup_namespace(name, attr_system_names, ATTR_SYSCOUNT);
+	if (!namesp)
+		return -EOPNOTSUPP;
+	return namesp->attr_get(vp, name, data, size, xflags);
+}
+
+STATIC int
+attr_system_remove(
+	struct vnode *vp, char *name, int xflags)
+{
+	attrnames_t	*namesp;
+
+	namesp = attr_lookup_namespace(name, attr_system_names, ATTR_SYSCOUNT);
+	if (!namesp)
+		return -EOPNOTSUPP;
+	return namesp->attr_remove(vp, name, xflags);
+}
+
+STATIC struct attrnames attr_system = {
+	.attr_name	= "system.",
+	.attr_namelen	= sizeof("system.") - 1,
+	.attr_flag	= ATTR_SYSTEM,
+	.attr_get	= attr_system_get,
+	.attr_set	= attr_system_set,
+	.attr_remove	= attr_system_remove,
+	.attr_capable	= (attrcapable_t)fs_noerr,
+};
+
+STATIC int
 attr_system_list(
 	struct vnode		*vp,
 	void			*data,
@@ -2574,59 +2629,6 @@
 	return -ENOSECURITY;
 }
 
-STATIC int
-attr_system_set(
-	struct vnode *vp, char *name, void *data, size_t size, int xflags)
-{
-	attrnames_t	*namesp;
-	int		error;
-
-	if (xflags & ATTR_CREATE)
-		return -EINVAL;
-
-	namesp = attr_lookup_namespace(name, attr_system_names, ATTR_SYSCOUNT);
-	if (!namesp)
-		return -EOPNOTSUPP;
-	error = namesp->attr_set(vp, name, data, size, xflags);
-	if (!error)
-		error = vn_revalidate(vp);
-	return error;
-}
-
-STATIC int
-attr_system_get(
-	struct vnode *vp, char *name, void *data, size_t size, int xflags)
-{
-	attrnames_t	*namesp;
-
-	namesp = attr_lookup_namespace(name, attr_system_names, ATTR_SYSCOUNT);
-	if (!namesp)
-		return -EOPNOTSUPP;
-	return namesp->attr_get(vp, name, data, size, xflags);
-}
-
-STATIC int
-attr_system_remove(
-	struct vnode *vp, char *name, int xflags)
-{
-	attrnames_t	*namesp;
-
-	namesp = attr_lookup_namespace(name, attr_system_names, ATTR_SYSCOUNT);
-	if (!namesp)
-		return -EOPNOTSUPP;
-	return namesp->attr_remove(vp, name, xflags);
-}
-
-struct attrnames attr_system = {
-	.attr_name	= "system.",
-	.attr_namelen	= sizeof("system.") - 1,
-	.attr_flag	= ATTR_SYSTEM,
-	.attr_get	= attr_system_get,
-	.attr_set	= attr_system_set,
-	.attr_remove	= attr_system_remove,
-	.attr_capable	= (attrcapable_t)fs_noerr,
-};
-
 struct attrnames attr_trusted = {
 	.attr_name	= "trusted.",
 	.attr_namelen	= sizeof("trusted.") - 1,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr_leaf.h.old	2005-04-23 04:56:08.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr_leaf.h	2005-04-23 05:00:05.000000000 +0200
@@ -261,8 +261,6 @@
 /*
  * Routines used for growing the Btree.
  */
-int	xfs_attr_leaf_create(struct xfs_da_args *args, xfs_dablk_t which_block,
-				    struct xfs_dabuf **bpp);
 int	xfs_attr_leaf_split(struct xfs_da_state *state,
 				   struct xfs_da_state_blk *oldblk,
 				   struct xfs_da_state_blk *newblk);
@@ -284,12 +282,6 @@
 				       struct xfs_da_state_blk *drop_blk,
 				       struct xfs_da_state_blk *save_blk);
 int	xfs_attr_root_inactive(struct xfs_trans **trans, struct xfs_inode *dp);
-int	xfs_attr_node_inactive(struct xfs_trans **trans, struct xfs_inode *dp,
-				      struct xfs_dabuf *bp, int level);
-int	xfs_attr_leaf_inactive(struct xfs_trans **trans, struct xfs_inode *dp,
-				      struct xfs_dabuf *bp);
-int	xfs_attr_leaf_freextent(struct xfs_trans **trans, struct xfs_inode *dp,
-				       xfs_dablk_t blkno, int blkcnt);
 
 /*
  * Utility routines.
@@ -299,10 +291,6 @@
 				   struct xfs_dabuf *leaf2_bp);
 int	xfs_attr_leaf_newentsize(struct xfs_da_args *args, int blocksize,
 					int *local);
-int	xfs_attr_leaf_entsize(struct xfs_attr_leafblock *leaf, int index);
-int	xfs_attr_put_listent(struct xfs_attr_list_context *context,
-			     struct attrnames *, char *name, int namelen,
-			     int valuelen);
 int	xfs_attr_rolltrans(struct xfs_trans **transp, struct xfs_inode *dp);
 
 #endif	/* __XFS_ATTR_LEAF_H__ */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr_leaf.c.old	2005-04-23 04:56:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_attr_leaf.c	2005-04-23 05:00:48.000000000 +0200
@@ -100,6 +100,18 @@
 					 int dst_start, int move_count,
 					 xfs_mount_t *mp);
 
+STATIC int xfs_attr_leaf_create(xfs_da_args_t *args, xfs_dablk_t blkno,
+				xfs_dabuf_t **bpp);
+STATIC int xfs_attr_leaf_entsize(xfs_attr_leafblock_t *leaf, int index);
+STATIC int xfs_attr_leaf_freextent(xfs_trans_t **trans, xfs_inode_t *dp,
+				   xfs_dablk_t blkno, int blkcnt);
+STATIC int xfs_attr_leaf_inactive(xfs_trans_t **trans, xfs_inode_t *dp,
+				  xfs_dabuf_t *bp);
+STATIC int xfs_attr_node_inactive(xfs_trans_t **trans, xfs_inode_t *dp,
+				  xfs_dabuf_t *bp, int level);
+STATIC int xfs_attr_put_listent(xfs_attr_list_context_t *context,
+				attrnames_t *namesp, char *name,
+				int namelen, int valuelen);
 
 /*========================================================================
  * External routines when dirsize < XFS_LITINO(mp).
@@ -774,7 +786,7 @@
  * Create the initial contents of a leaf attribute list
  * or a leaf in a node attribute list.
  */
-int
+STATIC int
 xfs_attr_leaf_create(xfs_da_args_t *args, xfs_dablk_t blkno, xfs_dabuf_t **bpp)
 {
 	xfs_attr_leafblock_t *leaf;
@@ -2209,7 +2221,7 @@
  * Calculate the number of bytes used to store the indicated attribute
  * (whether local or remote only calculate bytes in this block).
  */
-int
+STATIC int
 xfs_attr_leaf_entsize(xfs_attr_leafblock_t *leaf, int index)
 {
 	xfs_attr_leaf_name_local_t *name_loc;
@@ -2380,7 +2392,7 @@
  * we may be reading them directly out of a user buffer.
  */
 /*ARGSUSED*/
-int
+STATIC int
 xfs_attr_put_listent(xfs_attr_list_context_t *context,
 		     attrnames_t *namesp, char *name, int namelen, int valuelen)
 {
@@ -2740,7 +2752,7 @@
  * Recurse (gasp!) through the attribute nodes until we find leaves.
  * We're doing a depth-first traversal in order to invalidate everything.
  */
-int
+STATIC int
 xfs_attr_node_inactive(xfs_trans_t **trans, xfs_inode_t *dp, xfs_dabuf_t *bp,
 				   int level)
 {
@@ -2849,7 +2861,7 @@
  * Note that we must release the lock on the buffer so that we are not
  * caught holding something that the logging code wants to flush to disk.
  */
-int
+STATIC int
 xfs_attr_leaf_inactive(xfs_trans_t **trans, xfs_inode_t *dp, xfs_dabuf_t *bp)
 {
 	xfs_attr_leafblock_t *leaf;
@@ -2934,7 +2946,7 @@
  * Look at all the extents for this logical region,
  * invalidate any buffers that are incore/in transactions.
  */
-int
+STATIC int
 xfs_attr_leaf_freextent(xfs_trans_t **trans, xfs_inode_t *dp,
 				    xfs_dablk_t blkno, int blkcnt)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bit.c.old	2005-04-23 05:01:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bit.c	2005-04-23 05:01:44.000000000 +0200
@@ -45,7 +45,7 @@
 /*
  * Index of high bit number in byte, -1 for none set, 0..7 otherwise.
  */
-const char xfs_highbit[256] = {
+static const char xfs_highbit[256] = {
        -1, 0, 1, 1, 2, 2, 2, 2,			/* 00 .. 07 */
 	3, 3, 3, 3, 3, 3, 3, 3,			/* 08 .. 0f */
 	4, 4, 4, 4, 4, 4, 4, 4,			/* 10 .. 17 */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap_btree.h.old	2005-04-23 05:02:03.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap_btree.h	2005-04-23 05:07:05.000000000 +0200
@@ -580,14 +580,6 @@
 	xfs_filblks_t,
 	int *);
 
-int
-xfs_bmbt_lookup_le(
-	struct xfs_btree_cur *,
-	xfs_fileoff_t,
-	xfs_fsblock_t,
-	xfs_filblks_t,
-	int *);
-
 /*
  * Give the bmap btree a new root block.  Copy the old broot contents
  * down into a real block and make the broot point to it.
@@ -681,21 +673,6 @@
 #endif
 
 
-/*
- * Search an extent list for the extent which includes block
- * bno.
- */
-xfs_bmbt_rec_t *
-xfs_bmap_do_search_extents(
-	xfs_bmbt_rec_t *,
-	xfs_extnum_t,
-	xfs_extnum_t,
-	xfs_fileoff_t,
-	int *,
-	xfs_extnum_t *,
-	xfs_bmbt_irec_t *,
-	xfs_bmbt_irec_t *);
-
 #endif	/* __KERNEL__ */
 
 #endif	/* __XFS_BMAP_BTREE_H__ */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap.h.old	2005-04-23 05:02:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap.h	2005-04-23 05:02:59.000000000 +0200
@@ -332,19 +332,6 @@
 	int			iflags);	/* interface flags */
 
 /*
- * Check the last inode extent to determine whether this allocation will result
- * in blocks being allocated at the end of the file. When we allocate new data
- * blocks at the end of the file which do not start at the previous data block,
- * we will try to align the new blocks at stripe unit boundaries.
- */
-int
-xfs_bmap_isaeof(
-	struct xfs_inode	*ip,
-	xfs_fileoff_t		off,
-	int			whichfork,
-	char			*aeof);
-
-/*
  * Check if the endoff is outside the last extent. If so the caller will grow
  * the allocation to a stripe unit boundary
  */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap.c.old	2005-04-23 05:02:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap.c	2005-04-23 05:04:08.000000000 +0200
@@ -68,6 +68,8 @@
 #include "xfs_trans_space.h"
 #include "xfs_buf_item.h"
 
+STATIC int xfs_bmap_isaeof(xfs_inode_t *ip, xfs_fileoff_t off,
+			   int whichfork, char *aeof);
 
 #ifdef DEBUG
 STATIC void
@@ -3411,7 +3413,7 @@
 	return error;
 }
 
-xfs_bmbt_rec_t *			/* pointer to found extent entry */
+STATIC xfs_bmbt_rec_t *			/* pointer to found extent entry */
 xfs_bmap_do_search_extents(
 	xfs_bmbt_rec_t	*base,		/* base of extent list */
 	xfs_extnum_t	lastx,		/* last extent index used */
@@ -5714,7 +5716,7 @@
  * blocks at the end of the file which do not start at the previous data block,
  * we will try to align the new blocks at stripe unit boundaries.
  */
-int					/* error */
+STATIC int					/* error */
 xfs_bmap_isaeof(
 	xfs_inode_t	*ip,		/* incore inode pointer */
 	xfs_fileoff_t   off,		/* file offset in fsblocks */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap_btree.c.old	2005-04-23 05:07:13.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_bmap_btree.c	2005-04-23 05:07:31.000000000 +0200
@@ -2331,6 +2331,7 @@
 	return xfs_bmbt_lookup(cur, XFS_LOOKUP_GE, stat);
 }
 
+#if 0
 int					/* error */
 xfs_bmbt_lookup_le(
 	xfs_btree_cur_t	*cur,
@@ -2344,6 +2345,7 @@
 	cur->bc_rec.b.br_blockcount = len;
 	return xfs_bmbt_lookup(cur, XFS_LOOKUP_LE, stat);
 }
+#endif  /*  0  */
 
 /*
  * Give the bmap btree a new root block.  Copy the old broot contents
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_btree.h.old	2005-04-23 05:08:25.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_btree.h	2005-04-23 05:08:33.000000000 +0200
@@ -325,16 +325,6 @@
 	int			level);	/* level to change */
 
 /*
- * Retrieve the block pointer from the cursor at the given level.
- * This may be a bmap btree root or from a buffer.
- */
-xfs_btree_block_t *			/* generic btree block pointer */
-xfs_btree_get_block(
-	xfs_btree_cur_t		*cur,	/* btree cursor */
-	int			level,	/* level in btree */
-	struct xfs_buf		**bpp);	/* buffer containing the block */
-
-/*
  * Get a buffer for the block, return it with no data read.
  * Long-form addressing.
  */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_btree.c.old	2005-04-23 05:08:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_btree.c	2005-04-23 05:10:11.000000000 +0200
@@ -77,6 +77,9 @@
  * Prototypes for internal routines.
  */
 
+STATIC xfs_btree_block_t *xfs_btree_get_block(xfs_btree_cur_t *cur, int level,
+					      xfs_buf_t **bpp);
+
 /*
  * Checking routine: return maxrecs for the block.
  */
@@ -497,7 +500,7 @@
  * Retrieve the block pointer from the cursor at the given level.
  * This may be a bmap btree root or from a buffer.
  */
-xfs_btree_block_t *			/* generic btree block pointer */
+STATIC xfs_btree_block_t *		/* generic btree block pointer */
 xfs_btree_get_block(
 	xfs_btree_cur_t		*cur,	/* btree cursor */
 	int			level,	/* level in btree */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_buf_item.c.old	2005-04-23 05:10:46.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_buf_item.c	2005-04-23 05:12:50.000000000 +0200
@@ -172,7 +172,7 @@
  *
  * If the XFS_BLI_STALE flag has been set, then log nothing.
  */
-uint
+STATIC uint
 xfs_buf_item_size(
 	xfs_buf_log_item_t	*bip)
 {
@@ -240,7 +240,7 @@
  * format structure, and the rest point to contiguous chunks
  * within the buffer.
  */
-void
+STATIC void
 xfs_buf_item_format(
 	xfs_buf_log_item_t	*bip,
 	xfs_log_iovec_t		*log_vector)
@@ -365,7 +365,7 @@
  * item in memory so it cannot be written out.  Simply call bpin()
  * on the buffer to do this.
  */
-void
+STATIC void
 xfs_buf_item_pin(
 	xfs_buf_log_item_t	*bip)
 {
@@ -391,7 +391,7 @@
  * If the XFS_BLI_STALE flag is set and we are the last reference,
  * then free up the buf log item and unlock the buffer.
  */
-void
+STATIC void
 xfs_buf_item_unpin(
 	xfs_buf_log_item_t	*bip,
 	int			stale)
@@ -446,7 +446,7 @@
  * so we need to free the item's descriptor (that points to the item)
  * in the transaction.
  */
-void
+STATIC void
 xfs_buf_item_unpin_remove(
 	xfs_buf_log_item_t	*bip,
 	xfs_trans_t		*tp)
@@ -493,7 +493,7 @@
  * the lock right away, return 0.  If we can get the lock, pull the
  * buffer from the free list, mark it busy, and return 1.
  */
-uint
+STATIC uint
 xfs_buf_item_trylock(
 	xfs_buf_log_item_t	*bip)
 {
@@ -537,7 +537,7 @@
  * This is for support of xfs_trans_bhold(). Make sure the
  * XFS_BLI_HOLD field is cleared if we don't free the item.
  */
-void
+STATIC void
 xfs_buf_item_unlock(
 	xfs_buf_log_item_t	*bip)
 {
@@ -635,7 +635,7 @@
  * by returning the original lsn of that transaction here rather than
  * the current one.
  */
-xfs_lsn_t
+STATIC xfs_lsn_t
 xfs_buf_item_committed(
 	xfs_buf_log_item_t	*bip,
 	xfs_lsn_t		lsn)
@@ -654,7 +654,7 @@
  * and have aborted this transaction, we'll trap this buffer when it tries to
  * get written out.
  */
-void
+STATIC void
 xfs_buf_item_abort(
 	xfs_buf_log_item_t	*bip)
 {
@@ -674,7 +674,7 @@
  * B_DELWRI set, then get it going out to disk with a call to bawrite().
  * If not, then just release the buffer.
  */
-void
+STATIC void
 xfs_buf_item_push(
 	xfs_buf_log_item_t	*bip)
 {
@@ -693,7 +693,7 @@
 }
 
 /* ARGSUSED */
-void
+STATIC void
 xfs_buf_item_committing(xfs_buf_log_item_t *bip, xfs_lsn_t commit_lsn)
 {
 }
@@ -701,7 +701,7 @@
 /*
  * This is the ops vector shared by all buf log items.
  */
-struct xfs_item_ops xfs_buf_item_ops = {
+STATIC struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_buf_item_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_buf_item_format,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_da_btree.h.old	2005-04-23 05:13:08.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_da_btree.h	2005-04-23 05:14:27.000000000 +0200
@@ -296,8 +296,6 @@
 /*
  * Utility routines.
  */
-int	xfs_da_blk_unlink(xfs_da_state_t *state, xfs_da_state_blk_t *drop_blk,
-					 xfs_da_state_blk_t *save_blk);
 int	xfs_da_blk_link(xfs_da_state_t *state, xfs_da_state_blk_t *old_blk,
 				       xfs_da_state_blk_t *new_blk);
 
@@ -320,7 +318,6 @@
 uint xfs_da_log2_roundup(uint i);
 xfs_da_state_t *xfs_da_state_alloc(void);
 void xfs_da_state_free(xfs_da_state_t *state);
-void xfs_da_state_kill_altpath(xfs_da_state_t *state);
 
 void xfs_da_buf_done(xfs_dabuf_t *dabuf);
 void xfs_da_log_buf(struct xfs_trans *tp, xfs_dabuf_t *dabuf, uint first,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_da_btree.c.old	2005-04-23 05:13:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_da_btree.c	2005-04-23 05:14:49.000000000 +0200
@@ -114,6 +114,10 @@
 STATIC int	xfs_da_node_order(xfs_dabuf_t *node1_bp, xfs_dabuf_t *node2_bp);
 STATIC xfs_dabuf_t *xfs_da_buf_make(int nbuf, xfs_buf_t **bps, inst_t *ra);
 
+STATIC int xfs_da_blk_unlink(xfs_da_state_t *state,
+			     xfs_da_state_blk_t *drop_blk,
+			     xfs_da_state_blk_t *save_blk);
+STATIC void xfs_da_state_kill_altpath(xfs_da_state_t *state);
 
 /*========================================================================
  * Routines used for growing the Btree.
@@ -1424,7 +1428,7 @@
 /*
  * Unlink a block from a doubly linked list of blocks.
  */
-int							/* error */
+STATIC int						/* error */
 xfs_da_blk_unlink(xfs_da_state_t *state, xfs_da_state_blk_t *drop_blk,
 				 xfs_da_state_blk_t *save_blk)
 {
@@ -2381,7 +2385,7 @@
 /*
  * Kill the altpath contents of a da-state structure.
  */
-void
+STATIC void
 xfs_da_state_kill_altpath(xfs_da_state_t *state)
 {
 	int	i;
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2.h.old	2005-04-23 05:15:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2.h	2005-04-23 05:17:02.000000000 +0200
@@ -97,12 +97,6 @@
 			    xfs_dir2_db_t *dbp);
 
 extern int
-	xfs_dir2_isblock(struct xfs_trans *tp, struct xfs_inode *dp, int *vp);
-
-extern int
-	xfs_dir2_isleaf(struct xfs_trans *tp, struct xfs_inode *dp, int *vp);
-
-extern int
 	xfs_dir2_shrink_inode(struct xfs_da_args *args, xfs_dir2_db_t db,
 			      struct xfs_dabuf *bp);
 
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2.c.old	2005-04-23 05:15:24.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2.c	2005-04-23 05:18:17.000000000 +0200
@@ -101,6 +101,9 @@
 static int	xfs_dir2_put_dirent64_direct(xfs_dir2_put_args_t *pa);
 static int	xfs_dir2_put_dirent64_uio(xfs_dir2_put_args_t *pa);
 
+static int	xfs_dir2_isblock(xfs_trans_t *tp, xfs_inode_t *dp, int *vp);
+static int	xfs_dir2_isleaf(xfs_trans_t *tp, xfs_inode_t *dp, int *vp);
+
 /*
  * Directory operations vector.
  */
@@ -666,7 +669,7 @@
 /*
  * See if the directory is a single-block form directory.
  */
-int					/* error */
+static int				/* error */
 xfs_dir2_isblock(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_inode_t	*dp,		/* incore directory inode */
@@ -689,7 +692,7 @@
 /*
  * See if the directory is a single-leaf form directory.
  */
-int					/* error */
+static int				/* error */
 xfs_dir2_isleaf(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_inode_t	*dp,		/* incore directory inode */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_data.h.old	2005-04-23 05:18:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_data.h	2005-04-23 05:20:01.000000000 +0200
@@ -185,18 +185,10 @@
 #endif
 
 extern xfs_dir2_data_free_t *
-	xfs_dir2_data_freefind(xfs_dir2_data_t *d,
-			       xfs_dir2_data_unused_t *dup);
-
-extern xfs_dir2_data_free_t *
 	xfs_dir2_data_freeinsert(xfs_dir2_data_t *d,
 				 xfs_dir2_data_unused_t *dup, int *loghead);
 
 extern void
-	xfs_dir2_data_freeremove(xfs_dir2_data_t *d,
-				 xfs_dir2_data_free_t *dfp, int *loghead);
-
-extern void
 	xfs_dir2_data_freescan(struct xfs_mount *mp, xfs_dir2_data_t *d,
 			       int *loghead, char *aendp);
 
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_data.c.old	2005-04-23 05:18:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_data.c	2005-04-23 05:20:06.000000000 +0200
@@ -61,6 +61,9 @@
 #include "xfs_dir2_block.h"
 #include "xfs_error.h"
 
+static xfs_dir2_data_free_t *xfs_dir2_data_freefind(xfs_dir2_data_t *d,
+						    xfs_dir2_data_unused_t *dup);
+
 #ifdef DEBUG
 /*
  * Check the consistency of the data block.
@@ -193,7 +196,7 @@
  * Given a data block and an unused entry from that block,
  * return the bestfree entry if any that corresponds to it.
  */
-xfs_dir2_data_free_t *
+static xfs_dir2_data_free_t *
 xfs_dir2_data_freefind(
 	xfs_dir2_data_t		*d,		/* data block */
 	xfs_dir2_data_unused_t	*dup)		/* data unused entry */
@@ -304,7 +307,7 @@
 /*
  * Remove a bestfree entry from the table.
  */
-void
+static void
 xfs_dir2_data_freeremove(
 	xfs_dir2_data_t		*d,		/* data block pointer */
 	xfs_dir2_data_free_t	*dfp,		/* bestfree entry pointer */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_leaf.h.old	2005-04-23 05:20:25.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_leaf.h	2005-04-23 05:21:53.000000000 +0200
@@ -330,15 +330,8 @@
 			       int first, int last);
 
 extern void
-	xfs_dir2_leaf_log_bests(struct xfs_trans *tp, struct xfs_dabuf *bp,
-				int first, int last);
-
-extern void
 	xfs_dir2_leaf_log_header(struct xfs_trans *tp, struct xfs_dabuf *bp);
 
-extern void
-	xfs_dir2_leaf_log_tail(struct xfs_trans *tp, struct xfs_dabuf *bp);
-
 extern int
 	xfs_dir2_leaf_lookup(struct xfs_da_args *args);
 
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_leaf.c.old	2005-04-23 05:20:41.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_leaf.c	2005-04-23 05:22:35.000000000 +0200
@@ -77,6 +77,9 @@
 #endif
 static int xfs_dir2_leaf_lookup_int(xfs_da_args_t *args, xfs_dabuf_t **lbpp,
 				    int *indexp, xfs_dabuf_t **dbpp);
+static void xfs_dir2_leaf_log_bests(xfs_trans_t *tp, xfs_dabuf_t *bp,
+				    int first, int last);
+static void xfs_dir2_leaf_log_tail(xfs_trans_t *tp, xfs_dabuf_t *bp);
 
 /*
  * Convert a block form directory to a leaf form directory.
@@ -1214,7 +1217,7 @@
 /*
  * Log the bests entries indicated from a leaf1 block.
  */
-void
+static void
 xfs_dir2_leaf_log_bests(
 	xfs_trans_t		*tp,		/* transaction pointer */
 	xfs_dabuf_t		*bp,		/* leaf buffer */
@@ -1278,7 +1281,7 @@
 /*
  * Log the tail of the leaf1 block.
  */
-void
+static void
 xfs_dir2_leaf_log_tail(
 	xfs_trans_t		*tp,		/* transaction pointer */
 	xfs_dabuf_t		*bp)		/* leaf buffer */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_node.h.old	2005-04-23 05:22:53.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_node.h	2005-04-23 05:23:03.000000000 +0200
@@ -108,10 +108,6 @@
  * Functions.
  */
 
-extern void
-	xfs_dir2_free_log_bests(struct xfs_trans *tp, struct xfs_dabuf *bp,
-				int first, int last);
-
 extern int
 	xfs_dir2_leaf_to_node(struct xfs_da_args *args, struct xfs_dabuf *lbp);
 
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_node.c.old	2005-04-23 05:23:23.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir2_node.c	2005-04-23 05:23:32.000000000 +0200
@@ -88,7 +88,7 @@
 /*
  * Log entries from a freespace block.
  */
-void
+static void
 xfs_dir2_free_log_bests(
 	xfs_trans_t		*tp,		/* transaction pointer */
 	xfs_dabuf_t		*bp,		/* freespace buffer */
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir_leaf.h.old	2005-04-23 05:23:54.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir_leaf.h	2005-04-23 05:24:02.000000000 +0200
@@ -202,8 +202,6 @@
 /*
  * Routines used for growing the Btree.
  */
-int	xfs_dir_leaf_create(struct xfs_da_args *args, xfs_dablk_t which_block,
-				   struct xfs_dabuf **bpp);
 int	xfs_dir_leaf_split(struct xfs_da_state *state,
 				  struct xfs_da_state_blk *oldblk,
 				  struct xfs_da_state_blk *newblk);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir_leaf.c.old	2005-04-23 05:24:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_dir_leaf.c	2005-04-23 05:24:57.000000000 +0200
@@ -100,6 +100,8 @@
 					      int dst_start, int move_count,
 					      xfs_mount_t *mp);
 
+STATIC int xfs_dir_leaf_create(xfs_da_args_t *args, xfs_dablk_t blkno,
+			       xfs_dabuf_t **bpp);
 
 /*========================================================================
  * External routines when dirsize < XFS_IFORK_DSIZE(dp).
@@ -781,7 +783,7 @@
  * Create the initial contents of a leaf directory
  * or a leaf in a node directory.
  */
-int
+STATIC int
 xfs_dir_leaf_create(xfs_da_args_t *args, xfs_dablk_t blkno, xfs_dabuf_t **bpp)
 {
 	xfs_dir_leafblock_t *leaf;
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_error.h.old	2005-04-23 05:25:11.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_error.h	2005-04-23 05:25:21.000000000 +0200
@@ -73,9 +73,6 @@
 	int		linenum,
 	inst_t		*ra);
 
-extern void
-xfs_hex_dump(void *p, int length);
-
 #define	XFS_ERROR_REPORT(e, lvl, mp)	\
 	xfs_error_report(e, lvl, mp, __FILE__, __LINE__, __return_address)
 #define	XFS_CORRUPTION_ERROR(e, lvl, mp, mem)	\
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_error.c.old	2005-04-23 05:25:30.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_error.c	2005-04-23 05:26:01.000000000 +0200
@@ -280,7 +280,7 @@
 	}
 }
 
-void
+static void
 xfs_hex_dump(void *p, int length)
 {
 	__uint8_t *uip = (__uint8_t*)p;
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_extfree_item.c.old	2005-04-23 05:26:06.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_extfree_item.c	2005-04-23 05:26:37.000000000 +0200
@@ -288,7 +288,7 @@
 /*
  * This is the ops vector shared by all efi log items.
  */
-struct xfs_item_ops xfs_efi_item_ops = {
+STATIC struct xfs_item_ops xfs_efi_item_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_efi_item_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_efi_item_format,
@@ -615,7 +615,7 @@
 /*
  * This is the ops vector shared by all efd log items.
  */
-struct xfs_item_ops xfs_efd_item_ops = {
+STATIC struct xfs_item_ops xfs_efd_item_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_efd_item_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_efd_item_format,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_fsops.c.old	2005-04-23 05:26:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_fsops.c	2005-04-23 05:27:10.000000000 +0200
@@ -559,6 +559,7 @@
 	return(0);
 }
 
+#if 0
 void
 xfs_fs_log_dummy(xfs_mount_t *mp)
 {
@@ -584,6 +585,7 @@
 
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 }
+#endif  /*  0  */
 
 int
 xfs_fs_goingdown(
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_inode.h.old	2005-04-23 05:27:24.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_inode.h	2005-04-23 06:02:39.000000000 +0200
@@ -466,7 +466,6 @@
 void		xfs_chash_free(struct xfs_mount *);
 xfs_inode_t	*xfs_inode_incore(struct xfs_mount *, xfs_ino_t,
 				  struct xfs_trans *);
-void            xfs_inode_lock_init(xfs_inode_t *, struct vnode *);
 int		xfs_iget(struct xfs_mount *, struct xfs_trans *, xfs_ino_t,
 			 uint, uint, xfs_inode_t **, xfs_daddr_t);
 void		xfs_iput(xfs_inode_t *, uint);
@@ -487,8 +486,6 @@
 /*
  * xfs_inode.c prototypes.
  */
-int		xfs_inotobp(struct xfs_mount *, struct xfs_trans *, xfs_ino_t,
-			    xfs_dinode_t **, struct xfs_buf **, int *);
 int		xfs_itobp(struct xfs_mount *, struct xfs_trans *,
 			  xfs_inode_t *, xfs_dinode_t **, struct xfs_buf **,
 			  xfs_daddr_t);
@@ -515,7 +512,6 @@
 void		xfs_idestroy_fork(xfs_inode_t *, int);
 void		xfs_idestroy(xfs_inode_t *);
 void		xfs_idata_realloc(xfs_inode_t *, int, int);
-void		xfs_iextract(xfs_inode_t *);
 void		xfs_iext_realloc(xfs_inode_t *, int, int);
 void		xfs_iroot_realloc(xfs_inode_t *, int, int);
 void		xfs_ipin(xfs_inode_t *);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_iget.c.old	2005-04-23 05:27:37.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_iget.c	2005-04-23 05:29:07.000000000 +0200
@@ -57,6 +57,9 @@
 #include "xfs_utils.h"
 #include "xfs_bit.h"
 
+static void xfs_iextract(xfs_inode_t *ip);
+static void xfs_inode_lock_init(xfs_inode_t *ip, vnode_t *vp);
+
 /*
  * Initialize the inode hash table for the newly mounted file system.
  * Choose an initial table size based on user specified value, else
@@ -522,7 +525,7 @@
 /*
  * Do the setup for the various locks within the incore inode.
  */
-void
+static void
 xfs_inode_lock_init(
 	xfs_inode_t	*ip,
 	vnode_t		*vp)
@@ -668,7 +671,7 @@
  * all of the lists in which it is located with the exception
  * of the behavior chain.
  */
-void
+static void
 xfs_iextract(
 	xfs_inode_t	*ip)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_inode.c.old	2005-04-23 05:29:44.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_inode.c	2005-04-23 05:42:49.000000000 +0200
@@ -148,6 +148,7 @@
 /*
  * called from bwrite on xfs inode buffers
  */
+#if 0
 void
 xfs_inobp_bwcheck(xfs_buf_t *bp)
 {
@@ -189,6 +190,7 @@
 
 	return;
 }
+#endif  /*  0  */
 
 /*
  * This routine is called to map an inode number within a file
@@ -203,7 +205,7 @@
  * Use xfs_imap() to determine the size and location of the
  * buffer to read from disk.
  */
-int
+static int
 xfs_inotobp(
 	xfs_mount_t	*mp,
 	xfs_trans_t	*tp,
@@ -2156,7 +2158,7 @@
 		(ip->i_update_core == 0));
 }
 
-void
+static void
 xfs_ifree_cluster(
 	xfs_inode_t	*free_ip,
 	xfs_trans_t	*tp,
@@ -2875,7 +2877,7 @@
  * be subsequently pinned once someone is waiting for it to be
  * unpinned.
  */
-void
+static void
 xfs_iunpin_wait(
 	xfs_inode_t	*ip)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_inode_item.c.old	2005-04-23 05:43:06.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_inode_item.c	2005-04-23 05:43:18.000000000 +0200
@@ -910,7 +910,7 @@
 /*
  * This is the ops vector shared by all buf log items.
  */
-struct xfs_item_ops xfs_inode_item_ops = {
+STATIC struct xfs_item_ops xfs_inode_item_ops = {
 	.iop_size	= (uint(*)(xfs_log_item_t*))xfs_inode_item_size,
 	.iop_format	= (void(*)(xfs_log_item_t*, xfs_log_iovec_t*))
 					xfs_inode_item_format,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_log.c.old	2005-04-23 05:43:54.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_log.c	2005-04-23 05:44:39.000000000 +0200
@@ -134,7 +134,7 @@
 #define xlog_verify_tail_lsn(a,b,c)
 #endif
 
-int		xlog_iclogs_empty(xlog_t *log);
+static int	xlog_iclogs_empty(xlog_t *log);
 
 #ifdef DEBUG
 int xlog_do_error = 0;
@@ -1857,7 +1857,7 @@
  *
  * State Change: DIRTY -> ACTIVE
  */
-void
+static void
 xlog_state_clean_log(xlog_t *log)
 {
 	xlog_in_core_t	*iclog;
@@ -3542,7 +3542,7 @@
 	return (retval);
 }
 
-int
+static int
 xlog_iclogs_empty(xlog_t *log)
 {
 	xlog_in_core_t	*iclog;
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_log_priv.h.old	2005-04-23 05:44:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_log_priv.h	2005-04-23 05:46:50.000000000 +0200
@@ -535,20 +535,9 @@
 
 /* common routines */
 extern xfs_lsn_t xlog_assign_tail_lsn(struct xfs_mount *mp);
-extern int	 xlog_find_head(xlog_t *log, xfs_daddr_t *head_blk);
-extern int	 xlog_find_tail(xlog_t	*log,
-				xfs_daddr_t *head_blk,
-				xfs_daddr_t *tail_blk,
-				int readonly);
 extern int	 xlog_recover(xlog_t *log, int readonly);
 extern int	 xlog_recover_finish(xlog_t *log, int mfsi_flags);
 extern void	 xlog_pack_data(xlog_t *log, xlog_in_core_t *iclog, int);
-extern void	 xlog_recover_process_iunlinks(xlog_t *log);
-
-extern struct xfs_buf *xlog_get_bp(xlog_t *, int);
-extern void	 xlog_put_bp(struct xfs_buf *);
-extern int	 xlog_bread(xlog_t *, xfs_daddr_t, int, struct xfs_buf *);
-extern xfs_caddr_t xlog_align(xlog_t *, xfs_daddr_t, int, struct xfs_buf *);
 
 /* iclog tracing */
 #define XLOG_TRACE_GRAB_FLUSH  1
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_log_recover.c.old	2005-04-23 05:45:07.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_log_recover.c	2005-04-23 05:46:55.000000000 +0200
@@ -86,7 +86,7 @@
 	((bbs + (log)->l_sectbb_mask + 1) & ~(log)->l_sectbb_mask) : (bbs) )
 #define XLOG_SECTOR_ROUNDDOWN_BLKNO(log, bno)	((bno) & ~(log)->l_sectbb_mask)
 
-xfs_buf_t *
+STATIC xfs_buf_t *
 xlog_get_bp(
 	xlog_t		*log,
 	int		num_bblks)
@@ -101,7 +101,7 @@
 	return xfs_buf_get_noaddr(BBTOB(num_bblks), log->l_mp->m_logdev_targp);
 }
 
-void
+STATIC void
 xlog_put_bp(
 	xfs_buf_t	*bp)
 {
@@ -112,7 +112,7 @@
 /*
  * nbblks should be uint, but oh well.  Just want to catch that 32-bit length.
  */
-int
+STATIC int
 xlog_bread(
 	xlog_t		*log,
 	xfs_daddr_t	blk_no,
@@ -148,7 +148,7 @@
  * The buffer is kept locked across the write and is returned locked.
  * This can only be used for synchronous log writes.
  */
-int
+STATIC int
 xlog_bwrite(
 	xlog_t		*log,
 	xfs_daddr_t	blk_no,
@@ -179,7 +179,7 @@
 	return error;
 }
 
-xfs_caddr_t
+STATIC xfs_caddr_t
 xlog_align(
 	xlog_t		*log,
 	xfs_daddr_t	blk_no,
@@ -310,7 +310,7 @@
  * Note that the algorithm can not be perfect because the disk will not
  * necessarily be perfect.
  */
-int
+STATIC int
 xlog_find_cycle_start(
 	xlog_t		*log,
 	xfs_buf_t	*bp,
@@ -528,7 +528,7 @@
  *
  * Return: zero if normal, non-zero if error.
  */
-int
+STATIC int
 xlog_find_head(
 	xlog_t 		*log,
 	xfs_daddr_t	*return_head_blk)
@@ -794,7 +794,7 @@
  * We could speed up search by using current head_blk buffer, but it is not
  * available.
  */
-int
+STATIC int
 xlog_find_tail(
 	xlog_t			*log,
 	xfs_daddr_t		*head_blk,
@@ -3208,7 +3208,7 @@
  * freeing of the inode and its removal from the list must be
  * atomic.
  */
-void
+STATIC void
 xlog_recover_process_iunlinks(
 	xlog_t		*log)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_mount.h.old	2005-04-23 05:48:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_mount.h	2005-04-23 05:52:32.000000000 +0200
@@ -543,10 +543,8 @@
 extern int	xfs_mountfs(struct vfs *, xfs_mount_t *mp, int);
 
 extern int	xfs_unmountfs(xfs_mount_t *, struct cred *);
-extern void	xfs_unmountfs_wait(xfs_mount_t *);
 extern void	xfs_unmountfs_close(xfs_mount_t *, struct cred *);
 extern int	xfs_unmountfs_writesb(xfs_mount_t *);
-extern int	xfs_unmount_flush(xfs_mount_t *, int);
 extern int	xfs_mod_incore_sb(xfs_mount_t *, xfs_sb_field_t, int, int);
 extern int	xfs_mod_incore_sb_batch(xfs_mount_t *, xfs_mod_sb_t *,
 			uint, int);
@@ -554,7 +552,6 @@
 extern int	xfs_readsb(xfs_mount_t *mp);
 extern void	xfs_freesb(xfs_mount_t *);
 extern void	xfs_do_force_shutdown(bhv_desc_t *, int, char *, int);
-extern int	xfs_syncsub(xfs_mount_t *, int, int, int *);
 extern xfs_agnumber_t	xfs_initialize_perag(xfs_mount_t *, xfs_agnumber_t);
 extern void	xfs_xlatesb(void *, struct xfs_sb *, int, __int64_t);
 
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_mount.c.old	2005-04-23 05:47:08.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_mount.c	2005-04-23 05:47:50.000000000 +0200
@@ -64,6 +64,7 @@
 STATIC void	xfs_mount_log_sbunit(xfs_mount_t *, __int64_t);
 STATIC int	xfs_uuid_mount(xfs_mount_t *);
 STATIC void	xfs_uuid_unmount(xfs_mount_t *mp);
+STATIC void	xfs_unmountfs_wait(xfs_mount_t *mp);
 
 static struct {
     short offset;
@@ -546,7 +547,7 @@
  * fields from the superblock associated with the given
  * mount structure
  */
-void
+STATIC void
 xfs_mount_common(xfs_mount_t *mp, xfs_sb_t *sbp)
 {
 	int	i;
@@ -1137,7 +1138,7 @@
 	xfs_free_buftarg(mp->m_ddev_targp, 0);
 }
 
-void
+STATIC void
 xfs_unmountfs_wait(xfs_mount_t *mp)
 {
 	if (mp->m_logdev_targp != mp->m_ddev_targp)
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_rename.c.old	2005-04-23 05:48:25.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_rename.c	2005-04-23 05:48:33.000000000 +0200
@@ -235,7 +235,7 @@
 }
 
 
-int rename_which_error_return = 0;
+static int rename_which_error_return = 0;
 
 /*
  * xfs_rename
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_trans.h.old	2005-04-23 05:49:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_trans.h	2005-04-23 05:50:03.000000000 +0200
@@ -987,8 +987,6 @@
 xfs_trans_t	*xfs_trans_dup(xfs_trans_t *);
 int		xfs_trans_reserve(xfs_trans_t *, uint, uint, uint,
 				  uint, uint);
-void		xfs_trans_callback(xfs_trans_t *,
-				   void (*)(xfs_trans_t *, void *), void *);
 void		xfs_trans_mod_sb(xfs_trans_t *, uint, long);
 struct xfs_buf	*xfs_trans_get_buf(xfs_trans_t *, struct xfs_buftarg *, xfs_daddr_t,
 				   int, uint);
@@ -1010,7 +1008,6 @@
 			       xfs_ino_t , uint, uint, struct xfs_inode **);
 void		xfs_trans_ijoin(xfs_trans_t *, struct xfs_inode *, uint);
 void		xfs_trans_ihold(xfs_trans_t *, struct xfs_inode *);
-void		xfs_trans_ihold_release(xfs_trans_t *, struct xfs_inode *);
 void		xfs_trans_log_buf(xfs_trans_t *, struct xfs_buf *, uint, uint);
 void		xfs_trans_log_inode(xfs_trans_t *, struct xfs_inode *, uint);
 struct xfs_efi_log_item	*xfs_trans_get_efi(xfs_trans_t *, uint);
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_trans.c.old	2005-04-23 05:49:20.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_trans.c	2005-04-23 05:49:49.000000000 +0200
@@ -338,6 +338,7 @@
  *
  * Only one callback can be associated with any single transaction.
  */
+#if 0
 void
 xfs_trans_callback(
 	xfs_trans_t		*tp,
@@ -348,6 +349,7 @@
 	tp->t_callback = callback;
 	tp->t_callarg = arg;
 }
+#endif  /*  0  */
 
 
 /*
@@ -551,7 +553,7 @@
  *
  * This is done efficiently with a single call to xfs_mod_incore_sb_batch().
  */
-void
+STATIC void
 xfs_trans_unreserve_and_mod_sb(
 	xfs_trans_t	*tp)
 {
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_trans_inode.c.old	2005-04-23 05:50:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_trans_inode.c	2005-04-23 05:50:25.000000000 +0200
@@ -258,6 +258,7 @@
  * for this transaction.
  */
 /*ARGSUSED*/
+#if 0
 void
 xfs_trans_ihold_release(
 	xfs_trans_t	*tp,
@@ -270,6 +271,7 @@
 
 	ip->i_itemp->ili_flags &= ~XFS_ILI_HOLD;
 }
+#endif  /*  0  */
 
 
 /*
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_vfsops.c.old	2005-04-23 05:50:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_vfsops.c	2005-04-23 05:53:30.000000000 +0200
@@ -71,7 +71,8 @@
 #include "xfs_log_priv.h"
 
 STATIC int xfs_sync(bhv_desc_t *, int, cred_t *);
-
+STATIC int xfs_syncsub(xfs_mount_t *mp, int flags, int xflags, int *bypassed);
+STATIC int xfs_unmount_flush( xfs_mount_t *mp, int relocation);
 int
 xfs_init(void)
 {
@@ -681,7 +682,7 @@
  * inodes, which are needed as a separate set of operations so that
  * they can be called as part of relocation process.
  */
-int
+STATIC int
 xfs_unmount_flush(
 	xfs_mount_t	*mp,		/* Mount structure we are getting
 					   rid of. */
@@ -1444,7 +1445,7 @@
  * only available by calling this routine.
  *
  */
-int
+STATIC int
 xfs_syncsub(
 	xfs_mount_t	*mp,
 	int		flags,
@@ -1658,7 +1659,7 @@
 #define MNTOPT_NOIKEEP	"noikeep"	/* free empty inode clusters */
 
 
-int
+STATIC int
 xfs_parseargs(
 	struct bhv_desc		*bhv,
 	char			*options,
@@ -1844,7 +1845,7 @@
 	return 0;
 }
 
-int
+STATIC int
 xfs_showargs(
 	struct bhv_desc		*bhv,
 	struct seq_file		*m)
--- linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_vnodeops.c.old	2005-04-23 05:54:03.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/xfs_vnodeops.c	2005-04-23 05:54:37.000000000 +0200
@@ -283,7 +283,7 @@
 /*
  * xfs_setattr
  */
-int
+STATIC int
 xfs_setattr(
 	bhv_desc_t		*bdp,
 	vattr_t			*vap,
@@ -4025,7 +4025,7 @@
  *      errno on error
  *
  */
-int
+STATIC int
 xfs_alloc_file_space(
 	xfs_inode_t		*ip,
 	xfs_off_t		offset,
--- linux-2.6.12-rc2-mm3-full/fs/xfs/linux-2.6/xfs_linux.h.old	2005-04-23 05:56:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/linux-2.6/xfs_linux.h	2005-04-23 05:56:49.000000000 +0200
@@ -64,7 +64,6 @@
 #include <sema.h>
 #include <time.h>
 
-#include <support/qsort.h>
 #include <support/ktrace.h>
 #include <support/debug.h>
 #include <support/move.h>
--- linux-2.6.12-rc2-mm3-full/fs/xfs/Makefile.old	2005-04-23 04:47:42.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/xfs/Makefile	2005-04-23 04:47:51.000000000 +0200
@@ -143,7 +143,6 @@
 xfs-y				+= $(addprefix support/, \
 				   debug.o \
 				   move.o \
-				   qsort.o \
 				   uuid.o)
 
 xfs-$(CONFIG_XFS_TRACE)		+= support/ktrace.o
--- linux-2.6.12-rc2-mm3-full/fs/xfs/support/qsort.h	2005-04-23 05:55:45.000000000 +0200
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,41 +0,0 @@
-/*
- * Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
- */
-
-#ifndef QSORT_H
-#define QSORT_H
-
-extern void qsort (void *const pbase,
-		    size_t total_elems,
-		    size_t size,
-		    int (*cmp)(const void *, const void *));
-
-#endif
--- linux-2.6.12-rc2-mm3-full/fs/xfs/support/qsort.c	2005-04-23 05:55:45.000000000 +0200
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,155 +0,0 @@
-/*
- * Copyright (c) 1992, 1993
- *	The Regents of the University of California.  All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. Neither the name of the University nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-/*
- * Qsort routine from Bentley & McIlroy's "Engineering a Sort Function".
- */
-#define swapcode(TYPE, parmi, parmj, n) { 		\
-	long i = (n) / sizeof (TYPE); 			\
-	register TYPE *pi = (TYPE *) (parmi); 		\
-	register TYPE *pj = (TYPE *) (parmj); 		\
-	do { 						\
-		register TYPE	t = *pi;		\
-		*pi++ = *pj;				\
-		*pj++ = t;				\
-        } while (--i > 0);				\
-}
-
-#define SWAPINIT(a, es) swaptype = ((char *)a - (char *)0) % sizeof(long) || \
-	es % sizeof(long) ? 2 : es == sizeof(long)? 0 : 1;
-
-static __inline void
-swapfunc(char *a, char *b, int n, int swaptype)
-{
-	if (swaptype <= 1) 
-		swapcode(long, a, b, n)
-	else
-		swapcode(char, a, b, n)
-}
-
-#define swap(a, b)					\
-	if (swaptype == 0) {				\
-		long t = *(long *)(a);			\
-		*(long *)(a) = *(long *)(b);		\
-		*(long *)(b) = t;			\
-	} else						\
-		swapfunc(a, b, es, swaptype)
-
-#define vecswap(a, b, n) 	if ((n) > 0) swapfunc(a, b, n, swaptype)
-
-static __inline char *
-med3(char *a, char *b, char *c, int (*cmp)(const void *, const void *))
-{
-	return cmp(a, b) < 0 ?
-	       (cmp(b, c) < 0 ? b : (cmp(a, c) < 0 ? c : a ))
-              :(cmp(b, c) > 0 ? b : (cmp(a, c) < 0 ? a : c ));
-}
-
-void
-qsort(void *aa, size_t n, size_t es, int (*cmp)(const void *, const void *))
-{
-	char *pa, *pb, *pc, *pd, *pl, *pm, *pn;
-	int d, r, swaptype, swap_cnt;
-	register char *a = aa;
-
-loop:	SWAPINIT(a, es);
-	swap_cnt = 0;
-	if (n < 7) {
-		for (pm = (char *)a + es; pm < (char *) a + n * es; pm += es)
-			for (pl = pm; pl > (char *) a && cmp(pl - es, pl) > 0;
-			     pl -= es)
-				swap(pl, pl - es);
-		return;
-	}
-	pm = (char *)a + (n / 2) * es;
-	if (n > 7) {
-		pl = (char *)a;
-		pn = (char *)a + (n - 1) * es;
-		if (n > 40) {
-			d = (n / 8) * es;
-			pl = med3(pl, pl + d, pl + 2 * d, cmp);
-			pm = med3(pm - d, pm, pm + d, cmp);
-			pn = med3(pn - 2 * d, pn - d, pn, cmp);
-		}
-		pm = med3(pl, pm, pn, cmp);
-	}
-	swap(a, pm);
-	pa = pb = (char *)a + es;
-
-	pc = pd = (char *)a + (n - 1) * es;
-	for (;;) {
-		while (pb <= pc && (r = cmp(pb, a)) <= 0) {
-			if (r == 0) {
-				swap_cnt = 1;
-				swap(pa, pb);
-				pa += es;
-			}
-			pb += es;
-		}
-		while (pb <= pc && (r = cmp(pc, a)) >= 0) {
-			if (r == 0) {
-				swap_cnt = 1;
-				swap(pc, pd);
-				pd -= es;
-			}
-			pc -= es;
-		}
-		if (pb > pc)
-			break;
-		swap(pb, pc);
-		swap_cnt = 1;
-		pb += es;
-		pc -= es;
-	}
-	if (swap_cnt == 0) {  /* Switch to insertion sort */
-		for (pm = (char *) a + es; pm < (char *) a + n * es; pm += es)
-			for (pl = pm; pl > (char *) a && cmp(pl - es, pl) > 0; 
-			     pl -= es)
-				swap(pl, pl - es);
-		return;
-	}
-
-	pn = (char *)a + n * es;
-	r = min(pa - (char *)a, pb - pa);
-	vecswap(a, pb - r, r);
-	r = min((long)(pd - pc), (long)(pn - pd - es));
-	vecswap(pb, pn - r, r);
-	if ((r = pb - pa) > es)
-		qsort(a, r / es, es, cmp);
-	if ((r = pd - pc) > es) { 
-		/* Iterate rather than recurse to save stack space */
-		a = pn - r;
-		n = r / es;
-		goto loop;
-	}
-/*		qsort(pn - r, r / es, es, cmp);*/
-}

