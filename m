Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264285AbTCXRE3>; Mon, 24 Mar 2003 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264286AbTCXQtr>; Mon, 24 Mar 2003 11:49:47 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:46826 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264285AbTCXQa5>; Mon, 24 Mar 2003 11:30:57 -0500
Message-Id: <200303241642.h2OGg735008305@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:54 +0000
To: akpm@zip.com.au
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: ancient block_dev patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
 What became of this patch ? Is it needed ?


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/block_dev.c linux-2.5/fs/block_dev.c
--- bk-linus/fs/block_dev.c	2003-03-17 12:40:51.000000000 +0000
+++ linux-2.5/fs/block_dev.c	2003-03-17 13:09:03.000000000 +0000
@@ -653,15 +653,16 @@ int blkdev_put(struct block_device *bdev
 	struct gendisk *disk = bdev->bd_disk;
 
 	down(&bdev->bd_sem);
-	switch (kind) {
-	case BDEV_FILE:
-	case BDEV_FS:
-		sync_blockdev(bd_inode->i_bdev);
-		break;
-	}
 	lock_kernel();
-	if (!--bdev->bd_openers)
+	if (!--bdev->bd_openers) {
+		switch (kind) {
+		case BDEV_FILE:
+		case BDEV_FS:
+			sync_blockdev(bd_inode->i_bdev);
+			break;
+		}
 		kill_bdev(bdev);
+	}
 	if (bdev->bd_contains == bdev) {
 		if (disk->fops->release)
 			ret = disk->fops->release(bd_inode, NULL);
