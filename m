Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265479AbSKFBre>; Tue, 5 Nov 2002 20:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSKFBrd>; Tue, 5 Nov 2002 20:47:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22544 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265479AbSKFBpL>;
	Tue, 5 Nov 2002 20:45:11 -0500
Date: Tue, 5 Nov 2002 17:47:48 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106014748.GA18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com> <20021106013835.GT18627@kroah.com> <20021106013915.GU18627@kroah.com> <20021106014304.GV18627@kroah.com> <20021106014358.GW18627@kroah.com> <20021106014444.GX18627@kroah.com> <20021106014528.GY18627@kroah.com> <20021106014603.GZ18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106014603.GZ18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.10, 2002/11/03 00:08:36-08:00, t-kouchi@mvf.biglobe.ne.jp

[PATCH] ACPI PCI hotplug updates

These are updates of the acpiphp driver for 2.5.
  - change debug flag from 'acpiphp_debug' to 'debug' for insmod
  - whitespace cleanup
  - message cleanup


diff -Nru a/drivers/hotplug/acpiphp.h b/drivers/hotplug/acpiphp.h
--- a/drivers/hotplug/acpiphp.h	Tue Nov  5 17:25:49 2002
+++ b/drivers/hotplug/acpiphp.h	Tue Nov  5 17:25:49 2002
@@ -41,12 +41,12 @@
 #define dbg(format, arg...)					\
 	do {							\
 		if (acpiphp_debug)				\
-			printk (KERN_DEBUG "%s: " format "\n",	\
+			printk(KERN_DEBUG "%s: " format,	\
 				MY_NAME , ## arg); 		\
 	} while (0)
-#define err(format, arg...) printk (KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk (KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk (KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME , ## arg)
 
 #define SLOT_MAGIC	0x67267322
 /* name size which is used for entries in pcihpfs */
diff -Nru a/drivers/hotplug/acpiphp_core.c b/drivers/hotplug/acpiphp_core.c
--- a/drivers/hotplug/acpiphp_core.c	Tue Nov  5 17:25:49 2002
+++ b/drivers/hotplug/acpiphp_core.c	Tue Nov  5 17:25:49 2002
@@ -50,6 +50,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
+static int debug;
 int acpiphp_debug;
 
 /* local variables */
@@ -62,8 +63,8 @@
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_PARM(acpiphp_debug, "i");
-MODULE_PARM_DESC(acpiphp_debug, "Debugging mode enabled or not");
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
 static int enable_slot		(struct hotplug_slot *slot);
 static int disable_slot		(struct hotplug_slot *slot);
@@ -95,15 +96,15 @@
 static inline int slot_paranoia_check (struct slot *slot, const char *function)
 {
 	if (!slot) {
-		dbg("%s - slot == NULL", function);
+		dbg("%s - slot == NULL\n", function);
 		return -1;
 	}
 	if (slot->magic != SLOT_MAGIC) {
-		dbg("%s - bad magic number for slot", function);
+		dbg("%s - bad magic number for slot\n", function);
 		return -1;
 	}
 	if (!slot->hotplug_slot) {
-		dbg("%s - slot->hotplug_slot == NULL!", function);
+		dbg("%s - slot->hotplug_slot == NULL!\n", function);
 		return -1;
 	}
 	return 0;
@@ -111,16 +112,16 @@
 
 
 static inline struct slot *get_slot (struct hotplug_slot *hotplug_slot, const char *function)
-{ 
+{
 	struct slot *slot;
 
 	if (!hotplug_slot) {
-		dbg("%s - hotplug_slot == NULL", function);
+		dbg("%s - hotplug_slot == NULL\n", function);
 		return NULL;
 	}
 
 	slot = (struct slot *)hotplug_slot->private;
-	if (slot_paranoia_check (slot, function))
+	if (slot_paranoia_check(slot, function))
                 return NULL;
 	return slot;
 }
@@ -135,16 +136,16 @@
  */
 static int enable_slot (struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
 
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	/* enable the specified slot */
-	retval = acpiphp_enable_slot (slot->acpi_slot);
+	retval = acpiphp_enable_slot(slot->acpi_slot);
 
 	return retval;
 }
@@ -159,16 +160,16 @@
  */
 static int disable_slot (struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
 
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	/* disable the specified slot */
-	retval = acpiphp_disable_slot (slot->acpi_slot);
+	retval = acpiphp_disable_slot(slot->acpi_slot);
 
 	return retval;
 }
@@ -185,8 +186,8 @@
 static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
 {
 	int retval = 0;
-	
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	switch (status) {
 		case 0:
@@ -213,15 +214,15 @@
  */
 static int hardware_test (struct hotplug_slot *hotplug_slot, u32 value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	err ("No hardware tests are defined for this driver");
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	err("No hardware tests are defined for this driver\n");
 	retval = -ENODEV;
 
 	return retval;
@@ -239,15 +240,15 @@
  */
 static int get_power_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	*value = acpiphp_get_power_status (slot->acpi_slot);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_power_status(slot->acpi_slot);
 
 	return retval;
 }
@@ -263,8 +264,8 @@
 static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int retval = 0;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	*value = hotplug_slot->info->attention_status;
 
@@ -283,15 +284,15 @@
  */
 static int get_latch_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	*value = acpiphp_get_latch_status (slot->acpi_slot);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_latch_status(slot->acpi_slot);
 
 	return retval;
 }
@@ -308,15 +309,15 @@
  */
 static int get_adapter_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	*value = acpiphp_get_adapter_status (slot->acpi_slot);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_adapter_status(slot->acpi_slot);
 
 	return retval;
 }
@@ -325,11 +326,11 @@
 /* return dummy value because ACPI doesn't provide any method... */
 static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
 	if (slot == NULL)
 		return -ENODEV;
-	
+
 	*value = PCI_SPEED_UNKNOWN;
 
 	return 0;
@@ -339,11 +340,11 @@
 /* return dummy value because ACPI doesn't provide any method... */
 static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
 	if (slot == NULL)
 		return -ENODEV;
-	
+
 	*value = PCI_SPEED_UNKNOWN;
 
 	return 0;
@@ -375,10 +376,10 @@
  */
 static void make_slot_name (struct slot *slot)
 {
-	snprintf (slot->hotplug_slot->name, SLOT_NAME_SIZE, "ACPI%d-%02x:%02x",
-		  slot->acpi_slot->sun,
-		  slot->acpi_slot->bridge->bus,
-		  slot->acpi_slot->device);
+	snprintf(slot->hotplug_slot->name, SLOT_NAME_SIZE, "ACPI%d-%02x:%02x",
+		 slot->acpi_slot->sun,
+		 slot->acpi_slot->bridge->bus,
+		 slot->acpi_slot->device);
 }
 
 /**
@@ -392,31 +393,31 @@
 	int i;
 
 	for (i = 0; i < num_slots; ++i) {
-		slot = kmalloc (sizeof (struct slot), GFP_KERNEL);
+		slot = kmalloc(sizeof(struct slot), GFP_KERNEL);
 		if (!slot)
 			return -ENOMEM;
 		memset(slot, 0, sizeof(struct slot));
 
-		slot->hotplug_slot = kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
+		slot->hotplug_slot = kmalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
 		if (!slot->hotplug_slot) {
-			kfree (slot);
+			kfree(slot);
 			return -ENOMEM;
 		}
-		memset(slot->hotplug_slot, 0, sizeof (struct hotplug_slot));
+		memset(slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
 
-		slot->hotplug_slot->info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
+		slot->hotplug_slot->info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
 		if (!slot->hotplug_slot->info) {
-			kfree (slot->hotplug_slot);
-			kfree (slot);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
 			return -ENOMEM;
 		}
-		memset(slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
+		memset(slot->hotplug_slot->info, 0, sizeof(struct hotplug_slot_info));
 
-		slot->hotplug_slot->name = kmalloc (SLOT_NAME_SIZE, GFP_KERNEL);
+		slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
 		if (!slot->hotplug_slot->name) {
-			kfree (slot->hotplug_slot->info);
-			kfree (slot->hotplug_slot);
-			kfree (slot);
+			kfree(slot->hotplug_slot->info);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
 			return -ENOMEM;
 		}
 
@@ -426,27 +427,27 @@
 		slot->hotplug_slot->private = slot;
 		slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
 
-		slot->acpi_slot = get_slot_from_id (i);
+		slot->acpi_slot = get_slot_from_id(i);
 		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
 		slot->hotplug_slot->info->attention_status = acpiphp_get_attention_status(slot->acpi_slot);
 		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
 		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
 
-		make_slot_name (slot);
+		make_slot_name(slot);
 
-		retval = pci_hp_register (slot->hotplug_slot);
+		retval = pci_hp_register(slot->hotplug_slot);
 		if (retval) {
-			err ("pci_hp_register failed with error %d", retval);
-			kfree (slot->hotplug_slot->info);
-			kfree (slot->hotplug_slot->name);
-			kfree (slot->hotplug_slot);
-			kfree (slot);
+			err("pci_hp_register failed with error %d\n", retval);
+			kfree(slot->hotplug_slot->info);
+			kfree(slot->hotplug_slot->name);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
 			return retval;
 		}
 
 		/* add slot to our internal list */
-		list_add (&slot->slot_list, &slot_list);
-		info("Slot [%s] registered", slot->hotplug_slot->name);
+		list_add(&slot->slot_list, &slot_list);
+		info("Slot [%s] registered\n", slot->hotplug_slot->name);
 	}
 
 	return retval;
@@ -459,13 +460,13 @@
 	struct slot *slot;
 
 	list_for_each_safe (tmp, n, &slot_list) {
-		slot = list_entry (tmp, struct slot, slot_list);
-		list_del (&slot->slot_list);
-		pci_hp_deregister (slot->hotplug_slot);
-		kfree (slot->hotplug_slot->info);
-		kfree (slot->hotplug_slot->name);
-		kfree (slot->hotplug_slot);
-		kfree (slot);
+		slot = list_entry(tmp, struct slot, slot_list);
+		list_del(&slot->slot_list);
+		pci_hp_deregister(slot->hotplug_slot);
+		kfree(slot->hotplug_slot->info);
+		kfree(slot->hotplug_slot->name);
+		kfree(slot->hotplug_slot);
+		kfree(slot);
 	}
 
 	return;
@@ -476,7 +477,9 @@
 {
 	int retval;
 
-	info (DRIVER_DESC " version: " DRIVER_VERSION);
+	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	acpiphp_debug = debug;
 
 	/* read all the ACPI info from the system */
 	retval = init_acpi();
diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Tue Nov  5 17:25:49 2002
+++ b/drivers/hotplug/acpiphp_glue.c	Tue Nov  5 17:25:49 2002
@@ -153,7 +153,7 @@
 	for (slot = bridge->slots; slot; slot = slot->next)
 		if (slot->device == device) {
 			if (slot->sun != sun)
-				warn("sibling found, but _SUN doesn't match!");
+				warn("sibling found, but _SUN doesn't match!\n");
 			break;
 		}
 
@@ -177,7 +177,7 @@
 
 		bridge->nr_slots++;
 
-		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:0x%x",
+		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:%d\n",
 		    slot->bridge->bus, slot->device, slot->sun);
 	}
 
@@ -202,7 +202,7 @@
 					     newfunc);
 
 	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler");
+		err("failed to register interrupt notify handler\n");
 		return status;
 	}
 
