Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269801AbUH0A64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269801AbUH0A64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269828AbUH0A4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:56:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:18822 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269781AbUHZXw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:52:57 -0400
Date: Thu, 26 Aug 2004 16:52:41 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.9-rc1
Message-ID: <20040826235241.GA22295@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of various USB fixes and cleanups for 2.6.9-rc1.
Almost all of them were in the last -mm release (the exception being the
gadgetfs update and a cdc-acm driver bugfix.)

There are a number of USB OTG driver additions here, firmware updates
for the edgeport drivers, lots of bugfixes, shrinkage of the struct urb
structure, and sadly, the removal of the PWC video camera driver (as per
the driver author's wishes, it was not my decision.)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/DocBook/gadget.tmpl      |  245 ++-
 Documentation/usb/philips.txt          |  236 --
 Documentation/usb/sn9c102.txt          |   34 
 drivers/block/ub.c                     |   80 
 drivers/i2c/chips/Kconfig              |   12 
 drivers/i2c/chips/Makefile             |    2 
 drivers/i2c/chips/isp1301_omap.c       | 1660 ++++++++++++++++++++
 drivers/net/irda/irda-usb.c            |    3 
 drivers/usb/class/cdc-acm.c            |    2 
 drivers/usb/core/Kconfig               |   26 
 drivers/usb/core/hcd.c                 |   41 
 drivers/usb/core/hcd.h                 |    1 
 drivers/usb/core/hub.c                 |   87 +
 drivers/usb/core/hub.h                 |    4 
 drivers/usb/core/message.c             |   42 
 drivers/usb/core/otg_whitelist.h       |  112 +
 drivers/usb/gadget/Kconfig             |   47 
 drivers/usb/gadget/Makefile            |    2 
 drivers/usb/gadget/ether.c             |   19 
 drivers/usb/gadget/file_storage.c      |    2 
 drivers/usb/gadget/gadget_chips.h      |    6 
 drivers/usb/gadget/inode.c             |  153 +
 drivers/usb/gadget/lh7a40x_udc.c       | 2168 ++++++++++++++++++++++++++
 drivers/usb/gadget/lh7a40x_udc.h       |  261 +++
 drivers/usb/gadget/net2280.c           |   17 
 drivers/usb/gadget/omap_udc.c          | 2695 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/omap_udc.h          |  199 ++
 drivers/usb/gadget/serial.c            |    3 
 drivers/usb/gadget/zero.c              |   13 
 drivers/usb/host/Kconfig               |    1 
 drivers/usb/host/ohci-hcd.c            |    3 
 drivers/usb/host/ohci-hub.c            |   94 +
 drivers/usb/host/ohci-omap.c           |  559 +++---
 drivers/usb/host/ohci-omap.h           |   57 
 drivers/usb/host/ohci-pci.c            |    3 
 drivers/usb/host/ohci-q.c              |    3 
 drivers/usb/host/ohci.h                |    7 
 drivers/usb/host/uhci-hcd.c            |   15 
 drivers/usb/media/Kconfig              |   40 
 drivers/usb/media/Makefile             |    4 
 drivers/usb/media/pwc-ctrl.c           |    9 
 drivers/usb/media/pwc-ctrl.c           | 1635 --------------------
 drivers/usb/media/pwc-if.c             |   35 
 drivers/usb/media/pwc-if.c             | 2158 --------------------------
 drivers/usb/media/pwc-ioctl.h          |  279 ---
 drivers/usb/media/pwc-misc.c           |  146 -
 drivers/usb/media/pwc-uncompress.c     |  180 --
 drivers/usb/media/pwc-uncompress.h     |   84 -
 drivers/usb/media/pwc.h                |    6 
 drivers/usb/media/pwc.h                |  265 ---
 drivers/usb/media/pwc_kiara.h          |  270 ---
 drivers/usb/media/pwc_nala.h           |   66 
 drivers/usb/media/pwc_timon.h          |  270 ---
 drivers/usb/media/sn9c102.h            |    5 
 drivers/usb/media/sn9c102_core.c       |    9 
 drivers/usb/media/sn9c102_pas106b.c    |    6 
 drivers/usb/media/sn9c102_pas202bcb.c  |    6 
 drivers/usb/media/sn9c102_tas5110c1b.c |   31 
 drivers/usb/media/sn9c102_tas5130d1b.c |   37 
 drivers/usb/media/stv680.c             |    1 
 drivers/usb/misc/legousbtower.c        |    6 
 drivers/usb/misc/phidgetservo.c        |   16 
 drivers/usb/misc/usbtest.c             |   31 
 drivers/usb/net/kaweth.c               |    2 
 drivers/usb/serial/io_edgeport.c       |   12 
 drivers/usb/serial/io_fw_down.h        | 1968 ++++++++++++------------
 drivers/usb/serial/io_fw_down3.h       | 1532 +++++++++---------
 drivers/usb/serial/io_tables.h         |   67 
 drivers/usb/serial/io_ti.c             |   12 
 drivers/usb/serial/io_usbvend.h        |  363 +++-
 drivers/usb/storage/transport.c        |    3 
 drivers/usb/storage/unusual_devs.h     |    7 
 include/linux/usb.h                    |    7 
 include/linux/usb_gadget.h             |    6 
 include/linux/usb_otg.h                |    2 
 75 files changed, 10392 insertions(+), 8098 deletions(-)
-----

Al Borchers:
  o USB: update Edgeport io_fw_down3.h
  o USB: update Edgeport io_fw_down.h
  o USB: update Edgeport io_usbvend.h

Alan Stern:
  o USB: Add missing cleanup to usb_register_root_hub()
  o USB: Use 8-byte hub status URB buffer
  o USB: Update unlink testing code in the usbtest driver
  o USB: unusual_devs.h entry
  o USB: Fix submission-error bug in the USB scatter-gather
  o USB: Set QH bit in UHCI framelist entries

Alex Sanks:
  o USB: net2280 patch

Andrew Morton:
  o USB: legousbtower.c module_param fix

David Brownell:
  o USB: gadgetfs minor updates
  o USB: ethernet gadget, minor fixes
  o USB: add omap_udc driver
  o USB: add lh7a40x_udc driver
  o USB: isp1301_omap driver (OTG core)
  o USB: ohci_omap updates
  o USB OTG: doc updates (5/5)
  o USB OTG:  gadget zero (4/5)
  o USB OTG: usbcore enumeration (3/5)
  o USB OTG: ohci reset updates (2/5)
  o USB OTG: add usb_bus_start_enum() (1/5)
  o USB: gadget drivers learn about LH7A40x

Greg Kroah-Hartman:
  o USB: rip out the whole pwc driver as the author wishes to have done
  o USB: rip the pwc decompressor hooks out of the kernel, as they are a GPL violation
  o USB: Remove struct urb->timeout as it does not work
  o USB: fix bad value in kaweth.c driver

Luca Risolia:
  o USB: SN9C10[12] driver update

Matthew Dharm:
  o USB Storage: help vendors count to 1

Oliver Neukum:
  o USB: cdc acm patch

Pete Zaitcev:
  o USB: ub patch to use add_timer

Sean Young:
  o USB: USB PhidgetServo driver update

