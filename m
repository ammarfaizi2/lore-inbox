Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVJMCM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVJMCM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVJMCMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:12:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:58510 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964859AbVJMCM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:12:26 -0400
Date: Wed, 12 Oct 2005 19:11:17 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 8/8] input: rename input_dev_class to input_class to be correct.
Message-ID: <20051013021117.GI31732@kroah.com>
References: <20051013014147.235668000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-rename-input_dev_class.patch"
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/evdev.c    |    4 ++--
 drivers/input/input.c    |   14 +++++++-------
 drivers/input/joydev.c   |    4 ++--
 drivers/input/mousedev.c |    8 ++++----
 drivers/input/tsdev.c    |    4 ++--
 include/linux/input.h    |    2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

--- gregkh-2.6.orig/drivers/input/evdev.c
+++ gregkh-2.6/drivers/input/evdev.c
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
 
--- gregkh-2.6.orig/drivers/input/input.c
+++ gregkh-2.6/drivers/input/input.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
-EXPORT_SYMBOL_GPL(input_dev_class);
+EXPORT_SYMBOL_GPL(input_class);
 
 #define INPUT_DEVICES	256
 
@@ -724,8 +724,8 @@ static void input_dev_release(struct cla
 	module_put(THIS_MODULE);
 }
 
-struct class input_dev_class = {
-	.name			= "input_dev",
+struct class input_class = {
+	.name			= "input",
 	.release		= input_dev_release,
 	.class_dev_attrs	= input_dev_attrs,
 };
@@ -737,7 +737,7 @@ struct input_dev *input_allocate_device(
 	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
 	if (dev) {
 		dev->dynalloc = 1;
-		dev->cdev.class = &input_dev_class;
+		dev->cdev.class = &input_class;
 		class_device_initialize(&dev->cdev);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
@@ -925,7 +925,7 @@ static int __init input_init(void)
 {
 	int err;
 
-	err = class_register(&input_dev_class);
+	err = class_register(&input_class);
 	if (err) {
 		printk(KERN_ERR "input: unable to register input_dev class\n");
 		return err;
@@ -944,7 +944,7 @@ static int __init input_init(void)
 	return 0;
 
  fail2:	input_proc_exit();
- fail1:	class_unregister(&input_dev_class);
+ fail1:	class_unregister(&input_class);
 	return err;
 }
 
@@ -952,7 +952,7 @@ static void __exit input_exit(void)
 {
 	input_proc_exit();
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_unregister(&input_dev_class);
+	class_unregister(&input_class);
 }
 
 subsys_initcall(input_init);
--- gregkh-2.6.orig/drivers/input/joydev.c
+++ gregkh-2.6/drivers/input/joydev.c
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
--- gregkh-2.6.orig/drivers/input/mousedev.c
+++ gregkh-2.6/drivers/input/mousedev.c
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
--- gregkh-2.6.orig/drivers/input/tsdev.c
+++ gregkh-2.6/drivers/input/tsdev.c
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
 
--- gregkh-2.6.orig/include/linux/input.h
+++ gregkh-2.6/include/linux/input.h
@@ -1074,7 +1074,7 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class input_dev_class;
+extern struct class input_class;
 
 #endif
 #endif

--
