Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUHWKsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUHWKsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUHWKqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:46:48 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:24740 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267671AbUHWKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:31:42 -0400
Date: Mon, 23 Aug 2004 11:31:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 10/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/22 1.1813)
   NTFS: Complete "run list" to "runlist" renaming.
   
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
--- a/fs/ntfs/aops.c	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/aops.c	2004-08-18 20:50:17 +01:00
@@ -197,7 +197,7 @@
 
 #ifdef DEBUG
 	if (unlikely(!ni->runlist.rl && !ni->mft_no && !NInoAttr(ni)))
-		panic("NTFS: $MFT/$DATA run list has been unmapped! This is a "
+		panic("NTFS: $MFT/$DATA runlist has been unmapped! This is a "
 				"very serious bug! Cannot continue...");
 #endif
 
@@ -252,11 +252,11 @@
 			/* It is a hole, need to zero it. */
 			if (lcn == LCN_HOLE)
 				goto handle_hole;
-			/* If first try and run list unmapped, map and retry. */
+			/* If first try and runlist unmapped, map and retry. */
 			if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
 				is_retry = TRUE;
 				/*
-				 * Attempt to map run list, dropping lock for
+				 * Attempt to map runlist, dropping lock for
 				 * the duration.
 				 */
 				up_read(&ni->runlist.lock);
@@ -659,11 +659,11 @@
 			err = -EOPNOTSUPP;
 			break;
 		}
-		/* If first try and run list unmapped, map and retry. */
+		/* If first try and runlist unmapped, map and retry. */
 		if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
 			is_retry = TRUE;
 			/*
-			 * Attempt to map run list, dropping lock for
+			 * Attempt to map runlist, dropping lock for
 			 * the duration.
 			 */
 			up_read(&ni->runlist.lock);
