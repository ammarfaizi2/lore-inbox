Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTACGC1>; Fri, 3 Jan 2003 01:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbTACGC0>; Fri, 3 Jan 2003 01:02:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11514 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267415AbTACGCZ>; Fri, 3 Jan 2003 01:02:25 -0500
Date: Fri, 3 Jan 2003 07:10:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: andreas.bombe@munich.netsurf.de, bcollins@debian.org
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.5 patch] convert pcilynx.c to C99 initializers
Message-ID: <20030103061052.GY6114@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

in 2.5.54 struct i2c_adapter changed resulting in a compile error in
pcilynx.c. The patch below that converts pcilynx.c to C99 initializers 
fixes it.

cu
Adrian

--- linux-2.5.54/drivers/ieee1394/pcilynx.c.old	2003-01-03 06:58:52.000000000 +0100
+++ linux-2.5.54/drivers/ieee1394/pcilynx.c	2003-01-03 07:02:47.000000000 +0100
@@ -127,23 +127,20 @@
 }
 
 static struct i2c_algo_bit_data bit_data = {
-	NULL,
-	bit_setsda,
-	bit_setscl,
-	bit_getsda,
-	bit_getscl,
-	5, 5, 100,		/*	waits, timeout */
+	.setsda			= bit_setsda,
+	.setscl			= bit_setscl,
+	.getsda			= bit_getsda,
+	.getscl			= bit_getscl,
+	.udelay			= 5,
+	.mdelay			= 5,
+	.timeout		= 100,
 }; 
 
 static struct i2c_adapter bit_ops = {
-	"PCILynx I2C adapter",
-	0xAA, //FIXME: probably we should get an id in i2c-id.h
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	bit_reg,
-	bit_unreg,
+	.name			= "PCILynx I2C adapter",
+	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
+	.client_register	= bit_reg,
+	.client_unregister	= bit_unreg,
 };
 
 
