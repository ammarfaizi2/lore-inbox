Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270852AbTHASCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHASCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:02:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:29605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270852AbTHASCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:02:41 -0400
Date: Fri, 1 Aug 2003 11:02:39 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test2
Message-ID: <20030801180239.GA30470@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a bunch of USB fixes for 2.6.0-test2.  There are a lot of audit
patches from Oliver Neukum and Daniele Bellucci.  I've also fixed up the
usb_interface bugs that I introduced when moving to the driver model a
while ago.  David Brownell and Alan Stern have a bunch of host
controller driver and USB core fixes, getting rid of a number of error
messages and stack traces that people are running accross quite
frequently (like when removing a USB device from the system.)

And there are a few other documentation updates and other minor bug
fixes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/usb-serial.txt    |    3 
 drivers/media/video/cpia_usb.c      |    2 
 drivers/usb/Makefile                |    3 
 drivers/usb/class/audio.c           |   37 +--
 drivers/usb/class/bluetty.c         |  178 +++++-----------
 drivers/usb/class/cdc-acm.c         |   14 -
 drivers/usb/class/usb-midi.c        |   12 -
 drivers/usb/class/usblp.c           |   22 +-
 drivers/usb/core/config.c           |   94 +++++---
 drivers/usb/core/devices.c          |    2 
 drivers/usb/core/devio.c            |   17 -
 drivers/usb/core/hcd-pci.c          |   21 +
 drivers/usb/core/hcd.c              |   14 -
 drivers/usb/core/hcd.h              |    4 
 drivers/usb/core/hub.c              |   19 +
 drivers/usb/core/message.c          |  257 ++++++++++++++++--------
 drivers/usb/core/urb.c              |   27 +-
 drivers/usb/core/usb-debug.c        |    2 
 drivers/usb/core/usb.c              |  137 +++++-------
 drivers/usb/core/usb.h              |   13 +
 drivers/usb/gadget/net2280.c        |    2 
 drivers/usb/host/ehci-dbg.c         |   41 +++
 drivers/usb/host/ehci-hcd.c         |   37 +--
 drivers/usb/host/ehci-q.c           |   18 -
 drivers/usb/host/ehci-sched.c       |    2 
 drivers/usb/host/hc_sl811_rh.c      |    5 
 drivers/usb/host/ohci-hcd.c         |    1 
 drivers/usb/host/ohci-pci.c         |    2 
 drivers/usb/host/uhci-hcd.c         |    3 
 drivers/usb/image/scanner.c         |    2 
 drivers/usb/input/aiptek.c          |   10 
 drivers/usb/input/usbkbd.c          |    7 
 drivers/usb/input/usbmouse.c        |    7 
 drivers/usb/input/wacom.c           |    7 
 drivers/usb/input/xpad.c            |    7 
 drivers/usb/media/ibmcam.c          |    4 
 drivers/usb/media/konicawc.c        |    2 
 drivers/usb/media/ov511.c           |    2 
 drivers/usb/media/pwc-ctrl.c        |   40 ---
 drivers/usb/media/pwc-if.c          |  381 ++++++++++++++++--------------------
 drivers/usb/media/pwc-ioctl.h       |    2 
 drivers/usb/media/pwc-misc.c        |    3 
 drivers/usb/media/pwc-uncompress.c  |   17 -
 drivers/usb/media/pwc-uncompress.h  |    2 
 drivers/usb/media/pwc.h             |   25 +-
 drivers/usb/misc/auerswald.c        |    3 
 drivers/usb/misc/brlvger.c          |    2 
 drivers/usb/misc/emi26.c            |    7 
 drivers/usb/misc/usbtest.c          |   11 -
 drivers/usb/net/ax8817x.c           |  136 ++++++------
 drivers/usb/net/catc.c              |    7 
 drivers/usb/net/usbnet.c            |  151 +++++++-------
 drivers/usb/serial/ftdi_sio.c       |   33 ++-
 drivers/usb/serial/ftdi_sio.h       |   10 
 drivers/usb/serial/io_ti.c          |    2 
 drivers/usb/serial/kobil_sct.c      |    2 
 drivers/usb/serial/pl2303.c         |    8 
 drivers/usb/serial/usb-serial.c     |    5 
 drivers/usb/serial/visor.c          |   10 
 drivers/usb/storage/shuttle_usbat.c |  186 ++++++++++-------
 drivers/usb/storage/unusual_devs.h  |    9 
 include/linux/usb.h                 |    7 
 include/linux/usb_gadget.h          |    6 
 sound/usb/usbaudio.c                |  242 +++++++++++++++-------
 sound/usb/usbmixer.c                |    4 
 65 files changed, 1269 insertions(+), 1079 deletions(-)
