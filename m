Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUAUBmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 20:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUAUBmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 20:42:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:41157 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265797AbUAUBmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 20:42:08 -0500
Date: Tue, 20 Jan 2004 17:42:15 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.1
Message-ID: <20040121014215.GA6416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.1.  There are a number of different
fixes and a few new drivers added.  Some of the highlights are:
	- lots of usb-storage fixes
	- some usb-storage unusual-devs updates
	- added new usbled driver
	- added new goku_udc driver
	- added new usb gadget driver
	- added new emi62 midi driver
	- a ehci driver update for iso devices.
	- lots of other little changes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 CREDITS                                 |   10 
 Documentation/usb/w9968cf.txt           |  151 
 MAINTAINERS                             |    4 
 drivers/usb/Makefile                    |    1 
 drivers/usb/core/buffer.c               |    2 
 drivers/usb/core/driverfs.c             |   91 
 drivers/usb/core/urb.c                  |    2 
 drivers/usb/gadget/Kconfig              |   21 
 drivers/usb/gadget/Makefile             |    3 
 drivers/usb/gadget/goku_udc.c           | 1988 ++
 drivers/usb/gadget/goku_udc.h           |  290 
 drivers/usb/gadget/serial.c             | 2121 ++
 drivers/usb/host/ehci-dbg.c             |   37 
 drivers/usb/host/ehci-hcd.c             |   24 
 drivers/usb/host/ehci-mem.c             |    3 
 drivers/usb/host/ehci-q.c               |   28 
 drivers/usb/host/ehci-sched.c           |  995 -
 drivers/usb/host/ehci.h                 |   86 
 drivers/usb/host/uhci-hcd.c             |   73 
 drivers/usb/input/aiptek.c              |    1 
 drivers/usb/input/hid-core.c            |    1 
 drivers/usb/input/hid-input.c           |    1 
 drivers/usb/input/hid.h                 |    2 
 drivers/usb/input/hiddev.c              |    1 
 drivers/usb/input/kbtab.c               |    1 
 drivers/usb/input/powermate.c           |   21 
 drivers/usb/input/usbkbd.c              |    1 
 drivers/usb/input/usbmouse.c            |    1 
 drivers/usb/input/wacom.c               |    1 
 drivers/usb/input/xpad.c                |    1 
 drivers/usb/media/Kconfig               |   19 
 drivers/usb/media/w9968cf.c             |  836 -
 drivers/usb/media/w9968cf.h             |   58 
 drivers/usb/media/w9968cf_decoder.h     |    2 
 drivers/usb/media/w9968cf_externaldef.h |   13 
 drivers/usb/misc/Kconfig                |   25 
 drivers/usb/misc/Makefile               |    4 
 drivers/usb/misc/emi62.c                |  314 
 drivers/usb/misc/emi62_fw_m.h           | 8852 +++++++++++
 drivers/usb/misc/emi62_fw_s.h           |23752 +++++++++++++++++++++-----------
 drivers/usb/misc/usbled.c               |  181 
 drivers/usb/net/usbnet.c                |   27 
 drivers/usb/serial/cyberjack.c          |   34 
 drivers/usb/serial/ftdi_sio.c           |  159 
 drivers/usb/serial/ftdi_sio.h           |    3 
 drivers/usb/serial/ir-usb.c             |    2 
 drivers/usb/serial/mct_u232.c           |  240 
 drivers/usb/serial/mct_u232.h           |    5 
 drivers/usb/serial/pl2303.c             |    1 
 drivers/usb/serial/pl2303.h             |    3 
 drivers/usb/serial/visor.c              |    3 
 drivers/usb/serial/visor.h              |    1 
 drivers/usb/serial/whiteheat.c          |    1 
 drivers/usb/storage/datafab.c           |  201 
 drivers/usb/storage/jumpshot.c          |  203 
 drivers/usb/storage/scsiglue.c          |  110 
 drivers/usb/storage/scsiglue.h          |    3 
 drivers/usb/storage/sddr09.c            |  167 
 drivers/usb/storage/sddr55.c            |  159 
 drivers/usb/storage/shuttle_usbat.c     |   28 
 drivers/usb/storage/transport.c         |    6 
 drivers/usb/storage/unusual_devs.h      |   28 
 drivers/usb/usb-skeleton.c              |   11 
 63 files changed, 32205 insertions(+), 9208 deletions(-)
-----

<adi:drcomp.erfurt.thur.de>:
  o USB: add Driver for Emagic A6-2 (formerly known as EMI 6|2m)

<awagger:web.de>:
  o USB: fix memory bug in usb-skeleton.c

<drb:med.co.nz>:
  o USB Storage: patch to unusual_devs.h for Pentax Optio 330GS camera

<felipe_alfaro:linuxmail.org>:
  o USB Storage: unusual_devs.h patch for Trumpion MP3 player

<luca.risolia:studio.unibo.it>:
  o USB: W996[87]CF driver update

<pmarques:grupopie.com>:
  o USB: add another PID to ftdi_sio

<rohde:duff.dk>:
  o USB: Missing patch for ftdi_sio.c

<sebek64:post.cz>:
  o USB: fix whiteheat problems

<thomas:stewarts.org.uk>:
  o USB: powermate-payload-size-fix.patch

Adam Kropelin:
  o USB: hiddev HIDIOCGREPORT not blocking in 2.6

Alan Stern:
  o USB Storage: Notify the SCSI layer about device resets
  o USB UHCI: fix broken data toggles for queued control URBs
  o USB Storage: Fix scatter-gather for non READ/WRITE in sddr55
  o USB Storage: Fix scatter-gather for non READ/WRITE in jumpshot
  o USB Storage: Scatter-gather fixes for non READ/WRITE in datafab
  o USB Storage: Remove non s-g pathway from subdriver READ/WRITE
  o USB Storage: Old patches (as129 and as141)
  o USB Storage: unusual_devs.h update
  o USB Storage: another unusual_devs entry
  o USB Storage: another unneeded unusual_devs entry
  o USB storage: unusual_devs.h change

David Brownell:
  o USB: ehci update:  3/3, highspeed iso rewrite
  o USB: ehci update:  2/3, microframe scanning
  o USB: ehci update:  1/3, misc
  o USB: high speed iso maxpacket is 1024 not 1023
  o USB:  EHCI support on MIPS
  o USB: fix kfree in usb-skeleton.c
  o USB: add goku_udc driver (Toshiba TC86C001 USB device)

David T. Hollis:
  o USB: usbnet on 2.6.0 -- needs ax8817x_ethtool_ops

Greg Kroah-Hartman:
  o USB: hook up the other (non-HID) input devices to the input system properly
  o USB: hook up the HID device's struct device to the input system properly
  o USB: fix up compiler warnings and other stuff in the emi62 driver
  o USB: add support for the Clie PEG-TJ25 device
  o USB: add new usb led driver
  o USB: add gadget serial driver from Al Borchers
  o USB: add test for B4000000 to ir-usb driver to fix build issue on some archs
  o USB: fix bug in bMaxPower sysfs file, it should be * 2
  o USB: add a new pl2303 device id
  o USB: add legotower driver to main usb makefile

Matthew Dharm:
  o USB Storage: Sysfs attribute file for max_sectors
  o USB Storage: add sysfs info attribute
  o USB Storage: fix mode-sense handling for 10-byte commands
  o USB Storage: Fix scatter-gather for non READ/WRITE in sddr09

Matthias Bruestle:
  o USB: update the cyberjack driver

Pete Zaitcev:
  o USB: Band-aid for mct_u232 in 2.6.1

