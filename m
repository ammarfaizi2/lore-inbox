Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTLCWcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTLCWcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:32:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:3023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262038AbTLCWaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:30:24 -0500
Date: Wed, 3 Dec 2003 14:29:18 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 008 release
Message-ID: <20031203222918.GA13067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 008 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-008.tar.gz

rpms are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-008-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-008-1.src.rpm

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.  Please see the udev
FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

Note:
	The way the configuration files for udev was structured has
	changed a lot.  Previously there were two config files,
	/etc/udev/udev.config and /etc/udev/udev.permissions.  The
	location of these files could be overridden in the build
	process, or at runtime with environment variables.  
	
	Now there is a single config file at /etc/udev/udev.conf.  The
	contents of that file tell udev where its other config files are
	located at (for the rules and permissions) and specify other
	configurable things.  For more details about this file, please
	see the man page, which covers this file and how it is set up.
	Also see the default udev.conf file provided in the release.
	
The major changes since the 007 release are:
	- different structure of the config files (see Note above for
	  more info.)
	- proper handling of the BUS values now (previously they were
	  just ignored.)
	- a basic set of regular expression matching is now supported.
	  See the man page for details about this.
	- permission handling logic has been rewritten to actually work
	  properly with rules that had regular expressions.
	- new '%D' format modifier has been added to make it easier to
	  create devfs like names.
	- automated regression test script added (run the udev-test.pl
	  script in the test/ directory to make sure any changes you
	  make don't break anything else.)

Again, many thanks to Kay Sievers, for lots of great patches in this
release.  I'm really thankful for the automated test script and the
regex matching he has provided.  This release included patches from lots
of other people, all detailed below.

There are a few features coming in the next version of libsysfs that
should help udev out a bunch, but this release is showing how flexible
udev is at in creating different types of device names.  If you haven't
tested udev out yet, thinking it was still to early, I suggest trying
this release out, as it's quite full featured now.

I'm still looking for a devfs naming scheme config file.  Can anyone
verify that udev supports everything yet now or not?  I know I've been
saying this for a few releases now...

The full ChangeLog can be found below.
 
udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of this tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
Many thanks to Dave Jones for managing this.

thanks,

greg k-h


Summary of changes from v007 to v008
============================================

<azarah:nosferatu.za.org>:
  o more config file parsing robustness

<christophe.varoqui:free.fr>:
  o udev-007/extras/multipath update

Arnd Bergmann:
  o Build failure - missing linux/limits.h include?
  o Add format modifier for devfs like naming
  o klibc makefile fixes

Daniel E. F. Stekloff:
  o another patch for path problem
  o quick fix for libsysfs bus
  o libsysfs changes for sysfsutils 0.3.0

Greg Kroah-Hartman:
  o fix up some duplicated function compiler warnings in libsysfs
  o fix some compiler warnings in the tdb code
  o Added Kay's name to the man page
  o update the wildcard documentation in the man page to show the new styles supported
  o fix permission handling logic
  o enable default_mode ability to actually build
  o add support for the default_mode variable, as it is documented
  o show permissions and groups in the label_test
  o remove some items off of the TODO list, as they are now done
  o fix up the tests to work without all of the environ variables
  o get rid of the majority of the debug environment variables
  o Update the man page to show the new config file, it's format, and how to use it
  o fix up the tests to support the rules file name change
  o add support for a main udev config file, udev.conf
  o turn debugging messages off by default
  o split out the namedev config parsing logic to namedev_parse.c
  o rename namedev's get_attr() to be main namedev_name_device() as that's what it really is
  o add devfs like tty rules as an example in the default config file
  o operate on the rules in the order they are in the config file (within the rule type) instead of operating on them backwards.
  o Cset exclude: dsteklof@us.ibm.com|ChangeSet|20031126173159|56255
  o add test for checking the BUS value
  o fix problem where we were not looking at the BUS value
  o add scsi and pci bus links in the test sysfs tree
  o add test and documentation for new %D devfs format modifier
  o changed the default location of the database to /udev/.udev.tdb to be LSB compliant
  o get rid of functions in klibc_fixups that are now in klibc
  o sync up with the 0.84 version of klibc
  o fix udev init.d script to handle all class devices in sysfs
  o fix the test.block and test.tty scripts due to their moveing.  Also add a test.all script
  o 007_bk version change to Makefile
  o v007 release TAG: v007

Kay Sievers:
  o pattern matching for namedev
  o catch replace device by wildcard
  o udev.8 tweak numeric id text
  o udev-test.pl add subdir test
  o namedev.c strcat tweak
  o overall whitespace + debug text conditioning
  o udev-test.pl - tweaks

Martin Hicks:
  o Add -nodefaultlibs while compiling against klibc

Olaf Hering:
  o ARCH detection for ppc

Patrick Mansfield:
  o fix udev parallel builds with klibc

