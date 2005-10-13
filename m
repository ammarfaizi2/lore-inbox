Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVJMCM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVJMCM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVJMCM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:12:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:47502 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964862AbVJMCML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:12:11 -0400
Date: Wed, 12 Oct 2005 19:11:08 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 7/8] input: remove the input_class structure, as it is unused.
Message-ID: <20051013021108.GH31732@kroah.com>
References: <20051013014147.235668000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-remove-input_class.patch"
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/input.c |   18 +++---------------
 include/linux/input.h |    1 -
 2 files changed, 3 insertions(+), 16 deletions(-)

--- gregkh-2.6.orig/drivers/input/input.c
+++ gregkh-2.6/drivers/input/input.c
@@ -39,7 +39,6 @@ EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
-EXPORT_SYMBOL(input_class);
 EXPORT_SYMBOL_GPL(input_dev_class);
 
 #define INPUT_DEVICES	256
@@ -922,8 +921,6 @@ static struct file_operations input_fops
 	.open = input_open_file,
 };
 
-struct class *input_class;
-
 static int __init input_init(void)
 {
 	int err;
@@ -934,27 +931,19 @@ static int __init input_init(void)
 		return err;
 	}
 
-	input_class = class_create(THIS_MODULE, "input");
-	if (IS_ERR(input_class)) {
-		printk(KERN_ERR "input: unable to register input class\n");
-		err = PTR_ERR(input_class);
-		goto fail1;
-	}
-
 	err = input_proc_init();
 	if (err)
-		goto fail2;
+		goto fail1;
 
 	err = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (err) {
 		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);
-		goto fail3;
+		goto fail2;
 	}
 
 	return 0;
 
- fail3:	input_proc_exit();
- fail2:	class_destroy(input_class);
+ fail2:	input_proc_exit();
  fail1:	class_unregister(&input_dev_class);
 	return err;
 }
@@ -963,7 +952,6 @@ static void __exit input_exit(void)
 {
 	input_proc_exit();
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_destroy(input_class);
 	class_unregister(&input_dev_class);
 }
 
--- gregkh-2.6.orig/include/linux/input.h
+++ gregkh-2.6/include/linux/input.h
@@ -1074,7 +1074,6 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class *input_class;
 extern struct class input_dev_class;
 
 #endif

--
