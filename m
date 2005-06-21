Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVFUHCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVFUHCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVFUHCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:02:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:57315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261999AbVFUGa5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:57 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the videodevice devfs_name field as it's no longer needed
In-Reply-To: <11193354441615@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:44 -0700
Message-Id: <11193354443124@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the videodevice devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4a8c1e81ac1235c3861c0ab6c4bad960e945c451
tree 25a7ea27febb952a02df8e79030cac8aeb8a7331
parent 87656ce7a691bebc4ed9fb68cdd931ff9223fc9f
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:38 -0700

 drivers/media/video/videodev.c |    3 +--
 include/linux/videodev.h       |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -336,8 +336,7 @@ int video_register_device(struct video_d
 		vfd->class_dev.dev = vfd->dev;
 	vfd->class_dev.class       = &video_class;
 	vfd->class_dev.devt       = MKDEV(VIDEO_MAJOR, vfd->minor);
-	sprintf(vfd->devfs_name, "%s%d", name_base, i - base);
-	strlcpy(vfd->class_dev.class_id, vfd->devfs_name, BUS_ID_SIZE);
+	sprintf(vfd->class_dev.class_id, "%s%d", name_base, i - base);
 	class_device_register(&vfd->class_dev);
 	class_device_create_file(&vfd->class_dev,
 				 &class_device_attr_name);
diff --git a/include/linux/videodev.h b/include/linux/videodev.h
--- a/include/linux/videodev.h
+++ b/include/linux/videodev.h
@@ -42,7 +42,6 @@ struct video_device
 	/* for videodev.c intenal usage -- please don't touch */
 	int users;                     /* video_exclusive_{open|close} ... */
 	struct semaphore lock;         /* ... helper function uses these   */
-	char devfs_name[64];           /* devfs */
 	struct class_device class_dev; /* sysfs */
 };
 

