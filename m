Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbULPA2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbULPA2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbULPA1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:27:32 -0500
Received: from mail.dif.dk ([193.138.115.101]:62371 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262537AbULPAOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:14:22 -0500
Date: Thu, 16 Dec 2004 01:24:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 13/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_log.c
Message-ID: <Pine.LNX.4.61.0412160123540.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_log.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_log.c	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_log.c	2004-12-15 23:00:37.000000000 +0100
@@ -377,7 +377,7 @@ xfs_log_release_iclog(xfs_mount_t *mp,
 
 	if (xlog_state_release_iclog(log, iclog)) {
 		xfs_force_shutdown(mp, XFS_LOG_IO_ERROR);
-		return(EIO);
+		return EIO;
 	}
 
 	return 0;
@@ -534,7 +534,7 @@ xfs_log_unmount(xfs_mount_t *mp)
 
 	error = xfs_log_unmount_write(mp);
 	xfs_log_unmount_dealloc(mp);
-	return (error);
+	return error;
 }
 
 /*
@@ -716,7 +716,7 @@ xfs_log_write(xfs_mount_t *	mp,
 	if ((error = xlog_write(mp, reg, nentries, tic, start_lsn, NULL, 0))) {
 		xfs_force_shutdown(mp, XFS_LOG_IO_ERROR);
 	}
-	return (error);
+	return error;
 }	/* xfs_log_write */
 
 
@@ -829,7 +829,7 @@ xfs_log_need_covered(xfs_mount_t *mp)
 		needed = 1;
 	}
 	LOG_UNLOCK(log, s);
-	return(needed);
+	return needed;
 }
 
 /******************************************************************************
@@ -1001,7 +1001,7 @@ xlog_bdstrat_cb(struct xfs_buf *bp)
 	XFS_BUF_ERROR(bp, EIO);
 	XFS_BUF_STALE(bp);
 	xfs_biodone(bp);
-	return (XFS_ERROR(EIO));
+	return XFS_ERROR(EIO);
 
 
 }
@@ -1283,7 +1283,7 @@ xlog_commit_record(xfs_mount_t  *mp,
 			       iclog, XLOG_COMMIT_TRANS))) {
 		xfs_force_shutdown(mp, XFS_LOG_IO_ERROR);
 	}
-	return (error);
+	return error;
 }	/* xlog_commit_record */
 
 
