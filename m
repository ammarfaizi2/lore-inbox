Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUGNX5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUGNX5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUGNX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:57:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:48103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265373AbUGNX4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:56:33 -0400
Date: Wed, 14 Jul 2004 16:50:58 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.8-rc1
Message-ID: <20040714235057.GA17670@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes and a new driver for 2.6.8-rc1.  All of these
patches have been in the past few -mm releases (but the locking changes
that have caused so many problems, are not included here, they need more
testing...)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/media/w9968cf_externaldef.h |   94 -
 CREDITS                                 |    3 
 Documentation/usb/error-codes.txt       |    2 
 Documentation/usb/sn9c102.txt           |  276 +++
 Documentation/usb/w9968cf.txt           |  114 -
 drivers/usb/class/usb-midi.c            |   20 
 drivers/usb/core/file.c                 |   19 
 drivers/usb/core/hcd.c                  |  173 --
 drivers/usb/core/hcd.h                  |   14 
 drivers/usb/core/hub.c                  |  229 +--
 drivers/usb/core/hub.h                  |    3 
 drivers/usb/core/inode.c                |  108 +
 drivers/usb/core/message.c              |  222 +-
 drivers/usb/core/urb.c                  |   88 -
 drivers/usb/core/usb.c                  |   22 
 drivers/usb/gadget/Kconfig              |   10 
 drivers/usb/gadget/ether.c              |  148 +
 drivers/usb/gadget/inode.c              |   44 
 drivers/usb/gadget/serial.c             |   14 
 drivers/usb/gadget/zero.c               |   65 
 drivers/usb/host/ehci-dbg.c             |    2 
 drivers/usb/host/ehci-hcd.c             |    4 
 drivers/usb/host/ehci-sched.c           |   12 
 drivers/usb/host/hc_simple.c            |   44 
 drivers/usb/host/ohci-dbg.c             |    6 
 drivers/usb/host/ohci-hcd.c             |   18 
 drivers/usb/host/ohci-hub.c             |   10 
 drivers/usb/host/ohci-mem.c             |    7 
 drivers/usb/host/ohci-omap.c            |    5 
 drivers/usb/host/ohci-pci.c             |    6 
 drivers/usb/host/ohci-q.c               |   16 
 drivers/usb/host/ohci-sa1111.c          |    4 
 drivers/usb/host/uhci-hcd.c             |    2 
 drivers/usb/image/mdc800.c              |   28 
 drivers/usb/image/microtek.c            |    2 
 drivers/usb/input/aiptek.c              |   10 
 drivers/usb/input/hid-core.c            |   18 
 drivers/usb/input/powermate.c           |    2 
 drivers/usb/media/Kconfig               |   40 
 drivers/usb/media/Makefile              |    2 
 drivers/usb/media/ov511.c               |    2 
 drivers/usb/media/pwc-ctrl.c            |    2 
 drivers/usb/media/pwc-if.c              |    3 
 drivers/usb/media/se401.c               |    2 
 drivers/usb/media/sn9c102.h             |  185 ++
 drivers/usb/media/sn9c102_core.c        | 2439 ++++++++++++++++++++++++++++++++
 drivers/usb/media/sn9c102_pas106b.c     |  209 ++
 drivers/usb/media/sn9c102_sensor.h      |  270 +++
 drivers/usb/media/sn9c102_tas5110c1b.c  |   98 +
 drivers/usb/media/sn9c102_tas5130d1b.c  |  120 +
 drivers/usb/media/w9968cf.c             | 1066 +++++++------
 drivers/usb/media/w9968cf.h             |  117 -
 drivers/usb/media/w9968cf_vpp.h         |   43 
 drivers/usb/misc/auerswald.c            |    6 
 drivers/usb/misc/emi26_fw.h             |    4 
 drivers/usb/misc/speedtch.c             |    2 
 drivers/usb/misc/usbtest.c              |   24 
 drivers/usb/net/kaweth.c                |    2 
 drivers/usb/net/usbnet.c                |  178 +-
 drivers/usb/serial/Kconfig              |    7 
 drivers/usb/serial/Makefile             |   31 
 drivers/usb/serial/belkin_sa.c          |   14 
 drivers/usb/serial/bus.c                |    7 
 drivers/usb/serial/cyberjack.c          |   20 
 drivers/usb/serial/digi_acceleport.c    |   13 
 drivers/usb/serial/empeg.c              |   16 
 drivers/usb/serial/ezusb.c              |   17 
 drivers/usb/serial/ftdi_sio.c           |   32 
 drivers/usb/serial/ftdi_sio.h           |   27 
 drivers/usb/serial/generic.c            |   17 
 drivers/usb/serial/io_edgeport.c        |   36 
 drivers/usb/serial/io_ti.c              |   32 
 drivers/usb/serial/ipaq.c               |   21 
 drivers/usb/serial/ipaq.h               |    3 
 drivers/usb/serial/ir-usb.c             |   23 
 drivers/usb/serial/keyspan.c            |   16 
 drivers/usb/serial/keyspan_pda.c        |   11 
 drivers/usb/serial/kl5kusb105.c         |   21 
 drivers/usb/serial/kobil_sct.c          |   18 
 drivers/usb/serial/mct_u232.c           |   18 
 drivers/usb/serial/omninet.c            |   13 
 drivers/usb/serial/pl2303.c             |   15 
 drivers/usb/serial/safe_serial.c        |   31 
 drivers/usb/serial/usb-serial.c         |   13 
 drivers/usb/serial/usb-serial.h         |   18 
 drivers/usb/serial/visor.c              |   20 
 drivers/usb/serial/whiteheat.c          |   23 
 drivers/usb/storage/sddr09.c            |    2 
 drivers/usb/storage/unusual_devs.h      |    8 
 include/linux/usb.h                     |   19 
 include/linux/usb_gadget.h              |  153 +-
 include/linux/videodev.h                |    5 
 92 files changed, 5754 insertions(+), 1644 deletions(-)
