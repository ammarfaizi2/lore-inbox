Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUDNVwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUDNVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:52:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:3730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261857AbUDNVwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:52:23 -0400
Date: Wed, 14 Apr 2004 14:51:47 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.5
Message-ID: <20040414215146.GA25126@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.5.  Almost all of these have been in
the -mm tree for a number of weeks now (the exceptions being the last 4
patches, to the speedtouch driver, and a security fix which has been in
the WOLK kernel for a while.)

Here are the main types of changes:
	- bugfixes.  Lots of these that have been reported numerous
	  times on lkml.
	- uhci fixes
	- gadget driver updates and additions
	- new device ids
	- lots of misc small cleanups

Please pull from:  bk://linuxusb.bkbits.net/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 arch/arm/configs/neponset_defconfig               |    2 
 arch/ia64/configs/generic_defconfig               |    2 
 arch/ia64/configs/zx1_defconfig                   |    2 
 arch/ia64/defconfig                               |    2 
 arch/mips/configs/rm200_defconfig                 |    1 
 arch/parisc/configs/c3000_defconfig               |    2 
 arch/parisc/defconfig                             |    1 
 arch/ppc64/configs/pSeries_defconfig              |    2 
 arch/ppc64/defconfig                              |    2 
 arch/ppc/configs/adir_defconfig                   |    1 
 arch/ppc/configs/common_defconfig                 |    2 
 arch/ppc/configs/lopec_defconfig                  |    1 
 arch/ppc/configs/pmac_defconfig                   |    2 
 arch/ppc/configs/sandpoint_defconfig              |    1 
 arch/ppc/defconfig                                |    2 
 Documentation/input/ff.txt                        |    2 
 Documentation/input/input.txt                     |   70 
 Documentation/input/joystick.txt                  |    4 
 Documentation/usb/linux.inf                       |  200 ++
 drivers/isdn/hisax/hfc_usb.c                      |    8 
 drivers/isdn/hisax/st5481_b.c                     |    6 
 drivers/isdn/hisax/st5481_d.c                     |    8 
 drivers/isdn/hisax/st5481_init.c                  |    4 
 drivers/isdn/hisax/st5481_usb.c                   |   26 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   13 
 drivers/usb/core/config.c                         |  462 +++---
 drivers/usb/core/devices.c                        |    8 
 drivers/usb/core/devio.c                          |  172 +-
 drivers/usb/core/driverfs.c                       |   39 
 drivers/usb/core/hcd.c                            |   21 
 drivers/usb/core/hcd.h                            |    4 
 drivers/usb/core/hcd-pci.c                        |   22 
 drivers/usb/core/hub.c                            |  188 +-
 drivers/usb/core/hub.h                            |   20 
 drivers/usb/core/message.c                        |   77 -
 drivers/usb/core/usb.c                            |  175 +-
 drivers/usb/core/usb.h                            |    4 
 drivers/usb/gadget/dummy_hcd.c                    | 1681 +++++++++++++++++++++-
 drivers/usb/gadget/epautoconf.c                   |  314 ++++
 drivers/usb/gadget/ether.c                        | 1553 ++++++++++++++------
 drivers/usb/gadget/file_storage.c                 |  454 ++---
 drivers/usb/gadget/gadget_chips.h                 |    6 
 drivers/usb/gadget/goku_udc.c                     |    3 
 drivers/usb/gadget/Kconfig                        |   49 
 drivers/usb/gadget/Makefile                       |   16 
 drivers/usb/gadget/ndis.h                         |  187 ++
 drivers/usb/gadget/net2280.c                      |    4 
 drivers/usb/gadget/pxa2xx_udc.c                   |    8 
 drivers/usb/gadget/rndis.c                        | 1384 ++++++++++++++++++
 drivers/usb/gadget/rndis.h                        |  319 ++++
 drivers/usb/gadget/serial.c                       |   21 
 drivers/usb/gadget/usbstring.c                    |    1 
 drivers/usb/gadget/zero.c                         |  211 +-
 drivers/usb/host/ehci-dbg.c                       |    6 
 drivers/usb/host/ehci.h                           |   40 
 drivers/usb/host/ehci-hcd.c                       |   58 
 drivers/usb/host/ehci-hub.c                       |   18 
 drivers/usb/host/ehci-q.c                         |   15 
 drivers/usb/host/Kconfig                          |   11 
 drivers/usb/host/ohci-hcd.c                       |    7 
 drivers/usb/host/ohci-q.c                         |   12 
 drivers/usb/host/uhci-debug.c                     |   22 
 drivers/usb/host/uhci-hcd.c                       |  294 ---
 drivers/usb/host/uhci-hcd.h                       |   44 
 drivers/usb/input/aiptek.c                        |    2 
 drivers/usb/input/ati_remote.c                    |   60 
 drivers/usb/input/hiddev.c                        |   80 -
 drivers/usb/input/kbtab.c                         |    2 
 drivers/usb/input/Kconfig                         |    2 
 drivers/usb/input/Makefile                        |   16 
 drivers/usb/input/powermate.c                     |    2 
 drivers/usb/input/wacom.c                         |    2 
 drivers/usb/input/xpad.c                          |    2 
 drivers/usb/Makefile                              |    3 
 drivers/usb/media/Kconfig                         |    2 
 drivers/usb/media/vicam.c                         |   14 
 drivers/usb/media/w9968cf.c                       |   12 
 drivers/usb/misc/cytherm.c                        |  433 +++++
 drivers/usb/misc/Kconfig                          |   13 
 drivers/usb/misc/Makefile                         |    3 
 drivers/usb/misc/speedtch.c                       |   51 
 drivers/usb/misc/usbtest.c                        |    3 
 drivers/usb/net/Kconfig                           |    2 
 drivers/usb/net/rtl8150.c                         |  115 +
 drivers/usb/net/usbnet.c                          |    3 
 drivers/usb/serial/ftdi_sio.c                     |   96 +
 drivers/usb/serial/ftdi_sio.h                     |   49 
 drivers/usb/serial/io_ti.c                        |    2 
 drivers/usb/serial/kobil_sct.c                    |   16 
 drivers/usb/serial/omninet.c                      |    4 
 drivers/usb/serial/pl2303.c                       |   10 
 drivers/usb/serial/visor.c                        |   65 
 drivers/usb/serial/whiteheat.c                    |   11 
 drivers/usb/storage/datafab.c                     |    4 
 drivers/usb/storage/transport.c                   |    5 
 drivers/usb/storage/unusual_devs.h                |   42 
 drivers/usb/usb-skeleton.c                        |    2 
 include/linux/pci_ids.h                           |    6 
 include/linux/usb_ch9.h                           |   14 
 include/linux/usb_gadget.h                        |    9 
 include/linux/usb.h                               |   25 
 101 files changed, 7553 insertions(+), 1925 deletions(-)
