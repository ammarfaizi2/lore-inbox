Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUJSKcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUJSKcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUJSK3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:29:44 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:31889 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268212AbUJSJrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:47:03 -0400
Date: Tue, 19 Oct 2004 10:46:56 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 33/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191046440.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 33/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/15 1.2053)
   NTFS: Add helpers fs/ntfs/layout.h::MK_MREF() and MK_LE_MREF().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:15:06 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:15:06 +01:00
@@ -133,6 +133,7 @@
 	  add a declaration for it to inode.h.  Fix some compilation issues
 	  that resulted due to #includes and header file interdependencies.
 	- Simplify setup of i_mode in fs/ntfs/inode.c::ntfs_read_locked_inode().
+	- Add helpers fs/ntfs/layout.h::MK_MREF() and MK_LE_MREF().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-10-19 10:15:06 +01:00
+++ b/fs/ntfs/layout.h	2004-10-19 10:15:06 +01:00
@@ -316,6 +316,10 @@
 typedef u64 MFT_REF;
 typedef le64 leMFT_REF;
 
+#define MK_MREF(m, s)	((MFT_REF)(((MFT_REF)(s) << 48) |		\
+					((MFT_REF)(m) & MFT_REF_MASK_CPU)))
+#define MK_LE_MREF(m, s) cpu_to_le64(MK_MREF(m, s))
+
 #define MREF(x)		((unsigned long)((x) & MFT_REF_MASK_CPU))
 #define MSEQNO(x)	((u16)(((x) >> 48) & 0xffff))
 #define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
