Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVDEVvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVDEVvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVDEVt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:49:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3213 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262059AbVDEVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:47:24 -0400
Date: Tue, 5 Apr 2005 23:47:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in rest of the tree
Message-ID: <20050405214707.GA1872@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t confusion in remaining
places. Fortunately there's few of them. Should
change no code. Please apply,

                                                                Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/arch/sh/kernel/cpu/bus.c	2004-08-15 19:14:54.000000000 +0200
+++ linux-mm/arch/sh/kernel/cpu/bus.c	2005-04-05 12:13:19.000000000 +0200
@@ -31,7 +31,7 @@
 	return shdev->dev_id == shdrv->dev_id;
 }
 
-static int sh_bus_suspend(struct device *dev, u32 state)
+static int sh_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct sh_dev *shdev = to_sh_dev(dev);
 	struct sh_driver *shdrv = to_sh_driver(dev->driver);
--- clean-mm/drivers/ide/pci/sc1200.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-mm/drivers/ide/pci/sc1200.c	2005-04-05 12:13:23.000000000 +0200
@@ -346,7 +346,7 @@
 } sc1200_saved_state_t;
 
 
-static int sc1200_suspend (struct pci_dev *dev, u32 state)
+static int sc1200_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	ide_hwif_t		*hwif = NULL;
 
--- clean-mm/drivers/macintosh/via-pmu.c	2005-04-05 10:55:13.000000000 +0200
+++ linux-mm/drivers/macintosh/via-pmu.c	2005-04-05 12:13:24.000000000 +0200
@@ -3052,7 +3052,7 @@
 
 static int pmu_sys_suspended = 0;
 
-static int pmu_sys_suspend(struct sys_device *sysdev, u32 state)
+static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
 		return 0;
--- clean-mm/include/asm-sh/bus-sh.h	2004-08-15 19:15:05.000000000 +0200
+++ linux-mm/include/asm-sh/bus-sh.h	2005-04-05 12:13:39.000000000 +0200
@@ -34,7 +34,7 @@
 	unsigned int		bus_id;
 	int (*probe)(struct sh_dev *);
 	int (*remove)(struct sh_dev *);
-	int (*suspend)(struct sh_dev *, u32);
+	int (*suspend)(struct sh_dev *, pm_message_t);
 	int (*resume)(struct sh_dev *);
 };
 
--- clean-mm/include/linux/mmc/host.h	2004-10-01 00:30:30.000000000 +0200
+++ linux-mm/include/linux/mmc/host.h	2005-04-05 12:13:39.000000000 +0200
@@ -98,7 +98,7 @@
 #define mmc_priv(x)	((void *)((x) + 1))
 #define mmc_dev(x)	((x)->dev)
 
-extern int mmc_suspend_host(struct mmc_host *, u32);
+extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);
 
 extern void mmc_detect_change(struct mmc_host *);
--- clean-mm/sound/oss/cs46xx.c	2005-04-05 10:55:41.000000000 +0200
+++ linux-mm/sound/oss/cs46xx.c	2005-04-05 12:13:42.000000000 +0200
@@ -3640,7 +3640,7 @@
 
 static void cs461x_reset(struct cs_card *card);
 static void cs461x_proc_stop(struct cs_card *card);
-static int cs46xx_suspend(struct cs_card *card, u32 state)
+static int cs46xx_suspend(struct cs_card *card, pm_message_t state)
 {
 	unsigned int tmp;
 	CS_DBGOUT(CS_PM | CS_FUNCTION, 4, 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
