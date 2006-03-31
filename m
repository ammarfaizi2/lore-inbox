Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWCaKH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCaKH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCaKFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:20 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:17965 "EHLO
	linux") by vger.kernel.org with ESMTP id S932081AbWCaKEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:48 -0500
Message-Id: <20060331100424.440602000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:30 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org, Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 07/10] RTC subsystem, compact error messages
Content-Disposition: inline; filename=rtc-subsys-compact-err-message.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - move registration error message from drivers
 to core.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>

---
 drivers/rtc/class.c       |    2 ++
 drivers/rtc/rtc-ds1672.c  |    2 --
 drivers/rtc/rtc-ep93xx.c  |    1 -
 drivers/rtc/rtc-m48t86.c  |    4 +---
 drivers/rtc/rtc-pcf8563.c |    2 --
 drivers/rtc/rtc-rs5c372.c |    2 --
 drivers/rtc/rtc-sa1100.c  |    1 -
 drivers/rtc/rtc-test.c    |    2 --
 drivers/rtc/rtc-x1205.c   |    2 --
 9 files changed, 3 insertions(+), 15 deletions(-)

--- linux-rtc.orig/drivers/rtc/class.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/class.c	2006-03-29 02:55:47.000000000 +0200
@@ -96,6 +96,8 @@ exit_idr:
 	idr_remove(&rtc_idr, id);
 
 exit:
+	dev_err(dev, "rtc core: unable to register %s, err = %d\n",
+			name, err);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(rtc_device_register);
--- linux-rtc.orig/drivers/rtc/rtc-x1205.c	2006-03-29 02:50:57.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-x1205.c	2006-03-29 02:53:01.000000000 +0200
@@ -544,8 +544,6 @@ static int x1205_probe(struct i2c_adapte
 
 	if (IS_ERR(rtc)) {
 		err = PTR_ERR(rtc);
-		dev_err(&client->dev,
-			"unable to register the class device\n");
 		goto exit_detach;
 	}
 
--- linux-rtc.orig/drivers/rtc/rtc-ds1672.c	2006-03-29 02:29:43.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-ds1672.c	2006-03-29 02:57:10.000000000 +0200
@@ -229,8 +229,6 @@ static int ds1672_probe(struct i2c_adapt
 
 	if (IS_ERR(rtc)) {
 		err = PTR_ERR(rtc);
-		dev_err(&client->dev,
-			"unable to register the class device\n");
 		goto exit_detach;
 	}
 
--- linux-rtc.orig/drivers/rtc/rtc-m48t86.c	2006-03-29 02:50:57.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-m48t86.c	2006-03-29 02:56:48.000000000 +0200
@@ -151,10 +151,8 @@ static int __devinit m48t86_rtc_probe(st
 	struct rtc_device *rtc = rtc_device_register("m48t86",
 				&dev->dev, &m48t86_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc)) {
-		dev_err(&dev->dev, "unable to register\n");
+	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
-	}
 
 	platform_set_drvdata(dev, rtc);
 
--- linux-rtc.orig/drivers/rtc/rtc-pcf8563.c	2006-03-29 02:50:57.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-pcf8563.c	2006-03-29 02:57:01.000000000 +0200
@@ -290,8 +290,6 @@ static int pcf8563_probe(struct i2c_adap
 
 	if (IS_ERR(rtc)) {
 		err = PTR_ERR(rtc);
-		dev_err(&client->dev,
-			"unable to register the class device\n");
 		goto exit_detach;
 	}
 
--- linux-rtc.orig/drivers/rtc/rtc-test.c	2006-03-29 02:50:57.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-test.c	2006-03-29 02:56:29.000000000 +0200
@@ -119,8 +119,6 @@ static int test_probe(struct platform_de
 						&test_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
 		err = PTR_ERR(rtc);
-		dev_err(&plat_dev->dev,
-			"unable to register the class device\n");
 		return err;
 	}
 	device_create_file(&plat_dev->dev, &dev_attr_irq);
--- linux-rtc.orig/drivers/rtc/rtc-ep93xx.c	2006-03-29 02:50:57.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-ep93xx.c	2006-03-29 02:58:03.000000000 +0200
@@ -109,7 +109,6 @@ static int __devinit ep93xx_rtc_probe(st
 				&dev->dev, &ep93xx_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rtc)) {
-		dev_err(&dev->dev, "unable to register\n");
 		return PTR_ERR(rtc);
 	}
 
--- linux-rtc.orig/drivers/rtc/rtc-sa1100.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-sa1100.c	2006-03-29 02:57:38.000000000 +0200
@@ -341,7 +341,6 @@ static int sa1100_rtc_probe(struct platf
 				THIS_MODULE);
 
 	if (IS_ERR(rtc)) {
-		dev_err(&pdev->dev, "Unable to register the RTC device\n");
 		return PTR_ERR(rtc);
 	}
 
--- linux-rtc.orig/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:50:58.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:59:15.000000000 +0200
@@ -233,8 +233,6 @@ static int rs5c372_probe(struct i2c_adap
 
 	if (IS_ERR(rtc)) {
 		err = PTR_ERR(rtc);
-		dev_err(&client->dev,
-			"unable to register the class device\n");
 		goto exit_detach;
 	}
 

--
