Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWAMUA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWAMUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWAMUAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:00:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:46740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422876AbWAMTua convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:30 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add sh_bus_type probe and remove methods
In-Reply-To: <11371818091202@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818102241@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add sh_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c6a09196bab3bc9e515b713193d61e3e87c720f7
tree 17636bb7c0c0d9cb01868a2d9bdbd56df25c0855
parent 91fb53866d00b4eaeaf1cbfd2237799cb152f742
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:35:42 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:06 -0800

 arch/sh/kernel/cpu/bus.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/sh/kernel/cpu/bus.c b/arch/sh/kernel/cpu/bus.c
index d4fee2a..3278d23 100644
--- a/arch/sh/kernel/cpu/bus.c
+++ b/arch/sh/kernel/cpu/bus.c
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

