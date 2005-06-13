Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVFMQny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVFMQny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVFMQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:43:54 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:59292 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261791AbVFMQmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:42:24 -0400
Message-ID: <42ADB768.9030801@brturbo.com.br>
Date: Mon, 13 Jun 2005 13:42:16 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fixes removal of normal_i2c_range on V4L
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------070407000902090307090609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407000902090307090609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew, After sending patch07, I found it was generated with wrong tuner-core.c. I'm sending it again. It should apply correctly this time.

As a reference, all patches 01 to 07 against 2.6.12-rc6-mm1 are at
http://linuxtv.org/download/video4linux/patches/2.6.12-rc6-mm

Mauro Carvalho Chehab wrote:


>This patch is necessary to correct I2C detect after normal_i2c_range
>removal applied by  gregkh-i2c-i2c-address_range_removal.patch at -mm
>series.
>
>Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>
>
> 


--------------070407000902090307090609
Content-Type: text/x-patch;
 name="patch07-remove_i2c_range.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch07-remove_i2c_range.diff"

diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/bt832.c linux-2.6.12-rc6-mm1/drivers/media/video/bt832.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/bt832.c	2005-06-13 11:51:08.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/bt832.c	2005-06-13 11:54:15.000000000 -0300
@@ -39,8 +39,8 @@
 MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_BT832_ALT1>>1,I2C_BT832_ALT2>>1,I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { I2C_BT832_ALT1>>1, I2C_BT832_ALT2>>1,
+				       I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* ---------------------------------------------------------------------- */
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/msp3400.c linux-2.6.12-rc6-mm1/drivers/media/video/msp3400.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/msp3400.c	2005-06-13 11:51:08.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/msp3400.c	2005-06-13 11:54:15.000000000 -0300
@@ -147,7 +147,6 @@
 	I2C_MSP3400C_ALT  >> 1,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* ----------------------------------------------------------------------- */
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/saa7134/saa6752hs.c linux-2.6.12-rc6-mm1/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/saa7134/saa6752hs.c	2005-06-13 11:51:11.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/saa7134/saa6752hs.c	2005-06-13 11:54:15.000000000 -0300
@@ -22,7 +22,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x20, I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 MODULE_DESCRIPTION("device driver for saa6752hs MPEG2 encoder");
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tda7432.c linux-2.6.12-rc6-mm1/drivers/media/video/tda7432.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tda7432.c	2005-06-13 11:51:08.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tda7432.c	2005-06-13 11:54:15.000000000 -0300
@@ -74,7 +74,6 @@
 	I2C_TDA7432 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* Structure of address and subaddresses for the tda7432 */
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tda9875.c linux-2.6.12-rc6-mm1/drivers/media/video/tda9875.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tda9875.c	2005-06-13 11:51:08.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tda9875.c	2005-06-13 11:54:15.000000000 -0300
@@ -44,7 +44,6 @@
     I2C_TDA9875 >> 1,
     I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* This is a superset of the TDA9875 */
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tda9887.c linux-2.6.12-rc6-mm1/drivers/media/video/tda9887.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tda9887.c	2005-06-13 11:51:08.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tda9887.c	2005-06-13 11:54:15.000000000 -0300
@@ -33,7 +33,6 @@
 	0x96 >>1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* insmod options */
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tuner-core.c linux-2.6.12-rc6-mm1/drivers/media/video/tuner-core.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tuner-core.c	2005-06-13 11:51:24.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tuner-core.c	2005-06-13 11:55:51.000000000 -0300
@@ -32,13 +32,10 @@
 /* standard i2c insmod options */
 static unsigned short normal_i2c[] = {
 	0x4b, /* tda8290 */
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {
-	0x60, 0x6f,
-	I2C_CLIENT_END
-};
-I2C_CLIENT_INSMOD;
 
 /* insmod options used at init time => read/only */
 static unsigned int addr  =  0;
@@ -324,9 +321,8 @@
 static int tuner_probe(struct i2c_adapter *adap)
 {
 	if (0 != addr) {
-		normal_i2c[0]       = addr;
-		normal_i2c_range[0] = addr;
-		normal_i2c_range[1] = addr;
+		normal_i2c[0] = addr;
+		normal_i2c[1] = I2C_CLIENT_END;
 	}
 	this_adap = 0;
 
Somente em linux-2.6.12-rc6-mm1/drivers/media/video: tuner-core.c.orig
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tvaudio.c linux-2.6.12-rc6-mm1/drivers/media/video/tvaudio.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tvaudio.c	2005-06-13 11:51:08.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tvaudio.c	2005-06-13 11:54:15.000000000 -0300
@@ -148,7 +148,6 @@
 	I2C_TDA9874   >> 1,
 	I2C_PIC16C54  >> 1,
 	I2C_CLIENT_END };
-static unsigned short normal_i2c_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
diff -ur linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tveeprom.c linux-2.6.12-rc6-mm1/drivers/media/video/tveeprom.c
--- linux-2.6.12-rc6-mm1-v4l/drivers/media/video/tveeprom.c	2005-06-13 11:51:11.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tveeprom.c	2005-06-13 11:54:15.000000000 -0300
@@ -482,7 +482,6 @@
 	0xa0 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 struct i2c_driver i2c_driver_tveeprom;

--------------070407000902090307090609--
