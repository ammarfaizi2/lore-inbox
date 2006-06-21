Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbWFUTsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWFUTsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWFUTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:48:43 -0400
Received: from mx1.suse.de ([195.135.220.2]:30640 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932500AbWFUTsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:48:21 -0400
Date: Wed, 21 Jun 2006 12:45:11 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core patches for 2.6.17
Message-ID: <20060621194511.GA23982@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core patches and fixes for 2.6.17.  They contain the
following changes:
	- documentation update
	- add ABI documentation as discussed on lkml
	- add ISA driver core framework
	- add ability for devices to work like class devices
	- let drivers get to tty class device pointer
	- add /sys/hypervisor when needed
	- some mutex conversions
	- some MODALIAS and uevent fixes
	- remove some unused exports
	- make the dev_printk() messags be a bit more informative when
	  we do not have a driver attached to a device yet.

All of these patches have been in the -mm tree for a number of months.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 Documentation/ABI/README                |   77 ++++++++++++
 Documentation/ABI/obsolete/devfs        |   13 ++
 Documentation/ABI/stable/syscalls       |   10 +
 Documentation/ABI/stable/sysfs-module   |   30 ++++
 Documentation/ABI/testing/sysfs-class   |   16 ++
 Documentation/ABI/testing/sysfs-devices |   25 ++++
 Documentation/isdn/README.gigaset       |    7 -
 Documentation/power/devices.txt         |   90 --------------
 block/genhd.c                           |    7 -
 drivers/base/Kconfig                    |    4 
 drivers/base/Makefile                   |    2 
 drivers/base/attribute_container.c      |    8 -
 drivers/base/base.h                     |    9 +
 drivers/base/bus.c                      |   28 +++-
 drivers/base/class.c                    |  112 ++++++++++++------
 drivers/base/core.c                     |  197 +++++++++++++++++++++++++++++++-
 drivers/base/firmware_class.c           |   22 +--
 drivers/base/hypervisor.c               |   19 +++
 drivers/base/init.c                     |    1 
 drivers/base/isa.c                      |  180 +++++++++++++++++++++++++++++
 drivers/base/platform.c                 |   35 +++++
 drivers/base/power/Makefile             |    3 
 drivers/base/power/suspend.c            |   17 ++
 drivers/base/sys.c                      |   51 ++++++++
 drivers/block/cciss.c                   |    1 
 drivers/char/tty_io.c                   |   11 +
 drivers/isdn/gigaset/common.c           |   13 +-
 drivers/isdn/gigaset/gigaset.h          |    1 
 drivers/isdn/gigaset/interface.c        |   10 +
 drivers/isdn/gigaset/proc.c             |   21 ++-
 fs/partitions/check.c                   |    4 
 include/linux/device.h                  |   25 ++--
 include/linux/isa.h                     |   28 ++++
 include/linux/kobject.h                 |    2 
 include/linux/sysdev.h                  |   18 ++
 include/linux/tty.h                     |    4 
 lib/kobject.c                           |    6 
 37 files changed, 907 insertions(+), 200 deletions(-)

---------------

Alan Stern:
      Driver Core: Make dev_info and friends print the bus name if there is no driver

David Brownell:
      Driver Core: CONFIG_DEBUG_PM covers drivers/base/power too
      platform_bus learns about modalias
      remove duplication from Documentation/power/devices.txt
      Driver core: PM_DEBUG device suspend() messages become informative

Greg Kroah-Hartman:
      kobject: make people pay attention to kobject_add errors
      Add kernel<->userspace ABI stability documentation
      CCISS: add device symlink to the block cciss block devices in sysfs
      Driver Core: remove unused exports
      Driver core: change make_class_name() to take kobjects
      Driver core: allow struct device to have a dev_t
      Driver core: add proper symlinks for devices

Hansjoerg Lipp:
      TTY: return class device pointer from tty_register_device()
      i4l gigaset: move sysfs entry to tty class device

Kay Sievers:
      Driver core: bus device event delay
      Driver core: add generic "subsystem" link to all devices

Laura Garcia:
      firmware_class: s/semaphores/mutexes

Michael Holzheu:
      Driver Core: Add /sys/hypervisor when needed

Rene Herman:
      Driver model: add ISA bus

Russell King:
      Driver Core: Fix platform_device_add to use device_add

Shaohua Li:
      Driver Core: Allow sysdev_class have attributes

Stephen Hemminger:
      Driver core: class_device_add needs error checks

