Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263103AbTDBSx4>; Wed, 2 Apr 2003 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbTDBSxz>; Wed, 2 Apr 2003 13:53:55 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:64189 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263103AbTDBSxp>;
	Wed, 2 Apr 2003 13:53:45 -0500
Date: Wed, 2 Apr 2003 21:05:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Patrick Mochel <mochel@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver model docs
Message-ID: <Pine.GSO.4.21.0304022102190.23156-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While trying to understand the new driver model (I still have to update the
Zorro bus support), I made these spelling and grammar modifications.

Furthermore it looks like some structures are no longer in sync with the actual
implementation, but I didn't change that.

Disclaimer: my mother tongue is Dutch, not English.

--- linux-cvs-2.5.x/Documentation/kobject.txt	12 Mar 2003 01:47:56 -0000	1.5
+++ linux-2.5.x/Documentation/kobject.txt	2 Apr 2003 18:08:53 -0000
@@ -9,7 +9,7 @@
 
 The kobject infrastructure performs basic object management that larger
 data structures and subsystems can leverage, rather than reimplement
-similar functionality. This functionality consists primarily concerns:
+similar functionality. This functionality primarily concerns:
 
 - Object reference counting.
 - Maintaining lists (sets) of objects.
@@ -45,7 +45,7 @@
 struct kobject is a simple data type that provides a foundation for
 more complex object types. It provides a set of basic fields that
 almost all complex data types share. kobjects are intended to be
-embedded in larger data structures and replace fields it duplicates. 
+embedded in larger data structures and replace fields they duplicate. 
 
 1.2 Defintion
 
@@ -77,7 +77,7 @@
 includes inserting the kobject in the list of its dominant kset and
 creating a directory for it in sysfs.
 
-Alternatively, one may use a kobject without adding to its kset's list
+Alternatively, one may use a kobject without adding it to its kset's list
 or exporting it via sysfs, by simply calling kobject_init(). An
 initialized kobject may later be added to the object hierarchy by
 calling kobject_add(). An initialized kobject may be used for
@@ -87,8 +87,8 @@
 equivalent to calling kobject_register().
 
 When a kobject is unregistered, it is removed from its kset's list,
-removed from the sysfs filesystem, and its reference decremented. List
-and sysfs removal happen in kobject_del(), and may be called
+removed from the sysfs filesystem, and its reference count is decremented.
+List and sysfs removal happen in kobject_del(), and may be called
 manually. kobject_put() decrements the reference count, and may also
 be called manually. 
 
@@ -98,8 +98,8 @@
 it is already positive. 
 
 When a kobject's reference count reaches 0, the method struct
