Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUHYWkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUHYWkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUHYWi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:38:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:58778 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266065AbUHYWff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:35:35 -0400
Date: Wed, 25 Aug 2004 15:35:04 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] Driver Core patches for 2.6.9-rc1
Message-ID: <20040825223503.GA27072@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some driver core patches for 2.6.9-rc1.  They fix a few minor
error paths, and shrink down the kref code enough to be able to use it
in a kobject.  All of the driver patches have been in the patch few -mm
releases.

I've also put 4 minor I2C patches, and two PCI patches as they need to
make it into the mainline tree soon.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 CREDITS                            |    6 +
 Documentation/driver-model/bus.txt |   78 ++++++----------------
 Documentation/i2c/sysfs-interface  |    2 
 MAINTAINERS                        |   30 ++++++++
 drivers/base/class.c               |    9 +-
 drivers/char/tty_io.c              |   44 +++++++++---
 drivers/i2c/busses/i2c-keywest.c   |    2 
 drivers/i2c/chips/asb100.c         |    4 -
 drivers/i2c/chips/it87.c           |    4 -
 drivers/i2c/chips/lm78.c           |    4 -
 drivers/i2c/chips/lm85.c           |    4 -
 drivers/i2c/chips/w83627hf.c       |    4 -
 drivers/i2c/chips/w83781d.c        |    4 -
 drivers/pci/pci-driver.c           |    7 -
 drivers/pci/probe.c                |    6 +
 drivers/pci/remove.c               |   20 +++--
 drivers/scsi/sd.c                  |  117 +++++++++++++++++++--------------
 drivers/scsi/sr.c                  |   14 +--
 drivers/usb/core/config.c          |    7 +
 drivers/usb/core/message.c         |    4 -
 drivers/usb/core/urb.c             |    8 +-
 drivers/usb/core/usb.h             |    1 
 drivers/usb/host/ehci-mem.c        |    4 -
 drivers/usb/serial/usb-serial.c    |  130 +++++++++++++++++--------------------
 include/linux/device.h             |    1 
 include/linux/kobject.h            |    5 +
 include/linux/kref.h               |    9 --
 include/linux/pci.h                |    2 
 lib/Makefile                       |    7 -
 lib/kobject.c                      |   57 ++++++++++------
 lib/kref.c                         |   29 +++-----
 31 files changed, 346 insertions(+), 277 deletions(-)
-----


<thomas.koeller:baslerweb.com>:
  o Driver Core: fix minor class reference counting issue on the error path

Dmitry Torokhov:
  o kobject: fix kobject_set_name comment

François Romieu:
  o pci-driver: function documentation fix

Greg Kroah-Hartman:
  o kobject: convert struct kobject use kref
  o KREF: make kref_get() return void as it makes sense to do so
  o KREF: fix up the current kref users for the changed api
  o KREF: shrink the size of struct kref down to just a single atomic_t

Jean Delvare:
  o I2C: update kernel credits/maintainers
  o I2C: rename in0_ref to cpu0_vid
  o I2C: keywest class

John Rose:
  o PCI Hotplug: create pci_remove_bus()

Jonathan Corbet:
  o Remove struct bus_type->add()

Olaf Hering:
  o export legacy pty info via sysfs

Robert Love:
  o KOBJECT: add kobject_get_path

