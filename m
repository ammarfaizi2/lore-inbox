Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUFFQ0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUFFQ0F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUFFQ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:26:04 -0400
Received: from may.priocom.com ([213.156.65.50]:905 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263798AbUFFQZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:25:26 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in
	drivers/media/video/v4l1-compat.c
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086539151.2793.98.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:25:51 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various memory allocation checks in drivers/media/video/v4l1-compat.c

 ./linux-2.6.6-modified/drivers/media/video/v4l1-compat.c |   17
+++++++++++++++
 1 files changed, 17 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/media/video/v4l1-compat.c
./linux-2.6.6-modified/drivers/media/video/v4l1-compat.c
--- ./linux-2.6.6/drivers/media/video/v4l1-compat.c	Mon May 10 05:32:38
2004
+++ ./linux-2.6.6-modified/drivers/media/video/v4l1-compat.c	Wed Jun  2
14:27:21 2004
@@ -308,6 +308,9 @@ v4l_compat_translate_ioctl(struct inode 
 		struct video_capability *cap = arg;
 
 		cap2 = kmalloc(sizeof(*cap2),GFP_KERNEL);
+		if (!cap2)
+			return -ENOMEM;
+                        
 		memset(cap, 0, sizeof(*cap));
 		memset(cap2, 0, sizeof(*cap2));
 		memset(&fbuf2, 0, sizeof(fbuf2));
@@ -425,6 +428,8 @@ v4l_compat_translate_ioctl(struct inode 
 		struct video_window	*win = arg;
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(win,0,sizeof(*win));
 		memset(fmt2,0,sizeof(*fmt2));
 
@@ -464,6 +469,8 @@ v4l_compat_translate_ioctl(struct inode 
 		int err1,err2;
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(fmt2,0,sizeof(*fmt2));
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		drv(inode, file, VIDIOC_STREAMOFF, &fmt2->type);
@@ -598,6 +605,8 @@ v4l_compat_translate_ioctl(struct inode 
 						  V4L2_CID_WHITENESS, drv);
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(fmt2,0,sizeof(*fmt2));
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
@@ -628,6 +637,8 @@ v4l_compat_translate_ioctl(struct inode 
 				V4L2_CID_WHITENESS, pict->whiteness, drv);
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(fmt2,0,sizeof(*fmt2));
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
@@ -861,6 +872,8 @@ v4l_compat_translate_ioctl(struct inode 
 		struct video_mmap	*mm = arg;
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(&buf2,0,sizeof(buf2));
 		memset(fmt2,0,sizeof(*fmt2));
 		
@@ -957,6 +970,8 @@ v4l_compat_translate_ioctl(struct inode 
 		struct vbi_format      *fmt = arg;
 		
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(fmt2, 0, sizeof(*fmt2));
 		fmt2->type = V4L2_BUF_TYPE_VBI_CAPTURE;
 		
@@ -981,6 +996,8 @@ v4l_compat_translate_ioctl(struct inode 
 		struct vbi_format      *fmt = arg;
 		
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		if (!fmt2)
+			return -ENOMEM;
 		memset(fmt2, 0, sizeof(*fmt2));
 
 		fmt2->type = V4L2_BUF_TYPE_VBI_CAPTURE;

-- 
umka

