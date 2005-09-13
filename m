Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVIMRtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVIMRtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVIMRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:49:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:44004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964937AbVIMRtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:49:16 -0400
Date: Tue, 13 Sep 2005 10:48:49 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 069 release
Message-ID: <20050913174848.GA6702@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 069 version of udev.  It can be found at:
  	kernel.org/pub/linux/utils/kernel/hotplug/udev-058.tar.gz

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

Note, I _really_ recommend anyone running 2.6.13 or newer to upgrade to
at least the 068 version of udev due to some very nice speed improvemets
(not to mention the fact that the 2.6.12 kernel requires at least the
058 version of udev.)

There have been lots of good bugfixes and new features added since the
last time I announced a udev release, so see the RELEASE-NOTES file for
details, and the changelog below.

udev uses git for its source code control system.  The main udev git
repo can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/hotplug/udev.git
and can be browsed online at:
	http://www.kernel.org/git/?p=linux/hotplug/udev.git

thanks,

greg k-h

Summary of changes from v068 to v069
============================================

Amir Shalem:
  fix typo in firmware_helper

Duncan Sands:
  firmware_helper: fix write count

Kay Sievers:
  *_id: fix zero length in set_str()
  add program name to logged error
  fix exit code of udevinitsend and udevmonitor
  udevd: keep the right order for messages without SEQNUM
  volume_id: don't probe for mac_partition_maps
  udevmonitor: cleanup on exit
  path_id: remove SUSE specific PATH
  update SUSE rules
  add pci_express to bus list
  update SUSE rules
  store ENV{key}="value" exported keys in the database
  fix lookup for name in the udevdb, it should return the devpath
  prepare for new HAL udevdb dump
  print persistent data with "udevinfo -q all"
  change parameter order of udev_db_search_name()
  add and use name_list_cleanup() for cleaning up the string lists
  don't store devpath in udevdb, we don't need it
  add uft8 validation for safe volume label exporting
  start to enforce plain ascii or valid utf8
  use WRITE_END/READ_END for the pipe index
  remove not needed sig_flag for state of signal_pipe
  don't reenter get_udevd_msg() if message is ignored
  rename ...trailing_char() to ...trailing_chars()
  vol_id: ID_LABEL_SAFE will no longer contain fancy characters
  udevd: move some logging to "info" and "err"
  remove special TIMEOUT handling from incoming queue
  udev_test.pl: we replace untrusted chars with '_'
  check the udevdb before assigning a new %e
  update RELEASE-NOTES
  udevinfo: add database export
  write man page masters in DocBook XML
  udevinfo: rename dump() to export()
  test the automatic man page rebuild and checkin
  Makefile: remove all the duplicated rules
  all man pages rewritten to use DocBook XML
  add missing udevsend man page
  also forgot udevmonitor.8
  udevinfo: restore -d option
  scsi_id: rename SYSFS to LIBSYSFS
  add edd_id tool to match BIOS EDD disk information
  move and update libsysfs.txt
  klibc: update to version 1.1.1
  delete cdromsymlinks* - obsoleted by cdrom_id and IMPORT rules
  delete docs/persistent_naming - obsoleted by persistent disk names
  delete old Fedora html page
  add "totally outdated" header to docs/overview :)
  update SUSE rules
  fix useless but funny name_cdrom.pl script to work again
  update TODO
  Makefile: fix prerequisits for $(PROGRAMS)
  Makefile: cleanup install targets
  remove chassis_id program
  fic gcov use and move it into the Makefile
  FAQ: update things that have changed

Thierry Vignaud:
  switch to '==' in raid-devfs.sh


Summary of changes from v067 to v068
============================================

Greg Kroah-Hartman:
  add EXTRAS documentation to the README file.
  Always open the cdrom drive in non-blocking mode in cdrom_id
  cdrom_id: change err() to info() to help with debugging problems

Kay Sievers:
  cleanup some debug output and move to info level + unify select() loops
  move udevmonitor to /usr/sbin
  ENV{TEST}=="1" compares and ENV{TEST}="1" sets the environment
  vol_id: fix sloppy error handling
  fix typo in cdrom_id syslog
  bring std(in|out|err) fd's in a sane state
  fix printed udevmonitor header


Summary of changes from v066 to v067
============================================

Greg Kroah-Hartman:
  added the cdrom.h #defines directly into the cdrom_id.c file

Kay Sievers:
  update SUSE rules
  fix make install, as we don't provide a default rule set anymore
  fix more compiler warnings ...
  fix udevstart event ordering, we want /dev/null very early
  don't fail too bad, if /dev/null does not exist


Summary of changes from v065 to v066
============================================

Greg Kroah-Hartman:
  update gentoo rule file.
  Created cdrom_id program to make it easier to determine cdrom types
  added cdrom_id to the build check
  updated gentoo rule file to handle removable ide devices.
  changed cdrom_id exports to be easier to understand and consistant with other _id programs.
  fix klibc build issue in cdrom_id.c
  Change the gentoo rules to use cdrom_id instead of cdsymlink.sh
  changed location of gentoo helper apps to be /sbin instead of in scripts dir
  tweak the gentoo rules some more.

Kay Sievers:
  add NETLINK define for the lazy distros
  read sysfs attribute also from parent class device
  switch some strlcpy's to memcpy
  allow clean shutdown of udevd
  add flag for reading of precompiled rules
  update distro rules files
  add SUSE rules
  update SUSE rules
  add firmware_helper to load firmware
  more distro rules updates
  update README
  remove example rules and put the dev.d stuff into the run_directory folder
  trivial text cleanups
  update SUSE rules
  split udev_util in several files
  update SUSE rules
  allow logging of all output from executed tools
  add Usage: to udevmonitor and udevcontrol
  move some logging to the info level