-----

<alessandro.zummo:towertech.it>:
  o USB: omninet patch

<coreyed:linxtechnologies.com>:
  o USB: add ftdi_sio product ids

<erik:rigtorp.com>:
  o USB: new cypress thermometer driver

<info:gudeads.com>:
  o USB: more ftdi_sio ids

<jan:ccsinfo.com>:
  o USB: more ftdi devices

<m.c.p:kernel.linux-systeme.com>:
  o USB: fix CAN-2004-0075

<mail:gude.info>:
  o USB: FTDI 232BM "USB-RS232 OptoBridge"

<martin.lubich:gmx.at>:
  o USB: Patch for Clie TH55 Support in visor kernel module

<mochel:digitalimplant.org>:
  o USB:  Fix drivers/usb/net/Kconfig

<patrick.boettcher:desy.de>:
  o USB: fix bug in usb-skeleton.c

<rml:ximian.com>:
  o USB: add missing usb entries to sysfs

<thoffman:arnor.net>:
  o USB: fix race in ati_remote and small cleanup

Alan Stern:
  o USB: Updated unusual_dev.h entry
  o USB Gadget: Rename the dummy_hcd's gadget
  o USB: Complete all URBs in UHCI when releasing the bus
  o USB Gadget: Use automatic endpoint selection in file-storage
  o USB Gadget: Use configuration-buffer library in file-storage
  o USB: Altsetting update for USB input drivers
  o USB: Add dummy_hcd to the main kernel
  o USB: UHCI: Get rid of excessive spinlocks
  o USB: UHCI: Improved handling of short control transfers
  o USB: UHCI: Do short packet detection correctly
  o USB: Don't trust raw descriptor length in devioc
  o USB: Unusual_devs.h update
  o USB: Regularize unusual_devs entries for Genesys Logic
  o USB: Unusual_devs update
  o USB: Code improvements for core/config.c
  o USB: Improve core/config.c error messages

