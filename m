Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUFVT1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUFVT1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUFVSJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:09:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:28853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265051AbUFVRnR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:17 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261123869@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:52 -0700
Message-Id: <1087926112482@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.22, 2004/06/10 09:36:26-07:00, greg@kroah.com

Driver Core: more whitespace fixups

This catches the files I had to do by hand as Dmitry's patch differed from my tree.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c   |  129 +++++++++++++++++++++++++--------------------------
 drivers/base/class.c |   36 +++++++-------
 2 files changed, 82 insertions(+), 83 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Tue Jun 22 09:47:09 2004
+++ b/drivers/base/bus.c	Tue Jun 22 09:47:09 2004
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -17,17 +17,17 @@
 #include "base.h"
 #include "power/power.h"
 
-#define to_dev(node) container_of(node,struct device,bus_list)
-#define to_drv(node) container_of(node,struct device_driver,kobj.entry)
+#define to_dev(node) container_of(node, struct device, bus_list)
+#define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
-#define to_bus_attr(_attr) container_of(_attr,struct bus_attribute,attr)
-#define to_bus(obj) container_of(obj,struct bus_type,subsys.kset.kobj)
+#define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
+#define to_bus(obj) container_of(obj, struct bus_type, subsys.kset.kobj)
 
 /*
  * sysfs bindings for drivers
  */
 
-#define to_drv_attr(_attr) container_of(_attr,struct driver_attribute,attr)
+#define to_drv_attr(_attr) container_of(_attr, struct driver_attribute, attr)
 #define to_driver(obj) container_of(obj, struct device_driver, kobj)
 
 
@@ -39,12 +39,12 @@
 	ssize_t ret = 0;
 
 	if (drv_attr->show)
-		ret = drv_attr->show(drv,buf);
+		ret = drv_attr->show(drv, buf);
 	return ret;
 }
 
 static ssize_t
-drv_attr_store(struct kobject * kobj, struct attribute * attr, 
+drv_attr_store(struct kobject * kobj, struct attribute * attr,
 	       const char * buf, size_t count)
 {
 	struct driver_attribute * drv_attr = to_drv_attr(attr);
@@ -52,7 +52,7 @@
 	ssize_t ret = 0;
 
 	if (drv_attr->store)
-		ret = drv_attr->store(drv,buf,count);
+		ret = drv_attr->store(drv, buf, count);
 	return ret;
 }
 
@@ -87,12 +87,12 @@
 	ssize_t ret = 0;
 
 	if (bus_attr->show)
-		ret = bus_attr->show(bus,buf);
+		ret = bus_attr->show(bus, buf);
 	return ret;
 }
 
 static ssize_t
