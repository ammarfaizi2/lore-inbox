Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVAHJZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVAHJZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVAHJXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:23:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:31877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261831AbVAHFsH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:07 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627753674@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627753411@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.3, 2004/12/15 11:37:22-08:00, icampbell@arcom.com

[PATCH] I2C: i2c-algo-bit should support I2C_FUNC_I2C

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/i2c-algo-pca.c |    4 ++--
 drivers/i2c/algos/i2c-algo-pcf.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c	2005-01-07 14:56:06 -08:00
+++ b/drivers/i2c/algos/i2c-algo-pca.c	2005-01-07 14:56:06 -08:00
@@ -189,7 +189,7 @@
 
 	state = pca_status(adap);
 	if ( state != 0xF8 ) {
-		printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
+		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state );
 		/* FIXME: what to do. Force stop ? */
 		return -EREMOTEIO;
 	}
@@ -328,7 +328,7 @@
 
 static u32 pca_func(struct i2c_adapter *adap)
 {
-        return I2C_FUNC_SMBUS_EMUL;
+        return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static int pca_init(struct i2c_algo_pca_data *adap)
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	2005-01-07 14:56:06 -08:00
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	2005-01-07 14:56:06 -08:00
@@ -414,8 +414,8 @@
 
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING; 
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING; 
 }
 
 /* -----exported algorithm data: -------------------------------------	*/

