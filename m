Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268455AbUJVXaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268455AbUJVXaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUJVX3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:29:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:11945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269247AbUJVX1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:27:41 -0400
Date: Fri, 22 Oct 2004 16:26:58 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.10-rc1
Message-ID: <20041022232658.GA27745@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few USB patches for 2.6.10-rc1.  Hopefully a few odd USB
devices that only would work on Windows will now work on Linux with
these patches.  A few other odd bug fixes are in here too, along with
yet another new driver.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h


 Documentation/devices.txt         |   23 +
 Documentation/usb/error-codes.txt |   43 +-
 Documentation/usb/silverlink.txt  |    6 
 Documentation/usb/w9968cf.txt     |   51 +--
 MAINTAINERS                       |    4 
 drivers/usb/Kconfig               |    2 
 drivers/usb/class/audio.c         |   13 
 drivers/usb/class/usblp.c         |   16 -
 drivers/usb/core/hub.c            |  187 +++++++++---
 drivers/usb/core/message.c        |   16 -
 drivers/usb/core/urb.c            |    9 
 drivers/usb/core/usb.c            |    3 
 drivers/usb/gadget/ether.c        |    2 
 drivers/usb/gadget/file_storage.c |   32 +-
 drivers/usb/gadget/goku_udc.c     |  149 ++++-----
 drivers/usb/gadget/goku_udc.h     |    8 
 drivers/usb/gadget/net2280.c      |    9 
 drivers/usb/gadget/net2280.h      |    8 
 drivers/usb/gadget/omap_udc.c     |  335 ++++++++++++++++-----
 drivers/usb/gadget/omap_udc.h     |    6 
 drivers/usb/gadget/zero.c         |    2 
 drivers/usb/host/Kconfig          |   26 +
 drivers/usb/host/ehci-dbg.c       |   17 -
 drivers/usb/host/ehci-hcd.c       |   77 +++--
 drivers/usb/host/ehci-sched.c     |   13 
 drivers/usb/host/ohci-hcd.c       |    7 
 drivers/usb/host/uhci-hcd.c       |    8 
 drivers/usb/input/Kconfig         |   11 
 drivers/usb/input/hid-core.c      |   27 +
 drivers/usb/media/dabusb.c        |    3 
 drivers/usb/media/w9968cf.h       |    2 
 drivers/usb/misc/Kconfig          |   10 
 drivers/usb/misc/Makefile         |    3 
 drivers/usb/misc/phidgetkit.c     |  581 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/tiglusb.c        |   61 ++-
 drivers/usb/misc/tiglusb.h        |    8 
 drivers/usb/net/kaweth.c          |  136 +++-----
 drivers/usb/net/usbnet.c          |   70 ++--
 drivers/usb/serial/belkin_sa.c    |    1 
 drivers/usb/serial/console.c      |    4 
 drivers/usb/serial/cyberjack.c    |    2 
 drivers/usb/serial/pl2303.c       |    4 
 drivers/usb/serial/pl2303.h       |    3 
 drivers/usb/serial/usb-serial.c   |   72 +---
 drivers/usb/serial/visor.c        |  162 +++++++++-
 drivers/usb/storage/scsiglue.c    |   13 
 include/linux/proc_fs.h           |    1 
 include/linux/ticable.h           |    2 
 48 files changed, 1663 insertions(+), 585 deletions(-)
-----

<philippe.bertin:pandora.be>:
  o USB: Superfluous statement in usb.c

<rco3:2005dauphin.org>:
  o USB: PL2303 - PharosGPS patch

Adrian Bunk:
  o USB: fix usb/serial/console.c compile error

Alan Stern:
  o USB device init: implement the Windows scheme
  o USB file-storage gadget: clean up endian issues
  o USB Gadget: Use proper BCD values
  o UHCI: No bandwidth reclamation during enumeration
  o usbcore: drop reference to bus on allocation error

Dale Farnsworth:
  o USB: USB fixes for non-cache-coherent processors

David Brownell:
  o USB ehci: minor debug cleanups
  o USB ehci: handle earlier endpoint_disable()
  o USB ehci: minor pci tweaks
  o USB input Kconfig updates
  o USB: net2280 compile fixes
  o USB: omap_udc updates
  o USB: ohci module param for broken bios
  o USB: usb error code docs
  o USB: usb/hcd kconfig updates
  o USB: goku_udc sparse updates
  o USB: usb suspend support for hid-core
  o USB: usb hub descriptor fetch needs retries

Greg Kroah-Hartman:
  o USB: fix DoS in the visor driver by rate limiting sends
  o USB: fix build error in the USB core if CONFIG_PROCFS is disabled
  o USB: remove unneeded checks in the usb-serial core
  o USB: add phidgetkit driver
  o USB: update devices.txt with the proper USB minor number information

Luca Risolia:
  o USB: W996[87]CF driver updates

Luiz Capitulino:
  o USB: Module version info for Belkin_sa
  o USB: Module version info for PL2303
  o USB: Module version info for CyberJack

Matthew Dharm:
  o USB Storage: Fix queuecommand() for disconnected devices

Maximilian Attems:
  o USB: dabusb: replace schedule_timeout() with msleep_interruptible()
  o USB: tiglusb: replace schedule_timeout() with msleep_interruptible()

Naoki Shibata:
  o USB: usbnet patch (new ax8817x device)

Oliver Neukum:
  o kaweth: no need for packed
  o kaweth: full conversion to usb_unlink_urb

Pete Zaitcev:
  o USB: usblp BKL removal

Romain Liévin:
  o USB: tiglusb.c: add direct USB support on some new TI handhelds

Stephen Hemminger:
  o USB kaweth: use alloc_etherdev to allocate device private data - fix
  o usbnet: use alloc_etherdev to allocate private data
  o kaweth: use alloc_etherdev to allocate device private

