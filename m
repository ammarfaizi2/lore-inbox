Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWJRULq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWJRULq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422877AbWJRULL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:11:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52202 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422869AbWJRUKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:10:01 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/16] Driver core: bus: remove indentation level
Date: Wed, 18 Oct 2006 13:09:06 -0700
Message-Id: <11612021942412-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021903607-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com> <11612021771048-git-send-email-greg@kroah.com> <11612021801495-git-send-email-greg@kroah.com> <11612021841579-git-send-email-greg@kroah.com> <11612021872574-git-send-email-greg@kroah.com> <11612021903607-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>

Before potentially fixing up these functions, this cosmetic change
reduces the indentation level to make the code easier to read and
maintain.

No functional changes at all.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c |   77 +++++++++++++++++++++++++++-------------------------
 1 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d7c5ea2..7d8a7ce 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -518,34 +518,36 @@ int bus_add_driver(struct device_driver 
 	struct bus_type * bus = get_bus(drv->bus);
 	int error = 0;
 
-	if (bus) {
-		pr_debug("bus %s: add driver %s\n", bus->name, drv->name);
-		error = kobject_set_name(&drv->kobj, "%s", drv->name);
-		if (error)
-			goto out_put_bus;
-		drv->kobj.kset = &bus->drivers;
-		if ((error = kobject_register(&drv->kobj)))
-			goto out_put_bus;
-
-		error = driver_attach(drv);
-		if (error)
-			goto out_unregister;
-		klist_add_tail(&drv->knode_bus, &bus->klist_drivers);
-		module_add_driver(drv->owner, drv);
-
-		error = driver_add_attrs(bus, drv);
-		if (error) {
-			/* How the hell do we get out of this pickle? Give up */
-			printk(KERN_ERR "%s: driver_add_attrs(%s) failed\n",
-				__FUNCTION__, drv->name);
-		}
-		error = add_bind_files(drv);
-		if (error) {
-			/* Ditto */
-			printk(KERN_ERR "%s: add_bind_files(%s) failed\n",
-				__FUNCTION__, drv->name);
-		}
+	if (!bus)
+		return 0;
+
+	pr_debug("bus %s: add driver %s\n", bus->name, drv->name);
+	error = kobject_set_name(&drv->kobj, "%s", drv->name);
+	if (error)
+		goto out_put_bus;
+	drv->kobj.kset = &bus->drivers;
+	if ((error = kobject_register(&drv->kobj)))
+		goto out_put_bus;
+
+	error = driver_attach(drv);
+	if (error)
+		goto out_unregister;
+	klist_add_tail(&drv->knode_bus, &bus->klist_drivers);
+	module_add_driver(drv->owner, drv);
+
+	error = driver_add_attrs(bus, drv);
+	if (error) {
+		/* How the hell do we get out of this pickle? Give up */
+		printk(KERN_ERR "%s: driver_add_attrs(%s) failed\n",
+			__FUNCTION__, drv->name);
+	}
+	error = add_bind_files(drv);
+	if (error) {
+		/* Ditto */
+		printk(KERN_ERR "%s: add_bind_files(%s) failed\n",
+			__FUNCTION__, drv->name);
 	}
+
 	return error;
 out_unregister:
 	kobject_unregister(&drv->kobj);
@@ -565,16 +567,17 @@ out_put_bus:
 
 void bus_remove_driver(struct device_driver * drv)
 {
-	if (drv->bus) {
-		remove_bind_files(drv);
-		driver_remove_attrs(drv->bus, drv);
-		klist_remove(&drv->knode_bus);
-		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
-		driver_detach(drv);
-		module_remove_driver(drv);
-		kobject_unregister(&drv->kobj);
-		put_bus(drv->bus);
-	}
+	if (!drv->bus)
+		return;
+
+	remove_bind_files(drv);
+	driver_remove_attrs(drv->bus, drv);
+	klist_remove(&drv->knode_bus);
+	pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
+	driver_detach(drv);
+	module_remove_driver(drv);
+	kobject_unregister(&drv->kobj);
+	put_bus(drv->bus);
 }
 
 
-- 
1.4.2.4

