Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271539AbTGQSjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271530AbTGQShi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:37:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:29852 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271525AbTGQSfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:35:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 17 Jul 2003 20:45:17 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] drivers/media/video/tuner.c update
Message-ID: <20030717184517.GA22196@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds support for one more tv tuner chip to the
tuner module.

  Gerd

diff -u linux-2.6.0-test1/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.0-test1/drivers/media/video/tuner.c	2003-07-17 18:56:49.855733482 +0200
+++ linux/drivers/media/video/tuner.c	2003-07-17 19:13:34.490310872 +0200
@@ -225,6 +225,8 @@
 
 	{ "HITACHI V7-J180AT", HITACHI, NTSC,
 	  16*170.00, 16*450.00, 0x01,0x02,0x00,0x8e,940 },
+	{ "Philips PAL_MK (FI1216 MK)", Philips, PAL,
+	  16*140.25,16*463.25,0x01,0xc2,0xcf,0x8e,623},
 };
 #define TUNERS ARRAY_SIZE(tuners)
 
@@ -960,11 +962,9 @@
 };
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-	.driver = &driver,
-	.dev  = {
-		.name   = "(tuner unset)",
-	},
+	I2C_DEVNAME("(tuner unset)"),
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &driver,
 };
 
 static int tuner_init_module(void)
diff -u linux-2.6.0-test1/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.0-test1/include/media/tuner.h	2003-07-17 18:56:42.279032859 +0200
+++ linux/include/media/tuner.h	2003-07-17 19:13:34.494310203 +0200
@@ -65,8 +65,7 @@
 #define TUNER_PHILIPS_FM1216ME_MK3  38
 #define TUNER_LG_NTSC_NEW_TAPC   39
 #define TUNER_HITACHI_NTSC       40
-
-
+#define TUNER_PHILIPS_PAL_MK     41
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */

-- 
sigfault
