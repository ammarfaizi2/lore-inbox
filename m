Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbULPAgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbULPAgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbULPAgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:36:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:14244 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262556AbULPARa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:17:30 -0500
Date: Thu, 16 Dec 2004 01:27:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 15/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_dir_leaf.c
Message-ID: <Pine.LNX.4.61.0412160126460.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_dir_leaf.c



Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_dir_leaf.c	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_dir_leaf.c	2004-12-15 23:20:26.000000000 +0100
@@ -165,7 +165,7 @@ xfs_dir_shortform_create(xfs_da_args_t *
 	INT_ZERO(hdr->count, ARCH_CONVERT);
 	dp->i_d.di_size = sizeof(*hdr);
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_DDATA);
-	return(0);
+	return 0;
 }
 
 /*
@@ -198,7 +198,7 @@ xfs_dir_shortform_addname(xfs_da_args_t 
 		if (sfe->namelen == args->namelen &&
 		    args->name[0] == sfe->name[0] &&
 		    memcmp(args->name, sfe->name, args->namelen) == 0)
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		sfe = XFS_DIR_SF_NEXTENTRY(sfe);
 	}
 
@@ -216,7 +216,7 @@ xfs_dir_shortform_addname(xfs_da_args_t 
 	dp->i_d.di_size += size;
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_DDATA);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -256,7 +256,7 @@ xfs_dir_shortform_removename(xfs_da_args
 	}
 	if (i < 0) {
 		ASSERT(args->oknoent);
-		return(XFS_ERROR(ENOENT));
+		return XFS_ERROR(ENOENT);
 	}
 
 	if ((base + size) != dp->i_d.di_size) {
@@ -269,7 +269,7 @@ xfs_dir_shortform_removename(xfs_da_args
 	dp->i_d.di_size -= size;
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_DDATA);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -299,11 +299,11 @@ xfs_dir_shortform_lookup(xfs_da_args_t *
 	if (args->namelen == 2 &&
 	    args->name[0] == '.' && args->name[1] == '.') {
 		XFS_DIR_SF_GET_DIRINO_ARCH(&sf->hdr.parent, &args->inumber, ARCH_CONVERT);
-		return(XFS_ERROR(EEXIST));
+		return XFS_ERROR(EEXIST);
 	}
 	if (args->namelen == 1 && args->name[0] == '.') {
 		args->inumber = dp->i_ino;
-		return(XFS_ERROR(EEXIST));
+		return XFS_ERROR(EEXIST);
 	}
 	sfe = &sf->list[0];
 	for (i = INT_GET(sf->hdr.count, ARCH_CONVERT)-1; i >= 0; i--) {
@@ -311,12 +311,12 @@ xfs_dir_shortform_lookup(xfs_da_args_t *
 		    sfe->name[0] == args->name[0] &&
 		    memcmp(args->name, sfe->name, args->namelen) == 0) {
 			XFS_DIR_SF_GET_DIRINO_ARCH(&sfe->inumber, &args->inumber, ARCH_CONVERT);
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		}
 		sfe = XFS_DIR_SF_NEXTENTRY(sfe);
 	}
 	ASSERT(args->oknoent);
-	return(XFS_ERROR(ENOENT));
+	return XFS_ERROR(ENOENT);
 }
 
 /*
@@ -408,7 +408,7 @@ xfs_dir_shortform_to_leaf(xfs_da_args_t 
 
 out:
 	kmem_free(tmpbuffer, size);
-	return(retval);
+	return retval;
 }
 
 STATIC int
@@ -614,7 +614,7 @@ xfs_dir_shortform_replace(xfs_da_args_t 
 		/* XXX - replace assert? */
 		XFS_DIR_SF_PUT_DIRINO_ARCH(&args->inumber, &sf->hdr.parent, ARCH_CONVERT);
 		xfs_trans_log_inode(args->trans, dp, XFS_ILOG_DDATA);
-		return(0);
+		return 0;
 	}
 	ASSERT(args->namelen != 1 || args->name[0] != '.');
 	sfe = &sf->list[0];
