Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUCQA3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUCQA3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:29:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:64387 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261870AbUCQA3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:29:22 -0500
Date: Tue, 16 Mar 2004 16:29:03 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.5-rc1
Message-ID: <20040317002903.GA1175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.5-rc1.  All of these have been in the
past few -mm releases with no problems.  Here are the main types of
changes:
	- remove the brlvger driver as it's no longer needed.
	- lots of alternate setting fixes across a wide range of
	  usb drivers.
	- usb gadget update and fixes
	- lots of small bugfixes and updates.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 CREDITS                                    |   20 
 Documentation/DocBook/gadget.tmpl          |    1 
 Documentation/usb/brlvger.txt              |   36 -
 Documentation/usb/error-codes.txt          |    4 
 Documentation/usb/mtouchusb.txt            |   85 ++
 Documentation/usb/scanner.txt              |  315 --------
 drivers/char/watchdog/pcwd_usb.c           |    2 
 drivers/input/joystick/iforce/iforce-usb.c |    2 
 drivers/isdn/hisax/hfc_usb.c               |   31 
 drivers/net/irda/stir4200.c                |   95 +-
 drivers/usb/class/audio.c                  |  157 ++--
 drivers/usb/class/bluetty.c                |    2 
 drivers/usb/class/cdc-acm.c                |    6 
 drivers/usb/class/usblp.c                  |   16 
 drivers/usb/class/usb-midi.c               |   93 --
 drivers/usb/core/buffer.c                  |   16 
 drivers/usb/core/config.c                  |    9 
 drivers/usb/core/devio.c                   |   21 
 drivers/usb/core/driverfs.c                |    8 
 drivers/usb/core/hcd.c                     |    4 
 drivers/usb/core/hcd-pci.c                 |    4 
 drivers/usb/core/hub.c                     |   12 
 drivers/usb/core/message.c                 |   87 +-
 drivers/usb/core/urb.c                     |   65 +
 drivers/usb/core/usb.c                     |   84 +-
 drivers/usb/gadget/config.c                |  118 +++
 drivers/usb/gadget/ether.c                 |  153 +---
 drivers/usb/gadget/gadget_chips.h          |   57 +
 drivers/usb/gadget/Kconfig                 |   19 
 drivers/usb/gadget/Makefile                |    4 
 drivers/usb/gadget/net2280.c               |    5 
 drivers/usb/gadget/usbstring.c             |   92 ++
 drivers/usb/gadget/zero.c                  |  193 ++---
 drivers/usb/host/ehci-dbg.c                |    6 
 drivers/usb/host/ehci.h                    |   14 
 drivers/usb/host/ehci-hcd.c                |    8 
 drivers/usb/host/ehci-sched.c              |  523 ++++++++++++--
 drivers/usb/host/Kconfig                   |    9 
 drivers/usb/host/uhci-hcd.c                |   95 +-
 drivers/usb/host/uhci-hcd.h                |    3 
 drivers/usb/image/hpusbscsi.c              |    2 
 drivers/usb/image/mdc800.c                 |   11 
 drivers/usb/image/microtek.c               |   21 
 drivers/usb/input/aiptek.c                 |   57 +
 drivers/usb/input/ati_remote.c             |  981 ++++++++++++++++++++++++++--
 drivers/usb/input/hid-core.c               |    4 
 drivers/usb/input/kbtab.c                  |   21 
 drivers/usb/input/Kconfig                  |   26 
 drivers/usb/input/Makefile                 |   10 
 drivers/usb/input/mtouchusb.c              |  395 +++++++++++
 drivers/usb/input/pid.c                    |    1 
 drivers/usb/input/usbkbd.c                 |    2 
 drivers/usb/input/usbmouse.c               |    2 
 drivers/usb/input/wacom.c                  |   38 -
 drivers/usb/Kconfig                        |   38 -
 drivers/usb/Makefile                       |    6 
 drivers/usb/misc/brlvger.c                 | 1016 -----------------------------
 drivers/usb/misc/Kconfig                   |   11 
 drivers/usb/misc/Makefile                  |    1 
 drivers/usb/misc/usbtest.c                 |   62 -
 drivers/usb/net/Kconfig                    |    8 
 drivers/usb/net/pegasus.h                  |    8 
 drivers/usb/net/usbnet.c                   |   35 
 drivers/usb/serial/ftdi_sio.c              |    3 
 drivers/usb/serial/ftdi_sio.h              |    2 
 drivers/usb/serial/keyspan.h               |   26 
 drivers/usb/serial/kl5kusb105.c            |    5 
 drivers/usb/serial/pl2303.c                |    8 
 drivers/usb/serial/usb-serial.c            |   27 
 drivers/usb/serial/usb-serial.h            |    5 
 drivers/usb/serial/visor.c                 |    3 
 drivers/usb/serial/visor.h                 |    1 
 drivers/usb/storage/Kconfig                |    2 
 drivers/usb/storage/scsiglue.c             |   14 
 drivers/usb/storage/transport.c            |   22 
 drivers/usb/storage/unusual_devs.h         |    0 
 drivers/usb/storage/unusual_devs.h         |   45 -
 drivers/usb/storage/usb.c                  |   13 
 drivers/usb/storage/usb.h                  |    1 
 include/linux/brlvger.h                    |   54 -
 include/linux/usb_gadget.h                 |   32 
 include/linux/usb.h                        |  216 ++++--
 MAINTAINERS                                |   30 
 83 files changed, 3259 insertions(+), 2480 deletions(-)
