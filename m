Return-Path: <linux-kernel-owner+w=401wt.eu-S1030340AbWLTUCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWLTUCG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWLTUCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:02:06 -0500
Received: from cantor.suse.de ([195.135.220.2]:48665 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030340AbWLTUCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:02:04 -0500
Date: Wed, 20 Dec 2006 12:01:29 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.20-rc1
Message-ID: <20061220200129.GA1698@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB patches for 2.6.20-rc1

They include:
	- lots of device id updates
	- lots of tiny bugfixes
	- removal of improper tty ioctl code
	- gadget driver updates

They have all been in the -mm tree for a while.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/kernel-parameters.txt |    8 +
 MAINTAINERS                         |    8 +-
 drivers/bluetooth/hci_usb.c         |    1 +
 drivers/usb/class/usblp.c           |   54 ++--
 drivers/usb/core/devio.c            |    6 +-
 drivers/usb/gadget/at91_udc.c       |  236 ++++++++------
 drivers/usb/gadget/at91_udc.h       |    7 +-
 drivers/usb/gadget/dummy_hcd.c      |    7 +-
 drivers/usb/gadget/file_storage.c   |    2 +-
 drivers/usb/gadget/gmidi.c          |   12 +-
 drivers/usb/gadget/goku_udc.c       |   12 +-
 drivers/usb/gadget/lh7a40x_udc.c    |   13 +-
 drivers/usb/gadget/net2280.c        |   11 +-
 drivers/usb/gadget/omap_udc.c       |   13 +-
 drivers/usb/gadget/pxa2xx_udc.c     |    7 +-
 drivers/usb/gadget/serial.c         |    2 +-
 drivers/usb/host/ohci-at91.c        |    3 +-
 drivers/usb/host/ohci-au1xxx.c      |    4 +-
 drivers/usb/host/ohci-dbg.c         |    8 +-
 drivers/usb/host/ohci-ep93xx.c      |    2 +-
 drivers/usb/host/ohci-hcd.c         |  110 ++-----
 drivers/usb/host/ohci-hub.c         |   21 +-
 drivers/usb/host/ohci-lh7a404.c     |    8 +-
 drivers/usb/host/ohci-mem.c         |   10 +-
 drivers/usb/host/ohci-omap.c        |    4 +-
 drivers/usb/host/ohci-pci.c         |   16 +-
 drivers/usb/host/ohci-pnx4008.c     |    4 +-
 drivers/usb/host/ohci-pnx8550.c     |  258 +++++++++++++++
 drivers/usb/host/ohci-ppc-soc.c     |    8 +-
 drivers/usb/host/ohci-pxa27x.c      |   10 +-
 drivers/usb/host/ohci-q.c           |  103 +++---
 drivers/usb/host/ohci-s3c2410.c     |    4 +-
 drivers/usb/host/ohci-sa1111.c      |    8 +-
 drivers/usb/host/ohci.h             |   92 +++---
 drivers/usb/host/u132-hcd.c         |   92 ++----
 drivers/usb/host/uhci-hcd.c         |   13 +-
 drivers/usb/host/uhci-hub.c         |   14 +-
 drivers/usb/input/wacom_sys.c       |    4 +-
 drivers/usb/input/wacom_wac.c       |   26 +-
 drivers/usb/misc/auerswald.c        |    6 +-
 drivers/usb/misc/ftdi-elan.c        |  592 +++++++++++++++++++++++------------
 drivers/usb/misc/phidgetservo.c     |    1 +
 drivers/usb/misc/trancevibrator.c   |    2 +-
 drivers/usb/net/gl620a.c            |  154 ---------
 drivers/usb/net/rtl8150.c           |    6 +-
 drivers/usb/serial/airprime.c       |    3 +
 drivers/usb/serial/cp2101.c         |    1 +
 drivers/usb/serial/cypress_m8.c     |   15 -
 drivers/usb/serial/ftdi_sio.c       |    1 +
 drivers/usb/serial/ftdi_sio.h       |    5 +-
 drivers/usb/serial/funsoft.c        |   27 ++
 drivers/usb/serial/kl5kusb105.c     |   68 ----
 drivers/usb/serial/mos7840.c        |    6 -
 drivers/usb/serial/option.c         |    3 +
 drivers/usb/storage/unusual_devs.h  |   16 +
 55 files changed, 1195 insertions(+), 932 deletions(-)
 create mode 100644 drivers/usb/host/ohci-pnx8550.c

---------------

Alan (1):
      usb serial: Eliminate bogus ioctl code

Alan Stern (1):
      UHCI: module parameter to ignore overcurrent changes

Andrew Morton (2):
      USB: Nokia E70 is an unusual device
      USB: Nokia E70 is an unusual device

Andrew Victor (3):
      USB: ohci at91 warning fix
      USB: at91 udc, support at91sam926x addresses
      USB: at91_udc, misc fixes

Burman Yan (1):
      USB AUERSWALD: replace kmalloc+memset with kzalloc

Chris Frey (1):
      USB: fix to usbfs_snoop logging of user defined control urbs

David Brownell (3):
      USB: gadget driver unbind() is optional; section fixes; misc
      USB: MAINTAINERS update, EHCI and OHCI
      USB: ohci whitespace/comment fixups

David Clare (1):
      USB: Prevent the funsoft serial device from entering raw mode

Eagle Jones (1):
      USB: airprime: add device id for dell wireless 5500 hsdpa card

Eric Smith (1):
      usb serial: add support for Novatel S720/U720 CDMA/EV-DO modems

Greg Kroah-Hartman (1):
      USB Storage: remove duplicate Nokia entry in unusual_devs.h

Jan Capek (1):
      USB: ftdi_sio - MachX product ID added

Jeff Garzik (1):
      USB: fix ohci.h over-use warnings

Johann Wilhelm (2):
      usb-storage: Ignore the virtual cd-drive of the Huawei E220 USB Modem
      usb-gsm-driver: Added VendorId and ProductId for Huawei E220 USB Modem

Johannes Hoelzl (1):
      Add Baltech Reader ID to CP2101 driver

Oliver Neukum (3):
      USB: fix transvibrator disconnect race
      USB: removing ifdefed code from gl620a
      USB: mutexification of usblp

Olivier Galibert (1):
      bluetooth: add support for another Kensington dongle

Petko Manolov (1):
      USB: rtl8150 new device id

Ping Cheng (1):
      USB: fix Wacom Intuos3 4x6 bugs

Sean Young (1):
      USB: Fix oops in PhidgetServo

Takamasa Ohtake (1):
      USB: ohci handles hardware faults during root port resets

Tony Olech (1):
      USB: u132-hcd/ftdi-elan: add support for Option GT 3G Quad card

Vitaly Wool (1):
      USB: OHCI support for PNX8550

Wojtek Kaniewski (3):
      USB: at91_udc: allow drivers that support high speed
      USB: at91_udc: Cleanup variables after failure in usb_gadget_register_driver()
      USB: at91_udc: Additional checks

