Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVAYLJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVAYLJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVAYLJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:09:49 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:26589 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261890AbVAYLJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:09:47 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 25 Jan 2005 12:04:30 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: akpm@osdl.org, Christoph Bartelmus <lirc@bartelmus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add i2c adapter id for the cx88 driver.
Message-ID: <20050125110430.GA2027@bytesex>
References: <20050125102036.GA1696@bytesex> <sbi0fAAA.1106649524.3006370.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sbi0fAAA.1106649524.3006370.khali@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 0x1a is reserved for TI PCILynx in the i2c project, although I never took
> the time to forward the update to the kernel trees. Could you please use
> 0x1b instead?

Ok, here is a new version of the patch, using 0x1b.

  Gerd

Index: linux-2005-01-23/include/linux/i2c-id.h
===================================================================
--- linux-2005-01-23.orig/include/linux/i2c-id.h	2005-01-24 16:27:38.000000000 +0100
+++ linux-2005-01-23/include/linux/i2c-id.h	2005-01-25 11:57:45.000000000 +0100
@@ -239,6 +239,7 @@
 #define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
+#define I2C_HW_B_CX2388x 0x1b	/* connexant 2388x based tv cards	*/
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
Index: linux-2005-01-23/drivers/media/video/cx88/cx88-i2c.c
===================================================================
--- linux-2005-01-23.orig/drivers/media/video/cx88/cx88-i2c.c	2005-01-24 16:28:43.000000000 +0100
+++ linux-2005-01-23/drivers/media/video/cx88/cx88-i2c.c	2005-01-25 11:57:21.000000000 +0100
@@ -134,7 +134,7 @@ static struct i2c_algo_bit_data cx8800_i
 static struct i2c_adapter cx8800_i2c_adap_template = {
 	I2C_DEVNAME("cx2388x"),
 	.owner             = THIS_MODULE,
-	.id                = I2C_HW_B_BT848,
+	.id                = I2C_HW_B_CX2388x,
 	.client_register   = attach_inform,
 	.client_unregister = detach_inform,
 };