-----

<brill:fs.math.uni-frankfurt.de>:
  o USB Storage: unusual_devs.h entry submission

<henning:wh9.tu-dresden.de>:
  o USB: unusual_devs.h update

<jeffm:suse.com>:
  o USB: Fix for kl5kusb105 driver

<jurgen:botz.org>:
  o USB: visor patch for Samsung SPH-i500

<michal_dobrzynski:mac.com>:
  o USB: add IRTrans support to ftdi_sio driver

<tejohnson:yahoo.com>:
  o USB: add new USB Touchscreen Driver

<thoffman:arnor.net>:
  o USB: update driver for ATI USB/RF remotes
  o USB: add driver for ATI USB/RF remotes

<u233:shaw.ca>:
  o USB: kbtab.c (Jamstudio Tablet) with optional pressure

Adrian Bunk:
  o USB: remove USB_SCANNER MAINTAINERS entry
  o USB_STORAGE: remove a comment

Alan Stern:
  o USB: Altsetting/interface update for USB image drivers
  o USB: Remove interface/altsetting assumptions from usb-midi
  o USB: Interface/altsetting update for ISDN hisax driver
  o USB UHCI: restore more state following PM resume
  o USB: Remove interface/altsettings assumption from audio driver
  o USB: Update USB class drivers
  o USB: Convert usbtest to the new altsetting regime
  o USB: Convert usb-storage to use cur_altsetting
  o USB: Small improvements for devio.c
  o USB: Convert usbcore to use cur_altsetting
  o USB: Improve handling of altsettings
  o USB: Don't add/del interfaces, register/unregister them
  o USB Storage: Revision of as202, Genesys quirk patch
  o USB Storage: Remove Minolta Dimage 7i from unusual_devs.h
  o USB: Use list_splice instead of looping over list elements
  o USB: Remove name obfuscation in UHCI
  o USB: Return better result codes in UHCI
  o USB: Enable interrupts in UHCI after PM resume
  o USB: Fix a bug in the UHCI dequeueing code
  o USB Storage: update unusual_devs.h comments
  o USB Storage: unusual_devs.h update

Andrew Morton:
  o USB ati_remote.c: don't be a namespace hog

Art Haas:
  o USB: C99 initializers for drivers/usb/serial/keyspan.h

David Brownell:
  o USB Gadget: add "gadget_chips.h"
  o USB gadget: gadget zero, simplified controller-specific configuration
  o USB: usb buffer allocation shouldn't require DMA
  o USB: usbtest updates (new firmware)
  o USB: usb_unlink_urb() has distinct "not linked" fault
  o USB gadget: dualspeed {run,compile}-time flags
  o USB: usbcore doc update
  o USB: clarify CONFIG_USB_GADGET
  o USB: gadget config buf utilities
  o USB: usbnet and ALI M5632
  o USB: HCD names, for better troubleshooting
  o USB Gadget: make usb gadget strings talk utf-8
  o USB: EHCI and full-speed ISO-OUT
  o USB Gadget: gadget config buffer utilities
  o USB: usbnet learns about Zaurus C-860

Greg Kroah-Hartman:
  o USB: replace kobject with kref in usb-serial core
  o USB: fix compiler warning in hfc_usb.c driver
  o USB: fix usb-serial core to look at the proper interface descriptor
  o USB: fix the pcwd_usb driver due to act_altsetting going away
  o merge fixups with irda usb code
  o USB: remove intf->act_altsetting altogether from the USB core and usb.h
  o USB: remove act_altsetting usages in more USB drivers
  o USB: remove act_altsetting usages in the remaining drivers/usb/ drivers
  o USB: fix up the input Makefile after these last few drivers were added
  o USB: fix build for older versions of gcc and the mtouchusb driver
  o USB: delete unneeded scanner documentation
  o USB Storage: remove unneeded debug message

Martin Diehl:
  o USB: fix stack usage in pl2303 driver

Matthew Dharm:
  o USB Storage: tighten sense-clearing code
  o USB Storage: Remove unneeded macro
  o USB Storage: Fix for Fuji Finepix 1400
  o USB Storage: DSC-T1 unusual_devs.h entry

Oliver Neukum:
  o USB: wacom driver fixes
  o USB: bug in error code path of kbtab driver
  o USB: fixes for aiptek driver
  o USB: locking fix for pid.c

Paulo Marques:
  o USB: usblp.c (Was: usblp_write spins forever after an error)

Per Winkvist:
  o USB Storage: unusual devs fix for Pentax cameras

Petko Manolov:
  o USB: 2.6 pegasus.h updates

Randy Dunlap:
  o USB: fix net2280 section usage

Stéphane Doyon:
  o USB brlvger: Driver obsoleted by rewrite using usbfs

Thomas Sailer:
  o USB: USB OSS audio driver workaround for buggy descriptors

