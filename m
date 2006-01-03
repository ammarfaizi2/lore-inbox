Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWACXd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWACXd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWACX3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:02 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:1500 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965079AbWACX2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:28:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 26/41] m68k: amiflop __user annotations
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZz-0003O8-MR@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:28:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011656 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/block/amiflop.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

acedeac10e60b9db8e3e4be4c84ec3d06f61077a
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

