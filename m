Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUHWKqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUHWKqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHWKmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:42:20 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:62418 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267662AbUHWKb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:31:29 -0400
Date: Mon, 23 Aug 2004 11:31:05 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 9/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/21 1.1812)
   NTFS: Rename vcn_to_lcn() to ntfs_vcn_to_lcn().
   
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
--- a/fs/ntfs/aops.c	2004-08-18 20:50:13 +01:00
+++ b/fs/ntfs/aops.c	2004-08-18 20:50:13 +01:00
@@ -232,7 +232,7 @@
 				/* Seek to element containing target vcn. */
 				while (rl->length && rl[1].vcn <= vcn)
 					rl++;
-				lcn = vcn_to_lcn(rl, vcn);
+				lcn = ntfs_vcn_to_lcn(rl, vcn);
 			} else
 				lcn = (LCN)LCN_RL_NOT_MAPPED;
 			/* Successful remap. */
@@ -266,15 +266,15 @@
 			}
 			/* Hard error, zero out region. */
 			SetPageError(page);
-			ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%llx) failed "
-					"with error code 0x%llx%s.",
+			ntfs_error(vol->sb, "ntfs_vcn_to_lcn(vcn = 0x%llx) "
+					"failed with error code 0x%llx%s.",
 					(unsigned long long)vcn,
 					(unsigned long long)-lcn,
 					is_retry ? " even after retrying" : "");
 			// FIXME: Depending on vol->on_errors, do something.
 		}
 		/*
-		 * Either iblock was outside lblock limits or vcn_to_lcn()
+		 * Either iblock was outside lblock limits or ntfs_vcn_to_lcn()
 		 * returned error. Just zero that portion of the page and set
 		 * the buffer uptodate.
 		 */
@@ -638,7 +638,7 @@
 			/* Seek to element containing target vcn. */
 			while (rl->length && rl[1].vcn <= vcn)
 				rl++;
-			lcn = vcn_to_lcn(rl, vcn);
+			lcn = ntfs_vcn_to_lcn(rl, vcn);
 		} else
 			lcn = (LCN)LCN_RL_NOT_MAPPED;
 		/* Successful remap. */
@@ -674,7 +674,7 @@
 		}
 		/* Failed to map the buffer, even after retrying. */
 		bh->b_blocknr = -1UL;
