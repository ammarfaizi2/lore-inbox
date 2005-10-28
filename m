Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVJ1GrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVJ1GrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVJ1Gqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:46:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:18666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965107AbVJ1GbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:07 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: remove the input_class structure, as it is unused.
In-Reply-To: <11304810264196@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <11304810262929@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: remove the input_class structure, as it is unused.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4fccc75dab34abbbf9368d2fa21bed0918cdaec7
tree aac77ee746bae2328684201596b2860d94fd1e02
parent 706d2a7c95014882307f31cd0f3c2a95b0544819
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/input.c |   18 +++---------------
 include/linux/input.h |    1 -
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 0d570cf..5c9044d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -39,7 +39,6 @@ EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
-EXPORT_SYMBOL(input_class);
 EXPORT_SYMBOL_GPL(input_dev_class);
 
 #define INPUT_DEVICES	256
@@ -927,8 +926,6 @@ static struct file_operations input_fops
 	.open = input_open_file,
 };
 
-struct class *input_class;
-
 static int __init input_init(void)
 {
 	int err;
@@ -939,27 +936,19 @@ static int __init input_init(void)
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
@@ -968,7 +957,6 @@ static void __exit input_exit(void)
 {
 	input_proc_exit();
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_destroy(input_class);
 	class_unregister(&input_dev_class);
 }
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 5de8441..256e887 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1074,7 +1074,6 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class *input_class;
 extern struct class input_dev_class;
 
 #endif

