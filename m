Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263180AbSJHAHJ>; Mon, 7 Oct 2002 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbSJHAGl>; Mon, 7 Oct 2002 20:06:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35240 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263160AbSJHAEI>;
	Mon, 7 Oct 2002 20:04:08 -0400
Date: Mon, 7 Oct 2002 17:12:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] Rename driverfs to kfs
In-Reply-To: <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071711550.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.573.1.140, 2002-10-07 15:24:31-07:00, mochel@osdl.org
  kfs documentation: s/driverfs/kfs/g in driver model and kfs docs.
  
  Also, move Documentation/filesystems/driverfs.txt to 
  Documentation/filesystems/kfs.txt.

diff -Nru a/Documentation/driver-model/binding.txt b/Documentation/driver-model/binding.txt
--- a/Documentation/driver-model/binding.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/binding.txt	Mon Oct  7 15:40:18 2002
@@ -60,7 +60,7 @@
 driver's list of devices. 
 
 
-driverfs
+kfs
 ~~~~~~~~
 
 A symlink is created in the bus's 'devices' directory that points to
@@ -71,7 +71,7 @@
 
 A directory for the device is created in the class's directory. A
 symlink is created in that directory that points to the device's
-physical location in the driverfs tree. 
+physical location in the kfs tree. 
 
 A symlink can be created (though this isn't done yet) in the device's
 physical directory to either its class directory, or the class's
diff -Nru a/Documentation/driver-model/bus.txt b/Documentation/driver-model/bus.txt
--- a/Documentation/driver-model/bus.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/bus.txt	Mon Oct  7 15:40:18 2002
@@ -131,7 +131,7 @@
 lock is not held when calling the callback. 
 
 
-driverfs
+kfs
 ~~~~~~~~
 There is a top-level directory named 'bus'.
 
@@ -184,7 +184,7 @@
 static bus_attribute bus_attr_debug;
 
 This can then be used to add and remove the attribute from the bus's
-driverfs directory using:
+kfs directory using:
 
 int bus_create_file(struct bus_type *, struct bus_attribute *);
 void bus_remove_file(struct bus_type *, struct bus_attribute *);
diff -Nru a/Documentation/driver-model/class.txt b/Documentation/driver-model/class.txt
--- a/Documentation/driver-model/class.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/class.txt	Mon Oct  7 15:40:18 2002
@@ -91,9 +91,9 @@
 the struct device_driver::devclass field. 
 
 
-driverfs directory structure
+kfs directory structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-There is a top-level driverfs directory named 'class'. 
+There is a top-level kfs directory named 'class'. 
 
 Each class gets a directory in the class directory, along with two
 default subdirectories:
@@ -143,13 +143,13 @@
 static devclass_attribute devclass_attr_debug;
 
 The bus driver can add and remove the attribute from the class's
-driverfs directory using:
+kfs directory using:
 
 int devclass_create_file(struct device_class *, struct devclass_attribute *);
 void devclass_remove_file(struct device_class *, struct devclass_attribute *);
 
 In the example above, the file will be named 'debug' in placed in the
-class's directory in driverfs. 
+class's directory in kfs. 
 
 
 Interfaces
diff -Nru a/Documentation/driver-model/device.txt b/Documentation/driver-model/device.txt
--- a/Documentation/driver-model/device.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/device.txt	Mon Oct  7 15:40:18 2002
@@ -64,7 +64,7 @@
 
 bus:	       Pointer to struct bus_type that device belongs to.
 
-dir:	       Device's driverfs directory.
+dir:	       Device's kfs directory.
 
 driver:	       Pointer to struct device_driver that controls the device.
 
@@ -125,8 +125,8 @@
 Attributes of devices can be exported via drivers using a simple
 procfs-like interface. 
 
-Please see Documentation/filesystems/driverfs.txt for more information
-on how driverfs works.
+Please see Documentation/filesystems/kfs.txt for more information
+on how kfs works.
 
 Attributes are declared using a macro called DEVICE_ATTR:
 
diff -Nru a/Documentation/driver-model/driver.txt b/Documentation/driver-model/driver.txt
--- a/Documentation/driver-model/driver.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/driver.txt	Mon Oct  7 15:40:18 2002
@@ -147,10 +147,10 @@
 accesses it. 
 
 
-driverfs
+kfs
 ~~~~~~~~
 
-When a driver is registered, a driverfs directory is created in its
+When a driver is registered, a kfs directory is created in its
 bus's directory. In this directory, the driver can export an interface
 to userspace to control operation of the driver on a global basis;
 e.g. toggling debugging output in the driver.
@@ -268,7 +268,7 @@
         ssize_t (*store)(struct device_driver *, const char * buf, size_t count, loff_t off);
 };
 
