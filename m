Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUCMAHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbUCMAHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:07:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:43148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262538AbUCMAHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:07:42 -0500
Date: Fri, 12 Mar 2004 16:07:29 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 022 release
Message-ID: <20040313000729.GA10821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 022 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-022.tar.gz

rpms built against Red Hat FC2-test1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-022-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-022-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


There are a few minor bugfixes in this release, and a few new features.
Which pretty much seems to prove my "udev is mature" statement I made
for the last release :)

Oh, I'd like to thank OSDL for doing some preliminary speed tests (as
well as functionality tests) on udev.  Unofficially it looks like it
only took 7 seconds extra to use udev to name 1000 scsi disks (and the
rule was calling out to scsi_id for every disk, and then parsing over
1000 rules.)  Note that is 7 seconds extra to name _all_ of the disks at
once using the scsi_debug module.  That's not too shabby at all.

Where are those "hotplug is too slow to do device naming" whiners now...

Major changes from the 021 version:
	- lots of security audits in libsysfs and the remaining udev
	  files.
	- fixes for the foo-%c{N} type rules
	- add foo-%c{N+} type rule option (see the manpage for info).
	- allow node permissions to be specified in the rules file.
	- more tests added to the test scripts
	- number of other small fixes.

Again a big thanks to Kay Sievers for sending me patches faster than I
can integrate them.  udev is a viable program due to his excellent work.

Thanks also to everyone else who has send me patches for this release, a
full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v021 to v022
============================================

<ananth:in.ibm.com>:
  o more Libsysfs updates
  o Libsysfs updates

<async:cc.gatech.edu>:
  o fix HOWTO-udev_for_dev for udevdir

<kay.sievers:vrfy.org>:
  o udev-test.pl cleanup
  o add dev node test to udev-test.pl
  o add permission tests
  o "symlink only" test
  o callout part selector tweak
  o cleanup callout fork
  o allow to specify node permissions in the rule
  o man page beauty
  o put symlink only rules to the man page
  o rename strn*() macros to strmax
  o conditional remove of trailing sysfs whitespace
  o clarify udevinfo text
  o better fix for NAME="foo-%c{N}" gets a truncated name
  o overall trivial trivial cleanup
  o fix NAME="foo-%c{N}" gets a truncated name
  o cleanup mult field string handling

<ken:cgi101.com>:
  o fix a type in docs/libsysfs.txt
  o Added line to udev.permissions.redhat
  o Include more examples in the docs area for gentoo and redhat

<md:linux.it>:
  o udevstart fixes

Greg Kroah-Hartman:
  o add big major tests to udev-test.pl
  o add a test for a minor over 255
  o udev-test.pl: print out major:minor and perm test "ok" if is ok
  o make perm and major:minor test errors be reported properly
  o remove extra ; in namedev_parse.c
  o Added multipath-tools 0.1.1 release
  o deleted current extras/multipath directory
  o 021_bk mark
  o fix the build for older versions of gcc
  o 021 release TAG: v021

Hanna V. Linder:
  o Small fix to remove extra "will" in man page

Olaf Hering:
  o make spotless
  o udev* segfaults with new klibc

Patrick Mansfield:
  o add tests for NAME="foo-%c{N}"

