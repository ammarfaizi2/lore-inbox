Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTLQAxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTLQAxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:53:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:5004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262427AbTLQAxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:53:45 -0500
Date: Tue, 16 Dec 2003 16:53:34 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 009 release
Message-ID: <20031217005334.GA8651@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 009 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-009.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-009-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-009-1.src.rpm

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run.  Please see the udev
FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

Please read the FAQ if you have any questions about devfs and udev.
It's been updated a lot in response to all of the confusion about this
topic.

Note:
	The config file format has changed a bit again, sorry...  Any
	udev.rules file you have that contains a "LABEL" rule needs to
	have the sysfs file field prepend a "SYSFS_" string to it.
	Please see the documentation for the LABEL rule for an example
	of what is needed here.

The major changes since the 008 release are:
	- symlinks!!!  We now support an almost infinite number of
	  symlinks for every device node that is created.  See the man
	  page for an example of how to do this.
	- LABEL rules now need a "SYSFS_" string before the name of the
	  sysfs file.  This allows the rules file to be much more
	  free-form and reduced the amount of parsing code in udev.
	- There is now support for DBUS in the tarball.  It is not
	  enabled by default, as it requires the cvs version of DBUS to
	  run properly right now.  To enable it, build with
	  "USE_DBUS=true".
	- updated to the latest version (pre-release) of libsysfs
	- updated to the latest version of klibc.
	- Lots of updates to the extras/multipath and extras/scsi-id
	  tools.  Both authors welcome feedback for their programs.
	  Unfortunately I think I broke both of them due to the libsysfs
	  update, sorry...
	- the rpm package now installs the /etc/init.d/udev script
	  providing a simple way to populate /udev at boot time.  This
	  makes it even easier for people to try udev out, if they
	  haven't yet.

Again, Kay Sievers is just moving through the TODO list with the
addition of the symlink support.  I really appreciate it.  Thanks also
to David Zeuthen for the D-BUS support, and to everyone else who has
submitted patches for this release.

The full ChangeLog can be found below.
 
udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of this tree used to be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
But that box seems to be down now.  Hopefully it will be restored
someday.  If anyone ever wants a tarball of the current bk tree, just
email me.

thanks,

greg k-h


Summary of changes from v008 to v009
============================================

<christophe.varoqui:free.fr>:
  o more extras/multipath changes
  o and more extras/multipath updates
  o more extras/multipath updates
  o yet more extras/multipath
  o more extras/multipath updates
  o extras/multipath update

<david:fubar.dk>:
  o D-BUS patch for udev-008

<eike-hotplug:sf-tec.de>:
  o add init.d/udev to "make install"
  o add init.d/udev to the spec file

Kay Sievers:
  o don't rely on field order in namedev_parse
  o get part of callout return string
  o remove '\n' from end of callout return
  o man-page mention multiple symlinks
  o allow multiple symlinks
  o cleanup man & remove symlink comment
  o experimental (very simple) SYMLINK creation
  o man page beauty
  o pattern match for label method
  o a bug in linefeed removal

<rml:ximian.com>:
  o remove udev from runlevels on uninstall
  o install initscript in udev rpm

Daniel E. F. Stekloff:
  o pre-libsysfs-0.4.0 patch

Greg Kroah-Hartman:
  o signal fixes due to klibc update
  o sync klibc with release 0.95
  o add mol permissions to the debian permissions file
  o update the FAQ with info about bad modprobe events from the devfs scheme
  o some cleanups due to the need for LABEL rules to use "SYSFS_" now
  o Add restart target to the etc/init.d/udev script
  o tweak the config file generation portion of the Makefile a bit
  o change devfs disk name rule from 'disk' to 'disc'
  o add vc support to udev.rules.devfs
  o added a devfs udev config file from Marco d'Itri <md@Linux.IT>
  o set default mode to 0600 to be safer
  o Makefile tweaks for the DBUS build
  o update the FAQ due to the latest devfs mess on lkml and also due to symlinks now working
  o document the different Makefile config options that we have
  o change USE_DBUS to DBUS in Makefile, and disable it by default as it's still to hard to build on all systems
  o fix formatting of udev_dbus.c to use tabs.  Also get it to build properly now
  o move all of the DBUS logic into one file and remove all of the #ifdef crud from the main code
  o 008_bk mark
  o v008 release TAG: v008

Olaf Hering:
  o dump latest klibc into the udev build tree
  o use udevdir in udev.conf

Patrick Mansfield:
  o better allow builds of extras programs under udev
  o update udev extras/scsi_id to version 0.2

