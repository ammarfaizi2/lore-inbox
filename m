Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUBSTSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUBSTSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:18:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:51855 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267490AbUBSTSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:18:00 -0500
Date: Thu, 19 Feb 2004 10:59:32 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 018 release
Message-ID: <20040219185932.GA10527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 018 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-018.tar.gz

rpms built against Red Hat FC2-test1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-018-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-018-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Major changes from the 017 version:
	- We now handle the ability to generate all partitions for a
	  device to allow removable devices to work in a sane manner.
	  This has been requested by a lot of people.
	- there's a new %s{} modifier available for people to use
	- the SYSFS_ style rule has changed to SYSFS{}.  The old style
	  is still supported for now, but you have been warned
	- %c1 style modifiers has been changed to %c{1}.  Again, the old
	  style format still works.
	- scsi_id is built by default now in the rpm and is available in
	  the pre-built rpm package.  This should get it a wider range
	  of testing.
	- lots of bug fixes and other cleanups.

In all, there is nothing hugely major in this release, but any current
users of udev will want this version for all of the bugfixes if for
nothing else.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h

Summary of changes from v017 to v018
============================================

<ext.devoteam.varoqui:sncf.fr>:
  o [PATCH] symlink dm-[0-9]* rule
  o update extras/multipath

<john-hotplug:fjellstad.org>:
  o init.d debian patch

Kay Sievers:
  o udev - TODO update
  o udev - add %s{filename} to man page
  o udev - udevd/udevsend man page
  o udev - switch callout part selector to {attribute}
  o udev - switch SYSFS_file to SYSFS{file}
  o udev - create all partitions of blockdevice
  o allow SYSFS{file}
  o Adding '%s' format specifier to NAME and SYMLINK

Greg Kroah-Hartman:
  o added some scsi_id files to the bk ignore file
  o added scsi_id and some more documentation to the udev.spec file
  o update udev.rules.gentoo with new config file format
  o Update the Gentoo udev.rules and udev.permissions files
  o Create a udev.rules.examples file to hold odd udev.rules
  o add udevd priority issue to the TODO list
  o more HOWTO cleanups
  o add HOWTO detailing how to use udev to manage /dev
  o mv libsysfs/libsysfs.h to libsysfs/sysfs/libsysfs.h to make it easier to use
  o add start_udev init script
  o add support for UDEV_NO_SLEEP env variable so Gentoo people will be happy
  o start up udevd ourselves in the init script to give it some good priorities
  o update the red hat init script to handle nodes that are not present
  o add a "old style" SYSFS_attribute test to udev-test.pl
  o Have udevsend report more info in debug mode
  o Have udevd report it's version in debug mode
  o fix up bug created for udevtest in previous partition creation patch
  o update the udev.spec to add udevtest and make some more Red Hat suggested changes
  o add ability to install udevtest to Makefile
  o 017_bk mark
  o Add another test to udev-test.pl and fix a bug when only running 1 test
  o Fix bug where we did not use the "converted" kernel name if we had no rule
  o v017 release TAG: v017

Patrick Mansfield:
  o udev use new libsysfs header file location
  o udev add some ID tests

