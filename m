Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVDBVsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDBVsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDBVgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:36:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21921 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261375AbVDBVVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:21:18 -0500
Date: Sat, 2 Apr 2005 23:21:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in drivers/media
Message-ID: <20050402212100.GA2118@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are fixes for drivers/media. [These patches are independend and
change no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-03-29 13:29:54.000000000 +0200
+++ linux-cvs/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-03-31 23:54:45.000000000 +0200
@@ -879,7 +879,7 @@
 	kfree(cinergyt2);
 }
 
-static int cinergyt2_suspend (struct usb_interface *intf, u32 state)
+static int cinergyt2_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 
--- clean-cvs/drivers/media/video/meye.c	2005-03-29 13:29:56.000000000 +0200
+++ linux-cvs/drivers/media/video/meye.c	2005-03-31 23:54:45.000000000 +0200
@@ -1768,7 +1768,7 @@
 };
 
 #ifdef CONFIG_PM
-static int meye_suspend(struct pci_dev *pdev, u32 state)
+static int meye_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state(pdev);
 	meye.pm_mchip_mode = meye.mchip_mode;
--- clean-cvs/drivers/media/video/msp3400.c	2005-03-31 23:33:35.000000000 +0200
+++ linux-cvs/drivers/media/video/msp3400.c	2005-03-31 23:54:45.000000000 +0200
@@ -1426,7 +1426,7 @@
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1834,7 +1834,7 @@
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, u32 state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
--- clean-cvs/drivers/media/video/tda9887.c	2005-03-29 13:29:58.000000000 +0200
+++ linux-cvs/drivers/media/video/tda9887.c	2005-03-31 23:54:45.000000000 +0200
@@ -741,7 +741,7 @@
 	return 0;
 }
 
-static int tda9887_suspend(struct device * dev, u32 state, u32 level)
+static int tda9887_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	dprintk("tda9887: suspend\n");
 	return 0;
--- clean-cvs/drivers/media/video/tuner-core.c	2005-03-08 18:55:38.000000000 +0100
+++ linux-cvs/drivers/media/video/tuner-core.c	2005-03-31 23:54:45.000000000 +0200
@@ -378,7 +378,7 @@
 	return 0;
 }
 
-static int tuner_suspend(struct device * dev, u32 state, u32 level)
+static int tuner_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 	struct tuner *t = i2c_get_clientdata(c);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