@@ -1439,7 +1439,7 @@
 						lcn == LCN_RL_NOT_MAPPED) {
 					is_retry = TRUE;
 					/*
-					 * Attempt to map run list, dropping
+					 * Attempt to map runlist, dropping
 					 * lock for the duration.
 					 */
 					up_read(&ni->runlist.lock);
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/attrib.c	2004-08-18 20:50:17 +01:00
@@ -29,7 +29,7 @@
 /**
  * ntfs_rl_mm - runlist memmove
  *
- * It is up to the caller to serialize access to the run list @base.
+ * It is up to the caller to serialize access to the runlist @base.
  */
 static inline void ntfs_rl_mm(runlist_element *base, int dst, int src,
 		int size)
@@ -41,7 +41,7 @@
 /**
  * ntfs_rl_mc - runlist memory copy
  *
- * It is up to the caller to serialize access to the run lists @dstbase and
+ * It is up to the caller to serialize access to the runlists @dstbase and
  * @srcbase.
  */
 static inline void ntfs_rl_mc(runlist_element *dstbase, int dst,
@@ -53,22 +53,22 @@
 
 /**
  * ntfs_rl_realloc - Reallocate memory for runlists
- * @rl:		original run list
- * @old_size:	number of run list elements in the original run list @rl
- * @new_size:	number of run list elements we need space for
+ * @rl:		original runlist
+ * @old_size:	number of runlist elements in the original runlist @rl
+ * @new_size:	number of runlist elements we need space for
  *
  * As the runlists grow, more memory will be required.  To prevent the
  * kernel having to allocate and reallocate large numbers of small bits of
  * memory, this function returns and entire page of memory.
  *
- * It is up to the caller to serialize access to the run list @rl.
+ * It is up to the caller to serialize access to the runlist @rl.
  *
  * N.B.  If the new allocation doesn't require a different number of pages in
  *       memory, the function will return the original pointer.
  *
  * On success, return a pointer to the newly allocated, or recycled, memory.
  * On error, return -errno. The following error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
 static inline runlist_element *ntfs_rl_realloc(runlist_element *rl,
@@ -95,17 +95,17 @@
 }
 
 /**
- * ntfs_are_rl_mergeable - test if two run lists can be joined together
- * @dst:	original run list
- * @src:	new run list to test for mergeability with @dst
+ * ntfs_are_rl_mergeable - test if two runlists can be joined together
+ * @dst:	original runlist
+ * @src:	new runlist to test for mergeability with @dst
  *
- * Test if two run lists can be joined together. For this, their VCNs and LCNs
+ * Test if two runlists can be joined together. For this, their VCNs and LCNs
  * must be adjacent.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * Return: TRUE   Success, the run lists can be merged.
- *	   FALSE  Failure, the run lists cannot be merged.
+ * Return: TRUE   Success, the runlists can be merged.
+ *	   FALSE  Failure, the runlists cannot be merged.
  */
 static inline BOOL ntfs_are_rl_mergeable(runlist_element *dst,
 		runlist_element *src)
@@ -124,15 +124,15 @@
 }
 
 /**
- * __ntfs_rl_merge - merge two run lists without testing if they can be merged
- * @dst:	original, destination run list
- * @src:	new run list to merge with @dst
- *
- * Merge the two run lists, writing into the destination run list @dst. The
- * caller must make sure the run lists can be merged or this will corrupt the
- * destination run list.
+ * __ntfs_rl_merge - merge two runlists without testing if they can be merged
+ * @dst:	original, destination runlist
+ * @src:	new runlist to merge with @dst
+ *
+ * Merge the two runlists, writing into the destination runlist @dst. The
+ * caller must make sure the runlists can be merged or this will corrupt the
+ * destination runlist.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  */
 static inline void __ntfs_rl_merge(runlist_element *dst, runlist_element *src)
 {
@@ -140,18 +140,18 @@
 }
 
 /**
- * ntfs_rl_merge - test if two run lists can be joined together and merge them
- * @dst:	original, destination run list
- * @src:	new run list to merge with @dst
+ * ntfs_rl_merge - test if two runlists can be joined together and merge them
+ * @dst:	original, destination runlist
+ * @src:	new runlist to merge with @dst
  *
- * Test if two run lists can be joined together. For this, their VCNs and LCNs
+ * Test if two runlists can be joined together. For this, their VCNs and LCNs
  * must be adjacent. If they can be merged, perform the merge, writing into
- * the destination run list @dst.
+ * the destination runlist @dst.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * Return: TRUE   Success, the run lists have been merged.
- *	   FALSE  Failure, the run lists cannot be merged and have not been
+ * Return: TRUE   Success, the runlists have been merged.
+ *	   FALSE  Failure, the runlists cannot be merged and have not been
  *		  modified.
  */
 static inline BOOL ntfs_rl_merge(runlist_element *dst, runlist_element *src)
@@ -164,27 +164,27 @@
 }
 
 /**
- * ntfs_rl_append - append a run list after a given element
- * @dst:	original run list to be worked on
+ * ntfs_rl_append - append a runlist after a given element
+ * @dst:	original runlist to be worked on
  * @dsize:	number of elements in @dst (including end marker)
- * @src:	run list to be inserted into @dst
+ * @src:	runlist to be inserted into @dst
  * @ssize:	number of elements in @src (excluding end marker)
- * @loc:	append the new run list @src after this element in @dst
+ * @loc:	append the new runlist @src after this element in @dst
  *
- * Append the run list @src after element @loc in @dst.  Merge the right end of
- * the new run list, if necessary. Adjust the size of the hole before the
- * appended run list.
+ * Append the runlist @src after element @loc in @dst.  Merge the right end of
+ * the new runlist, if necessary. Adjust the size of the hole before the
+ * appended runlist.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * On success, return a pointer to the new, combined, run list. Note, both
- * run lists @dst and @src are deallocated before returning so you cannot use
- * the pointers for anything any more. (Strictly speaking the returned run list
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
  * may be the same as @dst but this is irrelevant.)
  *
- * On error, return -errno. Both run lists are left unmodified. The following
+ * On error, return -errno. Both runlists are left unmodified. The following
  * error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
 static inline runlist_element *ntfs_rl_append(runlist_element *dst,
@@ -205,7 +205,7 @@
 		return dst;
 	/*
 	 * We are guaranteed to succeed from here so can start modifying the
-	 * original run lists.
+	 * original runlists.
 	 */
 
 	/* First, merge the right hand end, if necessary. */
