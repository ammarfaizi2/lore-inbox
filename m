Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbULPAIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbULPAIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbULPAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:08:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:31139 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262549AbULPAE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:04:56 -0500
Date: Thu, 16 Dec 2004 01:15:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 6/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_da_btree.c
Message-ID: <Pine.LNX.4.61.0412160114040.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_da_btree.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_da_btree.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_da_btree.c	2004-12-15 22:43:04.000000000 +0100
@@ -134,7 +134,7 @@ xfs_da_node_create(xfs_da_args_t *args, 
 	tp = args->trans;
 	error = xfs_da_get_buf(tp, args->dp, blkno, -1, &bp, whichfork);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 	node = bp->data;
 	INT_ZERO(node->hdr.info.forw, ARCH_CONVERT);
@@ -148,7 +148,7 @@ xfs_da_node_create(xfs_da_args_t *args, 
 		XFS_DA_LOGRANGE(node, &node->hdr, sizeof(node->hdr)));
 
 	*bpp = bp;
-	return(0);
+	return 0;
 }
 
 /*
@@ -188,11 +188,11 @@ xfs_da_split(xfs_da_state_t *state)
 		switch (oldblk->magic) {
 		case XFS_ATTR_LEAF_MAGIC:
 #ifndef __KERNEL__
-			return(ENOTTY);
+			return ENOTTY;
 #else
 			error = xfs_attr_leaf_split(state, oldblk, newblk);
 			if ((error != 0) && (error != ENOSPC)) {
-				return(error);	/* GROT: attr is inconsistent */
+				return error;	/* GROT: attr is inconsistent */
 			}
 			if (!error) {
 				addblk = newblk;
@@ -212,7 +212,7 @@ xfs_da_split(xfs_da_state_t *state)
 							    &state->extrablk);
 			}
 			if (error)
-				return(error);	/* GROT: attr inconsistent */
+				return error;	/* GROT: attr inconsistent */
 			addblk = newblk;
 			break;
 #endif
@@ -220,7 +220,7 @@ xfs_da_split(xfs_da_state_t *state)
 			ASSERT(XFS_DIR_IS_V1(state->mp));
 			error = xfs_dir_leaf_split(state, oldblk, newblk);
 			if ((error != 0) && (error != ENOSPC)) {
-				return(error);	/* GROT: dir is inconsistent */
+				return error;	/* GROT: dir is inconsistent */
 			}
 			if (!error) {
 				addblk = newblk;
@@ -235,14 +235,14 @@ xfs_da_split(xfs_da_state_t *state)
 				error = xfs_dir_leaf_split(state, oldblk,
 							   &state->extrablk);
 				if (error)
-					return(error);	/* GROT: dir incon. */
+					return error;	/* GROT: dir incon. */
 				addblk = newblk;
 			} else {
 				state->extraafter = 1;	/* after newblk */
 				error = xfs_dir_leaf_split(state, newblk,
 							   &state->extrablk);
 				if (error)
-					return(error);	/* GROT: dir incon. */
+					return error;	/* GROT: dir incon. */
 				addblk = newblk;
 			}
 			break;
@@ -259,7 +259,7 @@ xfs_da_split(xfs_da_state_t *state)
 			xfs_da_buf_done(addblk->bp);
 			addblk->bp = NULL;
 			if (error)
-				return(error);	/* GROT: dir is inconsistent */
+				return error;	/* GROT: dir is inconsistent */
 			/*
 			 * Record the newly split block for the next time thru?
 			 */
@@ -283,7 +283,7 @@ xfs_da_split(xfs_da_state_t *state)
 			xfs_da_buf_done(oldblk->bp);
 	}
 	if (!addblk)
