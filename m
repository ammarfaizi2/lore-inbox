Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUHWKsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUHWKsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUHWKrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:47:07 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:421 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267687AbUHWKcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:32:21 -0400
Date: Mon, 23 Aug 2004 11:32:06 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 13/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/30 1.1816)
   NTFS: Fix compilation with gcc-2.95 in attrib.c::ntfs_find_vcn().  (Adrian Bunk)
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
   Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-08-18 20:50:27 +01:00
+++ b/fs/ntfs/attrib.c	2004-08-18 20:50:27 +01:00
@@ -1113,15 +1113,11 @@
 			}
 			rl++;
 		}
-		switch (rl->lcn) {
-		case (LCN)LCN_RL_NOT_MAPPED:
-			break;
-		case (LCN)LCN_ENOENT:
-			err = -ENOENT;
-			break;
-		default:
-			err = -EIO;
-			break;
+		if (likely(rl->lcn != (LCN)LCN_RL_NOT_MAPPED)) {
+			if (likely(rl->lcn == (LCN)LCN_ENOENT))
+				err = -ENOENT;
+			else
+				err = -EIO;
 		}
 	}
 	if (!need_write)
