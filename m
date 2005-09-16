Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbVIPHWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbVIPHWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbVIPHWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:22:15 -0400
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:40373 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161102AbVIPHWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:22:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Date: Fri, 16 Sep 2005 02:21:53 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050916002036.GA6149@suse.de> <200509152136.08951.dtor_core@ameritech.net> <20050916024351.GC13486@vrfy.org>
In-Reply-To: <20050916024351.GC13486@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509160221.54587.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > No, like your first picture, except 'interfaces/mice' will be a directory,
> > not a symlink, since it does not have class_device parent. I should have
> > said "Otherwise it gets added into _its_ class directory". 
> 

Ok, this is _very_ raw and I am creating double symlinks somehow, but still
it shows it can be done:

[dtor@core ~]$ tree /sys/class/input/
/sys/class/input/
|-- devices
|   |-- input0
|   |   |-- capabilities
|   |   |   |-- abs
|   |   |   |-- ev
|   |   |   |-- ff
|   |   |   |-- key
|   |   |   |-- led
|   |   |   |-- msc
|   |   |   |-- rel
|   |   |   |-- snd
|   |   |   `-- sw
|   |   |-- device -> ../../../../devices/platform/i8042/serio1
|   |   |-- event0
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input0
|   |   |-- event0
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input0
|   |   |-- id
|   |   |   |-- bustype
|   |   |   |-- product
|   |   |   |-- vendor
|   |   |   `-- version
|   |   |-- name
|   |   |-- phys
|   |   `-- uniq
|   |-- input1
|   |   |-- capabilities
|   |   |   |-- abs
|   |   |   |-- ev
|   |   |   |-- ff
|   |   |   |-- key
|   |   |   |-- led
|   |   |   |-- msc
|   |   |   |-- rel
|   |   |   |-- snd
|   |   |   `-- sw
|   |   |-- device -> ../../../../devices/platform/i8042/serio0
|   |   |-- event1
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input1
|   |   |-- event1
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input1
|   |   |-- id
|   |   |   |-- bustype
|   |   |   |-- product
|   |   |   |-- vendor
|   |   |   `-- version
|   |   |-- mouse0
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input1
|   |   |-- mouse0
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input1
|   |   |-- name
|   |   |-- phys
|   |   |-- ts0
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input1
|   |   |-- ts0
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../class/input/devices/input1
|   |   `-- uniq
|   `-- input2
|       |-- capabilities
|       |   |-- abs
|       |   |-- ev
|       |   |-- ff
|       |   |-- key
|       |   |-- led
|       |   |-- msc
|       |   |-- rel
|       |   |-- snd
|       |   `-- sw
|       |-- device -> ../../../../devices/platform/i8042/serio0/serio2
|       |-- event2
|       |   |-- dev
|       |   `-- device -> ../../../../../class/input/devices/input2
|       |-- event2
|       |   |-- dev
|       |   `-- device -> ../../../../../class/input/devices/input2
|       |-- id
|       |   |-- bustype
|       |   |-- product
|       |   |-- vendor
|       |   `-- version
|       |-- mouse1
|       |   |-- dev
|       |   `-- device -> ../../../../../class/input/devices/input2
|       |-- mouse1
|       |   |-- dev
|       |   `-- device -> ../../../../../class/input/devices/input2
|       |-- name
|       |-- phys
|       |-- ts1
|       |   |-- dev
|       |   `-- device -> ../../../../../class/input/devices/input2
|       |-- ts1
|       |   |-- dev
|       |   `-- device -> ../../../../../class/input/devices/input2
|       `-- uniq
`-- interfaces
    |-- event0 -> ../../../class/input/devices/input0/event0
    |-- event1 -> ../../../class/input/devices/input1/event1
    |-- event2 -> ../../../class/input/devices/input2/event2
    |-- mice
    |   `-- dev
    |-- mouse0 -> ../../../class/input/devices/input1/mouse0
    |-- mouse1 -> ../../../class/input/devices/input2/mouse1
    |-- ts0 -> ../../../class/input/devices/input1/ts0
    `-- ts1 -> ../../../class/input/devices/input2/ts1

-- 
Dmitry

Subject: XXX
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c   |   81 +++++++++++++++++++++++++++++++++++--------------
 drivers/input/input.c  |    6 +++
 include/linux/device.h |    5 ++-
 3 files changed, 67 insertions(+), 25 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -485,7 +485,7 @@ static char *make_class_name(struct clas
 
 int class_device_add(struct class_device *class_dev)
 {
-	struct class * parent = NULL;
+	struct class * class = NULL;
 	struct class_interface * class_intf;
 	char *class_name = NULL;
 	int error;
@@ -499,15 +499,18 @@ int class_device_add(struct class_device
 		goto register_done;
 	}
 
-	parent = class_get(class_dev->class);
+	class = class_get(class_dev->class);
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
 	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
-	if (parent)
-		class_dev->kobj.parent = &parent->subsys.kset.kobj;
+
+	if (is_a_class_device(class_dev->parent))
+		class_dev->kobj.parent = class_dev->parent;
+	else if (class)
+		class_dev->kobj.parent = &class->subsys.kset.kobj;
 
 	if ((error = kobject_add(&class_dev->kobj)))
 		goto register_done;
@@ -524,7 +527,7 @@ int class_device_add(struct class_device
 
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
-		attr->attr.owner = parent->owner;
+		attr->attr.owner = class ? class->owner : NULL;
 		attr->show = show_dev;
 		attr->store = NULL;
 		class_device_create_file(class_dev, attr);
@@ -532,31 +535,45 @@ int class_device_add(struct class_device
 	}
 
 	class_device_add_attrs(class_dev);
+
+	/* this will go away */
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
-		sysfs_create_link(&class_dev->kobj,
-				  &class_dev->dev->kobj, "device");
+		sysfs_create_link(&class_dev->kobj, &class_dev->dev->kobj,
+				  "device");
 		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
 				  class_name);
+		kfree(class_name);
+	} else if (class_dev->parent) {
+		class_name = make_class_name(class_dev);
+		sysfs_create_link(&class_dev->kobj, class_dev->parent,
+				  "device");
+		sysfs_create_link(class_dev->parent, &class_dev->kobj,
+				  is_a_class_device(class_dev->parent) ?
+				  class_dev->class_id : class_name);
+		kfree(class_name);
 	}
 
+	if (class && is_a_class_device(class_dev->parent))
+		sysfs_create_link(&class->subsys.kset.kobj, &class_dev->kobj,
+				  class_dev->class_id);
+
 	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
-	if (parent) {
-		down(&parent->sem);
-		list_add_tail(&class_dev->node, &parent->children);
-		list_for_each_entry(class_intf, &parent->interfaces, node)
+	if (class) {
+		down(&class->sem);
+		list_add_tail(&class_dev->node, &class->children);
+		list_for_each_entry(class_intf, &class->interfaces, node)
 			if (class_intf->add)
 				class_intf->add(class_dev, class_intf);
-		up(&parent->sem);
+		up(&class->sem);
 	}
 
  register_done:
-	if (error && parent)
-		class_put(parent);
+	if (error && class)
+		class_put(class);
 	class_device_put(class_dev);
-	kfree(class_name);
 	return error;
 }
 
@@ -619,34 +636,48 @@ error:
 
 void class_device_del(struct class_device *class_dev)
 {
-	struct class * parent = class_dev->class;
+	struct class * class = class_dev->class;
 	struct class_interface * class_intf;
 	char *class_name = NULL;
 
-	if (parent) {
-		down(&parent->sem);
+	if (class) {
+		down(&class->sem);
 		list_del_init(&class_dev->node);
-		list_for_each_entry(class_intf, &parent->interfaces, node)
+		list_for_each_entry(class_intf, &class->interfaces, node)
 			if (class_intf->remove)
 				class_intf->remove(class_dev, class_intf);
-		up(&parent->sem);
+		up(&class->sem);
+	}
+
+	if (class && is_a_class_device(class_dev->parent))
+		sysfs_remove_link(&class->subsys.kset.kobj, class_dev->class_id);
+
+	if (class_dev->parent) {
+		class_name = make_class_name(class_dev);
+		sysfs_remove_link(&class_dev->kobj, "device");
+		sysfs_remove_link(class_dev->parent,
+				  is_a_class_device(class_dev->parent) ?
+				  class_dev->class_id : class_name);
+		kfree(class_name);
 	}
 
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
 		sysfs_remove_link(&class_dev->kobj, "device");
 		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		kfree(class_name);
 	}
+
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
+
 	class_device_remove_attrs(class_dev);
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
-	if (parent)
-		class_put(parent);
-	kfree(class_name);
+	if (class)
+		class_put(class);
 }
 
 void class_device_unregister(struct class_device *class_dev)
@@ -715,6 +746,10 @@ void class_device_put(struct class_devic
 	kobject_put(&class_dev->kobj);
 }
 
+int is_a_class_device(struct kobject *kobj)
+{
+	return kobj && get_ktype(kobj) == &ktype_class_device;
+}
 
 int class_interface_register(struct class_interface *class_intf)
 {
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -199,7 +199,8 @@ struct class_device {
 	struct class		* class;	/* required */
 	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
 	struct class_device_attribute *devt_attr;
-	struct device		* dev;		/* not necessary, but nice to have */
+	struct device		* dev;		/* not necessary, but nice to have (going away) */
+	struct kobject		* parent;	/* either device or class_device */
 	void			* class_data;	/* class-specific data */
 
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
@@ -229,6 +230,8 @@ extern int class_device_rename(struct cl
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);
 
+extern int is_a_class_device(struct kobject *);
+
 struct class_device_attribute {
 	struct attribute	attr;
 	ssize_t (*show)(struct class_device *, char * buf);
Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -948,18 +948,22 @@ int input_create_interface_device(struct
 
 	dev->devt = devt;
 	dev->class = &input_interface_class;
+	if (handle->dev)
+		dev->parent = &handle->dev->cdev.kobj;
 	strlcpy(dev->class_id, handle->name, BUS_ID_SIZE);
 
+
 	error = class_device_register(dev);
 	if (error)
 		return error;
 
+/*
 	if (handle->dev) {
 		sysfs_create_link(&dev->kobj, &handle->dev->cdev.kobj, "device");
 		sysfs_create_link(&handle->dev->cdev.kobj, &dev->kobj,
 				  kobject_name(&dev->kobj));
 	}
-
+*/
 	handle->intf_dev = dev;
 
 	__module_get(THIS_MODULE);
