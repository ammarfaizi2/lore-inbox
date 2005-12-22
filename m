Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVLVEzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVLVEzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVLVEvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36560 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965092AbVLVEvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:20 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 27/36] m68k: amiflop __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQB-0004tA-My@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011656 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/block/amiflop.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

442bc9893a32b018bc451c700c588596d52aeb6d
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 8c69533..ac58521 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1431,6 +1431,7 @@ static int fd_ioctl(struct inode *inode,
 {
 	int drive = iminor(inode) & 3;
 	static struct floppy_struct getprm;
+	void __user *argp = (void __user *)param;
 
 	switch(cmd){
 	case HDIO_GETGEO:
@@ -1440,8 +1441,7 @@ static int fd_ioctl(struct inode *inode,
 		loc.sectors = unit[drive].dtype->sects * unit[drive].type->sect_mult;
 		loc.cylinders = unit[drive].type->tracks;
 		loc.start = 0;
-		if (copy_to_user((void *)param, (void *)&loc,
-				 sizeof(struct hd_geometry)))
+		if (copy_to_user(argp, &loc, sizeof(struct hd_geometry)))
 			return -EFAULT;
 		break;
 	}
@@ -1488,9 +1488,7 @@ static int fd_ioctl(struct inode *inode,
 		getprm.head=unit[drive].type->heads;
 		getprm.sect=unit[drive].dtype->sects * unit[drive].type->sect_mult;
 		getprm.size=unit[drive].blocks;
-		if (copy_to_user((void *)param,
-				 (void *)&getprm,
-				 sizeof(struct floppy_struct)))
+		if (copy_to_user(argp, &getprm, sizeof(struct floppy_struct)))
 			return -EFAULT;
 		break;
 	case FDSETPRM:
@@ -1502,8 +1500,7 @@ static int fd_ioctl(struct inode *inode,
 		break;
 #ifdef RAW_IOCTL
 	case IOCTL_RAW_TRACK:
-		if (copy_to_user((void *)param, raw_buf,
-				 unit[drive].type->read_size))
+		if (copy_to_user(argp, raw_buf, unit[drive].type->read_size))
 			return -EFAULT;
 		else
 			return unit[drive].type->read_size;
-- 
0.99.9.GIT

