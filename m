Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVDEVvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVDEVvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVDEVtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:49:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2701 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262052AbVDEVp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:45:56 -0400
Date: Tue, 5 Apr 2005 23:45:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in driver/video
Message-ID: <20050405214537.GA1861@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t confusion in drivers/video. Should
change no code. Please apply,

								Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/video/backlight/corgi_bl.c	2005-03-19 00:31:59.000000000 +0100
+++ linux-mm/drivers/video/backlight/corgi_bl.c	2005-04-05 12:13:38.000000000 +0200
@@ -81,7 +81,7 @@
 }
 
 #ifdef CONFIG_PM
-static int corgibl_suspend(struct device *dev, u32 state, u32 level)
+static int corgibl_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN)
 		corgibl_blank(FB_BLANK_POWERDOWN);
--- clean-mm/drivers/video/pxafb.c	2005-04-05 10:55:24.000000000 +0200
+++ linux-mm/drivers/video/pxafb.c	2005-04-05 12:13:38.000000000 +0200
@@ -942,7 +942,7 @@
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int pxafb_suspend(struct device *dev, u32 state, u32 level)
+static int pxafb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct pxafb_info *fbi = dev_get_drvdata(dev);
 
--- clean-mm/drivers/video/sa1100fb.c	2005-04-05 10:55:24.000000000 +0200
+++ linux-mm/drivers/video/sa1100fb.c	2005-04-05 12:13:38.000000000 +0200
@@ -1307,7 +1307,7 @@
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int sa1100fb_suspend(struct device *dev, u32 state, u32 level)
+static int sa1100fb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
 
--- clean-mm/drivers/video/savage/savagefb_driver.c	2005-04-05 10:55:24.000000000 +0200
+++ linux-mm/drivers/video/savage/savagefb_driver.c	2005-04-05 12:13:38.000000000 +0200
@@ -2103,7 +2103,7 @@
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, u32 state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
@@ -2118,7 +2118,7 @@
 	release_console_sem();
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
--- clean-mm/drivers/video/w100fb.c	2005-04-05 10:55:24.000000000 +0200
+++ linux-mm/drivers/video/w100fb.c	2005-04-05 12:13:38.000000000 +0200
@@ -544,7 +544,7 @@
 
 
 #ifdef CONFIG_PM
-static int w100fb_suspend(struct device *dev, u32 state, u32 level)
+static int w100fb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		struct fb_info *info = dev_get_drvdata(dev);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
