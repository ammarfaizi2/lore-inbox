Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbULPAqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbULPAqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbULPAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:43:21 -0500
Received: from mail.dif.dk ([193.138.115.101]:19364 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262558AbULPAS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:18:59 -0500
Date: Thu, 16 Dec 2004 01:29:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 16/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_attr_leaf.c
Message-ID: <Pine.LNX.4.61.0412160128020.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_attr_leaf.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_attr_leaf.c	2004-10-18 23:54:08.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_attr_leaf.c	2004-12-15 23:35:33.000000000 +0100
@@ -132,7 +132,7 @@ xfs_attr_shortform_create(xfs_da_args_t 
 	INT_ZERO(hdr->count, ARCH_CONVERT);
 	INT_SET(hdr->totsize, ARCH_CONVERT, sizeof(*hdr));
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_ADATA);
-	return(0);
+	return 0;
 }
 
 /*
@@ -165,7 +165,7 @@ xfs_attr_shortform_add(xfs_da_args_t *ar
 		if (((args->flags & ATTR_ROOT) != 0) !=
 		    ((sfe->flags & XFS_ATTR_ROOT) != 0))
 			continue;
-		return(XFS_ERROR(EEXIST));
+		return XFS_ERROR(EEXIST);
 	}
 
 	offset = (char *)sfe - (char *)sf;
@@ -184,7 +184,7 @@ xfs_attr_shortform_add(xfs_da_args_t *ar
 	INT_MOD(sf->hdr.totsize, ARCH_CONVERT, size);
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_ADATA);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -222,7 +222,7 @@ xfs_attr_shortform_remove(xfs_da_args_t 
 		break;
 	}
 	if (i == INT_GET(sf->hdr.count, ARCH_CONVERT))
-		return(XFS_ERROR(ENOATTR));
+		return XFS_ERROR(ENOATTR);
 
 	end = base + size;
 	totsize = INT_GET(sf->hdr.totsize, ARCH_CONVERT);
@@ -235,7 +235,7 @@ xfs_attr_shortform_remove(xfs_da_args_t 
 	xfs_idata_realloc(dp, -size, XFS_ATTR_FORK);
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_ADATA);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -266,9 +266,9 @@ xfs_attr_shortform_lookup(xfs_da_args_t 
 		if (((args->flags & ATTR_ROOT) != 0) !=
 		    ((sfe->flags & XFS_ATTR_ROOT) != 0))
 			continue;
-		return(XFS_ERROR(EEXIST));
+		return XFS_ERROR(EEXIST);
 	}
-	return(XFS_ERROR(ENOATTR));
+	return XFS_ERROR(ENOATTR);
 }
 
 /*
@@ -299,18 +299,18 @@ xfs_attr_shortform_getvalue(xfs_da_args_
 			continue;
 		if (args->flags & ATTR_KERNOVAL) {
 			args->valuelen = INT_GET(sfe->valuelen, ARCH_CONVERT);
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		}
 		if (args->valuelen < INT_GET(sfe->valuelen, ARCH_CONVERT)) {
 			args->valuelen = INT_GET(sfe->valuelen, ARCH_CONVERT);
-			return(XFS_ERROR(ERANGE));
+			return XFS_ERROR(ERANGE);
 		}
 		args->valuelen = INT_GET(sfe->valuelen, ARCH_CONVERT);
 		memcpy(args->value, &sfe->nameval[args->namelen],
 						    args->valuelen);
-		return(XFS_ERROR(EEXIST));
+		return XFS_ERROR(EEXIST);
 	}
-	return(XFS_ERROR(ENOATTR));
+	return XFS_ERROR(ENOATTR);
 }
 
 /*
@@ -398,7 +398,7 @@ out:
 	if(bp)
 		xfs_da_buf_done(bp);
 	kmem_free(tmpbuffer, size);
-	return(error);
+	return error;
 }
 
 STATIC int
@@ -410,12 +410,12 @@ xfs_attr_shortform_compare(const void *a
 	sb = (xfs_attr_sf_sort_t *)b;
 	if (INT_GET(sa->hash, ARCH_CONVERT)
 				< INT_GET(sb->hash, ARCH_CONVERT)) {
-		return(-1);
+		return -1;
 	} else if (INT_GET(sa->hash, ARCH_CONVERT)
 				> INT_GET(sb->hash, ARCH_CONVERT)) {
-		return(1);
+		return 1;
 	} else {
-		return(sa->entno - sb->entno);
+		return sa->entno - sb->entno;
 	}
 }
 
@@ -444,7 +444,7 @@ xfs_attr_shortform_list(xfs_attr_list_co
 	sf = (xfs_attr_shortform_t *)dp->i_afp->if_u1.if_data;
 	ASSERT(sf != NULL);
 	if (INT_ISZERO(sf->hdr.count, ARCH_CONVERT))
-		return(0);
+		return 0;
 	cursor = context->cursor;
 	ASSERT(cursor != NULL);
 
@@ -491,7 +491,7 @@ xfs_attr_shortform_list(xfs_attr_list_co
 			sfe = XFS_ATTR_SF_NEXTENTRY(sfe);
 		}
 		xfs_attr_trace_l_c("sf big-gulp", context);
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -566,7 +566,7 @@ xfs_attr_shortform_list(xfs_attr_list_co
 	if (i == nsbuf) {
 		kmem_free(sbuf, sbsize);
 		xfs_attr_trace_l_c("blk end", context);
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -598,7 +598,7 @@ xfs_attr_shortform_list(xfs_attr_list_co
 
 	kmem_free(sbuf, sbsize);
 	xfs_attr_trace_l_c("sf E-O-F", context);
-	return(0);
+	return 0;
 }
 
 /*
@@ -623,17 +623,17 @@ xfs_attr_shortform_allfit(xfs_dabuf_t *b
 		if (entry->flags & XFS_ATTR_INCOMPLETE)
 			continue;		/* don't copy partial entries */
 		if (!(entry->flags & XFS_ATTR_LOCAL))
