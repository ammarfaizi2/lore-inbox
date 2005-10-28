Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVJ1Gfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVJ1Gfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVJ1Gbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:46826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965148AbVJ1GbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:25 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: move the input class devices under their new input_dev devices
In-Reply-To: <11304810263958@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <1130481026406@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: move the input class devices under their new input_dev devices

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ae2ea92c4fa1b32ab686bf48243b3671b3aa7c3a
tree f028ec6ef1b89db4620fa04b9b919079c6abee83
parent 67f440c4cac8a7073e113a0a7f201089123772a0
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/evdev.c    |    6 +++---
 drivers/input/joydev.c   |    6 +++---
 drivers/input/mousedev.c |   10 +++++-----
 drivers/input/tsdev.c    |    6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 14ea57f..579041d 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -686,9 +686,9 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			dev->dev, "event%d", minor);
+			dev->cdev.dev, "event%d", minor);
 
 	return &evdev->handle;
 }
@@ -698,7 +698,7 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
 
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 40d2b46..9c17d1a 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -513,9 +513,9 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			dev->dev, "js%d", minor);
+			dev->cdev.dev, "js%d", minor);
 
 	return &joydev->handle;
 }
@@ -525,7 +525,7 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	class_device_destroy(&input_dev_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	joydev->exist = 0;
 
 	if (joydev->open) {
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 89c3e49..5ec6291 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -648,9 +648,9 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			dev->dev, "mouse%d", minor);
+			dev->cdev.dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -660,7 +660,7 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev->exist = 0;
 
@@ -734,7 +734,7 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
@@ -753,7 +753,7 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index 2d45e4d..0581edb 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -409,9 +409,9 @@ static struct input_handle *tsdev_connec
 
 	tsdev_table[minor] = tsdev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			dev->dev, "ts%d", minor);
+			dev->cdev.dev, "ts%d", minor);
 
 	return &tsdev->handle;
 }
@@ -421,7 +421,7 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev->exist = 0;
 

