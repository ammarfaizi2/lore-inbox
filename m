Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWFUTtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWFUTtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWFUTtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:49:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:59824 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030235AbWFUTtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:14 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>
Subject: [PATCH 2/22] [PATCH] Add kernel<->userspace ABI stability documentation
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:45 -0700
Message-Id: <11509191682051-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191652021-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/ABI/README                |   77 +++++++++++++++++++++++++++++++
 Documentation/ABI/obsolete/devfs        |   13 +++++
 Documentation/ABI/stable/syscalls       |   10 ++++
 Documentation/ABI/stable/sysfs-module   |   30 ++++++++++++
 Documentation/ABI/testing/sysfs-class   |   16 ++++++
 Documentation/ABI/testing/sysfs-devices |   25 ++++++++++
 6 files changed, 171 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/README b/Documentation/ABI/README
new file mode 100644
index 0000000..9feaf16
--- /dev/null
+++ b/Documentation/ABI/README
@@ -0,0 +1,77 @@
+This directory attempts to document the ABI between the Linux kernel and
+userspace, and the relative stability of these interfaces.  Due to the
+everchanging nature of Linux, and the differing maturity levels, these
+interfaces should be used by userspace programs in different ways.
+
+We have four different levels of ABI stability, as shown by the four
+different subdirectories in this location.  Interfaces may change levels
+of stability according to the rules described below.
+
+The different levels of stability are:
+
+  stable/
+	This directory documents the interfaces that the developer has
+	defined to be stable.  Userspace programs are free to use these
+	interfaces with no restrictions, and backward compatibility for
+	them will be guaranteed for at least 2 years.  Most interfaces
+	(like syscalls) are expected to never change and always be
+	available.
+
+  testing/
+	This directory documents interfaces that are felt to be stable,
+	as the main development of this interface has been completed.
+	The interface can be changed to add new features, but the
+	current interface will not break by doing this, unless grave
+	errors or security problems are found in them.  Userspace
+	programs can start to rely on these interfaces, but they must be
+	aware of changes that can occur before these interfaces move to
+	be marked stable.  Programs that use these interfaces are
+	strongly encouraged to add their name to the description of
+	these interfaces, so that the kernel developers can easily
+	notify them if any changes occur (see the description of the
+	layout of the files below for details on how to do this.)
+
+  obsolete/
+  	This directory documents interfaces that are still remaining in
+	the kernel, but are marked to be removed at some later point in
+	time.  The description of the interface will document the reason
+	why it is obsolete and when it can be expected to be removed.
+	The file Documentation/feature-removal-schedule.txt may describe
+	some of these interfaces, giving a schedule for when they will
+	be removed.
+
+  removed/
+	This directory contains a list of the old interfaces that have
+	been removed from the kernel.
+
+Every file in these directories will contain the following information:
+
+What:		Short description of the interface
+Date:		Date created
+KernelVersion:	Kernel version this feature first showed up in.
+Contact:	Primary contact for this interface (may be a mailing list)
+Description:	Long description of the interface and how to use it.
+Users:		All users of this interface who wish to be notified when
+		it changes.  This is very important for interfaces in
+		the "testing" stage, so that kernel developers can work
+		with userspace developers to ensure that things do not
+		break in ways that are unacceptable.  It is also
+		important to get feedback for these interfaces to make
+		sure they are working in a proper way and do not need to
+		be changed further.
+
+
+How things move between levels:
+
+Interfaces in stable may move to obsolete, as long as the proper
+notification is given.
+
+Interfaces may be removed from obsolete and the kernel as long as the
+documented amount of time has gone by.
+
+Interfaces in the testing state can move to the stable state when the
+developers feel they are finished.  They cannot be removed from the
+kernel tree without going through the obsolete state first.
+
+It's up to the developer to place their interfaces in the category they
+wish for it to start out in.
diff --git a/Documentation/ABI/obsolete/devfs b/Documentation/ABI/obsolete/devfs
new file mode 100644
index 0000000..b8b8739
--- /dev/null
+++ b/Documentation/ABI/obsolete/devfs
@@ -0,0 +1,13 @@
+What:		devfs
+Date:		July 2005
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+	devfs has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
+	along with the the assorted devfs function calls throughout the
+	kernel tree.
+
+Users:
+
diff --git a/Documentation/ABI/stable/syscalls b/Documentation/ABI/stable/syscalls
new file mode 100644
index 0000000..c3ae3e7
--- /dev/null
+++ b/Documentation/ABI/stable/syscalls
@@ -0,0 +1,10 @@
+What:		The kernel syscall interface
+Description:
+	This interface matches much of the POSIX interface and is based
+	on it and other Unix based interfaces.  It will only be added to
+	over time, and not have things removed from it.
+
+	Note that this interface is different for every architecture
+	that Linux supports.  Please see the architecture-specific
+	documentation for details on the syscall numbers that are to be
+	mapped to each syscall.
diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
new file mode 100644
index 0000000..75be431
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-module
@@ -0,0 +1,30 @@
+What:		/sys/module
+Description:
+	The /sys/module tree consists of the following structure:
+
+	/sys/module/MODULENAME
+		The name of the module that is in the kernel.  This
+		module name will show up either if the module is built
+		directly into the kernel, or if it is loaded as a
+		dyanmic module.
+
+	/sys/module/MODULENAME/parameters
+		This directory contains individual files that are each
+		individual parameters of the module that are able to be
+		changed at runtime.  See the individual module
+		documentation as to the contents of these parameters and
+		what they accomplish.
+
+		Note: The individual parameter names and values are not
+		considered stable, only the fact that they will be
+		placed in this location within sysfs.  See the
+		individual driver documentation for details as to the
+		stability of the different parameters.
+
+	/sys/module/MODULENAME/refcnt
+		If the module is able to be unloaded from the kernel, this file
+		will contain the current reference count of the module.
+
+		Note: If the module is built into the kernel, or if the
+		CONFIG_MODULE_UNLOAD kernel configuration value is not enabled,
+		this file will not be present.
diff --git a/Documentation/ABI/testing/sysfs-class b/Documentation/ABI/testing/sysfs-class
new file mode 100644
index 0000000..4b0cb89
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class
@@ -0,0 +1,16 @@
+What:		/sys/class/
+Date:		Febuary 2006
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+		The /sys/class directory will consist of a group of
+		subdirectories describing individual classes of devices
+		in the kernel.  The individual directories will consist
+		of either subdirectories, or symlinks to other
+		directories.
+
+		All programs that use this directory tree must be able
+		to handle both subdirectories or symlinks in order to
+		work properly.
+
+Users:
+	udev <linux-hotplug-devel@lists.sourceforge.net>
diff --git a/Documentation/ABI/testing/sysfs-devices b/Documentation/ABI/testing/sysfs-devices
new file mode 100644
index 0000000..6a25671
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices
@@ -0,0 +1,25 @@
+What:		/sys/devices
+Date:		February 2006
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+		The /sys/devices tree contains a snapshot of the
+		internal state of the kernel device tree.  Devices will
+		be added and removed dynamically as the machine runs,
+		and between different kernel versions, the layout of the
+		devices within this tree will change.
+
+		Please do not rely on the format of this tree because of
+		this.  If a program wishes to find different things in
+		the tree, please use the /sys/class structure and rely
+		on the symlinks there to point to the proper location
+		within the /sys/devices tree of the individual devices.
+		Or rely on the uevent messages to notify programs of
+		devices being added and removed from this tree to find
+		the location of those devices.
+
+		Note that sometimes not all devices along the directory
+		chain will have emitted uevent messages, so userspace
+		programs must be able to handle such occurrences.
+
+Users:
+	udev <linux-hotplug-devel@lists.sourceforge.net>
-- 
1.4.0