-			return(0);
+			return 0;
 		name_loc = XFS_ATTR_LEAF_NAME_LOCAL(leaf, i);
 		if (name_loc->namelen >= XFS_ATTR_SF_ENTSIZE_MAX)
-			return(0);
+			return 0;
 		if (INT_GET(name_loc->valuelen, ARCH_CONVERT) >= XFS_ATTR_SF_ENTSIZE_MAX)
-			return(0);
+			return 0;
 		bytes += sizeof(struct xfs_attr_sf_entry)-1
 				+ name_loc->namelen
 				+ INT_GET(name_loc->valuelen, ARCH_CONVERT);
 	}
-	return( bytes < XFS_IFORK_ASIZE(dp) );
+	return (bytes < XFS_IFORK_ASIZE(dp));
 }
 
 /*
@@ -703,7 +703,7 @@ xfs_attr_leaf_to_shortform(xfs_dabuf_t *
 
 out:
 	kmem_free(tmpbuffer, XFS_LBSIZE(dp->i_mount));
-	return(error);
+	return error;
 }
 
 /*
@@ -762,7 +762,7 @@ out:
 		xfs_da_buf_done(bp1);
 	if (bp2)
 		xfs_da_buf_done(bp2);
-	return(error);
+	return error;
 }
 
 
@@ -788,7 +788,7 @@ xfs_attr_leaf_create(xfs_da_args_t *args
 	error = xfs_da_get_buf(args->trans, args->dp, blkno, -1, &bp,
 					    XFS_ATTR_FORK);
 	if (error)
-		return(error);
+		return error;
 	ASSERT(bp != NULL);
 	leaf = bp->data;
 	memset((char *)leaf, 0, XFS_LBSIZE(dp->i_mount));
@@ -810,7 +810,7 @@ xfs_attr_leaf_create(xfs_da_args_t *args
 	xfs_da_log_buf(args->trans, bp, 0, XFS_LBSIZE(dp->i_mount) - 1);
 
 	*bpp = bp;
-	return(0);
+	return 0;
 }
 
 /*
@@ -829,10 +829,10 @@ xfs_attr_leaf_split(xfs_da_state_t *stat
 	ASSERT(oldblk->magic == XFS_ATTR_LEAF_MAGIC);
 	error = xfs_da_grow_inode(state->args, &blkno);
 	if (error)
-		return(error);
+		return error;
 	error = xfs_attr_leaf_create(state->args, blkno, &newblk->bp);
 	if (error)
-		return(error);
+		return error;
 	newblk->blkno = blkno;
 	newblk->magic = XFS_ATTR_LEAF_MAGIC;
 
@@ -843,7 +843,7 @@ xfs_attr_leaf_split(xfs_da_state_t *stat
 	xfs_attr_leaf_rebalance(state, oldblk, newblk);
 	error = xfs_da_blk_link(state, oldblk, newblk);
 	if (error)
-		return(error);
+		return error;
 
 	/*
 	 * Save info on "old" attribute for "atomic rename" ops, leaf_add()
@@ -862,7 +862,7 @@ xfs_attr_leaf_split(xfs_da_state_t *stat
 	 */
 	oldblk->hashval = xfs_attr_leaf_lasthash(oldblk->bp, NULL);
 	newblk->hashval = xfs_attr_leaf_lasthash(newblk->bp, NULL);