-----

<aj:net-lab.net>:
  o USB: usbserial/ipaq update

<frankie:cse.unsw.edu.au>:
  o USB: unusual_devs.h update

<mika:osdl.org>:
  o USB: Trivial fix to include/linux/usb.h

Adrian Bunk:
  o USB:  USB w9968cf compile error

Alan Stern:
  o USB: Allow NULL argument in usb_unlink_urb() and usb_kill_urb()
  o USB: Fix endianness bug in UHCI driver
  o USB: Remove hub's children upon unbinding
  o USB: Store pointer to usb_device in private hub structure
  o USB: Don't ask for string descriptor lengths
  o USB: Make hub driver use usb_kill_urb()
  o USB: Add usb_kill_urb()

Dan Streetman:
  o USB: fix usbfs mount options ignored bug

David Brownell:
  o USB: usb hub, don't check speed before reset
  o USB: usb host side updates, mostly for suspend
  o USB: usb ethernet gadget, minor fixes + basic OTG support
  o USB: usb gadget zero, basic OTG updates
  o USB: usb gadget API updates
  o USB: usb gadgetfs, handle omap_udc
  o USB: usb serial gadget, add omap_udc
  o USB: misc ohci tweaks

David T. Hollis:
  o USB: ax8817x_unbind does not free the interrupt URB after unlinking
  o USB: usbnet:ax8817x - use interrupt URB for link detection

Greg Kroah-Hartman:
  o USB: sort the order in which the usb-serial drivers get built
  o USB: remove CONFIG_USB_SERIAL_DEBUG
  o USB: change all usbserial drivers to use module_param()
  o USB: oops, revert hub patch that wasn't supposed to make it into this patch series yet
  o USB: more sparse fixups that found a real bug in the se401 driver
  o USB: more sparse cleanups (all pretty much NULL usages.)
  o USB: fix up the wording in the emi26 firmware file to match the other kernel firmware files
  o USB: add 3 Phidget device ids to the HID blacklist

Ian Abbott:
  o USB: ftdi_sio VID/PID updates
  o USB: ftdi_sio debug trace for TIOCMSET

Luca Risolia:
  o USB: W99[87]CF fix
  o Updates for W99[87]CF and new SN9C10[12] driver

Luiz Capitulino:
  o USB: usb/core/hcd.c::usb_init() missing audit
  o USB: usb/core/file.c::usb_major_init() cleanup

Olaf Hering:
  o USB: fix SN9C10[12] driver for ia64
  o USB: fix lockup with 2.6 keyspan_pda driver

Tim Chick:
  o USB: usbnet, Sitecom LN-029

