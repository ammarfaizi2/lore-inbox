Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUHWKg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUHWKg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUHWKgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:36:12 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:38851 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267652AbUHWKae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:30:34 -0400
Date: Mon, 23 Aug 2004 11:30:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 6/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/21 1.1809)
   NTFS: Wrap the new bitmap.[hc] code in #ifdef NTFS_RW / #endif.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- a/fs/ntfs/bitmap.c	2004-08-18 20:50:03 +01:00
+++ b/fs/ntfs/bitmap.c	2004-08-18 20:50:03 +01:00
@@ -19,6 +19,8 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef NTFS_RW
+
 #include <linux/pagemap.h>
 
 #include "bitmap.h"
@@ -181,3 +183,5 @@
 	}
 	return PTR_ERR(page);
 }
+
+#endif /* NTFS_RW */
diff -Nru a/fs/ntfs/bitmap.h b/fs/ntfs/bitmap.h
--- a/fs/ntfs/bitmap.h	2004-08-18 20:50:03 +01:00
+++ b/fs/ntfs/bitmap.h	2004-08-18 20:50:03 +01:00
@@ -23,6 +23,8 @@
 #ifndef _LINUX_NTFS_BITMAP_H
 #define _LINUX_NTFS_BITMAP_H
 
+#ifdef NTFS_RW
+
 #include <linux/fs.h>
 
 #include "types.h"
@@ -110,5 +112,7 @@
 {
 	return ntfs_bitmap_clear_run(vi, bit, 1);
 }
+
+#endif /* NTFS_RW */
 
 #endif /* defined _LINUX_NTFS_BITMAP_H */
