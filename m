Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVFVHCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVFVHCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVFVG7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:59:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:7580 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262781AbVFVFVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:55 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Merge unused address lists in some video drivers
In-Reply-To: <1119417461270@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:41 -0700
Message-Id: <1119417461139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Merge unused address lists in some video drivers

On top of my previous patch which removes the use of address ranges in
video i2c drivers, this one can save an additional few bytes of memory.
Most of these drivers which do not use I2C_CLIENT_INSMOD initialize the
unused address lists in a less than optimal way. This patch simply
optimizes this, by using a single one-element list instead of 3
different lists with two elements each.

This saves an average 63 bytes on these drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7170.c linux-2.6.12-rc1-bk5/drivers/media/video/adv7170.c

---
commit 68cc9d0b714d7d533c0cfc257a62f7f7f4f22a11
tree 616ee332d4a489598141512cbc01f591e1e84dec
parent b3d5496ea5915fa4848fe307af9f7097f312e932
author Jean Delvare <khali@linux-fr.org> Sat, 02 Apr 2005 20:04:41 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:49 -0700

 drivers/media/video/adv7170.c    |   10 ++++------
 drivers/media/video/adv7175.c    |   10 ++++------
 drivers/media/video/bt819.c      |   10 ++++------
 drivers/media/video/bt856.c      |   10 ++++------
 drivers/media/video/saa7110.c    |   10 ++++------
 drivers/media/video/saa7111.c    |   10 ++++------
 drivers/media/video/saa7114.c    |   10 ++++------
 drivers/media/video/saa7185.c    |   10 ++++------
 drivers/media/video/tuner-3036.c |   10 ++++------
 drivers/media/video/vpx3220.c    |   10 ++++------
 10 files changed, 40 insertions(+), 60 deletions(-)

diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -385,15 +385,13 @@ static unsigned short normal_i2c[] =
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_adv7170;
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -435,15 +435,13 @@ static unsigned short normal_i2c[] =
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_adv7175;
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -501,15 +501,13 @@ static unsigned short normal_i2c[] = {
 	I2C_CLIENT_END,
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_bt819;
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -289,15 +289,13 @@ bt856_command (struct i2c_client *client
  */
 static unsigned short normal_i2c[] = { I2C_BT856 >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_bt856;
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -464,15 +464,13 @@ static unsigned short normal_i2c[] = {
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7110;
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -483,15 +483,13 @@ saa7111_command (struct i2c_client *clie
  */
 static unsigned short normal_i2c[] = { I2C_SAA7111 >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7111;
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -821,15 +821,13 @@ saa7114_command (struct i2c_client *clie
 static unsigned short normal_i2c[] =
     { I2C_SAA7114 >> 1, I2C_SAA7114A >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7114;
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -381,15 +381,13 @@ saa7185_command (struct i2c_client *clie
  */
 static unsigned short normal_i2c[] = { I2C_SAA7185 >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7185;
diff --git a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c
+++ b/drivers/media/video/tuner-3036.c
@@ -35,15 +35,13 @@ static struct i2c_client client_template
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x60, 0x61, I2C_CLIENT_END };
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c	= normal_i2c,
-	.probe		= probe,
-	.ignore		= ignore,
-	.force		= force,
+	.probe		= &ignore,
+	.ignore		= &ignore,
+	.force		= &ignore,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -570,15 +570,13 @@ static unsigned short normal_i2c[] =
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver vpx3220_i2c_driver;