-		ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%llx) failed "
+		ntfs_error(vol->sb, "ntfs_vcn_to_lcn(vcn = 0x%llx) failed "
 				"with error code 0x%llx%s.",
 				(unsigned long long)vcn,
 				(unsigned long long)-lcn,
@@ -1404,7 +1404,7 @@
 				/* Seek to element containing target vcn. */
 				while (rl->length && rl[1].vcn <= vcn)
 					rl++;
-				lcn = vcn_to_lcn(rl, vcn);
+				lcn = ntfs_vcn_to_lcn(rl, vcn);
 			} else
 				lcn = (LCN)LCN_RL_NOT_MAPPED;
 			if (unlikely(lcn < 0)) {
@@ -1453,9 +1453,9 @@
 				 * retrying.
 				 */
 				bh->b_blocknr = -1UL;
-				ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%llx) "
-						"failed with error code "
-						"0x%llx%s.",
+				ntfs_error(vol->sb, "ntfs_vcn_to_lcn(vcn = "
+						"0x%llx) failed with error "
+						"code 0x%llx%s.",
 						(unsigned long long)vcn,
 						(unsigned long long)-lcn,
 						is_retry ? " even after "
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-08-18 20:50:13 +01:00
+++ b/fs/ntfs/attrib.c	2004-08-18 20:50:13 +01:00
@@ -939,6 +939,9 @@
  * Map the part of a run list containing the @vcn of the ntfs inode @ni.
  *
  * Return 0 on success and -errno on error.
+ *
+ * Locking: - The runlist must be unlocked on entry and is unlocked on return.
+ *	    - This function takes the lock for writing and modifies the runlist.
  */
 int ntfs_map_runlist(ntfs_inode *ni, VCN vcn)
 {
@@ -972,7 +975,7 @@
 
 	down_write(&ni->runlist.lock);
 	/* Make sure someone else didn't do the work while we were sleeping. */
-	if (likely(vcn_to_lcn(ni->runlist.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
+	if (likely(ntfs_vcn_to_lcn(ni->runlist.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
 		runlist_element *rl;
 
 		rl = decompress_mapping_pairs(ni->vol, ctx->attr,
@@ -991,7 +994,7 @@
 }
 
 /**
- * vcn_to_lcn - convert a vcn into a lcn given a run list
+ * ntfs_vcn_to_lcn - convert a vcn into a lcn given a run list
  * @rl:		run list to use for conversion
  * @vcn:	vcn to convert
  *
@@ -1009,9 +1012,11 @@
  *  -2 = LCN_RL_NOT_MAPPED	This is part of the run list which has not been
  *				inserted into the run list yet.
  *  -3 = LCN_ENOENT		There is no such vcn in the attribute.
- *  -4 = LCN_EINVAL		Input parameter error (if debug enabled).
+ *
+ * Locking: - The caller must have locked the runlist (for reading or writing).
+ *	    - This function does not touch the lock.
  */
-LCN vcn_to_lcn(const runlist_element *rl, const VCN vcn)
+LCN ntfs_vcn_to_lcn(const runlist_element *rl, const VCN vcn)
 {
 	int i;
 
@@ -1253,13 +1258,13 @@
 	rl = runlist->rl;
 	/* Read all clusters specified by the run list one run at a time. */
 	while (rl->length) {
-		lcn = vcn_to_lcn(rl, rl->vcn);
+		lcn = ntfs_vcn_to_lcn(rl, rl->vcn);
 		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
 				(unsigned long long)rl->vcn,
 				(unsigned long long)lcn);
 		/* The attribute list cannot be sparse. */
 		if (lcn < 0) {
-			ntfs_error(sb, "vcn_to_lcn() failed. Cannot read "
+			ntfs_error(sb, "ntfs_vcn_to_lcn() failed. Cannot read "
 					"attribute list.");
 			goto err_out;
 		}
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-08-18 20:50:13 +01:00
+++ b/fs/ntfs/attrib.h	2004-08-18 20:50:13 +01:00
@@ -40,7 +40,6 @@
 	LCN_HOLE		= -1,	/* Keep this as highest value or die! */
 	LCN_RL_NOT_MAPPED	= -2,
 	LCN_ENOENT		= -3,
-	LCN_EINVAL		= -4,
 } LCN_SPECIAL_VALUES;
 
 /**
@@ -77,7 +76,7 @@
 
 extern int ntfs_map_runlist(ntfs_inode *ni, VCN vcn);
 
-extern LCN vcn_to_lcn(const runlist_element *rl, const VCN vcn);
+extern LCN ntfs_vcn_to_lcn(const runlist_element *rl, const VCN vcn);
 
 extern BOOL find_attr(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-08-18 20:50:13 +01:00
+++ b/fs/ntfs/compress.c	2004-08-18 20:50:13 +01:00
@@ -600,7 +600,7 @@
 			/* Seek to element containing target vcn. */
 			while (rl->length && rl[1].vcn <= vcn)
 				rl++;
-			lcn = vcn_to_lcn(rl, vcn);
+			lcn = ntfs_vcn_to_lcn(rl, vcn);
 		} else
 			lcn = (LCN)LCN_RL_NOT_MAPPED;
 		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
@@ -926,8 +926,8 @@
 
 rl_err:
 	up_read(&ni->runlist.lock);
-	ntfs_error(vol->sb, "vcn_to_lcn() failed. Cannot read compression "
-			"block.");
+	ntfs_error(vol->sb, "ntfs_vcn_to_lcn() failed. Cannot read "
+			"compression block.");
 	goto err_out;
 
 getblk_err:
diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2004-08-18 20:50:13 +01:00
+++ b/fs/ntfs/debug.c	2004-08-18 20:50:13 +01:00
@@ -137,8 +137,7 @@
 {
 	int i;
 	const char *lcn_str[5] = { "LCN_HOLE         ", "LCN_RL_NOT_MAPPED",
-				   "LCN_ENOENT       ", "LCN_EINVAL       ",
-				   "LCN_unknown      " };
+				   "LCN_ENOENT       ", "LCN_unknown      " };
 
 	if (!debug_msgs)
 		return;
@@ -155,7 +154,7 @@
 		if (lcn < (LCN)0) {
 			int index = -lcn - 1;
 
-			if (index > -LCN_EINVAL - 1)
+			if (index > -LCN_ENOENT - 1)
 				index = 4;
 			printk(KERN_DEBUG "%-16Lx %s %-16Lx%s\n",
 				(rl + i)->vcn, lcn_str[index],
