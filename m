Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbULPA1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbULPA1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbULPAZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:25:57 -0500
Received: from mail.dif.dk ([193.138.115.101]:52131 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262545AbULPAL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:11:58 -0500
Date: Thu, 16 Dec 2004 01:22:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 11/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_dir.c
Message-ID: <Pine.LNX.4.61.0412160121240.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_dir.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_dir.c	2004-10-18 23:53:43.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_dir.c	2004-12-15 22:54:16.000000000 +0100
@@ -218,11 +218,11 @@ xfs_dir_isempty(xfs_inode_t *dp)
 
 	ASSERT((dp->i_d.di_mode & S_IFMT) == S_IFDIR);
 	if (dp->i_d.di_size == 0)
-		return(1);
+		return 1;
 	if (dp->i_d.di_size > XFS_IFORK_DSIZE(dp))
-		return(0);
+		return 0;
 	hdr = (xfs_dir_sf_hdr_t *)dp->i_df.if_u1.if_data;
-	return(hdr->count == 0);
+	return (hdr->count == 0);
 }
 
 /*
@@ -242,7 +242,7 @@ xfs_dir_init(xfs_trans_t *trans, xfs_ino
 	if ((error = xfs_dir_ino_validate(trans->t_mountp, parent_dir->i_ino)))
 		return error;
 
-	return(xfs_dir_shortform_create(&args, parent_dir->i_ino));
+	return xfs_dir_shortform_create(&args, parent_dir->i_ino);
 }
 
 /*
@@ -260,7 +260,7 @@ xfs_dir_createname(xfs_trans_t *trans, x
 	ASSERT((dp->i_d.di_mode & S_IFMT) == S_IFDIR);
 
 	if ((retval = xfs_dir_ino_validate(trans->t_mountp, inum)))
-		return (retval);
+		return retval;
 
 	XFS_STATS_INC(xs_dir_create);
 	/*
@@ -308,7 +308,7 @@ xfs_dir_createname(xfs_trans_t *trans, x
 	if (!done) {
 		retval = xfs_dir_node_addname(&args);
 	}
-	return(retval);
+	return retval;
 }
 
 /*
@@ -351,7 +351,7 @@ xfs_dir_canenter(xfs_trans_t *trans, xfs
 	} else {
 		retval = xfs_dir_node_addname(&args);
 	}
-	return(retval);
+	return retval;
 }
 
 /*
@@ -399,7 +399,7 @@ xfs_dir_removename(xfs_trans_t *trans, x
 	} else {
 		retval = xfs_dir_node_removename(&args);
 	}
-	return(retval);
+	return retval;
 }
 
 static int							/* error */
@@ -441,7 +441,7 @@ xfs_dir_lookup(xfs_trans_t *trans, xfs_i
 	if (retval == EEXIST)
 		retval = 0;
 	*inum = args.inumber;
-	return(retval);
+	return retval;
 }
 
 /*
@@ -488,7 +488,7 @@ xfs_dir_getdents(xfs_trans_t *trans, xfs
 	if (dbp != NULL)
 		kmem_free(dbp, sizeof(*dbp) + MAXNAMELEN);
 
-	return(retval);
+	return retval;
 }
 
 static int							/* error */
@@ -530,7 +530,7 @@ xfs_dir_replace(xfs_trans_t *trans, xfs_
 		retval = xfs_dir_node_replace(&args);
 	}
 
-	return(retval);
+	return retval;
 }
 
 static int
