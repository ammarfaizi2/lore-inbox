Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVDBVsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVDBVsx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDBVgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:36:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27790 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261325AbVDBVTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:19:37 -0500
Date: Sat, 2 Apr 2005 23:19:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in pcmcia
Message-ID: <20050402211915.GA2102@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t in pcmcia. [These patches are
independend and change no object code; therefore not numbered]. Please
apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/pcmcia/au1000_generic.c	2005-03-31 23:34:03.000000000 +0200
+++ linux-cvs/drivers/pcmcia/au1000_generic.c	2005-03-31 23:54:46.000000000 +0200
@@ -518,7 +518,7 @@
 }
 
 
-static int au1x00_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int au1x00_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-cvs/drivers/pcmcia/hd64465_ss.c	2005-03-31 23:34:04.000000000 +0200
+++ linux-cvs/drivers/pcmcia/hd64465_ss.c	2005-03-31 23:54:46.000000000 +0200
@@ -845,7 +845,7 @@
 	local_irq_restore(flags);
 }
 
-static int hd64465_suspend(struct device *dev, u32 state, u32 level)
+static int hd64465_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-cvs/drivers/pcmcia/m32r_cfc.c	2005-03-31 23:34:04.000000000 +0200
+++ linux-cvs/drivers/pcmcia/m32r_cfc.c	2005-03-31 23:54:46.000000000 +0200
@@ -743,7 +743,7 @@
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-cvs/drivers/pcmcia/m32r_pcc.c	2005-03-31 23:34:04.000000000 +0200
+++ linux-cvs/drivers/pcmcia/m32r_pcc.c	2005-03-31 23:54:46.000000000 +0200
@@ -696,7 +696,7 @@
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-cvs/drivers/pcmcia/pxa2xx_base.c	2004-12-25 16:29:34.000000000 +0100
+++ linux-cvs/drivers/pcmcia/pxa2xx_base.c	2005-03-31 23:54:46.000000000 +0200
@@ -205,7 +205,7 @@
 }
 EXPORT_SYMBOL(pxa2xx_drv_pcmcia_probe);
 
-static int pxa2xx_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int pxa2xx_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-cvs/drivers/pcmcia/sa1100_generic.c	2004-11-19 12:20:08.000000000 +0100
+++ linux-cvs/drivers/pcmcia/sa1100_generic.c	2005-03-31 23:54:46.000000000 +0200
@@ -75,7 +75,7 @@
 	return ret;
 }
 
-static int sa11x0_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int sa11x0_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-cvs/drivers/pcmcia/sa1111_generic.c	2004-11-19 12:20:08.000000000 +0100
+++ linux-cvs/drivers/pcmcia/sa1111_generic.c	2005-03-31 23:54:46.000000000 +0200
@@ -158,7 +158,7 @@
 	return 0;
 }
 
-static int pcmcia_suspend(struct sa1111_dev *dev, u32 state)
+static int pcmcia_suspend(struct sa1111_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
--- clean-cvs/drivers/pcmcia/vrc4171_card.c	2005-03-31 23:34:04.000000000 +0200
+++ linux-cvs/drivers/pcmcia/vrc4171_card.c	2005-03-31 23:54:47.000000000 +0200
@@ -774,7 +774,7 @@
 
 __setup("vrc4171_card=", vrc4171_card_setup);
 
-static int vrc4171_card_suspend(struct device *dev, u32 state, u32 level)
+static int vrc4171_card_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int retval = 0;
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