@@ -626,12 +626,12 @@ xfs_dir_shortform_replace(xfs_da_args_t 
 				(char *)&sfe->inumber, sizeof(xfs_ino_t)));
 			XFS_DIR_SF_PUT_DIRINO_ARCH(&args->inumber, &sfe->inumber, ARCH_CONVERT);
 			xfs_trans_log_inode(args->trans, dp, XFS_ILOG_DDATA);
-			return(0);
+			return 0;
 		}
 		sfe = XFS_DIR_SF_NEXTENTRY(sfe);
 	}
 	ASSERT(args->oknoent);
-	return(XFS_ERROR(ENOENT));
+	return XFS_ERROR(ENOENT);
 }
 
 /*
@@ -713,7 +713,7 @@ xfs_dir_leaf_to_shortform(xfs_da_args_t 
 
 out:
 	kmem_free(tmpbuffer, XFS_LBSIZE(dp->i_mount));
-	return(retval);
+	return retval;
 }
 
 /*
@@ -733,17 +733,17 @@ xfs_dir_leaf_to_node(xfs_da_args_t *args
 	retval = xfs_da_grow_inode(args, &blkno);
 	ASSERT(blkno == 1);
 	if (retval)
-		return(retval);
+		return retval;
 	retval = xfs_da_read_buf(args->trans, args->dp, 0, -1, &bp1,
 					      XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp1 != NULL);
 	retval = xfs_da_get_buf(args->trans, args->dp, 1, -1, &bp2,
 					     XFS_DATA_FORK);
 	if (retval) {
 		xfs_da_buf_done(bp1);
-		return(retval);
+		return retval;
 	}
 	ASSERT(bp2 != NULL);
 	memcpy(bp2->data, bp1->data, XFS_LBSIZE(dp->i_mount));
@@ -756,7 +756,7 @@ xfs_dir_leaf_to_node(xfs_da_args_t *args
 	retval = xfs_da_node_create(args, 0, 1, &bp1, XFS_DATA_FORK);
 	if (retval) {
 		xfs_da_buf_done(bp2);
-		return(retval);
+		return retval;
 	}
 	node = bp1->data;
 	leaf = bp2->data;
@@ -769,7 +769,7 @@ xfs_dir_leaf_to_node(xfs_da_args_t *args
 		XFS_DA_LOGRANGE(node, &node->btree[0], sizeof(node->btree[0])));
 	xfs_da_buf_done(bp1);
 
-	return(retval);
+	return retval;
 }
 
 
@@ -794,7 +794,7 @@ xfs_dir_leaf_create(xfs_da_args_t *args,
 	ASSERT(dp != NULL);
 	retval = xfs_da_get_buf(args->trans, dp, blkno, -1, &bp, XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 	leaf = bp->data;
 	memset((char *)leaf, 0, XFS_LBSIZE(dp->i_mount));
@@ -809,7 +809,7 @@ xfs_dir_leaf_create(xfs_da_args_t *args,
 	xfs_da_log_buf(args->trans, bp, 0, XFS_LBSIZE(dp->i_mount) - 1);
 
 	*bpp = bp;
-	return(0);
+	return 0;
 }
 
 /*
@@ -831,10 +831,10 @@ xfs_dir_leaf_split(xfs_da_state_t *state
 	ASSERT(oldblk->magic == XFS_DIR_LEAF_MAGIC);
 	error = xfs_da_grow_inode(args, &blkno);
 	if (error)
-		return(error);
+		return error;
 	error = xfs_dir_leaf_create(args, blkno, &newblk->bp);
 	if (error)
-		return(error);
+		return error;
 	newblk->blkno = blkno;
 	newblk->magic = XFS_DIR_LEAF_MAGIC;
 
@@ -844,7 +844,7 @@ xfs_dir_leaf_split(xfs_da_state_t *state
 	xfs_dir_leaf_rebalance(state, oldblk, newblk);
 	error = xfs_da_blk_link(state, oldblk, newblk);
 	if (error)
-		return(error);
+		return error;
 
 	/*
 	 * Insert the new entry in the correct block.
@@ -860,7 +860,7 @@ xfs_dir_leaf_split(xfs_da_state_t *state
 	 */
 	oldblk->hashval = xfs_dir_leaf_lasthash(oldblk->bp, NULL);
 	newblk->hashval = xfs_dir_leaf_lasthash(newblk->bp, NULL);
