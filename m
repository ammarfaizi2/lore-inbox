Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbULHS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbULHS7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbULHS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:59:22 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46223 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261305AbULHS7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:59:10 -0500
Date: Wed, 8 Dec 2004 10:58:56 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 047 release
Message-ID: <20041208185856.GA26734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 047 version of udev.  It can be found at:
  	kernel.org/pub/linux/utils/kernel/hotplug/udev-046.tar.gz

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

Lots of changes here in this release, see the full changelog below.
Highlights are:
	- massive change with the way udevd can now work.  See
	  http://thread.gmane.org/gmane.linux.hotplug.devel/6173 for
	  more details on this (Kay's changes are now part of udev
	  proper, you don't have to apply anything for this to work,
	  just follow the directions in
	  http://article.gmane.org/gmane.linux.hotplug.devel/6192
	  to enable this mode.)
	- wait_for_sysfs is now gone.
	- bugfixes and rules file tweaks
	- add ability to handle expressions in GROUP rules.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h

Summary of changes from v046 to v047
============================================

<klauser:access.unizh.ch>:
  o Various typos and other litte errors in udev.8.in

<sjoerd:spring.luon.net>:
  o DEVNAME on device removal

<sschweizer:gmail.com>:
  o Allow GROUP to have modifiers in it

Greg Kroah-Hartman:
  o add more debian rules files
  o move distro specific config files into their own directories
  o update debian rules files
  o added asterix rules to the gentoo file
  o use udevstart for udev.init.* files
  o delete a bunch of files no longer needed
  o fix gentoo scsi cdrom rule
  o Fix the multithreaded build again
  o merge
  o comment out ability to run udev-test.pl with valgrind
  o fix spurious valgrind warning in udev
  o fix udevinfo '-q path' option as it was not working
  o merge
  o fix parallel build error

Kay Sievers:
  o update Fedora dev.d/ example and remove unused conf.d/ directory
  o don't install distribution specific init script on "make install"
  o restore OWNER/GROUP assignment in rule coming from RESULT
  o make gcov compile scripts working with recent gcc
  o fix udev-test/udev-test.pl to work with again
  o add net/atml and class/ppdev to the wait_for_sysfs exception list
  o add net/nlv* devices to the exception list
  o add "pcmcia" and "fc_transport" to the wait_for_sysfs lists
  o remove unused timestamp field
  o simplify permission handling
  o handle /etc/hotplug.d/ only if the event comes from udevd
  o trivial cleanups and change some comments
  o remove unused variables
  o udevsend/udevd handle events without a subsystem
  o use blacklist on device "remove" and remove dev.d/ call code duplication
  o update the man pages and correct Usage: hints
  o don't call the hotplug scripts with a test run
  o don't call dev.d/ scripts twice, if directory = subsystem
  o remove archive file if we changed something
  o link archive insted of objects
  o rename udev_lib to udev_utils and dev_d to udev_multiplex
  o handle whole hotplug event with udevd/udev
  o integrate wait_for_sysfs in udev
  o make the searched multiplex directories conditionally
  o add MANAGED_EVENT to the forked udev environment
  o export DEVNAME on remove event
  o export udev_log flag to the environment
  o remove my test code
  o add support for /devices-devices without any file to wait for
  o Patch from Alex Riesen <raa.lkml@gmail.com>
  o add a bunch of busses to the list of what to wait for
  o close connection to syslog in forked udevd child
  o udevd exit path cleanup
  o fix network device naming bug