@@ -229,27 +229,27 @@
 }
 
 /**
- * ntfs_rl_insert - insert a run list into another
- * @dst:	original run list to be worked on
+ * ntfs_rl_insert - insert a runlist into another
+ * @dst:	original runlist to be worked on
  * @dsize:	number of elements in @dst (including end marker)
- * @src:	new run list to be inserted
+ * @src:	new runlist to be inserted
  * @ssize:	number of elements in @src (excluding end marker)
- * @loc:	insert the new run list @src before this element in @dst
+ * @loc:	insert the new runlist @src before this element in @dst
  *
- * Insert the run list @src before element @loc in the run list @dst. Merge the
- * left end of the new run list, if necessary. Adjust the size of the hole
- * after the inserted run list.
+ * Insert the runlist @src before element @loc in the runlist @dst. Merge the
+ * left end of the new runlist, if necessary. Adjust the size of the hole
+ * after the inserted runlist.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * On success, return a pointer to the new, combined, run list. Note, both
- * run lists @dst and @src are deallocated before returning so you cannot use
- * the pointers for anything any more. (Strictly speaking the returned run list
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
  * may be the same as @dst but this is irrelevant.)
  *
- * On error, return -errno. Both run lists are left unmodified. The following
+ * On error, return -errno. Both runlists are left unmodified. The following
  * error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
 static inline runlist_element *ntfs_rl_insert(runlist_element *dst,
@@ -290,7 +290,7 @@
 		return dst;
 	/*
 	 * We are guaranteed to succeed from here so can start modifying the
-	 * original run list.
+	 * original runlist.
 	 */
 
 	if (left)
@@ -336,26 +336,26 @@
 }
 
 /**
- * ntfs_rl_replace - overwrite a runlist element with another run list
- * @dst:	original run list to be worked on
+ * ntfs_rl_replace - overwrite a runlist element with another runlist
+ * @dst:	original runlist to be worked on
  * @dsize:	number of elements in @dst (including end marker)
- * @src:	new run list to be inserted
+ * @src:	new runlist to be inserted
  * @ssize:	number of elements in @src (excluding end marker)
- * @loc:	index in run list @dst to overwrite with @src
+ * @loc:	index in runlist @dst to overwrite with @src
  *
- * Replace the run list element @dst at @loc with @src. Merge the left and
- * right ends of the inserted run list, if necessary.
+ * Replace the runlist element @dst at @loc with @src. Merge the left and
+ * right ends of the inserted runlist, if necessary.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * On success, return a pointer to the new, combined, run list. Note, both
- * run lists @dst and @src are deallocated before returning so you cannot use
- * the pointers for anything any more. (Strictly speaking the returned run list
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
  * may be the same as @dst but this is irrelevant.)
  *
- * On error, return -errno. Both run lists are left unmodified. The following
+ * On error, return -errno. Both runlists are left unmodified. The following
  * error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
 static inline runlist_element *ntfs_rl_replace(runlist_element *dst,
@@ -380,7 +380,7 @@
 		return dst;
 	/*
 	 * We are guaranteed to succeed from here so can start modifying the
-	 * original run lists.
+	 * original runlists.
 	 */
 	if (right)
 		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
