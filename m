Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWIANOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWIANOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWIANOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:14:39 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:63118 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751022AbWIANOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:14:38 -0400
Message-ID: <44F833C9.1000208@student.ltu.se>
Date: Fri, 01 Sep 2006 15:21:13 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, xfs-masters@oss.sgi.com, nathans@sgi.com
CC: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Converting into generic boolean
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Converting:
'B_FALSE' into 'false'
'B_TRUE'  into 'true'
'boolean_t' into 'bool'

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Depends on "[PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Correcting error-prone boolean-statement"
Compile-tested


 quota/xfs_dquot.c       |   14 +++++++-------
 quota/xfs_qm.c          |   12 ++++++------
 quota/xfs_qm.h          |    2 +-
 quota/xfs_qm_bhv.c      |    4 ++--
 quota/xfs_qm_syscalls.c |   26 +++++++++++++-------------
 quota/xfs_trans_dquot.c |   10 +++++-----
 xfs_ialloc.c            |    6 +++---
 xfs_ialloc.h            |    4 ++--
 xfs_inode.c             |    2 +-
 xfs_inode.h             |    2 +-
 xfs_log.c               |    6 +++---
 xfs_qmops.c             |    2 +-
 xfs_types.h             |    1 -
 xfs_utils.c             |    2 +-
 xfs_vfsops.c            |   28 ++++++++++++++--------------
 xfs_vnodeops.c          |   22 +++++++++++-----------
 16 files changed, 71 insertions(+), 72 deletions(-)


