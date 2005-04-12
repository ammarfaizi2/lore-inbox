Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVDMEaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVDMEaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVDLTBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:01:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:62409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262113AbVDLKcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:43 -0400
Message-Id: <200504121032.j3CAWVVY005617@shell0.pdx.osdl.net>
Subject: [patch 120/198] fix u32 vs. pm_message_t in rest of the tree
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes u32 vs.  pm_message_t confusion in remaining places.  Fortunately
there's few of them.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/sh/kernel/cpu/bus.c    |    2 +-
 25-akpm/drivers/ide/pci/sc1200.c    |    2 +-
 25-akpm/drivers/macintosh/via-pmu.c |    2 +-
 25-akpm/include/asm-sh/bus-sh.h     |    2 +-
 25-akpm/include/linux/mmc/host.h    |    2 +-
 25-akpm/sound/oss/cs46xx.c          |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff -puN arch/sh/kernel/cpu/bus.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree arch/sh/kernel/cpu/bus.c
--- 25/arch/sh/kernel/cpu/bus.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree	2005-04-12 03:21:32.496196728 -0700
+++ 25-akpm/arch/sh/kernel/cpu/bus.c	2005-04-12 03:21:32.506195208 -0700
@@ -31,7 +31,7 @@ static int sh_bus_match(struct device *d
 	return shdev->dev_id == shdrv->dev_id;
 }
 
-static int sh_bus_suspend(struct device *dev, u32 state)
+static int sh_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct sh_dev *shdev = to_sh_dev(dev);
 	struct sh_driver *shdrv = to_sh_driver(dev->driver);
diff -puN drivers/ide/pci/sc1200.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree drivers/ide/pci/sc1200.c
--- 25/drivers/ide/pci/sc1200.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree	2005-04-12 03:21:32.497196576 -0700
+++ 25-akpm/drivers/ide/pci/sc1200.c	2005-04-12 03:21:32.507195056 -0700
@@ -346,7 +346,7 @@ typedef struct sc1200_saved_state_s {
 } sc1200_saved_state_t;
 
 
-static int sc1200_suspend (struct pci_dev *dev, u32 state)
+static int sc1200_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	ide_hwif_t		*hwif = NULL;
 
diff -puN drivers/macintosh/via-pmu.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree drivers/macintosh/via-pmu.c
--- 25/drivers/macintosh/via-pmu.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree	2005-04-12 03:21:32.499196272 -0700
+++ 25-akpm/drivers/macintosh/via-pmu.c	2005-04-12 03:21:32.509194752 -0700
@@ -3052,7 +3052,7 @@ pmu_polled_request(struct adb_request *r
 
 static int pmu_sys_suspended = 0;
 
-static int pmu_sys_suspend(struct sys_device *sysdev, u32 state)
+static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
 		return 0;
diff -puN include/asm-sh/bus-sh.h~fix-u32-vs-pm_message_t-in-rest-of-the-tree include/asm-sh/bus-sh.h
--- 25/include/asm-sh/bus-sh.h~fix-u32-vs-pm_message_t-in-rest-of-the-tree	2005-04-12 03:21:32.500196120 -0700
+++ 25-akpm/include/asm-sh/bus-sh.h	2005-04-12 03:21:32.510194600 -0700
@@ -34,7 +34,7 @@ struct sh_driver {
 	unsigned int		bus_id;
 	int (*probe)(struct sh_dev *);
 	int (*remove)(struct sh_dev *);
-	int (*suspend)(struct sh_dev *, u32);
+	int (*suspend)(struct sh_dev *, pm_message_t);
 	int (*resume)(struct sh_dev *);
 };
 
diff -puN include/linux/mmc/host.h~fix-u32-vs-pm_message_t-in-rest-of-the-tree include/linux/mmc/host.h
--- 25/include/linux/mmc/host.h~fix-u32-vs-pm_message_t-in-rest-of-the-tree	2005-04-12 03:21:32.501195968 -0700
+++ 25-akpm/include/linux/mmc/host.h	2005-04-12 03:21:32.510194600 -0700
@@ -98,7 +98,7 @@ extern void mmc_free_host(struct mmc_hos
 #define mmc_priv(x)	((void *)((x) + 1))
 #define mmc_dev(x)	((x)->dev)
 
-extern int mmc_suspend_host(struct mmc_host *, u32);
+extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);
 
 extern void mmc_detect_change(struct mmc_host *);
diff -puN sound/oss/cs46xx.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree sound/oss/cs46xx.c
--- 25/sound/oss/cs46xx.c~fix-u32-vs-pm_message_t-in-rest-of-the-tree	2005-04-12 03:21:32.504195512 -0700
+++ 25-akpm/sound/oss/cs46xx.c	2005-04-12 03:21:32.514193992 -0700
@@ -3640,7 +3640,7 @@ static int cs46xx_restart_part(struct cs
 
 static void cs461x_reset(struct cs_card *card);
 static void cs461x_proc_stop(struct cs_card *card);
-static int cs46xx_suspend(struct cs_card *card, u32 state)
+static int cs46xx_suspend(struct cs_card *card, pm_message_t state)
 {
 	unsigned int tmp;
 	CS_DBGOUT(CS_PM | CS_FUNCTION, 4, 
_
