Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTL2We0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTL2WeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:34:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:35781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264586AbTL2WeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:34:19 -0500
Date: Mon, 29 Dec 2003 14:34:22 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.0
Message-ID: <20031229223422.GA13691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.0.  There are a number of different
fixes and a few new drivers added.  Some of the highlights are:
	- lots of usb-storage fixes
	- lots of usb-storage unusual-devs updates
	- added new w9968cf driver
	- added new lego tower driver
	- core tweaks for non-compliant USB devices.
	- lots of other little fixes

Please pull from:  bk://linuxusb.bkbits.net/usb-devel-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 CREDITS                                 |    9 
 Documentation/usb/w9968cf.txt           |  463 +++
 drivers/usb/class/audio.h               |    6 
 drivers/usb/class/cdc-acm.c             |   42 
 drivers/usb/class/usblp.c               |   18 
 drivers/usb/class/usb-midi.h            |    6 
 drivers/usb/core/hcd.c                  |    8 
 drivers/usb/core/hub.c                  |   62 
 drivers/usb/core/hub.h                  |    2 
 drivers/usb/core/message.c              |    7 
 drivers/usb/core/usb.c                  |  101 
 drivers/usb/gadget/ether.c              |   21 
 drivers/usb/gadget/zero.c               |  102 
 drivers/usb/host/ohci-dbg.c             |   43 
 drivers/usb/host/ohci.h                 |   10 
 drivers/usb/host/ohci-hcd.c             |    8 
 drivers/usb/host/ohci-q.c               |   32 
 drivers/usb/image/scanner.c             |    4 
 drivers/usb/image/scanner.h             |   17 
 drivers/usb/input/hid-core.c            |    4 
 drivers/usb/input/hiddev.c              |    1 
 drivers/usb/Makefile                    |    2 
 drivers/usb/media/Kconfig               |   42 
 drivers/usb/media/Makefile              |    1 
 drivers/usb/media/pwc-ctrl.c            |  173 +
 drivers/usb/media/pwc.h                 |   22 
 drivers/usb/media/pwc-if.c              |   75 
 drivers/usb/media/pwc-ioctl.h           |   44 
 drivers/usb/media/pwc-misc.c            |   31 
 drivers/usb/media/w9968cf.c             | 3712 ++++++++++++++++++++++++++++++++
 drivers/usb/media/w9968cf_decoder.h     |   86 
 drivers/usb/media/w9968cf_externaldef.h |   95 
 drivers/usb/media/w9968cf.h             |  312 ++
 drivers/usb/misc/Kconfig                |   14 
 drivers/usb/misc/legousbtower.c         | 1224 +++++++++-
 drivers/usb/misc/Makefile               |    1 
 drivers/usb/net/Kconfig                 |   15 
 drivers/usb/net/pegasus.h               |    5 
 drivers/usb/net/usbnet.c                |   78 
 drivers/usb/serial/cyberjack.c          |   25 
 drivers/usb/serial/ftdi_sio.c           |   12 
 drivers/usb/serial/ftdi_sio.h           |    8 
 drivers/usb/serial/io_edgeport.c        |   12 
 drivers/usb/serial/io_fw_boot2.h        |    2 
 drivers/usb/serial/io_fw_boot.h         |    2 
 drivers/usb/serial/io_fw_down2.h        |    2 
 drivers/usb/serial/io_fw_down.h         |    2 
 drivers/usb/serial/mct_u232.c           |   37 
 drivers/usb/serial/mct_u232.h           |  101 
 drivers/usb/serial/pl2303.c             |   44 
 drivers/usb/serial/pl2303.h             |    1 
 drivers/usb/serial/visor.c              |    3 
 drivers/usb/serial/visor.h              |    1 
 drivers/usb/storage/datafab.c           |  136 -
 drivers/usb/storage/debug.c             |   59 
 drivers/usb/storage/debug.h             |    1 
 drivers/usb/storage/isd200.c            |   76 
 drivers/usb/storage/jumpshot.c          |  123 -
 drivers/usb/storage/Makefile            |   10 
 drivers/usb/storage/protocol.c          |  172 +
 drivers/usb/storage/protocol.h          |   10 
 drivers/usb/storage/raw_bulk.c          |  116 -
 drivers/usb/storage/raw_bulk.c          |    2 
 drivers/usb/storage/raw_bulk.h          |   20 
 drivers/usb/storage/scsiglue.c          |    3 
 drivers/usb/storage/sddr09.c            |  395 +--
 drivers/usb/storage/sddr55.c            |   98 
 drivers/usb/storage/shuttle_usbat.c     |   42 
 drivers/usb/storage/transport.c         |   37 
 drivers/usb/storage/unusual_devs.h      |   91 
 drivers/usb/storage/usb.c               |   41 
 include/linux/i2c-id.h                  |    1 
 include/linux/usb_ch9.h                 |   42 
 include/linux/usb_gadget.h              |   29 
 include/linux/usb.h                     |    5 
 include/linux/videodev.h                |    1 
 MAINTAINERS                             |   28 
 sound/usb/usbaudio.h                    |    6 
 78 files changed, 7491 insertions(+), 1203 deletions(-)
