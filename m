Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbULPAFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbULPAFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbULPAFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:05:49 -0500
Received: from mail.dif.dk ([193.138.115.101]:27555 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262543AbULPADX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:03:23 -0500
Date: Thu, 16 Dec 2004 01:13:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 5/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_mount.c
Message-ID: <Pine.LNX.4.61.0412160112460.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_mount.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_mount.c	2004-10-18 23:53:50.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_mount.c	2004-12-15 22:36:35.000000000 +0100
@@ -650,7 +650,7 @@ xfs_mountfs(
 
 	if (mp->m_sb_bp == NULL) {
 		if ((error = xfs_readsb(mp))) {
-			return (error);
+			return error;
 		}
 	}
 	xfs_mount_common(mp, sbp);
@@ -893,7 +893,7 @@ xfs_mountfs(
 	 * For client case we are done now
 	 */
 	if (mfsi_flags & XFS_MFSI_CLIENT) {
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1184,7 +1184,7 @@ xfs_unmountfs_writesb(xfs_mount_t *mp)
 			xfs_fs_cmn_err(CE_ALERT, mp, "Superblock write error detected while unmounting.  Filesystem may not be marked shared readonly");
 	}
 	xfs_buf_relse(sbp);
-	return (error);
+	return error;
 }
 
 /*
@@ -1259,19 +1259,19 @@ xfs_mod_incore_sb_unlocked(xfs_mount_t *
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_icount = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_IFREE:
 		lcounter = (long long)mp->m_sb.sb_ifree;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_ifree = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_FDBLOCKS:
 
 		lcounter = (long long)mp->m_sb.sb_fdblocks;
@@ -1298,101 +1298,101 @@ xfs_mod_incore_sb_unlocked(xfs_mount_t *
 				if (rsvd) {
 					lcounter = (long long)mp->m_resblks_avail + delta;
 					if (lcounter < 0) {
-						return (XFS_ERROR(ENOSPC));
+						return XFS_ERROR(ENOSPC);
 					}
 					mp->m_resblks_avail = lcounter;
-					return (0);
+					return 0;
 				} else {	/* not reserved */
-					return (XFS_ERROR(ENOSPC));
+					return XFS_ERROR(ENOSPC);
 				}
 			}
 		}
 
 		mp->m_sb.sb_fdblocks = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_FREXTENTS:
 		lcounter = (long long)mp->m_sb.sb_frextents;
 		lcounter += delta;
 		if (lcounter < 0) {
-			return (XFS_ERROR(ENOSPC));
+			return XFS_ERROR(ENOSPC);
 		}
 		mp->m_sb.sb_frextents = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_DBLOCKS:
 		lcounter = (long long)mp->m_sb.sb_dblocks;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_dblocks = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_AGCOUNT:
 		scounter = mp->m_sb.sb_agcount;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_agcount = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_IMAX_PCT:
 		scounter = mp->m_sb.sb_imax_pct;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_imax_pct = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_REXTSIZE:
 		scounter = mp->m_sb.sb_rextsize;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rextsize = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_RBMBLOCKS:
 		scounter = mp->m_sb.sb_rbmblocks;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rbmblocks = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_RBLOCKS:
 		lcounter = (long long)mp->m_sb.sb_rblocks;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rblocks = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_REXTENTS:
 		lcounter = (long long)mp->m_sb.sb_rextents;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rextents = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_REXTSLOG:
 		scounter = mp->m_sb.sb_rextslog;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rextslog = scounter;
-		return (0);
+		return 0;
 	default:
 		ASSERT(0);
-		return (XFS_ERROR(EINVAL));
+		return XFS_ERROR(EINVAL);
 	}
 }
 
@@ -1411,7 +1411,7 @@ xfs_mod_incore_sb(xfs_mount_t *mp, xfs_s
 	s = XFS_SB_LOCK(mp);
 	status = xfs_mod_incore_sb_unlocked(mp, field, delta, rsvd);
 	XFS_SB_UNLOCK(mp, s);
-	return (status);
+	return status;
 }
 
 /*
@@ -1472,7 +1472,7 @@ xfs_mod_incore_sb_batch(xfs_mount_t *mp,
 		}
 	}
 	XFS_SB_UNLOCK(mp, s);
-	return (status);
+	return status;
 }
 
 /*
@@ -1502,7 +1502,7 @@ xfs_getsb(
 	}
 	XFS_BUF_HOLD(bp);
 	ASSERT(XFS_BUF_ISDONE(bp));
-	return (bp);
+	return bp;
 }
 
 /*