-		return(0);
+		return 0;
 
 	/*
 	 * Split the root node.
@@ -295,7 +295,7 @@ xfs_da_split(xfs_da_state_t *state)
 		xfs_da_buf_done(oldblk->bp);
 		xfs_da_buf_done(addblk->bp);
 		addblk->bp = NULL;
-		return(error);	/* GROT: dir is inconsistent */
+		return error;	/* GROT: dir is inconsistent */
 	}
 
 	/*
@@ -336,7 +336,7 @@ xfs_da_split(xfs_da_state_t *state)
 	xfs_da_buf_done(oldblk->bp);
 	xfs_da_buf_done(addblk->bp);
 	addblk->bp = NULL;
-	return(0);
+	return 0;
 }
 
 /*
@@ -366,13 +366,13 @@ xfs_da_root_split(xfs_da_state_t *state,
 	ASSERT(args != NULL);
 	error = xfs_da_grow_inode(args, &blkno);
 	if (error)
-		return(error);
+		return error;
 	dp = args->dp;
 	tp = args->trans;
 	mp = state->mp;
 	error = xfs_da_get_buf(tp, dp, blkno, -1, &bp, args->whichfork);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 	node = bp->data;
 	oldroot = blk1->bp->data;
@@ -400,7 +400,7 @@ xfs_da_root_split(xfs_da_state_t *state,
 		XFS_DIR_IS_V2(mp) ? mp->m_dirleafblk : 0,
 		INT_GET(node->hdr.level, ARCH_CONVERT) + 1, &bp, args->whichfork);
 	if (error)
-		return(error);
+		return error;
 	node = bp->data;
 	INT_SET(node->btree[0].hashval, ARCH_CONVERT, blk1->hashval);
 	INT_SET(node->btree[0].before, ARCH_CONVERT, blk1->blkno);
@@ -423,7 +423,7 @@ xfs_da_root_split(xfs_da_state_t *state,
 			sizeof(xfs_da_node_entry_t) * 2));
 	xfs_da_buf_done(bp);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -458,18 +458,18 @@ xfs_da_node_split(xfs_da_state_t *state,
 		 */
 		error = xfs_da_grow_inode(state->args, &blkno);
 		if (error)
-			return(error);	/* GROT: dir is inconsistent */
+			return error;	/* GROT: dir is inconsistent */
 
 		error = xfs_da_node_create(state->args, blkno, treelevel,
 					   &newblk->bp, state->args->whichfork);
 		if (error)
-			return(error);	/* GROT: dir is inconsistent */
+			return error;	/* GROT: dir is inconsistent */
 		newblk->blkno = blkno;
 		newblk->magic = XFS_DA_NODE_MAGIC;
 		xfs_da_node_rebalance(state, oldblk, newblk);
 		error = xfs_da_blk_link(state, oldblk, newblk);
 		if (error)
-			return(error);
+			return error;
 		*result = 1;
 	} else {
 		*result = 0;
@@ -508,7 +508,7 @@ xfs_da_node_split(xfs_da_state_t *state,
 		}
 	}
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -709,9 +709,9 @@ xfs_da_join(xfs_da_state_t *state)
 			error = xfs_attr_leaf_toosmall(state, &action);
 #endif
 			if (error)
-				return(error);
+				return error;
 			if (action == 0)
-				return(0);
+				return 0;
 #ifdef __KERNEL__
 			xfs_attr_leaf_unbalance(state, drop_blk, save_blk);
 #endif
@@ -720,9 +720,9 @@ xfs_da_join(xfs_da_state_t *state)
 			ASSERT(XFS_DIR_IS_V1(state->mp));
 			error = xfs_dir_leaf_toosmall(state, &action);
 			if (error)
-				return(error);
+				return error;
 			if (action == 0)
-				return(0);
+				return 0;
 			xfs_dir_leaf_unbalance(state, drop_blk, save_blk);
 			break;
 		case XFS_DIR2_LEAFN_MAGIC:
@@ -743,7 +743,7 @@ xfs_da_join(xfs_da_state_t *state)
 			xfs_da_fixhashpath(state, &state->path);
 			error = xfs_da_node_toosmall(state, &action);
 			if (error)
-				return(error);
+				return error;
 			if (action == 0)
 				return 0;
 			xfs_da_node_unbalance(state, drop_blk, save_blk);
@@ -753,12 +753,12 @@ xfs_da_join(xfs_da_state_t *state)
 		error = xfs_da_blk_unlink(state, drop_blk, save_blk);
 		xfs_da_state_kill_altpath(state);
 		if (error)
-			return(error);
+			return error;
 		error = xfs_da_shrink_inode(state->args, drop_blk->blkno,
 							 drop_blk->bp);
 		drop_blk->bp = NULL;
 		if (error)
-			return(error);
+			return error;
 	}
 	/*
 	 * We joined all the way to the top.  If it turns out that
@@ -768,7 +768,7 @@ xfs_da_join(xfs_da_state_t *state)
 	xfs_da_node_remove(state, drop_blk);
 	xfs_da_fixhashpath(state, &state->path);
 	error = xfs_da_root_join(state, &state->path.blk[0]);
-	return(error);
+	return error;
 }
 
 /*
@@ -798,7 +798,7 @@ xfs_da_root_join(xfs_da_state_t *state, 
 	 * If the root has more than one child, then don't do anything.
 	 */
 	if (INT_GET(oldroot->hdr.count, ARCH_CONVERT) > 1)
