Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUCYAby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCYA3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:29:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:65426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262774AbUCYA1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:27:00 -0500
Date: Wed, 24 Mar 2004 16:26:47 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 023 release
Message-ID: <20040325002647.GA22795@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 023 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-023.tar.gz

rpms built against Red Hat FC2-test1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-023-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-023-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Big changes in this release (along with a lot of good bugfixes):
	- we can now rename network devices.  Yeah, I said udev would
	  never do this, but it was just so darn simple, and udev is
	  more flexible than nameif is today.  That and someone sent in
	  a patch to do it :)
	- udev will now call scripts in /etc/dev.d/ when it creates or
	  removes a device node.  More on that below.
	- There's a first cut at a gui tool to help create rules.  It's
	  called udevruler and needs to be made separately:
	  	make udevruler
	- D-BUS and SELinux support have been removed from the main udev
	  program due to the /etc/dev.d/ mechanism.  These have been
	  moved to separate programs in the udev extras/ directory, and
	  probably do not work quite right yet.  Could anyone who was
	  using this functionality in udev please help me out in getting
	  these programs working again?

Ok, about the /etc/dev.d/ scheme.  It works much like the current
/etc/hotplug.d/ system, and is fully documented at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/RFC-dev.d
It is a scheme that is not limited to udev, if some other device naming
daemon is created.  I'll be working on submitting it (and the
/etc/hotplug.d/ system) to the LSB soon.

With /etc/dev.d/ it is _very_ simple for scripts or programs to get run
when a new device is added to the system.  Yes, this also can be done
with the existing /etc/hotplug.d/ system, but it is difficult and takes
a whole lot more code to do so.  Also, to have the /etc/hotplug.d/
system work properly, the hotplug core would have to run udev first,
before any other hotplug programs, which is not something that I feel is
good to start doing.

Anyway, comments and criticisms are welcome, after you go read the above
text file (and patches against the text file for anything that is not
documented well are always welcome.)

Thanks to everyone else who has send me patches for this release, a full
list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v022 to v023
============================================

Kay Sievers:
  o hmm, handle net devices with udev?
  o correct apply_format() for symlink only rules
  o don't init namedev on remove
  o first stupid try for a rule compose gui
  o replace fgets() with mmap() and introduce udev_lib.[hc]
  o make udevtest a real program :)

Daniel E. F. Stekloff:
  o udevinfo patch

Greg Kroah-Hartman:
  o create the /etc/dev.d/ directories in 'make install'
  o actually have udev run files ending in .dev in the /etc/dev.d/ directory as documented
  o added RFC-dev.d document detailing how /etc/dev.d/ works
  o fixed up udev.spec to handle selinux stuff properly now
  o remove USE_DBUS and USE_SELINUX flags from the README as they are no longer present
  o remove selinux stuff from the main Makefile
  o move udev_selinux into extras/selinux
  o fix dbus build in the udev.spec file
  o remove dbus stuff from main Makefile
  o move udev_dbus to extras/dbus
  o udev_dbus can now compile properly, but linnking is another story
  o remove udev_dbus.h from Makefile
  o first cut at standalone udev_selinux program
  o remove selinux support from udev core as it's no longer needed
  o first cut at standalone udev_dbus program
  o add get_devnode() helper to udev_lib for udev_dbus program
  o remove dbus code from core udev code as it's no longer needed to be there
  o add /etc/dev.d/ support for udev add and remove events
  o fix build error in namedev.c caused by previous patch
  o 022_bk tag
  o fix 'make spotless' to really do that in klibc
  o add a question/answer about automounting usb devices to the FAQ
  o mark scsi-devfs.sh as executable
  o Increase the name size as requested by Richard Gooch <rgooch@ras.ucalgary.ca>
  o fix udevtest to build properly after the big udev_lib change
  o 022 release TAG: v022

Olaf Hering:
  o uninitialized variable for mknod and friend

Richard Gooch:
  o SCSI logical and physical names for udev

Theodore Y. T'so:
  o Trivial man page typo fixes to udev

