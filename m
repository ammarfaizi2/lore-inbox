Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbTABTUR>; Thu, 2 Jan 2003 14:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbTABTUR>; Thu, 2 Jan 2003 14:20:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:24589 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266384AbTABTUP>;
	Thu, 2 Jan 2003 14:20:15 -0500
Date: Thu, 2 Jan 2003 20:27:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Documentation/modules.txt
Message-ID: <20030102192751.GA18197@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small update to modules.txt to reflect preferred way to compile modules,
and a bit more about installing them.
I did not know enough about modules to update the whole file...

Well, I deleted the note, that looked too old.

	Sam

===== Documentation/modules.txt 1.3 vs edited =====
--- 1.3/Documentation/modules.txt	Fri Dec 27 11:55:36 2002
+++ edited/Documentation/modules.txt	Thu Jan  2 20:26:03 2003
@@ -9,20 +9,13 @@
 that the kernel now supports.  The current required version is listed
 in the file linux/Documentation/Changes.
 
-* * * NOTE * * *
-The kernel has been changed to remove kerneld support and use
-the new kmod support.  Keep this in mind when reading this file.  Kmod
-does the exact same thing as kerneld, but doesn't require an external
-program (see Documentation/kmod.txt)
-
 In the beginning...
 -------------------
 
 Anyway, your first step is to compile the kernel, as explained in the
 file linux/README.  It generally goes like:
 
-	make config
-	make dep
+	make *config <= usually menuconfig or xconfig
 	make clean
 	make zImage or make zlilo
 
@@ -39,15 +32,16 @@
 	plus those things that you just can't live without...
 
 The set of modules is constantly increasing, and you will be able to select
-the option "m" in "make config" for those features that the current kernel
+the option "m" in "make menuconfig" for those features that the current kernel
 can offer as loadable modules.
 
 You also have a possibility to create modules that are less dependent on
-the kernel version.  This option can be selected during "make config", by
+the kernel version.  This option can be selected during "make *config", by
 enabling CONFIG_MODVERSIONS, and is most useful on "stable" kernel versions,
-such as the kernels from the 1.2 and 2.0 series.
+such as the kernels from the 2.<even number> series.
 If you have modules that are based on sources that are not included in
 the official kernel sources, you will certainly like this option...
+See below how to compile modules outside the official kernel.
 
 Here is a sample of the available modules included in the kernel sources:
 
@@ -83,22 +77,45 @@
 
 	make modules
 
-This will compile all modules and update the linux/modules directory.
-In this directory you will then find a bunch of symbolic links,
-pointing to the various object files in the kernel tree.
+This will compile all modules. A module is identified by the
+extension .ko, for kernel object.
 Now, after you have created all your modules, you should also do:
 
 	make modules_install
 
 This will copy all newly made modules into subdirectories under
 "/lib/modules/kernel_release/", where "kernel_release" is something
-like 2.0.1, or whatever the current kernel version is...
+like 2.5.54, or whatever the current kernel version is.
+Note: Installing modules may require root privileges.
 
 As soon as you have rebooted the newly made kernel, you can install
 and remove modules at will with the utilities: "insmod" and "rmmod".
 After reading the man-page for insmod, you will also know how easy
 it is to configure a module when you do "insmod" (hint: symbol=value).
 
+Installing modules in a non-standard location
+---------------------------------------------
+When the modules needs to be installed under another directory
+the INSTALL_MOD_PATH can be used to prefix "/lib/modules" as seen
+in the following example:
+
+make INSTALL_MOD_PATH=/frodo modules_install
+
+This will install the modules in the directory /frodo/lib/modules.
+/frodo can be a NFS mounted filesystem on another machine, allowing
+out-of-the-box support for installation on remote machines.
+
+
+Compiling modules outside the official kernel
+---------------------------------------------
+Often modules are developed outside the official kernel.
+To keep up with changes in the build system the most portable way
+to compile a module outside the kernel is to use the following command-line:
+
+make -C path/to/kernel/src SUBDIRS=$PWD modules
+
+This requires that a makefile exits made in accordance to
+Documentation/kbuild/makefiles.txt.
 
 Nifty features:
 ---------------
