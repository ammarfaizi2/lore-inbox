Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTKSQb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTKSQb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:31:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:26760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263898AbTKSQbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:31:24 -0500
Date: Wed, 19 Nov 2003 08:29:12 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 006 release
Message-ID: <20031119162912.GA20835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 006 version of udev.  It can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-006.tar.gz

Due to me being on paternity leave for all of November, I've not built
up any rpms, but the spec file is in the tarball, so you can do it if
you wish.

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.

The major changes since the 005 release are:
	- rules now are applied in the proper priority, instead of the
	  order they showed up in the config files.
	- partitions work properly for all types of rules, instead of
	  just the LABEL rule type.
	- format modifiers have been added so that the NAME is now
	  dynamic.  See the udev.config file and the man page for more
	  documentation about these (NOTE, if you have any rules that
	  named partitions in the past, they will have to be changed to
	  take advantage of these modifiers in order to work properly
	  now.)
	- subdirectories under /udev are now handled properly.
	- better parsing logic can handle broken files saner.
	- added 
	- moved the tests to a test/ directory, along with the
	  beginnings of a regression test suite.
	- lots of tiny fixes
	
Many, many thanks to Kay Sievers, for this release, for implementing
many of the new features.  I really appreciate it.

Thanks also to Dan Stekloff, Robert Love, Paul Mundt, Chris Friesen,
Arnd Bergmann, and Olaf Hering, all of whom submitted patches for this
release.

The full ChangeLog can be found below.
 
The udev FAQ can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ
 
The udev BitKeeper tree has moved for now, due to kernel.bkbits.net
being off the air to:
	bk://linuxusb.bkbits.net/udev

Note, to build using klibc, please read the klibc README in the klibc/
directory, and build using 'make -f Makefile.klibc'.

If anyone ever wants a snapshot of the current tree, due to not using
BitKeeper, or other reasons, is always available at any time by asking.

thanks,

greg k-h


Summary of changes from v005 to v006
============================================

<chris_friesen:sympatico.ca>:
  o faster test scripts

Arnd Bergmann:
  o more robust config file parsing in namedev.c
  o add bus id modifier

Daniel E. F. Stekloff:
  o patch for libsysfs sysfs directory handling

Greg Kroah-Hartman:
  o add another line to udev.permissions in the proper format
  o tweak replace_test
  o fix permissions to work properly now
  o add real udev.permissions file to test directory
  o fix namedev.c to build with older version of gcc
  o add dumb test for all of the different modifiers
  o update the TODO list with more items that people can easily do
  o move the test.block and test.tty scripts to the test/ directory
  o add remove actions to the test scripts
  o turn DEBUG_PARSER off by default
  o add some documentation for the %b modifier to the default config file
  o fix make install rule for when the udev symlink is already there
  o change release target in makefile
  o change debug level on printf values for now
  o updated demo config file
  o add some documentation of the modifiers to the default config file
  o add demo config file
  o updated bk ignore list for klibc generated files
  o add printf option to label test to verify it works
  o fix up printf-like functionality due to previous changes
  o get the major/minor number before we name the device
  o add scsi_id "extra" program from Patrick Mansfield <patmans@us.ibm.com>
  o Add multipath "extra" program from Christophe Varoqui, <christophe.varoqui@free.fr>
  o trailing whitespace cleanups
  o splig LABEL and NUMBER into separate functions
  o add TOPO regression test
  o move TOPOLOGY rule to it's own function
  o fix bug where NUMBER and TOPOLOGY would not work for partitions
  o clean up the way we find the sysdevice for a block device for namedev
  o updated label test script (tests for partitions now.)
  o split REPLACE and CALLOUT into separate functions
  o add debug line for REPLACE call
  o add replace test
  o add more sysfs test tree files
  o change UDEV_SYSFS_PATH environment variable due to libsysfs change
  o fix bug in klibc's isspace function
  o fix udev-add.c to build properly with older versions of gcc
  o add prototype for ftruncate to klibc
  o Remove a few items from the TODO list that are already done
  o version number to 005_bk
  o pull some klibc stuff into the make Makefile to try to stay in sync
  o klibc build fixes

Kay Sievers:
  o apply permissions.conf support for wildcard and default name
  o man page with included placeholder list
  o implement printf-like placeholder support for NAME
  o more manpage tweaks
  o add support for subdirs
  o add uid/gid to nodes

Olaf Hering:
  o DESTDIR for udev

Paul Mundt:
  o Fixup path for kernel includes when building with klibc

Robert Love:
  o udev init script


