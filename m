Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269937AbUJHAQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269937AbUJHAQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269882AbUJHANb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:13:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:62105 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269859AbUJHAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:09:55 -0400
Date: Thu, 7 Oct 2004 17:09:19 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 034 release
Message-ID: <20041008000919.GA4881@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 034 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-034.tar.gz

(hm, last announcement I sent out was for 031, sorry about that...)

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

Lots of good bugfixes have happened since the 031 release, and some
major enhancements:
	- SELinux support is back in, thanks to Red Hat.
	- a new helper program, wait_for_sysfs, is installed as the
	  first program in the hotplug chain.  If this program spits out
	  any log messages, please forward them to the email address it
	  tells you to, and we will fix the code.
	- scsi_id is updated to the latest version
	- volume_id now builds on Gentoo based systems.
	  
Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

 Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v033 to v034
============================================

Kay Sievers:
  o wait_for_sysfs bluetooth class update

Greg Kroah-Hartman:
  o add comment in wait_for_sysfs to explain the structure better
  o Revert previous dev_d.c change, it's not what is causing HAL problems
  o hm, somethings odd with DEVPATH, see if this fixes it
  o 33_bk mark for the makefile
  o wait_for_sysfs: clean up the logic for the list of devices that we do not expect device symlinks for
  o get rid of annoying extra lines in the syslog for some libsysfs debug messages
  o added support for i2c devices in wait_for_sysfs.c
  o add support for i2c-adapter devices to wait_for_sysfs.c

Summary of changes from v032 to v033
============================================

<harald:redhat.com>:
  o udev close on exec
  o some cleanups and security fixes
  o some cleanups and security fixes
  o selinux for udev
  o cleanup PATCH for extras/chassis_id/Makefile

<kpfleming:backtobasicsmgmt.com>:
  o respect prefix= setting in built udev.conf (updated)

Greg Kroah-Hartman:
  o add support for usb interfaces to wait_for_sysfs to keep it quiet
  o enable native tdb spinlocks on i386 platforms
  o delete extras/multipath-tools as per the author's request
  o be paranoid in dev_d.c
  o add USE_SELINUX to README documentation so people have a chance to see what is going on
  o update the selinux.h file to start to look sane
  o update bk ignore list for the wait_for_sysfs binary
  o kdetv wants to see device nodes in /dev
  o update comments in scsi-devfs.sh
  o fix up Makefiles to get the klibc build working properly
  o update bk ignore list for new klibc generated files
  o oops forgot to add the new klibc/include directory
  o update klibc to version 0.181

Kay Sievers:
  o fix problems with dev.d and udevstart
  o wait_for_sysfs debug cleanup
  o fix problems using scsi_id with udevstart
  o update volume_id
  o finally solve the bad sysfs-timing for all of us
  o volume-id build fix and update
  o switch udev's seqnum to u64
  o add enum tests
  o fix udev segfaults with bad permissions file

Patrick Mansfield:
  o update udev to include scsi_id 0.6


Summary of changes from v031 to v032
============================================

<harald:redhat.com>:
  o udev parse bug

Kay Sievers:
  o handle only block and class devices
  o fix udevstart badly broken in udev 031


