Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbULYPek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbULYPek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 10:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULYPek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 10:34:40 -0500
Received: from coderock.org ([193.77.147.115]:13276 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261518AbULYPeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 10:34:37 -0500
Subject: [patch 1/2] radio-sf16fmi cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, sebek64@post.cz
From: domen@coderock.org
Date: Sat, 25 Dec 2004 16:34:39 +0100
Message-Id: <20041225153430.6D7451EA0F@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry about duplicate, had mail problems]

This is small cleanup of radio-sf16fmi driver.

Compile tested.

Signed-off-by: Marcel Sebek <sebek64@post.cz>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/media/radio/radio-sf16fmi.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff -puN drivers/media/radio/radio-sf16fmi.c~cleanup-drivers_media_radio_radio-sf16fmi.c drivers/media/radio/radio-sf16fmi.c
--- kj/drivers/media/radio/radio-sf16fmi.c~cleanup-drivers_media_radio_radio-sf16fmi.c	2004-12-25 01:36:05.000000000 +0100
+++ kj-domen/drivers/media/radio/radio-sf16fmi.c	2004-12-25 01:36:05.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/delay.h>	/* udelay			*/
 #include <linux/videodev.h>	/* kernel radio structs		*/
 #include <linux/isapnp.h>
+#include <linux/moduleparam.h>
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
 #include <asm/semaphore.h>
@@ -36,7 +37,7 @@ struct fmi_device
 
 static int io = -1; 
 static int radio_nr = -1;
-static struct pnp_dev *dev = NULL;
+static struct pnp_dev *dev;
 static struct semaphore lock;
 
 /* freq is in 1/16 kHz to internal number, hw precision is 50 kHz */
@@ -312,9 +313,9 @@ MODULE_AUTHOR("Petr Vandrovec, vandrove@
 MODULE_DESCRIPTION("A driver for the SF16MI radio.");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(io, "i");
+module_param(io, int, 0444);
 MODULE_PARM_DESC(io, "I/O address of the SF16MI card (0x284 or 0x384)");
-MODULE_PARM(radio_nr, "i");
+module_param(radio_nr, int, 0444);
 
 static void __exit fmi_cleanup_module(void)
 {
@@ -326,13 +327,3 @@ static void __exit fmi_cleanup_module(vo
 
 module_init(fmi_init);
 module_exit(fmi_cleanup_module);
-
-#ifndef MODULE
-static int __init fmi_setup_io(char *str)
-{
-	get_option(&str, &io);
-	return 1;
-}
-
-__setup("sf16fm=", fmi_setup_io);
-#endif
_
