Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbULPAmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbULPAmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbULPAdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:33:20 -0500
Received: from mail.dif.dk ([193.138.115.101]:6820 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262554AbULPAQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:16:07 -0500
Date: Thu, 16 Dec 2004 01:26:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 14/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_attr.c
Message-ID: <Pine.LNX.4.61.0412160125030.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_attr.c
 
Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_attr.c	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_attr.c	2004-12-15 23:15:10.000000000 +0100
@@ -124,11 +124,11 @@ xfs_attr_fetch(xfs_inode_t *ip, char *na
 	if ((XFS_IFORK_Q(ip) == 0) ||
 	    (ip->i_d.di_aformat == XFS_DINODE_FMT_EXTENTS &&
 	     ip->i_d.di_anextents == 0))
-		return(ENOATTR);
+		return ENOATTR;
 
 	if (!(flags & (ATTR_KERNACCESS|ATTR_SECURE))) {
 		if ((error = xfs_iaccess(ip, S_IRUSR, cred)))
-			return(XFS_ERROR(error));
+			return XFS_ERROR(error);
 	}
 
 	/*
@@ -166,7 +166,7 @@ xfs_attr_fetch(xfs_inode_t *ip, char *na
 
 	if (error == EEXIST)
 		error = 0;
-	return(error);
+	return error;
 }
 
 int
@@ -179,18 +179,18 @@ xfs_attr_get(bhv_desc_t *bdp, char *name
 	XFS_STATS_INC(xs_attr_get);
 
 	if (!name)
-		return(EINVAL);
+		return EINVAL;
 	namelen = strlen(name);
 	if (namelen >= MAXNAMELEN)
-		return(EFAULT);		/* match IRIX behaviour */
+		return EFAULT;		/* match IRIX behaviour */
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
-		return(EIO);
+		return EIO;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	error = xfs_attr_fetch(ip, name, namelen, value, valuelenp, flags, cred);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
-	return(error);
+	return error;
 }
 
 /*ARGSUSED*/
@@ -218,13 +218,13 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 	dp = XFS_BHVTOI(bdp);
 	mp = dp->i_mount;
 	if (XFS_FORCED_SHUTDOWN(mp))
-		return (EIO);
+		return EIO;
 
 	xfs_ilock(dp, XFS_ILOCK_SHARED);
 	if (!(flags & ATTR_SECURE) &&
 	     (error = xfs_iaccess(dp, S_IWUSR, cred))) {
 		xfs_iunlock(dp, XFS_ILOCK_SHARED);
-		return(XFS_ERROR(error));
+		return XFS_ERROR(error);
 	}
 	xfs_iunlock(dp, XFS_ILOCK_SHARED);
 
@@ -232,7 +232,7 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 	 * Attach the dquots to the inode.
 	 */
 	if ((error = XFS_QM_DQATTACH(mp, dp, 0)))
-		return (error);
+		return error;
 
 	/*
 	 * If the inode doesn't have an attribute fork, add one.
@@ -241,7 +241,7 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 	if (XFS_IFORK_Q(dp) == 0) {
 		error = xfs_bmap_add_attrfork(dp, rsvd);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	/*
@@ -308,7 +308,7 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 				      0, XFS_TRANS_PERM_LOG_RES,
 				      XFS_ATTRSET_LOG_COUNT))) {
 		xfs_trans_cancel(args.trans, 0);
-		return(error);
+		return error;
 	}
 	xfs_ilock(dp, XFS_ILOCK_EXCL);
 
@@ -318,7 +318,7 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 	if (error) {
 		xfs_iunlock(dp, XFS_ILOCK_EXCL);
 		xfs_trans_cancel(args.trans, XFS_TRANS_RELEASE_LOG_RES);
-		return (error);
+		return error;
 	}
 
 	xfs_trans_ijoin(args.trans, dp, XFS_ILOCK_EXCL);
@@ -369,7 +369,7 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 			if (!error && (flags & ATTR_KERNOTIME) == 0) {
 				xfs_ichgtime(dp, XFS_ICHGTIME_CHG);
 			}
-			return(error == 0 ? err2 : error);
+			return error == 0 ? err2 : error;
 		}
 
 		/*
@@ -439,14 +439,14 @@ xfs_attr_set(bhv_desc_t *bdp, char *name
 		xfs_ichgtime(dp, XFS_ICHGTIME_CHG);
 	}
 
-	return(error);
+	return error;
 
 out:
 	if (args.trans)
 		xfs_trans_cancel(args.trans,
 			XFS_TRANS_RELEASE_LOG_RES|XFS_TRANS_ABORT);
 	xfs_iunlock(dp, XFS_ILOCK_EXCL);
-	return(error);
+	return error;
 }
 
 /*
@@ -475,18 +475,18 @@ xfs_attr_remove(bhv_desc_t *bdp, char *n
 	dp = XFS_BHVTOI(bdp);
 	mp = dp->i_mount;
 	if (XFS_FORCED_SHUTDOWN(mp))
-		return (EIO);
+		return EIO;
 
 	xfs_ilock(dp, XFS_ILOCK_SHARED);
 	if (!(flags & ATTR_SECURE) &&
 	     (error = xfs_iaccess(dp, S_IWUSR, cred))) {
 		xfs_iunlock(dp, XFS_ILOCK_SHARED);
-		return(XFS_ERROR(error));
+		return XFS_ERROR(error);
 	} else if (XFS_IFORK_Q(dp) == 0 ||
 		   (dp->i_d.di_aformat == XFS_DINODE_FMT_EXTENTS &&
 		    dp->i_d.di_anextents == 0)) {
 		xfs_iunlock(dp, XFS_ILOCK_SHARED);
-		return(XFS_ERROR(ENOATTR));
+		return XFS_ERROR(ENOATTR);
 	}
 	xfs_iunlock(dp, XFS_ILOCK_SHARED);
 
@@ -508,7 +508,7 @@ xfs_attr_remove(bhv_desc_t *bdp, char *n
 	 * Attach the dquots to the inode.
 	 */
 	if ((error = XFS_QM_DQATTACH(mp, dp, 0)))
-		return (error);
+		return error;
 
 	/*
 	 * Start our first transaction of the day.
@@ -536,7 +536,7 @@ xfs_attr_remove(bhv_desc_t *bdp, char *n
 				      0, XFS_TRANS_PERM_LOG_RES,
 				      XFS_ATTRRM_LOG_COUNT))) {
 		xfs_trans_cancel(args.trans, 0);
-		return(error);
+		return error;
 
 	}
 
@@ -595,14 +595,14 @@ xfs_attr_remove(bhv_desc_t *bdp, char *n
 		xfs_ichgtime(dp, XFS_ICHGTIME_CHG);
 	}
 
-	return(error);
+	return error;
 
 out:
 	if (args.trans)
 		xfs_trans_cancel(args.trans,
 			XFS_TRANS_RELEASE_LOG_RES|XFS_TRANS_ABORT);
 	xfs_iunlock(dp, XFS_ILOCK_EXCL);
-	return(error);
+	return error;
 }
 
 /*
@@ -626,16 +626,16 @@ xfs_attr_list(bhv_desc_t *bdp, char *buf
 	 * Validate the cursor.
 	 */
 	if (cursor->pad1 || cursor->pad2)
-		return(XFS_ERROR(EINVAL));
+		return XFS_ERROR(EINVAL);
 	if ((cursor->initted == 0) &&
 	    (cursor->hashval || cursor->blkno || cursor->offset))
-		return(XFS_ERROR(EINVAL));
+		return XFS_ERROR(EINVAL);
 
 	/*
 	 * Check for a properly aligned buffer.
 	 */
 	if (((long)buffer) & (sizeof(int)-1))
-		return(XFS_ERROR(EFAULT));
+		return XFS_ERROR(EFAULT);
 	if (flags & ATTR_KERNOVAL)
 		bufsize = 0;
 
@@ -663,13 +663,13 @@ xfs_attr_list(bhv_desc_t *bdp, char *buf
 	}
 
 	if (XFS_FORCED_SHUTDOWN(dp->i_mount))
-		return (EIO);
+		return EIO;
 
 	xfs_ilock(dp, XFS_ILOCK_SHARED);
 	if (!(flags & ATTR_SECURE) &&
 	     (error = xfs_iaccess(dp, S_IRUSR, cred))) {
 		xfs_iunlock(dp, XFS_ILOCK_SHARED);
-		return(XFS_ERROR(error));
+		return XFS_ERROR(error);
 	}
 
 	/*
@@ -700,7 +700,7 @@ xfs_attr_list(bhv_desc_t *bdp, char *buf
 			error = -context.count;
 	}
 
-	return(error);
+	return error;
 }
 
 int								/* error */
@@ -719,7 +719,7 @@ xfs_attr_inactive(xfs_inode_t *dp)
 	    (dp->i_d.di_aformat == XFS_DINODE_FMT_EXTENTS &&
 	     dp->i_d.di_anextents == 0)) {
 		xfs_iunlock(dp, XFS_ILOCK_SHARED);
-		return(0);
+		return 0;
 	}
 	xfs_iunlock(dp, XFS_ILOCK_SHARED);
 