Thierry Vignaud:
  fix udevinfo output


Summary of changes from v064 to v065
============================================

Greg Kroah-Hartman:
  Added persistent name rules for block devices to gentoo rule file.
  Added horrible (but fun) path_id script to extras.
  Update gentoo rules file.

Kay Sievers:
  update release notes for next version
  add udevmonitor, to debug netlink+udev events at the same time
  allow RUN to send the environment to a local socket
  fix GGC signed pointer warnings and switch volume_id to stdint


Summary of changes from v063 to v064
============================================

Andre Masella:
  volume_id: add OCFS (Oracle Cluster File System) support

Hannes Reinecke:
  usb_id: fix typo
  add ID_BUS to *_id programs
  create_floppy_devices: add tool to create floppy nodes based on sysfs info

Kay Sievers:
  move code to its own files
  make SYSFS{} usable for all devices
  add padding to rules structure
  allow rules to have labels and skip to next label
  thread unknown ENV{key} match as empty value


Summary of changes from v062 to v063
============================================

Anton Farygin:
  fix typo in GROUP value application

Greg Kroah-Hartman:
  add 'make tests' as I'm always typing that one wrong...
  Really commit the udev_run_devd changes...
  Fixed udev_run_devd to run the /etc/dev.d/DEVNAME/ files too
  fix position of raw rules in gentoo config file

Hannes Reinecke:
  dasd_id: add s390 disk-label prober
  fix usb_id and let scsi_id ignore "illegal request"

Kay Sievers:
  volume_id: remove s390 dasd handling, it is dasd_id now
  trivial fixes for *_id programs
  IMPORT: add {parent} to import the persistent data of the parent device
  allow multiple values to be matched with KEY=="value1|value2"
  udevd: set incoming socket buffer SO_RCVBUF to maximum
  remember mapped rules state
  ata_id: check for empty serial number
  compile dasd only on s390

Ville Skyttä:
  correct default mode documentation in udev


Summary of changes from v061 to v062
============================================

Kay Sievers:
  fix symlink values separated by multiple spaces
  update RELEASE-NOTES
  fix typo in group assignment
  fix default-name handling and NAME="" rules
  add WAIT_FOR_SYSFS key to loop until a file in sysfs arrives
  fix unquoted strings in udevinitsend

Summary of changes from v060 to v061
============================================

Greg Kroah-Hartman:
  Sync up the Debian rules files
  fix cdrom symlink problem in gentoo rules
  Fix ChangeLog titles

Kay Sievers:
  update RELEASE-NOTES
  we want to provide OPTFLAGS
  rename ALARM_TIMEOUT to UDEV_ALARM_TIMEOUT
  udevd: optimize env-key parsing
  don't resolve OWNER, GROUP on precompile if string contains %, $
  set default device node to /dev
  create udevdb files only if somehting interesting happened
  pack parsed rules list
  replace useless defines by inline text
  move rule matches to function
  add usb_id program to generate usb-storage device identifiers
  add IEEE1394 rules to the gentoo rule file
  fake also kernel-name if we renamed a netif
  allow OPTIONS to be recognized for /sys/modules /sys/devices events
  switch gentoo rules to new operators


Summary of changes from v059 to v060
============================================

Greg Kroah-Hartman:
  Fix the gentoo udev rules to allow the box to boot properly

Gustavo Zacarias:
  Udev doesn't properly build with $CROSS

Kay Sievers:
  Keep udevstart from skipping devices without a 'dev' file

Marco d'Itri:
  #define NETLINK_KOBJECT_UEVENT


Summary of changes from v058 to v059
============================================

Greg Kroah-Hartman:
  Update the gentoo rule file
  Fix udevinfo for empty sysfs directories
  Fix makefile to allow 'make release' to work with git

Hannes Reinecke:
  udev: fix netdev RUN handling
  udevcontrol: fix exit code

Kay Sievers:
  prepare RELEASE-NOTES
  add ID_TYPE to the id probers
  add -x to scsi_id to export the queried values in env format
  store the imported device information in the udevdb
  rename udev_volume_id to vol_id and add --export option
  add ata_id to read serial numbers from ATA drives
  IMPORT allow to import program returned keys into the env
  unify execute_command() and execute_program()
  IMPORT=<file> allow to import a shell-var style config-file
  allow rules to be compiled to one binary file
  fix the fix and change the file to wait for to the "bus" link
  fix udevstart and let all events trvel trough udev
  prepare for module loading rules and add MODALIAS key
  remove device node, when type block/char has changed
  Makefile: remove dev.d/ hotplug.d/ from install target
  udevcontrol: add max_childs command
  udevd: control log-priority of the running daemon with udevcontrol
  udeveventrecorder: add small program that writes an event to disk
  klibc: add missing files
  udevinitsend: handle replay messages correctly
  udev man page: add operators
  udevd: allow starting of udevd with stopped exec-queue
  klibc: version 1.0.14
  udev: handle all events - not only class and block devices
  volume_id: use udev-provided log-level
  udev: clear lists if a new value is assigned
  udev: move dev.d/ handling to external helper
  udev: allow final assignments :=
  udevd: improve timeout handling
  Makefile: fix DESTDIR
  udevd: add initsend
  udevd: add udevcontrol
  udevd: listen for netlink events

Stefan Schweizer:
  Dialout group fix for capi devices in the gentoo rules file

