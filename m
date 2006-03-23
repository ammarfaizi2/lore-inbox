Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWCWR1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWCWR1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCWR1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:27:31 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:42692 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932170AbWCWR1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:27:30 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:27:01 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 09/14] NTFS: Improve comments on file attribute flags in
 fs/ntfs/layout.h.
In-Reply-To: <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Improve comments on file attribute flags in fs/ntfs/layout.h.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/layout.h  |   25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

2c2c8c1c211c75d0cc9d7642a569ceac1aecd96d
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 41d0381..a3a9d4b 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -37,6 +37,7 @@ ToDo/Notes:
 	- Limit name length in fs/ntfs/unistr.c::ntfs_nlstoucs() to maximum
 	  allowed by NTFS, i.e. 255 Unicode characters, not including the
 	  terminating NULL (which is not stored on disk).
+	- Improve comments on file attribute flags in fs/ntfs/layout.h.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index f4283e1..d34b93c 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -801,13 +801,16 @@ typedef struct {
 typedef ATTR_RECORD ATTR_REC;
 
 /*
- * File attribute flags (32-bit).
+ * File attribute flags (32-bit) appearing in the file_attributes fields of the
+ * STANDARD_INFORMATION attribute of MFT_RECORDs and the FILENAME_ATTR
+ * attributes of MFT_RECORDs and directory index entries.
+ *
+ * All of the below flags appear in the directory index entries but only some
+ * appear in the STANDARD_INFORMATION attribute whilst only some others appear
+ * in the FILENAME_ATTR attribute of MFT_RECORDs.  Unless otherwise stated the
+ * flags appear in all of the above.
  */
 enum {
-	/*
-	 * The following flags are only present in the STANDARD_INFORMATION
-	 * attribute (in the field file_attributes).
-	 */
 	FILE_ATTR_READONLY		= const_cpu_to_le32(0x00000001),
 	FILE_ATTR_HIDDEN		= const_cpu_to_le32(0x00000002),
 	FILE_ATTR_SYSTEM		= const_cpu_to_le32(0x00000004),
@@ -839,18 +842,14 @@ enum {
 	   F_A_COMPRESSED, and F_A_ENCRYPTED and preserves the rest.  This mask
 	   is used to to obtain all flags that are valid for setting. */
 	/*
-	 * The following flag is only present in the FILE_NAME attribute (in
-	 * the field file_attributes).
+	 * The flag FILE_ATTR_DUP_FILENAME_INDEX_PRESENT is present in all
+	 * FILENAME_ATTR attributes but not in the STANDARD_INFORMATION
+	 * attribute of an mft record.
 	 */
 	FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	= const_cpu_to_le32(0x10000000),
 	/* Note, this is a copy of the corresponding bit from the mft record,
 	   telling us whether this is a directory or not, i.e. whether it has
 	   an index root attribute or not. */
-	/*
-	 * The following flag is present both in the STANDARD_INFORMATION
-	 * attribute and in the FILE_NAME attribute (in the field
-	 * file_attributes).
-	 */
 	FILE_ATTR_DUP_VIEW_INDEX_PRESENT	= const_cpu_to_le32(0x20000000),
 	/* Note, this is a copy of the corresponding bit from the mft record,
 	   telling us whether this file has a view index present (eg. object id
@@ -891,7 +890,7 @@ typedef struct {
 					   Windows this is only updated when
 					   accessed if some time delta has
 					   passed since the last update. Also,
-					   last access times updates can be
+					   last access time updates can be
 					   disabled altogether for speed. */
 /* 32*/	FILE_ATTR_FLAGS file_attributes; /* Flags describing the file. */
 /* 36*/	union {
-- 
1.2.3.g9821