@@ -738,7 +738,7 @@ xfs_attr_inactive(xfs_inode_t *dp)
 				      XFS_TRANS_PERM_LOG_RES,
 				      XFS_ATTRINVAL_LOG_COUNT))) {
 		xfs_trans_cancel(trans, 0);
-		return(error);
+		return error;
 	}
 	xfs_ilock(dp, XFS_ILOCK_EXCL);
 
@@ -783,12 +783,12 @@ xfs_attr_inactive(xfs_inode_t *dp)
 				 NULL);
 	xfs_iunlock(dp, XFS_ILOCK_EXCL);
 
-	return(error);
+	return error;
 
 out:
 	xfs_trans_cancel(trans, XFS_TRANS_RELEASE_LOG_RES|XFS_TRANS_ABORT);
 	xfs_iunlock(dp, XFS_ILOCK_EXCL);
-	return(error);
+	return error;
 }
 
 
@@ -808,10 +808,10 @@ xfs_attr_shortform_addname(xfs_da_args_t
 
 	retval = xfs_attr_shortform_lookup(args);
 	if ((args->flags & ATTR_REPLACE) && (retval == ENOATTR)) {
-		return(retval);
+		return retval;
 	} else if (retval == EEXIST) {
 		if (args->flags & ATTR_CREATE)
-			return(retval);
+			return retval;
 		retval = xfs_attr_shortform_remove(args);
 		ASSERT(retval == 0);
 	}
@@ -824,9 +824,9 @@ xfs_attr_shortform_addname(xfs_da_args_t
 		retval = xfs_attr_shortform_add(args);
 		ASSERT(retval == 0);
 	} else {
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 	}
-	return(0);
+	return 0;
 }
 
 