@@ -401,27 +401,27 @@
 }
 
 /**
- * ntfs_rl_split - insert a run list into the centre of a hole
- * @dst:	original run list to be worked on
+ * ntfs_rl_split - insert a runlist into the centre of a hole
+ * @dst:	original runlist to be worked on
  * @dsize:	number of elements in @dst (including end marker)
- * @src:	new run list to be inserted
+ * @src:	new runlist to be inserted
  * @ssize:	number of elements in @src (excluding end marker)
- * @loc:	index in run list @dst at which to split and insert @src
+ * @loc:	index in runlist @dst at which to split and insert @src
  *
- * Split the run list @dst at @loc into two and insert @new in between the two
- * fragments. No merging of run lists is necessary. Adjust the size of the
+ * Split the runlist @dst at @loc into two and insert @new in between the two
+ * fragments. No merging of runlists is necessary. Adjust the size of the
  * holes either side.
  *
- * It is up to the caller to serialize access to the run lists @dst and @src.
+ * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * On success, return a pointer to the new, combined, run list. Note, both
- * run lists @dst and @src are deallocated before returning so you cannot use
- * the pointers for anything any more. (Strictly speaking the returned run list
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
  * may be the same as @dst but this is irrelevant.)
  *
- * On error, return -errno. Both run lists are left unmodified. The following
+ * On error, return -errno. Both runlists are left unmodified. The following
  * error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
  *	-EINVAL	- Invalid parameters were passed in.
  */
 static inline runlist_element *ntfs_rl_split(runlist_element *dst, int dsize,
@@ -436,7 +436,7 @@
 		return dst;
 	/*
 	 * We are guaranteed to succeed from here so can start modifying the
-	 * original run lists.
+	 * original runlists.
 	 */
 
 	/* Move the tail of @dst out of the way, then copy in @src. */
@@ -453,16 +453,16 @@
 
 /**
  * ntfs_merge_runlists - merge two runlists into one
- * @drl:	original run list to be worked on
- * @srl:	new run list to be merged into @drl
+ * @drl:	original runlist to be worked on
+ * @srl:	new runlist to be merged into @drl
  *
- * First we sanity check the two run lists @srl and @drl to make sure that they
- * are sensible and can be merged. The run list @srl must be either after the
- * run list @drl or completely within a hole (or unmapped region) in @drl.
+ * First we sanity check the two runlists @srl and @drl to make sure that they
+ * are sensible and can be merged. The runlist @srl must be either after the
+ * runlist @drl or completely within a hole (or unmapped region) in @drl.
  *
- * It is up to the caller to serialize access to the run lists @drl and @srl.
+ * It is up to the caller to serialize access to the runlists @drl and @srl.
  *
- * Merging of run lists is necessary in two cases:
+ * Merging of runlists is necessary in two cases:
  *   1. When attribute lists are used and a further extent is being mapped.
  *   2. When new clusters are allocated to fill a hole or extend a file.
  *
@@ -471,19 +471,19 @@
  *	- split the hole in two and be inserted between the two fragments,
  *	- be appended at the end of a hole, or it can
  *	- replace the whole hole.
- * It can also be appended to the end of the run list, which is just a variant
+ * It can also be appended to the end of the runlist, which is just a variant
  * of the insert case.
  *
- * On success, return a pointer to the new, combined, run list. Note, both
- * run lists @drl and @srl are deallocated before returning so you cannot use
- * the pointers for anything any more. (Strictly speaking the returned run list
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @drl and @srl are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
  * may be the same as @dst but this is irrelevant.)
  *
- * On error, return -errno. Both run lists are left unmodified. The following
+ * On error, return -errno. Both runlists are left unmodified. The following
  * error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
  *	-EINVAL	- Invalid parameters were passed in.
- *	-ERANGE	- The run lists overlap and cannot be merged.
+ *	-ERANGE	- The runlists overlap and cannot be merged.
  */
 runlist_element *ntfs_merge_runlists(runlist_element *drl,
 		runlist_element *srl)
@@ -513,15 +513,15 @@
 	/* Check for the case where the first mapping is being done now. */
 	if (unlikely(!drl)) {
 		drl = srl;
-		/* Complete the source run list if necessary. */
+		/* Complete the source runlist if necessary. */
 		if (unlikely(drl[0].vcn)) {
-			/* Scan to the end of the source run list. */
+			/* Scan to the end of the source runlist. */
 			for (dend = 0; likely(drl[dend].length); dend++)
 				;
 			drl = ntfs_rl_realloc(drl, dend, dend + 1);
 			if (IS_ERR(drl))
 				return drl;
-			/* Insert start element at the front of the run list. */
+			/* Insert start element at the front of the runlist. */
 			ntfs_rl_mm(drl, 1, 0, dend);
 			drl[0].vcn = 0;
 			drl[0].lcn = LCN_RL_NOT_MAPPED;
@@ -536,7 +536,7 @@
 	while (srl[si].length && srl[si].lcn < (LCN)LCN_HOLE)
 		si++;
 
-	/* Can't have an entirely unmapped source run list. */
+	/* Can't have an entirely unmapped source runlist. */
 	BUG_ON(!srl[si].length);
 
 	/* Record the starting points. */
@@ -560,7 +560,7 @@
 		return ERR_PTR(-ERANGE);
 	}
 
-	/* Scan to the end of both run lists in order to know their sizes. */
+	/* Scan to the end of both runlists in order to know their sizes. */
 	for (send = si; srl[send].length; send++)
 		;
 	for (dend = di; drl[dend].length; dend++)
@@ -631,7 +631,7 @@
 				goto finished;
 			}
 			/*
-			 * We need to create an unmapped run list element in
+			 * We need to create an unmapped runlist element in
 			 * @drl or extend an existing one before adding the
 			 * ENOENT terminator.
 			 */
@@ -640,7 +640,7 @@
 				slots = 1;
 			}
 			if (drl[ds].lcn != (LCN)LCN_RL_NOT_MAPPED) {
-				/* Add an unmapped run list element. */
+				/* Add an unmapped runlist element. */
 				if (!slots) {
 					/* FIXME/TODO: We need to have the
 					 * extra memory already! (AIA) */
@@ -677,7 +677,7 @@
 
 finished:
 	/* The merge was completed successfully. */
-	ntfs_debug("Merged run list:");
+	ntfs_debug("Merged runlist:");
 	ntfs_debug_dump_runlist(drl);
 	return drl;
 
@@ -688,32 +688,32 @@
 }
 
 /**
- * decompress_mapping_pairs - convert mapping pairs array to run list
+ * decompress_mapping_pairs - convert mapping pairs array to runlist
  * @vol:	ntfs volume on which the attribute resides
  * @attr:	attribute record whose mapping pairs array to decompress
- * @old_rl:	optional run list in which to insert @attr's run list
+ * @old_rl:	optional runlist in which to insert @attr's runlist
  *
- * It is up to the caller to serialize access to the run list @old_rl.
+ * It is up to the caller to serialize access to the runlist @old_rl.
  *
- * Decompress the attribute @attr's mapping pairs array into a run list. On
- * success, return the decompressed run list.
+ * Decompress the attribute @attr's mapping pairs array into a runlist. On
+ * success, return the decompressed runlist.
  *
- * If @old_rl is not NULL, decompressed run list is inserted into the
- * appropriate place in @old_rl and the resultant, combined run list is
+ * If @old_rl is not NULL, decompressed runlist is inserted into the
+ * appropriate place in @old_rl and the resultant, combined runlist is
  * returned. The original @old_rl is deallocated.
  *
  * On error, return -errno. @old_rl is left unmodified in that case.
  *
  * The following error codes are defined:
- *	-ENOMEM	- Not enough memory to allocate run list array.
- *	-EIO	- Corrupt run list.
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
+ *	-EIO	- Corrupt runlist.
  *	-EINVAL	- Invalid parameters were passed in.
- *	-ERANGE	- The two run lists overlap.
+ *	-ERANGE	- The two runlists overlap.
  *
  * FIXME: For now we take the conceptionally simplest approach of creating the
- * new run list disregarding the already existing one and then splicing the
+ * new runlist disregarding the already existing one and then splicing the
  * two into one, if that is possible (we check for overlap and discard the new
- * run list if overlap present before returning ERR_PTR(-ERANGE)).
+ * runlist if overlap present before returning ERR_PTR(-ERANGE)).
  */
 runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, runlist_element *old_rl)
