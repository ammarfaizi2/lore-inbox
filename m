Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTJUJiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTJUJhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:37:18 -0400
Received: from mail.convergence.de ([212.84.236.4]:34751 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262886AbTJUJg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:36:56 -0400
Subject: [PATCH 3/3] Fix bugs in analog tv i2c-helper chipset drivers
In-Reply-To: <1066729014790@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 21 Oct 2003 11:36:54 +0200
Message-Id: <10667290143917@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [V4L] remove cruft, memset() i2c-client structures in tda9840, tea6420, tea6415c driver, otherwise i2c_register()/kobject() segfaults later on
diff -ura xx-linux-2.6.0-test8/drivers/media/video/tda9840.c linux-2.6.0-test8-p/drivers/media/video/tda9840.c
--- xx-linux-2.6.0-test8/drivers/media/video/tda9840.c	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test8-p/drivers/media/video/tda9840.c	2003-10-21 11:21:02.000000000 +0200
@@ -196,6 +196,7 @@
 		printk("tda9840.o: not enough kernel memory.\n");
 		return -ENOMEM;
 	}
+	memset(client, 0, sizeof(struct i2c_client));
 	
 	/* fill client structure */
 	sprintf(client->name,"tda9840 (0x%02x)", address);
@@ -258,9 +259,7 @@
 }
 
 static struct i2c_driver driver = {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,54)
 	.owner		= THIS_MODULE,
-#endif
 	.name		= "tda9840 driver",
 	.id		= I2C_DRIVERID_TDA9840,
 	.flags		= I2C_DF_NOTIFY,
diff -ura xx-linux-2.6.0-test8/drivers/media/video/tea6415c.c linux-2.6.0-test8-p/drivers/media/video/tea6415c.c
--- xx-linux-2.6.0-test8/drivers/media/video/tea6415c.c	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test8-p/drivers/media/video/tea6415c.c	2003-10-21 11:20:48.000000000 +0200
@@ -70,6 +70,7 @@
         if (0 == client) {
 		return -ENOMEM;
 	}
+	memset(client, 0, sizeof(struct i2c_client));
 
 	/* fill client structure */
 	sprintf(client->name,"tea6415c (0x%02x)", address);
@@ -207,9 +208,7 @@
 }
 
 static struct i2c_driver driver = {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,54)
 	.owner		= THIS_MODULE,
-#endif
 	.name		= "tea6415c driver",
 	.id		= I2C_DRIVERID_TEA6415C,
 	.flags		= I2C_DF_NOTIFY,
diff -ura xx-linux-2.6.0-test8/drivers/media/video/tea6420.c linux-2.6.0-test8-p/drivers/media/video/tea6420.c
--- xx-linux-2.6.0-test8/drivers/media/video/tea6420.c	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test8-p/drivers/media/video/tea6420.c	2003-10-21 11:20:56.000000000 +0200
@@ -110,7 +110,8 @@
         if (0 == client) {
 		return -ENOMEM;
 	}
-	
+	memset(client, 0x0, sizeof(struct i2c_client));	
+
 	/* fill client structure */
 	sprintf(client->name,"tea6420 (0x%02x)", address);
 	client->id = tea6420_id++;
@@ -187,9 +188,7 @@
 }
 
 static struct i2c_driver driver = {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,54)
 	.owner		= THIS_MODULE,
-#endif
 	.name		= "tea6420 driver",
 	.id		= I2C_DRIVERID_TEA6420,
 	.flags		= I2C_DF_NOTIFY,