@@ -855,7 +855,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 	error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1, &bp,
 					     XFS_ATTR_FORK);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 
 	/*
@@ -865,11 +865,11 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 	retval = xfs_attr_leaf_lookup_int(bp, args);
 	if ((args->flags & ATTR_REPLACE) && (retval == ENOATTR)) {
 		xfs_da_brelse(args->trans, bp);
-		return(retval);
+		return retval;
 	} else if (retval == EEXIST) {
 		if (args->flags & ATTR_CREATE) {	/* pure create op */
 			xfs_da_brelse(args->trans, bp);
-			return(retval);
+			return retval;
 		}
 		args->rename = 1;			/* an atomic rename */
 		args->blkno2 = args->blkno;		/* set 2nd entry info*/
@@ -900,7 +900,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 			ASSERT(committed);
 			args->trans = NULL;
 			xfs_bmap_cancel(args->flist);
-			return(error);
+			return error;
 		}
 
 		/*
@@ -917,13 +917,13 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 		 * a new one.
 		 */
 		if ((error = xfs_attr_rolltrans(&args->trans, dp)))
-			return (error);
+			return error;
 
 		/*
 		 * Fob the whole rest of the problem off on the Btree code.
 		 */
 		error = xfs_attr_node_addname(args);
-		return(error);
+		return error;
 	}
 
 	/*
@@ -931,7 +931,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 	 * later routines can manage their own transactions.
 	 */
 	if ((error = xfs_attr_rolltrans(&args->trans, dp)))
-		return (error);
+		return error;
 
 	/*
 	 * If there was an out-of-line value, allocate the blocks we
@@ -942,7 +942,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 	if (args->rmtblkno > 0) {
 		error = xfs_attr_rmtval_set(args);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	/*
@@ -958,7 +958,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 		 */
 		error = xfs_attr_leaf_flipflags(args);
 		if (error)
