Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVAWE35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVAWE35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAWE1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:27:37 -0500
Received: from soundwarez.org ([217.160.171.123]:24715 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261209AbVAWE0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:26:32 -0500
Date: Sun, 23 Jan 2005 05:26:27 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 6/7] videodev: pass dev_t to the class core
Message-ID: <20050123042627.GB9256@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/media/video/videodev.c 1.35 vs edited =====
--- 1.35/drivers/media/video/videodev.c	2004-08-23 10:14:55 +02:00
+++ edited/drivers/media/video/videodev.c	2005-01-22 15:22:49 +01:00
@@ -46,15 +46,7 @@ static ssize_t show_name(struct class_de
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
@@ -347,12 +339,11 @@ int video_register_device(struct video_d
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

