Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTLWA6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTLWA6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:58:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:34995 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264608AbTLWA6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:58:11 -0500
Date: Mon, 22 Dec 2003 16:58:09 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 010 release
Message-ID: <20031223005809.GB5341@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 010 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-010.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-010-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-010-1.src.rpm

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.  Please see the udev
FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

Please read the FAQ if you have any questions about devfs and udev.
It's been updated a lot in response to all of the confusion about this
topic.

The major changes since the 008 release are:
	- a number of bugs that were in the 009 release are now fixed.
	  The extras/ subdir should now build properly (but I take no
	  responsibility if it doesn't...)
	  
	- we now don't blow away old config files if you install this
	  version on top of an older version.  Sorry about that...
	  
	- udev now supports looking at multiple sysfs files at once for
	  a single rule.  This enables you to write such rules as:
	  LABEL, BUS="usb", SYSFS_vendor="FUJIFILM", SYSFS_model="M100", NAME="camera%n"
	  which helps in trying to identify a device in a unique way.
	  Right now udev supports up to 5 different sysfs files.  If you
	  want to have more, the code can be changed, just let me know.

	- new format modifier "%k" has been added to allow rules to use
	  the kernel name of the device.

	- an example shell script that handles an IDE devfs mapping has
	  been added to the tarball.  Thanks to Kay Sievers for this.
	  
Thanks again to everyone who has send me patches for this release, a
full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of this tree used to be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
But that box seems to be down now.  Hopefully it will be restored
someday.  If anyone ever wants a tarball of the current bk tree, just
email me.

thanks,

greg k-h


Summary of changes from v009 to v010
============================================

<ananth:in.ibm.com>:
  o change pgsize

<christophe.varoqui:free.fr>:
  o extras multipath update
  o extras multipath update
  o extras multipath update
  o extras multipath update

Kay Sievers:
  o fix udev-test.pl
  o small cleanup udev-remove.c
  o experimental CALLOUT script for devfs ide node creation with cd, disc, part
  o add any valid device
  o introduce format char 'k' for kernel-name
  o trivial make fixes
  o don't overwrite old config on install
  o udev-remove.c cleanups
  o bug in udev-remove.c
  o trivial cleanup parser changes

<roman.kagan:itep.ru>:
  o fix comment and whitespace handling in config files

Adam Kropelin:
  o Allow build with empty EXTRAS

Daniel E. F. Stekloff:
  o libsysfs 0.4.0 patch
  o fix scsi_id segfault with udev-009
  o add libsysfs docs

David T. Hollis:
  o mark config files as such in the rpm spec file

Greg Kroah-Hartman:
  o fix complier warning in namedev.c
  o add documentation for the new '%k' modifier (kernel name replacement)
  o add documentation about the multiple sysfs values that are now allowed for the LABEL rule
  o add tests for multi-file LABEL rules
  o add ability to have up to 5 SYSFS_ file/value pairs for the LABEL rule
  o Just live with a sleep(1) in namedev for now until libsysfs is fixed up
  o try to wait until the proper device file shows up in sysfs
  o remove unneeded TODO and FIXME entry
  o clean up the stand-alone tests to work properly on other people's machines
  o add tests to catch whitespace and comment config file parsing errors

