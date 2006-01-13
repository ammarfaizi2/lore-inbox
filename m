Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWAMTvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWAMTvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbWAMTvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:2453 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422897AbWAMTuh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:37 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add mmc_bus_type probe and remove methods
In-Reply-To: <1137181811158@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:11 -0800
Message-Id: <11371818113200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add mmc_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4d0b653cdfde193944784c01fa3359b0a444dcf1
tree d3f359a72bd4df788277c2bf518809ff184be058
parent 413b486e18587fd53c9954252e6648f9450c734e
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:40:27 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:08 -0800

 drivers/mmc/mmc_sysfs.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index ec70166..a2a35fd 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -136,17 +136,7 @@ static int mmc_bus_resume(struct device 
 	return ret;
 }
 
-static struct bus_type mmc_bus_type = {
-	.name		= "mmc",
-	.dev_attrs	= mmc_dev_attrs,
-	.match		= mmc_bus_match,
-	.uevent		= mmc_bus_uevent,
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
+	.uevent		= mmc_bus_uevent,
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
 