@@ -1468,7 +1468,7 @@ xlog_sync(xlog_t		*log,
 	if ((error = XFS_bwrite(bp))) {
 		xfs_ioerror_alert("xlog_sync", log->l_mp, bp,
 				  XFS_BUF_ADDR(bp));
-		return (error);
+		return error;
 	}
 	if (split) {
 		bp		= iclog->ic_log->l_xbuf;
@@ -1506,10 +1506,10 @@ xlog_sync(xlog_t		*log,
 		if ((error = XFS_bwrite(bp))) {
 			xfs_ioerror_alert("xlog_sync (split)", log->l_mp,
 					  bp, XFS_BUF_ADDR(bp));
-			return (error);
+			return error;
 		}
 	}
-	return (0);
+	return 0;
 }	/* xlog_sync */
 
 
@@ -1694,7 +1694,7 @@ xlog_write(xfs_mount_t *	mp,
     for (index = 0; index < nentries; ) {
 	if ((error = xlog_state_get_iclog_space(log, len, &iclog, ticket,
 					       &contwr, &log_offset)))
-		return (error);
+		return error;
 
 	ASSERT(log_offset <= iclog->ic_size - 1);
 	ptr = (__psint_t) ((char *)iclog->ic_datap+log_offset);
@@ -1798,7 +1798,7 @@ xlog_write(xfs_mount_t *	mp,
 		    xlog_state_finish_copy(log, iclog, record_cnt, data_cnt);
 		    record_cnt = data_cnt = 0;
 		    if ((error = xlog_state_release_iclog(log, iclog)))
-			    return (error);
+			    return error;
 		    break;			/* don't increment index */
 	    } else {				/* copied entire region */
 		index++;
@@ -1812,7 +1812,7 @@ xlog_write(xfs_mount_t *	mp,
 			ASSERT(flags & XLOG_COMMIT_TRANS);
 			*commit_iclog = iclog;
 		    } else if ((error = xlog_state_release_iclog(log, iclog)))
-			   return (error);
+			   return error;
 		    if (index == nentries)
 			    return 0;		/* we are done */
 		    else
@@ -1829,7 +1829,7 @@ xlog_write(xfs_mount_t *	mp,
 	*commit_iclog = iclog;
 	return 0;
     }
-    return (xlog_state_release_iclog(log, iclog));
+    return xlog_state_release_iclog(log, iclog);
 }	/* xlog_write */
 
 
@@ -1945,7 +1945,7 @@ xlog_get_lowest_lsn(
 	    }
 	    lsn_log = lsn_log->ic_next;
 	} while (lsn_log != log->l_iclog);
-	return(lowest_lsn);
+	return lowest_lsn;
 }
 
 
@@ -2301,7 +2301,7 @@ restart:
 		if (iclog->ic_refcnt == 1) {
 			LOG_UNLOCK(log, s);
 			if ((error = xlog_state_release_iclog(log, iclog)))
-				return (error);
+				return error;
 		} else {
 			iclog->ic_refcnt--;
 			LOG_UNLOCK(log, s);
@@ -2468,7 +2468,7 @@ xlog_regrant_write_log_space(xlog_t	   *
 	tic->t_curr_res = tic->t_unit_res;
 
 	if (tic->t_cnt > 0)
-		return (0);
+		return 0;
 
 #ifdef DEBUG
 	if (log->l_flags & XLOG_ACTIVE_RECOVERY)
@@ -2565,7 +2565,7 @@ redo:
 	xlog_trace_loggrant(log, tic, "xlog_regrant_write_log_space: exit");
 	xlog_verify_grant_head(log, 1);
 	GRANT_UNLOCK(log, s);
-	return (0);
+	return 0;
 
 
  error_return:
@@ -2736,7 +2736,7 @@ xlog_state_release_iclog(xlog_t		*log,
 	if (sync) {
 		return xlog_sync(log, iclog);
 	}
-	return (0);
+	return 0;
 
 }	/* xlog_state_release_iclog */
 
@@ -3021,7 +3021,7 @@ try_again:
     } while (iclog != log->l_iclog);
 
     LOG_UNLOCK(log, s);
-    return (0);
+    return 0;
 }	/* xlog_state_sync */
 
 
@@ -3406,12 +3406,12 @@ xlog_state_ioerror(
 			ic->ic_state = XLOG_STATE_IOERROR;
 			ic = ic->ic_next;
 		} while (ic != iclog);
-		return (0);
+		return 0;
 	}
 	/*
 	 * Return non-zero, if state transition has already happened.
 	 */
-	return (1);
+	return 1;
 }
 
 /*
@@ -3447,7 +3447,7 @@ xfs_log_force_umount(
 	    log->l_flags & XLOG_ACTIVE_RECOVERY) {
 		mp->m_flags |= XFS_MOUNT_FS_SHUTDOWN;
 		XFS_BUF_DONE(mp->m_sb_bp);
-		return (0);
+		return 0;
 	}
 
 	/*
@@ -3456,7 +3456,7 @@ xfs_log_force_umount(
 	 */
 	if (logerror && log->l_iclog->ic_state & XLOG_STATE_IOERROR) {
 		ASSERT(XLOG_FORCED_SHUTDOWN(log));
-		return (1);
+		return 1;
 	}
 	retval = 0;
 	/*
@@ -3538,7 +3538,7 @@ xfs_log_force_umount(
 	}
 #endif
 	/* return non-zero if log IOERROR transition had already happened */
-	return (retval);
+	return retval;
 }
 
 int
@@ -3552,8 +3552,8 @@ xlog_iclogs_empty(xlog_t *log)
 		 * any language.
 		 */
 		if (iclog->ic_header.h_num_logops)
-			return(0);
+			return 0;
 		iclog = iclog->ic_next;
 	} while (iclog != log->l_iclog);
-	return(1);
+	return 1;
 }




