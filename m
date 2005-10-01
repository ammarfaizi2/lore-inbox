Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVJAFCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVJAFCC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 01:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVJAFCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 01:02:02 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11695 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750732AbVJAFCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 01:02:00 -0400
Date: Fri, 30 Sep 2005 22:02:02 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [PATCH] [I2C] kmalloc + memzero -> kzalloc conversion
Message-ID: <20051001050202.GE11137@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -104,11 +104,10 @@ static int ixp2000_i2c_probe(struct devi
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp2000_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp2000_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
+		kzalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
 
 	if (!drv_data)
 		return -ENOMEM;
-	memzero(drv_data, sizeof(*drv_data));
 	drv_data->gpio_pins = gpio;
 
 	drv_data->algo_data.data = gpio;
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -105,12 +105,11 @@ static int ixp4xx_i2c_probe(struct devic
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp4xx_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp4xx_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
+		kzalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
 
 	if(!drv_data)
 		return -ENOMEM;
 
-	memzero(drv_data, sizeof(struct ixp4xx_i2c_data));
 	drv_data->gpio_pins = gpio;
 
 	/*
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