diff -Narup a/fs/xfs/quota/xfs_dquot.c b/fs/xfs/quota/xfs_dquot.c
--- a/fs/xfs/quota/xfs_dquot.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/quota/xfs_dquot.c	2006-09-01 04:15:52.000000000 +0200
@@ -90,7 +90,7 @@ xfs_qm_dqinit(
 	uint	     type)
 {
 	xfs_dquot_t	*dqp;
-	boolean_t	brandnewdquot;
+	bool		brandnewdquot;
 
 	brandnewdquot = xfs_qm_dqalloc_incore(&dqp);
 	dqp->dq_flags = type;
@@ -526,13 +526,13 @@ xfs_qm_dqtobp(
 	xfs_mount_t	*mp;
 	xfs_disk_dquot_t *ddq;
 	xfs_dqid_t	id;
-	boolean_t	newdquot;
+	bool		newdquot;
 	xfs_trans_t	*tp = (tpp ? *tpp : NULL);
 
 	mp = dqp->q_mount;
 	id = be32_to_cpu(dqp->q_core.d_id);
 	nmaps = 1;
-	newdquot = B_FALSE;
+	newdquot = false;
 
 	/*
 	 * If we don't know where the dquot lives, find out.
@@ -582,7 +582,7 @@ xfs_qm_dqtobp(
 						dqp->q_fileoffset, &bp)))
 				return (error);
 			tp = *tpp;
-			newdquot = B_TRUE;
+			newdquot = true;
 		} else {
 			/*
 			 * store the blkno etc so that we don't have to do the
@@ -793,7 +793,7 @@ xfs_qm_dqlookup(
 
 	ASSERT(XFS_DQ_IS_HASH_LOCKED(qh));
 
-	flist_locked = B_FALSE;
+	flist_locked = false;
 
 	/*
 	 * Traverse the hashchain looking for a match
@@ -828,7 +828,7 @@ xfs_qm_dqlookup(
 					xfs_dqlock(dqp);
 					dqp->dq_flags &= ~(XFS_DQ_WANT);
 				}
-				flist_locked = B_TRUE;
+				flist_locked = true;
 			}
 
 			/*
@@ -840,7 +840,7 @@ xfs_qm_dqlookup(
 			if (flist_locked) {
 				if (dqp->q_nrefs != 0) {
 					xfs_qm_freelist_unlock(xfs_Gqm);
-					flist_locked = B_FALSE;
+					flist_locked = false;
 				} else {
 					/*
 					 * take it off the freelist
diff -Narup a/fs/xfs/quota/xfs_qm_bhv.c b/fs/xfs/quota/xfs_qm_bhv.c
--- a/fs/xfs/quota/xfs_qm_bhv.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/quota/xfs_qm_bhv.c	2006-09-01 02:49:49.000000000 +0200
@@ -279,7 +279,7 @@ xfs_qm_newmount(
 	uint		uquotaondisk = 0, gquotaondisk = 0, pquotaondisk = 0;
 
 	*quotaflags = 0;
-	*needquotamount = B_FALSE;
+	*needquotamount = false;
 
 	quotaondisk = XFS_SB_VERSION_HASQUOTA(&mp->m_sb) &&
 				(mp->m_sb.sb_qflags & XFS_ALL_QUOTA_ACCT);
@@ -334,7 +334,7 @@ xfs_qm_newmount(
 			 * inode goes inactive and wants to free blocks,
 			 * or via xfs_log_mount_finish.
 			 */
-			*needquotamount = B_TRUE;
+			*needquotamount = true;
 			*quotaflags = mp->m_qflags;
 			mp->m_qflags = 0;
 		}
diff -Narup a/fs/xfs/quota/xfs_qm.c b/fs/xfs/quota/xfs_qm.c
--- a/fs/xfs/quota/xfs_qm.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/quota/xfs_qm.c	2006-09-01 04:15:06.000000000 +0200
@@ -1031,14 +1031,14 @@ xfs_qm_sync(
 	int		recl, restarts;
 	xfs_dquot_t	*dqp;
 	uint		flush_flags;
-	boolean_t	nowait;
+	bool		nowait;
 	int		error;
 
 	restarts = 0;
 	/*
 	 * We won't block unless we are asked to.
 	 */
-	nowait = (boolean_t)(flags & SYNC_BDFLUSH || (flags & SYNC_WAIT) == 0);
+	nowait = (flags & SYNC_BDFLUSH || (flags & SYNC_WAIT) == 0);
 
   again:
 	xfs_qm_mplist_lock(mp);
@@ -2339,10 +2339,10 @@ xfs_qm_dqreclaim_one(void)
  * Return a new incore dquot. Depending on the number of
  * dquots in the system, we either allocate a new one on the kernel heap,
  * or reclaim a free one.
- * Return value is B_TRUE if we allocated a new dquot, B_FALSE if we managed
+ * Return value is 'true' if we allocated a new dquot, 'false' if we managed
  * to reclaim an existing one from the freelist.
  */
-boolean_t
+bool
 xfs_qm_dqalloc_incore(
 	xfs_dquot_t **O_dqpp)
 {
@@ -2365,7 +2365,7 @@ xfs_qm_dqalloc_incore(
 			 */
 			memset(&dqp->q_core, 0, sizeof(dqp->q_core));
 			*O_dqpp = dqp;
-			return B_FALSE;
+			return false;
 		}
 		XQM_STATS_INC(xqmstats.xs_qm_dqreclaim_misses);
 	}
@@ -2378,7 +2378,7 @@ xfs_qm_dqalloc_incore(
 	*O_dqpp = kmem_zone_zalloc(xfs_Gqm->qm_dqzone, KM_SLEEP);
 	atomic_inc(&xfs_Gqm->qm_totaldquots);
 
-	return B_TRUE;
+	return true;
 }
 
 
diff -Narup a/fs/xfs/quota/xfs_qm.h b/fs/xfs/quota/xfs_qm.h
--- a/fs/xfs/quota/xfs_qm.h	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/quota/xfs_qm.h	2006-09-01 04:15:17.000000000 +0200
@@ -180,7 +180,7 @@ extern int		xfs_qm_write_sb_changes(xfs_
 extern int		xfs_qm_sync(xfs_mount_t *, short);
 
 /* dquot stuff */
-extern boolean_t	xfs_qm_dqalloc_incore(xfs_dquot_t **);
+extern bool		xfs_qm_dqalloc_incore(xfs_dquot_t **);
 extern int		xfs_qm_dqattach(xfs_inode_t *, uint);
 extern void		xfs_qm_dqdetach(xfs_inode_t *);
 extern int		xfs_qm_dqpurge_all(xfs_mount_t *, uint);
diff -Narup a/fs/xfs/quota/xfs_qm_syscalls.c b/fs/xfs/quota/xfs_qm_syscalls.c
--- a/fs/xfs/quota/xfs_qm_syscalls.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/quota/xfs_qm_syscalls.c	2006-09-01 03:07:01.000000000 +0200
@@ -66,7 +66,7 @@ STATIC int	xfs_qm_scall_getqstat(xfs_mou
 STATIC int	xfs_qm_scall_setqlim(xfs_mount_t *, xfs_dqid_t, uint,
 					fs_disk_quota_t *);
 STATIC int	xfs_qm_scall_quotaon(xfs_mount_t *, uint);
-STATIC int	xfs_qm_scall_quotaoff(xfs_mount_t *, uint, boolean_t);
+STATIC int	xfs_qm_scall_quotaoff(xfs_mount_t *, uint, bool);
 STATIC int	xfs_qm_log_quotaoff(xfs_mount_t *, xfs_qoff_logitem_t **, uint);
 STATIC int	xfs_qm_log_quotaoff_end(xfs_mount_t *, xfs_qoff_logitem_t *,
 					uint);
@@ -149,7 +149,7 @@ xfs_qm_quotactl(
 			return XFS_ERROR(EROFS);
 		error = xfs_qm_scall_quotaoff(mp,
 					    xfs_qm_import_flags(*(uint *)addr),
-					    B_FALSE);
+					    false);
 		break;
 
 	case Q_XGETQUOTA:
@@ -204,7 +204,7 @@ STATIC int
 xfs_qm_scall_quotaoff(
 	xfs_mount_t		*mp,
 	uint			flags,
-	boolean_t		force)
+	bool			force)
 {
 	uint			dqtype;
 	unsigned long	s;
@@ -526,10 +526,10 @@ xfs_qm_scall_getqstat(
 	fs_quota_stat_t *out)
 {
 	xfs_inode_t	*uip, *gip;
-	boolean_t	tempuqip, tempgqip;
+	bool		tempuqip, tempgqip;
 
 	uip = gip = NULL;
-	tempuqip = tempgqip = B_FALSE;
+	tempuqip = tempgqip = false;
 	memset(out, 0, sizeof(fs_quota_stat_t));
 
 	out->qs_version = FS_QSTAT_VERSION;
@@ -552,12 +552,12 @@ xfs_qm_scall_getqstat(
 	if (!uip && mp->m_sb.sb_uquotino != NULLFSINO) {
 		if (xfs_iget(mp, NULL, mp->m_sb.sb_uquotino,
 					0, 0, &uip, 0) == 0)
-			tempuqip = B_TRUE;
+			tempuqip = true;
 	}
 	if (!gip && mp->m_sb.sb_gquotino != NULLFSINO) {
 		if (xfs_iget(mp, NULL, mp->m_sb.sb_gquotino,
 					0, 0, &gip, 0) == 0)
-			tempgqip = B_TRUE;
+			tempgqip = true;
 	}
 	if (uip) {
 		out->qs_uquota.qfs_nblks = uip->i_d.di_nblocks;
@@ -1034,7 +1034,7 @@ xfs_qm_dqrele_all_inodes(
 	xfs_inode_t	*ip, *topino;
 	uint		ireclaims;
 	bhv_vnode_t	*vp;
-	boolean_t	vnode_refd;
+	bool		vnode_refd;
 
 	ASSERT(mp->m_quotainfo);
 
@@ -1065,7 +1065,7 @@ again:
 			ip = ip->i_mnext;
 			continue;
 		}
-		vnode_refd = B_FALSE;
+		vnode_refd = false;
 		if (xfs_ilock_nowait(ip, XFS_ILOCK_EXCL) == 0) {
 			ireclaims = mp->m_ireclaims;
 			topino = mp->m_inodes;
@@ -1076,7 +1076,7 @@ again:
 			XFS_MOUNT_IUNLOCK(mp);
 			/* XXX restart limit ? */
 			xfs_ilock(ip, XFS_ILOCK_EXCL);
-			vnode_refd = B_TRUE;
+			vnode_refd = true;
 		} else {
 			ireclaims = mp->m_ireclaims;
 			topino = mp->m_inodes;
@@ -1344,7 +1344,7 @@ xfs_qm_internalqcheck_adjust(
 	xfs_inode_t		*ip;
 	xfs_dqtest_t		*ud, *gd;
 	uint			lock_flags;
-	boolean_t		ipreleased;
+	bool			ipreleased;
 	int			error;
 
 	ASSERT(XFS_IS_QUOTA_RUNNING(mp));
@@ -1357,7 +1357,7 @@ xfs_qm_internalqcheck_adjust(
 			(unsigned long long) mp->m_sb.sb_gquotino);
 		return XFS_ERROR(EINVAL);
 	}
-	ipreleased = B_FALSE;
+	ipreleased = false;
  again:
 	lock_flags = XFS_ILOCK_SHARED;
 	if ((error = xfs_iget(mp, NULL, ino, 0, lock_flags, &ip, bno))) {
@@ -1379,7 +1379,7 @@ xfs_qm_internalqcheck_adjust(
 	 */
 	if (! ipreleased) {
 		xfs_iput(ip, lock_flags);
-		ipreleased = B_TRUE;
+		ipreleased = true;
 		goto again;
 	}
 	xfs_qm_internalqcheck_get_dquots(mp,
diff -Narup a/fs/xfs/quota/xfs_trans_dquot.c b/fs/xfs/quota/xfs_trans_dquot.c
--- a/fs/xfs/quota/xfs_trans_dquot.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/quota/xfs_trans_dquot.c	2006-09-01 02:56:02.000000000 +0200
@@ -540,7 +540,7 @@ xfs_trans_unreserve_and_mod_dquots(
 	int			i, j;
 	xfs_dquot_t		*dqp;
 	xfs_dqtrx_t		*qtrx, *qa;
-	boolean_t		locked;
+	bool			locked;
 
 	if (!tp->t_dqinfo || !(tp->t_flags & XFS_TRANS_DQ_DIRTY))
 		return;
@@ -561,17 +561,17 @@ xfs_trans_unreserve_and_mod_dquots(
 			 * about the number of blocks used field, or deltas.
 			 * Also we don't bother to zero the fields.
 			 */
-			locked = B_FALSE;
+			locked = false;
 			if (qtrx->qt_blk_res) {
 				xfs_dqlock(dqp);
-				locked = B_TRUE;
+				locked = true;
 				dqp->q_res_bcount -=
 					(xfs_qcnt_t)qtrx->qt_blk_res;
 			}
 			if (qtrx->qt_ino_res) {
 				if (!locked) {
 					xfs_dqlock(dqp);
-					locked = B_TRUE;
+					locked = true;
 				}
 				dqp->q_res_icount -=
 					(xfs_qcnt_t)qtrx->qt_ino_res;
@@ -580,7 +580,7 @@ xfs_trans_unreserve_and_mod_dquots(
 			if (qtrx->qt_rtblk_res) {
 				if (!locked) {
 					xfs_dqlock(dqp);
-					locked = B_TRUE;
+					locked = true;
 				}
 				dqp->q_res_rtbcount -=
 					(xfs_qcnt_t)qtrx->qt_rtblk_res;
diff -Narup a/fs/xfs/xfs_ialloc.c b/fs/xfs/xfs_ialloc.c
--- a/fs/xfs/xfs_ialloc.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/xfs_ialloc.c	2006-09-01 03:02:53.000000000 +0200
@@ -509,7 +509,7 @@ xfs_dialloc(
 	mode_t		mode,		/* mode bits for new inode */
 	int		okalloc,	/* ok to allocate more space */
 	xfs_buf_t	**IO_agbp,	/* in/out ag header's buffer */
-	boolean_t	*alloc_done,	/* true if we needed to replenish
+	bool		*alloc_done,	/* true if we needed to replenish
 					   inode freelist */
 	xfs_ino_t	*inop)		/* inode number allocated */
 {
@@ -585,7 +585,7 @@ xfs_dialloc(
 	 * or in which we can allocate some inodes.  Iterate through the
 	 * allocation groups upward, wrapping at the end.
 	 */
-	*alloc_done = B_FALSE;
+	*alloc_done = false;
 	while (!agi->agi_freecount) {
 		/*
 		 * Don't do anything if we're not supposed to allocate
@@ -612,7 +612,7 @@ xfs_dialloc(
 				 * us again where we left off.
 				 */
 				ASSERT(be32_to_cpu(agi->agi_freecount) > 0);
-				*alloc_done = B_TRUE;
+				*alloc_done = true;
 				*IO_agbp = agbp;
 				*inop = NULLFSINO;
 				return 0;
diff -Narup a/fs/xfs/xfs_ialloc.h b/fs/xfs/xfs_ialloc.h
--- a/fs/xfs/xfs_ialloc.h	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/xfs_ialloc.h	2006-09-01 04:17:17.000000000 +0200
@@ -82,7 +82,7 @@ static inline int xfs_ialloc_find_free(x
  * on-disk data structures are updated.  The inode itself is not read
  * in, since doing so would break ordering constraints with xfs_reclaim.
  *
- * *agbp should be set to NULL on the first call, *alloc_done set to FALSE.
+ * *agbp should be set to NULL on the first call, *alloc_done set to 'false'.
  */
 int					/* error */
 xfs_dialloc(
@@ -91,7 +91,7 @@ xfs_dialloc(
 	mode_t		mode,		/* mode bits for new inode */
 	int		okalloc,	/* ok to allocate more space */
 	struct xfs_buf	**agbp,		/* buf for a.g. inode header */
-	boolean_t	*alloc_done,	/* an allocation was done to replenish
+	bool		*alloc_done,	/* an allocation was done to replenish
 					   the free inodes */
 	xfs_ino_t	*inop);		/* inode number allocated */
 
diff -Narup a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
--- a/fs/xfs/xfs_inode.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/xfs_inode.c	2006-09-01 03:05:41.000000000 +0200
@@ -1083,7 +1083,7 @@ xfs_ialloc(
 	xfs_prid_t	prid,
 	int		okalloc,
 	xfs_buf_t	**ialloc_context,
-	boolean_t	*call_again,
+	bool		*call_again,
 	xfs_inode_t	**ipp)
 {
 	xfs_ino_t	ino;
diff -Narup a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
--- a/fs/xfs/xfs_inode.h	2006-09-01 01:24:52.000000000 +0200
+++ b/fs/xfs/xfs_inode.h	2006-09-01 03:05:17.000000000 +0200
@@ -429,7 +429,7 @@ int		xfs_iread(struct xfs_mount *, struc
 int		xfs_iread_extents(struct xfs_trans *, xfs_inode_t *, int);
 int		xfs_ialloc(struct xfs_trans *, xfs_inode_t *, mode_t,
 			   xfs_nlink_t, xfs_dev_t, struct cred *, xfs_prid_t,
-			   int, struct xfs_buf **, boolean_t *, xfs_inode_t **);
+			   int, struct xfs_buf **, bool *, xfs_inode_t **);
 void		xfs_xlate_dinode_core(xfs_caddr_t, struct xfs_dinode_core *,
 					int);
 uint		xfs_ip2xflags(struct xfs_inode *);
diff -Narup a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
--- a/fs/xfs/xfs_log.c	2006-09-01 01:25:48.000000000 +0200
+++ b/fs/xfs/xfs_log.c	2006-09-01 04:18:20.000000000 +0200
@@ -113,7 +113,7 @@ STATIC void		xlog_ticket_put(xlog_t *log
 STATIC void	xlog_verify_dest_ptr(xlog_t *log, __psint_t ptr);
 STATIC void	xlog_verify_grant_head(xlog_t *log, int equals);
 STATIC void	xlog_verify_iclog(xlog_t *log, xlog_in_core_t *iclog,
-				  int count, boolean_t syncing);
+				  int count, bool syncing);
 STATIC void	xlog_verify_tail_lsn(xlog_t *log, xlog_in_core_t *iclog,
 				     xfs_lsn_t tail_lsn);
 #else
@@ -1443,7 +1443,7 @@ xlog_sync(xlog_t		*log,
 	ASSERT(XFS_BUF_ADDR(bp) <= log->l_logBBsize-1);
 	ASSERT(XFS_BUF_ADDR(bp) + BTOBB(count) <= log->l_logBBsize);
 
-	xlog_verify_iclog(log, iclog, count, B_TRUE);
+	xlog_verify_iclog(log, iclog, count, true);
 
 	/* account for log which doesn't start at block #0 */
 	XFS_BUF_SET_ADDR(bp, XFS_BUF_ADDR(bp) + log->l_logBBstart);
@@ -3436,7 +3436,7 @@ STATIC void
 xlog_verify_iclog(xlog_t	 *log,
 		  xlog_in_core_t *iclog,
 		  int		 count,
-		  boolean_t	 syncing)
+		  bool		 syncing)
 {
 	xlog_op_header_t	*ophead;
 	xlog_in_core_t		*icptr;
diff -Narup a/fs/xfs/xfs_qmops.c b/fs/xfs/xfs_qmops.c
--- a/fs/xfs/xfs_qmops.c	2006-09-01 01:24:49.000000000 +0200
+++ b/fs/xfs/xfs_qmops.c	2006-09-01 02:28:36.000000000 +0200
@@ -91,7 +91,7 @@ xfs_noquota_init(
 	int		error = 0;
 
 	*quotaflags = 0;
-	*needquotamount = B_FALSE;
+	*needquotamount = false;
 
 	ASSERT(!XFS_IS_QUOTA_ON(mp));
 
diff -Narup a/fs/xfs/xfs_types.h b/fs/xfs/xfs_types.h
--- a/fs/xfs/xfs_types.h	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/xfs_types.h	2006-09-01 02:29:10.000000000 +0200
@@ -40,7 +40,6 @@ typedef unsigned int		__uint32_t;
 typedef signed long long int	__int64_t;
 typedef unsigned long long int	__uint64_t;
 
-typedef enum { B_FALSE,B_TRUE }	boolean_t;
 typedef __uint32_t		prid_t;		/* project ID */
 typedef __uint32_t		inst_t;		/* an instruction */
 
diff -Narup a/fs/xfs/xfs_utils.c b/fs/xfs/xfs_utils.c
--- a/fs/xfs/xfs_utils.c	2006-09-01 01:24:51.000000000 +0200
+++ b/fs/xfs/xfs_utils.c	2006-09-01 04:43:34.000000000 +0200
@@ -142,7 +142,7 @@ xfs_dir_ialloc(
 	xfs_trans_t	*ntp;
 	xfs_inode_t	*ip;
 	xfs_buf_t	*ialloc_context = NULL;
-	boolean_t	call_again = B_FALSE;
+	bool		call_again = false;
 	int		code;
 	uint		log_res;
 	uint		log_count;
diff -Narup a/fs/xfs/xfs_vfsops.c b/fs/xfs/xfs_vfsops.c
--- a/fs/xfs/xfs_vfsops.c	2006-09-01 01:25:48.000000000 +0200
+++ b/fs/xfs/xfs_vfsops.c	2006-09-01 02:57:06.000000000 +0200
@@ -914,16 +914,16 @@ xfs_sync_inodes(
 	uint64_t	fflag;
 	uint		lock_flags;
 	uint		base_lock_flags;
-	boolean_t	mount_locked;
-	boolean_t	vnode_refed;
+	bool		mount_locked;
+	bool		vnode_refed;
 	int		preempt;
 	xfs_dinode_t	*dip;
 	xfs_iptr_t	*ipointer;
 #ifdef DEBUG
-	boolean_t	ipointer_in = B_FALSE;
+	bool		ipointer_in = false;
 
-#define IPOINTER_SET	ipointer_in = B_TRUE
-#define IPOINTER_CLR	ipointer_in = B_FALSE
+#define IPOINTER_SET	ipointer_in = true
+#define IPOINTER_CLR	ipointer_in = false
 #else
 #define IPOINTER_SET
 #define IPOINTER_CLR
@@ -942,7 +942,7 @@ xfs_sync_inodes(
 		ipointer->ip_mnext->i_mprev = (xfs_inode_t *)ipointer; \
 		preempt = 0; \
 		XFS_MOUNT_IUNLOCK(mp); \
-		mount_locked = B_FALSE; \
+		mount_locked = false; \
 		IPOINTER_SET; \
 	}
 
@@ -1000,8 +1000,8 @@ xfs_sync_inodes(
 
 	ip = mp->m_inodes;
 
-	mount_locked = B_TRUE;
-	vnode_refed  = B_FALSE;
+	mount_locked = true;
+	vnode_refed  = false;
 
 	IPOINTER_CLR;
 
@@ -1051,7 +1051,7 @@ xfs_sync_inodes(
 						XFS_IFLUSH_DELWRI_ELSE_ASYNC);
 
 				XFS_MOUNT_ILOCK(mp);
-				mount_locked = B_TRUE;
+				mount_locked = true;
 				IPOINTER_REMOVE(ip, mp);
 			} else {
 				xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1123,7 +1123,7 @@ xfs_sync_inodes(
 			ASSERT(vp == XFS_ITOV(ip));
 			ASSERT(ip->i_mount == mp);
 
-			vnode_refed = B_TRUE;
+			vnode_refed = true;
 		}
 
 		/* From here on in the loop we may have a marker record
@@ -1246,7 +1246,7 @@ xfs_sync_inodes(
 					 * and continue.
 					 */
 					XFS_MOUNT_ILOCK(mp);
-					mount_locked = B_TRUE;
+					mount_locked = true;
 
 					if (ip != ipointer->ip_mprev) {
 						IPOINTER_REMOVE(ip, mp);
@@ -1289,7 +1289,7 @@ xfs_sync_inodes(
 						 * a marker in the list here.
 						 */
 						XFS_MOUNT_IUNLOCK(mp);
-						mount_locked = B_FALSE;
+						mount_locked = false;
 						error = xfs_iflush(ip,
 							   XFS_IFLUSH_DELWRI);
 					} else {
@@ -1356,7 +1356,7 @@ xfs_sync_inodes(
 
 			VN_RELE(vp);
 
-			vnode_refed = B_FALSE;
+			vnode_refed = false;
 		}
 
 		if (error) {
@@ -1389,7 +1389,7 @@ xfs_sync_inodes(
 
 		if (!mount_locked) {
 			XFS_MOUNT_ILOCK(mp);
-			mount_locked = B_TRUE;
+			mount_locked = true;
 			IPOINTER_REMOVE(ip, mp);
 			continue;
 		}
diff -Narup a/fs/xfs/xfs_vnodeops.c b/fs/xfs/xfs_vnodeops.c
--- a/fs/xfs/xfs_vnodeops.c	2006-09-01 01:24:52.000000000 +0200
+++ b/fs/xfs/xfs_vnodeops.c	2006-09-01 02:59:37.000000000 +0200
@@ -1864,7 +1864,7 @@ xfs_create(
 	int                     error;
 	xfs_bmap_free_t		free_list;
 	xfs_fsblock_t		first_block;
-	boolean_t		dp_joined_to_trans;
+	bool			dp_joined_to_trans;
 	int			dm_event_sent = 0;
 	uint			cancel_flags;
 	int			committed;
@@ -1918,7 +1918,7 @@ xfs_create(
 		goto std_return;
 
 	ip = NULL;
-	dp_joined_to_trans = B_FALSE;
+	dp_joined_to_trans = false;
 
 	tp = xfs_trans_alloc(mp, XFS_TRANS_CREATE);
 	cancel_flags = XFS_TRANS_RELEASE_LOG_RES;
@@ -1984,7 +1984,7 @@ xfs_create(
 
 	VN_HOLD(dir_vp);
 	xfs_trans_ijoin(tp, dp, XFS_ILOCK_EXCL);
-	dp_joined_to_trans = B_TRUE;
+	dp_joined_to_trans = true;
 
 	error = xfs_dir_createname(tp, dp, name, namelen, ip->i_ino,
 					&first_block, &free_list, resblks ?
@@ -2765,8 +2765,8 @@ xfs_mkdir(
 	xfs_bmap_free_t         free_list;
 	xfs_fsblock_t           first_block;
 	bhv_vnode_t		*dir_vp;
-	boolean_t		dp_joined_to_trans;
-	boolean_t		created = B_FALSE;
+	bool			dp_joined_to_trans;
+	bool			created = false;
 	int			dm_event_sent = 0;
 	xfs_prid_t		prid;
 	struct xfs_dquot	*udqp, *gdqp;
@@ -2784,7 +2784,7 @@ xfs_mkdir(
 	dir_namelen = VNAMELEN(dentry);
 
 	tp = NULL;
-	dp_joined_to_trans = B_FALSE;
+	dp_joined_to_trans = false;
 	dm_di_mode = vap->va_mode;
 
 	if (DM_EVENT_ENABLED(dir_vp->v_vfsp, dp, DM_EVENT_CREATE)) {
@@ -2877,7 +2877,7 @@ xfs_mkdir(
 	 */
 	VN_HOLD(dir_vp);
 	xfs_trans_ijoin(tp, dp, XFS_ILOCK_EXCL);
-	dp_joined_to_trans = B_TRUE;
+	dp_joined_to_trans = true;
 
 	XFS_BMAP_INIT(&free_list, &first_block);
 
@@ -2908,7 +2908,7 @@ xfs_mkdir(
 
 	cvp = XFS_ITOV(cdp);
 
-	created = B_TRUE;
+	created = true;
 
 	*vpp = cvp;
 	IHOLD(cdp);
@@ -3266,7 +3266,7 @@ xfs_symlink(
 	int			pathlen;
 	xfs_bmap_free_t		free_list;
 	xfs_fsblock_t		first_block;
-	boolean_t		dp_joined_to_trans;
+	bool			dp_joined_to_trans;
 	bhv_vnode_t		*dir_vp;
 	uint			cancel_flags;
 	int			committed;
@@ -3288,7 +3288,7 @@ xfs_symlink(
 	*vpp = NULL;
 	dir_vp = BHV_TO_VNODE(dir_bdp);
 	dp = XFS_BHVTOI(dir_bdp);
-	dp_joined_to_trans = B_FALSE;
+	dp_joined_to_trans = false;
 	error = 0;
 	ip = NULL;
 	tp = NULL;
@@ -3428,7 +3428,7 @@ xfs_symlink(
 
 	VN_HOLD(dir_vp);
 	xfs_trans_ijoin(tp, dp, XFS_ILOCK_EXCL);
-	dp_joined_to_trans = B_TRUE;
+	dp_joined_to_trans = true;
 
 	/*
 	 * Also attach the dquot(s) to it, if applicable.


