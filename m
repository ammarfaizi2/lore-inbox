Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVFVF0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVFVF0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVFVF0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:26:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:34199 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262747AbVFVFMP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:15 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: cleanups.
In-Reply-To: <11194171261398@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:06 -0700
Message-Id: <11194171264139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: cleanups.

 - white space changes.
 - list_for_each_entry/list_for_each_entry_safe and reverse changes.
 - small coding style changes.
 - removed redundant NULL checks.
 - use attribute group and macros instead of direct device attributes.
Patch is havily based on work from Adrian Bunk and Dmitry Torokhov,
thanks guys.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7785925dd8e0d2f389d4a9168f1683c6b249a552
tree 5772979184dc9e2b811503fab6ed1119f5c9f93a
parent 85e941cc9f10316080a16b121d24d329e5c2a65d
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Fri, 20 May 2005 22:33:25 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:09 -0700

 drivers/w1/Kconfig      |   16 +--
 drivers/w1/matrox_w1.c  |   10 +-
 drivers/w1/w1.c         |  273 +++++++++++++++++------------------------------
 drivers/w1/w1.h         |   43 ++++---
 drivers/w1/w1_family.c  |    4 -
 drivers/w1/w1_family.h  |   10 +-
 drivers/w1/w1_int.c     |   29 ++---
 drivers/w1/w1_int.h     |    6 -
 drivers/w1/w1_io.c      |    4 -
 drivers/w1/w1_io.h      |    4 -
 drivers/w1/w1_log.h     |    4 -
 drivers/w1/w1_netlink.h |    4 -
 drivers/w1/w1_smem.c    |    8 +
 drivers/w1/w1_therm.c   |   12 +-
 14 files changed, 171 insertions(+), 256 deletions(-)

diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -3,9 +3,9 @@ menu "Dallas's 1-wire bus"
 config W1
 	tristate "Dallas's 1-wire support"
 	---help---
-	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
+	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
 	  such as iButtons and thermal sensors.
-	  
+
 	  If you want W1 support, you should say Y here.
 
 	  This W1 support can also be built as a module.  If so, the module
@@ -17,8 +17,8 @@ config W1_MATROX
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using Matrox's G400 GPIO pins.
-	  
-	  This support is also available as a module.  If so, the module 
+
+	  This support is also available as a module.  If so, the module
 	  will be called matrox_w1.ko.
 
 config W1_DS9490
@@ -27,17 +27,17 @@ config W1_DS9490
 	help
 	  Say Y here if you want to have a driver for DS9490R UWB <-> W1 bridge.
 
-	  This support is also available as a module.  If so, the module 
+	  This support is also available as a module.  If so, the module
 	  will be called ds9490r.ko.
 
-config W1_DS9490_BRIDGE
+config W1_DS9490R_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
 	depends on W1_DS9490
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using DS9490R USB bridge.
 
-	  This support is also available as a module.  If so, the module 
+	  This support is also available as a module.  If so, the module
 	  will be called ds_w1_bridge.ko.
 
 config W1_THERM
@@ -51,7 +51,7 @@ config W1_SMEM
 	tristate "Simple 64bit memory family implementation"
 	depends on W1
 	help
-	  Say Y here if you want to connect 1-wire 
+	  Say Y here if you want to connect 1-wire
 	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
 
 endmenu
diff --git a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
--- a/drivers/w1/matrox_w1.c
+++ b/drivers/w1/matrox_w1.c
@@ -1,8 +1,8 @@
 /*
- * 	matrox_w1.c
+ *	matrox_w1.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@ static struct pci_driver matrox_w1_pci_d
 	.remove = __devexit_p(matrox_w1_remove),
 };
 
-/* 
+/*
  * Matrox G400 DDC registers.
  */
 
