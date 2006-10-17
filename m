Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWJQVvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWJQVvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWJQVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:51:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:49034 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750970AbWJQVvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:51:07 -0400
Date: Tue, 17 Oct 2006 14:50:27 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes and drivers for 2.6.18-rc2
Message-ID: <20061017215027.GA12839@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB bugfixes and two new drivers for 2.6.18-rc2.

They include the reverting of the EHCI VIA patch that broke suspend for
the mac mini (I finally have mine up and running, but can't seem to even
suspend the thing yet, let alone worry about resume...)

All of these changes have been in the -mm tree for a while.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/input/xpad.txt                 |  115 +-
 drivers/usb/Makefile                         |    2 
 drivers/usb/atm/cxacru.c                     |    3 
 drivers/usb/atm/speedtch.c                   |   93 +
 drivers/usb/atm/ueagle-atm.c                 |   83 +
 drivers/usb/atm/usbatm.c                     |    5 
 drivers/usb/class/cdc-acm.c                  |   29 
 drivers/usb/class/usblp.c                    |   79 +
 drivers/usb/core/devio.c                     |    8 
 drivers/usb/core/endpoint.c                  |   22 
 drivers/usb/gadget/net2280.c                 |   20 
 drivers/usb/host/ehci-dbg.c                  |    4 
 drivers/usb/host/ehci-hcd.c                  |   70 -
 drivers/usb/host/ehci-hub.c                  |    2 
 drivers/usb/host/ehci-pci.c                  |    2 
 drivers/usb/host/ehci-q.c                    |    6 
 drivers/usb/host/ehci.h                      |   22 
 drivers/usb/host/ohci-pnx4008.c              |    9 
 drivers/usb/host/uhci-hcd.c                  |   44 +
 drivers/usb/input/Kconfig                    |   10 
 drivers/usb/input/Makefile                   |    3 
 drivers/usb/input/hid-core.c                 |   24 
 drivers/usb/input/usbtouchscreen.c           |    4 
 drivers/usb/input/wacom.h                    |    2 
 drivers/usb/input/wacom_sys.c                |   20 
 drivers/usb/input/wacom_wac.c                |  121 +-
 drivers/usb/input/wacom_wac.h                |    2 
 drivers/usb/input/xpad.c                     |  139 +-
 drivers/usb/misc/Kconfig                     |   10 
 drivers/usb/misc/Makefile                    |    1 
 drivers/usb/misc/adutux.c                    |    3 
 drivers/usb/misc/ftdi-elan.c                 |   36 -
 drivers/usb/{input => misc}/trancevibrator.c |    0 
 drivers/usb/net/Kconfig                      |    8 
 drivers/usb/net/Makefile                     |    1 
 drivers/usb/net/asix.c                       |   48 -
 drivers/usb/net/cdc_ether.c                  |    2 
 drivers/usb/net/kaweth.c                     |  204 ++-
 drivers/usb/net/mcs7830.c                    |  534 ++++++++
 drivers/usb/net/usbnet.c                     |   55 +
 drivers/usb/net/usbnet.h                     |    5 
 drivers/usb/serial/Kconfig                   |   13 
 drivers/usb/serial/Makefile                  |    1 
 drivers/usb/serial/airprime.c                |    7 
 drivers/usb/serial/cp2101.c                  |    1 
 drivers/usb/serial/ftdi_sio.c                |  254 ++--
 drivers/usb/serial/mos7720.c                 | 1683 ++++++++++++++++++++++++++
 drivers/usb/serial/mos7840.c                 |    3 
 drivers/usb/serial/sierra.c                  |  697 ++++++++++-
 drivers/usb/storage/unusual_devs.h           |   24 
 50 files changed, 3894 insertions(+), 639 deletions(-)
 rename drivers/usb/{input/trancevibrator.c => misc/trancevibrator.c} (100%)
 create mode 100644 drivers/usb/net/mcs7830.c
 create mode 100644 drivers/usb/serial/mos7720.c

---------------

Adrian Bunk:
      USB: ftdi-elan.c: remove dead code
      USB: mos7840.c: fix a check-after-dereference

Akinobu Mita:
      usb devio: handle class_device_create() error

Alan Stern:
      USB: unusual_devs entry for Nokia 6131
      UHCI: workaround for Asus motherboard
      usbcore: fix refcount bug in endpoint removal
      usbcore: fix endpoint device creation
      USB: unusual_devs entry for Nokia 6234

Alexey Dobriyan:
      USB: drivers/usb/net/*: use BUILD_BUG_ON

Andrew Morton:
      USB: fix usbatm tiny race

Arnd Bergmann:
      USB: driver for mcs7830 (aka DeLOCK) USB ethernet adapter
      usbnet: improve generic ethtool support
      usbnet: add a mutex around phy register access

Chris Malley:
      USB: Support for BT On-Air USB modem in cdc-acm.c

Craig Shelley:
      USB-SERIAL:cp2101 Add new device ID

Daniel Ritz:
      usbtouchscreen: fix data reading for ITM touchscreens

David Brownell:
      USB: ohci-pnx4008 build fixes
      USB: ftdi_sio whitespace fixes

Dominic Cerquetti:
      USB: xpad: dance pad support

Duncan Sands:
      usbatm: fix tiny race
      speedtch: "extended reach"
      cxacru: add the ZTE ZXDSL 852

Eric Sesterhenn:
      USB: BUG_ON conversion for wacom.c
      USB: fix use after free in wacom_sys.c
      USB: fix dereference in drivers/usb/misc/adutux.c
      USB: Memory leak in drivers/usb/serial/airprime.c

Grant Grundler:
      USB: input: extract() and implement() are bit field manipulation routines

Greg Kroah-Hartman:
      USB: revert EHCI VIA workaround patch
      USB: ftdi-elan: fix sparse warnings
      USB: move trancevibrator.c to the proper usb directory
      USB: add USB serial mos7720 driver
      USB: cleanup sierra wireless driver a bit

Jan Luebbe:
      USB: Add device id for Sierra Wireless MC8755

Jan Mate:
      USB Storage: unusual_devs.h entry for Sony Ericsson P990i

Jarek Poplawski:
      USB: fix cdc-acm problems with hard irq? (inconsistent lock state)

Jeff Garzik:
      USB/gadget/net2280: handle sysfs errors

Kevin Lloyd:
      USB: Sierra Wireless driver update

Luiz Fernando N. Capitulino:
      airprime: New device ID.

matthieu castet:
      UEAGLE : be suspend friendly
      UEAGLE : use interruptible sleep
      UEAGLE : comestic changes
      UEAGLE: fix ueagle-atm Oops

Oliver Neukum:
      USB: remove private debug macros from kaweth
      USB: suspend/resume support for kaweth
      USB: fix suspend support for usblp

Ping Cheng:
      USB: Wacom driver updates

Tobias Lorenz:
      USB: Mitsumi USB FDD 061M: UNUSUAL_DEV multilun fix

