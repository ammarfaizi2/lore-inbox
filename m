Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTEQOHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 10:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTEQOHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 10:07:16 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:12714 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261506AbTEQOHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 10:07:14 -0400
Subject: [PATCH] fix tuner.c and tda9887.c in 2.5.69-mm6
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kraxel@bytesex.org
Content-Type: multipart/mixed; boundary="=-myzHmodgHcTLtY5d6vXR"
Organization: 
Message-Id: <1053181206.4174.9.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 May 2003 10:20:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-myzHmodgHcTLtY5d6vXR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached are two patches that make bttv compile and work in 2.5.69-mm6.
I think this broke in -mm4. The patches are probably not correct, but
they work for me.

Regards,

Shane

--=-myzHmodgHcTLtY5d6vXR
Content-Disposition: attachment; filename=2.5.69-mm6.tda9887.diff
Content-Type: text/x-diff; name=2.5.69-mm6.tda9887.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.69-mm6/drivers/media/video/tda9887.c.orig	Sat May 17 09:20:35 2003
+++ linux-2.5.69-mm6/drivers/media/video/tda9887.c	Sat May 17 09:49:01 2003
@@ -439,9 +439,11 @@
 };
 static struct i2c_client client_template =
 {
-        .dev.name  = "tda9887",
-	.flags     = I2C_CLIENT_ALLOW_USE,
-        .driver    = &driver,
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
+        .dev	= {
+		.name	= "tda9887",
+	},
 };
 
 static int tda9887_init_module(void)

--=-myzHmodgHcTLtY5d6vXR
Content-Disposition: attachment; filename=2.5.69-mm6.tuner.diff
Content-Type: text/x-diff; name=2.5.69-mm6.tuner.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.69-mm6/drivers/media/video/tuner.c.orig	Fri May 16 20:38:34 2003
+++ linux-2.5.69-mm6/drivers/media/video/tuner.c	Sat May 17 09:46:53 2003
@@ -960,9 +960,11 @@
 };
 static struct i2c_client client_template =
 {
-        .dev.name   = "(tuner unset)",
-	.flags      = I2C_CLIENT_ALLOW_USE,
-        .driver     = &driver,
+	.flags  = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
+	.dev  = {
+		.name   = "(tuner unset)",
+	},
 };
 
 static int tuner_init_module(void)

--=-myzHmodgHcTLtY5d6vXR--