@@ -177,8 +177,8 @@ static int __devinit matrox_w1_probe(str
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-	/* 
-	 * True for G400, for some other we need resource 0, see drivers/video/matrox/matroxfb_base.c 
+	/*
+	 * True for G400, for some other we need resource 0, see drivers/video/matrox/matroxfb_base.c
 	 */
 
 	dev->phys_addr = pci_resource_start(pdev, 1);
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1,8 +1,8 @@
 /*
- * 	w1.c
+ *	w1.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -99,6 +99,23 @@ static ssize_t w1_default_read_bin(struc
 	return sprintf(buf, "No family registered.\n");
 }
 
+static struct device_attribute w1_slave_attribute =
+	__ATTR(name, S_IRUGO, w1_default_read_name, NULL);
+
+static struct device_attribute w1_slave_attribute_val =
+	__ATTR(value, S_IRUGO, w1_default_read_name, NULL);
+
+static struct bin_attribute w1_slave_bin_attribute = {
+	.attr = {
+		.name = "w1_slave",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = W1_SLAVE_DATA_SIZE,
+	.read = &w1_default_read_bin,
+};
+
+
 static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
@@ -119,34 +136,16 @@ struct device w1_device = {
 	.release = &w1_master_release
 };
 
-static struct device_attribute w1_slave_attribute = {
-	.attr = {
-			.name = "name",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_default_read_name,
-};
-
-static struct device_attribute w1_slave_attribute_val = {
-	.attr = {
-			.name = "value",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_default_read_name,
-};
-
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible (&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%s\n", md->name);
-	
+
 	up(&md->mutex);
 
 	return count;
@@ -156,12 +155,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "0x%p\n", md->bus_master);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -177,12 +176,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%d\n", md->max_slave_count);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -191,12 +190,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%lu\n", md->attempts);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -205,12 +204,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%d\n", md->slave_count);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -233,7 +232,7 @@ static ssize_t w1_master_attribute_show_
 		list_for_each_safe(ent, n, &md->slist) {
 			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
- 			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", sl->name);
+			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", sl->name);
 		}
 	}
 
@@ -242,73 +241,44 @@ static ssize_t w1_master_attribute_show_
 	return PAGE_SIZE - c;
 }
 
-static struct device_attribute w1_master_attribute_slaves = {
-	.attr = {
- 			.name = "w1_master_slaves",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE,
-	},
- 	.show = &w1_master_attribute_show_slaves,
-};
-static struct device_attribute w1_master_attribute_slave_count = {
-	.attr = {
-			.name = "w1_master_slave_count",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_slave_count,
-};
-static struct device_attribute w1_master_attribute_attempts = {
-	.attr = {
-			.name = "w1_master_attempts",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_attempts,
-};
-static struct device_attribute w1_master_attribute_max_slave_count = {
-	.attr = {
-			.name = "w1_master_max_slave_count",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_max_slave_count,
-};
-static struct device_attribute w1_master_attribute_timeout = {
-	.attr = {
-			.name = "w1_master_timeout",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_timeout,
-};
-static struct device_attribute w1_master_attribute_pointer = {
-	.attr = {
-			.name = "w1_master_pointer",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_pointer,
-};
-static struct device_attribute w1_master_attribute_name = {
-	.attr = {
-			.name = "w1_master_name",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_name,
+#define W1_MASTER_ATTR_RO(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =	\
+		__ATTR(w1_master_##_name, _mode,		\
+		       w1_master_attribute_show_##_name, NULL)
+
+static W1_MASTER_ATTR_RO(name, S_IRUGO);
+static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
+static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
+static W1_MASTER_ATTR_RO(max_slave_count, S_IRUGO);
+static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
+static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
+static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
+
+static struct attribute *w1_master_default_attrs[] = {
+	&w1_master_attribute_name.attr,
+	&w1_master_attribute_slaves.attr,
+	&w1_master_attribute_slave_count.attr,
+	&w1_master_attribute_max_slave_count.attr,
+	&w1_master_attribute_attempts.attr,
+	&w1_master_attribute_timeout.attr,
+	&w1_master_attribute_pointer.attr,
+	NULL
 };
 
-static struct bin_attribute w1_slave_bin_attribute = {
-	.attr = {
-		 	.name = "w1_slave",
-		 	.mode = S_IRUGO,
-			.owner = THIS_MODULE,
-	},
-	.size = W1_SLAVE_DATA_SIZE,
-	.read = &w1_default_read_bin,
+static struct attribute_group w1_master_defattr_group = {
+	.attrs = w1_master_default_attrs,
 };
 
+int w1_create_master_attributes(struct w1_master *master)
+{
+	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
+}
+
+void w1_destroy_master_attributes(struct w1_master *master)
+{
+	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
+}
+
 static int __w1_attach_slave_device(struct w1_slave *sl)
 {
 	int err;
@@ -341,7 +311,7 @@ static int __w1_attach_slave_device(stru
 	memcpy(&sl->attr_bin, &w1_slave_bin_attribute, sizeof(sl->attr_bin));
 	memcpy(&sl->attr_name, &w1_slave_attribute, sizeof(sl->attr_name));
 	memcpy(&sl->attr_val, &w1_slave_attribute_val, sizeof(sl->attr_val));
-	
+
 	sl->attr_bin.read = sl->family->fops->rbin;
 	sl->attr_name.show = sl->family->fops->rname;
 	sl->attr_val.show = sl->family->fops->rval;
@@ -445,7 +415,7 @@ static int w1_attach_slave_device(struct
 static void w1_slave_detach(struct w1_slave *sl)
 {
 	struct w1_netlink_msg msg;
-	
+
 	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
 
 	while (atomic_read(&sl->refcnt)) {
@@ -471,8 +441,8 @@ static struct w1_master *w1_search_maste
 {
 	struct w1_master *dev;
 	int found = 0;
-	
-	spin_lock_irq(&w1_mlock);
+
+	spin_lock_bh(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		if (dev->bus_master->data == data) {
 			found = 1;
@@ -480,12 +450,12 @@ static struct w1_master *w1_search_maste
 			break;
 		}
 	}
-	spin_unlock_irq(&w1_mlock);
+	spin_unlock_bh(&w1_mlock);
 
 	return (found)?dev:NULL;
 }
 
-void w1_slave_found(unsigned long data, u64 rn)
+static void w1_slave_found(unsigned long data, u64 rn)
 {
 	int slave_count;
 	struct w1_slave *sl;
@@ -500,7 +470,7 @@ void w1_slave_found(unsigned long data, 
 				data);
 		return;
 	}
-	
+
 	tmp = (struct w1_reg_num *) &rn;
 
 	slave_count = 0;
@@ -513,8 +483,7 @@ void w1_slave_found(unsigned long data, 
 		    sl->reg_num.crc == tmp->crc) {
 			set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 			break;
-		}
-		else if (sl->reg_num.family == tmp->family) {
+		} else if (sl->reg_num.family == tmp->family) {
 			family_found = 1;
 			break;
 		}
@@ -528,7 +497,7 @@ void w1_slave_found(unsigned long data, 
 		rn && ((le64_to_cpu(rn) >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
 		w1_attach_slave_device(dev, tmp);
 	}
-			
+
 	atomic_dec(&dev->refcnt);
 }
 
@@ -545,8 +514,8 @@ void w1_search(struct w1_master *dev)
 
 	desc_bit = 64;
 
-	while (!(id_bit && comp_bit) && !last_device
-		&& count++ < dev->max_slave_count) {
+	while (!(id_bit && comp_bit) && !last_device &&
+	       count++ < dev->max_slave_count) {
 		last = rn;
 		rn = 0;
 
@@ -591,8 +560,7 @@ void w1_search(struct w1_master *dev)
 						last_family_desc = last_zero;
 				}
 
-			}
-			else
+			} else
 				search_bit = id_bit;
 
 			tmp = search_bit;
@@ -615,42 +583,15 @@ void w1_search(struct w1_master *dev)
 			last_device = 1;
 
 		desc_bit = last_zero;
-	
+
 		w1_slave_found(dev->bus_master->data, rn);
 	}
 }
 
-int w1_create_master_attributes(struct w1_master *dev)
+static int w1_control(void *data)
 {
-	if (	device_create_file(&dev->dev, &w1_master_attribute_slaves) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_slave_count) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_attempts) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_max_slave_count) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_timeout) < 0||
-		device_create_file(&dev->dev, &w1_master_attribute_pointer) < 0||
-		device_create_file(&dev->dev, &w1_master_attribute_name) < 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-void w1_destroy_master_attributes(struct w1_master *dev)
-{
-	device_remove_file(&dev->dev, &w1_master_attribute_slaves);
-	device_remove_file(&dev->dev, &w1_master_attribute_slave_count);
-	device_remove_file(&dev->dev, &w1_master_attribute_attempts);
-	device_remove_file(&dev->dev, &w1_master_attribute_max_slave_count);
-	device_remove_file(&dev->dev, &w1_master_attribute_timeout);
-	device_remove_file(&dev->dev, &w1_master_attribute_pointer);
-	device_remove_file(&dev->dev, &w1_master_attribute_name);
-}
-
-
-int w1_control(void *data)
-{
-	struct w1_slave *sl;
-	struct w1_master *dev;
-	struct list_head *ent, *ment, *n, *mn;
+	struct w1_slave *sl, *sln;
+	struct w1_master *dev, *n;
 	int err, have_to_wait = 0;
 
 	daemonize("w1_control");
@@ -665,9 +606,7 @@ int w1_control(void *data)
 		if (signal_pending(current))
 			flush_signals(current);
 
-		list_for_each_safe(ment, mn, &w1_masters) {
-			dev = list_entry(ment, struct w1_master, w1_master_entry);
-
+		list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry) {
 			if (!control_needs_exit && !dev->need_exit)
 				continue;
 			/*
@@ -679,9 +618,9 @@ int w1_control(void *data)
 				continue;
 			}
 
-			spin_lock(&w1_mlock);
+			spin_lock_bh(&w1_mlock);
 			list_del(&dev->w1_master_entry);
-			spin_unlock(&w1_mlock);
+			spin_unlock_bh(&w1_mlock);
 
 			if (control_needs_exit) {
 				dev->need_exit = 1;
@@ -695,19 +634,11 @@ int w1_control(void *data)
 
 			wait_for_completion(&dev->dev_exited);
 
-			list_for_each_safe(ent, n, &dev->slist) {
-				sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-				if (!sl)
-					dev_warn(&dev->dev,
-						  "%s: slave entry is NULL.\n",
-						  __func__);
-				else {
-					list_del(&sl->w1_slave_entry);
+			list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
+				list_del(&sl->w1_slave_entry);
 
-					w1_slave_detach(sl);
-					kfree(sl);
-				}
+				w1_slave_detach(sl);
+				kfree(sl);
 			}
 			w1_destroy_master_attributes(dev);
 			atomic_dec(&dev->refcnt);
@@ -720,8 +651,7 @@ int w1_control(void *data)
 int w1_process(void *data)
 {
 	struct w1_master *dev = (struct w1_master *) data;
-	struct list_head *ent, *n;
-	struct w1_slave *sl;
+	struct w1_slave *sl, *sln;
 
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
@@ -742,27 +672,20 @@ int w1_process(void *data)
 		if (down_interruptible(&dev->mutex))
 			continue;
 
-		list_for_each_safe(ent, n, &dev->slist) {
-			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-			if (sl)
+		list_for_each_entry(sl, &dev->slist, w1_slave_entry)
 				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
-		}
-		
-		w1_search_devices(dev, w1_slave_found);
 
-		list_for_each_safe(ent, n, &dev->slist) {
-			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
+		w1_search_devices(dev, w1_slave_found);
 
-			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
+		list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
+			if (!test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
 				list_del (&sl->w1_slave_entry);
 
 				w1_slave_detach (sl);
 				kfree (sl);
 
 				dev->slave_count--;
-			}
-			else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
+			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
 				sl->ttl = dev->slave_ttl;
 		}
 		up(&dev->mutex);
@@ -774,7 +697,7 @@ int w1_process(void *data)
 	return 0;
 }
 
-int w1_init(void)
+static int w1_init(void)
 {
 	int retval;
 
@@ -814,18 +737,14 @@ err_out_exit_init:
 	return retval;
 }
 
-void w1_fini(void)
+static void w1_fini(void)
 {
 	struct w1_master *dev;
-	struct list_head *ent, *n;
 
-	list_for_each_safe(ent, n, &w1_masters) {
-		dev = list_entry(ent, struct w1_master, w1_master_entry);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
-	}
 
 	control_needs_exit = 1;
-
 	wait_for_completion(&w1_control_complete);
 
 	driver_unregister(&w1_driver);
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -1,8 +1,8 @@
 /*
- * 	w1.h
+ *	w1.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,9 +25,9 @@
 struct w1_reg_num
 {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u64	family:8,
-		id:48,
-		crc:8;
+  	__u64	family:8,
+  		id:48,
+  		crc:8;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u64	crc:8,
 		id:48,
@@ -74,11 +74,11 @@ struct w1_slave
 	int			ttl;
 
 	struct w1_master	*master;
-	struct w1_family 	*family;
-	struct device 		dev;
-	struct completion 	dev_released;
+	struct w1_family	*family;
+	struct device		dev;
+	struct completion	dev_released;
 
-	struct bin_attribute 	attr_bin;
+	struct bin_attribute	attr_bin;
 	struct device_attribute	attr_name, attr_val;
 };
 
@@ -90,16 +90,16 @@ struct w1_bus_master
 
 	u8			(*read_bit)(unsigned long);
 	void			(*write_bit)(unsigned long, u8);
-  	
+
 	u8			(*read_byte)(unsigned long);
-  	void			(*write_byte)(unsigned long, u8);
-  	
+	void			(*write_byte)(unsigned long, u8);
+
 	u8			(*read_block)(unsigned long, u8 *, int);
 	void			(*write_block)(unsigned long, u8 *, int);
-	
-  	u8			(*touch_bit)(unsigned long, u8);
-  
-  	u8			(*reset_bus)(unsigned long);
+
+	u8			(*touch_bit)(unsigned long, u8);
+
+	u8			(*reset_bus)(unsigned long);
 
 	void			(*search)(unsigned long, w1_slave_found_callback);
 };
@@ -123,21 +123,20 @@ struct w1_master
 
 	int			need_exit;
 	pid_t			kpid;
-	struct semaphore 	mutex;
+	struct semaphore	mutex;
 
 	struct device_driver	*driver;
-	struct device 		dev;
-	struct completion 	dev_released;
-	struct completion 	dev_exited;
+	struct device		dev;
+	struct completion	dev_released;
+	struct completion	dev_exited;
 
 	struct w1_bus_master	*bus_master;
 
 	u32			seq, groups;
-	struct sock 		*nls;
+	struct sock		*nls;
 };
 
 int w1_create_master_attributes(struct w1_master *);
-void w1_destroy_master_attributes(struct w1_master *);
 void w1_search(struct w1_master *dev);
 
 #endif /* __KERNEL__ */
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_family.c
+ *	w1_family.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_family.h
+ *	w1_family.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -39,7 +39,7 @@ struct w1_family_ops
 {
 	ssize_t (* rname)(struct device *, struct device_attribute *, char *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
-	
+
 	ssize_t (* rval)(struct device *, struct device_attribute *, char *);
 	unsigned char rvalname[MAXNAMELEN];
 };
@@ -48,9 +48,9 @@ struct w1_family
 {
 	struct list_head	family_entry;
 	u8			fid;
-	
+
 	struct w1_family_ops	*fops;
-	
+
 	atomic_t		refcnt;
 	u8			need_exit;
 };
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_int.c
+ *	w1_int.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -39,8 +39,9 @@ extern spinlock_t w1_mlock;
 
 extern int w1_process(void *);
 
-struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
-	      struct device_driver *driver, struct device *device)
+static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
+				       struct device_driver *driver,
+				       struct device *device)
 {
 	struct w1_master *dev;
 	int err;
@@ -60,13 +61,13 @@ struct w1_master * w1_alloc_dev(u32 id, 
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-	dev->owner 		= THIS_MODULE;
-	dev->max_slave_count 	= slave_count;
-	dev->slave_count 	= 0;
-	dev->attempts 		= 0;
-	dev->kpid 		= -1;
-	dev->initialized 	= 0;
-	dev->id 		= id;
+	dev->owner		= THIS_MODULE;
+	dev->max_slave_count	= slave_count;
+	dev->slave_count	= 0;
+	dev->attempts		= 0;
+	dev->kpid		= -1;
+	dev->initialized	= 0;
+	dev->id			= id;
 	dev->slave_ttl		= slave_ttl;
 
 	atomic_set(&dev->refcnt, 2);
@@ -105,7 +106,7 @@ struct w1_master * w1_alloc_dev(u32 id, 
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 	if (dev->nls && dev->nls->sk_socket)
@@ -197,10 +198,8 @@ void __w1_remove_master_device(struct w1
 void w1_remove_master_device(struct w1_bus_master *bm)
 {
 	struct w1_master *dev = NULL;
-	struct list_head *ent, *n;
 
-	list_for_each_safe(ent, n, &w1_masters) {
-		dev = list_entry(ent, struct w1_master, w1_master_entry);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		if (!dev->initialized)
 			continue;
 
diff --git a/drivers/w1/w1_int.h b/drivers/w1/w1_int.h
--- a/drivers/w1/w1_int.h
+++ b/drivers/w1/w1_int.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_int.h
+ *	w1_int.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,8 +27,6 @@
 
 #include "w1.h"
 
-struct w1_master * w1_alloc_dev(u32, int, int, struct device_driver *, struct device *);
-void w1_free_dev(struct w1_master *dev);
 int w1_add_master_device(struct w1_bus_master *);
 void w1_remove_master_device(struct w1_bus_master *);
 void __w1_remove_master_device(struct w1_master *);
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_io.c
+ *	w1_io.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- a/drivers/w1/w1_io.h
+++ b/drivers/w1/w1_io.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_io.h
+ *	w1_io.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/w1/w1_log.h b/drivers/w1/w1_log.h
--- a/drivers/w1/w1_log.h
+++ b/drivers/w1/w1_log.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_log.h
+ *	w1_log.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -33,13 +33,13 @@ enum w1_netlink_message_types {
 	W1_MASTER_REMOVE,
 };
 
-struct w1_netlink_msg 
+struct w1_netlink_msg
 {
 	__u8				type;
 	__u8				reserved[3];
 	union
 	{
-		struct w1_reg_num 	id;
+		struct w1_reg_num	id;
 		__u64			w1_id;
 		struct
 		{
diff --git a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c
+++ b/drivers/w1/w1_smem.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_smem.c
+ *	w1_smem.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the smems of the GNU General Public License as published by
@@ -70,7 +70,7 @@ static ssize_t w1_smem_read_val(struct d
 static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-			      			struct w1_slave, dev);
+					   struct w1_slave, dev);
 	int i;
 
 	atomic_inc(&sl->refcnt);
@@ -90,7 +90,7 @@ static ssize_t w1_smem_read_bin(struct k
 	for (i = 0; i < 8; ++i)
 		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
 	count += sprintf(buf + count, "\n");
-	
+
 out:
 	up(&sl->master->mutex);
 out_dec:
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_therm.c
+ *	w1_therm.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the therms of the GNU General Public License as published by
@@ -38,7 +38,7 @@ MODULE_AUTHOR("Evgeniy Polyakov <johnpol
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature family.");
 
 static u8 bad_roms[][9] = {
-				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87}, 
+				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87},
 				{}
 			};
 
@@ -163,7 +163,7 @@ static int w1_therm_check_rom(u8 rom[9])
 static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-			      			struct w1_slave, dev);
+					   struct w1_slave, dev);
 	struct w1_master *dev = sl->master;
 	u8 rom[9], crc, verdict;
 	int i, max_trying = 10;
@@ -198,7 +198,7 @@ static ssize_t w1_therm_read_bin(struct 
 			unsigned int tm = 750;
 
 			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
-			
+
 			w1_write_block(dev, match, 9);
 
 			w1_write_8(dev, W1_CONVERT_TEMP);
@@ -211,7 +211,7 @@ static ssize_t w1_therm_read_bin(struct 
 
 			if (!w1_reset_bus (dev)) {
 				w1_write_block(dev, match, 9);
-				
+
 				w1_write_8(dev, W1_READ_SCRATCHPAD);
 				if ((count = w1_read_block(dev, rom, 9)) != 9) {
 					dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);

