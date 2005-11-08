Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVKHXIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVKHXIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbVKHXIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:08:11 -0500
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:27051 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030395AbVKHXIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:08:10 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/macintosh: Conversions from kmalloc/memset to kzalloc.
Message-Id: <20051108230727.97E2220A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 00:07:27 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/macintosh: Conversion from kmalloc/memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/macintosh/macio_asic.c           |    3 +--
 drivers/macintosh/smu.c                  |    3 +--
 drivers/macintosh/therm_adt746x.c        |    5 +----
 drivers/macintosh/therm_pm72.c           |    3 +--
 drivers/macintosh/therm_windtunnel.c     |    3 +--
 drivers/macintosh/windfarm_lm75_sensor.c |    3 +--
 6 files changed, 6 insertions(+), 14 deletions(-)

applies-to: 3d8c8b2fd07ad2c1df959421121451207373f78f
08cda0f8be0769031ce5060c3c8f52f71e341281
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index c34c96d..d0f48b0 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -305,10 +305,9 @@ static struct macio_dev * macio_add_one_
 	if (np == NULL)
 		return NULL;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(*dev));
 
 	dev->bus = &chip->lbus;
 	dev->media_bay = in_bay;
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index e837827..fc8016e 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1032,10 +1032,9 @@ static int smu_open(struct inode *inode,
 	struct smu_private *pp;
 	unsigned long flags;
 
-	pp = kmalloc(sizeof(struct smu_private), GFP_KERNEL);
+	pp = kzalloc(sizeof(struct smu_private), GFP_KERNEL);
 	if (pp == 0)
 		return -ENOMEM;
-	memset(pp, 0, sizeof(struct smu_private));
 	spin_lock_init(&pp->lock);
 	pp->mode = smu_file_commands;
 	init_waitqueue_head(&pp->wait);
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f386966..bddcd7a 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -370,13 +370,10 @@ static int attach_one_thermostat(struct 
 	if (thermostat)
 		return 0;
 
-	th = (struct thermostat *)
-		kmalloc(sizeof(struct thermostat), GFP_KERNEL);
-
+	th = kzalloc(sizeof(struct thermostat), GFP_KERNEL);
 	if (!th)
 		return -ENOMEM;
 
-	memset(th, 0, sizeof(*th));
 	th->clt.addr = addr;
 	th->clt.adapter = adapter;
 	th->clt.driver = &thermostat_driver;
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 3fc8cdd..6b7734c 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -308,10 +308,9 @@ static struct i2c_client *attach_i2c_chi
 	if (adap == NULL)
 		return NULL;
 
-	clt = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	clt = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (clt == NULL)
 		return NULL;
-	memset(clt, 0, sizeof(struct i2c_client));
 
 	clt->addr = (id >> 1) & 0x7f;
 	clt->adapter = adap;
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 6aaa1df..a2fd73a 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -431,9 +431,8 @@ do_probe( struct i2c_adapter *adapter, i
 				     | I2C_FUNC_SMBUS_WRITE_BYTE) )
 		return 0;
 
-	if( !(cl=kmalloc(sizeof(*cl), GFP_KERNEL)) )
+	if( !(cl=kzalloc(sizeof(*cl), GFP_KERNEL)) )
 		return -ENOMEM;
-	memset( cl, 0, sizeof(struct i2c_client) );
 
 	cl->addr = addr;
 	cl->adapter = adapter;
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index a0a41ad..954d1ed 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -116,10 +116,9 @@ static struct wf_lm75_sensor *wf_lm75_cr
 	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
 	    ds1775 ? "ds1775" : "lm75", addr);
 
-	lm = kmalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
+	lm = kzalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
 	if (lm == NULL)
 		return NULL;
-	memset(lm, 0, sizeof(struct wf_lm75_sensor));
 
 	/* Usual rant about sensor names not beeing very consistent in
 	 * the device-tree, oh well ...
---
0.99.9.GIT
