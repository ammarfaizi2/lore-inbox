Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWDOTuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWDOTuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWDOTuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:50:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751345AbWDOTuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:50:18 -0400
Date: Sat, 15 Apr 2006 21:50:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/: remove dead #ifndef I2C_PEC code
Message-ID: <20060415195017.GM15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes dead #ifndef I2C_PEC code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/em28xx/em28xx-i2c.c |   17 -----------------
 drivers/media/video/tvmixer.c           |    8 --------
 2 files changed, 25 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx-i2c.c.old	2006-04-15 21:38:11.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx-i2c.c	2006-04-15 21:38:29.000000000 +0200
@@ -399,18 +399,6 @@ static u32 functionality(struct i2c_adap
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
-#ifndef I2C_PEC
-static void inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-#endif
-
 static int em28xx_set_tuner(int check_eeprom, struct i2c_client *client)
 {
 	struct em28xx *dev = client->adapter->algo_data;
@@ -480,12 +468,7 @@ static struct i2c_algorithm em28xx_algo 
 };
 
 static struct i2c_adapter em28xx_adap_template = {
-#ifdef I2C_PEC
 	.owner = THIS_MODULE,
-#else
-	.inc_use = inc_use,
-	.dec_use = dec_use,
-#endif
 	.class = I2C_CLASS_TV_ANALOG,
 	.name = "em28xx",
 	.id = I2C_HW_B_EM28XX,
--- linux-2.6.17-rc1-mm2-full/drivers/media/video/tvmixer.c.old	2006-04-15 21:38:37.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/video/tvmixer.c	2006-04-15 21:38:48.000000000 +0200
@@ -198,10 +198,6 @@ static int tvmixer_open(struct inode *in
 
 	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
-#ifndef I2C_PEC
-	if (client->adapter->inc_use)
-		client->adapter->inc_use(client->adapter);
-#endif
 	if (client->adapter->owner)
 		try_module_get(client->adapter->owner);
 	return 0;
@@ -217,10 +213,6 @@ static int tvmixer_release(struct inode 
 		return -ENODEV;
 	}
 
-#ifndef I2C_PEC
-	if (client->adapter->dec_use)
-		client->adapter->dec_use(client->adapter);
-#endif
 	if (client->adapter->owner)
 		module_put(client->adapter->owner);
 	return 0;

