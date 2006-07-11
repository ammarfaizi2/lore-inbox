Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWGKPZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWGKPZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWGKPZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:25:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750934AbWGKPZs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:25:48 -0400
Date: Tue, 11 Jul 2006 17:25:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove mentionings of devfs in documentation
Message-ID: <20060711152546.GV13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that devfs is removed, there's no longer any need to document how to 
do this or that with devfs.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/ABI/obsolete/devfs                |   13 ---
 Documentation/DocBook/usb.tmpl                  |    3 
 Documentation/DocBook/writing_usb_driver.tmpl   |    7 -
 Documentation/arm/SA1100/serial_UART            |    4 
 Documentation/computone.txt                     |   67 ----------------
 Documentation/feature-list-2.6.txt              |   10 --
 Documentation/filesystems/00-INDEX              |    2 
 Documentation/filesystems/tmpfs.txt             |    2 
 Documentation/input/input.txt                   |    4 
 Documentation/input/joystick.txt                |    2 
 Documentation/ioctl-mess.txt                    |   17 ----
 Documentation/kernel-docs.txt                   |   11 --
 Documentation/s390/3270.txt                     |    4 
 Documentation/scsi/osst.txt                     |    3 
 Documentation/sound/alsa/ALSA-Configuration.txt |   20 ----
 Documentation/uml/UserModeLinux-HOWTO.txt       |   54 ------------
 Documentation/usb/acm.txt                       |   14 ---
 Documentation/usb/usb-serial.txt                |    5 -
 drivers/block/Kconfig                           |    3 
 drivers/char/mwave/README                       |    5 -
 drivers/media/radio/Kconfig                     |    3 
 drivers/media/video/pwc/philips.txt             |    4 
 drivers/sbus/char/cpwatchdog.c                  |    2 
 23 files changed, 19 insertions(+), 240 deletions(-)

--- linux-2.6.18-rc1-mm1-full/Documentation/DocBook/usb.tmpl.old	2006-07-11 17:04:32.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/DocBook/usb.tmpl	2006-07-11 17:04:39.000000000 +0200
@@ -323,9 +323,6 @@
 	Until relatively recently it was often (confusingly) called
 	<emphasis>usbdevfs</emphasis> although it wasn't solving what
 	<emphasis>devfs</emphasis> was.
-	Every USB device will appear in usbfs, regardless of whether or
-	not it has a kernel driver; but only devices with kernel drivers
-	show up in devfs.
 	</para>
 
 	<sect1>
--- linux-2.6.18-rc1-mm1-full/Documentation/DocBook/writing_usb_driver.tmpl.old	2006-07-11 17:06:35.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/DocBook/writing_usb_driver.tmpl	2006-07-11 17:06:48.000000000 +0200
@@ -224,13 +224,8 @@
      Conversely, when the device is removed from the USB bus, the disconnect
      function is called with the device pointer. The driver needs to clean any
      private data that has been allocated at this time and to shut down any
-     pending urbs that are in the USB system. The driver also unregisters
-     itself from the devfs subsystem with the call:
+     pending urbs that are in the USB system.
   </para>
-  <programlisting>
-/* remove our devfs node */
-devfs_unregister(skel->devfs);
-  </programlisting>
   <para>
      Now that the device is plugged into the system and the driver is bound to
      the device, any of the functions in the file_operations structure that
--- linux-2.6.18-rc1-mm1-full/Documentation/arm/SA1100/serial_UART.old	2006-07-11 17:07:32.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/arm/SA1100/serial_UART	2006-07-11 17:07:45.000000000 +0200
@@ -24,8 +24,8 @@
 >                   7 = /dev/cusa2                Callout device for ttySA2
 >
 
-If you're not using devfs, you must create those inodes in /dev
-on the root filesystem used by your SA1100-based device:
+You must create those inodes in /dev on the root filesystem used
+by your SA1100-based device:
 
 	mknod ttySA0 c 204 5
 	mknod ttySA1 c 204 6
--- linux-2.6.18-rc1-mm1-full/Documentation/computone.txt.old	2006-07-11 17:07:52.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/computone.txt	2006-07-11 17:08:38.000000000 +0200
@@ -199,30 +199,6 @@
 Linux tty naming conventions: ttyF0 - ttyF255 for normal devices, and
 cuf0 - cuf255 for callout devices.
 
