Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbULPAWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbULPAWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbULPAWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:22:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:38819 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262547AbULPAHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:07:50 -0500
Date: Thu, 16 Dec 2004 01:18:18 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 8/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/quota/xfs_qm.c
Message-ID: <Pine.LNX.4.61.0412160117040.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/quota/xfs_qm.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.10-rc3-bk8-orig/fs/xfs/quota/xfs_qm.c	2004-10-18 23:53:07.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/quota/xfs_qm.c	2004-12-15 22:48:58.000000000 +0100
@@ -526,7 +526,7 @@ xfs_qm_dqflush_all(
 	int		error;
 
 	if (mp->m_quotainfo == NULL)
-		return (0);
+		return 0;
 	niters = 0;
 again:
 	xfs_qm_mplist_lock(mp);
@@ -557,7 +557,7 @@ again:
 		error = xfs_qm_dqflush(dqp, flags);
 		xfs_dqunlock(dqp);
 		if (error)
-			return (error);
+			return error;
 
 		xfs_qm_mplist_lock(mp);
 		if (recl != XFS_QI_MPLRECLAIMS(mp)) {
@@ -569,7 +569,7 @@ again:
 
 	xfs_qm_mplist_unlock(mp);
 	/* return ! busy */
-	return (0);
+	return 0;
 }
 /*
  * Release the group dquot pointers the user dquots may be
@@ -628,7 +628,7 @@ xfs_qm_dqpurge_int(
 	int		nmisses;
 
 	if (mp->m_quotainfo == NULL)
-		return (0);
+		return 0;
 
 	dqtype = (flags & XFS_QMOPT_UQUOTA) ? XFS_DQ_USER : 0;
 	dqtype |= (flags & XFS_QMOPT_GQUOTA) ? XFS_DQ_GROUP : 0;
@@ -824,7 +824,7 @@ xfs_qm_dqattach_one(
 			ASSERT(XFS_DQ_IS_LOCKED(dqp));
 	}
 #endif
-	return (error);
+	return error;
 }
 
 
@@ -925,7 +925,7 @@ xfs_qm_dqattach(
 	    (! XFS_NOT_DQATTACHED(mp, ip)) ||
 	    (ip->i_ino == mp->m_sb.sb_uquotino) ||
 	    (ip->i_ino == mp->m_sb.sb_gquotino))
-		return (0);
+		return 0;
 
 	ASSERT((flags & XFS_QMOPT_ILOCKED) == 0 ||
 	       XFS_ISLOCKED_INODE_EXCL(ip));
@@ -1007,7 +1007,7 @@ xfs_qm_dqattach(
 	else
 		ASSERT(XFS_ISLOCKED_INODE_EXCL(ip));
 #endif
-	return (error);
+	return error;
 }
 
 /*
@@ -1072,7 +1072,7 @@ xfs_qm_sync(
 	 */
 	if (! XFS_IS_QUOTA_ON(mp)) {
 		xfs_qm_mplist_unlock(mp);
-		return (0);
+		return 0;
 	}
 	FOREACH_DQUOT_IN_MP(dqp, mp) {
 		/*
@@ -1132,9 +1132,9 @@ xfs_qm_sync(
 		error = xfs_qm_dqflush(dqp, flush_flags);
 		xfs_dqunlock(dqp);
 		if (error && XFS_FORCED_SHUTDOWN(mp))
-			return(0);	/* Need to prevent umount failure */
+			return 0;	/* Need to prevent umount failure */
 		else if (error)
-			return (error);
+			return error;
 
 		xfs_qm_mplist_lock(mp);
 		if (recl != XFS_QI_MPLRECLAIMS(mp)) {
@@ -1147,7 +1147,7 @@ xfs_qm_sync(
 	}
 
 	xfs_qm_mplist_unlock(mp);
-	return (0);
+	return 0;
 }
 
 
@@ -1169,7 +1169,7 @@ xfs_qm_init_quotainfo(
 	 * Tell XQM that we exist as soon as possible.
 	 */
 	if ((error = xfs_qm_hold_quotafs_ref(mp))) {
-		return (error);
+		return error;
 	}
 
 	qinf = mp->m_quotainfo = kmem_zalloc(sizeof(xfs_quotainfo_t), KM_SLEEP);
@@ -1181,7 +1181,7 @@ xfs_qm_init_quotainfo(
 	if ((error = xfs_qm_init_quotainos(mp))) {
 		kmem_free(qinf, sizeof(xfs_quotainfo_t));
 		mp->m_quotainfo = NULL;
-		return (error);
+		return error;
 	}
 
 	spinlock_init(&qinf->qi_pinlock, "xfs_qinf_pin");
@@ -1267,7 +1267,7 @@ xfs_qm_init_quotainfo(
 		qinf->qi_iwarnlimit = XFS_QM_IWARNLIMIT;
 	}
 
-	return (0);
+	return 0;
 }
 
 
@@ -1367,7 +1367,7 @@ xfs_qm_dqget_noattach(
 			 */
 			ASSERT(error != ESRCH);
 			ASSERT(error != ENOENT);
-			return (error);
+			return error;
 		}
 		ASSERT(udqp);
 	}
@@ -1383,7 +1383,7 @@ xfs_qm_dqget_noattach(
 				xfs_qm_dqrele(udqp);
 			ASSERT(error != ESRCH);
 			ASSERT(error != ENOENT);
-			return (error);
+			return error;
 		}
 		ASSERT(gdqp);
 
@@ -1404,7 +1404,7 @@ xfs_qm_dqget_noattach(
 	if (udqp) ASSERT(XFS_DQ_IS_LOCKED(udqp));
 	if (gdqp) ASSERT(XFS_DQ_IS_LOCKED(gdqp));
 #endif
-	return (0);
+	return 0;
 }
 
 /*
@@ -1431,7 +1431,7 @@ xfs_qm_qino_alloc(
 				      XFS_TRANS_PERM_LOG_RES,
 				      XFS_CREATE_LOG_COUNT))) {
 		xfs_trans_cancel(tp, 0);
-		return (error);
+		return error;
 	}
 	memset(&zerocr, 0, sizeof(zerocr));
 
@@ -1439,7 +1439,7 @@ xfs_qm_qino_alloc(
 				   &zerocr, 0, 1, ip, &committed))) {
 		xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES |
 				 XFS_TRANS_ABORT);
-		return (error);
+		return error;
 	}
 
 	/*
@@ -1487,9 +1487,9 @@ xfs_qm_qino_alloc(
 	if ((error = xfs_trans_commit(tp, XFS_TRANS_RELEASE_LOG_RES,
 				     NULL))) {
 		xfs_fs_cmn_err(CE_ALERT, mp, "XFS qino_alloc failed!");
-		return (error);
+		return error;
 	}
-	return (0);
+	return 0;
 }
 
 
@@ -1532,7 +1532,7 @@ xfs_qm_reset_dqcounts(
 		ddq = (xfs_disk_dquot_t *) ((xfs_dqblk_t *)ddq + 1);
 	}
 
-	return (0);
+	return 0;
 }
 
 STATIC int
@@ -1580,7 +1580,7 @@ xfs_qm_dqiter_bufs(
 		bno++;
 		firstid += XFS_QM_DQPERBLK(mp);
 	}
-	return (error);
+	return error;
 }
 
 /*
@@ -1609,7 +1609,7 @@ xfs_qm_dqiterate(
 	 * happens only at mount time which is single threaded.
 	 */
 	if (qip->i_d.di_nblocks == 0)
-		return (0);
+		return 0;
 
 	map = kmem_alloc(XFS_DQITER_MAP_SIZE * sizeof(*map), KM_SLEEP);
 
@@ -1678,7 +1678,7 @@ xfs_qm_dqiterate(
 
 	kmem_free(map, XFS_DQITER_MAP_SIZE * sizeof(*map));
 
-	return (error);
+	return error;
 }
 
 /*
@@ -1738,7 +1738,7 @@ xfs_qm_get_rtblks(
 	ifp = XFS_IFORK_PTR(ip, XFS_DATA_FORK);
 	if (!(ifp->if_flags & XFS_IFEXTENTS)) {
 		if ((error = xfs_iread_extents(NULL, ip, XFS_DATA_FORK)))
-			return (error);
+			return error;
 	}
 	rtblks = 0;
 	nextents = ifp->if_bytes / sizeof(xfs_bmbt_rec_t);
@@ -1746,7 +1746,7 @@ xfs_qm_get_rtblks(
 	for (ep = base; ep < &base[nextents]; ep++)
 		rtblks += xfs_bmbt_get_blockcount(ep);
 	*O_rtblks = (xfs_qcnt_t)rtblks;
-	return (0);
+	return 0;
 }
 
 /*
@@ -1790,7 +1790,7 @@ xfs_qm_dqusage_adjust(
 	 */
 	if ((error = xfs_iget(mp, NULL, ino, XFS_ILOCK_EXCL, &ip, bno))) {
 		*res = BULKSTAT_RV_NOTHING;
-		return (error);
+		return error;
 	}
 
 	if (ip->i_d.di_mode == 0) {
@@ -1808,7 +1808,7 @@ xfs_qm_dqusage_adjust(
 	if ((error = xfs_qm_dqget_noattach(ip, &udqp, &gdqp))) {
 		xfs_iput(ip, XFS_ILOCK_EXCL);
 		*res = BULKSTAT_RV_GIVEUP;
-		return (error);
+		return error;
 	}
 
 	rtblks = 0;
@@ -1825,7 +1825,7 @@ xfs_qm_dqusage_adjust(
 			if (gdqp)
 				xfs_qm_dqput(gdqp);
 			*res = BULKSTAT_RV_GIVEUP;
-			return (error);
+			return error;
 		}
 		nblks = (xfs_qcnt_t)ip->i_d.di_nblocks - rtblks;
 	}
@@ -1870,7 +1870,7 @@ xfs_qm_dqusage_adjust(
 	 * Goto next inode.
 	 */
 	*res = BULKSTAT_RV_DIDONE;
-	return (0);
+	return 0;
 }
 
 /*
@@ -1974,7 +1974,7 @@ xfs_qm_quotacheck(
 
  error_return:
 	cmn_err(CE_NOTE, "XFS quotacheck %s: Done.", mp->m_fsname);
-	return (error);
+	return error;
 }
 
 /*
@@ -2050,7 +2050,7 @@ xfs_qm_init_quotainos(
 	XFS_QI_UQIP(mp) = uip;
 	XFS_QI_GQIP(mp) = gip;
 
-	return (0);
+	return 0;
 }
 
 
@@ -2071,7 +2071,7 @@ xfs_qm_shake_freelist(
 	int		nflushes;
 
 	if (howmany <= 0)
-		return (0);
+		return 0;
 
 	nreclaimed = 0;
 	restarts = 0;
@@ -2097,7 +2097,7 @@ xfs_qm_shake_freelist(
 			xfs_dqunlock(dqp);
 			xfs_qm_freelist_unlock(xfs_Gqm);
 			if (++restarts >= XFS_QM_RECLAIM_MAX_RESTARTS)
-				return (nreclaimed);
+				return nreclaimed;
 			XQM_STATS_INC(xqmstats.xs_qm_dqwants);
 			goto tryagain;
 		}
@@ -2172,7 +2172,7 @@ xfs_qm_shake_freelist(
 			XFS_DQ_HASH_UNLOCK(hash);
 			xfs_qm_freelist_unlock(xfs_Gqm);
 			if (++restarts >= XFS_QM_RECLAIM_MAX_RESTARTS)
-				return (nreclaimed);
+				return nreclaimed;
 			goto tryagain;
 		}
 		xfs_dqtrace_entry(dqp, "DQSHAKE: UNLINKING");
@@ -2197,7 +2197,7 @@ xfs_qm_shake_freelist(
 		dqp = nextdqp;
 	}
 	xfs_qm_freelist_unlock(xfs_Gqm);
-	return (nreclaimed);
+	return nreclaimed;
 }
 
 
@@ -2211,9 +2211,9 @@ xfs_qm_shake(int nr_to_scan, unsigned in
 	int	ndqused, nfree, n;
 
 	if (!kmem_shake_allow(gfp_mask))
-		return (0);
+		return 0;
 	if (!xfs_Gqm)
-		return (0);
+		return 0;
 
 	nfree = xfs_Gqm->qm_dqfreelist.qh_nelems; /* free dquots */
 	/* incore dquots in all f/s's */
@@ -2222,7 +2222,7 @@ xfs_qm_shake(int nr_to_scan, unsigned in
 	ASSERT(ndqused >= 0);
 
 	if (nfree <= ndqused && nfree < ndquot)
-		return (0);
+		return 0;
 
 	ndqused *= xfs_Gqm->qm_dqfree_ratio;	/* target # of free dquots */
 	n = nfree - ndqused - ndquot;		/* # over target */
@@ -2266,7 +2266,7 @@ xfs_qm_dqreclaim_one(void)
 			xfs_dqunlock(dqp);
 			xfs_qm_freelist_unlock(xfs_Gqm);
 			if (++restarts >= XFS_QM_RECLAIM_MAX_RESTARTS)
-				return (NULL);
+				return NULL;
 			XQM_STATS_INC(xqmstats.xs_qm_dqwants);
 			goto startagain;
 		}
@@ -2342,7 +2342,7 @@ xfs_qm_dqreclaim_one(void)
 	}
 
 	xfs_qm_freelist_unlock(xfs_Gqm);
-	return (dqpout);
+	return dqpout;
 }
 
 
@@ -2378,7 +2378,7 @@ xfs_qm_dqalloc_incore(
 			 */
 			memset(&dqp->q_core, 0, sizeof(dqp->q_core));
 			*O_dqpp = dqp;
-			return (B_FALSE);
+			return B_FALSE;
 		}
 		XQM_STATS_INC(xqmstats.xs_qm_dqreclaim_misses);
 	}