@@ -721,11 +721,11 @@
 	VCN vcn;		/* Current vcn. */
 	LCN lcn;		/* Current lcn. */
 	s64 deltaxcn;		/* Change in [vl]cn. */
-	runlist_element *rl;	/* The output run list. */
+	runlist_element *rl;	/* The output runlist. */
 	u8 *buf;		/* Current position in mapping pairs array. */
 	u8 *attr_end;		/* End of attribute. */
-	int rlsize;		/* Size of run list buffer. */
-	u16 rlpos;		/* Current run list position in units of
+	int rlsize;		/* Size of runlist buffer. */
+	u16 rlpos;		/* Current runlist position in units of
 				   runlist_elements. */
 	u8 b;			/* Current byte offset in buf. */
 
@@ -748,9 +748,9 @@
 		ntfs_error(vol->sb, "Corrupt attribute.");
 		return ERR_PTR(-EIO);
 	}
-	/* Current position in run list array. */
+	/* Current position in runlist array. */
 	rlpos = 0;
-	/* Allocate first page and set current run list size to one page. */
+	/* Allocate first page and set current runlist size to one page. */
 	rl = ntfs_malloc_nofs(rlsize = PAGE_SIZE);
 	if (unlikely(!rl))
 		return ERR_PTR(-ENOMEM);
@@ -810,7 +810,7 @@
 			goto err_out;
 		}
 		/*
-		 * Enter the current run length into the current run list
+		 * Enter the current run length into the current runlist
 		 * element.
 		 */
 		rl[rlpos].length = deltaxcn;
@@ -866,7 +866,7 @@
 		goto io_error;
 	/*
 	 * If there is a highest_vcn specified, it must be equal to the final
-	 * vcn in the run list - 1, or something has gone badly wrong.
+	 * vcn in the runlist - 1, or something has gone badly wrong.
 	 */
 	deltaxcn = sle64_to_cpu(attr->data.non_resident.highest_vcn);
 	if (unlikely(deltaxcn && vcn - 1 != deltaxcn)) {
@@ -875,7 +875,7 @@
 				"non-resident attribute.");
 		goto err_out;
 	}
