Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUFVR0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUFVR0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUFVRXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:23:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:28331 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265024AbUFVRVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:21:10 -0400
Date: Tue, 22 Jun 2004 10:19:49 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core patches for 2.6.7
Message-ID: <20040622171949.GA1394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a bunch of driver core and i2c patches for 2.6.7 (I merged the
two trees, as they were conflicting in spots.)  They contain:
	- some sysfs and driver model attribute core changes
	- fixes to the kernel where people didn't put a ';' at the end
	  of their driver and device attribute definitions.
	- i2c bug fixes 
	- sysfs class support for raw devices, allowing udev to work
	  with raw devices.  This patch is shipping in the SuSE kernel.
	- other sysfs class support patches.
	- sparse cleanups.

These patches used to be in the -mm tree, until last -mm release where
it conflicted with the scsi code too much.  That merge has been fixed
here.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 MAINTAINERS                       |   18 +-
 arch/i386/kernel/cpuid.c          |  123 +++++++++++----
 arch/i386/kernel/msr.c            |   71 ++++++++
 drivers/base/base.h               |    5 
 drivers/base/bus.c                |  202 ++++++++++++++++--------
 drivers/base/class.c              |  117 +++++++++++---
 drivers/base/class_simple.c       |   12 -
 drivers/base/core.c               |   48 ++---
 drivers/base/driver.c             |   16 -
 drivers/base/firmware.c           |    6 
 drivers/base/firmware_class.c     |   10 -
 drivers/base/init.c               |    4 
 drivers/base/interface.c          |   18 +-
 drivers/base/node.c               |   14 -
 drivers/base/platform.c           |  200 ++++++++++++++++++------
 drivers/base/power/main.c         |   14 -
 drivers/base/power/power.h        |    8 
 drivers/base/power/resume.c       |   12 -
 drivers/base/power/runtime.c      |    8 
 drivers/base/power/shutdown.c     |   18 +-
 drivers/base/power/suspend.c      |   42 ++---
 drivers/base/power/sysfs.c        |   18 +-
 drivers/base/sys.c                |  102 ++++++------
 drivers/char/raw.c                |   25 ++-
 drivers/i2c/busses/i2c-piix4.c    |    2 
 drivers/i2c/chips/asb100.c        |   66 ++++----
 drivers/i2c/chips/it87.c          |  102 ++++++------
 drivers/i2c/chips/lm78.c          |   22 +-
 drivers/i2c/chips/lm85.c          |   26 +--
 drivers/i2c/chips/via686a.c       |   18 +-
 drivers/i2c/chips/w83627hf.c      |  308 ++++++++++++++++++++++++--------------
 drivers/i2c/chips/w83781d.c       |   41 ++---
 drivers/i2c/chips/w83l785ts.c     |    4 
 drivers/i2c/i2c-dev.c             |    7 
 drivers/pci/pci-driver.c          |    1 
 drivers/pci/pci-sysfs.c           |   33 +---
 drivers/pci/pci.h                 |    1 
 drivers/scsi/scsi_debug.c         |   52 +++---
 drivers/scsi/scsi_sysfs.c         |   14 -
 drivers/scsi/scsi_transport_spi.c |    6 
 drivers/usb/core/devio.c          |   19 +-
 fs/sysfs/inode.c                  |    7 
 include/linux/device.h            |   43 ++---
 include/linux/i2c-id.h            |   12 +
 include/linux/module.h            |   19 ++
 include/linux/sysfs.h             |   23 ++
 kernel/module.c                   |  200 ++++++++++++++++++++++++
 47 files changed, 1437 insertions(+), 700 deletions(-)
-----


<frank.a.uepping:t-online.de>:
  o Driver Core: fix struct device::release issue

<jmunsin:iki.fi>:
  o I2C: drivers/i2c/chips/it87.c cleanup patch

Andrew Morton:
  o I2C: w83627hf.c build fix

Dmitry Torokhov:
  o Driver Core: Whitespace fixes
  o Driver Core: Suppress platform device suffixes

Greg Kroah-Hartman:
  o USB: sparse fixups for devio.c
  o merge fixups
  o I2C: sparse cleanups again, based on comments from lkml
  o I2C: sparse cleanups for drivers/i2c/*
  o Driver Core: more whitespace fixups
  o cpuid: fix hotplug cpu remove bug for class device
  o Driver core: finally add a MAINTAINERS entry for it
  o PCI: convert to using dev_attrs for all PCI devices
  o Driver Model: And even more cleanup of silly scsi use of the *ATTR macros
  o Driver Model: Cleanup the i2c driver silly use of the *ATTR macros which just broke
  o Driver Model: More cleanup of silly scsi use of the *ATTR macros
  o Add basic sysfs support for raw devices

Hanna V. Linder:
  o Driver Model: Add class support to msr.c
  o Add cpu hotplug support to cpuid.c
  o Add class support to cpuid.c

Jean Delvare:
  o I2C: Drop out-of-date code in w83781d and w83627hf
  o I2C: update I2C IDs

Jonathan Corbet:
  o Module section offsets in /sys/module

Mark M. Hoffman:
  o I2C: add alternate VCORE calculations for w83627thf and w83637hf
  o I2C: add alternate VCORE calculations for w83627thf and w83637hf

Patrick Mochel:
  o [Driver Model] Add default device attributes to struct bus_type
  o [Driver Model] Add default attributes for struct bus_type
  o [Driver Model] Add default attributes for classes class devices
  o [sysfs] Add attr_name() macro
  o [Driver Model] Fix up silly scsi usage of DEVICE_ATTR() macros
  o [Driver Model] Consolidate attribute definition macros

Russell King:
  o Couple of sysfs patches
  o Add platform_get_resource()

Sebastian Henschel:
  o sysfs: fs/sysfs/inode.c: modify parents ctime and mtime on creation

Vojtech Pavlik:
  o I2C i2c-piix: Don't treat ServerWorks servers as Laptops