-If you are using devfs, existing devices are automatically created within
-the devfs name space.  Normal devices will be tts/F0 - tts/F255 and callout
-devices will be cua/F0 - cua/F255.  With devfs installed, ip2mkdev will
-create symbolic links in /dev from the old conventional names to the newer
-devfs names as follows:
-
-	/dev/ip2ipl[n]	-> /dev/ip2/ipl[n]	n = 0 - 3
-	/dev/ip2stat[n]	-> /dev/ip2/stat[n]	n = 0 - 3
-	/dev/ttyF[n]	-> /dev/tts/F[n]	n = 0 - 255
-	/dev/cuf[n]	-> /dev/cua/F[n]	n = 0 - 255
-
-Only devices for existing ports and boards will be created.
-
-IMPORTANT NOTE:  The naming convention used for devfs by this driver
-was changed from 1.2.12 to 1.2.13.  The old naming convention was to
-use ttf/%d for the tty device and cuf/%d for the cua device.  That
-has been changed to conform to an agreed-upon standard of placing
-all the tty devices under tts.  The device names are now tts/F%d for
-the tty device and cua/F%d for the cua devices.  If you were using
-the older devfs names, you must update for the newer convention.
-
-You do not need to run ip2mkdev if you are using devfs and only want to
-use the devfs native device names.
-
 
 4. USING THE DRIVERS
 
@@ -260,53 +236,14 @@
 use the devfs native device names.
 
 
-6. DEVFS
-
-DEVFS is the DEVice File System available as an add on package for the
-2.2.x kernels and available as a configuration option in 2.3.46 and higher.
-Devfs allows for the automatic creation and management of device names
-under control of the device drivers themselves.  The Devfs namespace is
-hierarchical and reduces the clutter present in the normal flat /dev
-namespace.  Devfs names and conventional device names may be intermixed.
-A userspace daemon, devfsd, exists to allow for automatic creation and
-management of symbolic links from the devfs name space to the conventional
-names.  More details on devfs can be found on the DEVFS home site at
-<http://www.atnf.csiro.au/~rgooch/linux/> or in the file kernel
-documentation files, .../linux/Documentation/filesystems/devfs/README.
-
-If you are using devfs, existing devices are automatically created within
-the devfs name space.  Normal devices will be tts/F0 - tts/F255 and callout
-devices will be cua/F0 - cua/F255.  With devfs installed, ip2mkdev will
-create symbolic links in /dev from the old conventional names to the newer
-devfs names as follows:
-
-	/dev/ip2ipl[n]	-> /dev/ip2/ipl[n]	n = 0 - 3
-	/dev/ip2stat[n]	-> /dev/ip2/stat[n]	n = 0 - 3
-	/dev/ttyF[n]	-> /dev/tts/F[n]	n = 0 - 255
-	/dev/cuf[n]	-> /dev/cua/F[n]	n = 0 - 255
-
-Only devices for existing ports and boards will be created.
-
-IMPORTANT NOTE:  The naming convention used for devfs by this driver
-was changed from 1.2.12 to 1.2.13.  The old naming convention was to
-use ttf/%d for the tty device and cuf/%d for the cua device.  That
-has been changed to conform to an agreed-upon standard of placing
-all the tty devices under tts.  The device names are now tts/F%d for
-the tty device and cua/F%d for the cua devices.  If you were using
-the older devfs names, you must update for the newer convention.
-
-You do not need to run ip2mkdev if you are using devfs and only want to
-use the devfs native device names.
- 
-
-7. NOTES
+6. NOTES
 
 This is a release version of the driver, but it is impossible to test it
 in all configurations of Linux. If there is any anomalous behaviour that 
 does not match the standard serial port's behaviour please let us know.
 
 
-8. ip2mkdev shell script
+7. ip2mkdev shell script
 
 Previously, this script was simply attached here.  It is now attached as a
 shar archive to make it easier to extract the script from the documentation.