-	/* Setup not mapped run list element if this is the base extent. */
+	/* Setup not mapped runlist element if this is the base extent. */
 	if (!attr->data.non_resident.lowest_vcn) {
 		VCN max_cluster;
 
@@ -885,7 +885,7 @@
 				vol->cluster_size_bits;
 		/*
 		 * If there is a difference between the highest_vcn and the
-		 * highest cluster, the run list is either corrupt or, more
+		 * highest cluster, the runlist is either corrupt or, more
 		 * likely, there are more extents following this one.
 		 */
 		if (deltaxcn < --max_cluster) {
@@ -911,18 +911,18 @@
 	/* Setup terminating runlist element. */
 	rl[rlpos].vcn = vcn;
 	rl[rlpos].length = (s64)0;
-	/* If no existing run list was specified, we are done. */
+	/* If no existing runlist was specified, we are done. */
 	if (!old_rl) {
 		ntfs_debug("Mapping pairs array successfully decompressed:");
 		ntfs_debug_dump_runlist(rl);
 		return rl;
 	}
-	/* Now combine the new and old run lists checking for overlaps. */
+	/* Now combine the new and old runlists checking for overlaps. */
 	old_rl = ntfs_merge_runlists(old_rl, rl);
 	if (likely(!IS_ERR(old_rl)))
 		return old_rl;
 	ntfs_free(rl);
-	ntfs_error(vol->sb, "Failed to merge run lists.");
+	ntfs_error(vol->sb, "Failed to merge runlists.");
 	return old_rl;
 io_error:
 	ntfs_error(vol->sb, "Corrupt attribute.");
@@ -932,11 +932,11 @@
 }
 
 /**
- * ntfs_map_runlist - map (a part of) a run list of an ntfs inode
- * @ni:		ntfs inode for which to map (part of) a run list
- * @vcn:	map run list part containing this vcn
+ * ntfs_map_runlist - map (a part of) a runlist of an ntfs inode
+ * @ni:		ntfs inode for which to map (part of) a runlist
+ * @vcn:	map runlist part containing this vcn
  *
- * Map the part of a run list containing the @vcn of the ntfs inode @ni.
+ * Map the part of a runlist containing the @vcn of the ntfs inode @ni.
  *
  * Return 0 on success and -errno on error.
  *
@@ -950,7 +950,7 @@
 	MFT_RECORD *mrec;
 	int err = 0;
 
-	ntfs_debug("Mapping run list part containing vcn 0x%llx.",
+	ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
 			(unsigned long long)vcn);
 
 	if (!NInoAttr(ni))
@@ -994,23 +994,23 @@
 }
 
 /**
- * ntfs_vcn_to_lcn - convert a vcn into a lcn given a run list
- * @rl:		run list to use for conversion
+ * ntfs_vcn_to_lcn - convert a vcn into a lcn given a runlist
+ * @rl:		runlist to use for conversion
  * @vcn:	vcn to convert
  *
  * Convert the virtual cluster number @vcn of an attribute into a logical
- * cluster number (lcn) of a device using the run list @rl to map vcns to their
+ * cluster number (lcn) of a device using the runlist @rl to map vcns to their
  * corresponding lcns.
  *
- * It is up to the caller to serialize access to the run list @rl.
+ * It is up to the caller to serialize access to the runlist @rl.
  *
  * Since lcns must be >= 0, we use negative return values with special meaning:
  *
  * Return value			Meaning / Description
  * ==================================================
  *  -1 = LCN_HOLE		Hole / not allocated on disk.
- *  -2 = LCN_RL_NOT_MAPPED	This is part of the run list which has not been
- *				inserted into the run list yet.
+ *  -2 = LCN_RL_NOT_MAPPED	This is part of the runlist which has not been
+ *				inserted into the runlist yet.
  *  -3 = LCN_ENOENT		There is no such vcn in the attribute.
  *
  * Locking: - The caller must have locked the runlist (for reading or writing).
@@ -1022,7 +1022,7 @@
 
 	BUG_ON(vcn < 0);
 	/*
-	 * If rl is NULL, assume that we have found an unmapped run list. The
+	 * If rl is NULL, assume that we have found an unmapped runlist. The
 	 * caller can then attempt to map it and fail appropriately if
 	 * necessary.
 	 */
@@ -1216,12 +1216,12 @@
 /**
  * load_attribute_list - load an attribute list into memory
  * @vol:		ntfs volume from which to read
- * @runlist:		run list of the attribute list
+ * @runlist:		runlist of the attribute list
  * @al_start:		destination buffer
  * @size:		size of the destination buffer in bytes
  * @initialized_size:	initialized size of the attribute list
  *
- * Walk the run list @runlist and load all clusters from it copying them into
+ * Walk the runlist @runlist and load all clusters from it copying them into
  * the linear buffer @al. The maximum number of bytes copied to @al is @size
  * bytes. Note, @size does not need to be a multiple of the cluster size. If
  * @initialized_size is less than @size, the region in @al between
@@ -1256,7 +1256,7 @@
 	block_size_bits = sb->s_blocksize_bits;
 	down_read(&runlist->lock);
 	rl = runlist->rl;
-	/* Read all clusters specified by the run list one run at a time. */
+	/* Read all clusters specified by the runlist one run at a time. */
 	while (rl->length) {
 		lcn = ntfs_vcn_to_lcn(rl, rl->vcn);
 		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/compress.c	2004-08-18 20:50:17 +01:00
@@ -575,7 +575,7 @@
 	}
 
 	/*
-	 * We have the run list, and all the destination pages we need to fill.
+	 * We have the runlist, and all the destination pages we need to fill.
 	 * Now read the first compression block.
 	 */
 	cur_page = 0;
@@ -617,7 +617,7 @@
 				goto rl_err;
 			is_retry = TRUE;
 			/*
-			 * Attempt to map run list, dropping lock for the
+			 * Attempt to map runlist, dropping lock for the
 			 * duration.
 			 */
 			up_read(&ni->runlist.lock);
diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/debug.c	2004-08-18 20:50:17 +01:00
@@ -132,7 +132,7 @@
 	spin_unlock(&err_buf_lock);
 }
 
