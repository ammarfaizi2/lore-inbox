Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbULPAqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbULPAqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbULPApD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:45:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:21668 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262557AbULPATy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:19:54 -0500
Date: Thu, 16 Dec 2004 01:30:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 17/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_vnodeops.c
Message-ID: <Pine.LNX.4.61.0412160129340.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_vnodeops.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_vnodeops.c	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_vnodeops.c	2004-12-15 23:44:24.000000000 +0100
@@ -375,7 +375,7 @@ xfs_setattr(
 		ASSERT(gdqp == NULL);
 		code = XFS_QM_DQVOPALLOC(mp, ip, uid,gid, qflags, &udqp, &gdqp);
 		if (code)
-			return (code);
+			return code;
 	}
 
 	/*
@@ -1068,11 +1068,8 @@ xfs_readlink(
 
 	}
 
-
 error_return:
-
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
-
 	return error;
 }
 
@@ -1221,7 +1218,7 @@ xfs_inactive_free_eofblocks(
 	last_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_MAXIOFFSET(mp));
 	map_len = last_fsb - end_fsb;
 	if (map_len <= 0)
-		return (0);
+		return 0;
 
 	nimaps = 1;
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
@@ -1235,7 +1232,7 @@ xfs_inactive_free_eofblocks(
 		 * Attach the dquots to the inode up front.
 		 */
 		if ((error = XFS_QM_DQATTACH(mp, ip, 0)))
-			return (error);
+			return error;
 
 		/*
 		 * There are blocks after the end of file.
@@ -1263,7 +1260,7 @@ xfs_inactive_free_eofblocks(
 			ASSERT(XFS_FORCED_SHUTDOWN(mp));
 			xfs_trans_cancel(tp, 0);
 			xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-			return (error);
+			return error;
 		}
 
 		xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1291,7 +1288,7 @@ xfs_inactive_free_eofblocks(
 		}
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 	}
-	return (error);
+	return error;
 }
 
 /*
@@ -1469,7 +1466,7 @@ xfs_inactive_symlink_local(
 	if (error) {
 		xfs_trans_cancel(*tpp, 0);
 		*tpp = NULL;
-		return (error);
+		return error;
 	}
 	xfs_ilock(ip, XFS_ILOCK_EXCL | XFS_IOLOCK_EXCL);
 
@@ -1482,7 +1479,7 @@ xfs_inactive_symlink_local(
 				  XFS_DATA_FORK);
 		ASSERT(ip->i_df.if_bytes == 0);
 	}
-	return (0);
+	return 0;
 }
 
 /*
@@ -1508,7 +1505,7 @@ xfs_inactive_attrs(
 	if (error) {
 		*tpp = NULL;
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-		return (error); /* goto out*/
+		return error; /* goto out */
 	}
 
 	tp = xfs_trans_alloc(mp, XFS_TRANS_INACTIVE);
@@ -1521,7 +1518,7 @@ xfs_inactive_attrs(
 		xfs_trans_cancel(tp, 0);
 		*tpp = NULL;
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-		return (error);
+		return error;
 	}
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1532,7 +1529,7 @@ xfs_inactive_attrs(
 	ASSERT(ip->i_d.di_anextents == 0);
 
 	*tpp = tp;
-	return (0);
+	return 0;
 }
 
 STATIC int
