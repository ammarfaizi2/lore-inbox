Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSKHBkt>; Thu, 7 Nov 2002 20:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266705AbSKHBkt>; Thu, 7 Nov 2002 20:40:49 -0500
Received: from fmr06.intel.com ([134.134.136.7]:5612 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266701AbSKHBkr>; Thu, 7 Nov 2002 20:40:47 -0500
Date: Thu, 7 Nov 2002 17:47:31 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200211080147.gA81lVs04905@linux.intel.com>
To: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: [PATCH]Driver-model docs for 2.5.46
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed all the Documentation/device-model/ files still refer to driverfs
instead of sysfs.  Here is a 2.5.46 patch that just replaces all "driverfs"
with "sysfs".

	   -rustyl

diff -urN linux-2.5.46/Documentation/driver-model/binding.txt linux-2.5.46-patched/Documentation/driver-model/binding.txt
--- linux-2.5.46/Documentation/driver-model/binding.txt	2002-10-18 21:01:50.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/binding.txt	2002-11-07 17:25:33.000000000 -0800
@@ -60,7 +60,7 @@
 driver's list of devices. 
 
 
-driverfs
+sysfs
 ~~~~~~~~
 
 A symlink is created in the bus's 'devices' directory that points to
@@ -71,7 +71,7 @@
 
 A directory for the device is created in the class's directory. A
 symlink is created in that directory that points to the device's
-physical location in the driverfs tree. 
+physical location in the sysfs tree. 
 
 A symlink can be created (though this isn't done yet) in the device's
 physical directory to either its class directory, or the class's
diff -urN linux-2.5.46/Documentation/driver-model/bus.txt linux-2.5.46-patched/Documentation/driver-model/bus.txt
--- linux-2.5.46/Documentation/driver-model/bus.txt	2002-10-18 21:01:59.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/bus.txt	2002-11-07 17:26:50.000000000 -0800
@@ -131,7 +131,7 @@
 lock is not held when calling the callback. 
 
 
-driverfs
+sysfs
 ~~~~~~~~
 There is a top-level directory named 'bus'.
 
@@ -184,7 +184,7 @@
 static bus_attribute bus_attr_debug;
 
 This can then be used to add and remove the attribute from the bus's
-driverfs directory using:
+sysfs directory using:
 
 int bus_create_file(struct bus_type *, struct bus_attribute *);
 void bus_remove_file(struct bus_type *, struct bus_attribute *);
diff -urN linux-2.5.46/Documentation/driver-model/class.txt linux-2.5.46-patched/Documentation/driver-model/class.txt
--- linux-2.5.46/Documentation/driver-model/class.txt	2002-10-18 21:01:09.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/class.txt	2002-11-07 17:26:48.000000000 -0800
@@ -91,9 +91,9 @@
 the struct device_driver::devclass field. 
 
 
-driverfs directory structure
+sysfs directory structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-There is a top-level driverfs directory named 'class'. 
+There is a top-level sysfs directory named 'class'. 
 
 Each class gets a directory in the class directory, along with two
 default subdirectories:
@@ -143,13 +143,13 @@
 static devclass_attribute devclass_attr_debug;
 
 The bus driver can add and remove the attribute from the class's
-driverfs directory using:
+sysfs directory using:
 
 int devclass_create_file(struct device_class *, struct devclass_attribute *);
 void devclass_remove_file(struct device_class *, struct devclass_attribute *);
 
 In the example above, the file will be named 'debug' in placed in the
-class's directory in driverfs. 
+class's directory in sysfs. 
 
 
 Interfaces
diff -urN linux-2.5.46/Documentation/driver-model/device.txt linux-2.5.46-patched/Documentation/driver-model/device.txt
--- linux-2.5.46/Documentation/driver-model/device.txt	2002-10-18 21:01:54.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/device.txt	2002-11-07 17:26:45.000000000 -0800
@@ -64,7 +64,7 @@
 
 bus:	       Pointer to struct bus_type that device belongs to.
 
-dir:	       Device's driverfs directory.
+dir:	       Device's sysfs directory.
 
 driver:	       Pointer to struct device_driver that controls the device.
 
@@ -125,8 +125,8 @@
 Attributes of devices can be exported via drivers using a simple
 procfs-like interface. 
 
-Please see Documentation/filesystems/driverfs.txt for more information
-on how driverfs works.
+Please see Documentation/filesystems/sysfs.txt for more information
+on how sysfs works.
 
 Attributes are declared using a macro called DEVICE_ATTR:
 
diff -urN linux-2.5.46/Documentation/driver-model/driver.txt linux-2.5.46-patched/Documentation/driver-model/driver.txt
--- linux-2.5.46/Documentation/driver-model/driver.txt	2002-10-18 21:01:54.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/driver.txt	2002-11-07 17:26:43.000000000 -0800
@@ -147,10 +147,10 @@
 accesses it. 
 
 
-driverfs
+sysfs
 ~~~~~~~~
 
-When a driver is registered, a driverfs directory is created in its
+When a driver is registered, a sysfs directory is created in its
 bus's directory. In this directory, the driver can export an interface
 to userspace to control operation of the driver on a global basis;
 e.g. toggling debugging output in the driver.
@@ -268,7 +268,7 @@
         ssize_t (*store)(struct device_driver *, const char * buf, size_t count, loff_t off);
 };
 
-Device drivers can export attributes via their driverfs directories. 
+Device drivers can export attributes via their sysfs directories. 
 Drivers can declare attributes using a DRIVER_ATTR macro that works
 identically to the DEVICE_ATTR macro. 
 
diff -urN linux-2.5.46/Documentation/driver-model/interface.txt linux-2.5.46-patched/Documentation/driver-model/interface.txt
--- linux-2.5.46/Documentation/driver-model/interface.txt	2002-10-18 21:01:54.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/interface.txt	2002-11-07 17:26:41.000000000 -0800
@@ -81,7 +81,7 @@
 Devices are enumerated within the interface. This happens in interface_add_data()
 and the enumerated value is stored in the struct intf_data for that device. 
 
-driverfs
+sysfs
 ~~~~~~~~
 Each interface is given a directory in the directory of the device
 class it belongs to:
diff -urN linux-2.5.46/Documentation/driver-model/overview.txt linux-2.5.46-patched/Documentation/driver-model/overview.txt
--- linux-2.5.46/Documentation/driver-model/overview.txt	2002-10-18 21:01:20.000000000 -0700
+++ linux-2.5.46-patched/Documentation/driver-model/overview.txt	2002-11-07 17:26:30.000000000 -0800
@@ -80,17 +80,17 @@
 By virtue of having a complete hierarchical view of all the devices in the
 system, exporting a complete hierarchical view to userspace becomes relatively
 easy. This has been accomplished by implementing a special purpose virtual
-file system named driverfs. It is hence possible for the user to mount the
-whole driverfs filesystem anywhere in userspace.
+file system named sysfs. It is hence possible for the user to mount the
+whole sysfs filesystem anywhere in userspace.
 
 This can be done permanently by providing the following entry into the
 /etc/fstab (under the provision that the mount point does exist, of course):
 
-none     	/devices	driverfs    defaults		0	0
+none     	/devices	sysfs    defaults		0	0
 
 Or by hand on the command line:
 
-~: mount -t driverfs none /devices
+~: mount -t sysfs none /devices
 
 Whenever a device is inserted into the tree, a directory is created for it.
 This directory may be populated at each layer of discovery - the global layer,
@@ -108,7 +108,7 @@
 A device-specific driver may also export files in its directory to expose
 device-specific data or tunable interfaces.
 
-More information about the driverfs directory layout can be found in
+More information about the sysfs directory layout can be found in
 the other documents in this directory and in the file 
-Documentation/filesystems/driverfs.txt.
+Documentation/filesystems/sysfs.txt.
 