-	return(error);
+	return error;
 }
 
 /*
@@ -903,7 +903,7 @@ xfs_dir_leaf_add(xfs_dabuf_t *bp, xfs_da
 		if (INT_GET(map->size, ARCH_CONVERT) >= tmp) {
 			if (!args->justcheck)
 				xfs_dir_leaf_add_work(bp, args, index, i);
-			return(0);
+			return 0;
 		}
 		sum += INT_GET(map->size, ARCH_CONVERT);
 	}
@@ -914,7 +914,7 @@ xfs_dir_leaf_add(xfs_dabuf_t *bp, xfs_da
 	 * no good and we should just give up.
 	 */
 	if (!hdr->holes && (sum < entsize))
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 
 	/*
 	 * Compact the entries to coalesce free space.
@@ -927,18 +927,18 @@ xfs_dir_leaf_add(xfs_dabuf_t *bp, xfs_da
 				(uint)sizeof(xfs_dir_leaf_entry_t) : 0,
 			args->justcheck);
 	if (error)
-		return(error);
+		return error;
 	/*
 	 * After compaction, the block is guaranteed to have only one
 	 * free region, in freemap[0].  If it is not big enough, give up.
 	 */
 	if (INT_GET(hdr->freemap[0].size, ARCH_CONVERT) <
 	    (entsize + (uint)sizeof(xfs_dir_leaf_entry_t)))
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 
 	if (!args->justcheck)
 		xfs_dir_leaf_add_work(bp, args, index, 0);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1090,7 +1090,7 @@ xfs_dir_leaf_compact(xfs_trans_t *trans,
 	kmem_free(tmpbuffer, lbsize);
 	if (musthave || justcheck)
 		kmem_free(tmpbuffer2, lbsize);
-	return(rval);
+	return rval;
 }
 
 /*
@@ -1310,7 +1310,7 @@ xfs_dir_leaf_figure_balance(xfs_da_state
 
 	*countarg = count;
 	*namebytesarg = totallen;
-	return(foundit);
+	return foundit;
 }
 
 /*========================================================================
@@ -1352,7 +1352,7 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 		INT_GET(leaf->hdr.namebytes, ARCH_CONVERT);
 	if (bytes > (state->blocksize >> 1)) {
 		*action = 0;	/* blk over 50%, don't try to join */
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1371,13 +1371,13 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
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
@@ -1399,7 +1399,7 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 							    blkno, -1, &bp,
 							    XFS_DATA_FORK);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(bp != NULL);
 
 		leaf = (xfs_dir_leafblock_t *)info;
@@ -1420,7 +1420,7 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 	}
 	if (i >= 2) {
 		*action = 0;
-		return(0);
+		return 0;
 	}
 	xfs_da_buf_done(bp);
 
@@ -1437,13 +1437,13 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 						 0, &retval);
 	}
 	if (error)