@@ -1569,7 +1566,7 @@ xfs_release(
 		     (ip->i_df.if_flags & XFS_IFEXTENTS))  &&
 		    (!(ip->i_d.di_flags & (XFS_DIFLAG_PREALLOC|XFS_DIFLAG_APPEND)))) {
 			if ((error = xfs_inactive_free_eofblocks(mp, ip)))
-				return (error);
+				return error;
 			/* Update linux inode block count after free above */
 			LINVFS_GET_IP(vp)->i_blocks = XFS_FSB_TO_BB(mp,
 				ip->i_d.di_nblocks + ip->i_delayed_blks);
@@ -1647,7 +1644,7 @@ xfs_inactive(
 		    (!(ip->i_d.di_flags & (XFS_DIFLAG_PREALLOC|XFS_DIFLAG_APPEND)) ||
 		     (ip->i_delayed_blks != 0))) {
 			if ((error = xfs_inactive_free_eofblocks(mp, ip)))
-				return (VN_INACTIVE_CACHE);
+				return VN_INACTIVE_CACHE;
 			/* Update linux inode block count after free above */
 			LINVFS_GET_IP(vp)->i_blocks = XFS_FSB_TO_BB(mp,
 				ip->i_d.di_nblocks + ip->i_delayed_blks);
@@ -1658,7 +1655,7 @@ xfs_inactive(
 	ASSERT(ip->i_d.di_nlink == 0);
 
 	if ((error = XFS_QM_DQATTACH(mp, ip, 0)))
-		return (VN_INACTIVE_CACHE);
+		return VN_INACTIVE_CACHE;
 
 	tp = xfs_trans_alloc(mp, XFS_TRANS_INACTIVE);
 	if (truncate) {
@@ -1681,7 +1678,7 @@ xfs_inactive(
 			ASSERT(XFS_FORCED_SHUTDOWN(mp));
 			xfs_trans_cancel(tp, 0);
 			xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 
 		xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1702,7 +1699,7 @@ xfs_inactive(
 			xfs_trans_cancel(tp,
 				XFS_TRANS_RELEASE_LOG_RES | XFS_TRANS_ABORT);
 			xfs_iunlock(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 	} else if ((ip->i_d.di_mode & S_IFMT) == S_IFLNK) {
 
@@ -1716,7 +1713,7 @@ xfs_inactive(
 
 		if (error) {
 			ASSERT(tp == NULL);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 
 		xfs_trans_ijoin(tp, ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
@@ -1729,7 +1726,7 @@ xfs_inactive(
 		if (error) {
 			ASSERT(XFS_FORCED_SHUTDOWN(mp));
 			xfs_trans_cancel(tp, 0);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 
 		xfs_ilock(ip, XFS_ILOCK_EXCL | XFS_IOLOCK_EXCL);
@@ -1751,7 +1748,7 @@ xfs_inactive(
 		 * cancelled, and the inode is unlocked. Just get out.
 		 */
 		 if (error)
-			 return (VN_INACTIVE_CACHE);
+			 return VN_INACTIVE_CACHE;
 	} else if (ip->i_afp) {
 		xfs_idestroy_fork(ip, XFS_ATTR_FORK);
 	}
@@ -2057,8 +2054,8 @@ std_return:
  abort_return:
 	cancel_flags |= XFS_TRANS_ABORT;
 	/* FALLTHROUGH */
- error_return:
 
+ error_return:
 	if (tp != NULL)
 		xfs_trans_cancel(tp, cancel_flags);
 
@@ -2733,9 +2730,9 @@ std_return:
  abort_return:
 	cancel_flags |= XFS_TRANS_ABORT;
 	/* FALLTHROUGH */
+
  error_return:
 	xfs_trans_cancel(tp, cancel_flags);
-
 	goto std_return;
 }
 /*
@@ -3207,10 +3204,12 @@ std_return:
 	}
 	return error;
 
- error1:
+error1:
 	xfs_bmap_cancel(&free_list);
 	cancel_flags |= XFS_TRANS_ABORT;
- error_return:
+	/* FALLTHROUGH */
+
+error_return:
 	xfs_trans_cancel(tp, cancel_flags);
 	goto std_return;
 }
@@ -3629,9 +3628,9 @@ xfs_rwlock(
 	if (locktype == VRWLOCK_WRITE) {
 		xfs_ilock(ip, XFS_IOLOCK_EXCL);
 	} else if (locktype == VRWLOCK_TRY_READ) {
-		return (xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED));
+		return xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED);
 	} else if (locktype == VRWLOCK_TRY_WRITE) {
-		return (xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL));
+		return xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL);
 	} else {
 		ASSERT((locktype == VRWLOCK_READ) ||
 		       (locktype == VRWLOCK_WRITE_DIRECT));
@@ -3915,7 +3914,7 @@ xfs_finish_reclaim(
 			xfs_ifunlock(ip);
 			xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		}
-		return(1);
+		return 1;
 	}
 	ip->i_flags |= XFS_IRECLAIM;
 	write_unlock(&ih->ih_lock);
@@ -3949,7 +3948,7 @@ xfs_finish_reclaim(
 			if (error) {
 				xfs_iunlock(ip, XFS_ILOCK_EXCL);
 				xfs_ireclaim(ip);
-				return (0);
+				return 0;
 			}
 			xfs_iflock(ip); /* synchronize with xfs_iflush_done */
 		}
@@ -4097,7 +4096,7 @@ xfs_alloc_file_space(
 			offset, end_dmi_offset - offset,
 			0, NULL);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	/*
@@ -4345,7 +4344,7 @@ xfs_free_file_space(
 				offset, end_dmi_offset - offset,
 				AT_DELAY_FLAG(attr_flags), NULL);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	if (need_iolock)