-			return(error);
+			return error;
 
 		/*
 		 * Dismantle the "old" attribute/value pair by removing
@@ -971,7 +971,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 		if (args->rmtblkno) {
 			error = xfs_attr_rmtval_remove(args);
 			if (error)
-				return(error);
+				return error;
 		}
 
 		/*
@@ -981,7 +981,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 		error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1,
 						     &bp, XFS_ATTR_FORK);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(bp != NULL);
 		(void)xfs_attr_leaf_remove(bp, args);
 
@@ -1002,7 +1002,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 				ASSERT(committed);
 				args->trans = NULL;
 				xfs_bmap_cancel(args->flist);
-				return(error);
+				return error;
 			}
 
 			/*
@@ -1028,7 +1028,7 @@ xfs_attr_leaf_addname(xfs_da_args_t *arg
 		 */
 		error = xfs_attr_leaf_clearflag(args);
 	}
-	return(error);
+	return error;
 }
 
 /*
@@ -1053,14 +1053,14 @@ xfs_attr_leaf_removename(xfs_da_args_t *
 	error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1, &bp,
 					     XFS_ATTR_FORK);
 	if (error) {
-		return(error);
+		return error;
 	}
 
 	ASSERT(bp != NULL);
 	error = xfs_attr_leaf_lookup_int(bp, args);
 	if (error == ENOATTR) {
 		xfs_da_brelse(args->trans, bp);
-		return(error);
+		return error;
 	}
 
 	(void)xfs_attr_leaf_remove(bp, args);
@@ -1080,7 +1080,7 @@ xfs_attr_leaf_removename(xfs_da_args_t *
 			ASSERT(committed);
 			args->trans = NULL;
 			xfs_bmap_cancel(args->flist);
-			return(error);
+			return error;
 		}
 
 		/*
@@ -1093,7 +1093,7 @@ xfs_attr_leaf_removename(xfs_da_args_t *
 		}
 	} else
 		xfs_da_buf_done(bp);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1112,20 +1112,20 @@ xfs_attr_leaf_get(xfs_da_args_t *args)
 	error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1, &bp,
 					     XFS_ATTR_FORK);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 
 	error = xfs_attr_leaf_lookup_int(bp, args);
 	if (error != EEXIST)  {
 		xfs_da_brelse(args->trans, bp);
-		return(error);
+		return error;
 	}
 	error = xfs_attr_leaf_getvalue(bp, args);
 	xfs_da_brelse(args->trans, bp);
 	if (!error && (args->rmtblkno > 0) && !(args->flags & ATTR_KERNOVAL)) {
 		error = xfs_attr_rmtval_get(args);
 	}
-	return(error);
+	return error;
 }
 
 /*
@@ -1141,7 +1141,7 @@ xfs_attr_leaf_list(xfs_attr_list_context
 	context->cursor->blkno = 0;
 	error = xfs_da_read_buf(NULL, context->dp, 0, -1, &bp, XFS_ATTR_FORK);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 	leaf = bp->data;
 	if (unlikely(INT_GET(leaf->hdr.info.magic, ARCH_CONVERT)
@@ -1149,12 +1149,12 @@ xfs_attr_leaf_list(xfs_attr_list_context
 		XFS_CORRUPTION_ERROR("xfs_attr_leaf_list", XFS_ERRLEVEL_LOW,
 				     context->dp->i_mount, leaf);
 		xfs_da_brelse(NULL, bp);
-		return(XFS_ERROR(EFSCORRUPTED));
+		return XFS_ERROR(EFSCORRUPTED);
 	}
 
 	(void)xfs_attr_leaf_list_int(bp, context);
 	xfs_da_brelse(NULL, bp);
-	return(0);
+	return 0;
 }
 
 
@@ -1317,7 +1317,7 @@ restart:
 	if (args->rmtblkno > 0) {
 		error = xfs_attr_rmtval_set(args);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	/*
@@ -1346,7 +1346,7 @@ restart:
 		if (args->rmtblkno) {
 			error = xfs_attr_rmtval_remove(args);
 			if (error)
-				return(error);
+				return error;
 		}
 
 		/*
@@ -1423,8 +1423,8 @@ out:
 	if (state)
 		xfs_da_state_free(state);
 	if (error)
-		return(error);
-	return(retval);
+		return error;
+	return retval;
 }
 
 /*
@@ -1595,7 +1595,7 @@ xfs_attr_node_removename(xfs_da_args_t *
 
 out:
 	xfs_da_state_free(state);
-	return(error);
+	return error;
 }
 
 /*
@@ -1643,7 +1643,7 @@ xfs_attr_fillstate(xfs_da_state_t *state
 		}
 	}
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -1672,7 +1672,7 @@ xfs_attr_refillstate(xfs_da_state_t *sta
 						blk->blkno, blk->disk_blkno,
 						&blk->bp, XFS_ATTR_FORK);
 			if (error)
-				return(error);
+				return error;
 		} else {
 			blk->bp = NULL;
 		}
@@ -1691,13 +1691,13 @@ xfs_attr_refillstate(xfs_da_state_t *sta
 						blk->blkno, blk->disk_blkno,
 						&blk->bp, XFS_ATTR_FORK);
 			if (error)
-				return(error);
+				return error;
 		} else {
 			blk->bp = NULL;
 		}
 	}
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -1751,7 +1751,7 @@ xfs_attr_node_get(xfs_da_args_t *args)
 	}
 
 	xfs_da_state_free(state);
-	return(retval);
+	return retval;
 }
 
 STATIC int							/* error */