-Device drivers can export attributes via their driverfs directories. 
+Device drivers can export attributes via their kfs directories. 
 Drivers can declare attributes using a DRIVER_ATTR macro that works
 identically to the DEVICE_ATTR macro. 
 
diff -Nru a/Documentation/driver-model/interface.txt b/Documentation/driver-model/interface.txt
--- a/Documentation/driver-model/interface.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/interface.txt	Mon Oct  7 15:40:18 2002
@@ -81,7 +81,7 @@
 Devices are enumerated within the interface. This happens in interface_add_data()
 and the enumerated value is stored in the struct intf_data for that device. 
 
-driverfs
+kfs
 ~~~~~~~~
 Each interface is given a directory in the directory of the device
 class it belongs to:
diff -Nru a/Documentation/driver-model/overview.txt b/Documentation/driver-model/overview.txt
--- a/Documentation/driver-model/overview.txt	Mon Oct  7 15:40:18 2002
+++ b/Documentation/driver-model/overview.txt	Mon Oct  7 15:40:18 2002
@@ -80,17 +80,17 @@
 By virtue of having a complete hierarchical view of all the devices in the
 system, exporting a complete hierarchical view to userspace becomes relatively
 easy. This has been accomplished by implementing a special purpose virtual
-file system named driverfs. It is hence possible for the user to mount the
-whole driverfs filesystem anywhere in userspace.
+file system named kfs. It is hence possible for the user to mount the
+whole kfs filesystem anywhere in userspace.
 
 This can be done permanently by providing the following entry into the
 /etc/fstab (under the provision that the mount point does exist, of course):
 
-none     	/devices	driverfs    defaults		0	0
+none     	/devices	kfs    defaults		0	0
 
 Or by hand on the command line:
 
-~: mount -t driverfs none /devices
+~: mount -t kfs none /devices
 
 Whenever a device is inserted into the tree, a directory is created for it.
 This directory may be populated at each layer of discovery - the global layer,
@@ -108,7 +108,7 @@
 A device-specific driver may also export files in its directory to expose
 device-specific data or tunable interfaces.
 
-More information about the driverfs directory layout can be found in
+More information about the kfs directory layout can be found in
 the other documents in this directory and in the file 
-Documentation/filesystems/driverfs.txt.
+Documentation/filesystems/kfs.txt.
 
