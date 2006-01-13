Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422869AbWAMUD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWAMUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422875AbWAMUCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:02:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:43156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422874AbWAMTu3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:29 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add ccwgroup_bus_type probe and remove methods
In-Reply-To: <11371818111878@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:11 -0800
Message-Id: <11371818111724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add ccwgroup_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f9ccf4569ac4597e9e09d301ca362d90b4a1046d
tree 67a3eaf663e26e9b6b6625fbc1114237db28f43c
parent 4681fc320889de4591f945c4fdf08546eb9ab266
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:42:09 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:09 -0800

 drivers/s390/cio/ccwgroup.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index e849289..503a568 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -52,11 +52,7 @@ ccwgroup_uevent (struct device *dev, cha
 	return 0;
 }
 
-static struct bus_type ccwgroup_bus_type = {
-	.name    = "ccwgroup",
-	.match   = ccwgroup_bus_match,
-	.uevent = ccwgroup_uevent,
-};
+static struct bus_type ccwgroup_bus_type;
 
 static inline void
 __ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
@@ -389,6 +385,14 @@ ccwgroup_remove (struct device *dev)
 	return 0;
 }
 
+static struct bus_type ccwgroup_bus_type = {
+	.name   = "ccwgroup",
+	.match  = ccwgroup_bus_match,
+	.uevent = ccwgroup_uevent,
+	.probe  = ccwgroup_probe,
+	.remove = ccwgroup_remove,
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

