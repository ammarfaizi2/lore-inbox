Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUBIXN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBIXNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:13:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:50361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265362AbUBIXNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:13:41 -0500
Date: Mon, 9 Feb 2004 15:13:37 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.3-rc1
Message-ID: <20040209231337.GD2393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.3-rc1.  Here are the main types of
changes:
	- remove the usb scanner driver as it's no longer needed and has
	  been broken for quite some time.
	- add new gadget driver
	- usbtest driver update with new tests
	- new UHCI driver maintainer
	- lots of little bug fixes and add support for a few new
	  devices.

Almost all of these (with the exception of the last few added today)
have been in the last few -mm trees with no problems.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/usb-debug.c            |  201 -----
 drivers/usb/image/scanner.c             | 1216 --------------------------------
 drivers/usb/image/scanner.h             |  387 ----------
 MAINTAINERS                             |    4 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c |   30 
 drivers/usb/Makefile                    |    1 
 drivers/usb/class/cdc-acm.c             |    7 
 drivers/usb/core/Makefile               |    2 
 drivers/usb/core/hcd.c                  |   29 
 drivers/usb/core/hcd.h                  |    6 
 drivers/usb/core/hub.c                  |   46 -
 drivers/usb/core/usb.c                  |   78 +-
 drivers/usb/gadget/ether.c              |   38 -
 drivers/usb/gadget/file_storage.c       |   21 
 drivers/usb/gadget/net2280.c            |    8 
 drivers/usb/gadget/pxa2xx_udc.c         |  142 ++-
 drivers/usb/gadget/pxa2xx_udc.h         |   18 
 drivers/usb/host/ehci-hcd.c             |   11 
 drivers/usb/host/hc_sl811_rh.c          |    2 
 drivers/usb/host/ohci-hcd.c             |   45 -
 drivers/usb/host/ohci-hub.c             |    2 
 drivers/usb/host/ohci-omap.c            |   12 
 drivers/usb/host/ohci-pci.c             |    3 
 drivers/usb/host/ohci-q.c               |   35 
 drivers/usb/host/ohci-sa1111.c          |    2 
 drivers/usb/host/uhci-hcd.c             |   10 
 drivers/usb/host/uhci-hcd.h             |    1 
 drivers/usb/image/Kconfig               |   15 
 drivers/usb/image/Makefile              |    1 
 drivers/usb/input/Kconfig               |   13 
 drivers/usb/input/hid-core.c            |    6 
 drivers/usb/media/Kconfig               |   29 
 drivers/usb/media/dsbr100.c             |    6 
 drivers/usb/misc/Kconfig                |    9 
 drivers/usb/misc/usbtest.c              |  779 +++++++++++++++++---
 drivers/usb/misc/uss720.c               |    8 
 drivers/usb/net/Kconfig                 |   18 
 drivers/usb/net/usbnet.c                |  273 ++++---
 drivers/usb/serial/belkin_sa.c          |    4 
 drivers/usb/serial/keyspan.h            |    1 
 drivers/usb/serial/kobil_sct.c          |    4 
 drivers/usb/serial/visor.c              |    3 
 drivers/usb/serial/visor.h              |    3 
 drivers/usb/storage/Kconfig             |    6 
 drivers/usb/storage/datafab.h           |    2 
 drivers/usb/storage/unusual_devs.h      |   11 
 drivers/usb/storage/usb.c               |    2 
 include/linux/usb.h                     |   11 
 48 files changed, 1271 insertions(+), 2290 deletions(-)
-----

<dsaxena:plexity.net>:
  o USB: remove reference to usb_hcd.refcnt in ohci-sa111.c

<scholnik:radar.nrl.navy.mil>:
  o USB: fix Casio digicam entry in unusual_devs.h

<tony:atomide.com>:
  o USB: Update ohci-omap to compile

Adrian Bunk:
  o USB: remove USB_SCANNER from the build

Alan Stern:
  o USB: fix unneeded SubClass entry in unusual_devs.h
  o USB: change uhci maintainer
  o USB gadget: fix usb/gadget/file_storage.c doesn't compile with gcc 2.95
  o USB gadget: file_storage.c -- remove device_unregister_wait()

Andrew Morton:
  o USB: gcc-3.5: drivers/usb/storage/usb.c
  o USB: gcc-3.5: drivers/usb/misc/uss720.c
  o USB: gcc-3.5: drivers/usb/input/hid-core.c
  o USB: gcc-3.5: drivers/usb/gadget/net2280.c

David Brownell:
  o USB: re-factor enumeration/reset paths
  o USB: USB misc OHCI updates
  o USB: usbnet updates (new devices)
  o USB: usbtest updates
  o USB Gadget: pxa2xx_udc updates
  o USB Gadget: ethernet gadget locking tweaks
  o USB: remove pci_unmap_single() calls from usbcore
  o USB: fix Bug 1821: sleeping function called

Greg Kroah-Hartman:
  o USB: fix bug number 1980 about keyspan devices not getting recognized
  o USB: remove scanner driver files
  o USB: add support for the Aceeca Meazura device to the visor driver
  o USB: remove unused usb-debug.c file

Kevin Owen:
  o USB: ehci - clear TT buffer command patch

Markus Demleitner:
  o USB: DSBR-100 tiny patch

Olaf Hering:
  o USB storage: fix sign bug in usb-storage datafab

Oliver Neukum:
  o USB: fix URB leak in belkin driver
  o USB: fix DMA to stack in tt-usb

Petri Koistinen:
  o USB: drivers/usb/media/Kconfig URL fixups
  o USB: drivers/usb/input/Kconfig URI unify
  o USB: drivers/usb/misc/Kconfig URI update & unify: modules.txt
  o USB: drivers/usb/net config URI update and unify
  o USB: usb-storage Kconfig_URL_update

Stephen Hemminger:
  o USB: uhci - unused urbp element
  o USB: fix usb hc and shared irq handling

Tom Rini:
  o USB: mark the scanner driver BROKEN

