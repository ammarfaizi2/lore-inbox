Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270065AbUJVIQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbUJVIQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269695AbUJVINm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:13:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:22979 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269748AbUJSQfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:35:08 -0400
Date: Tue, 19 Oct 2004 09:34:29 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core patches for 2.6.9
Message-ID: <20041019163429.GA2402@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a bunch of driver core 2.6.9.  They have all been in the -mm
tree for a number of weeks.  They contain:
	- add /sys/kernel for kernel stuff (like the hotplug sequence
	  number).
	- add the kevent code.
	- change the export type of the sysfs and driver core symbols.
	- other good stuff (see below for full list)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/bus.c             |   32 +--
 drivers/base/class.c           |   34 +--
 drivers/base/core.c            |   25 +-
 drivers/base/driver.c          |   14 -
 drivers/base/firmware.c        |    4 
 drivers/base/firmware_class.c  |    4 
 drivers/base/platform.c        |   16 -
 drivers/base/power/main.c      |    2 
 drivers/base/power/resume.c    |    4 
 drivers/base/power/suspend.c   |    4 
 drivers/base/sys.c             |   16 -
 drivers/pci/pci-driver.c       |    2 
 drivers/usb/core/usb.c         |   61 ++----
 drivers/usb/serial/bus.c       |    1 
 fs/super.c                     |   51 +++++
 fs/sysfs/bin.c                 |    4 
 fs/sysfs/dir.c                 |    6 
 fs/sysfs/file.c                |    6 
 fs/sysfs/group.c               |    4 
 fs/sysfs/symlink.c             |    4 
 include/linux/device.h         |    2 
 include/linux/kobject.h        |   74 ++++---
 include/linux/kobject_uevent.h |   64 +++++-
 include/linux/module.h         |   21 +-
 include/linux/netlink.h        |    1 
 include/linux/pci.h            |    2 
 init/Kconfig                   |   38 +++
 kernel/Makefile                |   11 -
 kernel/ksysfs.c                |   64 ++++++
 kernel/module.c                |   21 ++
 lib/Makefile                   |    6 
 lib/kobject.c                  |  149 +--------------
 lib/kobject_uevent.c           |  393 ++++++++++++++++++++++++++++++++++++++---
 33 files changed, 804 insertions(+), 336 deletions(-)
-----

<kay.sievers:vrfy.org>:
  o export of SEQNUM to userspace (creates /sys/kernel)

Andrew Morton:
  o ksysfs warning fix
  o kobject_uevent warning fix

Greg Kroah-Hartman:
  o kevent: add __bitwise kobject_action to help the compiler check for misusages
  o PCI: add "struct module *" to struct pci_driver to show symlink in sysfs for pci drivers
  o USB: add support for symlink from usb and usb-serial driver to its module in sysfs
  o Put symbolic links between drivers and modules in the sysfs tree
  o kevent: add block mount and umount support
  o kevent: standardize on the event types
  o Kobject Userspace Event Notification
  o ksyms: don't implement /sys/kernel/hotplug_seqnum if CONFIG_HOTPLUG is not enabled
  o kobject: hotplug_seqnum is not 64 bits on all platforms, so fix it
  o kobject: fix build error if CONFIG_HOTPLUG is not enabled
  o ksysfs: don't build ksysfs if CONFIG_SYSFS is not enabled
  o kobject: adjust hotplug_seqnum increment to keep userspace and kernel agreeing

Hannes Reinecke:
  o Driver Core: Handle NULL arg for put_device()

Ingo Molnar:
  o module.h build fix

Patrick Mochel:
  o [driver core] Change symbol exports to GPL only in power/suspend.c
  o [driver core] Change symbol exports to GPL only in power/resume.c
  o [driver core] Change symbol exports to GPL only in power/main.c
  o [sysfs] Change symbol exports to GPL only in symlink.c
  o [sysfs] Change symbol exports to GPL only in group.c
  o [sysfs] Change symbol exports to GPL only in file.c
  o [sysfs] Change symbol exports to GPL only in dir.c
  o [sysfs] Change symbol exports to GPL only in bin.c
  o [driver model] Change symbol exports to GPL only in sys.c
  o [driver model] Change symbol exports to GPL only in platform.c
  o [driver model] Change symbol exports to GPL only in firmware.c
  o [driver model] Change symbol exports to GPL only in driver.c
  o [driver model] Change symbol exports to GPL only in core.c
  o [driver model] Change sybmols exports to GPL only in class.c
  o [driver model] Change symbol exports to GPL only in drivers/base/bus.c

Roland Dreier:
  o USB: use add_hotplug_env_var() in core/usb.c
  o kobject: add add_hotplug_env_var()

