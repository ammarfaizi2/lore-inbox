Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVFKHzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVFKHzN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVFKHyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:54:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:64963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261645AbVFKHsl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:41 -0400
Subject: [PATCH] Remove the videodevice devfs_name field as it's no longer needed
In-Reply-To: <1118476112920@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <11184761121906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/video/videodev.c |    3 +--
 include/linux/videodev.h       |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/media/video/videodev.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/media/video/videodev.c	2005-06-10 23:37:23.000000000 -0700
@@ -336,8 +336,7 @@
 		vfd->class_dev.dev = vfd->dev;
 	vfd->class_dev.class       = &video_class;
 	vfd->class_dev.devt       = MKDEV(VIDEO_MAJOR, vfd->minor);
-	sprintf(vfd->devfs_name, "%s%d", name_base, i - base);
-	strlcpy(vfd->class_dev.class_id, vfd->devfs_name, BUS_ID_SIZE);
+	sprintf(vfd->class_dev.class_id, "%s%d", name_base, i - base);
 	class_device_register(&vfd->class_dev);
 	class_device_create_file(&vfd->class_dev,
 				 &class_device_attr_name);
--- gregkh-2.6.orig/include/linux/videodev.h	2005-06-10 23:28:58.000000000 -0700
+++ gregkh-2.6/include/linux/videodev.h	2005-06-10 23:37:23.000000000 -0700
@@ -42,7 +42,6 @@
 	/* for videodev.c intenal usage -- please don't touch */
 	int users;                     /* video_exclusive_{open|close} ... */
 	struct semaphore lock;         /* ... helper function uses these   */
-	char devfs_name[64];           /* devfs */
 	struct class_device class_dev; /* sysfs */
 };
 

