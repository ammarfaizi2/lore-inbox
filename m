Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTBEAAd>; Tue, 4 Feb 2003 19:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTBEAAd>; Tue, 4 Feb 2003 19:00:33 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:34752 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267622AbTBEAAb>; Tue, 4 Feb 2003 19:00:31 -0500
Date: Tue, 4 Feb 2003 19:18:44 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.59: drivers/media/video/bt819.c
Message-ID: <Pine.LNX.4.44.0302041915490.4326-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 The following patch addresses Buzilla Bug #169, as well as fixes up i2c 
updates. Please review for inclusion. 

Regards,
Frank

--- linux/drivers/media/video/bt819.c.old	2003-01-25 23:03:47.000000000 -0500
+++ linux/drivers/media/video/bt819.c	2003-02-04 18:36:05.000000000 -0500
@@ -48,18 +48,8 @@
 
 static unsigned short normal_i2c[] = {34>>1, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
-static unsigned short probe[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
-static unsigned force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };	
-
-static struct i2c_client_address_data addr_data = {
-	normal_i2c , normal_i2c_range,
-	probe , probe_range,
-	ignore , ignore_range,
-	force
-};
+
+I2C_CLIENT_INSMOD;
 
 static struct i2c_client client_template;
 
@@ -100,10 +90,6 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int bt819_probe(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, bt819_attach);
-}
 
 static int bt819_setbit(struct bt819 *dev, int subaddr, int bit, int data)
 {
@@ -211,6 +197,10 @@
 	MOD_INC_USE_COUNT;
 	return 0;
 }
+static int bt819_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, bt819_attach);
+}
 
 static int bt819_detach(struct i2c_client *client)
 {
@@ -448,21 +438,19 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_bt819 = {
-	"bt819",		/* name */
-	I2C_DRIVERID_BT819,	/* ID */
-	I2C_DF_NOTIFY,
-	bt819_probe,
-	bt819_detach,
-	bt819_command
+        .name = "bt819",		/* name */
+	.id = I2C_DRIVERID_BT819,	/* ID */
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = bt819_probe,
+	.detach_client = bt819_detach,
+	.command = bt819_command
+
 };
 
 static struct i2c_client client_template = {
-	"bt819_client",
-	-1,
-	0,
-	0,
-	NULL,
-	&i2c_driver_bt819
+	.name = "bt819_client",
+	.id = -1,
+	.driver = &i2c_driver_bt819
 };
 
 static int bt819_setup(void)

