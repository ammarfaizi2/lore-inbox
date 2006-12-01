Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162169AbWLAXQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162169AbWLAXQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162195AbWLAXQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:16:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:1260 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162169AbWLAXQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:16:33 -0500
Date: Fri, 1 Dec 2006 15:16:20 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver core patches for 2.6.19
Message-ID: <20061201231620.GA7560@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core patches for 2.6.19

They contain:
	- driver core rework to allow code to move over to using 'struct
	  device' instead of 'struct class_device'.  This also entails
	  full backward compatibility for distros that are using older
	  versions of udev.
	- the conversion of a number of subsystems to use 'struct
	  device' (note, the network conversion patches are on hold
	  until some ieee1394 changes get made, which are still in my
	  queue.  That patch will remain in -mm until that happens.)
	- changes in the driver core that are needed by the PPC
	  developers to handle their open-firmware based systems.
	- documentation update for platform devices.
	- other minor cleanups and fixes.

All of these patches have been in the -mm tree for a quite a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h

 Documentation/driver-model/platform.txt |  204 +++++++++++++++-----------
 arch/i386/kernel/cpuid.c                |   20 ++--
 arch/i386/kernel/msr.c                  |   20 ++--
 drivers/acpi/glue.c                     |   20 ++--
 drivers/base/bus.c                      |   34 ++++-
 drivers/base/class.c                    |  166 +++++++++++++---------
 drivers/base/core.c                     |  237 ++++++++++++++++++++++++++++---
 drivers/base/dd.c                       |   92 ++++++++----
 drivers/base/firmware_class.c           |  119 ++++++++--------
 drivers/base/platform.c                 |   48 ++++++
 drivers/base/topology.c                 |   55 ++++---
 drivers/char/hw_random/core.c           |   38 +++---
 drivers/char/mem.c                      |    8 +-
 drivers/char/misc.c                     |   13 +--
 drivers/char/ppdev.c                    |    6 +-
 drivers/char/raw.c                      |   12 +-
 drivers/char/tpm/tpm.c                  |    2 +-
 drivers/char/tty_io.c                   |   19 ++--
 drivers/char/vc_screen.c                |   16 +-
 drivers/char/vt.c                       |   81 +++++------
 drivers/i2c/i2c-dev.c                   |   26 ++--
 drivers/input/serio/serio_raw.c         |    2 +-
 drivers/isdn/gigaset/common.c           |    2 +-
 drivers/isdn/gigaset/gigaset.h          |    2 +-
 drivers/isdn/gigaset/interface.c        |   10 +-
 drivers/isdn/gigaset/proc.c             |   19 ++--
 drivers/mmc/mmc_queue.c                 |    4 +-
 drivers/mmc/mmc_sysfs.c                 |   20 ++--
 drivers/mmc/wbsd.c                      |    6 +-
 drivers/net/ppp_generic.c               |    4 +-
 drivers/video/fbmem.c                   |   16 +-
 drivers/video/fbsysfs.c                 |  163 ++++++++++++----------
 fs/sysfs/dir.c                          |   45 ++++++
 fs/sysfs/file.c                         |    3 +
 include/acpi/acpi_bus.h                 |    2 +-
 include/asm-alpha/device.h              |    7 +
 include/asm-arm/device.h                |    7 +
 include/asm-arm26/device.h              |    7 +
 include/asm-avr32/device.h              |    7 +
 include/asm-cris/device.h               |    7 +
 include/asm-frv/device.h                |    7 +
 include/asm-generic/device.h            |   12 ++
 include/asm-h8300/device.h              |    7 +
 include/asm-i386/device.h               |   15 ++
 include/asm-ia64/device.h               |   15 ++
 include/asm-m32r/device.h               |    7 +
 include/asm-m68k/device.h               |    7 +
 include/asm-m68knommu/device.h          |    7 +
 include/asm-mips/device.h               |    7 +
 include/asm-parisc/device.h             |    7 +
 include/asm-powerpc/device.h            |    7 +
 include/asm-ppc/device.h                |    7 +
 include/asm-s390/device.h               |    7 +
 include/asm-sh/device.h                 |    7 +
 include/asm-sh64/device.h               |    7 +
 include/asm-sparc/device.h              |    7 +
 include/asm-sparc64/device.h            |    7 +
 include/asm-um/device.h                 |    7 +
 include/asm-v850/device.h               |    7 +
 include/asm-x86_64/device.h             |   15 ++
 include/asm-xtensa/device.h             |    7 +
 include/linux/device.h                  |   35 ++++-
 include/linux/fb.h                      |    8 +-
 include/linux/kobject.h                 |    8 +
 include/linux/miscdevice.h              |    5 +-
 include/linux/mmc/host.h                |    8 +-
 include/linux/module.h                  |    1 +
 include/linux/platform_device.h         |    6 +
 include/linux/sysfs.h                   |    8 +
 include/linux/tty.h                     |    5 +-
 include/sound/core.h                    |    8 +-
 init/Kconfig                            |   20 +++
 kernel/module.c                         |   31 ++++-
 lib/kobject.c                           |   50 +++++++
 lib/kobject_uevent.c                    |   28 +++-
 sound/core/init.c                       |    8 +
 sound/core/pcm.c                        |    7 +-
 sound/core/sound.c                      |   22 ++--
 sound/oss/soundcard.c                   |   16 +-
 sound/sound_core.c                      |    6 +-
 80 files changed, 1418 insertions(+), 607 deletions(-)
 create mode 100644 include/asm-alpha/device.h
 create mode 100644 include/asm-arm/device.h
 create mode 100644 include/asm-arm26/device.h
 create mode 100644 include/asm-avr32/device.h
 create mode 100644 include/asm-cris/device.h
 create mode 100644 include/asm-frv/device.h
 create mode 100644 include/asm-generic/device.h
 create mode 100644 include/asm-h8300/device.h
 create mode 100644 include/asm-i386/device.h
 create mode 100644 include/asm-ia64/device.h
 create mode 100644 include/asm-m32r/device.h
 create mode 100644 include/asm-m68k/device.h
 create mode 100644 include/asm-m68knommu/device.h
 create mode 100644 include/asm-mips/device.h
 create mode 100644 include/asm-parisc/device.h
 create mode 100644 include/asm-powerpc/device.h
 create mode 100644 include/asm-ppc/device.h
 create mode 100644 include/asm-s390/device.h
 create mode 100644 include/asm-sh/device.h
 create mode 100644 include/asm-sh64/device.h
 create mode 100644 include/asm-sparc/device.h
 create mode 100644 include/asm-sparc64/device.h
 create mode 100644 include/asm-um/device.h
 create mode 100644 include/asm-v850/device.h
 create mode 100644 include/asm-x86_64/device.h
 create mode 100644 include/asm-xtensa/device.h

