Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUDCAYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUDCAYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:24:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261422AbUDCAYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:24:22 -0500
Date: Fri, 2 Apr 2004 16:24:04 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 024 release
Message-ID: <20040403002404.GA9285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 024 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-024.tar.gz

rpms built against Red Hat FC2-test2 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-024-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-024-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Changes in this release (along with a lot of good bugfixes):
	- more network device fixes and reworks.  We now handle network
	  devices better.
	- updated the udev.rules files based on a bunch of new devices
	  that the 2.6 kernel is now exporting through sysfs.
	- resynced up the Gentoo config files
	- added a /etc/dev.d/net/hotplug.dev file that allows udev to
	  rename network devices, and then have the main hotplug scripts
	  bring it up in the proper manner.  Before this, renamed
	  network devices would not work with the hotplug script system
	  properly.
	- rename the DEVNODE environment var to DEVNAME as it didn't
	  make much sense for network devices.
	- new helper program called chassis_id has been added to the
	  extras/ directory.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v023 to v024
============================================

<atul.sabharwal:intel.com>:
  o Add README for chassis_id
  o Add chassis_id program to extras directory

<chris_friesen:sympatico.ca>:
  o udevd race conditions and performance,  assorted cleanups

<hare:suse.de>:
  o fix SEGV in libsysfs/dlist.c

<maryedie:osdl.org>:
  o add OSDL documentation for persistent naming

<md:linux.it>:
  o small ide-devfs.sh fix

Greg Kroah-Hartman:
  o remove compiler warning from udevd.c
  o only generate udev.8 on the fly, not all other man pages
  o update bk ignore list some more
  o update bk ignore list
  o switch to generate the man pages during the normal build, not during the install
  o convert udev.8.in to use @udevdir@ macro for make install
  o first step of making man pages dynamically generated
  o add install and uninstall the etc/dev.d/net/hotplug.dev file to the Makefile
  o tweak net_test a bit
  o fix some segfaults when running udevtest for network devices
  o make a net_test test script using udevtest
  o handle the subsytem if provided in udevtest
  o add hotplug.dev script to handle renamed network devices
  o add a bunch of network class devices to the test sysfs tree
  o add udevruler to the bk ignore list
  o update RFC-dev.d docs due to DEVNODE to DEVNAME change
  o clean up chassis_id coding style
  o clean up the OSDL document formatting a bit
  o add netlink rules to devfs and gentoo rules files
  o added USB device rules to rules files
  o clean up the gentoo rules file a bit more, adding dri rules
  o fix up udev.rules to handle oss rules better
  o 023_bk mark
  o fix udev.spec file for where udevtest should be placed
  o v023 release TAG: v023

Kay Sievers:
  o tweak node unlink handling
  o switch udevd's msg_dump() to #define
  o handle netdev in udevruler
  o man page cleanup
  o put config info in db for netdev
  o increase udevd event timeout
  o udevstart fix
  o put netdev handling and dev.d/ in manpages
  o DEVPATH for netdev
  o netdev - udevdb+dev.d changes
  o udevd race conditions and performance,  assorted cleanups - take 2
  o udevinfo patch
  o dev_d.c file sorting and cleanup
  o apply all_partitions rule to main block device only

