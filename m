Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUHWUp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUHWUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUHWUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:44:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:12167 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267772AbUHWUmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:42:10 -0400
Date: Mon, 23 Aug 2004 13:40:30 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.8
Message-ID: <20040823204029.GA3065@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of various USB fixes and cleanups for 2.6.8.  All
of these patches have been in the past few -mm releases.

Most notable in here is a new ub driver that handles USB storage devices
_without_ using the scsi layer.  Pete's done a nice job with this.

I've also included a totally new usb-skeleton.c driver that reflects the
way the USB code has changed over time, it's a lot smaller and simpler
to understand now.

And there's a few other new drivers, and lots of good bugfixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/DocBook/usb.tmpl         |    1 
 Documentation/usb/sn9c102.txt          |   21 
 MAINTAINERS                            |   14 
 drivers/block/Kconfig                  |   16 
 drivers/block/Makefile                 |    1 
 drivers/block/ub.c                     | 2053 ++++++++++++++++++++++++++++++++-
 drivers/isdn/hisax/st5481_usb.c        |    3 
 drivers/usb/class/audio.c              |   24 
 drivers/usb/class/cdc-acm.c            |   28 
 drivers/usb/class/usb-midi.c           |   52 
 drivers/usb/class/usblp.c              |    4 
 drivers/usb/core/Kconfig               |   11 
 drivers/usb/core/devices.c             |    5 
 drivers/usb/core/devio.c               |   16 
 drivers/usb/core/hcd.c                 |    7 
 drivers/usb/core/hcd.h                 |    2 
 drivers/usb/core/hub.c                 |  617 +++++++++
 drivers/usb/core/hub.h                 |    2 
 drivers/usb/core/inode.c               |   19 
 drivers/usb/core/message.c             |   44 
 drivers/usb/core/urb.c                 |    7 
 drivers/usb/core/usb.c                 |    2 
 drivers/usb/gadget/Kconfig             |    4 
 drivers/usb/gadget/Makefile            |    2 
 drivers/usb/gadget/dummy_hcd.c         |    9 
 drivers/usb/gadget/file_storage.c      |  169 +-
 drivers/usb/gadget/net2280.c           |   42 
 drivers/usb/gadget/net2280.h           |    1 
 drivers/usb/gadget/pxa2xx_udc.c        |    6 
 drivers/usb/gadget/serial.c            |  290 +---
 drivers/usb/host/ehci-hcd.c            |    7 
 drivers/usb/host/ehci-q.c              |   12 
 drivers/usb/host/hc_simple.c           |    5 
 drivers/usb/host/hc_sl811.c            |    8 
 drivers/usb/host/ohci-omap.c           |    2 
 drivers/usb/host/ohci-q.c              |    6 
 drivers/usb/host/uhci-hcd.c            |    6 
 drivers/usb/image/microtek.c           |    4 
 drivers/usb/input/aiptek.c             |    4 
 drivers/usb/input/hid-core.c           |   10 
 drivers/usb/input/kbtab.c              |    7 
 drivers/usb/media/Kconfig              |    8 
 drivers/usb/media/Makefile             |    2 
 drivers/usb/media/dabusb.c             |    4 
 drivers/usb/media/dsbr100.c            |    2 
 drivers/usb/media/ibmcam.c             |   30 
 drivers/usb/media/konicawc.c           |   18 
 drivers/usb/media/ov511.c              |   85 -
 drivers/usb/media/pwc-if.c             |   34 
 drivers/usb/media/se401.c              |    4 
 drivers/usb/media/sn9c102.h            |    9 
 drivers/usb/media/sn9c102_core.c       |   92 -
 drivers/usb/media/sn9c102_pas106b.c    |   80 +
 drivers/usb/media/sn9c102_pas202bcb.c  |  240 +++
 drivers/usb/media/sn9c102_sensor.h     |  133 +-
 drivers/usb/media/sn9c102_tas5110c1b.c |   22 
 drivers/usb/media/sn9c102_tas5130d1b.c |   35 
 drivers/usb/media/stv680.c             |    6 
 drivers/usb/media/ultracam.c           |   16 
 drivers/usb/media/usbvideo.c           |    2 
 drivers/usb/misc/auerswald.c           |    6 
 drivers/usb/misc/legousbtower.c        |  106 -
 drivers/usb/misc/tiglusb.c             |    4 
 drivers/usb/net/pegasus.c              |    4 
 drivers/usb/net/usbnet.c               |    7 
 drivers/usb/serial/cyberjack.c         |   34 
 drivers/usb/serial/ftdi_sio.c          |  122 +
 drivers/usb/serial/ftdi_sio.h          |   17 
 drivers/usb/serial/ipaq.c              |    2 
 drivers/usb/serial/ipaq.h              |    1 
 drivers/usb/serial/pl2303.c            |    2 
 drivers/usb/storage/datafab.c          |   19 
 drivers/usb/storage/datafab.h          |    2 
 drivers/usb/storage/debug.c            |    8 
 drivers/usb/storage/debug.h            |    6 
 drivers/usb/storage/dpcm.c             |    6 
 drivers/usb/storage/dpcm.h             |    2 
 drivers/usb/storage/freecom.c          |   18 
 drivers/usb/storage/freecom.h          |    2 
 drivers/usb/storage/isd200.c           |   71 -
 drivers/usb/storage/isd200.h           |    2 
 drivers/usb/storage/jumpshot.c         |   18 
 drivers/usb/storage/jumpshot.h         |    2 
 drivers/usb/storage/protocol.c         |   25 
 drivers/usb/storage/protocol.h         |   20 
 drivers/usb/storage/scsiglue.c         |   47 
 drivers/usb/storage/scsiglue.h         |    8 
 drivers/usb/storage/sddr09.c           |   21 
 drivers/usb/storage/sddr09.h           |    2 
 drivers/usb/storage/sddr55.c           |   44 
 drivers/usb/storage/sddr55.h           |    2 
 drivers/usb/storage/shuttle_usbat.c    |   42 
 drivers/usb/storage/shuttle_usbat.h    |    2 
 drivers/usb/storage/transport.c        |   41 
 drivers/usb/storage/transport.h        |   11 
 drivers/usb/storage/unusual_devs.h     |   26 
 drivers/usb/storage/usb.c              |   30 
 drivers/usb/storage/usb.h              |   13 
 drivers/usb/usb-skeleton.c             |  622 ++-------
 fs/namei.c                             |    7 
 include/linux/fs.h                     |   10 
 include/linux/usb.h                    |    6 
 include/linux/usb_otg.h                |  116 +
 103 files changed, 4394 insertions(+), 1527 deletions(-)