@@ -1777,7 +1777,7 @@ xfs_attr_node_list(xfs_attr_list_context
 		error = xfs_da_read_buf(NULL, context->dp, cursor->blkno, -1,
 					      &bp, XFS_ATTR_FORK);
 		if ((error != 0) && (error != EFSCORRUPTED))
-			return(error);
+			return error;
 		if (bp) {
 			node = bp->data;
 			switch (INT_GET(node->hdr.info.magic, ARCH_CONVERT)) {
@@ -1826,12 +1826,12 @@ xfs_attr_node_list(xfs_attr_list_context
 						      cursor->blkno, -1, &bp,
 						      XFS_ATTR_FORK);
 			if (error)
-				return(error);
+				return error;
 			if (unlikely(bp == NULL)) {
 				XFS_ERROR_REPORT("xfs_attr_node_list(2)",
 						 XFS_ERRLEVEL_LOW,
 						 context->dp->i_mount);
-				return(XFS_ERROR(EFSCORRUPTED));
+				return XFS_ERROR(EFSCORRUPTED);
 			}
 			node = bp->data;
 			if (INT_GET(node->hdr.info.magic, ARCH_CONVERT)
@@ -1844,7 +1844,7 @@ xfs_attr_node_list(xfs_attr_list_context
 						     context->dp->i_mount,
 						     node);
 				xfs_da_brelse(NULL, bp);
-				return(XFS_ERROR(EFSCORRUPTED));
+				return XFS_ERROR(EFSCORRUPTED);
 			}
 			btree = node->btree;
 			for (i = 0;
@@ -1861,7 +1861,7 @@ xfs_attr_node_list(xfs_attr_list_context
 			}
 			if (i == INT_GET(node->hdr.count, ARCH_CONVERT)) {
 				xfs_da_brelse(NULL, bp);
-				return(0);
+				return 0;
 			}
 			xfs_da_brelse(NULL, bp);
 		}
@@ -1881,7 +1881,7 @@ xfs_attr_node_list(xfs_attr_list_context
 					     XFS_ERRLEVEL_LOW,
 					     context->dp->i_mount, leaf);
 			xfs_da_brelse(NULL, bp);
-			return(XFS_ERROR(EFSCORRUPTED));
+			return XFS_ERROR(EFSCORRUPTED);
 		}
 		error = xfs_attr_leaf_list_int(bp, context);
 		if (error || (INT_ISZERO(leaf->hdr.info.forw, ARCH_CONVERT)))
@@ -1891,16 +1891,16 @@ xfs_attr_node_list(xfs_attr_list_context
 		error = xfs_da_read_buf(NULL, context->dp, cursor->blkno, -1,
 					      &bp, XFS_ATTR_FORK);
 		if (error)
-			return(error);
+			return error;
 		if (unlikely((bp == NULL))) {
 			XFS_ERROR_REPORT("xfs_attr_node_list(5)",
 					 XFS_ERRLEVEL_LOW,
 					 context->dp->i_mount);
-			return(XFS_ERROR(EFSCORRUPTED));
+			return XFS_ERROR(EFSCORRUPTED);
 		}
 	}
 	xfs_da_brelse(NULL, bp);
-	return(0);
+	return 0;
 }
 
 
@@ -1936,7 +1936,7 @@ xfs_attr_rmtval_get(xfs_da_args_t *args)
 				  XFS_BMAPI_ATTRFORK | XFS_BMAPI_METADATA,
 				  NULL, 0, map, &nmap, NULL);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(nmap >= 1);
 
 		for (i = 0; (i < nmap) && (valuelen > 0); i++) {
@@ -1947,7 +1947,7 @@ xfs_attr_rmtval_get(xfs_da_args_t *args)
 			error = xfs_read_buf(mp, mp->m_ddev_targp, dblkno,
 					     blkcnt, XFS_BUF_LOCK, &bp);
 			if (error)
-				return(error);
+				return error;
 
 			tmp = (valuelen < XFS_BUF_SIZE(bp))
 				? valuelen : XFS_BUF_SIZE(bp);
@@ -1960,7 +1960,7 @@ xfs_attr_rmtval_get(xfs_da_args_t *args)
 		}
 	}
 	ASSERT(valuelen == 0);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1993,7 +1993,7 @@ xfs_attr_rmtval_set(xfs_da_args_t *args)
 	error = xfs_bmap_first_unused(args->trans, args->dp, blkcnt, &lfileoff,
 						   XFS_ATTR_FORK);
 	if (error) {
-		return(error);
+		return error;
 	}
 	args->rmtblkno = lblkno = (xfs_dablk_t)lfileoff;
 	args->rmtblkcnt = blkcnt;
