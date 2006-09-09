Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWIIIS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWIIIS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 04:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWIIIS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 04:18:29 -0400
Received: from ns1.suse.de ([195.135.220.2]:44516 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932352AbWIIIS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 04:18:28 -0400
Date: Sat, 9 Sep 2006 01:18:14 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: State of the Linux Driver Core Subsystem for 2.6.18-rc6
Message-ID: <20060909081814.GA13061@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of the current state of the Linux Driver core
subsystem, as of 2.6.18-rc6.

If the information in here is incorrect, or anyone knows of any
outstanding issues not listed here, please let me know.

List of outstanding regressions from 2.6.17:
	- none known.

List of outstanding regressions from older kernel versions:
	- none known.


There are no currently open Driver core or sysfs bugs in bugzilla.


Future patches that are currently in my quilt tree (as found at
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
) for the Driver core subsystem are as follows.  All of these will be
submitted for inclusion into 2.6.19, except as noted:

	- PHYSDEV* values in uevents are now depreciated.
	- sysfs poll behavior was made consistent
	- suspend sequence was changed.  We now let the drivers know
	  much more about what is going on in the suspend sequence.  The
	  PCI subsystem was modified to pass this information down to
	  all PCI drivers, if they wish to know.
	- Lots of other power management changes, including better
	  in-kernel documentation of what needs to be done for drivers.
	  See the documentation for details.
	- struct device got some more fields and functions to handle the
	  conversion from class_device to device properly.
	- Lots of sysfs and driver core functions were marked with
	  __must_fix to help fix up driver bugs where they fail to
	  handle errors returned by the driver core.  This is now a
	  configuration option so that it can be turned off for those
	  who don't like 1542 new compiler warnings in their build.
	  Patches are in other trees to fix these warnings.
	- The driver core was changed to allow multi-threaded device
	  probing.  This means that every device added to the system
	  gets a new kernel thread in which to do the probe sequence.
	  The PCI subsystem was modified to allow PCI drivers to do this
	  (this is made a configuration option, as it breaks numerous
	  boxes if enabled).  It does have the potential to speed up the
	  boot sequence a lot for some machines, and is even measurable
	  on single processor laptops.
	- Numerous class subsystems were changed from using the struct
	  class_device to use struct device.  This moves the directory
	  for the class device to be in the /sys/devices/ tree, where it
	  should have gone originally.  Note that this requires an
	  updated version of udev for most older distributions to handle
	  properly.  Because of this, these patches will not be
	  submitted for inclusion until all older udevs have been
	  patched to work with this change (a task I am currently
	  working on.)  This will probably not go into 2.6.19 because of
	  this.

For API changes, the suspend/resume sequence got new functions, passing
those functions down to the pci drivers to use.  struct device had some
fields added to it, and there are some new driver core functions for
creating devices that are associated with classes.  None of these
changes will break older code, as things were only added, not renamed or
removed from the API.

The class_device changes do move things around in sysfs, so userspace
tools will need to be updated when those changes make it into the kernel
tree (note, this will probably not happen for 2.6.19, but if it does,
everyone will be forewarned about it a lot.)  Kay Sievers has a great
document he is working on for how to properly use sysfs from userspace,
hopefully that will be finished and posted for others to comment on
soon.

thanks,

greg k-h