-		return(error);
+		return error;
 	if (retval) {
 		*action = 0;
 	} else {
 		*action = 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*
@@ -1593,8 +1593,8 @@ xfs_dir_leaf_remove(xfs_trans_t *trans, 
 	tmp += INT_GET(leaf->hdr.count, ARCH_CONVERT) * ((uint)sizeof(xfs_dir_leaf_name_t) - 1);
 	tmp += INT_GET(leaf->hdr.namebytes, ARCH_CONVERT);
 	if (tmp < mp->m_dir_magicpct)
-		return(1);			/* leaf is < 37% full */
-	return(0);
+		return 1;			/* leaf is < 37% full */
+	return 0;
 }
 
 /*
@@ -1750,7 +1750,7 @@ xfs_dir_leaf_lookup_int(xfs_dabuf_t *bp,
 	if ((probe == INT_GET(leaf->hdr.count, ARCH_CONVERT)) || (INT_GET(entry->hashval, ARCH_CONVERT) != hashval)) {
 		*index = probe;
 		ASSERT(args->oknoent);
-		return(XFS_ERROR(ENOENT));
+		return XFS_ERROR(ENOENT);
 	}
 
 	/*
@@ -1763,14 +1763,14 @@ xfs_dir_leaf_lookup_int(xfs_dabuf_t *bp,
 		    memcmp(args->name, namest->name, args->namelen) == 0) {
 			XFS_DIR_SF_GET_DIRINO_ARCH(&namest->inumber, &args->inumber, ARCH_CONVERT);
 			*index = probe;
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		}
 		entry++;
 		probe++;
 	}
 	*index = probe;
 	ASSERT(probe == INT_GET(leaf->hdr.count, ARCH_CONVERT) || args->oknoent);
-	return(XFS_ERROR(ENOENT));
+	return XFS_ERROR(ENOENT);
 }
 
 /*========================================================================
@@ -1908,9 +1908,9 @@ xfs_dir_leaf_order(xfs_dabuf_t *leaf1_bp
 	      INT_GET(leaf1->entries[ 0 ].hashval, ARCH_CONVERT)) ||
 	     (INT_GET(leaf2->entries[ INT_GET(leaf2->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT) <
 	      INT_GET(leaf1->entries[ INT_GET(leaf1->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT)))) {
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*
@@ -1926,8 +1926,8 @@ xfs_dir_leaf_lasthash(xfs_dabuf_t *bp, i
 	if (count)
 		*count = INT_GET(leaf->hdr.count, ARCH_CONVERT);
 	if (INT_ISZERO(leaf->hdr.count, ARCH_CONVERT))
-		return(0);
-	return(INT_GET(leaf->entries[ INT_GET(leaf->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT));
+		return 0;
+	return INT_GET(leaf->entries[ INT_GET(leaf->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT);
 }
 
 /*
@@ -1960,7 +1960,7 @@ xfs_dir_leaf_getdents_int(
 	leaf = bp->data;
 	if (INT_GET(leaf->hdr.info.magic, ARCH_CONVERT) != XFS_DIR_LEAF_MAGIC) {
 		*eobp = 1;
-		return(XFS_ERROR(ENOENT));	/* XXX wrong code */
+		return XFS_ERROR(ENOENT);	/* XXX wrong code */
 	}
 
 	want_entno = XFS_DA_COOKIE_ENTRY(mp, uio->uio_offset);
@@ -2018,7 +2018,7 @@ xfs_dir_leaf_getdents_int(
 		 * the node code will be setting uio_offset anyway.
 		 */
 		*eobp = 0;
-		return(0);
+		return 0;
 	}
 	xfs_dir_trace_g_due("leaf: hash found", dp, uio, entry);
 
@@ -2075,7 +2075,7 @@ xfs_dir_leaf_getdents_int(
 			retval = xfs_da_read_buf(dp->i_transp, dp, thishash,
 						 nextda, &bp2, XFS_DATA_FORK);
 			if (retval)
-				return(retval);
+				return retval;
 
 			ASSERT(bp2 != NULL);
 
@@ -2091,7 +2091,7 @@ xfs_dir_leaf_getdents_int(
 						     leaf2);
 				xfs_da_brelse(dp->i_transp, bp2);
 
-				return(XFS_ERROR(EFSCORRUPTED));
+				return XFS_ERROR(EFSCORRUPTED);
 			}
 
 			nexthash = INT_GET(leaf2->entries[0].hashval,
@@ -2157,7 +2157,7 @@ xfs_dir_leaf_getdents_int(
 
 			xfs_dir_trace_g_du("leaf: E-O-B", dp, uio);
 
-			return(retval);
+			return retval;
 		}
 	}
 
@@ -2167,7 +2167,7 @@ xfs_dir_leaf_getdents_int(
 
 	xfs_dir_trace_g_du("leaf: E-O-F", dp, uio);
 
-	return(0);
+	return 0;
 }
 
 /*




