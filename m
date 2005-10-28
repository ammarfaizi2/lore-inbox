Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVJ1Gqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVJ1Gqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVJ1Gqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:46:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:19434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965117AbVJ1GbI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:08 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: rename input_dev_class to input_class to be correct.
In-Reply-To: <1130481026406@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <1130481026735@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: rename input_dev_class to input_class to be correct.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fdbb989037a62b1748fdf3e292601a9373fa0739
tree f31cc114d1acdf13b3099ca1d83d5a5808c5e2ee
parent 4fccc75dab34abbbf9368d2fa21bed0918cdaec7
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/evdev.c    |    4 ++--
 drivers/input/input.c    |   14 +++++++-------
 drivers/input/joydev.c   |    4 ++--
 drivers/input/mousedev.c |    8 ++++----
 drivers/input/tsdev.c    |    4 ++--
 include/linux/input.h    |    2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 579041d..2a96b26 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -686,7 +686,7 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	class_device_create(&input_dev_class, &dev->cdev,
+	class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->cdev.dev, "event%d", minor);
 
@@ -698,7 +698,7 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	class_device_destroy(&input_dev_class,
+	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5c9044d..a8f65fa 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
-EXPORT_SYMBOL_GPL(input_dev_class);
+EXPORT_SYMBOL_GPL(input_class);
 
 #define INPUT_DEVICES	256
 
@@ -729,8 +729,8 @@ static void input_dev_release(struct cla
 	module_put(THIS_MODULE);
 }
 
-struct class input_dev_class = {
-	.name			= "input_dev",
+struct class input_class = {
+	.name			= "input",
 	.release		= input_dev_release,
 };
 
@@ -741,7 +741,7 @@ struct input_dev *input_allocate_device(
 	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
 	if (dev) {
 		dev->dynalloc = 1;
-		dev->cdev.class = &input_dev_class;
+		dev->cdev.class = &input_class;
 		class_device_initialize(&dev->cdev);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
@@ -930,7 +930,7 @@ static int __init input_init(void)
 {
 	int err;
 
-	err = class_register(&input_dev_class);
+	err = class_register(&input_class);
 	if (err) {
 		printk(KERN_ERR "input: unable to register input_dev class\n");
 		return err;
@@ -949,7 +949,7 @@ static int __init input_init(void)
 	return 0;
 
  fail2:	input_proc_exit();
- fail1:	class_unregister(&input_dev_class);
+ fail1:	class_unregister(&input_class);
 	return err;
 }
 
@@ -957,7 +957,7 @@ static void __exit input_exit(void)
 {
 	input_proc_exit();
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_unregister(&input_dev_class);
+	class_unregister(&input_class);
 }
 
 subsys_initcall(input_init);
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 9c17d1a..25f7eba 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -513,7 +513,7 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	class_device_create(&input_dev_class, &dev->cdev,
+	class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->cdev.dev, "js%d", minor);
 
@@ -525,7 +525,7 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	class_device_destroy(&input_dev_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	class_device_destroy(&input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	joydev->exist = 0;
 
 	if (joydev->open) {
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 5ec6291..de2808f 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -648,7 +648,7 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	class_device_create(&input_dev_class, &dev->cdev,
+	class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			dev->cdev.dev, "mouse%d", minor);
 
@@ -660,7 +660,7 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	class_device_destroy(&input_dev_class,
+	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev->exist = 0;
 
@@ -734,7 +734,7 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	class_device_create(&input_dev_class, NULL,
+	class_device_create(&input_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
@@ -753,7 +753,7 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	class_device_destroy(&input_dev_class,
+	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index 0581edb..75e1657 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -409,7 +409,7 @@ static struct input_handle *tsdev_connec
 
 	tsdev_table[minor] = tsdev;
 
-	class_device_create(&input_dev_class, &dev->cdev,
+	class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->cdev.dev, "ts%d", minor);
 
@@ -421,7 +421,7 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	class_device_destroy(&input_dev_class,
+	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev->exist = 0;
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 256e887..e3d9c08 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1074,7 +1074,7 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class input_dev_class;
+extern struct class input_class;
 
 #endif
 #endif

