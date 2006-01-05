Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWAEOmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWAEOmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAEOmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:42:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23052 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751388AbWAEOmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:42:16 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, S390 <linux-390@vm.marist.edu>
Subject: [CFT 24/29] Add ccwgroup_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:42:09 +0000
Message-ID: <20060105142951.13.24@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/s390/cio/ccwgroup.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/s390/cio/ccwgroup.c linux/drivers/s390/cio/ccwgroup.c
--- linus/drivers/s390/cio/ccwgroup.c	Mon Nov  7 19:57:56 2005
+++ linux/drivers/s390/cio/ccwgroup.c	Sun Nov 13 16:35:57 2005
@@ -52,11 +52,7 @@ ccwgroup_hotplug (struct device *dev, ch
 	return 0;
 }
 
-static struct bus_type ccwgroup_bus_type = {
-	.name    = "ccwgroup",
-	.match   = ccwgroup_bus_match,
-	.hotplug = ccwgroup_hotplug,
-};
+static struct bus_type ccwgroup_bus_type;
 
 static inline void
 __ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
@@ -389,6 +385,14 @@ ccwgroup_remove (struct device *dev)
 	return 0;
 }
 
+static struct bus_type ccwgroup_bus_type = {
+	.name    = "ccwgroup",
+	.match   = ccwgroup_bus_match,
+	.hotplug = ccwgroup_hotplug,
+	.probe   = ccwgroup_probe,
+	.remove  = ccwgroup_remove,
+};
+
 int
 ccwgroup_driver_register (struct ccwgroup_driver *cdriver)
 {
@@ -396,8 +400,6 @@ ccwgroup_driver_register (struct ccwgrou
 	cdriver->driver = (struct device_driver) {
 		.bus = &ccwgroup_bus_type,
 		.name = cdriver->name,
-		.probe = ccwgroup_probe,
-		.remove = ccwgroup_remove,
 	};
 
 	return driver_register(&cdriver->driver);
