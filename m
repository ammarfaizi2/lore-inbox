Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTLYA4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 19:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTLYA4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 19:56:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:26785 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264145AbTLYA4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 19:56:07 -0500
Date: Wed, 24 Dec 2003 16:56:14 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 011 release
Message-ID: <20031225005614.GA18568@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 011 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-011.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-011-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-011-1.src.rpm

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.  Please see the udev
FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

The major changes since the 010 release are:
	- The _long_ time delay on startup if you used the udev init
	  script is now gone.  We now fork a new process of udev for
	  every device in the sysfs tree, causing any slow udev proceses
	  (due to the type of device) to be not noticeable by the user.

	- The RPM package is built against klibc.  If you have any
	  problems with this image, please let me know.

	- The big "always wait 1 second" problem with the 010 release is
	  now pretty much fixed.  I still need some libsysfs changes to
	  work around some of the delays I had to hard code in, but for
	  any device that is not a partition, and has a "device"
	  symlink, udev will not sleep at all.  If a device does not
	  have a "device" symlink, we will wait around for a few seconds
	  to see if one is going to be created or not, and then move on.
	  It's the only sane way of handling the issue of not knowing
	  what kinds of devices have symlinks and which ones do not.

	- fixed a few bugs when devices did not have a "device" symlink.
	  Rules were getting applied when they should not have been.

	- LABEL and CALLOUT rules now no longer require the BUS key.  If
	  the BUS key is not present, the LABEL or CALLOUT rule will be
	  always be checked.  This allows us to use these types of rules
	  for devices without a "device" symlink.

	- a few other minor tweaks and bug fixes too.

Thanks again to everyone who has send me patches for this release, a
full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of this tree used to be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
But that box seems to be down now.  Hopefully it will be restored
someday.  If anyone ever wants a tarball of the current bk tree, just
email me.

It's time to go cook the Tofurky...

thanks,

greg k-h

Summary of changes from v010 to v011
============================================

<mbuesch:freenet.de>:
  o proper cleanup on udevdb_init() failure

<mh:nadir.org>:
  o patch udev 009-010 rpm spec file

<svetljo:gmx.de>:
  o fix udev sed Makefile usage

Greg Kroah-Hartman:
  o add documentation about the BUS key being optional for the LABEL rule
  o add tests for LABEL rule with a device that has no bus
  o Don't require the BUS value for the LABEL rule
  o If a LABEL rule has a BUS id, then we must check to see if the device is on a bus
  o add documentation about the BUS key being optional for the CALLOUT rule
  o If a CALLOUT rule has a BUS id, then we must check to see if the device is on a bus
  o Don't require the BUS value for the CALLOUT rule
  o add test for callout rule with a device that has no bus
  o 010_bk stamp
  o added different build options to the rpm udev.spec file
  o add pci to the bus_files list
  o check for empty line a bit better in the parser
  o more init script cleanups, the stop target now calls udev to cleanup instead of just removing the whole /udev directory
  o make udev init script run udev in the background to let startup go much faster
  o fix long delay for all devices in namedev
  o v010 release TAG: v010