---------------

Adrian Bunk (1):
      Driver core: make drivers/base/core.c:setup_parent() static

Benjamin Herrenschmidt (4):
      Driver core: add notification of bus events
      Driver core: add dev_archdata to struct device
      ACPI: Change ACPI to use dev_archdata instead of firmware_data
      Driver core: Call platform_notify_remove later

Cornelia Huck (3):
      driver core: Introduce device_find_child().
      driver core: Introduce device_move(): move a device to a new parent.
      driver core: Use klist_remove() in device_move()

David Brownell (2):
      Driver core: platform_driver_probe(), can save codespace
      Documentation/driver-model/platform.txt update/rewrite

Greg Kroah-Hartman (17):
      Driver Core: Move virtual_device_parent() to core.c
      Driver core: make old versions of udev work properly
      Driver core: convert vt code to use struct device
      Driver core: convert vc code to use struct device
      Driver core: change misc class_devices to be real devices
      Driver core: convert tty core to use struct device
      Driver core: convert raw device code to use struct device
      I2C: convert i2c-dev to use struct device instead of struct class_device
      Driver core: convert msr code to use struct device
      Driver core: convert cpuid code to use struct device
      Driver core: convert PPP code to use struct device
      Driver core: convert ppdev code to use struct device
      Driver core: convert mmc code to use struct device
      Driver core: convert firmware code to use struct device
      Driver core: convert fb code to use struct device
      Driver core: change mem class_devices to be real devices
      Driver core: convert sound core to use struct device

Heiko Carstens (1):
      cpu topology: consider sysfs_create_group return value

Kay Sievers (7):
      Driver core: fix "driver" symlink timing
      CONFIG_SYSFS_DEPRECATED
      CONFIG_SYSFS_DEPRECATED - bus symlinks
      CONFIG_SYSFS_DEPRECATED - device symlinks
      CONFIG_SYSFS_DEPRECATED - PHYSDEV* uevent variables
      CONFIG_SYSFS_DEPRECATED - class symlinks
      Driver core: show drivers in /sys/module/

Thomas Maier (1):
      sysfs: sysfs_write_file() writes zero terminated data

