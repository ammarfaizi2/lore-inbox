Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTKXAaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 19:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTKXAaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 19:30:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:39577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263539AbTKXAaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 19:30:09 -0500
Date: Sun, 23 Nov 2003 16:29:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 007 release
Message-ID: <20031124002901.GA8679@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 007 version of udev.  It can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-007.tar.gz

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.  Please see the udev
FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

Note:
	The CALLOUT rule format has changed.  If you have a config file
	using this rule, please change it to follow the new order.  See
	the man page for the proper style.

The major changes since the 006 release are:
	- better parsing of the udev.permissions file
	- string owner and group names in the udev.permissions file will
	  now work if you build against glibc.
	- fix the CALLOUT rule to look the same as the other rules.
	- add format char for CALLOUT rule output
	- support arguments in callout exec
	- add ability for CALLOUT program to accept format modifiers.
	- drop Makefile.klibc.  To build using klibc, use:
		make KLIBC=true
	- updated man page documenting new changes.

Again, many thanks to Kay Sievers, for lots of great patches in this
release.  Thanks also to Marco d'Itri and Olaf Hering, both of whom
submitted patches for this release.

I think with the ability to capture the output of the CALLOUT rule,
combined with the ability to put format modifiers in the CALLOUT program
string, we now have everything in place to emulate the existing devfs
naming scheme.  Anyone want to verify this or not?

The full ChangeLog can be found below.
 
udev development is done in a BitKeeper repository loacated at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of this tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
Many thanks to Dave Jones for managing this.

thanks,

greg k-h


Summary of changes from v006 to v007
============================================

<md:linux.it>:
  o fix segfault in parsing bad udev.permissions file

Greg Kroah-Hartman:
  o update default config file with a CALLOUT rule, and more documentation
  o updated the man page with the latest format specifier changes
  o added ability to put format specifiers in the CALLOUT program string
  o tweak udev-test.pl to report '0' errors if that's what happened
  o only build klibc_fixups.c if we are actually using klibc
  o add support for string group and string user names in udev.permissions
  o add getgrnam and getpwnam to klibc_fixups files
  o remove Makefile.klibc
  o add udev-test perl script from Kay Sievers <kay.sievers@vrfy.org> which blows away my puny shell scripts
  o added debian's version of udev.permissions
  o change to 006_bk version

Kay Sievers:
  o format char for CALLOUT output
  o more namedev whitespace cleanups
  o support arguments in callout exec
  o namedev.c - change order of fields in CALLOUT
  o namedev.c whitespace + debug text cleanup
  o man page with udev.permissions wildcard

Olaf Hering:
  o static klibc udev does not link against crt0.o

