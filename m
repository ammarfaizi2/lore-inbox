Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJWAUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 20:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTJWAUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 20:20:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:17863 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261345AbTJWAUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 20:20:13 -0400
Date: Wed, 22 Oct 2003 17:14:31 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 005 release
Message-ID: <20031023001430.GA1837@kroah.com>
Reply-To: linux-hotplug-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, these are just churning out...  This release is done in advance of
a talk about it for the CGL meeting tomorrow at OSDL.

I've released the 005 version of udev.  It can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-005.tar.gz

rpms are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-005-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-005-1.src.rpm

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.

The major changes since the 004 release are:
	- klibc is now included in the udev tarball.  If you want to
	  build udev with klibc, please see the README file for how to
	  do this.
	- LABEL for the device symlink now works again
	- if the 'dev' file is not present (like the device was yanked
	  out before udev started looking at it), udev will now timeout
	  properly.
	- the namedev.permission and namedev.config files are renamed to
	  udev.permission and udev.config.  Make sure to realize this if
	  you have customized your rules in the past.
	- man file updates

The biggest stuff is the klibc integration.  If you build with klibc,
the 453K binary shrinks to 45K.  Nothing like a power of ten decrease :)

The rpms are still built with debugging enabled, using glibc, so they do
not get any size savings yet...

Again, many thanks to Dan Stekloff, Kay Sievers, and Robert Love for
their help with patches for this release.  I really appreciate it.

The full ChangeLog can be found below.
 
The udev FAQ can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ
 
Development of udev is done in a BitKeeper tree available at:
	bk://kernel.bkbits.net/gregkh/udev/

I have the initial framework of some regression tests in the bk tree,
but there is a libsysfs bug that is keeping these tests from working
properly right now.  The libsysfs people are working on fixing this.

If anyone ever wants a snapshot of the current tree, due to not using
BitKeeper, or other reasons, is always available at any time by asking.

thanks,

greg k-h


Summary of changes from v004 to v005
============================================


Kay Sievers
  o namedev.c comments + debug patch
  o man page update

Greg Kroah-Hartman:
  o 005 release TAG: v005
  o ignore the klibc/linux symlink
  o add klibc linux symlink info to the README
  o get 'make release' to work properly again
  o added README info for how to build using klibc
  o turn off debugging if we are building with klibc
  o turn off debugging in namedev
  o added vsyslog support to klibc
  o add ftruncate to klibc
  o klibc specific tweaks
  o libsysfs does not need mntent.h in it's header file
  o udev build tweaks to tdb's spinlock code
  o klibc makefile changes
  o build tdb and libsysfs from the same makefile as udev
  o udev-add build cleanups for other libc versions
  o tweak tdb to build within udev better
  o make libsysfs spit debug messages to the same place as the rest of udev
  o make libsysfs build cleanly
  o updated bk ignore list
  o added klibc version 0.82 (cvs tree) to the udev tree
  o makefile fix for now
  o Merge greg@bucket:/home/greg/src/udev into kroah.com:/home/greg/src/udev
  o hm, makefile bug with so many files...  will fix later
  o regression tests starting to be added
  o fix LABEL bug for device files (not class files.)
  o more warning flags to the build
  o got rid of struct device_attr
  o rename namedev.permissions and namedev.config to udev.permissions and udev.config
  o fix dbg line in namedev.c
  o more overrides of config info with env variables if in test mode
  o Fix bug causing udev to sleep forever waiting for dev file to show up
  o change version to 004_bk
  o make config files, sysfs root, and udev root configurable from config variables

Robert Love:
  o udev: sleep_for_dev() bits
  o udev: another canidate for static