-/* Dump a run list. Caller has to provide synchronisation for @rl. */
+/* Dump a runlist. Caller has to provide synchronisation for @rl. */
 void ntfs_debug_dump_runlist(const runlist_element *rl)
 {
 	int i;
@@ -141,7 +141,7 @@
 
 	if (!debug_msgs)
 		return;
-	printk(KERN_DEBUG "NTFS-fs DEBUG: Dumping run list (values "
+	printk(KERN_DEBUG "NTFS-fs DEBUG: Dumping runlist (values "
 			"in hex):\n");
 	if (!rl) {
 		printk(KERN_DEBUG "Run list not present.\n");
@@ -159,12 +159,12 @@
 			printk(KERN_DEBUG "%-16Lx %s %-16Lx%s\n",
 				(rl + i)->vcn, lcn_str[index],
 				(rl + i)->length, (rl + i)->length ?
-				"" : " (run list end)");
+				"" : " (runlist end)");
 		} else
 			printk(KERN_DEBUG "%-16Lx %-16Lx  %-16Lx%s\n",
 				(rl + i)->vcn, (rl + i)->lcn,
 				(rl + i)->length, (rl + i)->length ?
-				"" : " (run list end)");
+				"" : " (runlist end)");
 		if (!(rl + i)->length)
 			break;
 	}
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/inode.c	2004-08-18 20:50:17 +01:00
@@ -680,7 +680,7 @@
 				goto unm_err_out;
 			}
 			/*
-			 * Setup the run list. No need for locking as we have
+			 * Setup the runlist. No need for locking as we have
 			 * exclusive access to the inode at this time.
 			 */
 			ni->attr_list_rl.rl = decompress_mapping_pairs(vol,
@@ -1757,7 +1757,7 @@
 						"You should run chkdsk.");
 				goto put_err_out;
 			}
-			/* Setup the run list. */
+			/* Setup the runlist. */
 			ni->attr_list_rl.rl = decompress_mapping_pairs(vol,
 					ctx->attr, NULL);
 			if (IS_ERR(ni->attr_list_rl.rl)) {
@@ -1885,7 +1885,7 @@
 		}
 		/*
 		 * Decompress the mapping pairs array of this extent and merge
-		 * the result into the existing run list. No need for locking
+		 * the result into the existing runlist. No need for locking
 		 * as we have exclusive access to the inode at this time and we
 		 * are a mount in progress task, too.
 		 */
