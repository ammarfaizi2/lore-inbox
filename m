Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbUKLXCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUKLXCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUKLXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:02:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26316 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262652AbUKLXAj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:39 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <1100300407889@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:07 -0800
Message-Id: <1100300407123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2100, 2004/11/12 11:44:09-08:00, greg@kroah.com

[PATCH] driver core: fix up some missed power_state changes from David's patch

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/video/aty/aty128fb.c   |   10 +++++-----
 drivers/video/aty/atyfb_base.c |   10 +++++-----
 drivers/video/aty/radeon_pm.c  |    6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)


diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	2004-11-12 14:52:49 -08:00
+++ b/drivers/video/aty/aty128fb.c	2004-11-12 14:52:49 -08:00
@@ -2363,7 +2363,7 @@
 		state = 2;
 #endif /* CONFIG_PPC_PMAC */
 	 
-	if (state != 2 || state == pdev->dev.power_state)
+	if (state != 2 || state == pdev->dev.power.power_state)
 		return 0;
 
 	printk(KERN_DEBUG "aty128fb: suspending...\n");
@@ -2394,7 +2394,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power_state = state;
+	pdev->dev.power.power_state = state;
 
 	return 0;
 }
@@ -2404,13 +2404,13 @@
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
 
-	if (pdev->dev.power_state == 0)
+	if (pdev->dev.power.power_state == 0)
 		return 0;
 
 	acquire_console_sem();
 
 	/* Wakeup chip */
-	if (pdev->dev.power_state == 2)
+	if (pdev->dev.power.power_state == 2)
 		aty128_set_suspend(par, 0);
 	par->asleep = 0;
 
@@ -2430,7 +2430,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power_state = 0;
+	pdev->dev.power.power_state = 0;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
 
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-11-12 14:52:49 -08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-11-12 14:52:49 -08:00
@@ -2033,7 +2033,7 @@
 		state = 2;
 #endif /* CONFIG_PPC_PMAC */
 
-	if (state != 2 || state == pdev->dev.power_state)
+	if (state != 2 || state == pdev->dev.power.power_state)
 		return 0;
 
 	acquire_console_sem();
@@ -2062,7 +2062,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power_state = state;
+	pdev->dev.power.power_state = state;
 
 	return 0;
 }
@@ -2072,12 +2072,12 @@
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-	if (pdev->dev.power_state == 0)
+	if (pdev->dev.power.power_state == 0)
 		return 0;
 
 	acquire_console_sem();
 
-	if (pdev->dev.power_state == 2)
+	if (pdev->dev.power.power_state == 2)
 		aty_power_mgmt(0, par);
 	par->asleep = 0;
 
@@ -2093,7 +2093,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power_state = 0;
+	pdev->dev.power.power_state = 0;
 
 	return 0;
 }
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c	2004-11-12 14:52:49 -08:00
+++ b/drivers/video/aty/radeon_pm.c	2004-11-12 14:52:49 -08:00
@@ -898,7 +898,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power_state = state;
+	pdev->dev.power.power_state = state;
 
 	return 0;
 }
@@ -908,7 +908,7 @@
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 
-	if (pdev->dev.power_state == 0)
+	if (pdev->dev.power.power_state == 0)
 		return 0;
 
 	acquire_console_sem();
@@ -935,7 +935,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power_state = 0;
+	pdev->dev.power.power_state = 0;
 
 	printk(KERN_DEBUG "radeonfb: resumed !\n");
 

