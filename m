Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030826AbWJDLsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030826AbWJDLsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030829AbWJDLsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:48:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:29833 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030826AbWJDLsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:48:05 -0400
Date: Wed, 4 Oct 2006 07:48:03 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/base/bus: remove indentation level
Message-ID: <20061004114803.GA21740@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Before potentially fixing up these functions, this cosmetic change
reduces the indentation level to make the code easier to read and
maintain.

No functional changes at all.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/base/bus.c |   77 +++++++++++++++++++++++++++--------------------------
 1 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 12173d1..b1069c7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -505,34 +505,36 @@ int bus_add_driver(struct device_driver 
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
@@ -552,16 +554,17 @@ out_put_bus:
 
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
 
 
