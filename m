Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSL0T5W>; Fri, 27 Dec 2002 14:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSL0T5W>; Fri, 27 Dec 2002 14:57:22 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:65284 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S265114AbSL0T5T>;
	Fri, 27 Dec 2002 14:57:19 -0500
Date: Fri, 27 Dec 2002 12:01:51 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: [PATCH] [TINY] Documentation/Changes for modules
Message-ID: <20021227200151.GA3469@net-ronin.org>
References: <20021220194900.GA19672@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220194900.GA19672@net-ronin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whups, looks like i had a small error in the last patch.  the url for
module-init-tools has been fixed, and all the references to modutils
(outside source) has been updated if necessary.

more patches to follow to fix up the modules.conf/conf.modules vs.
modprobe.conf references.

thanks to jlnance for pointing out the err in my last patch.

-- DN
Daniel

--- ./Documentation/Changes.orig	Thu Dec 26 18:24:33 2002
+++ ./Documentation/Changes	Fri Dec 27 11:07:57 2002
@@ -52,7 +52,7 @@
 o  Gnu make               3.78                    # make --version
 o  binutils               2.9.5.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  modutils               2.4.2                   # insmod -V
+o  module-init-tools      0.9                     # rmmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.0.14                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
@@ -141,14 +141,11 @@
 version of ksymoops to decode the report; see REPORTING-BUGS in the
 root of the Linux source for more information.
 
-Modutils
+Module-Init-Tools
 --------
 
-Upgrade to recent modutils to fix various outstanding bugs which are
-seen more frequently under 2.4.x, and to enable auto-loading of USB
-modules.  In addition, the layout of modules under
-/lib/modules/`uname -r`/ has been made more sane.  This change also
-requires that you upgrade to a recent modutils.
+A new module loader is now in the kernel that requires module-init-tools
+to use.  It is backward compatible with the 2.4.x series kernels.
 
 Mkinitrd
 --------
@@ -306,7 +303,7 @@
 
 Modutils
 --------
-o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/>
+o  <ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/>
 
 Mkinitrd
 --------
--- ./Documentation/kbuild/makefiles.txt.orig	Thu Dec 26 16:03:56 2002
+++ ./Documentation/kbuild/makefiles.txt	Fri Dec 27 10:54:09 2002
@@ -213,7 +213,7 @@
 
 	$(GENKSYMS) contains the command used to generate kernel symbol
 	signatures when CONFIG_MODVERSIONS is enabled.	The genksyms
-	command comes from the modutils package.
+	command comes from the module-init-tools package.
 
     CROSS_COMPILE
 
--- ./Documentation/modules.txt.orig	Thu Dec 26 16:03:55 2002
+++ ./Documentation/modules.txt	Fri Dec 27 10:55:36 2002
@@ -3,12 +3,11 @@
 the internals of module, but mostly a sample of how to compile
 and use modules.
 
-Note: You should ensure that the modutils-X.Y.Z.tar.gz you are using
-is the most up to date one for this kernel. The "X.Y.Z" will reflect
-the kernel version at the time of the release of the modules package.
-Some older modules packages aren't aware of some of the newer modular
-features that the kernel now supports.  The current required version
-is listed in the file linux/Documentation/Changes.
+Note: You should ensure that the module-init-tools-X.Y.Z.tar.gz you
+are using is the most up to date one for this kernel.  Some older
+modules packages aren't aware of some of the newer modular features
+that the kernel now supports.  The current required version is listed
+in the file linux/Documentation/Changes.
 
 * * * NOTE * * *
 The kernel has been changed to remove kerneld support and use
@@ -124,7 +123,8 @@
 
 To use modprobe successfully, you generally place the following
 command in your /etc/rc.d/rc.S script.  (Read more about this in the
-"rc.hints" file in the module utilities package, "modutils-x.y.z.tar.gz".)
+"rc.hints" file in the module utilities package,
+"module-init-tools-x.y.z.tar.gz".)
 
 	/sbin/depmod -a
 
--- ./Documentation/networking/z8530drv.txt.orig	Thu Dec 26 16:03:56 2002
+++ ./Documentation/networking/z8530drv.txt	Fri Dec 27 10:56:14 2002
@@ -54,7 +54,7 @@
 
 	insmod scc.o
 
