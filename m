Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbVGIDJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbVGIDJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 23:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVGIDJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 23:09:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39175 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263103AbVGIDHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 23:07:39 -0400
Date: Sat, 9 Jul 2005 05:07:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Klar <linpvr@projectplasma.com>, linux-kernel@vger.kernel.org,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: [2.6 patch] drivers/media/video/tveeprom.c: possible cleanups
Message-ID: <20050709030737.GE28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make two needlessly global structs static
- #if 0 the EXPORT_SYMBOL'ed but unused function tveeprom_dump

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2005

 drivers/media/video/tveeprom.c |    6 ++++--
 include/media/tveeprom.h       |    1 -
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc2-mm3-full/include/media/tveeprom.h.old	2005-04-19 01:41:24.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/media/tveeprom.h	2005-04-19 01:41:28.000000000 +0200
@@ -20,4 +20,3 @@
 			       unsigned char *eeprom_data);
 
 int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len);
-int tveeprom_dump(unsigned char *eedata, int len);
--- linux-2.6.12-rc2-mm3-full/drivers/media/video/tveeprom.c.old	2005-04-19 01:40:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/tveeprom.c	2005-04-19 01:41:13.000000000 +0200
@@ -453,6 +453,7 @@
 }
 EXPORT_SYMBOL(tveeprom_read);
 
+#if 0
 int tveeprom_dump(unsigned char *eedata, int len)
 {
 	int i;
@@ -468,6 +469,7 @@
 	return 0;
 }
 EXPORT_SYMBOL(tveeprom_dump);
+#endif  /*  0  */
 
 /* ----------------------------------------------------------------------- */
 /* needed for ivtv.sf.net at the moment.  Should go away in the long       */
@@ -484,7 +486,7 @@
 };
 I2C_CLIENT_INSMOD;
 
-struct i2c_driver i2c_driver_tveeprom;
+static struct i2c_driver i2c_driver_tveeprom;
 
 static int
 tveeprom_command(struct i2c_client *client,
@@ -556,7 +558,7 @@
 	return 0;
 }
 
-struct i2c_driver i2c_driver_tveeprom = {
+static struct i2c_driver i2c_driver_tveeprom = {
 	.owner          = THIS_MODULE,
 	.name           = "tveeprom",
 	.id             = I2C_DRIVERID_TVEEPROM,