--- linux-2.6.18-rc1-mm1-full/Documentation/filesystems/00-INDEX.old	2006-07-11 17:08:52.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/filesystems/00-INDEX	2006-07-11 17:08:56.000000000 +0200
@@ -26,8 +26,6 @@
 	- info on the cram filesystem for small storage (ROMs etc).
 dentry-locking.txt
 	- info on the RCU-based dcache locking model.
-devfs/
-	- directory containing devfs documentation.
 directory-locking
 	- info about the locking scheme used for directory operations.
 dlmfs.txt
--- linux-2.6.18-rc1-mm1-full/Documentation/filesystems/tmpfs.txt.old	2006-07-11 17:09:04.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/filesystems/tmpfs.txt	2006-07-11 17:09:14.000000000 +0200
@@ -39,7 +39,7 @@
 	tmpfs	/dev/shm	tmpfs	defaults	0 0
 
    Remember to create the directory that you intend to mount tmpfs on
-   if necessary (/dev/shm is automagically created if you use devfs).
+   if necessary.
 
    This mount is _not_ needed for SYSV shared memory. The internal
    mount is used for that. (In the 2.3 kernel versions it was
--- linux-2.6.18-rc1-mm1-full/Documentation/input/input.txt.old	2006-07-11 17:09:21.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/input/input.txt	2006-07-11 17:09:36.000000000 +0200
@@ -68,8 +68,8 @@
 
 	crw-r--r--   1 root     root      13,  63 Mar 28 22:45 mice
 
-  This device has to be created, unless you use devfs, in which case it's
-created automatically. The commands to do create it by hand are:
+  This device has to be created.
+  The commands to do create it by hand are:
 
 	cd /dev
 	mkdir input
--- linux-2.6.18-rc1-mm1-full/Documentation/input/joystick.txt.old	2006-07-11 17:09:43.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/input/joystick.txt	2006-07-11 17:09:58.000000000 +0200
@@ -61,7 +61,7 @@
 
 2.2 Device nodes
 ~~~~~~~~~~~~~~~~
-For applications to be able to use the joysticks, in you don't use devfs,
+For applications to be able to use the joysticks,
 you'll have to manually create these nodes in /dev:
 
 cd /dev
--- linux-2.6.18-rc1-mm1-full/Documentation/kernel-docs.txt.old	2006-07-11 17:10:10.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/kernel-docs.txt	2006-07-11 17:10:20.000000000 +0200
@@ -290,17 +290,6 @@
        Description: Very nice 92 pages GPL book on the topic of modules
        programming. Lots of examples.
        
-     * Title: "Device File System (devfs) Overview"
-       Author: Richard Gooch.
-       URL: http://www.atnf.csiro.au/people/rgooch/linux/docs/devfs.html
-       Keywords: filesystem, /dev, devfs, dynamic devices, major/minor
-       allocation, device management.
-       Description: Document describing Richard Gooch's controversial
-       devfs, which allows for dynamic devices, only shows present
-       devices in /dev, gets rid of major/minor numbers allocation
-       problems, and allows for hundreds of identical devices (which some
-       USB systems might demand soon).
-       
      * Title: "I/O Event Handling Under Linux"
        Author: Richard Gooch.
        URL: http://www.atnf.csiro.au/~rgooch/linux/docs/io-events.html
--- linux-2.6.18-rc1-mm1-full/Documentation/s390/3270.txt.old	2006-07-11 17:10:36.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/s390/3270.txt	2006-07-11 17:10:49.000000000 +0200
@@ -111,9 +111,7 @@
 	config3270.sh.	Inspect the output script it produces,
 	/tmp/mkdev3270, and then run that script.  This will create the
 	necessary character special device files and make the necessary
-	changes to /etc/inittab.  If you have selected DEVFS, the driver
-	itself creates the device files, and /tmp/mkdev3270 only changes
-	/etc/inittab.
+	changes to /etc/inittab.
 
 	Then notify /sbin/init that /etc/inittab has changed, by issuing
 	the telinit command with the q operand:
--- linux-2.6.18-rc1-mm1-full/Documentation/scsi/osst.txt.old	2006-07-11 17:10:58.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/scsi/osst.txt	2006-07-11 17:11:07.000000000 +0200
@@ -56,8 +56,7 @@
 
 Now, your osst driver is inside the kernel or available as a module,
 depending on your choice during kernel config. You may still need to create
-the device nodes by calling the Makedevs.sh script (see below) manually,
-unless you use a devfs kernel, where this won't be needed.
+the device nodes by calling the Makedevs.sh script (see below) manually.
 
 To load your module, you may use the command 
 modprobe osst
--- linux-2.6.18-rc1-mm1-full/Documentation/sound/alsa/ALSA-Configuration.txt.old	2006-07-11 17:11:17.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-11 17:13:11.000000000 +0200
@@ -57,11 +57,6 @@
 		- Default: 1
 		- For auto-loading more than one card, specify this
 		  option together with snd-card-X aliases.
-    device_mode
-		- permission mask for dynamic sound device filesystem
-		- This is available only when DEVFS is enabled
-		- Default: 0666
-		- E.g.: device_mode=0660
 
   
   Module snd-pcm-oss
@@ -1881,21 +1876,6 @@
 options of snd-pcm-oss module.
 
 
-DEVFS support
-=============
-
-The ALSA driver fully supports the devfs extension.
-You should add lines below to your devfsd.conf file:
-
-LOOKUP snd MODLOAD ACTION snd
-REGISTER ^sound/.* PERMISSIONS root.audio 660
-REGISTER ^snd/.* PERMISSIONS root.audio 660
-
-Warning: These lines assume that you have the audio group in your system.
-         Otherwise replace audio word with another group name (root for
-         example).
-
-
 Proc interfaces (/proc/asound)
 ==============================
 
--- linux-2.6.18-rc1-mm1-full/Documentation/uml/UserModeLinux-HOWTO.txt.old	2006-07-11 17:13:44.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-11 17:16:54.000000000 +0200
@@ -157,7 +157,7 @@
   13. What to do when UML doesn't work
 
      13.1 Strange compilation errors when you build from source
-     13.2 UML hangs on boot after mounting devfs
+     13.2 (obsolete)
      13.3 A variety of panics and hangs with /tmp on a reiserfs  filesystem
      13.4 The compile fails with errors about conflicting types for 'open', 'dup', and 'waitpid'
      13.5 UML doesn't work when /tmp is an NFS filesystem
@@ -379,31 +379,6 @@
   bug fixes and enhancements that have gone into subsequent releases.
 
 
-  If you build your own kernel, and want to boot it from one of the
-  filesystems distributed from this site, then, in nearly all cases,
-  devfs must be compiled into the kernel and mounted at boot time.  The
-  exception is the SuSE filesystem.  For this, devfs must either not be
-  in the kernel at all, or "devfs=nomount" must be on the kernel command
-  line.  Any disagreement between the kernel and the filesystem being
-  booted about whether devfs is being used will result in the boot
-  getting no further than single-user mode.
-
-
-  If you don't want to use devfs, you can remove the need for it from a
-  filesystem by copying /dev from someplace, making a bunch of /dev/ubd
-  devices:
-
-
-  UML# for i in 0 1 2 3 4 5 6 7; do mknod ubd$i b 98 $i; done
-
-
-
-
-  and changing /etc/fstab and /etc/inittab to refer to the non-devfs
-  devices.
-
-
-
   22..22..  CCoommppiilliinngg aanndd iinnssttaalllliinngg kkeerrnneell mmoodduulleess
 
   UML modules are built in the same way as the native kernel (with the
@@ -839,9 +814,7 @@
   +o  None - device=none
 
 
-     This causes the device to disappear.  If you are using devfs, the
-     device will not appear in /dev.  If not, then attempts to open it
-     will return -ENODEV.
+     This causes the device to disappear.
 
 
 
@@ -3898,29 +3871,6 @@
 
 
 
-  1133..22..  UUMMLL hhaannggss oonn bboooott aafftteerr mmoouunnttiinngg ddeevvffss
-
-  The boot looks like this:
-
-
-       VFS: Mounted root (ext2 filesystem) readonly.
-       Mounted devfs on /dev
-
-
-
-
-  You're probably running a recent distribution on an old machine.  I
-  saw this with the RH7.1 filesystem running on a Pentium.  The shared
-  library loader, ld.so, was executing an instruction (cmove) which the
-  Pentium didn't support.  That instruction was apparently added later.
-  If you run UML under the debugger, you'll see the hang caused by one
-  instruction causing an infinite SIGILL stream.
-
-
-  The fix is to boot UML on an older filesystem.
-
-
-
   1133..33..  AA vvaarriieettyy ooff ppaanniiccss aanndd hhaannggss wwiitthh //ttmmpp oonn aa rreeiisseerrffss  ffiilleessyyss--
   tteemm
 
--- linux-2.6.18-rc1-mm1-full/Documentation/usb/acm.txt.old	2006-07-11 17:17:08.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/usb/acm.txt	2006-07-11 17:17:27.000000000 +0200
@@ -49,20 +49,6 @@
   Unfortunately many modems and most ISDN TAs use proprietary interfaces and
 thus won't work with this drivers. Check for ACM compliance before buying.
 
-  The driver (with devfs) creates these devices in /dev/usb/acm:
-
-	crw-r--r--   1 root     root     166,   0 Apr  1 10:49 0
-	crw-r--r--   1 root     root     166,   1 Apr  1 10:49 1
-	crw-r--r--   1 root     root     166,   2 Apr  1 10:49 2
-
-  And so on, up to 31, with the limit being possible to change in acm.c to up
-to 256, so you can use up to 256 USB modems with one computer (you'll need
-three USB cards for that, though).
-
-  If you don't use devfs, then you can create device nodes with the same
-minor/major numbers anywhere you want, but either the above location or
-/dev/usb/ttyACM0 is preferred.
-
   To use the modems you need these modules loaded:
 
 	usbcore.ko
--- linux-2.6.18-rc1-mm1-full/Documentation/usb/usb-serial.txt.old	2006-07-11 17:17:45.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/usb/usb-serial.txt	2006-07-11 17:17:57.000000000 +0200
@@ -13,7 +13,6 @@
   Currently the driver can handle up to 256 different serial interfaces at
   one time. 
 
-  If you are not using devfs:
     The major number that the driver uses is 188 so to use the driver,
     create the following nodes:
 	mknod /dev/ttyUSB0 c 188 0
@@ -26,10 +25,6 @@
 	mknod /dev/ttyUSB254 c 188 254
 	mknod /dev/ttyUSB255 c 188 255
 
-  If you are using devfs:
-    The devices supported by this driver will show up as
-    /dev/usb/tts/{0,1,...}
-
   When the device is connected and recognized by the driver, the driver
   will print to the system log, which node(s) the device has been bound
   to.
--- linux-2.6.18-rc1-mm1-full/Documentation/feature-list-2.6.txt.old	2006-07-11 17:18:31.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/feature-list-2.6.txt	2006-07-11 17:19:01.000000000 +0200
@@ -91,7 +91,7 @@
 
 Deprecated/obsolete features.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- devfs will be obsoleted in favour of udev (http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+- devfs was obsoleted in favour of udev (http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
 - boot time root= parsing changed.
   ramdisks are now ram<n> instead of rd<n> and cm206 is cm206cd (instead of
   cm206).
@@ -683,14 +683,6 @@
 
 
 
-devfs.
-~~~~~~
-- devfs was somewhat stripped down and a lot of duplicate functionality
-  was removed. You now need to enable CONFIG_DEVPTS_FS=y and mount
-  the devpts filesystem in the same manner you would if you were not
-  using devfs.
-
-
 EXT2.
 ~~~~~
 - 2.5.49 included an extension to ext2 which will cause it to not attach
--- linux-2.6.18-rc1-mm1-full/Documentation/ioctl-mess.txt.old	2006-07-11 17:19:47.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/Documentation/ioctl-mess.txt	2006-07-11 17:20:07.000000000 +0200
@@ -1109,23 +1109,6 @@
 DECODER_SET_OUTPUT
 DECODER_SET_PICTURE
 DECODER_SET_VBI_BYPASS
-
-N: DEVFSDIOC_GET_PROTO_REV
-I: -
-O: int
-
-N: DEVFSDIOC_RELEASE_EVENT_QUEUE
-I: -
-O: -
-
-N: DEVFSDIOC_SET_DEBUG_MASK
-I: int
-O: -
-
-N: DEVFSDIOC_SET_EVENT_MASK
-I: (int) arg
-O: -
-
 DMX_GET_CAPS
 DMX_GET_EVENT
 DMX_GET_PES_PIDS
--- linux-2.6.18-rc1-mm1-full/drivers/block/Kconfig.old	2006-07-11 17:20:34.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/block/Kconfig	2006-07-11 17:20:41.000000000 +0200
@@ -205,8 +205,7 @@
 	  module will be called umem.
 
 	  The umem driver has not yet been allocated a MAJOR number, so
-	  one is chosen dynamically.  Use "devfs" or look in /proc/devices
-	  for the device number
+	  one is chosen dynamically.
 
 config BLK_DEV_UBD
 	bool "Virtual block device"
--- linux-2.6.18-rc1-mm1-full/drivers/char/mwave/README.old	2006-07-11 17:21:13.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/char/mwave/README	2006-07-11 17:21:22.000000000 +0200
@@ -41,10 +41,7 @@
 Accessing the driver
 --------------------
 
-You must also create a node for the driver.  Without devfs:
+You must also create a node for the driver:
   mkdir -p /dev/modems
   mknod --mode=660 /dev/modems/mwave c 10 219
-With devfs:
-  mkdir -p /dev/modems
-  ln -s ../misc/mwave /dev/modems/mwave
 
--- linux-2.6.18-rc1-mm1-full/drivers/media/radio/Kconfig.old	2006-07-11 17:21:36.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/media/radio/Kconfig	2006-07-11 17:21:50.000000000 +0200
@@ -195,8 +195,7 @@
 	---help---
 	  Choose Y here if you want to see RDS/RBDS information like
 	  RadioText, Programme Service name, Clock Time and date, Programme
-	  TYpe and Traffic Announcement/Programme identification.  You also
-	  need to say Y to "miroSOUND PCM20 radio" and devfs!
+	  TYpe and Traffic Announcement/Programme identification.
 
 	  It's not possible to read the raw RDS packets from the device, so
 	  the driver cant provide an V4L interface for this.  But the
--- linux-2.6.18-rc1-mm1-full/drivers/media/video/pwc/philips.txt.old	2006-07-11 17:22:00.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/media/video/pwc/philips.txt	2006-07-11 17:22:15.000000000 +0200
@@ -175,8 +175,8 @@
    - If a device node is already occupied, registration will fail and
      the webcam is not available.
    - You can have up to 64 video devices; be sure to make enough device
-     nodes in /dev if you want to spread the numbers (this does not apply
-     to devfs). After /dev/video9 comes /dev/video10 (not /dev/videoA).
+     nodes in /dev if you want to spread the numbers.
+     After /dev/video9 comes /dev/video10 (not /dev/videoA).
    - If a camera does not match any dev_hint, it will simply get assigned
      the first available device node, just as it used to be.
 
--- linux-2.6.18-rc1-mm1-full/drivers/sbus/char/cpwatchdog.c.old	2006-07-11 17:22:27.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/sbus/char/cpwatchdog.c	2006-07-11 17:22:35.000000000 +0200
@@ -10,8 +10,6 @@
  * 			timer interrupts.  We use a timer to periodically 
  * 			reset 'stopped' watchdogs on affected platforms.
  *
- * TODO:	DevFS support (/dev/watchdogs/0 ... /dev/watchdogs/2)
- *
  * Copyright (c) 2000 Eric Brower (ebrower@usa.net)
  */
 
--- linux-2.6.18-rc1-mm1-full/Documentation/ABI/obsolete/devfs	2006-07-09 11:22:37.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,13 +0,0 @@
-What:		devfs
-Date:		July 2005
-Contact:	Greg Kroah-Hartman <gregkh@suse.de>
-Description:
-	devfs has been unmaintained for a number of years, has unfixable
-	races, contains a naming policy within the kernel that is
-	against the LSB, and can be replaced by using udev.
-	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
-	along with the the assorted devfs function calls throughout the
-	kernel tree.
-
-Users:
-

