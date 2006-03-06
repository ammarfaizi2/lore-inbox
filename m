Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752040AbWCFWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbWCFWtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWCFWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:49:19 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17384
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751308AbWCFWtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:49:18 -0500
Date: Mon, 6 Mar 2006 14:49:08 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: State of the Linux Driver core and sysfs Subsystems for 2.6.16-rc5
Message-ID: <20060306224908.GA20981@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of the current state of the Linux Driver core and sysfs
subsystems as of 2.6.16-rc5.

If the information in here is incorrect, or anyone knows of any
outstanding issues not listed here, please let me know.

List of outstanding regressions from 2.6.15:
	- none known.

List of outstanding regressions from older kernel versions:
	- none known.

There are no outstanding bugs for these subsystems in the
bugzilla.kernel.org system that I know of.  If this is not true, please
point me at the bugs you feel I should know about.

Future stuff:
  All of the patches that will be sent in for 2.6.17 can be found in my
  quilt tree at
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/ and
  are included automagically in the -mm releases.

  Here's a summary of the changes that can be found there:
	- There's a big pending AOE driver update that missed the 2.6.16
	  cut-off timeframe.  If you use this driver, I would recommend
	  getting these patches.
	- pollable sysfs attributes will be coming soon.  I think Neil
	  is going to rework the existing patches, due to some issues
	  found in -mm reviews, but the functionality should remain the
	  same (adds a new sysfs function you can call to let userspace
	  know that a sysfs file has changed contents.  Use this instead
	  of the old uevent interface to notify userspace in an easier
	  manner.)
	- change semaphores to mutexes.
	- module sysfs file refcount fixes
	- EXPORT_SYMBOL_GPL_FUTURE() addition.
	- relayfs as a stand-alone filesystem is gone, to be replaced
	  with the ability to use relayfs files from within sysfs.
	- other minor bugfixes.

I am currently working on allowing struct device to be bound to a struct
class as part of the migration away from struct class_device and toward
allowing everything to be a struct device in the sysfs device tree.
That work is being tested out on the "usbfs2" work which adds a dev file
to every USB endpoint in the system, allowing async-io to be used from
userspace instead of the ioctl mess we have in usbfs today.  If anyone
is interested in this work, look in my patch queue for the initial cut
of it.  It will be rapidly changing this week as I get the time to work
more on it.

The above mentioned changes, do not change any existing sysfs or driver
core apis, but only add a few more functions.  So there are no API
changes coming in the near future that I am aware of.


It is also noted that a lot of people still don't know how to use a
kobject properly, and that more sysfs files are containing more than one
value (hey, look a table of numbers in the cpufreq file...)  Please be
aware that people will be walking around with big sticks and whacking
the fingers of any programmers who do this.  When in doubt, _please_ ask
how to do this kind of low-level programming as it is very easy to get
wrong...

Also the kernel/userspace API documentation patch is pending me getting
the chance to work on it today or tomorrow, don't worry, I haven't
forgotten about it :)


Was this summary useful for people?  Anything that I should add to it?

thanks,

greg k-h