@@ -565,7 +565,7 @@ xfs_dir_shortform_validate_ondisk(xfs_mo
 	if ((count < 0) || ((count * 10) > XFS_LITINO(mp))) {
 		xfs_fs_cmn_err(CE_WARN, mp,
 			"Invalid shortform count: dp 0x%p", dp);
-		return(1);
+		return 1;
 	}
 
 	if (count == 0) {
@@ -611,14 +611,14 @@ xfs_dir_leaf_addname(xfs_da_args_t *args
 	retval = xfs_da_read_buf(args->trans, args->dp, 0, -1, &bp,
 					      XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 
 	retval = xfs_dir_leaf_lookup_int(bp, args, &index);
 	if (retval == ENOENT)
 		retval = xfs_dir_leaf_add(bp, args, index);
 	xfs_da_buf_done(bp);
-	return(retval);
+	return retval;
 }
 
 /*
@@ -635,7 +635,7 @@ xfs_dir_leaf_removename(xfs_da_args_t *a
 	retval = xfs_da_read_buf(args->trans, args->dp, 0, -1, &bp,
 					      XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 	leaf = bp->data;
 	ASSERT(INT_GET(leaf->hdr.info.magic, ARCH_CONVERT) == XFS_DIR_LEAF_MAGIC);
@@ -647,7 +647,7 @@ xfs_dir_leaf_removename(xfs_da_args_t *a
 		retval = 0;
 	}
 	xfs_da_buf_done(bp);
-	return(retval);
+	return retval;
 }
 
 /*
@@ -663,11 +663,11 @@ xfs_dir_leaf_lookup(xfs_da_args_t *args)
 	retval = xfs_da_read_buf(args->trans, args->dp, 0, -1, &bp,
 					      XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 	retval = xfs_dir_leaf_lookup_int(bp, args, &index);
 	xfs_da_brelse(args->trans, bp);
-	return(retval);
+	return retval;
 }
 
 /*
@@ -682,12 +682,12 @@ xfs_dir_leaf_getdents(xfs_trans_t *trans
 
 	retval = xfs_da_read_buf(dp->i_transp, dp, 0, -1, &bp, XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 	retval = xfs_dir_leaf_getdents_int(bp, dp, 0, uio, &eob, dbp, put, -1);
 	xfs_da_brelse(trans, bp);
 	*eofp = (eob == 0);
-	return(retval);
+	return retval;
 }
 
 /*
@@ -708,7 +708,7 @@ xfs_dir_leaf_replace(xfs_da_args_t *args
 	retval = xfs_da_read_buf(args->trans, args->dp, 0, -1, &bp,
 					      XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 	retval = xfs_dir_leaf_lookup_int(bp, args, &index);
 	if (retval == EEXIST) {
@@ -723,7 +723,7 @@ xfs_dir_leaf_replace(xfs_da_args_t *args
 		retval = 0;
 	} else
 		xfs_da_brelse(args->trans, bp);
-	return(retval);
+	return retval;
 }
 
 
@@ -785,7 +785,7 @@ xfs_dir_node_addname(xfs_da_args_t *args
 error:
 	xfs_da_state_free(state);
 
-	return(retval);
+	return retval;
 }
 
 /*
@@ -816,7 +816,7 @@ xfs_dir_node_removename(xfs_da_args_t *a
 		retval = error;
 	if (retval != EEXIST) {
 		xfs_da_state_free(state);
-		return(retval);
+		return retval;
 	}
 
 	/*
@@ -837,8 +837,8 @@ xfs_dir_node_removename(xfs_da_args_t *a
 
 	xfs_da_state_free(state);
 	if (error)
-		return(error);
-	return(0);
+		return error;
+	return 0;
 }
 
 /*
@@ -875,7 +875,7 @@ xfs_dir_node_lookup(xfs_da_args_t *args)
 	}
 
 	xfs_da_state_free(state);
-	return(retval);
+	return retval;
 }
 
 STATIC int
@@ -913,7 +913,7 @@ xfs_dir_node_getdents(xfs_trans_t *trans
 	if (bno > 0) {
 		error = xfs_da_read_buf(trans, dp, bno, -2, &bp, XFS_DATA_FORK);
 		if ((error != 0) && (error != EFSCORRUPTED))
-			return(error);
+			return error;
 		if (bp)
 			leaf = bp->data;
 		if (bp && INT_GET(leaf->hdr.info.magic, ARCH_CONVERT) != XFS_DIR_LEAF_MAGIC) {
@@ -949,9 +949,9 @@ xfs_dir_node_getdents(xfs_trans_t *trans
 			error = xfs_da_read_buf(trans, dp, bno, -1, &bp,
 						       XFS_DATA_FORK);
 			if (error)
-				return(error);
+				return error;
 			if (bp == NULL)
-				return(XFS_ERROR(EFSCORRUPTED));
+				return XFS_ERROR(EFSCORRUPTED);
 			node = bp->data;
 			if (INT_GET(node->hdr.info.magic, ARCH_CONVERT) != XFS_DA_NODE_MAGIC)
 				break;
@@ -970,7 +970,7 @@ xfs_dir_node_getdents(xfs_trans_t *trans
 				uio->uio_offset = XFS_DA_MAKE_COOKIE(mp, 0, 0,
 							     XFS_DA_MAXHASH);
 				*eofp = 1;
-				return(0);
+				return 0;
 			}
 			xfs_dir_trace_g_dub("node: going to block",
 						   dp, uio, bno);
@@ -1006,23 +1006,23 @@ xfs_dir_node_getdents(xfs_trans_t *trans
 		if (eob) {
 			xfs_dir_trace_g_dub("node: E-O-B", dp, uio, bno);
 			*eofp = 0;
-			return(error);
+			return error;
 		}
 		if (bno == 0)
 			break;
 		error = xfs_da_read_buf(trans, dp, bno, nextda, &bp,
 					XFS_DATA_FORK);
 		if (error)
-			return(error);
+			return error;
 		if (unlikely(bp == NULL)) {
 			XFS_ERROR_REPORT("xfs_dir_node_getdents(2)",
 					 XFS_ERRLEVEL_LOW, mp);
-			return(XFS_ERROR(EFSCORRUPTED));
+			return XFS_ERROR(EFSCORRUPTED);
 		}
 	}
 	*eofp = 1;
 	xfs_dir_trace_g_du("node: E-O-F", dp, uio);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1082,7 +1082,7 @@ xfs_dir_node_replace(xfs_da_args_t *args
 	}
 
 	xfs_da_state_free(state);
-	return(retval);
+	return retval;
 }
 
 #if defined(XFS_DIR_TRACE)



