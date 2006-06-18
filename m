Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWFRPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWFRPsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWFRPsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:48:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751197AbWFRPsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:48:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ATmM/MOav7KtrKCU3XGfch2jOE72WX7VfUwNSeAQF/FRIu49K8jzTA41oG5zin3YDAZBF61gbU1F4Sjd2PCiLQxqdgojR63k1SSTi5EJpwRKt7WHEc3DJj8zpj46GPh+fVUwuEyecB4IsM7bN4RUsc380z+rvHC/Hx1UA+6bLpY=
Message-ID: <4495708A.70409@gmail.com>
Date: Sun, 18 Jun 2006 23:26:02 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH 4/9] VT binding: Do not create a device file for class device
 'fbcon'
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The class device "fbcon" does not need to be a device file.  Do not create
one by passing a major and minor number of zero to
class_device_create()/destroy().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 839f414..6e813a1 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3244,9 +3244,7 @@ static int __init fb_console_init(void)
 	acquire_console_sem();
 	fb_register_client(&fbcon_event_notifier);
 	fbcon_class_device =
-	    class_device_create(fb_class, NULL,
-				MKDEV(FB_MAJOR, FB_MAX), NULL,
-				"fbcon");
+	    class_device_create(fb_class, NULL, MKDEV(0, 0), NULL, "fbcon");
 
 	if (IS_ERR(fbcon_class_device)) {
 		printk(KERN_WARNING "Unable to create class_device "
@@ -3282,7 +3280,7 @@ static void __exit fb_console_exit(void)
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_class_device();
-	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
+	class_device_destroy(fb_class, MKDEV(0, 0));
 	fbcon_exit();
 	release_console_sem();
 	unregister_con_driver(&fb_con);