@@ -2021,7 +2021,7 @@ xfs_attr_rmtval_set(xfs_da_args_t *args)
 			ASSERT(committed);
 			args->trans = NULL;
 			xfs_bmap_cancel(args->flist);
-			return(error);
+			return error;
 		}
 
 		/*
@@ -2043,7 +2043,7 @@ xfs_attr_rmtval_set(xfs_da_args_t *args)
 		 * Start the next trans in the chain.
 		 */
 		if ((error = xfs_attr_rolltrans(&args->trans, dp)))
-			return (error);
+			return error;
 	}
 
 	/*
@@ -2065,7 +2065,7 @@ xfs_attr_rmtval_set(xfs_da_args_t *args)
 				  XFS_BMAPI_ATTRFORK | XFS_BMAPI_METADATA,
 				  args->firstblock, 0, &map, &nmap, NULL);
 		if (error) {
-			return(error);
+			return error;
 		}
 		ASSERT(nmap == 1);
 		ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
@@ -2085,7 +2085,7 @@ xfs_attr_rmtval_set(xfs_da_args_t *args)
 		if (tmp < XFS_BUF_SIZE(bp))
 			xfs_biozero(bp, tmp, XFS_BUF_SIZE(bp) - tmp);
 		if ((error = xfs_bwrite(mp, bp))) {/* GROT: NOTE: synchronous write */
-			return (error);
+			return error;
 		}
 		src += tmp;
 		valuelen -= tmp;
@@ -2093,7 +2093,7 @@ xfs_attr_rmtval_set(xfs_da_args_t *args)
 		lblkno += map.br_blockcount;
 	}
 	ASSERT(valuelen == 0);
-	return(0);
+	return 0;
 }
 
 /*
@@ -2130,7 +2130,7 @@ xfs_attr_rmtval_remove(xfs_da_args_t *ar
 					args->firstblock, 0, &map, &nmap,
 					args->flist);
 		if (error) {
-			return(error);
+			return error;
 		}
 		ASSERT(nmap == 1);
 		ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
@@ -2175,7 +2175,7 @@ xfs_attr_rmtval_remove(xfs_da_args_t *ar
 			ASSERT(committed);
 			args->trans = NULL;
 			xfs_bmap_cancel(args->flist);
-			return(error);
+			return error;
 		}
 
 		/*
@@ -2191,9 +2191,9 @@ xfs_attr_rmtval_remove(xfs_da_args_t *ar
 		 * Close out trans and start the next one in the chain.
 		 */
 		if ((error = xfs_attr_rolltrans(&args->trans, args->dp)))
-			return (error);
+			return error;
 	}
-	return(0);
+	return 0;
 }
 
 #if defined(XFS_ATTR_TRACE)