-	return(error);
+	return error;
 }
 
 /*
@@ -906,7 +906,7 @@ xfs_attr_leaf_add(xfs_dabuf_t *bp, xfs_d
 			tmp += sizeof(xfs_attr_leaf_entry_t);
 		if (INT_GET(map->size, ARCH_CONVERT) >= tmp) {
 			tmp = xfs_attr_leaf_add_work(bp, args, i);
-			return(tmp);
+			return tmp;
 		}
 		sum += INT_GET(map->size, ARCH_CONVERT);
 	}
@@ -917,7 +917,7 @@ xfs_attr_leaf_add(xfs_dabuf_t *bp, xfs_d
 	 * no good and we should just give up.
 	 */
 	if (!hdr->holes && (sum < entsize))
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 
 	/*
 	 * Compact the entries to coalesce free space.
@@ -931,9 +931,9 @@ xfs_attr_leaf_add(xfs_dabuf_t *bp, xfs_d
 	 */
 	if (INT_GET(hdr->freemap[0].size, ARCH_CONVERT)
 				< (entsize + sizeof(xfs_attr_leaf_entry_t)))
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 
-	return(xfs_attr_leaf_add_work(bp, args, 0));
+	return xfs_attr_leaf_add_work(bp, args, 0);
 }
 
 /*
@@ -1067,7 +1067,7 @@ xfs_attr_leaf_add_work(xfs_dabuf_t *bp, 
 				xfs_attr_leaf_entsize(leaf, args->index));
 	xfs_da_log_buf(args->trans, bp,
 		XFS_DA_LOGRANGE(leaf, hdr, sizeof(*hdr)));
-	return(0);
+	return 0;
 }
 
 /*
@@ -1399,7 +1399,7 @@ xfs_attr_leaf_figure_balance(xfs_da_stat
 
 	*countarg = count;
 	*usedbytesarg = totallen;
-	return(foundit);
+	return foundit;
 }
 
 /*========================================================================
@@ -1442,7 +1442,7 @@ xfs_attr_leaf_toosmall(xfs_da_state_t *s
 		INT_GET(leaf->hdr.usedbytes, ARCH_CONVERT);
 	if (bytes > (state->blocksize >> 1)) {
 		*action = 0;	/* blk over 50%, don't try to join */
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1461,13 +1461,13 @@ xfs_attr_leaf_toosmall(xfs_da_state_t *s
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
@@ -1490,7 +1490,7 @@ xfs_attr_leaf_toosmall(xfs_da_state_t *s
 		error = xfs_da_read_buf(state->args->trans, state->args->dp,
 					blkno, -1, &bp, XFS_ATTR_FORK);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(bp != NULL);
 
 		leaf = (xfs_attr_leafblock_t *)info;
@@ -1510,7 +1510,7 @@ xfs_attr_leaf_toosmall(xfs_da_state_t *s
 	}
 	if (i >= 2) {
 		*action = 0;
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1526,13 +1526,13 @@ xfs_attr_leaf_toosmall(xfs_da_state_t *s
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
@@ -1704,7 +1704,7 @@ xfs_attr_leaf_remove(xfs_dabuf_t *bp, xf
 	tmp += INT_GET(leaf->hdr.count, ARCH_CONVERT)
 					* sizeof(xfs_attr_leaf_entry_t);
 	tmp += INT_GET(leaf->hdr.usedbytes, ARCH_CONVERT);
-	return(tmp < mp->m_attr_magicpct); /* leaf is < 37% full */
+	return (tmp < mp->m_attr_magicpct); /* leaf is < 37% full */
 }
 
 /*
@@ -1883,7 +1883,7 @@ xfs_attr_leaf_lookup_int(xfs_dabuf_t *bp
 	if ((probe == INT_GET(leaf->hdr.count, ARCH_CONVERT))
 		    || (INT_GET(entry->hashval, ARCH_CONVERT) != hashval)) {
 		args->index = probe;
-		return(XFS_ERROR(ENOATTR));
+		return XFS_ERROR(ENOATTR);
 	}
 
 	/*
@@ -1917,7 +1917,7 @@ xfs_attr_leaf_lookup_int(xfs_dabuf_t *bp
 			    ((entry->flags & XFS_ATTR_ROOT) != 0))
 				continue;
 			args->index = probe;
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		} else {
 			name_rmt = XFS_ATTR_LEAF_NAME_REMOTE(leaf, probe);
 			if (name_rmt->namelen != args->namelen)
@@ -1937,11 +1937,11 @@ xfs_attr_leaf_lookup_int(xfs_dabuf_t *bp
 			args->rmtblkcnt = XFS_B_TO_FSB(args->dp->i_mount,
 						   INT_GET(name_rmt->valuelen,
 								ARCH_CONVERT));
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		}
 	}
 	args->index = probe;
-	return(XFS_ERROR(ENOATTR));
+	return XFS_ERROR(ENOATTR);
 }
 
 /*
@@ -1972,11 +1972,11 @@ xfs_attr_leaf_getvalue(xfs_dabuf_t *bp, 
 		valuelen = INT_GET(name_loc->valuelen, ARCH_CONVERT);
 		if (args->flags & ATTR_KERNOVAL) {
 			args->valuelen = valuelen;
-			return(0);
+			return 0;
 		}
 		if (args->valuelen < valuelen) {
 			args->valuelen = valuelen;
-			return(XFS_ERROR(ERANGE));
+			return XFS_ERROR(ERANGE);
 		}
 		args->valuelen = valuelen;
 		memcpy(args->value, &name_loc->nameval[args->namelen], valuelen);
@@ -1989,15 +1989,15 @@ xfs_attr_leaf_getvalue(xfs_dabuf_t *bp, 
 		args->rmtblkcnt = XFS_B_TO_FSB(args->dp->i_mount, valuelen);
 		if (args->flags & ATTR_KERNOVAL) {
 			args->valuelen = valuelen;
-			return(0);
+			return 0;
 		}
 		if (args->valuelen < valuelen) {
 			args->valuelen = valuelen;
-			return(XFS_ERROR(ERANGE));
+			return XFS_ERROR(ERANGE);
 		}
 		args->valuelen = valuelen;
 	}
-	return(0);
+	return 0;
 }
 
 /*========================================================================
@@ -2181,9 +2181,9 @@ xfs_attr_leaf_order(xfs_dabuf_t *leaf1_b
 				ARCH_CONVERT)-1].hashval, ARCH_CONVERT) <
 		      INT_GET(leaf1->entries[INT_GET(leaf1->hdr.count,
 				ARCH_CONVERT)-1].hashval, ARCH_CONVERT))) ) {
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*
@@ -2200,9 +2200,9 @@ xfs_attr_leaf_lasthash(xfs_dabuf_t *bp, 
 	if (count)
 		*count = INT_GET(leaf->hdr.count, ARCH_CONVERT);
 	if (INT_ISZERO(leaf->hdr.count, ARCH_CONVERT))
-		return(0);
-	return(INT_GET(leaf->entries[INT_GET(leaf->hdr.count,
-				ARCH_CONVERT)-1].hashval, ARCH_CONVERT));
+		return 0;
+	return INT_GET(leaf->entries[INT_GET(leaf->hdr.count,
+				ARCH_CONVERT)-1].hashval, ARCH_CONVERT);
 }
 
 /*
@@ -2227,7 +2227,7 @@ xfs_attr_leaf_entsize(xfs_attr_leafblock
 		name_rmt = XFS_ATTR_LEAF_NAME_REMOTE(leaf, index);
 		size = XFS_ATTR_LEAF_ENTSIZE_REMOTE(name_rmt->namelen);
 	}
-	return(size);
+	return size;
 }
 
 /*
@@ -2252,7 +2252,7 @@ xfs_attr_leaf_newentsize(xfs_da_args_t *
 			*local = 0;
 		}
 	}
-	return(size);
+	return size;
 }
 
 /*
@@ -2297,7 +2297,7 @@ xfs_attr_leaf_list_int(xfs_dabuf_t *bp, 
 		}
 		if (i == INT_GET(leaf->hdr.count, ARCH_CONVERT)) {
 			xfs_attr_trace_l_c("not found", context);
-			return(0);
+			return 0;
 		}
 	} else {
 		entry = &leaf->entries[0];
@@ -2365,7 +2365,7 @@ xfs_attr_leaf_list_int(xfs_dabuf_t *bp, 
 		}
 	}
 	xfs_attr_trace_l_cl("blk end", context, leaf);
-	return(retval);
+	return retval;
 }
 
 #define	ATTR_ENTBASESIZE		/* minimum bytes used by an attr */ \
@@ -2396,7 +2396,7 @@ xfs_attr_put_listent(xfs_attr_list_conte
 		arraytop = context->count + namesp->attr_namelen + namelen + 1;
 		if (arraytop > context->firstu) {
 			context->count = -1;	/* insufficient space */
-			return(1);
+			return 1;
 		}
 		offset = (char *)context->alist + context->count;
 		strncpy(offset, namesp->attr_name, namesp->attr_namelen);
@@ -2405,7 +2405,7 @@ xfs_attr_put_listent(xfs_attr_list_conte
 		offset += namelen;
 		*offset = '\0';
 		context->count += namesp->attr_namelen + namelen + 1;
-		return(0);
+		return 0;
 	}
 
 	ASSERT(context->count >= 0);
@@ -2419,7 +2419,7 @@ xfs_attr_put_listent(xfs_attr_list_conte
 	if (context->firstu < arraytop) {
 		xfs_attr_trace_l_c("buffer full", context);
 		context->alist->al_more = 1;
-		return(1);
+		return 1;
 	}
 
 	aep = (attrlist_ent_t *)&(((char *)context->alist)[ context->firstu ]);
@@ -2429,7 +2429,7 @@ xfs_attr_put_listent(xfs_attr_list_conte
 	context->alist->al_offset[ context->count++ ] = context->firstu;
 	context->alist->al_count = context->count;
 	xfs_attr_trace_l_c("add", context);
-	return(0);
+	return 0;
 }
 
 /*========================================================================
@@ -2459,7 +2459,7 @@ xfs_attr_leaf_clearflag(xfs_da_args_t *a
 	error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1, &bp,
 					     XFS_ATTR_FORK);
 	if (error) {
-		return(error);
+		return error;
 	}
 	ASSERT(bp != NULL);
 
@@ -2505,7 +2505,7 @@ xfs_attr_leaf_clearflag(xfs_da_args_t *a
 	 */
 	error = xfs_attr_rolltrans(&args->trans, args->dp);
 
-	return(error);
+	return error;
 }
 
 /*
@@ -2526,7 +2526,7 @@ xfs_attr_leaf_setflag(xfs_da_args_t *arg
 	error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1, &bp,
 					     XFS_ATTR_FORK);
 	if (error) {
-		return(error);
+		return error;
 	}
 	ASSERT(bp != NULL);
 
@@ -2555,7 +2555,7 @@ xfs_attr_leaf_setflag(xfs_da_args_t *arg
 	 */
 	error = xfs_attr_rolltrans(&args->trans, args->dp);
 
-	return(error);
+	return error;
 }
 
 /*
@@ -2585,7 +2585,7 @@ xfs_attr_leaf_flipflags(xfs_da_args_t *a
 	error = xfs_da_read_buf(args->trans, args->dp, args->blkno, -1, &bp1,
 					     XFS_ATTR_FORK);
 	if (error) {
-		return(error);
+		return error;
 	}
 	ASSERT(bp1 != NULL);
 
@@ -2596,7 +2596,7 @@ xfs_attr_leaf_flipflags(xfs_da_args_t *a
 		error = xfs_da_read_buf(args->trans, args->dp, args->blkno2,
 					-1, &bp2, XFS_ATTR_FORK);
 		if (error) {
-			return(error);
+			return error;
 		}
 		ASSERT(bp2 != NULL);
 	} else {
@@ -2675,7 +2675,7 @@ xfs_attr_leaf_flipflags(xfs_da_args_t *a
 	 */
 	error = xfs_attr_rolltrans(&args->trans, args->dp);
 
-	return(error);
+	return error;
 }
 
 /*========================================================================
@@ -2702,7 +2702,7 @@ xfs_attr_root_inactive(xfs_trans_t **tra
 	 */
 	error = xfs_da_read_buf(*trans, dp, 0, -1, &bp, XFS_ATTR_FORK);
 	if (error)
-		return(error);
+		return error;
 	blkno = xfs_da_blkno(bp);
 
 	/*
@@ -2719,21 +2719,21 @@ xfs_attr_root_inactive(xfs_trans_t **tra
 		xfs_da_brelse(*trans, bp);
 	}
 	if (error)
-		return(error);
+		return error;
 
 	/*
 	 * Invalidate the incore copy of the root block.
 	 */
 	error = xfs_da_get_buf(*trans, dp, 0, blkno, &bp, XFS_ATTR_FORK);
 	if (error)
-		return(error);
+		return error;
 	xfs_da_binval(*trans, bp);	/* remove from cache */
 	/*
 	 * Commit the invalidate and start the next transaction.
 	 */
 	error = xfs_attr_rolltrans(trans, dp);
 
-	return (error);
+	return error;
 }
 
 /*
@@ -2756,7 +2756,7 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 	 */
 	if (level > XFS_DA_NODE_MAXDEPTH) {
 		xfs_da_brelse(*trans, bp);	/* no locks for later trans */
-		return(XFS_ERROR(EIO));
+		return XFS_ERROR(EIO);
 	}
 
 	node = bp->data;
@@ -2766,7 +2766,7 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 	count = INT_GET(node->hdr.count, ARCH_CONVERT);
 	if (!count) {
 		xfs_da_brelse(*trans, bp);
-		return(0);
+		return 0;
 	}
 	child_fsb = INT_GET(node->btree[0].before, ARCH_CONVERT);
 	xfs_da_brelse(*trans, bp);	/* no locks for later trans */
@@ -2786,7 +2786,7 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 		error = xfs_da_read_buf(*trans, dp, child_fsb, -2, &child_bp,
 						XFS_ATTR_FORK);
 		if (error)
-			return(error);
+			return error;
 		if (child_bp) {
 						/* save for re-read later */
 			child_blkno = xfs_da_blkno(child_bp);
@@ -2808,7 +2808,7 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 				xfs_da_brelse(*trans, child_bp);
 			}
 			if (error)
-				return(error);
+				return error;
 
 			/*
 			 * Remove the subsidiary block from the cache
@@ -2817,7 +2817,7 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 			error = xfs_da_get_buf(*trans, dp, 0, child_blkno,
 				&child_bp, XFS_ATTR_FORK);
 			if (error)
-				return(error);
+				return error;
 			xfs_da_binval(*trans, child_bp);
 		}
 
@@ -2829,7 +2829,7 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 			error = xfs_da_read_buf(*trans, dp, 0, parent_blkno,
 				&bp, XFS_ATTR_FORK);
 			if (error)
-				return(error);
+				return error;
 			child_fsb = INT_GET(node->btree[i+1].before, ARCH_CONVERT);
 			xfs_da_brelse(*trans, bp);
 		}
@@ -2837,10 +2837,10 @@ xfs_attr_node_inactive(xfs_trans_t **tra
 		 * Atomically commit the whole invalidate stuff.
 		 */
 		if ((error = xfs_attr_rolltrans(trans, dp)))
-			return (error);
+			return error;
 	}
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -2881,7 +2881,7 @@ xfs_attr_leaf_inactive(xfs_trans_t **tra
 	 */
 	if (count == 0) {
 		xfs_da_brelse(*trans, bp);
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -2927,7 +2927,7 @@ xfs_attr_leaf_inactive(xfs_trans_t **tra
 	}
 
 	kmem_free((xfs_caddr_t)list, size);
-	return(error);
+	return error;
 }
 
 /*
@@ -2959,7 +2959,7 @@ xfs_attr_leaf_freextent(xfs_trans_t **tr
 					XFS_BMAPI_ATTRFORK | XFS_BMAPI_METADATA,
 					NULL, 0, &map, &nmap, NULL);
 		if (error) {
-			return(error);
+			return error;
 		}
 		ASSERT(nmap == 1);
 		ASSERT(map.br_startblock != DELAYSTARTBLOCK);
@@ -2982,14 +2982,14 @@ xfs_attr_leaf_freextent(xfs_trans_t **tr
 			 * Roll to next transaction.
 			 */
 			if ((error = xfs_attr_rolltrans(trans, dp)))
-				return (error);
+				return error;
 		}
 
 		tblkno += map.br_blockcount;
 		tblkcnt -= map.br_blockcount;
 	}
 
-	return(0);
+	return 0;
 }
 
 
@@ -3024,7 +3024,7 @@ xfs_attr_rolltrans(xfs_trans_t **transp,
 	 * the duplicate transaction that gets returned.
 	 */
 	if ((error = xfs_trans_commit(trans, 0, NULL)))
-		return (error);
+		return error;
 
 	trans = *transp;
 
@@ -3045,6 +3045,5 @@ xfs_attr_rolltrans(xfs_trans_t **transp,
 		xfs_trans_ijoin(trans, dp, XFS_ILOCK_EXCL);
 		xfs_trans_ihold(trans, dp);
 	}
-	return (error);
-
+	return error;
 }



