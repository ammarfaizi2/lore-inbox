Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUJSJzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUJSJzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUJSJxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:53:01 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:20421 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268129AbUJSJlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:41:39 -0400
Date: Tue, 19 Oct 2004 10:41:27 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 11/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 11/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/01 1.2011.1.1)
   NTFS: Remove unnecessary casts from LCN_* constants.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:45 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:45 +01:00
@@ -43,6 +43,7 @@
 	- Implement the equivalent of memset() for an ntfs attribute in
 	  fs/ntfs/attrib.[hc]::ntfs_attr_set() and switch
 	  fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
+	- Remove unnecessary casts from LCN_* constants.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:13:45 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:13:45 +01:00
@@ -234,7 +234,7 @@
 					rl++;
 				lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 			} else
-				lcn = (LCN)LCN_RL_NOT_MAPPED;
+				lcn = LCN_RL_NOT_MAPPED;
 			/* Successful remap. */
 			if (lcn >= 0) {
 				/* Setup buffer head to correct block. */
@@ -639,7 +639,7 @@
 				rl++;
 			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 		} else
-			lcn = (LCN)LCN_RL_NOT_MAPPED;
+			lcn = LCN_RL_NOT_MAPPED;
 		/* Successful remap. */
 		if (lcn >= 0) {
 			/* Setup buffer head to point to correct block. */
@@ -1404,7 +1404,7 @@
 					rl++;
 				lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 			} else
