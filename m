Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTIVX76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbTIVX7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:59:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:28833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262813AbTIVXb2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:28 -0400
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <10642734262057@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734262038@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:26 -0700
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.20, 2003/09/22 13:44:13-07:00, greg@kroah.com

[PATCH] I2C: clean up the i2c-elv.c driver a bit


 drivers/i2c/busses/i2c-elv.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- a/drivers/i2c/busses/i2c-elv.c	Mon Sep 22 16:12:46 2003
+++ b/drivers/i2c/busses/i2c-elv.c	Mon Sep 22 16:12:46 2003
@@ -21,8 +21,6 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elv.c,v 1.27 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -36,7 +34,7 @@
 
 #define DEFAULT_BASE 0x378
 static int base=0;
-static unsigned char PortData = 0;
+static unsigned char port_data = 0;
 
 /* ----- global defines -----------------------------------------------	*/
 #define DEB(x)		/* should be reasonable open, close &c. 	*/
@@ -57,21 +55,21 @@
 static void bit_elv_setscl(void *data, int state)
 {
 	if (state) {
-		PortData &= 0xfe;
+		port_data &= 0xfe;
 	} else {
-		PortData |=1;
+		port_data |=1;
 	}
-	outb(PortData, DATA);
+	outb(port_data, DATA);
 }
 
 static void bit_elv_setsda(void *data, int state)
 {
 	if (state) {
-		PortData &=0xfd;
+		port_data &=0xfd;
 	} else {
-		PortData |=2;
+		port_data |=2;
 	}
-	outb(PortData, DATA);
+	outb(port_data, DATA);
 } 
 
 static int bit_elv_getscl(void *data)
@@ -103,7 +101,7 @@
 		goto fail;
 	}
 
-	PortData = 0;
+	port_data = 0;
 	bit_elv_setsda((void*)base,1);
 	bit_elv_setscl((void*)base,1);
 	return 0;
@@ -129,14 +127,13 @@
 
 static struct i2c_adapter bit_elv_ops = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_ELV,
 	.algo_data	= &bit_elv_data,
 	.name		= "ELV Parallel port adaptor",
 };
 
 static int __init i2c_bitelv_init(void)
 {
-	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c ELV parallel port adapter driver\n");
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;

