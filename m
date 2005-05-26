Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVEZIOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVEZIOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVEZIOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:14:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15014 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261258AbVEZIOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:14:35 -0400
Date: Thu, 26 May 2005 11:14:22 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-ntfs-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: use struct initializers
In-Reply-To: <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0505261113390.6273@sbz-30.cs.Helsinki.FI>
References: <1117044875.9510.2.camel@localhost>
 <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk>
 <courier.42956AFA.00002502@courier.cs.helsinki.fi>
 <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

This patch converts explicit NULL assignments to use struct initializers as
suggested by Al Viro.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 super.c |   40 ++++++++++++----------------------------
 1 files changed, 12 insertions(+), 28 deletions(-)

Index: 2.6-mm/fs/ntfs/super.c
===================================================================
--- 2.6-mm.orig/fs/ntfs/super.c	2005-05-26 10:18:41.000000000 +0300
+++ 2.6-mm/fs/ntfs/super.c	2005-05-26 11:07:44.000000000 +0300
@@ -2292,36 +2292,20 @@
 		return -ENOMEM;
 	}
 	/* Initialize ntfs_volume structure. */
-	memset(vol, 0, sizeof(ntfs_volume));
-	vol->sb = sb;
-	vol->upcase = NULL;
-	vol->attrdef = NULL;
-	vol->mft_ino = NULL;
-	vol->mftbmp_ino = NULL;
+	*vol = (ntfs_volume) {
+		.sb = sb,
+		/*
+		 * Default is group and other don't have any access to files or
+		 * directories while owner has full access. Further, files by
+		 * default are not executable but directories are of course
+		 * browseable.
+		 */
+		.fmask = 0177,
+		.dmask = 0077,
+
+	};
 	init_rwsem(&vol->mftbmp_lock);
-#ifdef NTFS_RW
-	vol->mftmirr_ino = NULL;
-	vol->logfile_ino = NULL;
-#endif /* NTFS_RW */
-	vol->lcnbmp_ino = NULL;
 	init_rwsem(&vol->lcnbmp_lock);
-	vol->vol_ino = NULL;
-	vol->root_ino = NULL;
-	vol->secure_ino = NULL;
-	vol->extend_ino = NULL;
-#ifdef NTFS_RW
-	vol->quota_ino = NULL;
-	vol->quota_q_ino = NULL;
-#endif /* NTFS_RW */
-	vol->nls_map = NULL;
-
-	/*
-	 * Default is group and other don't have any access to files or
-	 * directories while owner has full access. Further, files by default
-	 * are not executable but directories are of course browseable.
-	 */
-	vol->fmask = 0177;
-	vol->dmask = 0077;
 
 	unlock_kernel();
 
