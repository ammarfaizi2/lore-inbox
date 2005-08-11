Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVHKViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVHKViT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVHKViT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:38:19 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:48397 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750801AbVHKViS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:38:18 -0400
Date: Thu, 11 Aug 2005 23:38:52 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (3/7) I2C: Kill i2c_algorithm.id
Message-Id: <20050811233852.6f11b2f9.khali@linux-fr.org>
In-Reply-To: <20050811231828.3e7f5837.khali@linux-fr.org>
References: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on i2c_algorithm.id to alter the i2c adapter's id, use the
I2C_ALGO_* value directly instead, because i2c_algorithm will soon
have no id member no more.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/algos/i2c-algo-bit.c    |    2 +-
 drivers/i2c/algos/i2c-algo-ite.c    |    2 +-
 drivers/i2c/algos/i2c-algo-pca.c    |    2 +-
 drivers/i2c/algos/i2c-algo-pcf.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sgi.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c    |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-bit.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-bit.c	2005-08-02 20:43:50.000000000 +0200
@@ -541,7 +541,7 @@
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= i2c_bit_algo.id;
+	adap->id |= I2C_ALGO_BIT;
 	adap->algo = &i2c_bit_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-ite.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-ite.c	2005-08-02 20:43:50.000000000 +0200
@@ -738,7 +738,7 @@
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= iic_algo.id;
+	adap->id |= I2C_ALGO_IIC;
 	adap->algo = &iic_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-pca.c	2005-08-02 20:43:50.000000000 +0200
@@ -371,7 +371,7 @@
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= pca_algo.id;
+	adap->id |= I2C_ALGO_PCA;
 	adap->algo = &pca_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-pcf.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-pcf.c	2005-08-02 20:43:50.000000000 +0200
@@ -476,7 +476,7 @@
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= pcf_algo.id;
+	adap->id |= I2C_ALGO_PCF;
 	adap->algo = &pcf_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-02 20:43:50.000000000 +0200
@@ -168,7 +168,7 @@
  */
 int i2c_sgi_add_bus(struct i2c_adapter *adap)
 {
-	adap->id |= sgi_algo.id;
+	adap->id |= I2C_ALGO_SGI;
 	adap->algo = &sgi_algo;
 
 	return i2c_add_adapter(adap);
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-ibm_iic.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-ibm_iic.c	2005-08-02 20:43:50.000000000 +0200
@@ -726,7 +726,7 @@
 	adap = &dev->adap;
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_HW_OCP | iic_algo.id;
+	adap->id = I2C_ALGO_OCP | I2C_HW_OCP;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-sibyte.c	2005-08-02 20:43:50.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-sibyte.c	2005-08-02 20:44:27.000000000 +0200
@@ -151,7 +151,7 @@
 
 	/* register new adapter to i2c module... */
 
-	i2c_adap->id |= i2c_sibyte_algo.id;
+	i2c_adap->id |= I2C_ALGO_SIBYTE;
 	i2c_adap->algo = &i2c_sibyte_algo;
         
         /* Set the frequency to 100 kHz */

-- 
Jean Delvare
