Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUHWKmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUHWKmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHWKla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:41:30 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:50310 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267659AbUHWKbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:31:15 -0400
Date: Mon, 23 Aug 2004 11:30:50 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 8/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/21 1.1811)
   NTFS: Rename map_runlist() to ntfs_map_runlist().
   
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
--- a/fs/ntfs/aops.c	2004-08-18 20:50:10 +01:00
+++ b/fs/ntfs/aops.c	2004-08-18 20:50:10 +01:00
@@ -260,7 +260,7 @@
 				 * the duration.
 				 */
 				up_read(&ni->runlist.lock);
-				if (!map_runlist(ni, vcn))
+				if (!ntfs_map_runlist(ni, vcn))
 					goto lock_retry_remap;
 				rl = NULL;
 			}
@@ -667,7 +667,7 @@
 			 * the duration.
 			 */
 			up_read(&ni->runlist.lock);
-			err = map_runlist(ni, vcn);
+			err = ntfs_map_runlist(ni, vcn);
 			if (likely(!err))
 				goto lock_retry_remap;
 			rl = NULL;
@@ -1443,7 +1443,7 @@
 					 * lock for the duration.
 					 */
 					up_read(&ni->runlist.lock);
-					err = map_runlist(ni, vcn);
+					err = ntfs_map_runlist(ni, vcn);
 					if (likely(!err))
 						goto lock_retry_remap;
 					rl = NULL;
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-08-18 20:50:10 +01:00
+++ b/fs/ntfs/attrib.c	2004-08-18 20:50:10 +01:00
@@ -932,7 +932,7 @@
 }
 
 /**
- * map_runlist - map (a part of) a run list of an ntfs inode
+ * ntfs_map_runlist - map (a part of) a run list of an ntfs inode
  * @ni:		ntfs inode for which to map (part of) a run list
  * @vcn:	map run list part containing this vcn
  *
@@ -940,7 +940,7 @@
  *
  * Return 0 on success and -errno on error.
  */
-int map_runlist(ntfs_inode *ni, VCN vcn)
+int ntfs_map_runlist(ntfs_inode *ni, VCN vcn)
 {
 	ntfs_inode *base_ni;
 	attr_search_context *ctx;
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-08-18 20:50:10 +01:00
+++ b/fs/ntfs/attrib.h	2004-08-18 20:50:10 +01:00
@@ -75,7 +75,7 @@
 extern runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, runlist_element *old_rl);
 
-extern int map_runlist(ntfs_inode *ni, VCN vcn);
+extern int ntfs_map_runlist(ntfs_inode *ni, VCN vcn);
 
 extern LCN vcn_to_lcn(const runlist_element *rl, const VCN vcn);
 
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-08-18 20:50:10 +01:00
+++ b/fs/ntfs/compress.c	2004-08-18 20:50:10 +01:00
@@ -621,7 +621,7 @@
 			 * duration.
 			 */
 			up_read(&ni->runlist.lock);
-			if (!map_runlist(ni, vcn))
+			if (!ntfs_map_runlist(ni, vcn))
 				goto lock_retry_remap;
 			goto map_rl_err;
 		}
@@ -920,8 +920,8 @@
 	goto err_out;
 
 map_rl_err:
-	ntfs_error(vol->sb, "map_runlist() failed. Cannot read compression "
-			"block.");
+	ntfs_error(vol->sb, "ntfs_map_runlist() failed. Cannot read "
+			"compression block.");
 	goto err_out;
 
 rl_err:
