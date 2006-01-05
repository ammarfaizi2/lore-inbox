Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWAEOjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWAEOjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAEOjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:39:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44303 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751277AbWAEOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:39:30 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, MAC <linuxppc-dev@ozlabs.org>
Subject: [CFT 19/29] Add macio_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:39:24 +0000
Message-ID: <20060105142951.13.19@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/macintosh/macio_asic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/macintosh/macio_asic.c linux/drivers/macintosh/macio_asic.c
--- linus/drivers/macintosh/macio_asic.c	Sun Nov  6 22:16:28 2005
+++ linux/drivers/macintosh/macio_asic.c	Sun Nov 13 16:28:39 2005
@@ -204,6 +204,9 @@ struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
        .hotplug = macio_hotplug,
+       .probe	= macio_device_probe,
+       .remove	= macio_device_remove,
+       .shutdown = macio_device_shutdown,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
        .dev_attrs = macio_dev_attrs,
@@ -487,9 +490,6 @@ int macio_register_driver(struct macio_d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &macio_bus_type;
-	drv->driver.probe = macio_device_probe;
-	drv->driver.remove = macio_device_remove;
-	drv->driver.shutdown = macio_device_shutdown;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
