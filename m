Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUIVMTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUIVMTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVMQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:16:59 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:23429 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264919AbUIVMQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:16:07 -0400
Date: Wed, 22 Sep 2004 13:16:01 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221315460.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/16 1.1867.9.2)
   NTFS: Fix a potential bug in fs/ntfs/mft.c::map_extent_mft_record() that
         could occur in the future for when we start closing/freeing extent
         inodes if we don't set base_ni->ext.extent_ntfs_inos to NULL after
         we free it.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-09-22 13:02:40 +01:00
+++ b/fs/ntfs/mft.c	2004-09-22 13:02:40 +01:00
@@ -418,7 +418,8 @@
 			m = ERR_PTR(-ENOMEM);
 			goto unm_err_out;
 		}
-		if (base_ni->ext.extent_ntfs_inos) {
+		if (base_ni->nr_extents) {
+			BUG_ON(!base_ni->ext.extent_ntfs_inos);
 			memcpy(tmp, base_ni->ext.extent_ntfs_inos, new_size -
 					4 * sizeof(ntfs_inode *));
 			kfree(base_ni->ext.extent_ntfs_inos);
