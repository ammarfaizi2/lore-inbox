Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUKJOEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUKJOEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbUKJOBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:01:03 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:60897 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261887AbUKJNpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:52 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 22/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsn2-0006SP-Im@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:36 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 22/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/05 1.2026.1.57)
   NTFS: Minor cleanup of fs/ntfs/debug.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2004-11-10 13:45:40 +00:00
+++ b/fs/ntfs/debug.c	2004-11-10 13:45:40 +00:00
@@ -127,8 +127,8 @@
 	va_start(args, fmt);
 	vsnprintf(err_buf, sizeof(err_buf), fmt, args);
 	va_end(args);
-	printk(KERN_DEBUG "NTFS-fs DEBUG (%s, %d): %s(): %s\n",
-		file, line, flen ? function : "", err_buf);
+	printk(KERN_DEBUG "NTFS-fs DEBUG (%s, %d): %s(): %s\n", file, line,
+			flen ? function : "", err_buf);
 	spin_unlock(&err_buf_lock);
 }
 
@@ -141,8 +141,7 @@
 
 	if (!debug_msgs)
 		return;
-	printk(KERN_DEBUG "NTFS-fs DEBUG: Dumping runlist (values "
-			"in hex):\n");
+	printk(KERN_DEBUG "NTFS-fs DEBUG: Dumping runlist (values in hex):\n");
 	if (!rl) {
 		printk(KERN_DEBUG "Run list not present.\n");
 		return;
@@ -157,14 +156,14 @@
 			if (index > -LCN_ENOENT - 1)
 				index = 3;
 			printk(KERN_DEBUG "%-16Lx %s %-16Lx%s\n",
-				(rl + i)->vcn, lcn_str[index],
-				(rl + i)->length, (rl + i)->length ?
-				"" : " (runlist end)");
+					(rl + i)->vcn, lcn_str[index],
+					(rl + i)->length, (rl + i)->length ?
+					"" : " (runlist end)");
 		} else
 			printk(KERN_DEBUG "%-16Lx %-16Lx  %-16Lx%s\n",
-				(rl + i)->vcn, (rl + i)->lcn,
-				(rl + i)->length, (rl + i)->length ?
-				"" : " (runlist end)");
+					(rl + i)->vcn, (rl + i)->lcn,
+					(rl + i)->length, (rl + i)->length ?
+					"" : " (runlist end)");
 		if (!(rl + i)->length)
 			break;
 	}
