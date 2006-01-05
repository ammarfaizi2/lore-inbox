Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWAEAtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWAEAtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWAEAtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:49:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:48825 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750936AbWAEAtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:39 -0500
Date: Wed, 4 Jan 2006 16:48:27 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core patches for 2.6.15
Message-ID: <20060105004826.GA17328@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a lot of driver core patches for 2.6.15.  They have all been in
the past few -mm releases with no problems.  They contain the following
things:
	- sysfs fixes.
	- klist fixes.
	- input build fixes.
	- platform driver interface additions
	- uevent and hotplug merge together
	- block device symlink fixes
	- lots of other good stuff, see the changelog below.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The full patch set will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/powerpc/eeh-pci-error-recovery.txt |   31 -
 MAINTAINERS                                      |    6 
 arch/arm/common/amba.c                           |    6 
 arch/ia64/sn/kernel/tiocx.c                      |    4 
 arch/powerpc/kernel/vio.c                        |    2 
 block/genhd.c                                    |   48 +-
 drivers/acpi/container.c                         |    8 
 drivers/acpi/processor_core.c                    |    8 
 drivers/acpi/scan.c                              |   14 
 drivers/base/Kconfig                             |    4 
 drivers/base/bus.c                               |   41 ++
 drivers/base/class.c                             |   68 ++--
 drivers/base/core.c                              |   42 +-
 drivers/base/cpu.c                               |    4 
 drivers/base/dd.c                                |   15 
 drivers/base/firmware_class.c                    |   45 +-
 drivers/base/memory.c                            |   12 
 drivers/base/platform.c                          |   68 ++--
 drivers/base/power/runtime.c                     |    2 
 drivers/ide/ide-cd.c                             |    1 
 drivers/ide/ide-disk.c                           |    1 
 drivers/ide/ide-floppy.c                         |    1 
 drivers/ide/ide-tape.c                           |    1 
 drivers/ide/ide.c                                |   60 +++
 drivers/ieee1394/nodemgr.c                       |   20 -
 drivers/infiniband/core/sysfs.c                  |   16 
 drivers/input/input.c                            |   54 ++-
 drivers/input/serio/serio.c                      |   22 -
 drivers/macintosh/macio_asic.c                   |    4 
 drivers/mmc/mmc_sysfs.c                          |    4 
 drivers/pci/hotplug.c                            |   44 +-
 drivers/pci/pci-driver.c                         |    6 
 drivers/pci/pci.h                                |    4 
 drivers/pcmcia/cs.c                              |   10 
 drivers/pcmcia/ds.c                              |   50 +--
 drivers/pnp/pnpbios/core.c                       |    8 
 drivers/s390/cio/ccwgroup.c                      |    4 
 drivers/s390/cio/device.c                        |    4 
 drivers/s390/crypto/z90main.c                    |    1 
 drivers/scsi/ipr.c                               |    4 
 drivers/usb/core/usb.c                           |   86 ++---
 drivers/usb/host/hc_crisv10.c                    |    2 
 drivers/w1/w1.c                                  |   14 
 fs/partitions/check.c                            |   33 +-
 fs/super.c                                       |   15 
 fs/sysfs/dir.c                                   |    6 
 include/linux/device.h                           |   14 
 include/linux/firmware.h                         |    2 
 include/linux/input.h                            |   81 ++--
 include/linux/kobject.h                          |  110 +++---
 include/linux/kobject_uevent.h                   |   57 ---
 include/linux/platform_device.h                  |    1 
 include/linux/sysctl.h                           |    2 
 include/linux/usb.h                              |    2 
 init/Kconfig                                     |   36 --
 kernel/ksysfs.c                                  |   42 +-
 kernel/sysctl.c                                  |    8 
 lib/klist.c                                      |    2 
 lib/kobject.c                                    |    4 
 lib/kobject_uevent.c                             |  379 ++++++++---------------
 net/bluetooth/hci_sysfs.c                        |    4 
 net/bridge/br_sysfs_if.c                         |    4 
 net/core/net-sysfs.c                             |   76 +---
 scripts/mod/file2alias.c                         |   62 +++
 64 files changed, 921 insertions(+), 868 deletions(-)


Adrian Bunk:
      drivers/base/power/runtime.c: #if 0 dpm_set_power_state()

Alan Stern:
      Hold the device's parent's lock during probe and remove

Andrew Morton:
      kobject_uevent CONFIG_NET=n fix

Dmitry Torokhov:
      Driver Core: Add platform_device_del()
      Driver Core: Rearrange exports in platform.c

Frank Pavlic:
      klist: Fix broken kref counting in find functions

Greg Kroah-Hartman:
      HOTPLUG: always enable the .config option, unless EMBEDDED
      Driver core: Make block devices create the proper symlink name
      Driver core: only all userspace bind/unbind if CONFIG_HOTPLUG is enabled

Kay Sievers:
      remove CONFIG_KOBJECT_UEVENT option
      remove mount/umount uevents from superblock handling
      keep pnpbios usermod_helper away from hotplug_path[]
      add uevent_helper control in /sys/kernel/
      merge kobject_uevent and kobject_hotplug
      driver core: replace "hotplug" by "uevent"
      ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
      net: swich device attribute creation to default attrs

Kumar Gala:
      Allow overlapping resources for platform devices

Paul Jackson:
      driver kill hotplug word from sn and others fix

Rusty Russell:
      Input: add modalias support
      Input: fix add modalias support build error

Steven Rostedt:
      sysfs: handle failures in sysfs_make_dirent