@@ -302,21 +302,21 @@
 			switch (resource_type) {
 			case ACPI_MEMORY_RANGE:
 				if (cache_attribute == ACPI_PREFETCHABLE_MEMORY) {
-					dbg("resource type: prefetchable memory 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+					dbg("resource type: prefetchable memory 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
 					res = acpiphp_make_resource(min_address_range,
 							    address_length);
 					if (!res) {
-						err("out of memory");
+						err("out of memory\n");
 						return;
 					}
 					res->next = bridge->p_mem_head;
 					bridge->p_mem_head = res;
 				} else {
-					dbg("resource type: memory 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+					dbg("resource type: memory 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
 					res = acpiphp_make_resource(min_address_range,
 							    address_length);
 					if (!res) {
-						err("out of memory");
+						err("out of memory\n");
 						return;
 					}
 					res->next = bridge->mem_head;
@@ -324,22 +324,22 @@
 				}
 				break;
 			case ACPI_IO_RANGE:
-				dbg("resource type: io 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+				dbg("resource type: io 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
 				res = acpiphp_make_resource(min_address_range,
 						    address_length);
 				if (!res) {
-					err("out of memory");
+					err("out of memory\n");
 					return;
 				}
 				res->next = bridge->io_head;
 				bridge->io_head = res;
 				break;
 			case ACPI_BUS_NUMBER_RANGE:
-				dbg("resource type: bus number %d - %d", (u32)min_address_range, (u32)max_address_range);
+				dbg("resource type: bus number %d - %d\n", (u32)min_address_range, (u32)max_address_range);
 				res = acpiphp_make_resource(min_address_range,
 						    address_length);
 				if (!res) {
-					err("out of memory");
+					err("out of memory\n");
 					return;
 				}
 				res->next = bridge->bus_head;
@@ -356,10 +356,9 @@
 	acpiphp_resource_sort_and_combine(&bridge->mem_head);
 	acpiphp_resource_sort_and_combine(&bridge->p_mem_head);
 	acpiphp_resource_sort_and_combine(&bridge->bus_head);
-#if 1
-	info("ACPI _CRS resource:");
+
+	dbg("ACPI _CRS resource:\n");
 	acpiphp_dump_resource(bridge);
-#endif
 }
 
 
@@ -368,7 +367,7 @@
 {
 	const struct list_head *l;
 
-	list_for_each(l, list) {
+	list_for_each (l, list) {
 		struct pci_bus *b = pci_bus_b(l);
 		if (b->number == bus)
 			return b;
@@ -404,7 +403,7 @@
 	status = acpi_evaluate_object(bridge->handle, "_HPP", NULL, &buffer);
 
 	if (ACPI_FAILURE(status)) {
-		dbg("_HPP evaluation failed");
+		dbg("_HPP evaluation failed\n");
 		return;
 	}
 
@@ -412,13 +411,13 @@
 
 	if (!package || package->type != ACPI_TYPE_PACKAGE ||
 	    package->package.count != 4 || !package->package.elements) {
-		err("invalid _HPP object; ignoring");
+		err("invalid _HPP object; ignoring\n");
 		goto err_exit;
 	}
 
 	for (i = 0; i < 4; i++) {
 		if (package->package.elements[i].type != ACPI_TYPE_INTEGER) {
-			err("invalid _HPP parameter type; ignoring");
+			err("invalid _HPP parameter type; ignoring\n");
 			goto err_exit;
 		}
 	}
@@ -428,7 +427,7 @@
 	bridge->hpp.enable_SERR = package->package.elements[2].integer.value;
 	bridge->hpp.enable_PERR = package->package.elements[3].integer.value;
 
-	dbg("_HPP parameter = (%02x, %02x, %02x, %02x)",
+	dbg("_HPP parameter = (%02x, %02x, %02x, %02x)\n",
 	    bridge->hpp.cache_line_size,
 	    bridge->hpp.latency_timer,
 	    bridge->hpp.enable_SERR,
@@ -463,15 +462,13 @@
 					     bridge);
 
 	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler");
+		err("failed to register interrupt notify handler\n");
 	}
 
 	list_add(&bridge->list, &bridge_list);
 
-#if 1
-	dbg("Bridge resource:");
+	dbg("Bridge resource:\n");
 	acpiphp_dump_resource(bridge);
-#endif
 }
 
 
@@ -507,7 +504,7 @@
 	status = acpi_get_current_resources(handle, &buffer);
 
 	if (ACPI_FAILURE(status)) {
-		err("failed to decode bridge resources");
+		err("failed to decode bridge resources\n");
 		kfree(bridge);
 		return;
 	}
@@ -535,7 +532,7 @@
 
 	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
 	if (bridge == NULL) {
-		err("out of memory");
+		err("out of memory\n");
 		return;
 	}
 
@@ -547,14 +544,14 @@
 
 	bridge->pci_dev = pci_find_slot(bus, PCI_DEVFN(dev, fn));
 	if (!bridge->pci_dev) {
-		err("Can't get pci_dev");
+		err("Can't get pci_dev\n");
 		kfree(bridge);
 		return;
 	}
 
 	bridge->pci_bus = bridge->pci_dev->subordinate;
 	if (!bridge->pci_bus) {
-		err("This is not a PCI-to-PCI bridge!");
+		err("This is not a PCI-to-PCI bridge!\n");
 		kfree(bridge);
 		return;
 	}
@@ -580,10 +577,10 @@
 		limit = ((limit << 8) & 0xf000) + 0xfff;
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->io_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("16bit I/O range: %04x-%04x",
+		dbg("16bit I/O range: %04x-%04x\n",
 		    (u32)bridge->io_head->base,
 		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
 		break;
@@ -594,18 +591,18 @@
 		limit = (((u32)tmp16 << 16) | ((limit << 8) & 0xf000)) + 0xfff;
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->io_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("32bit I/O range: %08x-%08x",
+		dbg("32bit I/O range: %08x-%08x\n",
 		    (u32)bridge->io_head->base,
 		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
 		break;
 	case 0x0f:
-		dbg("I/O space unsupported");
+		dbg("I/O space unsupported\n");
 		break;
 	default:
-		warn("Unknown I/O range type");
+		warn("Unknown I/O range type\n");
 	}
 
 	/* Memory resources (mandatory for P2P bridge) */
@@ -615,10 +612,10 @@
 	limit = ((tmp16 & 0xfff0) << 16) | 0xfffff;
 	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
 	if (!bridge->mem_head) {
-		err("out of memory");
+		err("out of memory\n");
 		return;
 	}
-	dbg("32bit Memory range: %08x-%08x",
+	dbg("32bit Memory range: %08x-%08x\n",
 	    (u32)bridge->mem_head->base,
 	    (u32)(bridge->mem_head->base + bridge->mem_head->length-1));
 
@@ -634,10 +631,10 @@
 		limit = ((limit & 0xfff0) << 16) | 0xfffff;
 		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->p_mem_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("32bit Prefetchable memory range: %08x-%08x",
+		dbg("32bit Prefetchable memory range: %08x-%08x\n",
 		    (u32)bridge->p_mem_head->base,
 		    (u32)(bridge->p_mem_head->base + bridge->p_mem_head->length - 1));
 		break;
@@ -649,10 +646,10 @@
 
 		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
 		if (!bridge->p_mem_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x",
+		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x\n",
 		    (u32)(bridge->p_mem_head->base >> 32),
 		    (u32)(bridge->p_mem_head->base & 0xffffffff),
 		    (u32)((bridge->p_mem_head->base + bridge->p_mem_head->length - 1) >> 32),
@@ -661,7 +658,7 @@
 	case 0x0f:
 		break;
 	default:
-		warn("Unknown prefetchale memory type");
+		warn("Unknown prefetchale memory type\n");
 	}
 
 	init_bridge_misc(bridge);
@@ -689,7 +686,7 @@
 
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
-		dbg("%s: _ADR evaluation failure", __FUNCTION__);
+		dbg("%s: _ADR evaluation failure\n", __FUNCTION__);
 		return AE_OK;
 	}
 
@@ -706,7 +703,7 @@
 
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
-		dbg("found PCI-to-PCI bridge at PCI %02x:%02x.%d", bus, device, function);
+		dbg("found PCI-to-PCI bridge at PCI %s\n", dev->slot_name);
 		add_p2p_bridge(handle, seg, bus, device, function);
 	}
 
@@ -727,7 +724,7 @@
 	if (ACPI_SUCCESS(status)) {
 		status = acpi_evaluate_integer(handle, "_STA", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
-			dbg("%s: _STA evaluation failure", __FUNCTION__);
+			dbg("%s: _STA evaluation failure\n", __FUNCTION__);
 			return 0;
 		}
 		if ((tmp & ACPI_STA_FUNCTIONING) == 0)
@@ -746,13 +743,13 @@
 	if (ACPI_SUCCESS(status)) {
 		bus = tmp;
 	} else {
-		warn("can't get bus number, assuming 0");
+		warn("can't get bus number, assuming 0\n");
 		bus = 0;
 	}
 
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
-		dbg("found PCI host-bus bridge with hot-pluggable slots");
+		dbg("found PCI host-bus bridge with hot-pluggable slots\n");
 		add_host_bridge(handle, seg, bus);
 		return 0;
 	}
@@ -764,7 +761,7 @@
 				     find_p2p_bridge, &tmp, NULL);
 
 	if (ACPI_FAILURE(status))
-		warn("find_p2p_bridge faied (error code = 0x%x)",status);
+		warn("find_p2p_bridge faied (error code = 0x%x)\n",status);
 
 	return 0;
 }
@@ -782,7 +779,7 @@
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
-		dbg("%s: failed to get bridge information", __FUNCTION__);
+		dbg("%s: failed to get bridge information\n", __FUNCTION__);
 		return AE_OK;		/* continue */
 	}
 
@@ -793,7 +790,7 @@
 	    (info.valid & ACPI_VALID_HID) &&
 	    strcmp(info.hardware_id, ACPI_PCI_HOST_HID) == 0) {
 		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
-		dbg("checking PCI-hotplug capable bridges under [%s]", objname);
+		dbg("checking PCI-hotplug capable bridges under [%s]\n", objname);
 		add_bridges(handle);
 	}
 	return AE_OK;
@@ -811,15 +808,15 @@
 	if (slot->flags & SLOT_POWEREDON)
 		goto err_exit;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_PS0) {
-			dbg("%s: executing _PS0 on %02x:%02x.%d", __FUNCTION__,
-			    slot->bridge->bus, slot->device, func->function);
+			dbg("%s: executing _PS0 on %s\n", __FUNCTION__,
+			    func->pci_dev->slot_name);
 			status = acpi_evaluate_object(func->handle, "_PS0", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
-				warn("%s: _PS0 failed", __FUNCTION__);
+				warn("%s: _PS0 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
 			}
@@ -849,27 +846,27 @@
 	if ((slot->flags & SLOT_POWEREDON) == 0)
 		goto err_exit;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_PS3) {
-			dbg("%s: executing _PS3 on %02x:%02x.%d", __FUNCTION__,
-			    slot->bridge->bus, slot->device, func->function);
+			dbg("%s: executing _PS3 on %s\n", __FUNCTION__,
+			    func->pci_dev->slot_name);
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
-				warn("%s: _PS3 failed", __FUNCTION__);
+				warn("%s: _PS3 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
 			}
 		}
 	}
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_EJ0) {
-			dbg("%s: executing _EJ0 on %02x:%02x.%d", __FUNCTION__,
-			    slot->bridge->bus, slot->device, func->function);
+			dbg("%s: executing _EJ0 on %s\n", __FUNCTION__,
+			    func->pci_dev->slot_name);
 
 			/* _EJ0 method take one argument */
 			arg_list.count = 1;
@@ -879,7 +876,7 @@
 
 			status = acpi_evaluate_object(func->handle, "_EJ0", &arg_list, NULL);
 			if (ACPI_FAILURE(status)) {
-				warn("%s: _EJ0 failed", __FUNCTION__);
+				warn("%s: _EJ0 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
 			}
@@ -919,7 +916,7 @@
 	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
 	if (dev) {
 		/* This case shouldn't happen */
-		err("pci_dev structure already exists.");
+		err("pci_dev structure already exists.\n");
 		retval = -1;
 		goto err_exit;
 	}
@@ -941,7 +938,7 @@
 	dev = pci_scan_slot (&dev0);
 
 	if (!dev) {
-		err("No new device found");
+		err("No new device found\n");
 		retval = -1;
 		goto err_exit;
 	}
@@ -953,7 +950,7 @@
 	}
 
 	/* associate pci_dev to our representation */
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		func->pci_dev = pci_find_slot(slot->bridge->bus,
@@ -970,10 +967,8 @@
 
 	slot->flags |= SLOT_ENABLED;
 
-#if 1
-	dbg("Available resources:");
+	dbg("Available resources:\n");
 	acpiphp_dump_resource(slot->bridge);
-#endif
 
  err_exit:
 	return retval;
@@ -993,14 +988,14 @@
 	if (!(slot->flags & SLOT_ENABLED))
 		goto err_exit;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->pci_dev) {
 			if (acpiphp_unconfigure_function(func) == 0) {
 				func->pci_dev = NULL;
 			} else {
-				err("failed to unconfigure device");
+				err("failed to unconfigure device\n");
 				retval = -1;
 				goto err_exit;
 			}
@@ -1033,7 +1028,7 @@
 	struct list_head *l;
 	struct acpiphp_func *func;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_STA) {
@@ -1063,7 +1058,7 @@
 /**
  * handle_hotplug_event_bridge - handle ACPI event on bridges
  *
- * @handle: Notify()'ed acpi_handle 
+ * @handle: Notify()'ed acpi_handle
  * @type: Notify code
  * @context: pointer to acpiphp_bridge structure
  *
@@ -1084,28 +1079,28 @@
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-		dbg("%s: Bus check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Bus check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_check_bridge(bridge);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		/* device check */
-		dbg("%s: Device check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_check_bridge(bridge);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
 		/* wake event */
-		dbg("%s: Device wake notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device wake notify on %s\n", __FUNCTION__, objname);
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
-		dbg("%s: Device eject notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
 		break;
 
 	default:
-		warn("notify_handler: unknown event type 0x%x for %s", type, objname);
+		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;
 	}
 }
@@ -1114,7 +1109,7 @@
 /**
  * handle_hotplug_event_func - handle ACPI event on functions (i.e. slots)
  *
- * @handle: Notify()'ed acpi_handle 
+ * @handle: Notify()'ed acpi_handle
  * @type: Notify code
  * @context: pointer to acpiphp_func structure
  *
@@ -1135,29 +1130,29 @@
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-		dbg("%s: Bus check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Bus check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_enable_slot(func->slot);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		/* device check : re-enumerate from parent bus */
-		dbg("%s: Device check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_check_bridge(func->slot->bridge);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
 		/* wake event */
-		dbg("%s: Device wake notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device wake notify on %s\n", __FUNCTION__, objname);
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
-		dbg("%s: Device eject notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
 		acpiphp_disable_slot(func->slot);
 		break;
 
 	default:
-		warn("notify_handler: unknown event type 0x%x for %s", type, objname);
+		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;
 	}
 }
@@ -1179,7 +1174,7 @@
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status)) {
-		err("%s: acpi_walk_namespace() failed", __FUNCTION__);
+		err("%s: acpi_walk_namespace() failed\n", __FUNCTION__);
 		return -1;
 	}
 
@@ -1200,12 +1195,12 @@
 	struct acpiphp_func *func;
 	acpi_status status;
 
-	list_for_each_safe(l1, n1, &bridge_list) {
+	list_for_each_safe (l1, n1, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)l1;
 		slot = bridge->slots;
 		while (slot) {
 			next = slot->next;
-			list_for_each_safe(l2, n2, &slot->funcs) {
+			list_for_each_safe (l2, n2, &slot->funcs) {
 				func = list_entry(l2, struct acpiphp_func, sibling);
 				acpiphp_free_resource(&func->io_head);
 				acpiphp_free_resource(&func->mem_head);
@@ -1215,7 +1210,7 @@
 								    ACPI_SYSTEM_NOTIFY,
 								    handle_hotplug_event_func);
 				if (ACPI_FAILURE(status))
-					err("failed to remove notify handler");
+					err("failed to remove notify handler\n");
 				kfree(func);
 			}
 			kfree(slot);
@@ -1224,7 +1219,7 @@
 		status = acpi_remove_notify_handler(bridge->handle, ACPI_SYSTEM_NOTIFY,
 						    handle_hotplug_event_bridge);
 		if (ACPI_FAILURE(status))
-			err("failed to remove notify handler");
+			err("failed to remove notify handler\n");
 
 		acpiphp_free_resource(&bridge->io_head);
 		acpiphp_free_resource(&bridge->mem_head);
@@ -1247,13 +1242,13 @@
 
 	num_slots = 0;
 
-	list_for_each(node, &bridge_list) {
+	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
-		dbg("Bus%d %dslot(s)", bridge->bus, bridge->nr_slots);
+		dbg("Bus%d %dslot(s)\n", bridge->bus, bridge->nr_slots);
 		num_slots += bridge->nr_slots;
 	}
 
-	dbg("Total %dslots", num_slots);
+	dbg("Total %dslots\n", num_slots);
 	return num_slots;
 }
 
@@ -1271,7 +1266,7 @@
 	struct acpiphp_slot *slot;
 	int retval = 0;
 
-	list_for_each(node, &bridge_list) {
+	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
 		for (slot = bridge->slots; slot; slot = slot->next) {
 			retval = fn(slot, data);
@@ -1292,7 +1287,7 @@
 	struct acpiphp_bridge *bridge;
 	struct acpiphp_slot *slot;
 
-	list_for_each(node, &bridge_list) {
+	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
 		for (slot = bridge->slots; slot; slot = slot->next)
 			if (slot->id == id)
@@ -1300,7 +1295,7 @@
 	}
 
 	/* should never happen! */
-	err("%s: no object for id %d",__FUNCTION__, id);
+	err("%s: no object for id %d\n",__FUNCTION__, id);
 	return 0;
 }
 
@@ -1352,7 +1347,7 @@
 	acpiphp_resource_sort_and_combine(&slot->bridge->mem_head);
 	acpiphp_resource_sort_and_combine(&slot->bridge->p_mem_head);
 	acpiphp_resource_sort_and_combine(&slot->bridge->bus_head);
-	dbg("Available resources:");
+	dbg("Available resources:\n");
 	acpiphp_dump_resource(slot->bridge);
 
  err_exit:
@@ -1380,7 +1375,7 @@
 			if (sta != ACPI_STA_ALL) {
 				retval = acpiphp_disable_slot(slot);
 				if (retval) {
-					err("Error occured in enabling");
+					err("Error occured in enabling\n");
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
@@ -1391,7 +1386,7 @@
 			if (sta == ACPI_STA_ALL) {
 				retval = acpiphp_enable_slot(slot);
 				if (retval) {
-					err("Error occured in enabling");
+					err("Error occured in enabling\n");
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
@@ -1400,7 +1395,7 @@
 		}
 	}
 
-	dbg("%s: %d enabled, %d disabled", __FUNCTION__, enabled, disabled);
+	dbg("%s: %d enabled, %d disabled\n", __FUNCTION__, enabled, disabled);
 
  err_exit:
 	return retval;
diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- a/drivers/hotplug/acpiphp_pci.c	Tue Nov  5 17:25:49 2002
+++ b/drivers/hotplug/acpiphp_pci.c	Tue Nov  5 17:25:49 2002
@@ -77,7 +77,7 @@
 		if (!bar)	/* This BAR is not implemented */
 			continue;
 
-		dbg("Device %02x.%02x BAR %d wants %x", device, function, count, bar);
+		dbg("Device %02x.%02x BAR %d wants %x\n", device, function, count, bar);
 
 		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
@@ -85,7 +85,7 @@
 			len = bar & 0xFFFFFFFC;
 			len = ~len + 1;
 
-			dbg ("len in IO %x, BAR %d", len, count);
+			dbg("len in IO %x, BAR %d\n", len, count);
 
 			spin_lock(&bridge->res_lock);
 			res = acpiphp_get_io_resource(&bridge->io_head, len);
@@ -110,7 +110,7 @@
 				len = bar & 0xFFFFFFF0;
 				len = ~len + 1;
 
-				dbg("len in PFMEM %x, BAR %d", len, count);
+				dbg("len in PFMEM %x, BAR %d\n", len, count);
 
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource(&bridge->p_mem_head, len);
@@ -127,7 +127,7 @@
 							   (u32)res->base);
 
 				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg ("inside the pfmem 64 case, count %d", count);
+					dbg("inside the pfmem 64 case, count %d\n", count);
 					count += 1;
 					pci_bus_write_config_dword(pbus, devfn,
 								   address[count],
@@ -143,7 +143,7 @@
 				len = bar & 0xFFFFFFF0;
 				len = ~len + 1;
 
-				dbg("len in MEM %x, BAR %d", len, count);
+				dbg("len in MEM %x, BAR %d\n", len, count);
 
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource(&bridge->mem_head, len);
@@ -161,7 +161,7 @@
 
 				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
-					dbg ("inside mem 64 case, reg. mem, count %d", count);
+					dbg("inside mem 64 case, reg. mem, count %d\n", count);
 					count += 1;
 					pci_bus_write_config_dword(pbus, devfn,
 								   address[count],
@@ -212,16 +212,16 @@
 
 	//pci_proc_attach_device(dev);
 	//pci_announce_device_to_drivers(dev);
-	info("Device %s configured", dev->slot_name);
+	info("Device %s configured\n", dev->slot_name);
 
 	return 0;
 }
 
 
-static int is_pci_dev_in_use (struct pci_dev* dev) 
+static int is_pci_dev_in_use (struct pci_dev* dev)
 {
-	/* 
-	 * dev->driver will be set if the device is in use by a new-style 
+	/*
+	 * dev->driver will be set if the device is in use by a new-style
 	 * driver -- otherwise, check the device's regions to see if any
 	 * driver has claimed them
 	 */
@@ -263,13 +263,13 @@
 {
 	struct pci_dev *dev = wrapped_dev->dev;
 
-	dbg("attempting removal of driver for device %s", dev->slot_name);
+	dbg("attempting removal of driver for device %s\n", dev->slot_name);
 
 	/* Now, remove the Linux Driver Representation */
 	if (dev->driver) {
 		if (dev->driver->remove) {
 			dev->driver->remove(dev);
-			dbg("driver was properly removed");
+			dbg("driver was properly removed\n");
 		}
 		dev->driver = NULL;
 	}
@@ -286,7 +286,7 @@
 	/* Now, remove the Linux Representation */
 	if (dev) {
 		if (pci_hp_remove_device(dev) == 0) {
-			info("Device %s removed", dev->slot_name);
+			info("Device %s removed\n", dev->slot_name);
 			kfree(dev); /* Now, remove */
 		} else {
 			return -1; /* problems while freeing, abort visitation */
@@ -338,7 +338,7 @@
 	int count;
 	struct pci_resource *res;
 
-	dbg("Device %s", dev->slot_name);
+	dbg("Device %s\n", dev->slot_name);
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
 		pci_read_config_dword(dev, address[count], &bar);
@@ -355,7 +355,7 @@
 			len &= 0xFFFFFFFC;
 			len = ~len + 1;
 
-			dbg("BAR[%d] %08x - %08x (IO)", count, (u32)base, (u32)base + len - 1);
+			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
 
 			spin_lock(&bridge->res_lock);
 			res = acpiphp_get_resource_with_base(&bridge->io_head, base, len);
@@ -372,10 +372,10 @@
 				len = ~len + 1;
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg ("prefetch mem 64");
+					dbg("prefetch mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (PMEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource_with_base(&bridge->p_mem_head, base, len);
 				spin_unlock(&bridge->res_lock);
@@ -389,10 +389,10 @@
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
-					dbg ("mem 64");
+					dbg("mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (MEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource_with_base(&bridge->mem_head, base, len);
 				spin_unlock(&bridge->res_lock);
@@ -414,7 +414,7 @@
 	struct list_head *l;
 	struct pci_dev *dev;
 
-	list_for_each(l, &bus->devices) {
+	list_for_each (l, &bus->devices) {
 		dev = pci_dev_b(l);
 		detect_used_resource(bridge, dev);
 		/* XXX recursive call */
@@ -463,16 +463,16 @@
 	struct pci_dev *dev;
 
 	dev = func->pci_dev;
-	dbg("Hot-pluggable device %s", dev->slot_name);
+	dbg("Hot-pluggable device %s\n", dev->slot_name);
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_read_config_dword (dev, address[count], &bar);
+		pci_read_config_dword(dev, address[count], &bar);
 
 		if (!bar)	/* This BAR is not implemented */
 			continue;
 
-		pci_write_config_dword (dev, address[count], 0xFFFFFFFF);
-		pci_read_config_dword (dev, address[count], &len);
+		pci_write_config_dword(dev, address[count], 0xFFFFFFFF);
+		pci_read_config_dword(dev, address[count], &len);
 
 		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
@@ -480,7 +480,7 @@
 			len &= 0xFFFFFFFC;
 			len = ~len + 1;
 
-			dbg("BAR[%d] %08x - %08x (IO)", count, (u32)base, (u32)base + len - 1);
+			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
 
 			res = acpiphp_make_resource(base, len);
 			if (!res)
@@ -499,10 +499,10 @@
 				len = ~len + 1;
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg ("prefetch mem 64");
+					dbg("prefetch mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (PMEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
 				res = acpiphp_make_resource(base, len);
 				if (!res)
 					goto no_memory;
@@ -518,10 +518,10 @@
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
-					dbg ("mem 64");
+					dbg("mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (MEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
 				res = acpiphp_make_resource(base, len);
 				if (!res)
 					goto no_memory;
@@ -532,7 +532,7 @@
 			}
 		}
 
-		pci_write_config_dword (dev, address[count], bar);
+		pci_write_config_dword(dev, address[count], bar);
 	}
 #if 1
 	acpiphp_dump_func_resource(func);
@@ -541,7 +541,7 @@
 	return 0;
 
  no_memory:
-	err("out of memory");
+	err("out of memory\n");
 	acpiphp_free_resource(&func->io_head);
 	acpiphp_free_resource(&func->mem_head);
 	acpiphp_free_resource(&func->p_mem_head);
@@ -574,7 +574,7 @@
 	if (hdr & 0x80)
 		is_multi = 1;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 		if (is_multi || func->function == 0) {
 			pci_bus_read_config_dword(slot->bridge->pci_bus,
@@ -583,7 +583,6 @@
 						  PCI_VENDOR_ID, &dvid);
 			if (dvid != 0xffffffff) {
 				retval = init_config_space(func);
-
 				if (retval)
 					break;
 			}
diff -Nru a/drivers/hotplug/acpiphp_res.c b/drivers/hotplug/acpiphp_res.c
--- a/drivers/hotplug/acpiphp_res.c	Tue Nov  5 17:25:49 2002
+++ b/drivers/hotplug/acpiphp_res.c	Tue Nov  5 17:25:49 2002
@@ -273,7 +273,7 @@
 
 	for (max = *head;max; max = max->next) {
 
-		/* If not big enough we could probably just bail, 
+		/* If not big enough we could probably just bail,
 		   instead we'll continue to the next. */
 		if (max->length < size)
 			continue;
@@ -370,13 +370,13 @@
 		return NULL;
 
 	for (node = *head; node; node = node->next) {
-		dbg("%s: req_size =%x node=%p, base=%x, length=%x",
+		dbg("%s: req_size =%x node=%p, base=%x, length=%x\n",
 		    __FUNCTION__, size, node, (u32)node->base, node->length);
 		if (node->length < size)
 			continue;
 
 		if (node->base & (size - 1)) {
-			dbg("%s: not aligned", __FUNCTION__);
+			dbg("%s: not aligned\n", __FUNCTION__);
 			/* this one isn't base aligned properly
 			   so we'll make a new entry and split it up */
 			temp_qword = (node->base | (size-1)) + 1;
@@ -400,7 +400,7 @@
 
 		/* Don't need to check if too small since we already did */
 		if (node->length > size) {
-			dbg("%s: too big", __FUNCTION__);
+			dbg("%s: too big\n", __FUNCTION__);
 			/* this one is longer than we need
 			   so we'll make a new entry and split it up */
 			split_node = acpiphp_make_resource(node->base + size, node->length - size);
@@ -415,7 +415,7 @@
 			node->next = split_node;
 		}  /* End of too big on top end */
 
-		dbg("%s: got one!!!", __FUNCTION__);
+		dbg("%s: got one!!!\n", __FUNCTION__);
 		/* If we got here, then it is the right size
 		   Now take it out of the list */
 		if (*head == node) {
@@ -437,7 +437,7 @@
 /**
  * get_resource_with_base - get resource with specific base address
  *
- * this function 
+ * this function
  * returns the first node of "size" length located at specified base address.
  * If it finds a node larger than "size" it will split it up.
  *
@@ -458,7 +458,7 @@
 		return NULL;
 
 	for (node = *head; node; node = node->next) {
-		dbg(": 1st req_base=%x req_size =%x node=%p, base=%x, length=%x",
+		dbg(": 1st req_base=%x req_size =%x node=%p, base=%x, length=%x\n",
 		    (u32)base, size, node, (u32)node->base, node->length);
 		if (node->base > base)
 			continue;
@@ -467,7 +467,7 @@
 			continue;
 
 		if (node->base < base) {
-			dbg(": split 1");
+			dbg(": split 1\n");
 			/* this one isn't base aligned properly
 			   so we'll make a new entry and split it up */
 			temp_qword = base;
@@ -489,12 +489,12 @@
 			node->next = split_node;
 		}
 
-		dbg(": 2nd req_base=%x req_size =%x node=%p, base=%x, length=%x",
+		dbg(": 2nd req_base=%x req_size =%x node=%p, base=%x, length=%x\n",
 		    (u32)base, size, node, (u32)node->base, node->length);
 
 		/* Don't need to check if too small since we already did */
 		if (node->length > size) {
-			dbg(": split 2");
+			dbg(": split 2\n");
 			/* this one is longer than we need
 			   so we'll make a new entry and split it up */
 			split_node = acpiphp_make_resource(node->base + size, node->length - size);
@@ -509,7 +509,7 @@
 			node->next = split_node;
 		}  /* End of too big on top end */
 
-		dbg(": got one!!!");
+		dbg(": got one!!!\n");
 		/* If we got here, then it is the right size
 		   Now take it out of the list */
 		if (*head == node) {
@@ -547,13 +547,13 @@
 	if (!(*head))
 		return 1;
 
-	dbg("*head->next = %p",(*head)->next);
+	dbg("*head->next = %p\n",(*head)->next);
 
 	if (!(*head)->next)
 		return 0;	/* only one item on the list, already sorted! */
 
-	dbg("*head->base = 0x%x",(u32)(*head)->base);
-	dbg("*head->next->base = 0x%x", (u32)(*head)->next->base);
+	dbg("*head->base = 0x%x\n",(u32)(*head)->base);
+	dbg("*head->next->base = 0x%x\n", (u32)(*head)->next->base);
 	while (out_of_order) {
 		out_of_order = 0;
 
@@ -587,7 +587,7 @@
 	while (node1 && node1->next) {
 		if ((node1->base + node1->length) == node1->next->base) {
 			/* Combine */
-			dbg("8..");
+			dbg("8..\n");
 			node1->length += node1->next->length;
 			node2 = node1->next;
 			node1->next = node1->next->next;
@@ -668,7 +668,7 @@
 	cnt = 0;
 
 	while (p) {
-		dbg("[%02d] %08x - %08x",
+		dbg("[%02d] %08x - %08x\n",
 		    cnt++, (u32)p->base, (u32)p->base + p->length - 1);
 		p = p->next;
 	}
@@ -676,24 +676,24 @@
 
 void acpiphp_dump_resource(struct acpiphp_bridge *bridge)
 {
-	dbg("I/O resource:");
+	dbg("I/O resource:\n");
 	dump_resource(bridge->io_head);
-	dbg("MEM resource:");
+	dbg("MEM resource:\n");
 	dump_resource(bridge->mem_head);
-	dbg("PMEM resource:");
+	dbg("PMEM resource:\n");
 	dump_resource(bridge->p_mem_head);
-	dbg("BUS resource:");
+	dbg("BUS resource:\n");
 	dump_resource(bridge->bus_head);
 }
 
 void acpiphp_dump_func_resource(struct acpiphp_func *func)
 {
-	dbg("I/O resource:");
+	dbg("I/O resource:\n");
 	dump_resource(func->io_head);
-	dbg("MEM resource:");
+	dbg("MEM resource:\n");
 	dump_resource(func->mem_head);
-	dbg("PMEM resource:");
+	dbg("PMEM resource:\n");
 	dump_resource(func->p_mem_head);
-	dbg("BUS resource:");
+	dbg("BUS resource:\n");
 	dump_resource(func->bus_head);
 }
