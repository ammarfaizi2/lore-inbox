Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267758AbUHWKmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUHWKmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUHWKlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:41:03 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:8582 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267657AbUHWKan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:30:43 -0400
Date: Mon, 23 Aug 2004 11:30:36 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 7/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/21 1.1810)
   NTFS: Rename run_list to runlist everywhere to bring in line with libntfs.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/aops.c	2004-08-18 20:50:07 +01:00
@@ -170,7 +170,7 @@
 	LCN lcn;
 	ntfs_inode *ni;
 	ntfs_volume *vol;
-	run_list_element *rl;
+	runlist_element *rl;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	sector_t iblock, lblock, zblock;
 	unsigned int blocksize, vcn_ofs;
@@ -196,7 +196,7 @@
 	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
 
 #ifdef DEBUG
-	if (unlikely(!ni->run_list.rl && !ni->mft_no && !NInoAttr(ni)))
+	if (unlikely(!ni->runlist.rl && !ni->mft_no && !NInoAttr(ni)))
 		panic("NTFS: $MFT/$DATA run list has been unmapped! This is a "
 				"very serious bug! Cannot continue...");
 #endif
@@ -225,8 +225,8 @@
 					vol->cluster_size_mask;
 			if (!rl) {
 lock_retry_remap:
-				down_read(&ni->run_list.lock);
-				rl = ni->run_list.rl;
+				down_read(&ni->runlist.lock);
+				rl = ni->runlist.rl;
 			}
 			if (likely(rl != NULL)) {
 				/* Seek to element containing target vcn. */
@@ -259,8 +259,8 @@
 				 * Attempt to map run list, dropping lock for
 				 * the duration.
 				 */
-				up_read(&ni->run_list.lock);
-				if (!map_run_list(ni, vcn))
+				up_read(&ni->runlist.lock);
+				if (!map_runlist(ni, vcn))
 					goto lock_retry_remap;
 				rl = NULL;
 			}
@@ -291,7 +291,7 @@
 
 	/* Release the lock if we took it. */
 	if (rl)