-----

<alexander:all-2.com>:
  o USB storage: patch for unusual_devs.h

<berentsen:sent5.uni-duisburg.de>:
  o USB storage: Minolta Dimage S414 usb patch

<dancy:dancysoft.com>:
  o USB: add TIOCMIWAIT support to pl2303 driver

<fello:libero.it>:
  o USB storage: patch for Fujifilm EX-20

<luca:libero.it>:
  o USB: add W996[87]CF driver

<marr:flex.com>:
  o Status Query On My MCT-U232 Patch

<mbp:samba.org>:
  o USB storage: add unusual storage device entry for Minolta DiMAGE

<per.winkvist:uk.com>:
  o USB storage: Make Pentax Optio S4 work

<petkan:nucleusys.com>:
  o USB: pegasus driver update

<stephane.galles:free.fr>:
  o USB storage: patch for Kyocera S5 camera

<tchen:on-go.com>:
  o USB: fix bug when errors happen in ioedgeport driver
  o USB: fix io_edgeport driver alignment issues

<_nessuno_:katamail.com>:
  o USB storage: Medion 6047 Digital Camera

Adam Kropelin:
  o USB: Stop hiddev generating empty events

Alan Stern:
  o USB: Allow configuration #0
  o USB storage: Unusual_devs.h addition
  o USB storage: Another unusual_devs.h update
  o USB storage: unusual_devs.h entry revision
  o USB storage: Add comments explaining new s-g usage
  o USB storage: Remove unneeded raw_bulk.[ch] files, change Makefile
  o USB storage: Convert sddr55 to use the new s-g routines
  o USB storage: Update scatter-gather handling in the shuttle-usbat
  o USB storage: Update scatter-gather handling in the isd200 driver
  o USB storage: Another utility scatter-gather routine
  o USB storage: Convert jumpshot to use the new s-g routines
  o USB storage: Convert datafab to use the new s-g routines
  o USB storage: Change sddr09 to use the new s-g access routine
  o USB storage: Fix scatter-gather buffer access in usb-storage core
  o USB storage: Remove dead code from debug.c
  o USB storage: Enhance sddr09 to work with 64 MB SmartMedia cards
  o USB storage: Remove unneeded scatter-gather operations in sddr09
  o USB: Fix khubd synchronization
  o USB: khubd optimization
  o USB storage: Fix logic error in raw_bulk.c:us_copy_to_sgbuf()
  o USB storage: Issue CBI clear_halt and fix BBB residue
  o USB storage: Command failure codes for sddr09 driver

Arnaud Quette:
  o USB: disable hiddev support for MGE UPS

David Brownell:
  o USB: let USB_{PEGASUS,USBNET} depend on NET_ETHERNET
  o USB: ethernet gadget supports goku_udc
  o USB: gadget zero updates
  o USB: <linux/usb_gadget.h> doc updates
  o USB: <linux/usb_ch9.h> new descriptor codes, types
  o USB: usb driver binding fixes
  o USB: usb_hcd_unlink_urb() test for list membership
  o USB: ohci, fix iso "bad entry" bug + misc
  o USB: change cdc-acm to do RX URB processing in a tasklet
  o USB: usbcore, better heuristic for choosing configs

David Glance:
  o USB: Add Lego USB Infrared Tower driver

David T. Hollis:
  o USB: Mark AX8817x usbnet driver as non-experimental
  o USB: ax8817x additional ethtool support in usbnet

Greg Kroah-Hartman:
  o USB: add support for Sony UX50 device to visor driver
  o USB: add support for another pl2303 device
  o USB storage: remove the raw_bulk.c and raw_bulk.h files as they are no longer needed
  o USB: fix up compiler warning in usblp driver caused by previous patches
  o USB: add support for Protego devices to ftdi_sio driver
  o USB: 64bit fixups for legousbtower driver
  o USB: give legotower driver a real USB minor, and remove unneeded ioctl function
  o USB: fix up formatting problems in the legotower driver

Henning Meier-Geinitz:
  o USB scanner driver: new device ids

Herbert Xu:
  o USB Storage: freecom dvd-rw fx-50 usb-ide patch

Matthew Dharm:
  o USB: don't send any MODE SENSE commands to usb mass storage devices

Nemosoft Unv.:
  o USB: PWC 8.12 driver update

Oliver Neukum:
  o USB: sleeping problems in cyberjack driver
  o USB: further cleanup in usblp
  o USB: fix error return codes in usblp

Pete Zaitcev:
  o USB: fix comment in usblp

