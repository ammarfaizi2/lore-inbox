Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUFGXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUFGXPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUFGXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:15:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:12006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265125AbUFGXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:15:41 -0400
Date: Mon, 7 Jun 2004 16:14:41 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 026 release
Message-ID: <20040607231440.GB11257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 026 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-026.tar.gz
(yes, there was a 025 release, I just forgot to announce it, full
 changelog is below)

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

Major changes since 024:
	- lots of minor bugfixes
	- added udev_volume_id from Kay Sievers which is an excellent
	  way to read block volume ids to create udev rules.
	- deleted the dbus and selinux programs as they were not the way
	  to integrate udev with those packages.  DBUS integration
	  with udev is now handled by the HAL project using the
	  /etc/dev.d/ notifiers.
	- update documentation.  Thanks to Daniel Drake for this.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v025 to v026
============================================

Arnd Bergmann:
  o udev rpm fix

Greg Kroah-Hartman:
  o add test for ! in partition name
  o 025_bk mark
  o Update to version 117 of klibc (from version 108)
  o add volume_id ignore rule for bk
  o add volume_id support to the udev.spec file
  o remove dbus and selinux stuff from the udev.spec file
  o delete udev_selinux as it doesn't work properly and is the wrong way to do it
  o Deleted the udev_dbus extra as it didn't really work properly and HAL has a real solution now
  o add udev.permissions.slackware file
  o udevstart: close open directories

Kay Sievers:
  o fix udevd zombies
  o catchup with recent klibc
  o Re: udevsend fallback
  o udev_volume_id update
  o udev callout for reading filesystem labels
  o udev callout for reading filesystem labels
  o udev default config layout changes

Leann Ogasawara:
  o evaluate getenv() return value for udev_config.c

Summary of changes from v024 to v025
============================================

<md:linux.it>:
  o devfs.sh-ide-floppy

<sjoerd:spring.luon.net>:
  o DEVNODE -> DEVNAME transition fixes

Daniel Drake:
  o Update writing udev rules docs

Greg Kroah-Hartman:
  o make dev.d call each directory in the directory chain of the device name, instead of just the whole name
  o add devd_test script
  o add more permissions based on SuSE's recommendations
  o added rules for tun and raw devices
  o add udev conf.d file
  o Switch the default config to point to a directory for the rules and permission files
  o update the Red Hat .dev files to work on other distros
  o add dbus.dev, pam_console.dev and selinux.dev files for /etc/dev.d/default/ usage
  o add hints for red hat users from Leann Ogasawara <ogasawara@osdl.org>
  o add scripts to run gcov for udev from Leann Ogasawara <ogasawara@osdl.org>
  o change permissions on udevd test scripts
  o Fix build process for users who have LC_ALL set to a non-english language
  o Added expanded tests to the test framework from Leann Ogasawara <ogasawara@osdl.org>
  o added execelent "writing udev rules" document from Daniel Drake <dan@reactivated.net>
  o added rule to put USB printers in their proper places
  o added rules for CAPI devices
  o added a dev.d alsa script to help people out
  o v024 release TAG: v024

Kay Sievers:
  o fix test regressions
  o udev_selinux changes
  o udevd test script
  o udev_dbus changes
  o fix devpath for netdev

Leann Ogasawara:
  o gcov for udev

