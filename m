Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTE3Sp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTE3SpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:45:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:24516 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263914AbTE3Sos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:44:48 -0400
Date: Fri, 30 May 2003 11:57:42 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.70
Message-ID: <20030530185742.GA20278@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB changes and fixes for 2.5.70.  Lots of little minor
things are in here, the majority being a bunch of ->owner fixups that
Arnaldo did.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/proc_usb_info.txt  |   30 ---
 drivers/bluetooth/hci_usb.c          |    1 
 drivers/isdn/hisax/st5481_init.c     |    1 
 drivers/media/video/cpia_usb.c       |    1 
 drivers/net/irda/irda-usb.c          |    2 
 drivers/usb/Makefile                 |    3 
 drivers/usb/class/audio.c            |    1 
 drivers/usb/class/bluetty.c          |    1 
 drivers/usb/class/cdc-acm.c          |    1 
 drivers/usb/class/usb-midi.c         |   23 --
 drivers/usb/core/Kconfig             |   12 -
 drivers/usb/core/devio.c             |    1 
 drivers/usb/core/hcd.c               |    1 
 drivers/usb/core/hub.c               |   19 +-
 drivers/usb/core/usb.c               |    3 
 drivers/usb/gadget/ether.c           |    3 
 drivers/usb/image/hpusbscsi.c        |  225 ++++++++-----------------
 drivers/usb/image/hpusbscsi.h        |   22 --
 drivers/usb/image/microtek.c         |  293 +++++----------------------------
 drivers/usb/image/microtek.h         |    3 
 drivers/usb/image/scanner.c          |    4 
 drivers/usb/input/aiptek.c           |    1 
 drivers/usb/input/hid-core.c         |    9 -
 drivers/usb/input/hid-input.c        |  139 ++++++++++++---
 drivers/usb/input/hid-lgff.c         |   11 -
 drivers/usb/input/hid-tmff.c         |   11 -
 drivers/usb/input/hid.h              |   10 +
 drivers/usb/input/hiddev.c           |    1 
 drivers/usb/input/kbtab.c            |    1 
 drivers/usb/input/pid.c              |   13 -
 drivers/usb/input/powermate.c        |    1 
 drivers/usb/input/usbkbd.c           |    1 
 drivers/usb/input/usbmouse.c         |    1 
 drivers/usb/input/wacom.c            |    1 
 drivers/usb/input/xpad.c             |    1 
 drivers/usb/media/dabusb.c           |    6 
 drivers/usb/media/dsbr100.c          |    1 
 drivers/usb/media/ibmcam.c           |   15 -
 drivers/usb/media/konicawc.c         |    3 
 drivers/usb/media/ov511.c            |    5 
 drivers/usb/media/pwc-if.c           |    4 
 drivers/usb/media/se401.c            |    1 
 drivers/usb/media/stv680.c           |    1 
 drivers/usb/media/ultracam.c         |    3 
 drivers/usb/media/vicam.c            |    1 
 drivers/usb/misc/auerswald.c         |    1 
 drivers/usb/misc/emi26.c             |    9 -
 drivers/usb/misc/rio500.c            |    1 
 drivers/usb/misc/usblcd.c            |    4 
 drivers/usb/net/catc.c               |    1 
 drivers/usb/net/cdc-ether.c          |    1 
 drivers/usb/net/pegasus.c            |    1 
 drivers/usb/net/rtl8150.c            |    1 
 drivers/usb/net/usbnet.c             |    1 
 drivers/usb/serial/belkin_sa.c       |    1 
 drivers/usb/serial/cyberjack.c       |    1 
 drivers/usb/serial/digi_acceleport.c |    1 
 drivers/usb/serial/empeg.c           |    1 
 drivers/usb/serial/ftdi_sio.c        |    1 
 drivers/usb/serial/io_edgeport.c     |    1 
 drivers/usb/serial/io_ti.c           |    1 
 drivers/usb/serial/ipaq.c            |    1 
 drivers/usb/serial/ir-usb.c          |    1 
 drivers/usb/serial/keyspan.h         |    1 
 drivers/usb/serial/keyspan_pda.c     |    1 
 drivers/usb/serial/kl5kusb105.c      |    1 
 drivers/usb/serial/mct_u232.c        |    1 
 drivers/usb/serial/omninet.c         |    1 
 drivers/usb/serial/pl2303.c          |    1 
 drivers/usb/serial/safe_serial.c     |    1 
 drivers/usb/serial/usb-serial.c      |    1 
 drivers/usb/serial/visor.c           |    1 
 drivers/usb/serial/whiteheat.c       |    1 
 drivers/usb/storage/scsiglue.c       |   32 +++
 drivers/usb/storage/transport.c      |  305 ++++++++++++++---------------------
 drivers/usb/storage/transport.h      |    8 
 drivers/usb/storage/unusual_devs.h   |   54 +-----
 drivers/usb/storage/usb.c            |   18 --
 drivers/usb/storage/usb.h            |   11 -
 drivers/usb/usb-skeleton.c           |    1 
 sound/usb/usbaudio.c                 |    1 
 81 files changed, 546 insertions(+), 814 deletions(-)
