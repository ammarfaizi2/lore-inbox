Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWAEOgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWAEOgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAEOgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:36:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57616 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751316AbWAEOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:35:52 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, SH <linux-sh@m17n.org>
Subject: [CFT 12/29] Add sh_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:35:42 +0000
Message-ID: <20060105142951.13.12@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/sh/kernel/cpu/bus.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/sh/kernel/cpu/bus.c linux/arch/sh/kernel/cpu/bus.c
--- linus/arch/sh/kernel/cpu/bus.c	Sun Nov  6 22:14:58 2005
+++ linux/arch/sh/kernel/cpu/bus.c	Sun Nov 13 16:11:45 2005
@@ -53,21 +53,6 @@ static int sh_bus_resume(struct device *
 	return 0;
 }
 
-static struct device sh_bus_devices[SH_NR_BUSES] = {
-	{
-		.bus_id		= SH_BUS_NAME_VIRT,
-	},
-};
-
-struct bus_type sh_bus_types[SH_NR_BUSES] = {
-	{
-		.name		= SH_BUS_NAME_VIRT,
-		.match		= sh_bus_match,
-		.suspend	= sh_bus_suspend,
-		.resume		= sh_bus_resume,
-	},
-};
-
 static int sh_device_probe(struct device *dev)
 {
 	struct sh_dev *shdev = to_sh_dev(dev);
@@ -90,6 +75,23 @@ static int sh_device_remove(struct devic
 	return 0;
 }
 
+static struct device sh_bus_devices[SH_NR_BUSES] = {
+	{
+		.bus_id		= SH_BUS_NAME_VIRT,
+	},
+};
+
+struct bus_type sh_bus_types[SH_NR_BUSES] = {
+	{
+		.name		= SH_BUS_NAME_VIRT,
+		.match		= sh_bus_match,
+		.probe		= sh_bus_probe,
+		.remove		= sh_bus_remove,
+		.suspend	= sh_bus_suspend,
+		.resume		= sh_bus_resume,
+	},
+};
+
 int sh_device_register(struct sh_dev *dev)
 {
 	if (!dev)
@@ -133,8 +135,6 @@ int sh_driver_register(struct sh_driver 
 		return -EINVAL;
 	}
 
-	drv->drv.probe  = sh_device_probe;
-	drv->drv.remove = sh_device_remove;
 	drv->drv.bus    = &sh_bus_types[drv->bus_id];
 
 	return driver_register(&drv->drv);
