Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVDMEWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVDMEWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVDLTC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:02:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:58313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262220AbVDLKcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:41 -0400
Message-Id: <200504121032.j3CAWUbY005613@shell0.pdx.osdl.net>
Subject: [patch 119/198] fix u32 vs. pm_message_t in driver/video
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes u32 vs.  pm_message_t confusion in drivers/video.  Should change no
code.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/backlight/corgi_bl.c     |    2 +-
 25-akpm/drivers/video/pxafb.c                  |    2 +-
 25-akpm/drivers/video/sa1100fb.c               |    2 +-
 25-akpm/drivers/video/savage/savagefb_driver.c |    4 ++--
 25-akpm/drivers/video/w100fb.c                 |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/video/backlight/corgi_bl.c~fix-u32-vs-pm_message_t-in-driver-video drivers/video/backlight/corgi_bl.c
--- 25/drivers/video/backlight/corgi_bl.c~fix-u32-vs-pm_message_t-in-driver-video	2005-04-12 03:21:32.226237768 -0700
+++ 25-akpm/drivers/video/backlight/corgi_bl.c	2005-04-12 03:21:32.235236400 -0700
@@ -81,7 +81,7 @@ static void corgibl_blank(int blank)
 }
 
 #ifdef CONFIG_PM
-static int corgibl_suspend(struct device *dev, u32 state, u32 level)
+static int corgibl_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN)
 		corgibl_blank(FB_BLANK_POWERDOWN);
diff -puN drivers/video/pxafb.c~fix-u32-vs-pm_message_t-in-driver-video drivers/video/pxafb.c
--- 25/drivers/video/pxafb.c~fix-u32-vs-pm_message_t-in-driver-video	2005-04-12 03:21:32.228237464 -0700
+++ 25-akpm/drivers/video/pxafb.c	2005-04-12 03:21:32.236236248 -0700
@@ -942,7 +942,7 @@ pxafb_freq_policy(struct notifier_block 
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int pxafb_suspend(struct device *dev, u32 state, u32 level)
+static int pxafb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct pxafb_info *fbi = dev_get_drvdata(dev);
 
diff -puN drivers/video/sa1100fb.c~fix-u32-vs-pm_message_t-in-driver-video drivers/video/sa1100fb.c
--- 25/drivers/video/sa1100fb.c~fix-u32-vs-pm_message_t-in-driver-video	2005-04-12 03:21:32.229237312 -0700
+++ 25-akpm/drivers/video/sa1100fb.c	2005-04-12 03:21:32.238235944 -0700
@@ -1307,7 +1307,7 @@ sa1100fb_freq_policy(struct notifier_blo
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int sa1100fb_suspend(struct device *dev, u32 state, u32 level)
+static int sa1100fb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
 
diff -puN drivers/video/savage/savagefb_driver.c~fix-u32-vs-pm_message_t-in-driver-video drivers/video/savage/savagefb_driver.c
--- 25/drivers/video/savage/savagefb_driver.c~fix-u32-vs-pm_message_t-in-driver-video	2005-04-12 03:21:32.231237008 -0700
+++ 25-akpm/drivers/video/savage/savagefb_driver.c	2005-04-12 03:21:32.240235640 -0700
@@ -2103,7 +2103,7 @@ static void __devexit savagefb_remove (s
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, u32 state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
@@ -2118,7 +2118,7 @@ static int savagefb_suspend (struct pci_
 	release_console_sem();
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
diff -puN drivers/video/w100fb.c~fix-u32-vs-pm_message_t-in-driver-video drivers/video/w100fb.c
--- 25/drivers/video/w100fb.c~fix-u32-vs-pm_message_t-in-driver-video	2005-04-12 03:21:32.232236856 -0700
+++ 25-akpm/drivers/video/w100fb.c	2005-04-12 03:21:32.241235488 -0700
@@ -544,7 +544,7 @@ static void w100fb_clear_buffer(void)
 
 
 #ifdef CONFIG_PM
-static int w100fb_suspend(struct device *dev, u32 state, u32 level)
+static int w100fb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		struct fb_info *info = dev_get_drvdata(dev);
_
