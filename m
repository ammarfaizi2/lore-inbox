Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319398AbSH2Vxu>; Thu, 29 Aug 2002 17:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319397AbSH2VxX>; Thu, 29 Aug 2002 17:53:23 -0400
Received: from smtpout.mac.com ([204.179.120.88]:44536 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319385AbSH2VwI>;
	Thu, 29 Aug 2002 17:52:08 -0400
Message-Id: <200208292156.g7TLuVKN026378@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 20/41 sound/oss/msnd_pinnacle.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/msnd_pinnacle.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/msnd_pinnacle.c	Sat Aug 10 19:51:16 2002
@@ -645,7 +645,7 @@
 
 static int dev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 
 	if (cmd == OSS_GETVERSION) {
 		int sound_version = SOUND_VERSION;
@@ -757,7 +757,7 @@
 
 static int dev_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	int err = 0;
 
 	if (minor == dev.dsp_minor) {
@@ -792,7 +792,7 @@
 
 static int dev_release(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	int err = 0;
 
 	lock_kernel();
@@ -982,7 +982,7 @@
 
 static ssize_t dev_read(struct file *file, char *buf, size_t count, loff_t *off)
 {
-	int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	int minor = minor(file->f_dentry->d_inode->i_rdev);
 	if (minor == dev.dsp_minor)
 		return dsp_read(buf, count);
 	else
@@ -991,7 +991,7 @@
 
 static ssize_t dev_write(struct file *file, const char *buf, size_t count, loff_t *off)
 {
-	int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	int minor = minor(file->f_dentry->d_inode->i_rdev);
 	if (minor == dev.dsp_minor)
 		return dsp_write(buf, count);
 	else