@@ -2391,7 +2391,7 @@ xfs_qm_dqalloc_incore(
 	*O_dqpp = kmem_zone_zalloc(xfs_Gqm->qm_dqzone, KM_SLEEP);
 	atomic_inc(&xfs_Gqm->qm_totaldquots);
 
-	return (B_TRUE);
+	return B_TRUE;
 }
 
 
@@ -2416,13 +2416,13 @@ xfs_qm_write_sb_changes(
 				      0,
 				      XFS_DEFAULT_LOG_COUNT))) {
 		xfs_trans_cancel(tp, 0);
-		return (error);
+		return error;
 	}
 
 	xfs_mod_sb(tp, flags);
 	(void) xfs_trans_commit(tp, 0, NULL);
 
-	return (0);
+	return 0;
 }
 
 
@@ -2471,7 +2471,7 @@ xfs_qm_vop_dqalloc(
 		if ((error = xfs_qm_dqattach(ip, XFS_QMOPT_DQALLOC |
 					    XFS_QMOPT_ILOCKED))) {
 			xfs_iunlock(ip, lockflags);
-			return (error);
+			return error;
 		}
 	}
 
@@ -2495,7 +2495,7 @@ xfs_qm_vop_dqalloc(
 						 XFS_QMOPT_DOWARN,
 						 &uq))) {
 				ASSERT(error != ENOENT);
-				return (error);
+				return error;
 			}
 			/*
 			 * Get the ilock in the right order.
@@ -2527,7 +2527,7 @@ xfs_qm_vop_dqalloc(
 				if (uq)
 					xfs_qm_dqrele(uq);
 				ASSERT(error != ENOENT);
-				return (error);
+				return error;
 			}
 			xfs_dqunlock(gq);
 			lockflags = XFS_ILOCK_SHARED;
@@ -2552,7 +2552,7 @@ xfs_qm_vop_dqalloc(
 		*O_gdqpp = gq;
 	else if (gq)
 		xfs_qm_dqrele(gq);
-	return (0);
+	return 0;
 }
 
 /*
@@ -2600,7 +2600,7 @@ xfs_qm_vop_chown(
 	xfs_dqunlock(newdq);
 	*IO_olddq = newdq;
 
-	return (prevdq);
+	return prevdq;
 }
 
 /*
@@ -2651,7 +2651,7 @@ xfs_qm_vop_chown_reserve(
 	if ((error = xfs_trans_reserve_quota_bydquots(tp, ip->i_mount,
 				delblksudq, delblksgdq, ip->i_d.di_nblocks, 1,
 				flags | XFS_QMOPT_RES_REGBLKS)))
-		return (error);
+		return error;
 
 	/*
 	 * Do the delayed blks reservations/unreservations now. Since, these
@@ -2668,13 +2668,13 @@ xfs_qm_vop_chown_reserve(
 		if ((error = xfs_trans_reserve_quota_bydquots(NULL, ip->i_mount,
 				delblksudq, delblksgdq, (xfs_qcnt_t)delblks, 0,
 				flags | XFS_QMOPT_RES_REGBLKS)))
-			return (error);
+			return error;
 		xfs_trans_reserve_quota_bydquots(NULL, ip->i_mount,
 				unresudq, unresgdq, -((xfs_qcnt_t)delblks), 0,
 				XFS_QMOPT_RES_REGBLKS);
 	}
 
-	return (0);
+	return 0;
 }
 
 int
@@ -2688,12 +2688,12 @@ xfs_qm_vop_rename_dqattach(
 	ip = i_tab[0];
 
 	if (! XFS_IS_QUOTA_ON(ip->i_mount))
-		return (0);
+		return 0;
 
 	if (XFS_NOT_DQATTACHED(ip->i_mount, ip)) {
 		error = xfs_qm_dqattach(ip, 0);
 		if (error)
-			return (error);
+			return error;
 	}
 	for (i = 1; (i < 4 && i_tab[i]); i++) {
 		/*
@@ -2703,11 +2703,11 @@ xfs_qm_vop_rename_dqattach(
 			if (XFS_NOT_DQATTACHED(ip->i_mount, ip)) {
 				error = xfs_qm_dqattach(ip, 0);
 				if (error)
-					return (error);
+					return error;
 			}
 		}
 	}
-	return (0);
+	return 0;
 }
 
 void
@@ -2816,7 +2816,7 @@ xfs_qm_dqhashlock_nowait(
 	int locked;
 
 	locked = mutex_trylock(&((dqp)->q_hash->qh_lock));
-	return (locked);
+	return locked;
 }
 
 int
@@ -2826,7 +2826,7 @@ xfs_qm_freelist_lock_nowait(
 	int locked;
 
 	locked = mutex_trylock(&(xqm->qm_dqfreelist.qh_lock));
-	return (locked);
+	return locked;
 }
 
 int
@@ -2837,5 +2837,5 @@ xfs_qm_mplist_nowait(
 
 	ASSERT(mp->m_quotainfo);
 	locked = mutex_trylock(&(XFS_QI_MPLLOCK(mp)));
-	return (locked);
+	return locked;
 }