-ktype::release() (which the kobject's kset points to) is called. This
-allows any memory allocated for the object to be freed.
+kobj_type::release() (which the kobject's kset points to) is called.
+This allows any memory allocated for the object to be freed.
 
 
 1.4 sysfs
@@ -118,7 +118,7 @@
 
 2. ksets
 
-2.1 Desecription
+2.1 Description
 
 A kset is a set of kobjects that are embedded in the same type. 
 
@@ -163,9 +163,9 @@
 	 kset_register(&disk->kset);
 
 - The kset that the disk's embedded object belongs to is the
-  block_kset, and is pointed to disk->kset.kobj.kset. 
+  block_kset, and is pointed to by disk->kset.kobj.kset. 
 
-- The type of object of the disk's _subordinate_ list are partitions, 
+- The type of objects on the disk's _subordinate_ list are partitions, 
   and is set in disk->kset.ktype. 
 
 - The kset is then registered, which handles initializing and adding
@@ -218,13 +218,13 @@
 - sysfs_ops: Provides conversion functions for sysfs access. Please
   see the sysfs documentation for more information. 
 
-- default_attrs: Default attributes to exported via sysfs when the
+- default_attrs: Default attributes to be exported via sysfs when the
   object is registered. 
 
 
 Instances of struct kobj_type are not registered; only referenced by
 the kset. A kobj_type may be referenced by an arbitrary number of
-ksets, as their may be disparate sets of identical objects. 
+ksets, as there may be disparate sets of identical objects. 
 
 
 
--- linux-cvs-2.5.x/Documentation/driver-model/binding.txt	11 Jan 2003 04:23:30 -0000	1.3
+++ linux-2.5.x/Documentation/driver-model/binding.txt	2 Apr 2003 18:08:53 -0000
@@ -11,11 +11,11 @@
 Bus
 ~~~
 
-The bus type structure contains a list of all devices that on that bus
+The bus type structure contains a list of all devices that are on that bus
 type in the system. When device_register is called for a device, it is
 inserted into the end of this list. The bus object also contains a
 list of all drivers of that bus type. When driver_register is called
-for a driver, it is inserted into the end of this list. These are the
+for a driver, it is inserted at the end of this list. These are the
 two events which trigger driver binding.
 
 
@@ -42,7 +42,7 @@
 ~~~~~~~~~~~~
 
 Upon the successful completion of probe, the device is registered with
-the class to which it belongs. Device drivers belong to one and only
+the class to which it belongs. Device drivers belong to one and only one
 class, and that is set in the driver's devclass field. 
 devclass_add_device is called to enumerate the device within the class
 and actually register it with the class, which happens with the
@@ -61,7 +61,7 @@
 
 
 sysfs
-~~~~~~~~
+~~~~~
 
 A symlink is created in the bus's 'devices' directory that points to
 the device's directory in the physical hierarchy.
--- linux-cvs-2.5.x/Documentation/driver-model/bus.txt	16 Jan 2003 02:28:01 -0000	1.4
+++ linux-2.5.x/Documentation/driver-model/bus.txt	2 Apr 2003 18:08:54 -0000
@@ -58,7 +58,7 @@
 
 The format of device ID structures and the semantics for comparing
 them are inherently bus-specific. Drivers typically declare an array
-of device IDs of device they support that reside in a bus-specific
+of device IDs of devices they support that reside in a bus-specific
 driver structure. 
 
 The purpose of the match callback is provide the bus an opportunity to
@@ -153,7 +153,7 @@
 	    |-- agpgart
 	    `-- e100
 
-Each device that is discovered a bus of that type gets a symlink in
+Each device that is discovered on a bus of that type gets a symlink in
 the bus's devices directory to the device's directory in the physical
 hierarchy:
 
--- linux-cvs-2.5.x/Documentation/driver-model/class.txt	11 Jan 2003 04:23:30 -0000	1.3
+++ linux-2.5.x/Documentation/driver-model/class.txt	2 Apr 2003 18:08:54 -0000
@@ -105,7 +105,7 @@
 
 
 Drivers registered with the class get a symlink in the drivers/ directory 
-that points the driver's directory (under its bus directory):
+that points to the driver's directory (under its bus directory):
 
    class/
    `-- input
--- linux-cvs-2.5.x/Documentation/driver-model/device.txt	11 Jan 2003 04:23:30 -0000	1.3
+++ linux-2.5.x/Documentation/driver-model/device.txt	2 Apr 2003 18:08:54 -0000
@@ -47,11 +47,13 @@
 
 children:      List of child devices.
 
+parent:        *** FIXME ***
+
 name:	       ASCII description of device. 
 	       Example: " 3Com Corporation 3c905 100BaseTX [Boomerang]"
 
 bus_id:	       ASCII representation of device's bus position. This 
-	       field should a name unique across all devices on the
+	       field should be a name unique across all devices on the
 	       bus type the device belongs to. 
 
 	       Example: PCI bus_ids are in the form of
@@ -66,12 +68,12 @@
 
 dir:	       Device's sysfs directory.
 
+class_num:     Class-enumerated value of the device.
+
 driver:	       Pointer to struct device_driver that controls the device.
 
 driver_data:   Driver-specific data.
 
-class_num:     Class-enumerated value of the device.
-
 platform_data: Platform data specific to the device.
 
 current_state: Current power state of the device.
@@ -108,7 +110,7 @@
 if the reference is not already 0 (if it's in the process of being
 removed already).
 
-A driver can take use the lock in the device structure using: 
+A driver can access the lock in the device structure using: 
 
 void lock_device(struct device * dev);
 void unlock_device(struct device * dev);
--- linux-cvs-2.5.x/Documentation/driver-model/driver.txt	12 Mar 2003 01:47:56 -0000	1.5
+++ linux-2.5.x/Documentation/driver-model/driver.txt	2 Apr 2003 18:08:54 -0000
@@ -63,9 +63,9 @@
 model because the bus they belong to has a bus-specific structure with
 bus-specific fields that cannot be generalized. 
 
-The most common example this are device ID structures. A driver
+The most common example of this are device ID structures. A driver
 typically defines an array of device IDs that it supports. The format
-of this structure and the semantics for comparing device IDs is
+of these structures and the semantics for comparing device IDs are
 completely bus-specific. Defining them as bus-specific entities would
 sacrifice type-safety, so we keep bus-specific structures around. 
 
@@ -77,8 +77,8 @@
        struct device_driver	  driver;
 };
 
-A definition that included bus-specific fields would look something
-like (using the eepro100 driver again):
+A definition that included bus-specific fields would look like
+(using the eepro100 driver again):
 
 static struct pci_driver eepro100_driver = {
        .id_table       = eepro100_pci_tbl,
@@ -109,7 +109,7 @@
 Most drivers, however, will have a bus-specific structure and will
 need to register with the bus using something like pci_driver_register.
 
-It is important that drivers register their drivers as early as
+It is important that drivers register their driver structure as early as
 possible. Registration with the core initializes several fields in the
 struct device_driver object, including the reference count and the
 lock. These fields are assumed to be valid at all times and may be
@@ -148,7 +148,7 @@
 
 
 sysfs
-~~~~~~~~
+~~~~~
 
 When a driver is registered, a sysfs directory is created in its
 bus's directory. In this directory, the driver can export an interface
@@ -205,7 +205,7 @@
 user-defined policy.
 
 SUSPEND_NOTIFY notifies the device that a suspend transition is about
-to happen. This happens on system power state transition to verify
+to happen. This happens on system power state transitions to verify
 that all devices can successfully suspend.
 
 A driver may choose to fail on this call, which should cause the
--- linux-cvs-2.5.x/Documentation/driver-model/interface.txt	11 Jan 2003 04:23:30 -0000	1.3
+++ linux-2.5.x/Documentation/driver-model/interface.txt	2 Apr 2003 18:08:55 -0000
@@ -82,7 +82,7 @@
 and the enumerated value is stored in the struct intf_data for that device. 
 
 sysfs
-~~~~~~~~
+~~~~~
 Each interface is given a directory in the directory of the device
 class it belongs to:
 
@@ -120,10 +120,10 @@
 
 Many interfaces have a major number associated with them and each
 device gets a minor number. Or, multiple interfaces might share one
-major number, and each get receive a range of minor numbers (like in
+major number, and each will receive a range of minor numbers (like in
 the case of input devices).
 
 These major and minor numbers could be stored in the interface
-structure. Major and minor allocation could happen when the interface
+structure. Major and minor allocations could happen when the interface
 is registered with the class, or via a helper function. 
 
--- linux-cvs-2.5.x/Documentation/driver-model/overview.txt	2 Apr 2003 03:54:05 -0000	1.5
+++ linux-2.5.x/Documentation/driver-model/overview.txt	2 Apr 2003 18:08:55 -0000
@@ -9,7 +9,7 @@
 ~~~~~~~~
 
 This driver model is a unification of all the current, disparate driver models
-that are currently in the kernel. It is intended is to augment the
+that are currently in the kernel. It is intended to augment the
 bus-specific drivers for bridges and devices by consolidating a set of data
 and operations into globally accessible data structures.
 
@@ -23,7 +23,7 @@
 of the global tree.
 
 Common data fields can also be moved out of the local bus models into the
-global model. Some of the manipulation of these fields can also be
+global model. Some of the manipulations of these fields can also be
 consolidated. Most likely, manipulation functions will become a set
 of helper functions, which the bus drivers wrap around to include any
 bus-specific items.
@@ -71,7 +71,7 @@
 This abstraction is prevention of unnecessary pain during transitional phases.
 If the name of the field changes or is removed, then every downstream driver
 will break. On the other hand, if only the bus layer (and not the device
-layer) accesses struct device, it is only those that need to change.
+layer) accesses struct device, it is only that layer that needs to change.
 
 
 User Interface
@@ -96,9 +96,9 @@
 This directory may be populated at each layer of discovery - the global layer,
 the bus layer, or the device layer.
 
-The global layer currently creates two files - name and 'power'. The
+The global layer currently creates two files - 'name' and 'power'. The
 former only reports the name of the device. The latter reports the
-current power state of the device. It also be used to set the current
+current power state of the device. It will also be used to set the current
 power state. 
 
 The bus layer may also create files for the devices it finds while probing the
--- linux-cvs-2.5.x/Documentation/driver-model/platform.txt	12 Mar 2003 01:47:56 -0000	1.3
+++ linux-2.5.x/Documentation/driver-model/platform.txt	2 Apr 2003 18:08:55 -0000
@@ -10,9 +10,9 @@
 
 Platform drivers
 ~~~~~~~~~~~~~~~~
-Drivers for platform devices have typically very simple and
+Drivers for platform devices are typically very simple and
 unstructured. Either the device was present at a particular I/O port
-and the driver was loaded, or there was not. There was no possibility
+and the driver was loaded, or it was not. There was no possibility
 of hotplugging or alternative discovery besides probing at a specific
 I/O address and expecting a specific response.
 
@@ -49,7 +49,7 @@
 
 Bus IDs
 ~~~~~~~
-Bus IDs are the canonical name for the device. There is no globally
+Bus IDs are the canonical names for the devices. There is no globally
 standard addressing mechanism for legacy devices. In the IA-32 world,
 we have Pnp IDs to use, as well as the legacy I/O ports. However,
 neither tell what the device really is or have any meaning on other
@@ -62,7 +62,7 @@
 
 For example, a serial driver might find a device at I/O 0x3f8. The
 ACPI firmware might also discover a device with PnP ID (_HID)
-PNP0501. Both correspond to the same device should be mapped to the
+PNP0501. Both correspond to the same device and should be mapped to the
 canonical name 'serial'. 
 
 The bus_id field should be a concatenation of the canonical name and
@@ -88,7 +88,7 @@
 ~~~~~~~~~~~~~~
 Legacy drivers assume they are bound to the device once they start up
 and probe an I/O port. Divorcing them from this will be a difficult
-process. However, that shouldn't prevent us from impelementing
+process. However, that shouldn't prevent us from implementing
 firmware-based enumeration. 
 
 The firmware should notify the platform bus about devices before the
--- linux-cvs-2.5.x/Documentation/driver-model/porting.txt	11 Jan 2003 04:23:30 -0000	1.2
+++ linux-2.5.x/Documentation/driver-model/porting.txt	2 Apr 2003 18:08:55 -0000
@@ -128,7 +128,7 @@
 
   The bus_id is an ASCII string that contains the device's address on
   the bus. The format of this string is bus-specific. This is
-  necessary for representing device in sysfs. 
+  necessary for representing devices in sysfs. 
 
   parent is the physical parent of the device. It is important that
   the bus driver sets this field correctly. 
@@ -286,7 +286,7 @@
 It would be difficult and tedious to force every driver on a bus to
 simultaneously convert their drivers to generic format. Instead, the
 bus driver should define single instances of the generic methods that
-forward calls to the bus-specific drivers. For instance: 
+forward call to the bus-specific drivers. For instance: 
 
 
 static int pci_device_remove(struct device * dev)
@@ -330,8 +330,8 @@
 devices must be bound to a driver, or drivers must be bound to all
 devices that it supports. 
 
-Drivers typically contain a list of device IDs that it supports. The
-bus driver compares this ID to the ID of devices registered with it. 
+A driver typically contains a list of device IDs that it supports. The
+bus driver compares these IDs to the IDs of devices registered with it. 
 The format of the device IDs, and the semantics for comparing them are
 bus-specific, so the generic model does attempt to generalize them. 
 
@@ -396,7 +396,7 @@
 Step 7: Cleaning up the bus driver.
 
 The generic bus, device, and driver structures provide several fields
-that can replace those define privately to the bus driver. 
+that can replace those defined privately to the bus driver. 
 
 - Device list.
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

