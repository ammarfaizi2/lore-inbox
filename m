Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTIVXtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTIVXrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:47:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:10401 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262592AbTIVXax convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064273428458@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734283922@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1381, 2003/09/22 16:03:26-07:00, greg@kroah.com

[PATCH] I2C: remove I2C_VERSION and I2C_DATE as they make no sense in the kernel tree.


 drivers/i2c/busses/i2c-ali1535.c  |    1 -
 drivers/i2c/busses/i2c-ali15x3.c  |    1 -
 drivers/i2c/busses/i2c-elektor.c  |   18 +++++++++---------
 drivers/i2c/busses/i2c-i801.c     |    1 -
 drivers/i2c/busses/i2c-piix4.c    |    1 -
 drivers/i2c/busses/i2c-rpx.c      |    2 +-
 drivers/i2c/busses/i2c-sis5595.c  |    1 -
 drivers/i2c/busses/i2c-sis630.c   |    1 -
 drivers/i2c/busses/i2c-velleman.c |    4 ++--
 drivers/i2c/busses/i2c-via.c      |    1 -
 drivers/i2c/i2c-dev.c             |    3 +--
 include/linux/i2c.h               |    3 ---
 12 files changed, 13 insertions(+), 24 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Sep 22 16:11:27 2003
@@ -525,7 +525,6 @@
 
 static int __init i2c_ali1535_init(void)
 {
-	printk(KERN_INFO "i2c-ali1535 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&ali1535_driver);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Mon Sep 22 16:11:27 2003
@@ -517,7 +517,6 @@
 
 static int __init i2c_ali15x3_init(void)
 {
-	printk("i2c-ali15x3.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&ali15x3_driver);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-elektor.c	Mon Sep 22 16:11:27 2003
@@ -77,7 +77,7 @@
 		val |= I2C_PCF_ENI;
 	}
 
-	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
+	DEB3(printk(KERN_DEBUG "i2c-elektor: Write 0x%X 0x%02X\n", address, val & 255));
 
 	switch (mmapped) {
 	case 0: /* regular I/O */
@@ -98,7 +98,7 @@
 	int address = ctl ? (base + 1) : base;
 	int val = mmapped ? readb(address) : inb(address);
 
-	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
+	DEB3(printk(KERN_DEBUG "i2c-elektor: Read 0x%X 0x%02X\n", address, val));
 
 	return (val);
 }
@@ -143,14 +143,14 @@
 	if (!mmapped) {
 		if (!request_region(base, 2, "i2c (isa bus adapter)")) {
 			printk(KERN_ERR
-			       "i2c-elektor.o: requested I/O region (0x%X:2) "
+			       "i2c-elektor: requested I/O region (0x%X:2) "
 			       "is in use.\n", base);
 			return -ENODEV;
 		}
 	}
 	if (irq > 0) {
 		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
-			printk(KERN_ERR "i2c-elektor.o: Request irq%d failed\n", irq);
+			printk(KERN_ERR "i2c-elektor: Request irq%d failed\n", irq);
 			irq = 0;
 		} else
 			enable_irq(irq);
@@ -196,7 +196,7 @@
 			/* yeap, we've found cypress, let's check config */
 			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
 				
-				DEB3(printk(KERN_DEBUG "i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+				DEB3(printk(KERN_DEBUG "i2c-elektor: found cy82c693, config register 0x47 = 0x%02x.\n", config));
 
 				/* UP2000 board has this register set to 0xe1,
                                    but the most significant bit as seems can be 
@@ -218,7 +218,7 @@
 					   8.25 MHz (PCI/4) clock
 					   (this can be read from cypress) */
 					clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
-					printk(KERN_INFO "i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
+					printk(KERN_INFO "i2c-elektor: found API UP2000 like board, will probe PCF8584 later.\n");
 				}
 			}
 		}
@@ -227,11 +227,11 @@
 
 	/* sanity checks for mmapped I/O */
 	if (mmapped && base < 0xc8000) {
-		printk(KERN_ERR "i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
+		printk(KERN_ERR "i2c-elektor: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO "i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-elektor: i2c pcf8584-isa adapter driver\n");
 
 	if (base == 0) {
 		base = DEFAULT_BASE;
@@ -243,7 +243,7 @@
 	if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
 		goto fail;
 	
-	printk(KERN_ERR "i2c-elektor.o: found device at %#x.\n", base);
+	printk(KERN_ERR "i2c-elektor: found device at %#x.\n", base);
 
 	return 0;
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Sep 22 16:11:27 2003
@@ -616,7 +616,6 @@
 
 static int __init i2c_i801_init(void)
 {
-	printk(KERN_INFO "i2c-i801 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&i801_driver);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 16:11:27 2003
@@ -473,7 +473,6 @@
 
 static int __init i2c_piix4_init(void)
 {
-	printk(KERN_INFO "i2c-piix4 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&piix4_driver);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-rpx.c	Mon Sep 22 16:11:27 2003
@@ -78,7 +78,7 @@
 
 int __init i2c_rpx_init(void)
 {
-	printk("i2c-rpx.o: i2c MPC8xx module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-rpx: i2c MPC8xx driver\n");
 
 	/* reset hardware to sane state */
 	rpx_iic_init(&rpx_data);
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Sep 22 16:11:27 2003
@@ -399,7 +399,6 @@
 
 static int __init i2c_sis5595_init(void)
 {
-	printk(KERN_INFO "i2c-sis5595 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&sis5595_driver);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-sis630.c	Mon Sep 22 16:11:27 2003
@@ -474,7 +474,6 @@
 
 static int __init i2c_sis630_init(void)
 {
-	printk("i2c-sis630.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&sis630_driver);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Sep 22 16:11:27 2003
@@ -120,7 +120,7 @@
 
 static int __init i2c_bitvelle_init(void)
 {
-	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-velleman: i2c Velleman K8000 driver\n");
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
@@ -140,7 +140,7 @@
 			return -ENODEV;
 		}
 	}
-	printk(KERN_DEBUG "i2c-velleman.o: found device at %#x.\n",base);
+	printk(KERN_DEBUG "i2c-velleman: found device at %#x.\n",base);
 	return 0;
 }
 
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/busses/i2c-via.c	Mon Sep 22 16:11:27 2003
@@ -165,7 +165,6 @@
 
 static int __init i2c_vt586b_init(void)
 {
-	printk(KERN_INFO "i2c-via version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&vt586b_driver);
 }
 
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Sep 22 16:11:27 2003
+++ b/drivers/i2c/i2c-dev.c	Mon Sep 22 16:11:27 2003
@@ -505,8 +505,7 @@
 {
 	int res;
 
-	printk(KERN_INFO "i2c /dev entries driver module version %s (%s)\n",
-		I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c /dev entries driver\n");
 
 	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
 		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Mon Sep 22 16:11:27 2003
+++ b/include/linux/i2c.h	Mon Sep 22 16:11:27 2003
@@ -28,9 +28,6 @@
 #ifndef _LINUX_I2C_H
 #define _LINUX_I2C_H
 
-#define I2C_DATE "20021208"
-#define I2C_VERSION "2.7.0"
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/i2c-id.h>

