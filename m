Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUGOAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUGOAcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUGOAcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:32:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:62955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266013AbUGOAJR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:17 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500311477@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:12 -0700
Message-Id: <10898500313698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.10, 2004/07/09 15:07:03-07:00, greg@kroah.com

I2C: sparse cleanups for a few i2c drivers.


 drivers/i2c/busses/i2c-elektor.c |    6 +++---
 drivers/i2c/chips/adm1031.c      |   29 +++++++++++++----------------
 2 files changed, 16 insertions(+), 19 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2004-07-14 16:59:33 -07:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2004-07-14 16:59:33 -07:00
@@ -143,7 +143,7 @@
 		}
 	}
 	if (irq > 0) {
-		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
+		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", NULL) < 0) {
 			printk(KERN_ERR "i2c-elektor: Request irq%d failed\n", irq);
 			irq = 0;
 		} else
@@ -244,7 +244,7 @@
  fail:
 	if (irq > 0) {
 		disable_irq(irq);
-		free_irq(irq, 0);
+		free_irq(irq, NULL);
 	}
 
 	if (!mmapped)
@@ -258,7 +258,7 @@
 
 	if (irq > 0) {
 		disable_irq(irq);
-		free_irq(irq, 0);
+		free_irq(irq, NULL);
 	}
 
 	if (!mmapped)
diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:33 -07:00
+++ b/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:33 -07:00
@@ -101,10 +101,6 @@
 static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1031_init_client(struct i2c_client *client);
 static int adm1031_detach_client(struct i2c_client *client);
-static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg);
-static inline int
-adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value);
-
 static struct adm1031_data *adm1031_update_device(struct device *dev);
 
 /* This is the driver that will be inserted */
@@ -116,7 +112,19 @@
 	.detach_client = adm1031_detach_client,
 };
 
-static int adm1031_id = 0;
+static int adm1031_id;
+
+static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static inline int
+adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
 
 #define TEMP_TO_REG(val)		(((val) < 0 ? ((val - 500) / 1000) : \
 					((val + 500) / 1000)))
@@ -847,17 +855,6 @@
 	}
 	kfree(client);
 	return 0;
-}
-
-static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static inline int
-adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
 static void adm1031_init_client(struct i2c_client *client)

