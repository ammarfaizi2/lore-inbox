Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVCJDYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVCJDYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCJBIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:08:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:49567 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262618AbVCJAm1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:27 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] videodev: pass dev_t to the class core
In-Reply-To: <11104148823637@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:43 -0800
Message-Id: <11104148831572@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2044, 2005/03/09 09:52:10-08:00, kay.sievers@vrfy.org

[PATCH] videodev: pass dev_t to the class core

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/media/video/videodev.c |   11 +----------
 1 files changed, 1 insertion(+), 10 deletions(-)


diff -Nru a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c	2005-03-09 16:29:20 -08:00
+++ b/drivers/media/video/videodev.c	2005-03-09 16:29:20 -08:00
@@ -46,15 +46,7 @@
 	return sprintf(buf,"%.*s\n",(int)sizeof(vfd->name),vfd->name);
 }
 
-static ssize_t show_dev(struct class_device *cd, char *buf)
-{
-	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
-	dev_t dev = MKDEV(VIDEO_MAJOR, vfd->minor);
-	return print_dev_t(buf,dev);
-}
-
 static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-static CLASS_DEVICE_ATTR(dev,  S_IRUGO, show_dev, NULL);
 
 struct video_device *video_device_alloc(void)
 {
@@ -347,12 +339,11 @@
 	if (vfd->dev)
 		vfd->class_dev.dev = vfd->dev;
 	vfd->class_dev.class       = &video_class;
+	vfd->class_dev.devt       = MKDEV(VIDEO_MAJOR, vfd->minor);
 	strlcpy(vfd->class_dev.class_id, vfd->devfs_name + 4, BUS_ID_SIZE);
 	class_device_register(&vfd->class_dev);
 	class_device_create_file(&vfd->class_dev,
 				 &class_device_attr_name);
-	class_device_create_file(&vfd->class_dev,
-				 &class_device_attr_dev);
 
 #if 1 /* needed until all drivers are fixed */
 	if (!vfd->release)

