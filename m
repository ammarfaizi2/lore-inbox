Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWAEOlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWAEOlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAEOlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:41:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45583 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751368AbWAEOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:40:33 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 21/29] Add mmc_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:40:27 +0000
Message-ID: <20060105142951.13.21@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/mmc/mmc_sysfs.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/mmc/mmc_sysfs.c linux/drivers/mmc/mmc_sysfs.c
--- linus/drivers/mmc/mmc_sysfs.c	Sun Nov  6 22:16:40 2005
+++ linux/drivers/mmc/mmc_sysfs.c	Sun Nov 13 16:32:05 2005
@@ -136,17 +136,7 @@ static int mmc_bus_resume(struct device 
 	return ret;
 }
 
-static struct bus_type mmc_bus_type = {
-	.name		= "mmc",
-	.dev_attrs	= mmc_dev_attrs,
-	.match		= mmc_bus_match,
-	.hotplug	= mmc_bus_hotplug,
-	.suspend	= mmc_bus_suspend,
-	.resume		= mmc_bus_resume,
-};
-
-
-static int mmc_drv_probe(struct device *dev)
+static int mmc_bus_probe(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = dev_to_mmc_card(dev);
@@ -154,7 +144,7 @@ static int mmc_drv_probe(struct device *
 	return drv->probe(card);
 }
 
-static int mmc_drv_remove(struct device *dev)
+static int mmc_bus_remove(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = dev_to_mmc_card(dev);
@@ -164,6 +154,16 @@ static int mmc_drv_remove(struct device 
 	return 0;
 }
 
+static struct bus_type mmc_bus_type = {
+	.name		= "mmc",
+	.dev_attrs	= mmc_dev_attrs,
+	.match		= mmc_bus_match,
+	.hotplug	= mmc_bus_hotplug,
+	.probe		= mmc_bus_probe,
+	.remove		= mmc_bus_remove,
+	.suspend	= mmc_bus_suspend,
+	.resume		= mmc_bus_resume,
+};
 
 /**
  *	mmc_register_driver - register a media driver
@@ -172,8 +172,6 @@ static int mmc_drv_remove(struct device 
 int mmc_register_driver(struct mmc_driver *drv)
 {
 	drv->drv.bus = &mmc_bus_type;
-	drv->drv.probe = mmc_drv_probe;
-	drv->drv.remove = mmc_drv_remove;
 	return driver_register(&drv->drv);
 }
 