@@ -2001,7 +2001,7 @@
 		goto put_err_out;
 	}
 	if (highest_vcn && highest_vcn != last_vcn - 1) {
-		ntfs_error(sb, "Failed to load the complete run list "
+		ntfs_error(sb, "Failed to load the complete runlist "
 				"for $MFT/$DATA. Driver bug or "
 				"corrupt $MFT. Run chkdsk.");
 		ntfs_debug("highest_vcn = 0x%llx, last_vcn - 1 = 0x%llx",
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/inode.h	2004-08-18 20:50:17 +01:00
@@ -57,11 +57,11 @@
 	ntfschar *name;		/* Attribute name of this fake inode. */
 	u32 name_len;		/* Attribute name length of this fake inode. */
 	runlist runlist;	/* If state has the NI_NonResident bit set,
-				   the run list of the unnamed data attribute
+				   the runlist of the unnamed data attribute
 				   (if a file) or of the index allocation
 				   attribute (directory) or of the attribute
 				   described by the fake inode (if NInoAttr()).
-				   If runlist.rl is NULL, the run list has not
+				   If runlist.rl is NULL, the runlist has not
 				   been read in yet or has been unmapped. If
 				   NI_NonResident is clear, the attribute is
 				   resident (file and fake inode) or there is
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/layout.h	2004-08-18 20:50:17 +01:00
@@ -545,7 +545,7 @@
  * can be stored:
  *
  *   1) The data in the block is all zero (a sparse block):
- *	  This is stored as a sparse block in the run list, i.e. the run list
+ *	  This is stored as a sparse block in the runlist, i.e. the runlist
  *	  entry has length = X and lcn = -1. The mapping pairs array actually
  *	  uses a delta_lcn value length of 0, i.e. delta_lcn is not present at
  *	  all, which is then interpreted by the driver as lcn = -1.
@@ -558,7 +558,7 @@
  *	  in clusters. I.e. if compression has a small effect so that the
  *	  compressed data still occupies X clusters, then the uncompressed data
  *	  is stored in the block.
- *	  This case is recognised by the fact that the run list entry has
+ *	  This case is recognised by the fact that the runlist entry has
  *	  length = X and lcn >= 0. The mapping pairs array stores this as
  *	  normal with a run length of X and some specific delta_lcn, i.e.
  *	  delta_lcn has to be present.
@@ -567,7 +567,7 @@
  *	  The common case. This case is recognised by the fact that the run
  *	  list entry has length L < X and lcn >= 0. The mapping pairs array
  *	  stores this as normal with a run length of X and some specific
- *	  delta_lcn, i.e. delta_lcn has to be present. This run list entry is
+ *	  delta_lcn, i.e. delta_lcn has to be present. This runlist entry is
  *	  immediately followed by a sparse entry with length = X - L and
  *	  lcn = -1. The latter entry is to make up the vcn counting to the
  *	  full compression block size X.
@@ -575,15 +575,15 @@
  * In fact, life is more complicated because adjacent entries of the same type
  * can be coalesced. This means that one has to keep track of the number of
  * clusters handled and work on a basis of X clusters at a time being one
- * block. An example: if length L > X this means that this particular run list
+ * block. An example: if length L > X this means that this particular runlist
  * entry contains a block of length X and part of one or more blocks of length
  * L - X. Another example: if length L < X, this does not necessarily mean that
  * the block is compressed as it might be that the lcn changes inside the block
- * and hence the following run list entry describes the continuation of the
+ * and hence the following runlist entry describes the continuation of the
  * potentially compressed block. The block would be compressed if the
- * following run list entry describes at least X - L sparse clusters, thus
+ * following runlist entry describes at least X - L sparse clusters, thus
  * making up the compression block length as described in point 3 above. (Of
- * course, there can be several run list entries with small lengths so that the
+ * course, there can be several runlist entries with small lengths so that the
  * sparse entry does not follow the first data containing entry with
  * length < X.)
  *
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/super.c	2004-08-18 20:50:17 +01:00
@@ -986,7 +986,7 @@
 	ntfs_unmap_page(mft_page);
 	ntfs_unmap_page(mirr_page);
 
-	/* Construct the mft mirror run list by hand. */
+	/* Construct the mft mirror runlist by hand. */
 	rl2[0].vcn = 0;
 	rl2[0].lcn = vol->mftmirr_lcn;
 	rl2[0].length = (vol->mftmirr_size * vol->mft_record_size +
@@ -996,12 +996,12 @@
 	rl2[1].length = 0;
 	/*
 	 * Because we have just read all of the mft mirror, we know we have
-	 * mapped the full run list for it.
+	 * mapped the full runlist for it.
 	 */
 	mirr_ni = NTFS_I(vol->mftmirr_ino);
 	down_read(&mirr_ni->runlist.lock);
 	rl = mirr_ni->runlist.rl;
-	/* Compare the two run lists.  They must be identical. */
+	/* Compare the two runlists.  They must be identical. */
 	i = 0;
 	do {
 		if (rl2[i].vcn != rl[i].vcn || rl2[i].lcn != rl[i].lcn ||
diff -Nru a/fs/ntfs/types.h b/fs/ntfs/types.h
--- a/fs/ntfs/types.h	2004-08-18 20:50:17 +01:00
+++ b/fs/ntfs/types.h	2004-08-18 20:50:17 +01:00
@@ -60,7 +60,7 @@
 
 /**
  * runlist - in memory vcn to lcn mapping array including a read/write lock
- * @rl:		pointer to an array of run list elements
+ * @rl:		pointer to an array of runlist elements
  * @lock:	read/write spinlock for serializing access to @rl
  *
  */
