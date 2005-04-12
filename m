Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVDLTRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVDLTRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVDLTPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:15:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:42953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbVDLKcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:33 -0400
Message-Id: <200504121032.j3CAWMdf005573@shell0.pdx.osdl.net>
Subject: [patch 109/198] fix u32 vs. pm_message_t in drivers/media
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

Here are fixes for drivers/media.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 25-akpm/drivers/media/video/meye.c              |    2 +-
 25-akpm/drivers/media/video/msp3400.c           |    4 ++--
 25-akpm/drivers/media/video/tda9887.c           |    2 +-
 25-akpm/drivers/media/video/tuner-core.c        |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/media/dvb/cinergyT2/cinergyT2.c~fix-u32-vs-pm_message_t-in-drivers-media drivers/media/dvb/cinergyT2/cinergyT2.c
--- 25/drivers/media/dvb/cinergyT2/cinergyT2.c~fix-u32-vs-pm_message_t-in-drivers-media	2005-04-12 03:21:29.655628560 -0700
+++ 25-akpm/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-04-12 03:21:29.664627192 -0700
@@ -879,7 +879,7 @@ static void cinergyt2_disconnect (struct
 	kfree(cinergyt2);
 }
 
-static int cinergyt2_suspend (struct usb_interface *intf, u32 state)
+static int cinergyt2_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 
diff -puN drivers/media/video/meye.c~fix-u32-vs-pm_message_t-in-drivers-media drivers/media/video/meye.c
--- 25/drivers/media/video/meye.c~fix-u32-vs-pm_message_t-in-drivers-media	2005-04-12 03:21:29.656628408 -0700
+++ 25-akpm/drivers/media/video/meye.c	2005-04-12 03:21:29.665627040 -0700
@@ -1768,7 +1768,7 @@ static struct video_device meye_template
 };
 
 #ifdef CONFIG_PM
-static int meye_suspend(struct pci_dev *pdev, u32 state)
+static int meye_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state(pdev);
 	meye.pm_mchip_mode = meye.mchip_mode;
diff -puN drivers/media/video/msp3400.c~fix-u32-vs-pm_message_t-in-drivers-media drivers/media/video/msp3400.c
--- 25/drivers/media/video/msp3400.c~fix-u32-vs-pm_message_t-in-drivers-media	2005-04-12 03:21:29.658628104 -0700
+++ 25-akpm/drivers/media/video/msp3400.c	2005-04-12 03:21:29.678625064 -0700
@@ -1426,7 +1426,7 @@ static int msp_detach(struct i2c_client 
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1834,7 +1834,7 @@ static int msp_command(struct i2c_client
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, u32 state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
diff -puN drivers/media/video/tda9887.c~fix-u32-vs-pm_message_t-in-drivers-media drivers/media/video/tda9887.c
--- 25/drivers/media/video/tda9887.c~fix-u32-vs-pm_message_t-in-drivers-media	2005-04-12 03:21:29.659627952 -0700
+++ 25-akpm/drivers/media/video/tda9887.c	2005-04-12 03:21:29.679624912 -0700
@@ -741,7 +741,7 @@ tda9887_command(struct i2c_client *clien
 	return 0;
 }
 
-static int tda9887_suspend(struct device * dev, u32 state, u32 level)
+static int tda9887_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	dprintk("tda9887: suspend\n");
 	return 0;
diff -puN drivers/media/video/tuner-core.c~fix-u32-vs-pm_message_t-in-drivers-media drivers/media/video/tuner-core.c
--- 25/drivers/media/video/tuner-core.c~fix-u32-vs-pm_message_t-in-drivers-media	2005-04-12 03:21:29.661627648 -0700
+++ 25-akpm/drivers/media/video/tuner-core.c	2005-04-12 03:21:29.680624760 -0700
@@ -378,7 +378,7 @@ tuner_command(struct i2c_client *client,
 	return 0;
 }
 
-static int tuner_suspend(struct device * dev, u32 state, u32 level)
+static int tuner_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 	struct tuner *t = i2c_get_clientdata(c);
_