-bus_attr_store(struct kobject * kobj, struct attribute * attr, 
+bus_attr_store(struct kobject * kobj, struct attribute * attr,
 	       const char * buf, size_t count)
 {
 	struct bus_attribute * bus_attr = to_bus_attr(attr);
@@ -100,7 +100,7 @@
 	ssize_t ret = 0;
 
 	if (bus_attr->store)
-		ret = bus_attr->store(bus,buf,count);
+		ret = bus_attr->store(bus, buf, count);
 	return ret;
 }
 
@@ -113,7 +113,7 @@
 {
 	int error;
 	if (get_bus(bus)) {
-		error = sysfs_create_file(&bus->subsys.kset.kobj,&attr->attr);
+		error = sysfs_create_file(&bus->subsys.kset.kobj, &attr->attr);
 		put_bus(bus);
 	} else
 		error = -EINVAL;
@@ -123,7 +123,7 @@
 void bus_remove_file(struct bus_type * bus, struct bus_attribute * attr)
 {
 	if (get_bus(bus)) {
-		sysfs_remove_file(&bus->subsys.kset.kobj,&attr->attr);
+		sysfs_remove_file(&bus->subsys.kset.kobj, &attr->attr);
 		put_bus(bus);
 	}
 }
@@ -133,7 +133,7 @@
 
 };
 
-decl_subsys(bus,&ktype_bus,NULL);
+decl_subsys(bus, &ktype_bus, NULL);
 
 /**
  *	bus_for_each_dev - device iterator.
@@ -151,10 +151,10 @@
  *
  *	NOTE: The device that returns a non-zero value is not retained
  *	in any way, nor is its refcount incremented. If the caller needs
- *	to retain this data, it should do, and increment the reference 
+ *	to retain this data, it should do, and increment the reference
  *	count in the supplied callback.
  */
-int bus_for_each_dev(struct bus_type * bus, struct device * start, 
+int bus_for_each_dev(struct bus_type * bus, struct device * start,
 		     void * data, int (*fn)(struct device *, void *))
 {
 	struct device *dev;
@@ -170,7 +170,7 @@
 	down_read(&bus->subsys.rwsem);
 	list_for_each_entry_continue(dev, head, bus_list) {
 		get_device(dev);
-		error = fn(dev,data);
+		error = fn(dev, data);
 		put_device(dev);
 		if (error)
 			break;
@@ -193,7 +193,7 @@
  *	and return it. If @start is not NULL, we use it as the head
  *	of the list.
  *
- *	NOTE: we don't return the driver that returns a non-zero 
+ *	NOTE: we don't return the driver that returns a non-zero
  *	value, nor do we leave the reference count incremented for that
  *	driver. If the caller needs to know that info, it must set it
  *	in the callback. It must also be sure to increment the refcount
@@ -216,7 +216,7 @@
 	down_read(&bus->subsys.rwsem);
 	list_for_each_entry_continue(drv, head, kobj.entry) {
 		get_driver(drv);
-		error = fn(drv,data);
+		error = fn(drv, data);
 		put_driver(drv);
 		if(error)
 			break;
@@ -233,8 +233,8 @@
  *	Allow manual attachment of a driver to a deivce.
  *	Caller must have already set @dev->driver.
  *
- *	Note that this does not modify the bus reference count 
- *	nor take the bus's rwsem. Please verify those are accounted 
+ *	Note that this does not modify the bus reference count
+ *	nor take the bus's rwsem. Please verify those are accounted
  *	for before calling this. (It is ok to call with no other effort
  *	from a driver's probe() method.)
  */
@@ -242,9 +242,9 @@
 void device_bind_driver(struct device * dev)
 {
 	pr_debug("bound device '%s' to driver '%s'\n",
-		 dev->bus_id,dev->driver->name);
-	list_add_tail(&dev->driver_list,&dev->driver->devices);
-	sysfs_create_link(&dev->driver->kobj,&dev->kobj,
+		 dev->bus_id, dev->driver->name);
+	list_add_tail(&dev->driver_list, &dev->driver->devices);
+	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 }
 
@@ -255,18 +255,18 @@
  *	@drv:	driver.
  *
  *	First, we call the bus's match function, which should compare
- *	the device IDs the driver supports with the device IDs of the 
- *	device. Note we don't do this ourselves because we don't know 
+ *	the device IDs the driver supports with the device IDs of the
+ *	device. Note we don't do this ourselves because we don't know
  *	the format of the ID structures, nor what is to be considered
  *	a match and what is not.
- *	
- *	If we find a match, we call @drv->probe(@dev) if it exists, and 
+ *
+ *	If we find a match, we call @drv->probe(@dev) if it exists, and
  *	call attach() above.
  */
 static int bus_match(struct device * dev, struct device_driver * drv)
 {
 	int error = -ENODEV;
-	if (dev->bus->match(dev,drv)) {
+	if (dev->bus->match(dev, drv)) {
 		dev->driver = drv;
 		if (drv->probe) {
 			if ((error = drv->probe(dev))) {
@@ -285,7 +285,7 @@
  *	device_attach - try to attach device to a driver.
  *	@dev:	device.
  *
- *	Walk the list of drivers that the bus has and call bus_match() 
+ *	Walk the list of drivers that the bus has and call bus_match()
  *	for each pair. If a compatible pair is found, break out and return.
  */
 static int device_attach(struct device * dev)
@@ -300,15 +300,15 @@
 	}
 
 	if (bus->match) {
-		list_for_each(entry,&bus->drivers.list) {
+		list_for_each(entry, &bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
-			error = bus_match(dev,drv);
-			if (!error )  
+			error = bus_match(dev, drv);
+			if (!error)
 				/* success, driver matched */
-				return 1; 
-			if (error != -ENODEV) 
+				return 1;
+			if (error != -ENODEV)
 				/* driver matched but the probe failed */
-				printk(KERN_WARNING 
+				printk(KERN_WARNING
 				    "%s: probe of %s failed with error %d\n",
 				    drv->name, dev->bus_id, error);
 		}
@@ -327,7 +327,7 @@
  *	If bus_match() returns 0 and the @dev->driver is set, we've found
  *	a compatible pair.
  *
- *	Note that we ignore the -ENODEV error from bus_match(), since it's 
+ *	Note that we ignore the -ENODEV error from bus_match(), since it's
  *	perfectly valid for a driver not to bind to any devices.
  */
 void driver_attach(struct device_driver * drv)
@@ -339,13 +339,13 @@
 	if (!bus->match)
 		return;
 
-	list_for_each(entry,&bus->devices.list) {
-		struct device * dev = container_of(entry,struct device,bus_list);
+	list_for_each(entry, &bus->devices.list) {
+		struct device * dev = container_of(entry, struct device, bus_list);
 		if (!dev->driver) {
-			error = bus_match(dev,drv);
+			error = bus_match(dev, drv);
 			if (error && (error != -ENODEV))
 				/* driver matched but the probe failed */
-				printk(KERN_WARNING 
+				printk(KERN_WARNING
 				    "%s: probe of %s failed with error %d\n",
 				    drv->name, dev->bus_id, error);
 		}
@@ -367,7 +367,7 @@
 {
 	struct device_driver * drv = dev->driver;
 	if (drv) {
-		sysfs_remove_link(&drv->kobj,kobject_name(&dev->kobj));
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		list_del_init(&dev->driver_list);
 		device_detach_shutdown(dev);
 		if (drv->remove)
@@ -385,11 +385,10 @@
 static void driver_detach(struct device_driver * drv)
 {
 	struct list_head * entry, * next;
-	list_for_each_safe(entry,next,&drv->devices) {
-		struct device * dev = container_of(entry,struct device,driver_list);
+	list_for_each_safe(entry, next, &drv->devices) {
+		struct device * dev = container_of(entry, struct device, driver_list);
 		device_release_driver(dev);
 	}
-	
 }
 
 static int device_add_attrs(struct bus_type * bus, struct device * dev)
@@ -439,12 +438,12 @@
 
 	if (bus) {
 		down_write(&dev->bus->subsys.rwsem);
-		pr_debug("bus %s: add device %s\n",bus->name,dev->bus_id);
-		list_add_tail(&dev->bus_list,&dev->bus->devices.list);
+		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
+		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
-		device_add_attrs(bus,dev);
-		sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);
+		device_add_attrs(bus, dev);
+		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 	}
 	return error;
 }
@@ -461,10 +460,10 @@
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
-		sysfs_remove_link(&dev->bus->devices.kobj,dev->bus_id);
-		device_remove_attrs(dev->bus,dev);
+		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
+		device_remove_attrs(dev->bus, dev);
 		down_write(&dev->bus->subsys.rwsem);
-		pr_debug("bus %s: remove device %s\n",dev->bus->name,dev->bus_id);
+		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		list_del_init(&dev->bus_list);
 		up_write(&dev->bus->subsys.rwsem);
@@ -484,8 +483,8 @@
 	int error = 0;
 
 	if (bus) {
-		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
-		error = kobject_set_name(&drv->kobj,drv->name);
+		pr_debug("bus %s: add driver %s\n", bus->name, drv->name);
+		error = kobject_set_name(&drv->kobj, drv->name);
 		if (error) {
 			put_bus(bus);
 			return error;
@@ -518,7 +517,7 @@
 {
 	if (drv->bus) {
 		down_write(&drv->bus->subsys.rwsem);
-		pr_debug("bus %s: remove driver %s\n",drv->bus->name,drv->name);
+		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
 		up_write(&drv->bus->subsys.rwsem);
 		kobject_unregister(&drv->kobj);
@@ -560,7 +559,7 @@
 
 struct bus_type * get_bus(struct bus_type * bus)
 {
-	return bus ? container_of(subsys_get(&bus->subsys),struct bus_type,subsys) : NULL;
+	return bus ? container_of(subsys_get(&bus->subsys), struct bus_type, subsys) : NULL;
 }
 
 void put_bus(struct bus_type * bus)
@@ -579,7 +578,7 @@
 
 struct bus_type * find_bus(char * name)
 {
-	struct kobject * k = kset_find_obj(&bus_subsys.kset,name);
+	struct kobject * k = kset_find_obj(&bus_subsys.kset, name);
 	return k ? to_bus(k) : NULL;
 }
 
@@ -624,19 +623,19 @@
  *
  *	Once we have that, we registered the bus with the kobject
  *	infrastructure, then register the children subsystems it has:
- *	the devices and drivers that belong to the bus. 
+ *	the devices and drivers that belong to the bus.
  */
 int bus_register(struct bus_type * bus)
 {
 	int retval;
 
-	retval = kobject_set_name(&bus->subsys.kset.kobj,bus->name);
+	retval = kobject_set_name(&bus->subsys.kset.kobj, bus->name);
 	if (retval)
 		goto out;
 
-	subsys_set_kset(bus,bus_subsys);
+	subsys_set_kset(bus, bus_subsys);
 	retval = subsystem_register(&bus->subsys);
-	if (retval) 
+	if (retval)
 		goto out;
 
 	kobject_set_name(&bus->devices.kobj, "devices");
@@ -653,7 +652,7 @@
 		goto bus_drivers_fail;
 	bus_add_attrs(bus);
 
-	pr_debug("bus type '%s' registered\n",bus->name);
+	pr_debug("bus type '%s' registered\n", bus->name);
 	return 0;
 
 bus_drivers_fail:
@@ -666,7 +665,7 @@
 
 
 /**
- *	bus_unregister - remove a bus from the system 
+ *	bus_unregister - remove a bus from the system
  *	@bus:	bus.
  *
  *	Unregister the child subsystems and the bus itself.
@@ -674,7 +673,7 @@
  */
 void bus_unregister(struct bus_type * bus)
 {
-	pr_debug("bus %s: unregistering\n",bus->name);
+	pr_debug("bus %s: unregistering\n", bus->name);
 	bus_remove_attrs(bus);
 	kset_unregister(&bus->drivers);
 	kset_unregister(&bus->devices);
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Tue Jun 22 09:47:09 2004
+++ b/drivers/base/class.c	Tue Jun 22 09:47:09 2004
@@ -5,7 +5,7 @@
  * Copyright (c) 2002-3 Open Source Development Labs
  * Copyright (c) 2003-2004 Greg Kroah-Hartman
  * Copyright (c) 2003-2004 IBM Corp.
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -17,8 +17,8 @@
 #include <linux/string.h>
 #include "base.h"
 
-#define to_class_attr(_attr) container_of(_attr,struct class_attribute,attr)
-#define to_class(obj) container_of(obj,struct class,subsys.kset.kobj)
+#define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
+#define to_class(obj) container_of(obj, struct class, subsys.kset.kobj)
 
 static ssize_t
 class_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
@@ -28,12 +28,12 @@
 	ssize_t ret = 0;
 
 	if (class_attr->show)
-		ret = class_attr->show(dc,buf);
+		ret = class_attr->show(dc, buf);
 	return ret;
 }
 
 static ssize_t
-class_attr_store(struct kobject * kobj, struct attribute * attr, 
+class_attr_store(struct kobject * kobj, struct attribute * attr,
 		 const char * buf, size_t count)
 {
 	struct class_attribute * class_attr = to_class_attr(attr);
@@ -41,7 +41,7 @@
 	ssize_t ret = 0;
 
 	if (class_attr->store)
-		ret = class_attr->store(dc,buf,count);
+		ret = class_attr->store(dc, buf, count);
 	return ret;
 }
 
@@ -69,14 +69,14 @@
 };
 
 /* Hotplug events for classes go to the class_obj subsys */
-static decl_subsys(class,&ktype_class,NULL);
+static decl_subsys(class, &ktype_class, NULL);
 
 
 int class_create_file(struct class * cls, const struct class_attribute * attr)
 {
 	int error;
 	if (cls) {
-		error = sysfs_create_file(&cls->subsys.kset.kobj,&attr->attr);
+		error = sysfs_create_file(&cls->subsys.kset.kobj, &attr->attr);
 	} else
 		error = -EINVAL;
 	return error;
@@ -85,13 +85,13 @@
 void class_remove_file(struct class * cls, const struct class_attribute * attr)
 {
 	if (cls)
-		sysfs_remove_file(&cls->subsys.kset.kobj,&attr->attr);
+		sysfs_remove_file(&cls->subsys.kset.kobj, &attr->attr);
 }
 
 struct class * class_get(struct class * cls)
 {
 	if (cls)
-		return container_of(subsys_get(&cls->subsys),struct class,subsys);
+		return container_of(subsys_get(&cls->subsys), struct class, subsys);
 	return NULL;
 }
 
@@ -135,15 +135,15 @@
 {
 	int error;
 
-	pr_debug("device class '%s': registering\n",cls->name);
+	pr_debug("device class '%s': registering\n", cls->name);
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	error = kobject_set_name(&cls->subsys.kset.kobj,cls->name);
+	error = kobject_set_name(&cls->subsys.kset.kobj, cls->name);
 	if (error)
 		return error;
 
-	subsys_set_kset(cls,class_subsys);
+	subsys_set_kset(cls, class_subsys);
 
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
@@ -155,7 +155,7 @@
 
 void class_unregister(struct class * cls)
 {
-	pr_debug("device class '%s': unregistering\n",cls->name);
+	pr_debug("device class '%s': unregistering\n", cls->name);
 	remove_class_attrs(cls);
 	subsystem_unregister(&cls->subsys);
 }
@@ -215,12 +215,12 @@
 	ssize_t ret = 0;
 
 	if (class_dev_attr->show)
-		ret = class_dev_attr->show(cd,buf);
+		ret = class_dev_attr->show(cd, buf);
 	return ret;
 }
 
 static ssize_t
-class_device_attr_store(struct kobject * kobj, struct attribute * attr, 
+class_device_attr_store(struct kobject * kobj, struct attribute * attr,
 			const char * buf, size_t count)
 {
 	struct class_device_attribute * class_dev_attr = to_class_dev_attr(attr);
@@ -228,7 +228,7 @@
 	ssize_t ret = 0;
 
 	if (class_dev_attr->store)
-		ret = class_dev_attr->store(cd,buf,count);
+		ret = class_dev_attr->store(cd, buf, count);
 	return ret;
 }
 
@@ -242,7 +242,7 @@
 	struct class_device *cd = to_class_dev(kobj);
 	struct class * cls = cd->class;
 
-	pr_debug("device class '%s': release.\n",cd->class_id);
+	pr_debug("device class '%s': release.\n", cd->class_id);
 
 	if (cls->release)
 		cls->release(cd);

