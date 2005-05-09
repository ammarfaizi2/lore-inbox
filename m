Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVEIXXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVEIXXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVEIXWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:22:15 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31250 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261408AbVEIXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:38 -0400
Subject: [patch 4/6] uml: add MOD_LICENSE to random driver
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 10 May 2005 00:45:17 +0200
Message-Id: <20050509224518.0695F13C218@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a MODULE_LICENSE("GPL") to the driver, remove some unused macros and
add the GPL license (it's GPL-licensed anyway since it's a GPL-derivative,
apart that Jeff Dike releases GPL software, in case anybody is wondering).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/random.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN arch/um/drivers/random.c~uml-random-mod-license arch/um/drivers/random.c
--- linux-2.6.12/arch/um/drivers/random.c~uml-random-mod-license	2005-05-02 15:45:03.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/random.c	2005-05-02 15:53:46.000000000 +0200
@@ -1,5 +1,10 @@
-/* Much of this ripped from hw_random.c */
-
+/* Copyright (C) 2005 Jeff Dike <jdike@addtoit.com> */
+/* Much of this ripped from drivers/char/hw_random.c, see there for other
+ * copyright.
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ */
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
@@ -12,8 +17,6 @@
  */
 #define RNG_VERSION "1.0.0"
 #define RNG_MODULE_NAME "random"
-#define RNG_DRIVER_NAME   RNG_MODULE_NAME " virtual driver " RNG_VERSION
-#define PFX RNG_MODULE_NAME ": "
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
@@ -98,7 +101,7 @@ static int __init rng_init (void)
 
 	err = misc_register (&rng_miscdev);
 	if (err) {
-		printk (KERN_ERR PFX "misc device register failed\n");
+		printk (KERN_ERR RNG_MODULE_NAME ": misc device register failed\n");
 		goto err_out_cleanup_hw;
 	}
 
@@ -120,3 +123,6 @@ static void __exit rng_cleanup (void)
 
 module_init (rng_init);
 module_exit (rng_cleanup);
+
+MODULE_DESCRIPTION("UML Host Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");
_
