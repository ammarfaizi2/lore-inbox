Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTLLXTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTLLXTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:19:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:5039 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262747AbTLLXSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:18:52 -0500
Date: Fri, 12 Dec 2003 15:17:19 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] big USB patch for 2.6.0-test11
Message-ID: <20031212231719.GA19038@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's all of the patches that people have been sending me for the USB
subsystem for 2.6 that I'm waiting for 2.6.0 to come out before sending
off for inclusion.  I've rolled everything up into one big patch that
will apply against 2.6.0-test11, and it can be found at:
	kernel.org/pub/linux/kernel/people/gregkh/usb/2.6/2.6.0-test11/usb-rollup-2.6.0-test11.patch

All of these patches can be found in a BitKeeper tree located at:
	bk://linuxusb.bkbits.net/usb-devel-2.6

A listing of all of the individual changes, and the diffstat of the
patch is below.

If anyone has sent me a USB patch and they don't see it here, or in the
patches sent to Linus a few days ago, please let me know, as I think
I've finally caught up..

thanks,

greg k-h


 CREDITS                                 |    9 
 MAINTAINERS                             |    7 
 Documentation/usb/w9968cf.txt           |  463 +++
 include/linux/i2c-id.h                  |    1 
 include/linux/usb.h                     |    5 
 include/linux/videodev.h                |    1 
 drivers/usb/class/cdc-acm.c             |   42 
 drivers/usb/class/usblp.c               |   14 
 drivers/usb/core/hcd.c                  |    8 
 drivers/usb/core/hub.c                  |   29 
 drivers/usb/core/hub.h                  |    2 
 drivers/usb/core/message.c              |    7 
 drivers/usb/core/usb.c                  |   79 
 drivers/usb/host/ohci-dbg.c             |   43 
 drivers/usb/host/ohci.h                 |   10 
 drivers/usb/host/ohci-hcd.c             |    8 
 drivers/usb/host/ohci-q.c               |   32 
 drivers/usb/image/scanner.c             |    4 
 drivers/usb/image/scanner.h             |   17 
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
 drivers/usb/misc/Kconfig                |   12 
 drivers/usb/misc/legousbtower.c         |  878 +++++++
 drivers/usb/misc/Makefile               |    1 
 drivers/usb/net/Kconfig                 |    2 
 drivers/usb/net/pegasus.h               |    5 
 drivers/usb/net/usbnet.c                |   34 
 drivers/usb/serial/cyberjack.c          |   25 
 drivers/usb/serial/ftdi_sio.c           |   12 
 drivers/usb/serial/ftdi_sio.h           |    8 
 drivers/usb/serial/io_edgeport.c        |   12 
 drivers/usb/serial/io_fw_boot2.h        |    2 
 drivers/usb/serial/io_fw_boot.h         |    2 
 drivers/usb/serial/io_fw_down2.h        |    2 
 drivers/usb/serial/io_fw_down.h         |    2 
 drivers/usb/serial/pl2303.c             |   44 
 drivers/usb/serial/pl2303.h             |    1 
 drivers/usb/serial/visor.c              |    3 
 drivers/usb/serial/visor.h              |    1 
 drivers/usb/storage/datafab.c           |  132 -
 drivers/usb/storage/debug.c             |   59 
 drivers/usb/storage/debug.h             |    1 
 drivers/usb/storage/isd200.c            |   76 
 drivers/usb/storage/jumpshot.c          |  119 -
 drivers/usb/storage/Makefile            |   10 
 drivers/usb/storage/protocol.c          |  166 +
 drivers/usb/storage/protocol.h          |   10 
 drivers/usb/storage/raw_bulk.c          |  116 -
 drivers/usb/storage/raw_bulk.h          |   20 
 drivers/usb/storage/scsiglue.c          |    3 
 drivers/usb/storage/sddr09.c            |  383 +--
 drivers/usb/storage/sddr55.c            |   98 
 drivers/usb/storage/shuttle_usbat.c     |   42 
 drivers/usb/storage/transport.c         |   37 
 drivers/usb/storage/unusual_devs.h      |   91 
 drivers/usb/storage/usb.c               |   29 
 66 files changed, 6934 insertions(+), 880 deletions(-)


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

David Brownell:
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

