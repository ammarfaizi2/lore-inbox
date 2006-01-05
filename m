Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWAEOoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWAEOoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWAEOoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:44:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25868 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751354AbWAEOoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:44:20 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, Matt Porter <mporter@kernel.crashing.org>
Subject: [CFT 28/29] Add rio_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:44:14 +0000
Message-ID: <20060105142951.13.28@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/rapidio/rio-driver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/rapidio/rio-driver.c linux/drivers/rapidio/rio-driver.c
--- linus/drivers/rapidio/rio-driver.c	Mon Nov  7 19:57:55 2005
+++ linux/drivers/rapidio/rio-driver.c	Sun Nov 13 16:42:34 2005
@@ -147,8 +147,6 @@ int rio_register_driver(struct rio_drive
 	/* initialize common driver fields */
 	rdrv->driver.name = rdrv->name;
 	rdrv->driver.bus = &rio_bus_type;
-	rdrv->driver.probe = rio_device_probe;
-	rdrv->driver.remove = rio_device_remove;
 
 	/* register with core */
 	return driver_register(&rdrv->driver);
@@ -204,7 +202,9 @@ static struct device rio_bus = {
 struct bus_type rio_bus_type = {
 	.name = "rapidio",
 	.match = rio_match_bus,
-	.dev_attrs = rio_dev_attrs
+	.dev_attrs = rio_dev_attrs,
+	.probe = rio_device_probe,
+	.remove = rio_device_remove,
 };
 
 /**