-		up_read(&ni->run_list.lock);
+		up_read(&ni->runlist.lock);
 
 	/* Check we have at least one buffer ready for i/o. */
 	if (nr) {
@@ -473,7 +473,7 @@
 	struct inode *vi;
 	ntfs_inode *ni;
 	ntfs_volume *vol;
-	run_list_element *rl;
+	runlist_element *rl;
 	struct buffer_head *bh, *head;
 	unsigned int blocksize, vcn_ofs;
 	int err;
@@ -631,8 +631,8 @@
 				vol->cluster_size_mask;
 		if (!rl) {
 lock_retry_remap:
-			down_read(&ni->run_list.lock);
-			rl = ni->run_list.rl;
+			down_read(&ni->runlist.lock);
+			rl = ni->runlist.rl;
 		}
 		if (likely(rl != NULL)) {
 			/* Seek to element containing target vcn. */
@@ -666,8 +666,8 @@
 			 * Attempt to map run list, dropping lock for
 			 * the duration.
 			 */
-			up_read(&ni->run_list.lock);
-			err = map_run_list(ni, vcn);
+			up_read(&ni->runlist.lock);
+			err = map_runlist(ni, vcn);
 			if (likely(!err))
 				goto lock_retry_remap;
 			rl = NULL;
@@ -687,7 +687,7 @@
 
 	/* Release the lock if we took it. */
 	if (rl)
-		up_read(&ni->run_list.lock);
+		up_read(&ni->runlist.lock);
 
 	/* For the error case, need to reset bh to the beginning. */
 	bh = head;
@@ -1240,7 +1240,7 @@
 	struct inode *vi;
 	ntfs_inode *ni;
 	ntfs_volume *vol;
-	run_list_element *rl;
+	runlist_element *rl;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
 	unsigned int vcn_ofs, block_start, block_end, blocksize;
 	int err;
@@ -1397,8 +1397,8 @@
 			is_retry = FALSE;
 			if (!rl) {
 lock_retry_remap:
-				down_read(&ni->run_list.lock);
-				rl = ni->run_list.rl;
+				down_read(&ni->runlist.lock);
+				rl = ni->runlist.rl;
 			}
 			if (likely(rl != NULL)) {
 				/* Seek to element containing target vcn. */
@@ -1442,8 +1442,8 @@
 					 * Attempt to map run list, dropping
 					 * lock for the duration.
 					 */
-					up_read(&ni->run_list.lock);
-					err = map_run_list(ni, vcn);
+					up_read(&ni->runlist.lock);
+					err = map_runlist(ni, vcn);
 					if (likely(!err))
 						goto lock_retry_remap;
 					rl = NULL;
@@ -1530,7 +1530,7 @@
 
 	/* Release the lock if we took it. */
 	if (rl) {
-		up_read(&ni->run_list.lock);
+		up_read(&ni->runlist.lock);
 		rl = NULL;
 	}
 
@@ -1576,7 +1576,7 @@
 	if (is_retry)
 		flush_dcache_page(page);
 	if (rl)
-		up_read(&ni->run_list.lock);
+		up_read(&ni->runlist.lock);
 	return err;
 }
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/attrib.c	2004-08-18 20:50:07 +01:00
@@ -27,11 +27,11 @@
 /* Temporary helper functions -- might become macros */
 
 /**
- * ntfs_rl_mm - run_list memmove
+ * ntfs_rl_mm - runlist memmove
  *
  * It is up to the caller to serialize access to the run list @base.
  */
-static inline void ntfs_rl_mm(run_list_element *base, int dst, int src,
+static inline void ntfs_rl_mm(runlist_element *base, int dst, int src,
 		int size)
 {
 	if (likely((dst != src) && (size > 0)))
@@ -39,25 +39,25 @@
 }
 
 /**
- * ntfs_rl_mc - run_list memory copy
+ * ntfs_rl_mc - runlist memory copy
  *
  * It is up to the caller to serialize access to the run lists @dstbase and
  * @srcbase.
  */
-static inline void ntfs_rl_mc(run_list_element *dstbase, int dst,
-		run_list_element *srcbase, int src, int size)
+static inline void ntfs_rl_mc(runlist_element *dstbase, int dst,
+		runlist_element *srcbase, int src, int size)
 {
 	if (likely(size > 0))
 		memcpy(dstbase + dst, srcbase + src, size * sizeof(*dstbase));
 }
 
 /**
- * ntfs_rl_realloc - Reallocate memory for run_lists
+ * ntfs_rl_realloc - Reallocate memory for runlists
  * @rl:		original run list
  * @old_size:	number of run list elements in the original run list @rl
  * @new_size:	number of run list elements we need space for
  *
- * As the run_lists grow, more memory will be required.  To prevent the
+ * As the runlists grow, more memory will be required.  To prevent the
  * kernel having to allocate and reallocate large numbers of small bits of
  * memory, this function returns and entire page of memory.
  *
@@ -71,10 +71,10 @@
  *	-ENOMEM	- Not enough memory to allocate run list array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_realloc(run_list_element *rl,
+static inline runlist_element *ntfs_rl_realloc(runlist_element *rl,
 		int old_size, int new_size)
 {
-	run_list_element *new_rl;
+	runlist_element *new_rl;
 
 	old_size = PAGE_ALIGN(old_size * sizeof(*rl));
 	new_size = PAGE_ALIGN(new_size * sizeof(*rl));
@@ -107,8 +107,8 @@
  * Return: TRUE   Success, the run lists can be merged.
  *	   FALSE  Failure, the run lists cannot be merged.
  */
-static inline BOOL ntfs_are_rl_mergeable(run_list_element *dst,
-		run_list_element *src)
+static inline BOOL ntfs_are_rl_mergeable(runlist_element *dst,
+		runlist_element *src)
 {
 	BUG_ON(!dst);
 	BUG_ON(!src);
@@ -134,7 +134,7 @@
  *
  * It is up to the caller to serialize access to the run lists @dst and @src.
  */
-static inline void __ntfs_rl_merge(run_list_element *dst, run_list_element *src)
+static inline void __ntfs_rl_merge(runlist_element *dst, runlist_element *src)
 {
 	dst->length += src->length;
 }
@@ -154,7 +154,7 @@
  *	   FALSE  Failure, the run lists cannot be merged and have not been
  *		  modified.
  */
-static inline BOOL ntfs_rl_merge(run_list_element *dst, run_list_element *src)
+static inline BOOL ntfs_rl_merge(runlist_element *dst, runlist_element *src)
 {
 	BOOL merge = ntfs_are_rl_mergeable(dst, src);
 
@@ -187,8 +187,8 @@
  *	-ENOMEM	- Not enough memory to allocate run list array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_append(run_list_element *dst,
-		int dsize, run_list_element *src, int ssize, int loc)
+static inline runlist_element *ntfs_rl_append(runlist_element *dst,
+		int dsize, runlist_element *src, int ssize, int loc)
 {
 	BOOL right;
 	int magic;
@@ -252,8 +252,8 @@
  *	-ENOMEM	- Not enough memory to allocate run list array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_insert(run_list_element *dst,
-		int dsize, run_list_element *src, int ssize, int loc)
+static inline runlist_element *ntfs_rl_insert(runlist_element *dst,
+		int dsize, runlist_element *src, int ssize, int loc)
 {
 	BOOL left = FALSE;
 	BOOL disc = FALSE;	/* Discontinuity */
@@ -336,7 +336,7 @@
 }
 
 /**
- * ntfs_rl_replace - overwrite a run_list element with another run list
+ * ntfs_rl_replace - overwrite a runlist element with another run list
  * @dst:	original run list to be worked on
  * @dsize:	number of elements in @dst (including end marker)
  * @src:	new run list to be inserted
@@ -358,8 +358,8 @@
  *	-ENOMEM	- Not enough memory to allocate run list array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_replace(run_list_element *dst,
-		int dsize, run_list_element *src, int ssize, int loc)
+static inline runlist_element *ntfs_rl_replace(runlist_element *dst,
+		int dsize, runlist_element *src, int ssize, int loc)
 {
 	BOOL left = FALSE;
 	BOOL right;
@@ -424,8 +424,8 @@
  *	-ENOMEM	- Not enough memory to allocate run list array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_split(run_list_element *dst, int dsize,
-		run_list_element *src, int ssize, int loc)
+static inline runlist_element *ntfs_rl_split(runlist_element *dst, int dsize,
+		runlist_element *src, int ssize, int loc)
 {
 	BUG_ON(!dst);
 	BUG_ON(!src);
@@ -452,7 +452,7 @@
 }
 
 /**
- * ntfs_merge_run_lists - merge two run_lists into one
+ * ntfs_merge_runlists - merge two runlists into one
  * @drl:	original run list to be worked on
  * @srl:	new run list to be merged into @drl
  *
@@ -485,8 +485,8 @@
  *	-EINVAL	- Invalid parameters were passed in.
  *	-ERANGE	- The run lists overlap and cannot be merged.
  */
-run_list_element *ntfs_merge_run_lists(run_list_element *drl,
-		run_list_element *srl)
+runlist_element *ntfs_merge_runlists(runlist_element *drl,
+		runlist_element *srl)
 {
 	int di, si;		/* Current index into @[ds]rl. */
 	int sstart;		/* First index with lcn > LCN_RL_NOT_MAPPED. */
@@ -532,7 +532,7 @@
 
 	si = di = 0;
 
-	/* Skip any unmapped start element(s) in the source run_list. */
+	/* Skip any unmapped start element(s) in the source runlist. */
 	while (srl[si].length && srl[si].lcn < (LCN)LCN_HOLE)
 		si++;
 
@@ -715,18 +715,18 @@
  * two into one, if that is possible (we check for overlap and discard the new
  * run list if overlap present before returning ERR_PTR(-ERANGE)).
  */
-run_list_element *decompress_mapping_pairs(const ntfs_volume *vol,
-		const ATTR_RECORD *attr, run_list_element *old_rl)
+runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
+		const ATTR_RECORD *attr, runlist_element *old_rl)
 {
 	VCN vcn;		/* Current vcn. */
 	LCN lcn;		/* Current lcn. */
 	s64 deltaxcn;		/* Change in [vl]cn. */
-	run_list_element *rl;	/* The output run list. */
+	runlist_element *rl;	/* The output run list. */
 	u8 *buf;		/* Current position in mapping pairs array. */
 	u8 *attr_end;		/* End of attribute. */
 	int rlsize;		/* Size of run list buffer. */
 	u16 rlpos;		/* Current run list position in units of
-				   run_list_elements. */
+				   runlist_elements. */
 	u8 b;			/* Current byte offset in buf. */
 
 #ifdef DEBUG
@@ -768,7 +768,7 @@
 		 * operates on whole pages only.
 		 */
 		if (((rlpos + 3) * sizeof(*old_rl)) > rlsize) {
-			run_list_element *rl2;
+			runlist_element *rl2;
 
 			rl2 = ntfs_malloc_nofs(rlsize + (int)PAGE_SIZE);
 			if (unlikely(!rl2)) {
@@ -780,7 +780,7 @@
 			rl = rl2;
 			rlsize += PAGE_SIZE;
 		}
-		/* Enter the current vcn into the current run_list element. */
+		/* Enter the current vcn into the current runlist element. */
 		rl[rlpos].vcn = vcn;
 		/*
 		 * Get the change in vcn, i.e. the run length in clusters.
@@ -854,10 +854,10 @@
 						"mapping pairs array.");
 				goto err_out;
 			}
-			/* Enter the current lcn into the run_list element. */
+			/* Enter the current lcn into the runlist element. */
 			rl[rlpos].lcn = lcn;
 		}
-		/* Get to the next run_list element. */
+		/* Get to the next runlist element. */
 		rlpos++;
 		/* Increment the buffer position to the next mapping pair. */
 		buf += (*buf & 0xf) + ((*buf >> 4) & 0xf) + 1;
@@ -908,7 +908,7 @@
 	} else /* Not the base extent. There may be more extents to follow. */
 		rl[rlpos].lcn = (LCN)LCN_RL_NOT_MAPPED;
 
-	/* Setup terminating run_list element. */
+	/* Setup terminating runlist element. */
 	rl[rlpos].vcn = vcn;
 	rl[rlpos].length = (s64)0;
 	/* If no existing run list was specified, we are done. */
@@ -918,7 +918,7 @@
 		return rl;
 	}
 	/* Now combine the new and old run lists checking for overlaps. */
-	old_rl = ntfs_merge_run_lists(old_rl, rl);
+	old_rl = ntfs_merge_runlists(old_rl, rl);
 	if (likely(!IS_ERR(old_rl)))
 		return old_rl;
 	ntfs_free(rl);
@@ -932,15 +932,15 @@
 }
 
 /**
- * map_run_list - map (a part of) a run list of an ntfs inode
+ * map_runlist - map (a part of) a run list of an ntfs inode
  * @ni:		ntfs inode for which to map (part of) a run list
  * @vcn:	map run list part containing this vcn
  *
- * Map the part of a run list containing the @vcn of an the ntfs inode @ni.
+ * Map the part of a run list containing the @vcn of the ntfs inode @ni.
  *
  * Return 0 on success and -errno on error.
  */
-int map_run_list(ntfs_inode *ni, VCN vcn)
+int map_runlist(ntfs_inode *ni, VCN vcn)
 {
 	ntfs_inode *base_ni;
 	attr_search_context *ctx;
@@ -970,19 +970,19 @@
 		goto err_out;
 	}
 
-	down_write(&ni->run_list.lock);
+	down_write(&ni->runlist.lock);
 	/* Make sure someone else didn't do the work while we were sleeping. */
-	if (likely(vcn_to_lcn(ni->run_list.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
-		run_list_element *rl;
+	if (likely(vcn_to_lcn(ni->runlist.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
+		runlist_element *rl;
 
 		rl = decompress_mapping_pairs(ni->vol, ctx->attr,
-				ni->run_list.rl);
+				ni->runlist.rl);
 		if (unlikely(IS_ERR(rl)))
 			err = PTR_ERR(rl);
 		else
-			ni->run_list.rl = rl;
+			ni->runlist.rl = rl;
 	}
-	up_write(&ni->run_list.lock);
+	up_write(&ni->runlist.lock);
 
 	put_attr_search_ctx(ctx);
 err_out:
@@ -1011,14 +1011,11 @@
  *  -3 = LCN_ENOENT		There is no such vcn in the attribute.
  *  -4 = LCN_EINVAL		Input parameter error (if debug enabled).
  */
-LCN vcn_to_lcn(const run_list_element *rl, const VCN vcn)
+LCN vcn_to_lcn(const runlist_element *rl, const VCN vcn)
 {
 	int i;
 
-#ifdef DEBUG
-	if (vcn < (VCN)0)
-		return (LCN)LCN_EINVAL;
-#endif
+	BUG_ON(vcn < 0);
 	/*
 	 * If rl is NULL, assume that we have found an unmapped run list. The
 	 * caller can then attempt to map it and fail appropriately if
@@ -1214,12 +1211,12 @@
 /**
  * load_attribute_list - load an attribute list into memory
  * @vol:		ntfs volume from which to read
- * @run_list:		run list of the attribute list
+ * @runlist:		run list of the attribute list
  * @al_start:		destination buffer
  * @size:		size of the destination buffer in bytes
  * @initialized_size:	initialized size of the attribute list
  *
- * Walk the run list @run_list and load all clusters from it copying them into
+ * Walk the run list @runlist and load all clusters from it copying them into
  * the linear buffer @al. The maximum number of bytes copied to @al is @size
  * bytes. Note, @size does not need to be a multiple of the cluster size. If
  * @initialized_size is less than @size, the region in @al between
@@ -1227,13 +1224,13 @@
  *
  * Return 0 on success or -errno on error.
  */
-int load_attribute_list(ntfs_volume *vol, run_list *run_list, u8 *al_start,
+int load_attribute_list(ntfs_volume *vol, runlist *runlist, u8 *al_start,
 		const s64 size, const s64 initialized_size)
 {
 	LCN lcn;
 	u8 *al = al_start;
 	u8 *al_end = al + initialized_size;
-	run_list_element *rl;
+	runlist_element *rl;
 	struct buffer_head *bh;
 	struct super_block *sb;
 	unsigned long block_size;
@@ -1242,7 +1239,7 @@
 	unsigned char block_size_bits;
 
 	ntfs_debug("Entering.");
-	if (!vol || !run_list || !al || size <= 0 || initialized_size < 0 ||
+	if (!vol || !runlist || !al || size <= 0 || initialized_size < 0 ||
 			initialized_size > size)
 		return -EINVAL;
 	if (!initialized_size) {
@@ -1252,8 +1249,8 @@
 	sb = vol->sb;
 	block_size = sb->s_blocksize;
 	block_size_bits = sb->s_blocksize_bits;
-	down_read(&run_list->lock);
-	rl = run_list->rl;
+	down_read(&runlist->lock);
+	rl = runlist->rl;
 	/* Read all clusters specified by the run list one run at a time. */
 	while (rl->length) {
 		lcn = vcn_to_lcn(rl, rl->vcn);
@@ -1292,7 +1289,7 @@
 		memset(al_start + initialized_size, 0, size - initialized_size);
 	}
 done:
-	up_read(&run_list->lock);
+	up_read(&runlist->lock);
 	return err;
 do_final:
 	if (al < al_end) {
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/attrib.h	2004-08-18 20:50:07 +01:00
@@ -30,7 +30,7 @@
 #include "types.h"
 #include "layout.h"
 
-static inline void init_run_list(run_list *rl)
+static inline void init_runlist(runlist *rl)
 {
 	rl->rl = NULL;
 	init_rwsem(&rl->lock);
@@ -72,12 +72,12 @@
 	ATTR_RECORD *base_attr;
 } attr_search_context;
 
-extern run_list_element *decompress_mapping_pairs(const ntfs_volume *vol,
-		const ATTR_RECORD *attr, run_list_element *old_rl);
+extern runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
+		const ATTR_RECORD *attr, runlist_element *old_rl);
 
-extern int map_run_list(ntfs_inode *ni, VCN vcn);
+extern int map_runlist(ntfs_inode *ni, VCN vcn);
 
-extern LCN vcn_to_lcn(const run_list_element *rl, const VCN vcn);
+extern LCN vcn_to_lcn(const runlist_element *rl, const VCN vcn);
 
 extern BOOL find_attr(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
@@ -88,7 +88,7 @@
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		attr_search_context *ctx);
 
-extern int load_attribute_list(ntfs_volume *vol, run_list *rl, u8 *al_start,
+extern int load_attribute_list(ntfs_volume *vol, runlist *rl, u8 *al_start,
 		const s64 size, const s64 initialized_size);
 
 static inline s64 attribute_value_length(const ATTR_RECORD *a)
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/compress.c	2004-08-18 20:50:07 +01:00
@@ -478,7 +478,7 @@
 	ntfs_inode *ni = NTFS_I(mapping->host);
 	ntfs_volume *vol = ni->vol;
 	struct super_block *sb = vol->sb;
-	run_list_element *rl;
+	runlist_element *rl;
 	unsigned long block_size = sb->s_blocksize;
 	unsigned char block_size_bits = sb->s_blocksize_bits;
 	u8 *cb, *cb_pos, *cb_end;
@@ -593,8 +593,8 @@
 
 		if (!rl) {
 lock_retry_remap:
-			down_read(&ni->run_list.lock);
-			rl = ni->run_list.rl;
+			down_read(&ni->runlist.lock);
+			rl = ni->runlist.rl;
 		}
 		if (likely(rl != NULL)) {
 			/* Seek to element containing target vcn. */
@@ -620,8 +620,8 @@
 			 * Attempt to map run list, dropping lock for the
 			 * duration.
 			 */
-			up_read(&ni->run_list.lock);
-			if (!map_run_list(ni, vcn))
+			up_read(&ni->runlist.lock);
+			if (!map_runlist(ni, vcn))
 				goto lock_retry_remap;
 			goto map_rl_err;
 		}
@@ -638,7 +638,7 @@
 
 	/* Release the lock if we took it. */
 	if (rl)
-		up_read(&ni->run_list.lock);
+		up_read(&ni->runlist.lock);
 
 	/* Setup and initiate io on all buffer heads. */
 	for (i = 0; i < nr_bhs; i++) {
@@ -920,18 +920,18 @@
 	goto err_out;
 
 map_rl_err:
-	ntfs_error(vol->sb, "map_run_list() failed. Cannot read compression "
+	ntfs_error(vol->sb, "map_runlist() failed. Cannot read compression "
 			"block.");
 	goto err_out;
 
 rl_err:
-	up_read(&ni->run_list.lock);
+	up_read(&ni->runlist.lock);
 	ntfs_error(vol->sb, "vcn_to_lcn() failed. Cannot read compression "
 			"block.");
 	goto err_out;
 
 getblk_err:
-	up_read(&ni->run_list.lock);
+	up_read(&ni->runlist.lock);
 	ntfs_error(vol->sb, "getblk() failed. Cannot read compression block.");
 
 err_out:
diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/debug.c	2004-08-18 20:50:07 +01:00
@@ -133,7 +133,7 @@
 }
 
 /* Dump a run list. Caller has to provide synchronisation for @rl. */
-void ntfs_debug_dump_runlist(const run_list_element *rl)
+void ntfs_debug_dump_runlist(const runlist_element *rl)
 {
 	int i;
 	const char *lcn_str[5] = { "LCN_HOLE         ", "LCN_RL_NOT_MAPPED",
diff -Nru a/fs/ntfs/debug.h b/fs/ntfs/debug.h
--- a/fs/ntfs/debug.h	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/debug.h	2004-08-18 20:50:07 +01:00
@@ -51,7 +51,7 @@
 #define ntfs_debug(f, a...)						\
 	__ntfs_debug(__FILE__, __LINE__, __FUNCTION__, f, ##a)
 
-extern void ntfs_debug_dump_runlist(const run_list_element *rl);
+extern void ntfs_debug_dump_runlist(const runlist_element *rl);
 
 #else	/* !DEBUG */
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/inode.c	2004-08-18 20:50:07 +01:00
@@ -372,13 +372,13 @@
 	ni->seq_no = 0;
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
-	init_run_list(&ni->run_list);
+	init_runlist(&ni->runlist);
 	init_MUTEX(&ni->mrec_lock);
 	ni->page = NULL;
 	ni->page_ofs = 0;
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
-	init_run_list(&ni->attr_list_rl);
+	init_runlist(&ni->attr_list_rl);
 	ni->itype.index.bmp_ino = NULL;
 	ni->itype.index.block_size = 0;
 	ni->itype.index.vcn_size = 0;
@@ -1628,7 +1628,7 @@
  * We solve these problems by starting with the $DATA attribute before anything
  * else and iterating using lookup_attr($DATA) over all extents. As each extent
  * is found, we decompress_mapping_pairs() including the implied
- * merge_run_lists(). Each step of the iteration necessarily provides
+ * merge_runlists(). Each step of the iteration necessarily provides
  * sufficient information for the next step to complete.
  *
  * This should work but there are two possible pit falls (see inline comments
@@ -1861,7 +1861,7 @@
 	attr = NULL;
 	next_vcn = last_vcn = highest_vcn = 0;
 	while (lookup_attr(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0, ctx)) {
-		run_list_element *nrl;
+		runlist_element *nrl;
 
 		/* Cache the current attribute. */
 		attr = ctx->attr;
@@ -1889,14 +1889,14 @@
 		 * as we have exclusive access to the inode at this time and we
 		 * are a mount in progress task, too.
 		 */
-		nrl = decompress_mapping_pairs(vol, attr, ni->run_list.rl);
+		nrl = decompress_mapping_pairs(vol, attr, ni->runlist.rl);
 		if (IS_ERR(nrl)) {
 			ntfs_error(sb, "decompress_mapping_pairs() failed with "
 					"error code %ld. $MFT is corrupt.",
 					PTR_ERR(nrl));
 			goto put_err_out;
 		}
-		ni->run_list.rl = nrl;
+		ni->runlist.rl = nrl;
 
 		/* Are we in the first extent? */
 		if (!next_vcn) {
@@ -1932,7 +1932,7 @@
 			}
 			vol->nr_mft_records = ll;
 			/*
-			 * We have got the first extent of the run_list for
+			 * We have got the first extent of the runlist for
 			 * $MFT which means it is now relatively safe to call
 			 * the normal ntfs_read_inode() function.
 			 * Complete reading the inode, this will actually
@@ -2073,12 +2073,12 @@
 void __ntfs_clear_inode(ntfs_inode *ni)
 {
 	/* Free all alocated memory. */
-	down_write(&ni->run_list.lock);
-	if (ni->run_list.rl) {
-		ntfs_free(ni->run_list.rl);
-		ni->run_list.rl = NULL;
+	down_write(&ni->runlist.lock);
+	if (ni->runlist.rl) {
+		ntfs_free(ni->runlist.rl);
+		ni->runlist.rl = NULL;
 	}
-	up_write(&ni->run_list.lock);
+	up_write(&ni->runlist.lock);
 
 	if (ni->attr_list) {
 		ntfs_free(ni->attr_list);
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/inode.h	2004-08-18 20:50:07 +01:00
@@ -56,18 +56,18 @@
 	ATTR_TYPES type;	/* Attribute type of this fake inode. */
 	ntfschar *name;		/* Attribute name of this fake inode. */
 	u32 name_len;		/* Attribute name length of this fake inode. */
-	run_list run_list;	/* If state has the NI_NonResident bit set,
+	runlist runlist;	/* If state has the NI_NonResident bit set,
 				   the run list of the unnamed data attribute
 				   (if a file) or of the index allocation
 				   attribute (directory) or of the attribute
 				   described by the fake inode (if NInoAttr()).
-				   If run_list.rl is NULL, the run list has not
+				   If runlist.rl is NULL, the run list has not
 				   been read in yet or has been unmapped. If
 				   NI_NonResident is clear, the attribute is
 				   resident (file and fake inode) or there is
 				   no $I30 index allocation attribute
 				   (small directory). In the latter case
-				   run_list.rl is always NULL.*/
+				   runlist.rl is always NULL.*/
 	/*
 	 * The following fields are only valid for real inodes and extent
 	 * inodes.
@@ -88,7 +88,7 @@
 	 */
 	u32 attr_list_size;	/* Length of attribute list value in bytes. */
 	u8 *attr_list;		/* Attribute list value itself. */
-	run_list attr_list_rl;	/* Run list for the attribute list value. */
+	runlist attr_list_rl;	/* Run list for the attribute list value. */
 	union {
 		struct { /* It is a directory, $MFT, or an index inode. */
 			struct inode *bmp_ino;	/* Attribute inode for the
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/super.c	2004-08-18 20:50:07 +01:00
@@ -913,7 +913,7 @@
 	ntfs_inode *mirr_ni;
 	struct page *mft_page, *mirr_page;
 	u8 *kmft, *kmirr;
-	run_list_element *rl, rl2[2];
+	runlist_element *rl, rl2[2];
 	int mrecs_per_page, i;
 
 	ntfs_debug("Entering.");
@@ -999,8 +999,8 @@
 	 * mapped the full run list for it.
 	 */
 	mirr_ni = NTFS_I(vol->mftmirr_ino);
-	down_read(&mirr_ni->run_list.lock);
-	rl = mirr_ni->run_list.rl;
+	down_read(&mirr_ni->runlist.lock);
+	rl = mirr_ni->runlist.rl;
 	/* Compare the two run lists.  They must be identical. */
 	i = 0;
 	do {
@@ -1008,11 +1008,11 @@
 				rl2[i].length != rl[i].length) {
 			ntfs_error(sb, "$MFTMirr location mismatch.  "
 					"Run chkdsk.");
-			up_read(&mirr_ni->run_list.lock);
+			up_read(&mirr_ni->runlist.lock);
 			return FALSE;
 		}
 	} while (rl2[i++].length);
-	up_read(&mirr_ni->run_list.lock);
+	up_read(&mirr_ni->runlist.lock);
 	ntfs_debug("Done.");
 	return TRUE;
 }
diff -Nru a/fs/ntfs/types.h b/fs/ntfs/types.h
--- a/fs/ntfs/types.h	2004-08-18 20:50:07 +01:00
+++ b/fs/ntfs/types.h	2004-08-18 20:50:07 +01:00
@@ -42,7 +42,7 @@
 typedef s64 LSN;
 
 /**
- * run_list_element - in memory vcn to lcn mapping array element
+ * runlist_element - in memory vcn to lcn mapping array element
  * @vcn:	starting vcn of the current array element
  * @lcn:	starting lcn of the current array element
  * @length:	length in clusters of the current array element
@@ -56,18 +56,18 @@
 	VCN vcn;	/* vcn = Starting virtual cluster number. */
 	LCN lcn;	/* lcn = Starting logical cluster number. */
 	s64 length;	/* Run length in clusters. */
-} run_list_element;
+} runlist_element;
 
 /**
- * run_list - in memory vcn to lcn mapping array including a read/write lock
+ * runlist - in memory vcn to lcn mapping array including a read/write lock
  * @rl:		pointer to an array of run list elements
  * @lock:	read/write spinlock for serializing access to @rl
  *
  */
 typedef struct {
-	run_list_element *rl;
+	runlist_element *rl;
 	struct rw_semaphore lock;
-} run_list;
+} runlist;
 
 typedef enum {
 	FALSE = 0,