-		return(0);
+		return 0;
 
 	/*
 	 * Read in the (only) child block, then copy those bytes into
@@ -809,7 +809,7 @@ xfs_da_root_join(xfs_da_state_t *state, 
 	error = xfs_da_read_buf(args->trans, args->dp, child, -1, &bp,
 					     args->whichfork);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 	blkinfo = bp->data;
 	if (INT_GET(oldroot->hdr.level, ARCH_CONVERT) == 1) {
@@ -823,7 +823,7 @@ xfs_da_root_join(xfs_da_state_t *state, 
 	memcpy(root_blk->bp->data, bp->data, state->blocksize);
 	xfs_da_log_buf(args->trans, root_blk->bp, 0, state->blocksize - 1);
 	error = xfs_da_shrink_inode(args, child, bp);
-	return(error);
+	return error;
 }
 
 /*
@@ -857,7 +857,7 @@ xfs_da_node_toosmall(xfs_da_state_t *sta
 	count = INT_GET(node->hdr.count, ARCH_CONVERT);
 	if (count > (state->node_ents >> 1)) {
 		*action = 0;	/* blk over 50%, don't try to join */
-		return(0);	/* blk over 50%, don't try to join */
+		return 0;	/* blk over 50%, don't try to join */
 	}
 
 	/*
@@ -876,13 +876,13 @@ xfs_da_node_toosmall(xfs_da_state_t *sta
 		error = xfs_da_path_shift(state, &state->altpath, forward,
 						 0, &retval);
 		if (error)
-			return(error);
+			return error;
 		if (retval) {
 			*action = 0;
 		} else {
 			*action = 2;
 		}
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -905,7 +905,7 @@ xfs_da_node_toosmall(xfs_da_state_t *sta
 		error = xfs_da_read_buf(state->args->trans, state->args->dp,
 					blkno, -1, &bp, state->args->whichfork);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(bp != NULL);
 
 		node = (xfs_da_intnode_t *)info;
@@ -921,7 +921,7 @@ xfs_da_node_toosmall(xfs_da_state_t *sta
 	}
 	if (i >= 2) {
 		*action = 0;
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -933,25 +933,25 @@ xfs_da_node_toosmall(xfs_da_state_t *sta
 		error = xfs_da_path_shift(state, &state->altpath, forward,
 						 0, &retval);
 		if (error) {
-			return(error);
+			return error;
 		}
 		if (retval) {
 			*action = 0;
-			return(0);
+			return 0;
 		}
 	} else {
 		error = xfs_da_path_shift(state, &state->path, forward,
 						 0, &retval);
 		if (error) {
-			return(error);
+			return error;
 		}
 		if (retval) {
 			*action = 0;
-			return(0);
+			return 0;
 		}
 	}
 	*action = 1;
-	return(0);
+	return 0;
 }
 
 /*
@@ -1159,7 +1159,7 @@ xfs_da_node_lookup_int(xfs_da_state_t *s
 		if (error) {
 			blk->blkno = 0;
 			state->path.active--;
-			return(error);
+			return error;
 		}
 		curr = blk->bp->data;
 		ASSERT(INT_GET(curr->magic, ARCH_CONVERT) == XFS_DA_NODE_MAGIC ||
@@ -1261,7 +1261,7 @@ xfs_da_node_lookup_int(xfs_da_state_t *s
 			error = xfs_da_path_shift(state, &state->path, 1, 1,
 							 &retval);
 			if (error)
-				return(error);
+				return error;
 			if (retval == 0) {
 				continue;
 			}
@@ -1275,7 +1275,7 @@ xfs_da_node_lookup_int(xfs_da_state_t *s
 		break;
 	}
 	*result = retval;
-	return(0);
+	return 0;
 }
 
 /*========================================================================
@@ -1342,7 +1342,7 @@ xfs_da_blk_link(xfs_da_state_t *state, x
 							ARCH_CONVERT), -1, &bp,
 						args->whichfork);
 			if (error)
-				return(error);
+				return error;
 			ASSERT(bp != NULL);
 			tmp_info = bp->data;
 			ASSERT(INT_GET(tmp_info->magic, ARCH_CONVERT) == INT_GET(old_info->magic, ARCH_CONVERT));
@@ -1363,7 +1363,7 @@ xfs_da_blk_link(xfs_da_state_t *state, x
 						INT_GET(old_info->forw, ARCH_CONVERT), -1, &bp,
 						args->whichfork);
 			if (error)
-				return(error);
+				return error;
 			ASSERT(bp != NULL);
 			tmp_info = bp->data;
 			ASSERT(INT_GET(tmp_info->magic, ARCH_CONVERT)
@@ -1379,7 +1379,7 @@ xfs_da_blk_link(xfs_da_state_t *state, x
 
 	xfs_da_log_buf(args->trans, old_blk->bp, 0, sizeof(*tmp_info) - 1);
 	xfs_da_log_buf(args->trans, new_blk->bp, 0, sizeof(*tmp_info) - 1);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1399,9 +1399,9 @@ xfs_da_node_order(xfs_dabuf_t *node1_bp,
 	      INT_GET(node1->btree[ 0 ].hashval, ARCH_CONVERT)) ||
 	     (INT_GET(node2->btree[ INT_GET(node2->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT) <
 	      INT_GET(node1->btree[ INT_GET(node1->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT)))) {
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*
@@ -1417,8 +1417,8 @@ xfs_da_node_lasthash(xfs_dabuf_t *bp, in
 	if (count)
 		*count = INT_GET(node->hdr.count, ARCH_CONVERT);
 	if (INT_ISZERO(node->hdr.count, ARCH_CONVERT))
-		return(0);
-	return(INT_GET(node->btree[ INT_GET(node->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT));
+		return 0;
+	return INT_GET(node->btree[ INT_GET(node->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT);
 }
 
 /*
@@ -1462,7 +1462,7 @@ xfs_da_blk_unlink(xfs_da_state_t *state,
 							ARCH_CONVERT), -1, &bp,
 						args->whichfork);
 			if (error)
-				return(error);
+				return error;
 			ASSERT(bp != NULL);
 			tmp_info = bp->data;
 			ASSERT(INT_GET(tmp_info->magic, ARCH_CONVERT) == INT_GET(save_info->magic, ARCH_CONVERT));
@@ -1479,7 +1479,7 @@ xfs_da_blk_unlink(xfs_da_state_t *state,
 						INT_GET(drop_info->forw, ARCH_CONVERT), -1, &bp,
 						args->whichfork);
 			if (error)
-				return(error);
+				return error;
 			ASSERT(bp != NULL);
 			tmp_info = bp->data;
 			ASSERT(INT_GET(tmp_info->magic, ARCH_CONVERT)
@@ -1494,7 +1494,7 @@ xfs_da_blk_unlink(xfs_da_state_t *state,
 	}
 
 	xfs_da_log_buf(args->trans, save_blk->bp, 0, sizeof(*save_info) - 1);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1543,7 +1543,7 @@ xfs_da_path_shift(xfs_da_state_t *state,
 	if (level < 0) {
 		*result = XFS_ERROR(ENOENT);	/* we're out of our tree */
 		ASSERT(args->oknoent);
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1565,7 +1565,7 @@ xfs_da_path_shift(xfs_da_state_t *state,
 		error = xfs_da_read_buf(args->trans, args->dp, blkno, -1,
 						     &blk->bp, args->whichfork);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(blk->bp != NULL);
 		info = blk->bp->data;
 		ASSERT(INT_GET(info->magic, ARCH_CONVERT) == XFS_DA_NODE_MAGIC ||
@@ -1609,7 +1609,7 @@ xfs_da_path_shift(xfs_da_state_t *state,
 		}
 	}
 	*result = 0;
-	return(0);
+	return 0;
 }
 
 
@@ -1635,7 +1635,7 @@ xfs_da_hashname(uchar_t *name, int namel
 	for (hash = 0; namelen > 0; namelen--) {
 		hash = *name++ ^ ROTL(hash, 7);
 	}
-	return(hash);
+	return hash;
 #else
 	/*
 	 * Do four characters at a time as long as we can.
@@ -2364,7 +2364,7 @@ xfs_da_log2_roundup(uint i)
 		if ((1 << rval) >= i)
 			break;
 	}
-	return(rval);
+	return rval;
 }
 
 kmem_zone_t *xfs_da_state_zone;	/* anchor for state struct zone */