-----

<juergen:jstuber.net>:
  o USB: LEGO USB Tower, move reset from probe to open

<nas:e-trolley.de>:
  o USB: ipaq module: product id for HTC Himalaya

<phil:ipom.com>:
  o USB: Debug fix in pl2303

Alan Stern:
  o USB: Disallow probing etc. for suspended devices
  o USB: Don't track endpoint halts in usbcore
  o USB: unusual_devs.h update
  o USB: unusual_devs.h update
  o USB: Remove unneeded unusual_devs.h entry
  o USB: Make removable-LUN support a non-test option in the g_file_storage driver
  o USB: Fix NULL-pointer bug in dummy_hcd

Andi Kleen:
  o USB: gcc-3.5 fixes

Dan Aloni:
  o d_unhash consolidation

David Brownell:
  o USB: add <linux/usb_otg.h>
  o USB: autoconf for gadget serial
  o USB: ehci and buggy BIOS handoff
  o USB: hid intervals
  o USB: usb_get_descriptor, more error checks
  o USB: usb hub docs and locktree()
  o USB: add CONFIG_USB_SUSPEND

Domen Puncer:
  o USB: use list_for_each() in core/devices.c
  o USB: use list_for_each() in class/usb-midi.c
  o USB: use list_for_each() in class/audio.c

Duncan Sands:
  o USB: usbfs: check the buffer size in proc_bulk
  o USB: usbfs: drop the device semaphore in proc_bulk and proc_control
  o USB: fix deadlock in hub_reset

Ganesh Varadarajan:
  o USB: fix for ipaq.c

Greg Kroah-Hartman:
  o USB: hook the ub driver up to the sysfs tree so that tools like udev work better
  o USB: fix up gadget driver usage of MODULE_PARM
  o USB: fix up ub.c due to usb_endpoint_running() going away
  o USB: finish up the last of MODULE_PARM to module_param conversions
  o USB: convert a lot of usb drivers from MODULE_PARM to module_param
  o USB: replace old usb-skeleton driver with a rewritten and simpler version
  o USB: fix build error from previous patch
  o USB: fix build error in the cyberjack driver

Harald Welte:
  o USB: Hackish fix for cyberjack driver

Ian Abbott:
  o USB: Add support for FT2232C chip to ftdi_sio
  o USB: ftdi_sio doesn't re-assert DTR modem control line

Johann Cardon:
  o USB: New unusual_devs.h entry

Jon Neal:
  o USB: net2280 minor fixes

Luca Risolia:
  o USB: SN9C10[12] driver update
  o USB: SN9C10[12] driver minor update
  o USB: SN9C10[12] driver update
  o USB: New entry in MAINTAINERS

Marcel Holtmann:
  o USB: fix ub driver

Matthew Dharm:
  o USB Storage: cleanups, mostly
  o USB Storage: improve debugging output in usb-storage
  o USB Storage: fix Genesys Logic based on info from vendor

Nishanth Aravamudan:
  o USB: usbnet: replace schedule_timeout() with msleep()
  o USB: auerswald: replace schedule_timeout() with msleep()
  o USB: ov511: replace schedule_timeout() with msleep()
  o USB: pxa2xx_udc.c: replace schedule_timeout() with msleep()

Oliver Neukum:
  o USB: ACM USB modem on Kernel 2.6.8-rc2

Pete Zaitcev:
  o USB: add ub driver

