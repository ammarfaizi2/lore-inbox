Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVAaBK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVAaBK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 20:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVAaBK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 20:10:27 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:8325 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261884AbVAaBKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 20:10:13 -0500
From: David Brownell <david-b@pacbell.net>
Reply-To: linux-usb-devel@lists.sourceforge.net
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net
Subject: ANNOUNCE:  usbutils-0.70
Date: Sun, 30 Jan 2005 17:10:09 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301710.10015.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WHAT
    The "usbutils" package is most useful for the "lsusb" utility, which
    can provide considerable detail about the USB devices connected to
    your Linux system.  (It's like "pciutils" is for PCI.)  When making
    bug reports, or otherwise troubleshooting, "lsusb -v" output is very
    useful; often more so than /proc/bus/usb/devices output.

    For folk using Linux 2.4 kernels, this also provides "usbmodules"
    which can help with the "coldplug" problem:  setting up devices that
    are connected before the OS is capable of running all of the necessary
    "hotplug" programs.

WHY
    The last official release was version 0.11 in August 2002.  This version
    should incorporate almost all of the bug fixes and patches that have been
    floating around since then.  If you're using patches that haven't been
    merged, please resolve that.

    This "lsusb" version is aware of USB 2.0 features; the 0.11 version only
    understood USB 1.1 functionality.

    This version understands many more types of descriptors; it previously
    understood primarily audio and HID descriptors.

	- Communications Device Class (CDC) descriptors, for USB Modems,
	  some Ethernet style links (such as cable modems), and many PDAs.

	- Hub descriptor.  Not all hubs are equal, and previously only
	  kernel CONFIG_USB_DEBUG messages showed how they differ.  Older
	  versions of "lsusb" only showed descriptors for some hubs; this
	  shows them for all hubs, and also current status of each port.

	- Device qualifier.  If a device supports high speed USB, it has
	  one of these; otherwise, it doesn't.

	- Chip Card and Smart Card interfacing devices.

	- USB On-The-Go (OTG) devices.  Starting to appear; some run Linux.

	- USB Debug devices.  Currently exotic.

	- Unrecognized descriptors are dumped in hex; some previous versions
	  discarded them, which made troubleshooting painful.

    Note that if the kernel HID driver is bound to a device, lsusb
    can't show its descriptors.  You can workaround this by removing the
    "usbhid" module before running lsusb against that device.

    This version uses the system's version of "libusb", rather than its
    own private copy.  That involved some API changes.  It also accounted
    for the only loss of functionality:  lsusb doesn't currently list
    the language strings supported by the device.  Many devices don't
    seem to bother with anything beyond English.

WHERE
    Download from one of the SourceForge mirrors for the Linux-USB project:

    http://sourceforge.net/project/showfiles.php?group_id=3581&package_id=142529

    Also, current source is in CVS for the Linux-USB project at SourceForge.
    If you have any patches (support for CJKV strings?), prepare them against
    CVS and post them to the linux-usb-devel list.

HOW
    It uses GNU autoconf, so configure and build it:

	$ tar xf usbutils-0.70.tar.gz
	$ cd usbutils-0.70
	$ ./configure			<-- see below for options
	$ make
	$ ./update-usbids.sh		<-- optional
	$ su -c "make install"
	$

    Significant options to "configure" include:

	--prefix=/		To replace the normal /sbin version of
				lsusb, rather than /usr/local.

	--enable-usbmodules	If you're using a Linux 2.4 based system
				or otherwise not using "udev" for coldplug.


