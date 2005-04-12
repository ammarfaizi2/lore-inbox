Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVDMD56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVDMD56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVDLTMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:12:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:46281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262209AbVDLKcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:35 -0400
Message-Id: <200504121032.j3CAWSPl005601@shell0.pdx.osdl.net>
Subject: [patch 116/198] u32 vs. pm_message_t in ppc and radeon
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes pm_message_t vs.  u32 confusion in ppc and aty (I *hope* that's
basically radeon code...).  I was not able to test most of these, but I'm
not really changing anything, so it should be okay.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/of_device.c |    2 +-
 25-akpm/include/asm-ppc/macio.h       |    2 +-
 25-akpm/include/asm-ppc/ocp.h         |    2 +-
 25-akpm/include/asm-ppc/of_device.h   |    2 +-
 drivers/video/aty/aty128fb.c          |    0 
 drivers/video/aty/atyfb_base.c        |    0 
 drivers/video/aty/radeonfb.h          |    0 
 7 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/ppc64/kernel/of_device.c~u32-vs-pm_message_t-in-ppc-and-radeon arch/ppc64/kernel/of_device.c
--- 25/arch/ppc64/kernel/of_device.c~u32-vs-pm_message_t-in-ppc-and-radeon	2005-04-12 03:21:31.445356480 -0700
+++ 25-akpm/arch/ppc64/kernel/of_device.c	2005-04-12 03:21:31.457354656 -0700
@@ -104,7 +104,7 @@ static int of_device_remove(struct devic
 	return 0;
 }
 
-static int of_device_suspend(struct device *dev, u32 state)
+static int of_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
diff -puN drivers/video/aty/aty128fb.c~u32-vs-pm_message_t-in-ppc-and-radeon drivers/video/aty/aty128fb.c
diff -puN drivers/video/aty/atyfb_base.c~u32-vs-pm_message_t-in-ppc-and-radeon drivers/video/aty/atyfb_base.c
diff -puN drivers/video/aty/radeonfb.h~u32-vs-pm_message_t-in-ppc-and-radeon drivers/video/aty/radeonfb.h
diff -puN include/asm-ppc/macio.h~u32-vs-pm_message_t-in-ppc-and-radeon include/asm-ppc/macio.h
--- 25/include/asm-ppc/macio.h~u32-vs-pm_message_t-in-ppc-and-radeon	2005-04-12 03:21:31.451355568 -0700
+++ 25-akpm/include/asm-ppc/macio.h	2005-04-12 03:21:31.457354656 -0700
@@ -126,7 +126,7 @@ struct macio_driver
 	int	(*probe)(struct macio_dev* dev, const struct of_match *match);
 	int	(*remove)(struct macio_dev* dev);
 
-	int	(*suspend)(struct macio_dev* dev, u32 state);
+	int	(*suspend)(struct macio_dev* dev, pm_message_t state);
 	int	(*resume)(struct macio_dev* dev);
 	int	(*shutdown)(struct macio_dev* dev);
 
diff -puN include/asm-ppc/ocp.h~u32-vs-pm_message_t-in-ppc-and-radeon include/asm-ppc/ocp.h
--- 25/include/asm-ppc/ocp.h~u32-vs-pm_message_t-in-ppc-and-radeon	2005-04-12 03:21:31.453355264 -0700
+++ 25-akpm/include/asm-ppc/ocp.h	2005-04-12 03:21:31.458354504 -0700
@@ -119,7 +119,7 @@ struct ocp_driver {
 	const struct ocp_device_id *id_table;	/* NULL if wants all devices */
 	int  (*probe)  (struct ocp_device *dev);	/* New device inserted */
 	void (*remove) (struct ocp_device *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct ocp_device *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct ocp_device *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct ocp_device *dev);	                /* Device woken up */
 	struct device_driver driver;
 };
diff -puN include/asm-ppc/of_device.h~u32-vs-pm_message_t-in-ppc-and-radeon include/asm-ppc/of_device.h
--- 25/include/asm-ppc/of_device.h~u32-vs-pm_message_t-in-ppc-and-radeon	2005-04-12 03:21:31.454355112 -0700
+++ 25-akpm/include/asm-ppc/of_device.h	2005-04-12 03:21:31.458354504 -0700
@@ -55,7 +55,7 @@ struct of_platform_driver
 	int	(*probe)(struct of_device* dev, const struct of_match *match);
 	int	(*remove)(struct of_device* dev);
 
-	int	(*suspend)(struct of_device* dev, u32 state);
+	int	(*suspend)(struct of_device* dev, pm_message_t state);
 	int	(*resume)(struct of_device* dev);
 	int	(*shutdown)(struct of_device* dev);
 
_
