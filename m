Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270089AbTGSPlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270351AbTGSPlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:41:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:20128 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270089AbTGSPkD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:40:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10586300964092@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test1
In-Reply-To: <1058630094923@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 19 Jul 2003 08:54:56 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1527, 2003/07/18 23:32:43-07:00, greg@kroah.com

[PATCH] I2C: minor cleanups to the i2c-nforce2 driver.


 drivers/i2c/busses/i2c-nforce2.c |   24 +++---------------------
 1 files changed, 3 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Sat Jul 19 08:48:02 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Sat Jul 19 08:48:02 2003
@@ -43,14 +43,10 @@
 #include <linux/delay.h>
 #include <asm/io.h>
 
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
 MODULE_AUTHOR ("Hans-Frieder Vogt <hfvogt@arcor.de>");
 MODULE_DESCRIPTION("nForce2 SMBus driver");
 
-#define LM_VERSION "2.80-lk1"
-#define LM_DATE    "2003/07/12"
 
 #ifndef PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
@@ -114,13 +110,6 @@
 static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write,
 		       u8 command, int size, union i2c_smbus_data *data);
-#if 0
-static void nforce2_do_pause(unsigned int amount);
-#endif
-/*
-static int nforce2_block_transaction(union i2c_smbus_data *data,
-				  char read_write, int i2c_enable);
- */
 static u32 nforce2_func(struct i2c_adapter *adapter);
 
 
@@ -345,18 +334,12 @@
 			smbus->base, smbus->base+smbus->size-1, name);
 		return -1;
 	}
-
-	/* TODO: find a better way to find out whether this file is compiled
-	 * with i2c 2.7.0 of earlier
-	 */
-/*#ifdef I2C_HW_SMBUS_AMD8111
+/*
 	smbus->adapter.owner = THIS_MODULE;
-#endif
-
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2;
 	smbus->adapter.algo = &smbus_algorithm;
-	smbus->adapter.algo_data = smbus;*/
-
+	smbus->adapter.algo_data = smbus;
+*/
 	smbus->adapter = nforce2_adapter;
 	smbus->adapter.dev.parent = &dev->dev;
 	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
@@ -430,7 +413,6 @@
 
 static int __init nforce2_init(void)
 {
-	printk(KERN_INFO "i2c-nforce2 version %s (%s)\n", LM_VERSION, LM_DATE);
 	return pci_module_init(&nforce2_driver);
 }
 

