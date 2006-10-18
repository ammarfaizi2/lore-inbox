Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWJRIZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWJRIZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWJRIZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:25:40 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:22728 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932093AbWJRIZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:25:39 -0400
Subject: [PATCH] fs/xfs: Handcrafted MIN/MAX macro removal
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Content-Type: text/plain
Date: Wed, 18 Oct 2006 13:58:52 +0530
Message-Id: <1161160132.20400.115.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
macros are changed to use macros in kernel.h

Tested using allmodconfig

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
xfs_btree.h |   34 ++++++++++------------------------
xfs_rtalloc.c |   20 ++++++++++----------
xfs_rtalloc.h |    3 ---
---
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h linux-2.6.19-rc2/fs/xfs/xfs_btree.h
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_btree.h	2006-10-18 11:25:46.000000000 +0530
@@ -18,6 +18,8 @@
 #ifndef __XFS_BTREE_H__
 #define	__XFS_BTREE_H__
 
+#include <linux/kernel.h>
+
 struct xfs_buf;
 struct xfs_bmap_free;
 struct xfs_inode;
@@ -444,30 +446,14 @@ xfs_btree_setbuf(
 /*
  * Min and max functions for extlen, agblock, fileoff, and filblks types.
  */
-#define	XFS_EXTLEN_MIN(a,b)	\
-	((xfs_extlen_t)(a) < (xfs_extlen_t)(b) ? \
-		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
-#define	XFS_EXTLEN_MAX(a,b)	\
-	((xfs_extlen_t)(a) > (xfs_extlen_t)(b) ? \
-		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
-#define	XFS_AGBLOCK_MIN(a,b)	\
-	((xfs_agblock_t)(a) < (xfs_agblock_t)(b) ? \
-		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
-#define	XFS_AGBLOCK_MAX(a,b)	\
-	((xfs_agblock_t)(a) > (xfs_agblock_t)(b) ? \
-		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
-#define	XFS_FILEOFF_MIN(a,b)	\
-	((xfs_fileoff_t)(a) < (xfs_fileoff_t)(b) ? \
-		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
-#define	XFS_FILEOFF_MAX(a,b)	\
-	((xfs_fileoff_t)(a) > (xfs_fileoff_t)(b) ? \
-		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
-#define	XFS_FILBLKS_MIN(a,b)	\
-	((xfs_filblks_t)(a) < (xfs_filblks_t)(b) ? \
-		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
-#define	XFS_FILBLKS_MAX(a,b)	\
-	((xfs_filblks_t)(a) > (xfs_filblks_t)(b) ? \
-		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
+#define	XFS_EXTLEN_MIN(a,b)   (min_t(xfs_extlen_t,a,b))
+#define	XFS_EXTLEN_MAX(a,b)	  (max_t(xfs_extlen_t,a,b))
+#define	XFS_AGBLOCK_MIN(a,b)  (min_t(xfs_agblock_t,a,b))
+#define	XFS_AGBLOCK_MAX(a,b)  (max_t(xfs_agblock_t,a,b))
+#define	XFS_FILEOFF_MIN(a,b)  (min_t(xfs_fileoff_t,a,b))
+#define	XFS_FILEOFF_MAX(a,b)  (max_t(xfs_fileoff_t,a,b))
+#define	XFS_FILBLKS_MIN(a,b)  (min_t(xfs_filblks_t,a,b))
+#define	XFS_FILBLKS_MAX(a,b)  (max_t(xfs_filblks_t,a,b))
 
 #define	XFS_FSB_SANITY_CHECK(mp,fsb)	\
 	(XFS_FSB_TO_AGNO(mp, fsb) < mp->m_sb.sb_agcount && \
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.c linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.c
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.c	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.c	2006-10-18 11:25:46.000000000 +0530
@@ -699,8 +699,8 @@ xfs_rtallocate_extent_size(
 			 * this summary level.
 			 */
 			error = xfs_rtallocate_extent_block(mp, tp, i,
-					XFS_RTMAX(minlen, 1 << l),
-					XFS_RTMIN(maxlen, (1 << (l + 1)) - 1),
+					max(minlen, (xfs_extlen_t)(1 << l)),
+					min(maxlen, (xfs_extlen_t)((1 << (l + 1)) - 1)),
 					len, &n, rbpp, rsb, prod, &r);
 			if (error) {
 				return error;
@@ -1020,7 +1020,7 @@ xfs_rtcheck_range(
 		/*
 		 * Compute first bit not examined.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min(bit + len, (xfs_extlen_t)XFS_NBWORD);
 		/*
 		 * Mask of relevant bits.
 		 */
@@ -1238,7 +1238,7 @@ xfs_rtfind_back(
 		 * Calculate first (leftmost) bit number to look at,
 		 * and mask for all the relevant bits in this word.
 		 */
-		firstbit = XFS_RTMAX((xfs_srtblock_t)(bit - len + 1), 0);
+		firstbit = max((xfs_srtblock_t)(bit - len + 1), (xfs_srtblock_t)0);
 		mask = (((xfs_rtword_t)1 << (bit - firstbit + 1)) - 1) <<
 			firstbit;
 		/*
@@ -1413,7 +1413,7 @@ xfs_rtfind_forw(
 		 * Calculate last (rightmost) bit number to look at,
 		 * and mask for all the relevant bits in this word.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min(bit + len, (xfs_rtblock_t)XFS_NBWORD);
 		mask = (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
 		/*
 		 * Calculate the difference between the value there
@@ -1724,7 +1724,7 @@ xfs_rtmodify_range(
 		/*
 		 * Compute first bit not changed and mask of relevant bits.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min(bit + len, (xfs_extlen_t)XFS_NBWORD);
 		mask = (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
 		/*
 		 * Set/clear the active bits.
@@ -1998,9 +1998,9 @@ xfs_growfs_rt(
 		nsbp->sb_rextsize = in->extsize;
 		nsbp->sb_rbmblocks = bmbno + 1;
 		nsbp->sb_rblocks =
-			XFS_RTMIN(nrblocks,
-				  nsbp->sb_rbmblocks * NBBY *
-				  nsbp->sb_blocksize * nsbp->sb_rextsize);
+			min(nrblocks,
+				  (xfs_drfsbno_t)(nsbp->sb_rbmblocks * NBBY *
+				  nsbp->sb_blocksize * nsbp->sb_rextsize));
 		nsbp->sb_rextents = nsbp->sb_rblocks;
 		do_div(nsbp->sb_rextents, nsbp->sb_rextsize);
 		nsbp->sb_rextslog = xfs_highbit32(nsbp->sb_rextents);
@@ -2424,7 +2424,7 @@ xfs_rtprint_summary(
 			if (c) {
 				if (!p) {
 					cmn_err(CE_DEBUG, "%Ld-%Ld:", 1LL << l,
-						XFS_RTMIN((1LL << l) +
+						min((1LL << l) +
 							  ((1LL << l) - 1LL),
 							 mp->m_sb.sb_rextents));
 					p = 1;
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.h linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.h
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.h	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.h	2006-10-18 11:25:46.000000000 +0530
@@ -57,9 +57,6 @@ struct xfs_trans;
 #define	XFS_BITTOWORD(mp,bi)	\
 	((int)(((bi) >> XFS_NBWORDLOG) & XFS_BLOCKWMASK(mp)))
 
-#define	XFS_RTMIN(a,b)	((a) < (b) ? (a) : (b))
-#define	XFS_RTMAX(a,b)	((a) > (b) ? (a) : (b))
-
 #define	XFS_RTLOBIT(w)	xfs_lowbit32(w)
 #define	XFS_RTHIBIT(w)	xfs_highbit32(w)
 




