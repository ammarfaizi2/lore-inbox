Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288784AbSATRp4>; Sun, 20 Jan 2002 12:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288854AbSATRph>; Sun, 20 Jan 2002 12:45:37 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:63500 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S288784AbSATRp1>;
	Sun, 20 Jan 2002 12:45:27 -0500
Date: Sun, 20 Jan 2002 12:28:31 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH]2.5.3-pre2: drivers/ieee1394/video1394.c
Message-ID: <Pine.LNX.4.33.0201201226270.12409-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   This patch fixes some of the compile errors in 2.5.3-pre2, MINOR -> 
minor
Regards,
Frank

--- drivers/ieee1394/video1394.c.old	Mon Jan 14 21:54:46 2002
+++ drivers/ieee1394/video1394.c	Sun Jan 20 12:24:41 2002
@@ -850,7 +850,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(inode->i_rdev)) {
+			if (p->id == minor(inode->i_rdev)) {
 				video = p;
 				ohci = video->ohci;
 				break;
@@ -860,7 +860,7 @@
 	spin_unlock_irqrestore(&video1394_cards_lock, flags);
 
 	if (video == NULL) {
-		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", MINOR(inode->i_rdev));
+		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", minor(inode->i_rdev));
 		return -EFAULT;
 	}
 
@@ -1328,7 +1328,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(file->f_dentry->d_inode->i_rdev)) {
+			if (p->id == minor(file->f_dentry->d_inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -1338,7 +1338,7 @@
 
 	if (video == NULL) {
 		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d",
-			MINOR(file->f_dentry->d_inode->i_rdev));
+			minor(file->f_dentry->d_inode->i_rdev));
 		return -EFAULT;
 	}
 
@@ -1357,7 +1357,7 @@
 
 static int video1394_open(struct inode *inode, struct file *file)
 {
-	int i = MINOR(inode->i_rdev);
+	int i = minor(inode->i_rdev);
 	unsigned long flags;
 	struct video_card *video = NULL;
 	struct list_head *lh;
@@ -1397,7 +1397,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(inode->i_rdev)) {
+			if (p->id == minor(inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -1407,7 +1407,7 @@
 
 	if (video == NULL) {
 		PRINT_G(KERN_ERR, __FUNCTION__": Unknown device for minor %d",
-				MINOR(inode->i_rdev));
+				minor(inode->i_rdev));
 		return 1;
 	}
 
 



