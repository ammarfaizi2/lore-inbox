Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUJSJzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUJSJzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUJSJyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:54:14 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:54922 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268135AbUJSJmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:42:21 -0400
Date: Tue, 19 Oct 2004 10:42:16 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 14/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 14/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/03 1.2018)
   NTFS: Add some debugging checks to fs/ntfs/inode.c::ntfs_truncate() and fix
         a typo in fs/ntfs/layout.h.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:13:56 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:13:56 +01:00
@@ -2289,6 +2289,8 @@
 	MFT_RECORD *m;
 	int err;
 
+	BUG_ON(NInoAttr(ni));
+	BUG_ON(ni->nr_extents < 0);
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
 		ntfs_error(vi->i_sb, "Failed to map mft record for inode 0x%lx "
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-10-19 10:13:56 +01:00
+++ b/fs/ntfs/layout.h	2004-10-19 10:13:56 +01:00
@@ -260,7 +260,7 @@
 enum {
 	MFT_RECORD_IN_USE	= const_cpu_to_le16(0x0001),
 	MFT_RECORD_IS_DIRECTORY = const_cpu_to_le16(0x0002),
-} __attrobite__ ((__packed__));
+} __attribute__ ((__packed__));
 
 typedef le16 MFT_RECORD_FLAGS;
 