-				lcn = (LCN)LCN_RL_NOT_MAPPED;
+				lcn = LCN_RL_NOT_MAPPED;
 			if (unlikely(lcn < 0)) {
 				/*
 				 * We extended the attribute allocation above.
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-19 10:13:45 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-19 10:13:45 +01:00
@@ -140,7 +140,7 @@
 	if (likely(rl && vcn >= rl[0].vcn)) {
 		while (likely(rl->length)) {
 			if (likely(vcn < rl[1].vcn)) {
-				if (likely(rl->lcn >= (LCN)LCN_HOLE)) {
+				if (likely(rl->lcn >= LCN_HOLE)) {
 					ntfs_debug("Done.");
 					return rl;
 				}
@@ -148,8 +148,8 @@
 			}
 			rl++;
 		}
-		if (likely(rl->lcn != (LCN)LCN_RL_NOT_MAPPED)) {
-			if (likely(rl->lcn == (LCN)LCN_ENOENT))
+		if (likely(rl->lcn != LCN_RL_NOT_MAPPED)) {
+			if (likely(rl->lcn == LCN_ENOENT))
 				err = -ENOENT;
 			else
 				err = -EIO;
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-10-19 10:13:45 +01:00
+++ b/fs/ntfs/compress.c	2004-10-19 10:13:45 +01:00
@@ -602,7 +602,7 @@
 				rl++;
 			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 		} else
-			lcn = (LCN)LCN_RL_NOT_MAPPED;
+			lcn = LCN_RL_NOT_MAPPED;
 		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
 				(unsigned long long)vcn,
 				(unsigned long long)lcn);
diff -Nru a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c	2004-10-19 10:13:45 +01:00
+++ b/fs/ntfs/lcnalloc.c	2004-10-19 10:13:45 +01:00
@@ -855,7 +855,7 @@
 		err = PTR_ERR(rl);
 		goto err_out;
 	}
-	if (unlikely(rl->lcn < (LCN)LCN_HOLE)) {
+	if (unlikely(rl->lcn < LCN_HOLE)) {
 		if (!is_rollback)
 			ntfs_error(vol->sb, "First runlist element has "
 					"invalid lcn, aborting.");
@@ -895,7 +895,7 @@
 	 * free them.
 	 */
 	for (; rl->length && count != 0; ++rl) {
-		if (unlikely(rl->lcn < (LCN)LCN_HOLE)) {
+		if (unlikely(rl->lcn < LCN_HOLE)) {
 			VCN vcn;
 
 			/*
@@ -926,7 +926,7 @@
 							"element.");
 				goto err_out;
 			}
-			if (unlikely(rl->lcn < (LCN)LCN_HOLE)) {
+			if (unlikely(rl->lcn < LCN_HOLE)) {
 				if (!is_rollback)
 					ntfs_error(vol->sb, "Runlist element "
 							"has invalid lcn "
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:13:45 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:13:45 +01:00
@@ -530,7 +530,7 @@
 	si = di = 0;
 
 	/* Skip any unmapped start element(s) in the source runlist. */
-	while (srl[si].length && srl[si].lcn < (LCN)LCN_HOLE)
+	while (srl[si].length && srl[si].lcn < LCN_HOLE)
 		si++;
 
 	/* Can't have an entirely unmapped source runlist. */
@@ -563,7 +563,7 @@
 	for (dend = di; drl[dend].length; dend++)
 		;
 
-	if (srl[send].lcn == (LCN)LCN_ENOENT)
+	if (srl[send].lcn == LCN_ENOENT)
 		marker_vcn = srl[marker = send].vcn;
 
 	/* Scan to the last element with lcn >= LCN_HOLE. */
@@ -624,7 +624,7 @@
 						"with LCN_ENOENT.",
 						(unsigned long long)
 						drl[ds].lcn);
-				drl[ds].lcn = (LCN)LCN_ENOENT;
+				drl[ds].lcn = LCN_ENOENT;
 				goto finished;
 			}
 			/*
@@ -632,11 +632,11 @@
 			 * @drl or extend an existing one before adding the
 			 * ENOENT terminator.
 			 */
-			if (drl[ds].lcn == (LCN)LCN_ENOENT) {
+			if (drl[ds].lcn == LCN_ENOENT) {
 				ds--;
 				slots = 1;
 			}
-			if (drl[ds].lcn != (LCN)LCN_RL_NOT_MAPPED) {
+			if (drl[ds].lcn != LCN_RL_NOT_MAPPED) {
 				/* Add an unmapped runlist element. */
 				if (!slots) {
 					/* FIXME/TODO: We need to have the
@@ -651,7 +651,7 @@
 				if (slots != 1)
 					drl[ds].vcn = drl[ds - 1].vcn +
 							drl[ds - 1].length;
-				drl[ds].lcn = (LCN)LCN_RL_NOT_MAPPED;
+				drl[ds].lcn = LCN_RL_NOT_MAPPED;
 				/* We now used up a slot. */
 				slots--;
 			}
@@ -666,7 +666,7 @@
 					goto critical_error;
 			}
 			drl[ds].vcn = marker_vcn;
-			drl[ds].lcn = (LCN)LCN_ENOENT;
+			drl[ds].lcn = LCN_ENOENT;
 			drl[ds].length = (s64)0;
 		}
 	}
@@ -753,8 +753,8 @@
 		return ERR_PTR(-ENOMEM);
 	/* Insert unmapped starting element if necessary. */
 	if (vcn) {
-		rl->vcn = (VCN)0;
-		rl->lcn = (LCN)LCN_RL_NOT_MAPPED;
+		rl->vcn = 0;
+		rl->lcn = LCN_RL_NOT_MAPPED;
 		rl->length = vcn;
 		rlpos++;
 	}
@@ -819,7 +819,7 @@
 		 * to LCN_HOLE.
 		 */
 		if (!(*buf & 0xf0))
-			rl[rlpos].lcn = (LCN)LCN_HOLE;
+			rl[rlpos].lcn = LCN_HOLE;
 		else {
 			/* Get the lcn change which really can be negative. */
 			u8 b2 = *buf & 0xf;
@@ -892,7 +892,7 @@
 					(unsigned long long)max_cluster);
 			rl[rlpos].vcn = vcn;
 			vcn += rl[rlpos].length = max_cluster - deltaxcn;
-			rl[rlpos].lcn = (LCN)LCN_RL_NOT_MAPPED;
+			rl[rlpos].lcn = LCN_RL_NOT_MAPPED;
 			rlpos++;
 		} else if (unlikely(deltaxcn > max_cluster)) {
 			ntfs_error(vol->sb, "Corrupt attribute. deltaxcn = "
@@ -901,9 +901,9 @@
 					(unsigned long long)max_cluster);
 			goto mpa_err;
 		}
-		rl[rlpos].lcn = (LCN)LCN_ENOENT;
+		rl[rlpos].lcn = LCN_ENOENT;
 	} else /* Not the base extent. There may be more extents to follow. */
-		rl[rlpos].lcn = (LCN)LCN_RL_NOT_MAPPED;
+		rl[rlpos].lcn = LCN_RL_NOT_MAPPED;
 
 	/* Setup terminating runlist element. */
 	rl[rlpos].vcn = vcn;
@@ -962,11 +962,11 @@
 	 * necessary.
 	 */
 	if (unlikely(!rl))
-		return (LCN)LCN_RL_NOT_MAPPED;
+		return LCN_RL_NOT_MAPPED;
 
 	/* Catch out of lower bounds vcn. */
 	if (unlikely(vcn < rl[0].vcn))
-		return (LCN)LCN_ENOENT;
+		return LCN_ENOENT;
 
 	for (i = 0; likely(rl[i].length); i++) {
 		if (unlikely(vcn < rl[i+1].vcn)) {
@@ -982,7 +982,7 @@
 	if (likely(rl[i].lcn < (LCN)0))
 		return rl[i].lcn;
 	/* Just in case... We could replace this with BUG() some day. */
-	return (LCN)LCN_ENOENT;
+	return LCN_ENOENT;
 }
 
 /**
