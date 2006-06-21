Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWFUTxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWFUTxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWFUTuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:07 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16538 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030248AbWFUTtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:40 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/22] [PATCH] Driver Core: remove unused exports
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:53 -0700
Message-Id: <11509191951525-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1150919192294-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Cc: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/attribute_container.c |    8 --------
 drivers/base/base.h                |    2 ++
 drivers/base/bus.c                 |    6 ------
 drivers/base/class.c               |    6 ++----
 include/linux/device.h             |    8 --------
 5 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index 2a7d7ae..2222073 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -236,7 +236,6 @@ attribute_container_remove_device(struct
 	}
 	up(&attribute_container_mutex);
 }
-EXPORT_SYMBOL_GPL(attribute_container_remove_device);
 
 /**
  * attribute_container_device_trigger - execute a trigger for each matching classdev
@@ -276,7 +275,6 @@ attribute_container_device_trigger(struc
 	}
 	up(&attribute_container_mutex);
 }
-EXPORT_SYMBOL_GPL(attribute_container_device_trigger);
 
 /**
  * attribute_container_trigger - trigger a function for each matching container
@@ -304,7 +302,6 @@ attribute_container_trigger(struct devic
 	}
 	up(&attribute_container_mutex);
 }
-EXPORT_SYMBOL_GPL(attribute_container_trigger);
 
 /**
  * attribute_container_add_attrs - add attributes
@@ -333,7 +330,6 @@ attribute_container_add_attrs(struct cla
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(attribute_container_add_attrs);
 
 /**
  * attribute_container_add_class_device - same function as class_device_add
@@ -352,7 +348,6 @@ attribute_container_add_class_device(str
 		return error;
 	return attribute_container_add_attrs(classdev);
 }
-EXPORT_SYMBOL_GPL(attribute_container_add_class_device);
 
 /**
  * attribute_container_add_class_device_adapter - simple adapter for triggers
@@ -367,7 +362,6 @@ attribute_container_add_class_device_ada
 {
 	return attribute_container_add_class_device(classdev);
 }
-EXPORT_SYMBOL_GPL(attribute_container_add_class_device_adapter);
 
 /**
  * attribute_container_remove_attrs - remove any attribute files
@@ -389,7 +383,6 @@ attribute_container_remove_attrs(struct 
 	for (i = 0; attrs[i]; i++)
 		class_device_remove_file(classdev, attrs[i]);
 }
-EXPORT_SYMBOL_GPL(attribute_container_remove_attrs);
 
 /**
  * attribute_container_class_device_del - equivalent of class_device_del
@@ -405,7 +398,6 @@ attribute_container_class_device_del(str
 	attribute_container_remove_attrs(classdev);
 	class_device_del(classdev);
 }
-EXPORT_SYMBOL_GPL(attribute_container_class_device_del);
 
 /**
  * attribute_container_find_class_device - find the corresponding class_device
diff --git a/drivers/base/base.h b/drivers/base/base.h
index bbbc2ac..122498a 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -13,6 +13,8 @@ extern int attribute_container_init(void
 extern int bus_add_device(struct device * dev);
 extern void bus_attach_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
+extern struct bus_type *get_bus(struct bus_type * bus);
+extern void put_bus(struct bus_type * bus);
 
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index b27a606..64ba901 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -745,15 +745,9 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
 EXPORT_SYMBOL_GPL(bus_find_device);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
-EXPORT_SYMBOL_GPL(bus_add_device);
-EXPORT_SYMBOL_GPL(bus_attach_device);
-EXPORT_SYMBOL_GPL(bus_remove_device);
 EXPORT_SYMBOL_GPL(bus_register);
 EXPORT_SYMBOL_GPL(bus_unregister);
 EXPORT_SYMBOL_GPL(bus_rescan_devices);
-EXPORT_SYMBOL_GPL(get_bus);
-EXPORT_SYMBOL_GPL(put_bus);
-EXPORT_SYMBOL_GPL(find_bus);
 
 EXPORT_SYMBOL_GPL(bus_create_file);
 EXPORT_SYMBOL_GPL(bus_remove_file);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 48ad5df..4b598be 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -91,14 +91,14 @@ void class_remove_file(struct class * cl
 		sysfs_remove_file(&cls->subsys.kset.kobj, &attr->attr);
 }
 
-struct class * class_get(struct class * cls)
+static struct class *class_get(struct class *cls)
 {
 	if (cls)
 		return container_of(subsys_get(&cls->subsys), struct class, subsys);
 	return NULL;
 }
 
-void class_put(struct class * cls)
+static void class_put(struct class * cls)
 {
 	if (cls)
 		subsys_put(&cls->subsys);
@@ -894,8 +894,6 @@ EXPORT_SYMBOL_GPL(class_create_file);
 EXPORT_SYMBOL_GPL(class_remove_file);
 EXPORT_SYMBOL_GPL(class_register);
 EXPORT_SYMBOL_GPL(class_unregister);
-EXPORT_SYMBOL_GPL(class_get);
-EXPORT_SYMBOL_GPL(class_put);
 EXPORT_SYMBOL_GPL(class_create);
 EXPORT_SYMBOL_GPL(class_destroy);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b2e5da2..ade10dd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -60,11 +60,6 @@ extern void bus_unregister(struct bus_ty
 
 extern void bus_rescan_devices(struct bus_type * bus);
 
-extern struct bus_type * get_bus(struct bus_type * bus);
-extern void put_bus(struct bus_type * bus);
-
-extern struct bus_type * find_bus(char * name);
-
 /* iterator helpers for buses */
 
 int bus_for_each_dev(struct bus_type * bus, struct device * start, void * data,
@@ -163,9 +158,6 @@ struct class {
 extern int class_register(struct class *);
 extern void class_unregister(struct class *);
 
-extern struct class * class_get(struct class *);
-extern void class_put(struct class *);
-
 
 struct class_attribute {
 	struct attribute	attr;
-- 
1.4.0