-----

<hwahl:hwahl.de>:
  o USB:  Patch for Samsung Digimax 410

Alan Stern:
  o USB: fix address assignment after device reset

Arnaldo Carvalho de Melo:
  o o drivers/usb/usb-skeleton: initialize struct usb_driver ->owner field
  o o drivers/usb/storage/usb: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/whiteheat: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/visor: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/usb-serial: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/safe_serial: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/pl2303: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/omninet: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/mct_u232: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/kl5kusb105: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/keyspan: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/ir-usb: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/ipaq: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/io_ti: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/io_edgeport: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/ftdi_sio: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/empeg: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/digi_acceleport: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/cyberjack: initialize struct usb_driver ->owner field
  o o drivers/usb/serial/belkin_sa: initialize struct usb_driver ->owner field
  o o drivers/usb/net/usbnet: initialize struct usb_driver ->owner field
  o o drivers/usb/net/rtl8150: initialize struct usb_driver ->owner field
  o o drivers/usb/net/pegasus: initialize struct usb_driver ->owner field
  o o drivers/usb/net/cdc-ether: initialize struct usb_driver ->owner field
  o o drivers/usb/net/catc: initialize struct usb_driver ->owner field
  o o drivers/usb/misc/usblcd: initialize struct usb_driver ->owner field
  o o drivers/usb/misc/rio500: initialize struct usb_driver ->owner field
  o o drivers/usb/misc/emi26: initialize struct usb_driver ->owner field
  o o drivers/usb/misc/auerswald: initialize struct usb_driver ->owner field
  o o drivers/usb/media/vicam: initialize struct usb_driver ->owner field
  o o drivers/usb/media/ultracam: remove MOD_{INC,DEC}_USE_COUNT
  o o drivers/usb/media/stv680: initialize struct usb_driver ->owner field
  o o drivers/usb/media/se401: initialize struct usb_driver ->owner field
  o o drivers/usb/media/pwc-if: initialize struct usb_driver ->owner field
  o o drivers/usb/media/ov511: initialize struct usb_driver ->owner field
  o o drivers/usb/media/konicawc: remove MOD_{DEC,INC}_USE_COUNT
  o o drivers/usb/media/ibmcam: remove MOD_{INC,DEC}_USE_COUNT
  o o drivers/usb/media/dsbr100: initialize struct usb_driver ->owner field
  o o drivers/usb/media/dabusb: initialize struct usb_driver ->owner field
  o o drivers/usb/input/xpad: initialize struct usb_driver ->owner field
  o o drivers/usb/input/wacom: initialize struct usb_driver ->owner field
  o o drivers/usb/input/usbmouse: initialize struct usb_driver ->owner field
  o o drivers/usb/input/usbkbd: initialize struct usb_driver ->owner field
  o o drivers/usb/input/powermate: initialize struct usb_driver ->owner field
  o o drivers/usb/input/kbtab: initialize struct usb_driver ->owner field
  o o drivers/usb/input/hiddev: initialize struct usb_driver ->owner field
  o o drivers/usb/input/hid-core: initialize struct usb_driver ->owner field
  o o drivers/usb/input/aiptek: initialize struct usb_driver ->owner field
  o o drivers/usb/image/scanner: initialize struct usb_driver ->owner field
  o o drivers/usb/image/microtek: initialize struct usb_driver ->owner field
  o o drivers/usb/image/hpusbscsi: initialize struct usb_driver ->owner field
  o o drivers/usb/core/hub: initialize struct usb_driver ->owner field
  o o drivers/usb/core/devio: initialize struct usb_driver ->owner field
  o o drivers/class/usb-midi: initialize struct usb_driver ->owner field
  o o drivers/class/cdc-acm: initialize struct usb_driver ->owner field
  o o drivers/class/bluetty: initialize struct usb_driver ->owner field
  o o drivers/class/audio: initialize struct usb_driver ->owner field
  o o drivers/net/irda/irda-usb: initialize struct usb_driver ->owner field
  o o drivers/media/video/cpia_usb: initialize struct usb_driver ->owner field
  o o drivers/isdn/hisax/st5481: initialize struct usb_driver ->owner field
  o o drivers/bluetooth/hci_usb: initialize struct usb_driver ->owner field

Ben Collins:
  o USB Multi-input quirk

Christoph Hellwig:
  o fix scsi_register_host abuse in usb scanner drivers
  o use second arg to scsi_add_host in usb storage

David Brownell:
  o USB: ethernet "gadget", rx overflows happen

Greg Kroah-Hartman:
  o USB: remove some old references to /proc/bus/usb/drivers
  o USB: fix up unusual_devs.h merge mess
  o USB: build gadget drivers if they are built into the kernel

Matthew Dharm:
  o USB: storage: collapse one-use functions
  o USB: storage: abort and disconnect handling

Oliver Neukum:
  o USB: allocate memory for reset earlier

Pavel Roskin:
  o USB: name uninitialized in scanner.c