diff -Nru a/Documentation/filesystems/driverfs.txt b/Documentation/filesystems/driverfs.txt
--- a/Documentation/filesystems/driverfs.txt	Mon Oct  7 15:40:18 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,336 +0,0 @@
-
-driverfs - The Device Driver Filesystem
-
-Patrick Mochel	<mochel@osdl.org>
-
-2 August 2002
-
-
-What it is:
-~~~~~~~~~~~
-driverfs is a ram-based filesystem. It was created by copying
-ramfs/inode.c to driverfs/inode.c and doing a little search-and-replace. 
-
-driverfs is a means to export kernel data structures, their
-attributes, and the linkages between them to userspace. 
-
-driverfs provides a unified interface for exporting attributes to
-userspace. Currently, this interface is available only to device and
-bus drivers. 
-
-
-Using driverfs
-~~~~~~~~~~~~~~
-driverfs is always compiled in. You can access it by doing something like:
-
-    mount -t driverfs driverfs /devices 
-
-
-Top Level Directory Layout
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-The driverfs directory arrangement exposes the relationship of kernel
-data structures. 
-
-The top level driverfs diretory looks like:
-
-bus/
-root/
-
-root/ contains a filesystem representation of the device tree. It maps
-directly to the internal kernel device tree, which is a hierarchy of
-struct device. 
-
-bus/ contains flat directory layout of the various bus types in the
-kernel. Each bus's directory contains two subdirectories:
-
-	devices/
-	drivers/
-
-devices/ contains symlinks for each device discovered in the system
-that point to the device's directory under root/.
-
-drivers/ contains a directory for each device driver that is loaded
-for devices on that particular bus (this assmumes that drivers do not
-span multiple bus types).
-
-
-More information can device-model specific features can be found in
-Documentation/device-model/. 
-
-
-Directory Contents
-~~~~~~~~~~~~~~~~~~
-Each object that is represented in driverfs gets a directory, rather
-than a file, to make it simple to export attributes of that object. 
-Attributes are exported via ASCII text files. The programming
-interface is discussed below. 
-
-Instead of having monolithic files that are difficult to parse, all
-files are intended to export one attribute. The name of the attribute
-is the name of the file. The value of the attribute are the contents
-of the file. 
-
-There should be few, if any, exceptions to this rule. You should not
-violate it, for fear of public humilation.
-
-
-The Two-Tier Model
-~~~~~~~~~~~~~~~~~~
-
-driverfs is a very simple, low-level interface. In order for kernel
-objects to use it, there must be an intermediate layer in place for
-each object type. 
-
-All calls in driverfs are intended to be as type-safe as possible. 
-In order to extend driverfs to support multiple data types, a layer of
-abstraction was required. This intermediate layer converts between the
-generic calls and data structures of the driverfs core to the
-subsystem-specific objects and calls. 
-
-
-The Subsystem Interface
-~~~~~~~~~~~~~~~~~~~~~~~
-
-The subsystems bear the responsibility of implementing driverfs
-extensions for the objects they control. Fortunately, it's intended to
-be really easy to do so. 
-
-It's divided into three sections: directories, files, and operations.
-
-
-Directories
-~~~~~~~~~~~
-
-struct driver_dir_entry {
-        char                    * name;
-        struct dentry           * dentry;
-        mode_t                  mode;
-        struct driverfs_ops     * ops;
-};
-
-
-int
-driverfs_create_dir(struct driver_dir_entry *, struct driver_dir_entry *);
-
-void
-driverfs_remove_dir(struct driver_dir_entry * entry);
-
-The directory structure should be statically allocated, and reside in
-a subsystem-specific data structure:
-
-struct device {
-       ...
-       struct driver_dir_entry	dir;
-};
-
-The subsystem is responsible for initializing the name, mode, and ops
-fields of the directory entry. (More on struct driverfs_ops later)
-
-
-Files
-~~~~~
-
-struct attribute {
-        char                    * name;
-        mode_t                  mode;
-};
-
-
-int
-driverfs_create_file(struct attribute * attr, struct driver_dir_entry * parent);
-
-void
-driverfs_remove_file(struct driver_dir_entry *, const char * name);
-
-
-The attribute structure is a simple, common token that the driverfs
-core handles. It has little use on its own outside of the
-core. Objects cannot use a plain struct attribute to export
-attributes, since there are no callbacks for reading and writing data.
-
-Therefore, the subsystem is required to define a data structure that
-encapsulates the attribute structure, and provides type-safe callbacks
-for reading and writing data.
-
-An example looks like this:
-
-struct device_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device * dev, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
-};
-
-
-Note that there is a struct attribute embedded in the structure. In
-order to relieve pain in declaring attributes, the subsystem should
-also define a macro, like:
-
-#define DEVICE_ATTR(_name,_mode,_show,_store)      \
-struct device_attribute dev_attr_##_name = {            \
-        .attr = {.name  = __stringify(_name) , .mode   = _mode },      \
-        .show   = _show,                                \
-        .store  = _store,                               \
-};
-
-This hides the initialization of the embedded struct, and in general,
-the internals of each structure. It yields a structure by the name of
-dev_attr_<name>.
-
-In order for objects to create files, the subsystem should create
-wrapper functions, like this:
-
-int device_create_file(struct device *device, struct device_attribute * entry);
-void device_remove_file(struct device * dev, struct device_attribute * attr);
-
-..and forward the call on to the driverfs functions.
-
-Note that there is no unique information in the attribute structures,
-so the same structure can be used to describe files of several
-different object instances. 
-
-
-Operations
-~~~~~~~~~~
-
-struct driverfs_ops {
-        int     (*open)(struct driver_dir_entry *);
-        int     (*close)(struct driver_dir_entry *);
-        ssize_t (*show)(struct driver_dir_entry *, struct attribute *,char *, size_t, loff_t);
-        ssize_t (*store)(struct driver_dir_entry *,struct attribute *,const char *, size_t, loff_t);
-};
-
-
-Subsystems are required to implement this set of callbacks. Their
-purpose is to translate the generic data structures into the specific
-objects, and operate on them. This can be done by defining macros like
-this:
-
-#define to_dev_attr(_attr) container_of(_attr,struct device_attribute,attr)
-
-#define to_device(d) container_of(d, struct device, dir)
-
-
-Since the directories are statically allocated in the object, you can
-derive the pointer to the object that owns the file. Ditto for the
-attribute structures. 
-
-Current Interfaces
-~~~~~~~~~~~~~~~~~~
-
-The following interface layers currently exist in driverfs:
-
-
-- devices (include/linux/device.h)
-----------------------------------
-Structure:
-
-struct device_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device * dev, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
-};
-
-Declaring:
-
-DEVICE_ATTR(_name,_str,_mode,_show,_store);
-
-Creation/Removal:
-
-int device_create_file(struct device *device, struct device_attribute * entry);
-void device_remove_file(struct device * dev, struct device_attribute * attr);
-
-
-- bus drivers (include/linux/device.h)
---------------------------------------
-Structure:
-
-struct bus_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct bus_type *, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct bus_type *, const char * buf, size_t count, loff_t off);
-};
-
-Declaring:
-
-BUS_ATTR(_name,_mode,_show,_store)
-
-Creation/Removal:
-
-int bus_create_file(struct bus_type *, struct bus_attribute *);
-void bus_remove_file(struct bus_type *, struct bus_attribute *);
-
-
-- device drivers (include/linux/device.h)
------------------------------------------
-
-Structure:
-
-struct driver_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device_driver *, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct device_driver *, const char * buf, size_t count, loff_t off);
-};
-
-Declaring:
-
-DRIVER_ATTR(_name,_mode,_show,_store)
-
-Creation/Removal:
-
-int driver_create_file(struct device_driver *, struct driver_attribute *);
-void driver_remove_file(struct device_driver *, struct driver_attribute *);
-
-
-Reading/Writing Data
-~~~~~~~~~~~~~~~~~~~~
-The callback functionality is similar to the way procfs works. When a
-user performs a read(2) or write(2) on the file, it first calls a
-driverfs function. This calls to the subsystem, which then calls to
-the object's show() or store() function.
-
-The buffer pointer, offset, and length should be passed to each
-function. The downstream callback should fill the buffer and return
-the number of bytes read/written.
-
-
-What driverfs is not:
-~~~~~~~~~~~~~~~~~~~~~
-It is not a replacement for either devfs or procfs.
-
-It does not handle device nodes, like devfs is intended to do. I think
-this functionality is possible, but indeed think that integration of
-the device nodes and control files should be done. Whether driverfs or
-devfs, or something else, is the place to do it, I don't know.
-
-It is not intended to be a replacement for all of the procfs
-functionality. I think that many of the driver files should be moved
-out of /proc (and maybe a few other things as well ;).
-
-
-
-Limitations:
-~~~~~~~~~~~~
-The driverfs functions assume that at most a page is being either read
-or written each time.
-
-There is a race condition that is really, really hard to fix; if not 
-impossible. There exists a race between a driverfs file being opened
-and the object that owns the file going away. During the driverfs
-open() callback, the reference count for the owning object needs to be
-incremented. 
-
-For drivers, we can put a struct module * owner in struct driver_dir_entry 
-and do try_inc_mod_count() when we open a file. However, this won't
-work for devices, that aren't tied to a module. And, it is still not
-guaranteed to solve the race. 
-
-I'm looking into fixing this, but it may not be doable without making
-a separate filesystem instance for each object. It's fun stuff. Please
-mail me with creative ideas that you know will work. 
-
-
-Possible bugs:
-~~~~~~~~~~~~~~
-It may not deal with offsets and/or seeks very well, especially if
-they cross a page boundary.
-
diff -Nru a/Documentation/filesystems/kfs.txt b/Documentation/filesystems/kfs.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/filesystems/kfs.txt	Mon Oct  7 15:40:18 2002
@@ -0,0 +1,333 @@
+
+kfs - The Kernel Filesystem
+
+Patrick Mochel	<mochel@osdl.org>
+
+2 August 2002
+
+
+What it is:
+~~~~~~~~~~~
+driverfs is a ram-based filesystem intended to export attributes of 
+kernel data structures and the relationships between them. 
+
+kfs provides a unified interface for exporting attributes to
+userspace. Currently, this interface is available only to device and
+bus drivers. 
+
+
+Using kfs
+~~~~~~~~~~~~~~
+kfs is always compiled in. You can access it by doing something like:
+
+    mount -t kfs kfs /devices 
+
+
+Top Level Directory Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+The kfs directory arrangement exposes the relationship of kernel
+data structures. 
+
+The top level kfs diretory looks like:
+
+bus/
+root/
+
+root/ contains a filesystem representation of the device tree. It maps
+directly to the internal kernel device tree, which is a hierarchy of
+struct device. 
+
+bus/ contains flat directory layout of the various bus types in the
+kernel. Each bus's directory contains two subdirectories:
+
+	devices/
+	drivers/
+
+devices/ contains symlinks for each device discovered in the system
+that point to the device's directory under root/.
+
+drivers/ contains a directory for each device driver that is loaded
+for devices on that particular bus (this assmumes that drivers do not
+span multiple bus types).
+
+
+More information can device-model specific features can be found in
+Documentation/device-model/. 
+
+
+Directory Contents
+~~~~~~~~~~~~~~~~~~
+Each object that is represented in kfs gets a directory, rather
+than a file, to make it simple to export attributes of that object. 
+Attributes are exported via ASCII text files. The programming
+interface is discussed below. 
+
+Instead of having monolithic files that are difficult to parse, all
+files are intended to export one attribute. The name of the attribute
+is the name of the file. The value of the attribute are the contents
+of the file. 
+
+There should be few, if any, exceptions to this rule. You should not
+violate it, for fear of public humilation.
+
+
+The Two-Tier Model
+~~~~~~~~~~~~~~~~~~
+
+kfs is a very simple, low-level interface. In order for kernel
+objects to use it, there must be an intermediate layer in place for
+each object type. 
+
+All calls in kfs are intended to be as type-safe as possible. 
+In order to extend kfs to support multiple data types, a layer of
+abstraction was required. This intermediate layer converts between the
+generic calls and data structures of the kfs core to the
+subsystem-specific objects and calls. 
+
+
+The Subsystem Interface
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The subsystems bear the responsibility of implementing kfs
+extensions for the objects they control. Fortunately, it's intended to
+be really easy to do so. 
+
+It's divided into three sections: directories, files, and operations.
+
+
+Directories
+~~~~~~~~~~~
+
+struct driver_dir_entry {
+        char                    * name;
+        struct dentry           * dentry;
+        mode_t                  mode;
+        struct kfs_ops     * ops;
+};
+
+
+int
+kfs_create_dir(struct driver_dir_entry *, struct driver_dir_entry *);
+
+void
+kfs_remove_dir(struct driver_dir_entry * entry);
+
+The directory structure should be statically allocated, and reside in
+a subsystem-specific data structure:
+
+struct device {
+       ...
+       struct driver_dir_entry	dir;
+};
+
+The subsystem is responsible for initializing the name, mode, and ops
+fields of the directory entry. (More on struct kfs_ops later)
+
+
+Files
+~~~~~
+
+struct attribute {
+        char                    * name;
+        mode_t                  mode;
+};
+
+
+int
+kfs_create_file(struct attribute * attr, struct driver_dir_entry * parent);
+
+void
+kfs_remove_file(struct driver_dir_entry *, const char * name);
+
+
+The attribute structure is a simple, common token that the kfs
+core handles. It has little use on its own outside of the
+core. Objects cannot use a plain struct attribute to export
+attributes, since there are no callbacks for reading and writing data.
+
+Therefore, the subsystem is required to define a data structure that
+encapsulates the attribute structure, and provides type-safe callbacks
+for reading and writing data.
+
+An example looks like this:
+
+struct device_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct device * dev, char * buf, size_t count, loff_t off);
+        ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
+};
+
+
+Note that there is a struct attribute embedded in the structure. In
+order to relieve pain in declaring attributes, the subsystem should
+also define a macro, like:
+
+#define DEVICE_ATTR(_name,_mode,_show,_store)      \
+struct device_attribute dev_attr_##_name = {            \
+        .attr = {.name  = __stringify(_name) , .mode   = _mode },      \
+        .show   = _show,                                \
+        .store  = _store,                               \
+};
+
+This hides the initialization of the embedded struct, and in general,
+the internals of each structure. It yields a structure by the name of
+dev_attr_<name>.
+
+In order for objects to create files, the subsystem should create
+wrapper functions, like this:
+
+int device_create_file(struct device *device, struct device_attribute * entry);
+void device_remove_file(struct device * dev, struct device_attribute * attr);
+
+..and forward the call on to the kfs functions.
+
+Note that there is no unique information in the attribute structures,
+so the same structure can be used to describe files of several
+different object instances. 
+
+
+Operations
+~~~~~~~~~~
+
+struct kfs_ops {
+        int     (*open)(struct driver_dir_entry *);
+        int     (*close)(struct driver_dir_entry *);
+        ssize_t (*show)(struct driver_dir_entry *, struct attribute *,char *, size_t, loff_t);
+        ssize_t (*store)(struct driver_dir_entry *,struct attribute *,const char *, size_t, loff_t);
+};
+
+
+Subsystems are required to implement this set of callbacks. Their
+purpose is to translate the generic data structures into the specific
+objects, and operate on them. This can be done by defining macros like
+this:
+
+#define to_dev_attr(_attr) container_of(_attr,struct device_attribute,attr)
+
+#define to_device(d) container_of(d, struct device, dir)
+
+
+Since the directories are statically allocated in the object, you can
+derive the pointer to the object that owns the file. Ditto for the
+attribute structures. 
+
+Current Interfaces
+~~~~~~~~~~~~~~~~~~
+
+The following interface layers currently exist in kfs:
+
+
+- devices (include/linux/device.h)
+----------------------------------
+Structure:
+
+struct device_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct device * dev, char * buf, size_t count, loff_t off);
+        ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
+};
+
+Declaring:
+
+DEVICE_ATTR(_name,_str,_mode,_show,_store);
+
+Creation/Removal:
+
+int device_create_file(struct device *device, struct device_attribute * entry);
+void device_remove_file(struct device * dev, struct device_attribute * attr);
+
+
+- bus drivers (include/linux/device.h)
+--------------------------------------
+Structure:
+
+struct bus_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct bus_type *, char * buf, size_t count, loff_t off);
+        ssize_t (*store)(struct bus_type *, const char * buf, size_t count, loff_t off);
+};
+
+Declaring:
+
+BUS_ATTR(_name,_mode,_show,_store)
+
+Creation/Removal:
+
+int bus_create_file(struct bus_type *, struct bus_attribute *);
+void bus_remove_file(struct bus_type *, struct bus_attribute *);
+
+
+- device drivers (include/linux/device.h)
+-----------------------------------------
+
+Structure:
+
+struct driver_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct device_driver *, char * buf, size_t count, loff_t off);
+        ssize_t (*store)(struct device_driver *, const char * buf, size_t count, loff_t off);
+};
+
+Declaring:
+
+DRIVER_ATTR(_name,_mode,_show,_store)
+
+Creation/Removal:
+
+int driver_create_file(struct device_driver *, struct driver_attribute *);
+void driver_remove_file(struct device_driver *, struct driver_attribute *);
+
+
+Reading/Writing Data
+~~~~~~~~~~~~~~~~~~~~
+The callback functionality is similar to the way procfs works. When a
+user performs a read(2) or write(2) on the file, it first calls a
+kfs function. This calls to the subsystem, which then calls to
+the object's show() or store() function.
+
+The buffer pointer, offset, and length should be passed to each
+function. The downstream callback should fill the buffer and return
+the number of bytes read/written.
+
+
+What kfs is not:
+~~~~~~~~~~~~~~~~~~~~~
+It is not a replacement for either devfs or procfs.
+
+It does not handle device nodes, like devfs is intended to do. I think
+this functionality is possible, but indeed think that integration of
+the device nodes and control files should be done. Whether kfs or
+devfs, or something else, is the place to do it, I don't know.
+
+It is not intended to be a replacement for all of the procfs
+functionality. I think that many of the driver files should be moved
+out of /proc (and maybe a few other things as well ;).
+
+
+
+Limitations:
+~~~~~~~~~~~~
+The kfs functions assume that at most a page is being either read
+or written each time.
+
+There is a race condition that is really, really hard to fix; if not 
+impossible. There exists a race between a kfs file being opened
+and the object that owns the file going away. During the kfs
+open() callback, the reference count for the owning object needs to be
+incremented. 
+
+For drivers, we can put a struct module * owner in struct driver_dir_entry 
+and do try_inc_mod_count() when we open a file. However, this won't
+work for devices, that aren't tied to a module. And, it is still not
+guaranteed to solve the race. 
+
+I'm looking into fixing this, but it may not be doable without making
+a separate filesystem instance for each object. It's fun stuff. Please
+mail me with creative ideas that you know will work. 
+
+
+Possible bugs:
+~~~~~~~~~~~~~~
+It may not deal with offsets and/or seeks very well, especially if
+they cross a page boundary.
+

