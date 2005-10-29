Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVJ2DIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVJ2DIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVJ2DIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:08:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:63377 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751113AbVJ2DIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:08:12 -0400
Date: Fri, 28 Oct 2005 20:07:39 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.14
Message-ID: <20051029030739.GA25691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch more USB patches against your latest git tree, they
have all been in the past few -mm releases just fine.  Lots of power
management fixes (but not the patches that blew up Andrew's boxes), one
new driver added, one driver removed (not needed anymore), and a lot of
other misc things.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/DocBook/usb.tmpl              |    2 
 Documentation/input/yealink.txt             |   19 
 Documentation/kernel-parameters.txt         |    2 
 MAINTAINERS                                 |   20 
 drivers/Makefile                            |    2 
 drivers/base/power/main.c                   |   26 
 drivers/base/power/power.h                  |   13 
 drivers/base/power/runtime.c                |    1 
 drivers/block/ub.c                          |    4 
 drivers/pci/quirks.c                        |  253 -----
 drivers/usb/Makefile                        |    2 
 drivers/usb/class/Kconfig                   |   23 
 drivers/usb/class/Makefile                  |    1 
 drivers/usb/class/bluetty.c                 | 1279 ----------------------------
 drivers/usb/class/cdc-acm.c                 |    5 
 drivers/usb/class/usblp.c                   |    3 
 drivers/usb/core/Kconfig                    |   11 
 drivers/usb/core/Makefile                   |    2 
 drivers/usb/core/config.c                   |   22 
 drivers/usb/core/devio.c                    |  190 +++-
 drivers/usb/core/file.c                     |   19 
 drivers/usb/core/hcd-pci.c                  |  106 +-
 drivers/usb/core/hcd.c                      |  165 ++-
 drivers/usb/core/hcd.h                      |   71 -
 drivers/usb/core/hub.c                      |  466 ++++------
 drivers/usb/core/hub.h                      |    2 
 drivers/usb/core/inode.c                    |   44 
 drivers/usb/core/message.c                  |   88 +
 drivers/usb/core/notify.c                   |  120 ++
 drivers/usb/core/sysfs.c                    |  505 +++++++----
 drivers/usb/core/urb.c                      |    3 
 drivers/usb/core/usb.c                      |  175 ++-
 drivers/usb/core/usb.h                      |   33 
 drivers/usb/gadget/dummy_hcd.c              |   24 
 drivers/usb/gadget/ether.c                  |    1 
 drivers/usb/gadget/file_storage.c           |   54 -
 drivers/usb/gadget/goku_udc.c               |    1 
 drivers/usb/gadget/lh7a40x_udc.c            |    1 
 drivers/usb/gadget/net2280.c                |    1 
 drivers/usb/gadget/omap_udc.c               |   13 
 drivers/usb/gadget/pxa2xx_udc.c             |    1 
 drivers/usb/gadget/zero.c                   |    1 
 drivers/usb/host/Makefile                   |    5 
 drivers/usb/host/ehci-hcd.c                 |  553 +-----------
 drivers/usb/host/ehci-hub.c                 |    8 
 drivers/usb/host/ehci-pci.c                 |  423 +++++++++
 drivers/usb/host/ehci.h                     |    1 
 drivers/usb/host/isp116x-hcd.c              |   43 
 drivers/usb/host/isp116x.h                  |    1 
 drivers/usb/host/ohci-au1xxx.c              |   10 
 drivers/usb/host/ohci-dbg.c                 |    4 
 drivers/usb/host/ohci-hcd.c                 |    4 
 drivers/usb/host/ohci-hub.c                 |   52 -
 drivers/usb/host/ohci-lh7a404.c             |   10 
 drivers/usb/host/ohci-mem.c                 |    1 
 drivers/usb/host/ohci-omap.c                |   43 
 drivers/usb/host/ohci-pci.c                 |   49 -
 drivers/usb/host/ohci-ppc-soc.c             |    9 
 drivers/usb/host/ohci-pxa27x.c              |    7 
 drivers/usb/host/ohci-s3c2410.c             |    9 
 drivers/usb/host/ohci-sa1111.c              |    7 
 drivers/usb/host/ohci.h                     |    1 
 drivers/usb/host/pci-quirks.c               |  482 ++++++++--
 drivers/usb/host/sl811-hcd.c                |   17 
 drivers/usb/host/uhci-debug.c               |    5 
 drivers/usb/host/uhci-hcd.c                 |  182 +--
 drivers/usb/host/uhci-hcd.h                 |  100 +-
 drivers/usb/host/uhci-q.c                   |   64 -
 drivers/usb/image/mdc800.c                  |   35 
 drivers/usb/image/microtek.c                |    3 
 drivers/usb/input/aiptek.c                  |    2 
 drivers/usb/input/hid-core.c                |    5 
 drivers/usb/input/hiddev.c                  |    3 
 drivers/usb/input/map_to_7segment.h         |    2 
 drivers/usb/input/touchkitusb.c             |    2 
 drivers/usb/media/dabusb.c                  |    3 
 drivers/usb/misc/auerswald.c                |    3 
 drivers/usb/misc/idmouse.c                  |    5 
 drivers/usb/misc/legousbtower.c             |    5 
 drivers/usb/misc/rio500.c                   |    3 
 drivers/usb/misc/sisusbvga/sisusb.c         |    7 
 drivers/usb/misc/usblcd.c                   |    9 
 drivers/usb/misc/usbtest.c                  |   11 
 drivers/usb/mon/mon_main.c                  |   23 
 drivers/usb/net/Kconfig                     |    2 
 drivers/usb/net/kaweth.c                    |    2 
 drivers/usb/net/pegasus.c                   |    2 
 drivers/usb/net/pegasus.h                   |    2 
 drivers/usb/net/rtl8150.c                   |    1 
 drivers/usb/net/usbnet.c                    |    2 
 drivers/usb/serial/ChangeLog.old            |  730 +++++++++++++++
 drivers/usb/serial/Kconfig                  |    9 
 drivers/usb/serial/Makefile                 |    1 
 drivers/usb/serial/airprime.c               |    8 
 drivers/usb/serial/belkin_sa.c              |   10 
 drivers/usb/serial/bus.c                    |   45 
 drivers/usb/serial/cp2101.c                 |   10 
 drivers/usb/serial/cyberjack.c              |   10 
 drivers/usb/serial/cypress_m8.c             |   20 
 drivers/usb/serial/digi_acceleport.c        |   24 
 drivers/usb/serial/empeg.c                  |    8 
 drivers/usb/serial/ftdi_sio.c               |   16 
 drivers/usb/serial/ftdi_sio.h               |   16 
 drivers/usb/serial/garmin_gps.c             |   15 
 drivers/usb/serial/generic.c                |    9 
 drivers/usb/serial/hp4x.c                   |   10 
 drivers/usb/serial/io_edgeport.c            |  219 ----
 drivers/usb/serial/io_tables.h              |   30 
 drivers/usb/serial/io_ti.c                  |   24 
 drivers/usb/serial/ipaq.c                   |  247 ++---
 drivers/usb/serial/ipw.c                    |   10 
 drivers/usb/serial/ir-usb.c                 |    9 
 drivers/usb/serial/keyspan.h                |   40 
 drivers/usb/serial/keyspan_pda.c            |   30 
 drivers/usb/serial/kl5kusb105.c             |   10 
 drivers/usb/serial/kobil_sct.c              |    9 
 drivers/usb/serial/mct_u232.c               |   10 
 drivers/usb/serial/nokia_dku2.c             |  142 +++
 drivers/usb/serial/omninet.c                |   10 
 drivers/usb/serial/option.c                 |   10 
 drivers/usb/serial/pl2303.c                 |   35 
 drivers/usb/serial/safe_serial.c            |   10 
 drivers/usb/serial/ti_usb_3410_5052.c       |   22 
 drivers/usb/serial/usb-serial.c             |  382 --------
 drivers/usb/serial/usb-serial.h             |   89 -
 drivers/usb/serial/visor.c                  |  170 ---
 drivers/usb/serial/whiteheat.c              |   42 
 drivers/usb/storage/Kconfig                 |    3 
 drivers/usb/storage/shuttle_usbat.c         |  318 +++---
 drivers/usb/storage/shuttle_usbat.h         |   66 -
 drivers/usb/storage/transport.c             |    6 
 drivers/usb/storage/transport.h             |    2 
 drivers/usb/storage/unusual_devs.h          |   44 
 drivers/usb/storage/usb.c                   |  163 +--
 drivers/usb/storage/usb.h                   |    5 
 drivers/usb/usb-skeleton.c                  |    3 
 fs/compat_ioctl.c                           |    1 
 include/asm-i386/mach-summit/mach_mpparse.h |    3 
 include/linux/pci_ids.h                     |    3 
 include/linux/pm.h                          |   14 
 include/linux/usb.h                         |  173 ++-
 include/linux/usb_otg.h                     |   13 
 include/linux/usbdevice_fs.h                |    7 
 143 files changed, 4460 insertions(+), 4851 deletions(-)


Alan Stern:
      USB: UHCI: Remove unused fields and unneeded tests for NULL
      USB: UHCI: Split apart the physical and logical framelist arrays
      USB: UHCI: Spruce up some comments
      USB: usb_bulk_message() handles interrupts endpoints
      USB: File-Storage gadget: use the kthread API
      g_file_storage: fix obscure race condition
      USB: Rename hcd->hub_suspend to hcd->bus_suspend
      UHCI: Improve handling of iso TDs
      UHCI: unify BIOS handoff and driver reset code
      Missing transfer_flags setting in usbtest
      Fix hcd->state assignments in uhci-hcd
      hid-core: Add Clear-Halt on the Interrupt-in endpoint
      USB: Always do usb-handoff
      PATCH: usb-storage: use kthread API
      PATCH: usb-storage: move GetMaxLUN later in time
      PATCH: usb-storage: allocate separate sense buffer
      usbcore: Improve endpoint sysfs file handling
      PATCH: usb-storage: implement minimal PM
      usbcore: Use kzalloc instead of kmalloc/memset
      usbcore: endpoint attributes track altsetting changes
      USB: Fix maxpacket length for ep0 on root hubs
      usbcore: Fix handling of sysfs strings and other attributes
      usbcore: Wrap lines before column 80

Alexey Dobriyan:
      mdc800: remove embrions of C++ exceptions

Andrew Morton:
      USB: sisusb warning fix
      USB: fix pm patches with CONFIG_PM off part 1
      USB: fix pm patches with CONFIG_PM off part 2

Ben Dooks:
      USB: S3C2410 OHCI - add driver owner field
      USB: gadget drivers - add .owner initialisation
      USB: add owner initialisation to host drivers

Borislav Petkov:
      USB: make usb storage note visible in Kconfig

Daniel Drake:
      usb-storage: Readd missing SDDR-05b unusual_devs entry
      USB Storage: HP8200: Another device type detection fix
      usb-storage: Some minor shuttle_usbat cleanups

Daniel Ritz:
      usb/input/touchkit: add more device IDs

David Brownell:
      USB: ehci.patch (earlier irq disable)
      remove usb_suspend_device() parameter
      USB: move handoff code
      remove suspend-path recursion
      usb_interface power state
      remove some USB_SUSPEND dependencies
      remove duplicated resume path code
      one less word in struct device
      usbcore PCI glue updates for PM
      all HCDs provide root hub suspend/resume methods
      root hub changes (lesser half)
      UHCI PM updates
      OHCI PM updates
      update PCI early-handoff handling for OHCI
      root hub updates (greater half)
      stop exporting two functions
      updates for "controller suspended" handling
      ISP116x PM updates
      omap_udc dma off-by-one fix

David Eriksson:
      USB: Improving the set of vendor/product IDs in the ipaq driver

Greg Kroah-Hartman:
      USB: add endpoint information to sysfs
      USB: disable tasklet if rtl8150 device is removed while active.
      devfs: Remove the mode field from usb_class_driver as it's no longer needed
      USB: add more snooping hooks in devio.c
      USB: make wHubCharacteristics __le16 to match other usb descriptor fields
      USB: remove the global function usbdev_lookup_minor
      USB: add notifier functions to the USB core for devices and busses
      USB: convert usbfs/inode.c to use usb notifiers
      USB: convert usbmon to use usb notifiers
      USB: convert usbfs/devio.c to use usb notifiers
      USB: delete the bluetty driver
      USB Serial: rename usb_serial_device_type to usb_serial_driver
      USB Serial: remove driver version from a few drivers
      USB Serial: get rid of the .owner field in usb_serial_driver
      USB Serial: move name to driver structure
      USB Serial: move old changelog comments out of source code
      USB: always export interface information for modalias
      USB: add nokia_dku2 driver
      USB: fix up some odd parts due to partial merges

Guillaume GOURAT /:
      USB: Kaweth.c udelay patch

Henk:
      USB: Buffer overflow patch for Yealink driver

Juha Yrj?l?:
      add usb transceiver set_suspend() method

Koen Kooi:
      USB: fix correct wording in drivers/usb/net/KConfig

Martin Hagelin:
      USB: add new device id to ftdi_sio module

Matt Porter:
      EHCI, split out PCI glue
      USB: Fix usb hub build

Oliver Neukum:
      USB: cdc-acm patch to use kzalloc
      USB: microtek patch to use kzalloc

Pete Zaitcev:
      ub: suppress gcc warnings for pointer casts
      usb: Patch for USBDEVFS_IOCTL from 32-bit programs

Petko Manolov:
      pegasus.h

Phil Dibowitz:
      Add unusual_devs for iPod Nano
      Add unusual_dev for iBeat
      USB Storage: Expand range of Freecom unusual_devs entry

Randy Dunlap:
      safe_serial: use preprocessor directive for error
      usb doc: fix kernel-doc warning

Rui Santos:
      USB: ftdi: Artemis and ATIK based USB astronomical CCD cameras

Simeon Simeonov:
      USB: storage patch for LEICA camera

Thomas Riewe:
      drivers/usb/serial/ftdi_sio: add PID/VID