Andrew Morton:
  o USB: drivers/usb/gadget/epautoconf.c gcc-3.5 build fix

Andries E. Brouwer:
  o USB Storage: datafab fix and unusual devices

Arjan van de Ven:
  o USB: fix race in whiteheat serial driver
  o USB: usb hiddev stack usage patch

Dave Jones:
  o USB: w9968cf driver misplaced ;
  o USB: kill off CONFIG_USB_BRLVGER detritus

David Brownell:
  o USB: fix xsane breakage, hangs on device scan at launch
  o USB: retry some descriptor fetches
  o USB: usbcore blinkenlights
  o USB Gadget: ethernet/rndis gadget updates
  o USB: ehci updates:  CONFIG_PCI, integrated TT
  o USB: remove usb_interface.driver field
  o USB: RNDIS/Ethernet Gadget Driver .inf file
  o USB: fix dvb-ttusb-budget driver due to set_configuration locking cleanups
  o USB: RNDIS/Ethernet Gadget Driver comment changes
  o USB: set_configuration locking cleanups
  o USB Gadget: RNDIS/Ethernet Gadget Driver (2/2)
  o USB Gadget: RNDIS/Ethernet Gadget Driver (1/2)
  o USB: ohci unlink tweaks
  o USB: usb/core/config.c null pointers after kfree
  o USB; minor usbfs locking updates
  o USB: ohci misc updates
  o USB: g_ether does endpoint autoconfig too
  o USB: usbnet, minor probe() fault fix
  o USB: define USB feature bit indices
  o USB: fix osdl bugid 2006 (timer init and fault paths)
  o USB: fix osdl bugid 481 (USB boot messages)
  o USB: USB gadgets can autoconfigure endpoints
  o USB: gadget zero does endpoint autoconfig

Deepak Saxena:
  o IXP425 -> IXP4XX conversion for USB-gadget

Duncan Sands:
  o USB speedtouch: bump the version number
  o USB speedtouch: fix memory leak in error path
  o USB speedtouch: turn on debugging if CONFIG_USB_DEBUG is set

Greg Kroah-Hartman:
  o USB: fix empty write issue in pl2303 driver
  o USB: fix pl2303 handling of status bits
  o USB: fix up previous sysfs patch to actually compile
  o USB: add usb_get_intf() and usb_put_intf() functions as they will be needed
  o USB: clean up usb_get_dev() as it was written quite horribly
  o USB: remove "released" field from struct usb_interface as it is not needed
  o USB: fix compiler warning in whiteheat driver
  o USB: ftdi_sio merge fixups
  o USB: mark pwc driver as broken, as it is
  o USB: add cytherm driver to the build

Luca Tettamanti:
  o USB: New ID for ftdi_sio

Marcel Holtmann:
  o USB: Rename the USB HID driver

Meelis Roos:
  o USB: fix whiteheat USB serial compile failure on PPC

Michael Still:
  o USB: kernel-doc comment tweak in vicam.c
  o USB: kernel-doc comment tweak

Oliver Neukum:
  o USB: fix hfc_usb sleeping in irq
  o USB: fix typo in previous patch
  o USB: cleanup of st5481
  o USB: fix DMA to stack in ftdi driver
  o USB: fix error paths in kobil_sct
  o USB: race condition in open of w9968cf

Paulo Marques:
  o USB: ftdi_sio.c: not unlinking urb on ftdi_close

Petko Manolov:
  o USB: rtl8150 update

