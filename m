Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPQJX>; Sat, 16 Dec 2000 11:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLPQJN>; Sat, 16 Dec 2000 11:09:13 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:22025 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129345AbQLPQI7>;
	Sat, 16 Dec 2000 11:08:59 -0500
Date: Sat, 16 Dec 2000 17:37:51 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: mj@suse.cz
cc: linux-kernel@vger.kernel.org
Subject: [patch] pci.c inline documentation
Message-ID: <Pine.LNX.4.10.10012161733050.11101-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martin, all

	this patch fixes some of the problems of the inline docs in pci.c
and adds docs to other 10 functions.
Could you comment on the comments :-) ?

Jani.

--- /usr/src/linux/drivers/pci/pci.c.ol	Sat Dec 16 16:11:21 2000
+++ pci.c	Sat Dec 16 17:17:26 2000
@@ -40,10 +40,12 @@
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
- * @devfn:  number of PCI slot in which desired PCI device resides
+ * @devfn: encodes number of PCI slot in which the desired PCI 
+ * device resides and the logical device number within that slot 
+ * in case of multi-function devices.
  *
- * Given a PCI bus and slot number, the desired PCI device is
- * located in system global list of PCI devices.  If the device
+ * Given a PCI bus and slot/function number, the desired PCI device 
+ * is located in system global list of PCI devices.  If the device
  * is found, a pointer to its data structure is returned.  If no 
  * device is found, %NULL is returned.
  */
@@ -59,7 +61,20 @@
 	return NULL;
 }
 
-
+/**
+ * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @ss_vendor: PCI subsystem vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices.  If a PCI device is
+ * found with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
+ * device structure is returned.  Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL to the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from that point.
+ */
 struct pci_dev *
 pci_find_subsys(unsigned int vendor, unsigned int device,
 		unsigned int ss_vendor, unsigned int ss_device,
@@ -89,9 +104,8 @@
  * Iterates through the list of known PCI devices.  If a PCI device is
  * found with a matching @vendor and @device, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
- *
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not null, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from that point.
  */
 struct pci_dev *
 pci_find_device(unsigned int vendor, unsigned int device, const struct pci_dev *from)
@@ -108,9 +122,8 @@
  * Iterates through the list of known PCI devices.  If a PCI device is
  * found with a matching @class, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
- *
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not null, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from that point.
  */
 struct pci_dev *
 pci_find_class(unsigned int class, const struct pci_dev *from)
@@ -126,7 +139,28 @@
 	return NULL;
 }
 
-
+/**
+ * pci_find_capability - query for devices' capabilities 
+ * @dev: PCI device to query
+ * @cap: capability code
+ *
+ * Tell if a device supports a given PCI capability.
+ * Returns the address of the requested capability structure within the device's PCI 
+ * configuration space or 0 in case the device does not support it.
+ * Possible values for @flags:
+ *
+ *  %PCI_CAP_ID_PM           Power Management 
+ *
+ *  %PCI_CAP_ID_AGP          Accelerated Graphics Port 
+ *
+ *  %PCI_CAP_ID_VPD          Vital Product Data 
+ *
+ *  %PCI_CAP_ID_SLOTID       Slot Identification 
+ *
+ *  %PCI_CAP_ID_MSI          Message Signalled Interrupts
+ *
+ *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
+ */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
 {
@@ -281,6 +315,15 @@
 
 static LIST_HEAD(pci_drivers);
 
+/**
+ * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
+ * @ids: array of PCI device id structures to search in
+ * @dev: the PCI device structure to match against
+ * 
+ * Used by a driver to check whether a PCI device present in the
+ * system is in its list of supported devices.Returns the matching
+ * pci_device_id structure or %NULL if there is no match.
+ */
 const struct pci_device_id *
 pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev)
 {
@@ -295,7 +338,7 @@
 	}
 	return NULL;
 }
-
+ 
 static int
 pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
 {
@@ -321,6 +364,14 @@
 	return ret;
 }
 
+/**
+ * pci_register_driver - register a new pci driver
+ * @drv: the driver structure to register
+ * 
+ * Adds the driver structure to the list of registered drivers
+ * Returns the number of pci devices which were claimed by the driver
+ * during registration
+ */
 int
 pci_register_driver(struct pci_driver *drv)
 {
@@ -335,6 +386,15 @@
 	return count;
 }
 
+/**
+ * pci_unregister_driver - unregister a pci driver
+ * @drv: the driver structure to unregister
+ * 
+ * Deletes the driver structure from the list of registered PCI drivers,
+ * gives it a chance to clean up and marks the devices for which it
+ * was responsible as driverless 
+ */
+
 void
 pci_unregister_driver(struct pci_driver *drv)
 {
@@ -396,6 +456,13 @@
 	call_usermodehelper (argv [0], argv, envp);
 }
 
+/**
+ * pci_insert_device - insert a hotplug device
+ * @dev: the device to insert
+ * @bus: where to insert it
+ *
+ * Add a new device to the device lists and notify userspace (/sbin/hotplug)
+ */
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
 {
@@ -428,6 +495,13 @@
 	}
 }
 
+/**
+ * pci_remove_device - remove a hotplug device
+ * @dev: the device to remove
+ *
+ * Delete the device structure from the device lists and 
+ * notify userspace (/sbin/hotplug)
+ */
 void
 pci_remove_device(struct pci_dev *dev)
 {
@@ -453,6 +527,13 @@
 	name: "compat"
 };
 
+/**
+ * pci_dev_driver - get the pci_driver of a device
+ * @dev: the device to query
+ *
+ * Returns the appropriate pci_driver structure or %NULL if there is no 
+ * registered driver for the device
+ */
 struct pci_driver *
 pci_dev_driver(const struct pci_dev *dev)
 {
@@ -504,7 +585,13 @@
 PCI_OP(write, word, u16)
 PCI_OP(write, dword, u32)
 
-
+/**
+ * pci_set_master - enables bus-mastering for device dev
+ * @dev: the PCI device to enable
+ *
+ * Enables bus-mastering on the device and calls pcibios_set_master()
+ * to do the needed arch specific settings
+ */
 void
 pci_set_master(struct pci_dev *dev)
 {
@@ -838,8 +925,15 @@
 	dev->irq = irq;
 }
 
-/*
- * Fill in class and map information of a device
+/**
+ * pci_setup_device - fill in class and map information of a device
+ * @dev: the device structure to fill
+ *
+ * Initialize the device structure with information about the device's 
+ * vendor,class,memory and IO-space addresses,IRQ lines etc.
+ * Called at initialisation of the PCI subsystem and by CardBus services.
+ * Returns 0 on success and -1 if unknown type of device (not normal, bridge
+ * or CardBus)
  */
 int pci_setup_device(struct pci_dev * dev)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
