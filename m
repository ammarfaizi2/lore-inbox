Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263841AbUDZOCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263841AbUDZOCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUDZOCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:02:50 -0400
Received: from mail.convergence.de ([212.84.236.4]:51076 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263841AbUDZNmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:42:21 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 9/9] DVB: Follow saa7146 changes in affected V4L drivers
In-Reply-To: <10829869142261@convergence.de>
Message-Id: <10829869172486@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:42:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [V4L] follow changes in saa7146 driver: mxb, dpc7146, hexium_orion, hexium_gemini
diff -ura linux-2.6.5.q/drivers/media/video/dpc7146.c linux-2.6.5.p/drivers/media/video/dpc7146.c
--- linux-2.6.5.q/drivers/media/video/dpc7146.c	2004-04-24 18:01:00.000000000 +0200
+++ linux-2.6.5.p/drivers/media/video/dpc7146.c	2004-04-24 18:02:26.000000000 +0200
@@ -106,7 +106,7 @@
 	   video port pins should be enabled here ?! */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&dpc->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(dpc);
@@ -312,18 +312,18 @@
 static struct saa7146_standard standard[] = {
 	{
 		.name	= "PAL", 	.id	= V4L2_STD_PAL,
-		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_offset	= 0x17,	.v_field 	= 288,
+		.h_offset	= 0x14,	.h_pixels 	= 680,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
-		.v_offset	= 0x16,	.v_field 	= 240,	.v_calc		= 480,
-		.h_offset	= 0x06,	.h_pixels 	= 708,	.h_calc		= 708+1,
+		.v_offset	= 0x16,	.v_field 	= 240,
+		.h_offset	= 0x06,	.h_pixels 	= 708,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}, {
 		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
-		.v_offset	= 0x14,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_offset	= 0x14,	.v_field 	= 288,
+		.h_offset	= 0x14,	.h_pixels 	= 720,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}
 };
diff -ura linux-2.6.5.q/drivers/media/video/hexium_gemini.c linux-2.6.5.p/drivers/media/video/hexium_gemini.c
--- linux-2.6.5.q/drivers/media/video/hexium_gemini.c	2004-04-24 18:00:54.000000000 +0200
+++ linux-2.6.5.p/drivers/media/video/hexium_gemini.c	2004-04-24 18:02:34.000000000 +0200
@@ -159,18 +159,18 @@
 static struct saa7146_standard hexium_standards[] = {
 	{
 		.name	= "PAL", 	.id	= V4L2_STD_PAL,
-		.v_offset	= 28,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 1,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_offset	= 28,	.v_field 	= 288,
+		.h_offset	= 1,	.h_pixels 	= 680,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
-		.v_offset	= 28,	.v_field 	= 240,	.v_calc		= 480,
-		.h_offset	= 1,	.h_pixels 	= 640,	.h_calc		= 641+1,
+		.v_offset	= 28,	.v_field 	= 240,
+		.h_offset	= 1,	.h_pixels 	= 640,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}, {
 		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
-		.v_offset	= 28,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 1,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_offset	= 28,	.v_field 	= 288,
+		.h_offset	= 1,	.h_pixels 	= 720,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}
 };		
@@ -250,7 +250,7 @@
 	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -ura linux-2.6.5.q/drivers/media/video/hexium_orion.c linux-2.6.5.p/drivers/media/video/hexium_orion.c
--- linux-2.6.5.q/drivers/media/video/hexium_orion.c	2004-04-24 18:00:51.000000000 +0200
+++ linux-2.6.5.p/drivers/media/video/hexium_orion.c	2004-04-24 18:03:09.000000000 +0200
@@ -192,18 +192,18 @@
 static struct saa7146_standard hexium_standards[] = {
 	{
 		.name	= "PAL", 	.id	= V4L2_STD_PAL,
-		.v_offset	= 16,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 1,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_offset	= 16,	.v_field 	= 288,
+		.h_offset	= 1,	.h_pixels 	= 680,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
-		.v_offset	= 16,	.v_field 	= 240,	.v_calc		= 480,
-		.h_offset	= 1,	.h_pixels 	= 640,	.h_calc		= 641+1,
+		.v_offset	= 16,	.v_field 	= 240,
+		.h_offset	= 1,	.h_pixels 	= 640,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}, {
 		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
-		.v_offset	= 16,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 1,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_offset	= 16,	.v_field 	= 288,
+		.h_offset	= 1,	.h_pixels 	= 720,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}
 };		
@@ -237,7 +237,7 @@
 	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -ura linux-2.6.5.q/drivers/media/video/mxb.c linux-2.6.5.p/drivers/media/video/mxb.c
--- linux-2.6.5.q/drivers/media/video/mxb.c	2004-04-24 17:57:34.000000000 +0200
+++ linux-2.6.5.p/drivers/media/video/mxb.c	2004-04-24 17:58:44.000000000 +0200
@@ -183,7 +183,7 @@
 	}
 	memset(mxb, 0x0, sizeof(struct mxb));	
 
-	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&mxb->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(mxb);
@@ -942,23 +942,23 @@
 static struct saa7146_standard standard[] = {
 	{
 		.name	= "PAL-BG", 	.id	= V4L2_STD_PAL_BG,
-		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_offset	= 0x17,	.v_field 	= 288,
+		.h_offset	= 0x14,	.h_pixels 	= 680,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "PAL-I", 	.id	= V4L2_STD_PAL_I,
-		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_offset	= 0x17,	.v_field 	= 288,
+		.h_offset	= 0x14,	.h_pixels 	= 680,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
-		.v_offset	= 0x16,	.v_field 	= 240,	.v_calc		= 480,
-		.h_offset	= 0x06,	.h_pixels 	= 708,	.h_calc		= 708+1,
+		.v_offset	= 0x16,	.v_field 	= 240,
+		.h_offset	= 0x06,	.h_pixels 	= 708,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}, {
 		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
-		.v_offset	= 0x14,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_offset	= 0x14,	.v_field 	= 288,
+		.h_offset	= 0x14,	.h_pixels 	= 720,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}
 };


