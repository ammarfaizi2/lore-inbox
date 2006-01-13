Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422877AbWAMTwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422877AbWAMTwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422917AbWAMTv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:58004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422887AbWAMTue convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:34 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add tiocx bus_type probe/remove methods
In-Reply-To: <11371818092544@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:09 -0800
Message-Id: <1137181809687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add tiocx bus_type probe/remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 83dfb8b67522f6cf1fc5771a8be0a9095eea65d4
tree b146d1eaa04b9ff40e0ce755bd041dcae23cccc6
parent 5c0784c350516856ed15deb6adf6b053bf427792
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:34:06 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:05 -0800

 arch/ia64/sn/kernel/tiocx.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/sn/kernel/tiocx.c b/arch/ia64/sn/kernel/tiocx.c
index 493fb3f..6a7939b 100644
--- a/arch/ia64/sn/kernel/tiocx.c
+++ b/arch/ia64/sn/kernel/tiocx.c
@@ -77,12 +77,6 @@ static void tiocx_bus_release(struct dev
 	kfree(to_cx_dev(dev));
 }
 
-struct bus_type tiocx_bus_type = {
-	.name = "tiocx",
-	.match = tiocx_match,
-	.uevent = tiocx_uevent,
-};
-
 /**
  * cx_device_match - Find cx_device in the id table.
  * @ids: id table from driver
@@ -149,6 +143,14 @@ static int cx_driver_remove(struct devic
 	return 0;
 }
 
+struct bus_type tiocx_bus_type = {
+	.name = "tiocx",
+	.match = tiocx_match,
+	.uevent = tiocx_uevent,
+	.probe = cx_device_probe,
+	.remove = cx_driver_remove,
+};
+
 /**
  * cx_driver_register - Register the driver.
  * @cx_driver: driver table (cx_drv struct) from driver
@@ -162,8 +164,6 @@ int cx_driver_register(struct cx_drv *cx
 {
 	cx_driver->driver.name = cx_driver->name;
 	cx_driver->driver.bus = &tiocx_bus_type;
-	cx_driver->driver.probe = cx_device_probe;
-	cx_driver->driver.remove = cx_driver_remove;
 
 	return driver_register(&cx_driver->driver);
 }

