Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUBCUUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUBCUUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:20:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:20184 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266029AbUBCUUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:20:12 -0500
Date: Tue, 3 Feb 2004 12:13:59 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 016 release
Message-ID: <20040203201359.GB19476@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 016 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-016.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-016-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-016-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Major changes from the 015 version:
	- udev is now in 3 pieces:
	    udevsend - is called by /sbin/hotplug and bundles up the
		       hotplug event and sends it off to the udevd
		       daemon.
	    udevd - receives the hotplug messages from udevsend, sorts
		    them in the proper order, and runs udev for the
		    different devices.
	    udev - still the same.  Does the actual device node creation
		   and removal.

	  This has been one of the major pieces missing for udev, and I
	  really want to thank Kay Sievers for all of his hard work on
	  this.

	  Right now, udevsend and udev are built against klibc (udevsend
	  is only 2.5Kb big), and udevd is linked dynamically against
	  glibc, due to it using pthreads.  This is ok, as udev can
	  still be placed into initramfs and run at early boot, it's
	  only after init starts up that udevsend and udevd will kick
	  in.


Thanks also to everyone who has send me patches for this release, a full
list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v015 to v016
============================================

<elkropac:students.zcu.cz>:
  o get_dev_number() in extras/ide-devfs.sh

<rrm3:rrm3.org>:
  o FAQ udev.rules.devfs

Greg Kroah-Hartman:
  o add udevd and udevsend to the spec file
  o make /etc/hotplug.d/default/udev.hotplug symlink point to udevsend now
  o add KERNEL_DIR option so that the distros will be happy
  o make udevsend binary even smaller
  o udevsend now almost compiles with klibc, struct sockaddr_un is only problem now
  o fix up logging code so that it can be built without it being enabled
  o rework the logging code so that each program logs with the proper name in the syslog
  o remove logging.c as it's no longer needed
  o kill the last examples that contained the %D option
  o remove a __KLIBC__ tests in libsysfs, as klibc now supports getpagesize()
  o udevd - remove stupid locking error I wrote
  o update to klibc version 0.101, fixing the stdin bug
  o fix Makefile typo for USE_LSB install
  o 015_bk mark
  o allow dbus code to actually build again
  o v015 release TAG: v015

Kay Sievers:
  o let udevsend build with klibc
  o udevd - config cleanup
  o udevd - cleanup and better timeout handling
  o fix possible buffer overflow
  o udevd - next round of fixes
  o udevinfo - missing options for man page
  o udev - trivial style cleanup

