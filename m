Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263675AbVBCSKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbVBCSKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbVBCSHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:07:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:37810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263694AbVBCSFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:05:43 -0500
Date: Thu, 3 Feb 2005 10:05:28 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 051 release
Message-ID: <20050203180528.GB24742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 051 version of udev.  It can be found at:
  	kernel.org/pub/linux/utils/kernel/hotplug/udev-051.tar.gz

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

The major change in this release is the fact that the .permissions files
are no longer used.  All group and mode settings are to be in the main
rules files.  The Gentoo rules have been converted over to this scheme
if you want an example of how to do this.

There are lots of other good bugfixes and changes in this release, see
the full changelog below.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h

Summary of changes from v050 to v051
============================================

<roland:digitalvampire.org>:
  o This fixes a silly mistake in how udevinfo prints the major and minor numbers (right now it prints the minor next to "MAJOR" and the major next to "MINOR" ;)

<tklauser:access.unizh.chbk>:
  o I tried to compile udev 050plus with the GCC 4.0 snapshot 200412119 and got two errors about possibly uninitialized structs, so I fixed this. 

Christian Bornträger:
  o udev_volume_id: fix -d option

Greg Kroah-Hartman:
  o gentoo fb permission fix
  o fix gcc 2.96 issue in libsysfs
  o remove the lfs startup script on request of the author
  o clean up the aoe char device rules, and delete the block one as it's not needed
  o add aoe block and char device rules to the gentoo rule file
  o fix udev_volume_id build error

Hannes Reinecke:
  o rearrange link order in Makefile

Kay Sievers:
  o udev_volume_id: new version of volume_id
  o klibc: update to version 0.198
  o udev_volume_id: fix FAT label reading
  o klibc: update to version 0.196
  o udevd: throttle the forking of processes
  o udevd: add possible initialization of expected_seqnum
  o udevd: it's obviously not the brightest idea to exit a device node manager if it doesn't find /dev/null
  o udevd: separate socket handling to prepare for other event sources
  o udevd: support -d switch to become a daemon
  o udev_volume_id: version 27
  o udevd: split up message receiving an queueing
  o remove useless warning if udev.conf contains keys not read by udev itself
  o improve event sequence serialization
  o remove udevsend syslog noise on udevd startup
  o limit the initial timeout of the udevd event handling
  o correct detection of hotplug.d/ udevsend loop
  o correct log statement
  o remove default_* permissions from udev.conf file
  o update Fedora config files and add some more tests
  o allow permissions only rules
  o add SUBSYSTEM rule to catch all block devices and apply the disk permissions
  o update Fedora config files
  o handle renamed network interfaces properly if we manage hotplug.d/
  o allow multiline rules by backslash at the end of the line
  o add OnStream tape drive rules
  o simplify rules file by setting default mode to 0660
  o simplify permission application
  o I broke the extras/ again. Add simple build test script now
  o initial merge of fedora udev.permissions into udev.rules
  o remove permissions file mentioning from the udev man page
  o fix some typos in gentoo's udev.rules introduced by the merge

Michael Buesch:
  o The attached patch fixes the code path if namedev_name_device() fails