-----

<ian.abbott:mev.co.uk>:
  o USB: ftdi_sio - additional pids

Alan Stern:
  o USB: Remove usb_set_maxpacket()
  o USB: Use the new enable/disable routines
  o USB: Add functions to enable/disable endpoints, interfaces
  o USB: Rename probe and unbind functions
  o USB: More unusual_devs.h stuff
  o USB: Small fixes for usbtest
  o USB: Rename usb_connect() to usb_choose_address()
  o USB: Fix irq problem in hcd_endpoint_disable()
  o USB:  Proper I/O buffering for the shuttle_usbat subdriver

Daniele Bellucci:
  o USB: Audit usb_register() in drivers/usb/net/catc.c
  o USB: Audit usb_register in usbmouse_init()
  o USB: Audit usb_register() in drivers/usb/input/aiptek.c
  o USB: Audit usb_register() in drivers/usb/input/usbkbd.c
  o USB: Audit usb_register in drivers/usb/input/xpad.c
  o USB: Audit usb_register() in drivers/usb/input/wacom.c
  o USB: Audit usb_register() in drivers/usb/misc/emi26.c
  o USB: Audit usb_register in drivers/usb/class/audio.c

David Brownell:
  o USB: hcd initialization fix
  o USB: usb root hubs need longer timeout
  o USB: ehci-hcd and period=1frame hs interrupts
  o USB: ehci-hcd, show microframe schedules
  o USB: usb_unlink_urb() kerneldoc
  o USB: usb_gadget.h doc fix
  o USB: ehci-hcd, TT fixup
  o USB: usbnet: zaurus c-750, motorola
  o USB: ehci needs a readb() on IDP425 PCI (ARM)
  o USB: usb audio, remove garbage warning

David T. Hollis:
  o USB: ax8817x.c - Fix flags to greatly increase rx performance
  o USB: AX8817x mii/ethtool fixes among others

Greg Kroah-Hartman:
  o USB: fix up ALSA merge due to struct usb_interface changes
  o USB: added support for TIOCM_RI and TIOCM_CD to pl2303 driver and fix stupid bug
  o USB: fix memory leak in auerswald driver
  o Cset exclude: greg@kroah.com|ChangeSet|20030730200104|44589
  o USB: Support sharp zaurus C-750
  o USB: bluetty: remove write_urb_pool logic, fixing locking issues
  o USB: remove funny characters from visor driver after much prodding
  o USB: fix bug if open() fails in usb-serial device
  o USB: AX8817x (USB ethernet) problem in 2.6.0-test1
  o USB: Compile AX8817x driver
  o USB: remove improper use of devinitdata markings for device ids
  o USB: changes due to struct usb_interface changing from a pointer to an array of pointers
  o USB: core cleanups for struct usb_interface changes
  o USB: fix stupid kobject coding error with regards to struct usb_interface

Judd Montgomery:
  o USB: visor.h[c] USB device IDs documentation

Nemosoft Unv.:
  o USB: PWC 8.11

Oliver Neukum:
  o USB: fix race condition in usblp_write
  o USB: cleanup of usblp (release and poll)
  o USB: error return codes in usblp