-please read 'man insmod' that comes with modutils.
+please read 'man insmod' that comes with module-init-tools.
 
 You should include the insmod in one of the /etc/rc.d/rc.* files,
 and don't forget to insert a call of sccinit after that. It
--- ./Documentation/sound/oss/Introduction.orig	Thu Dec 26 16:03:56 2002
+++ ./Documentation/sound/oss/Introduction	Fri Dec 27 10:57:58 2002
@@ -119,9 +119,9 @@
 
 6.  Make the modules and install them (make modules; make modules_install).
 
-Note, for 2.4.x kernels, make sure you have the newer modutils 
-loaded or modules will not be loaded properly.  2.4.x changed the 
-layout of /lib/modules/2.4.x and requires an updated modutils.
+Note, for 2.5.x kernels, make sure you have the newer module-init-tools 
+installed or modules will not be loaded properly.  2.5.x requires an
+updated module-init-tools.
 
 
 Plug and Play (PnP:
--- ./Documentation/sysctl/kernel.txt.orig	Thu Dec 26 16:03:56 2002
+++ ./Documentation/sysctl/kernel.txt	Fri Dec 27 10:58:58 2002
@@ -286,9 +286,9 @@
 
   1 - A module with a non-GPL license has been loaded, this
       includes modules with no license.
-      Set by modutils >= 2.4.9.
+      Set by modutils >= 2.4.9 and module-init-tools.
   2 - A module was force loaded by insmod -f.
-      Set by modutils >= 2.4.9.
+      Set by modutils >= 2.4.9 and module-init-tools.
   4 - Unsafe SMP processors: SMP with CPUs not designed for SMP.
 
 ==============================================================
--- ./Documentation/usb/hotplug.txt.orig	Thu Dec 26 16:03:56 2002
+++ ./Documentation/usb/hotplug.txt	Fri Dec 27 11:00:19 2002
@@ -5,8 +5,8 @@
 immediately usable.  That means the system must do many things, including:
 
     - Find a driver that can handle the device.  That may involve
-      loading a kernel module; newer drivers can use modutils to
-      publish their device (and class) support to user utilities.
+      loading a kernel module; newer drivers can use module-init-tools
+      to publish their device (and class) support to user utilities.
 
     - Bind a driver to that device.  Bus frameworks do that using a
       device driver's probe() routine.
@@ -76,15 +76,15 @@
 
 Currently available policy agent implementations can load drivers for
 modules, and can invoke driver-specific setup scripts.  The newest ones
-leverage USB modutils support.  Later agents might unload drivers.
+leverage USB module-init-tools support.  Later agents might unload drivers.
 
 
 USB MODUTILS SUPPORT
 
-Current versions of modutils will create a "modules.usbmap" file which
-contains the entries from each driver's MODULE_DEVICE_TABLE.  Such files
-can be used by various user mode policy agents to make sure all the right
-driver modules get loaded, either at boot time or later. 
+Current versions of module-init-tools will create a "modules.usbmap" file
+which contains the entries from each driver's MODULE_DEVICE_TABLE.  Such
+files can be used by various user mode policy agents to make sure all the
+right driver modules get loaded, either at boot time or later. 
 
 See <linux/usb.h> for full information about such table entries; or look
 at existing drivers.  Each table entry describes one or more criteria to
--- ./Documentation/video4linux/README.cpia.orig	Thu Dec 26 16:03:56 2002
+++ ./Documentation/video4linux/README.cpia	Fri Dec 27 11:01:37 2002
@@ -51,9 +51,9 @@
 CONFIG_VIDEO_CPIA=m
 CONFIG_VIDEO_CPIA_PP=m
 
-For autoloading of all those modules you need to tell modutils some
-stuff. Add the following line to your modutils config-file
-(e.g. /etc/modules.conf or wherever your distribution does store that
+For autoloading of all those modules you need to tell module-init-tools
+some stuff. Add the following line to your module-init-tools config-file
+(e.g. /etc/modprobe.conf or wherever your distribution does store that
 stuff):
 
 options parport_pc io=0x378 irq=7 dma=3
--- ./scripts/ver_linux.orig	Thu Dec 26 16:04:45 2002
+++ ./scripts/ver_linux	Fri Dec 27 11:07:13 2002
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-insmod -V  2>&1 | awk 'NR==1 {print "modutils              ",$NF}'
+rmmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
