Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270688AbTHOSQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTHOSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:16:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:4481 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270671AbTHOSQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:16:36 -0400
Date: Fri, 15 Aug 2003 11:12:59 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test3
Message-ID: <20030815181259.GA3561@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test3.  Included are a number of
bugfixes for things people have been complaining about lately (usblp not
working, warning messages from the driver model implementation, etc.),
and a fix for the ov511 driver due to the v4l core changes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/isdn/hisax/st5481_usb.c                   |    4 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    2 
 drivers/net/irda/irda-usb.c                       |    6 
 drivers/usb/class/cdc-acm.c                       |    9 
 drivers/usb/class/usblp.c                         |    6 
 drivers/usb/core/devio.c                          |    4 
 drivers/usb/core/file.c                           |   49 +
 drivers/usb/core/hcd-pci.c                        |   83 --
 drivers/usb/core/hcd.c                            |   36 -
 drivers/usb/core/hcd.h                            |    4 
 drivers/usb/core/hub.c                            |    5 
 drivers/usb/core/message.c                        |  145 +++-
 drivers/usb/core/usb.c                            |   28 
 drivers/usb/host/ehci-q.c                         |    4 
 drivers/usb/media/dabusb.c                        |    6 
 drivers/usb/media/ov511.c                         |  672 ++++------------------
 drivers/usb/media/ov511.h                         |   48 -
 drivers/usb/media/stv680.c                        |    5 
 drivers/usb/media/usbvideo.c                      |   19 
 drivers/usb/misc/tiglusb.c                        |    8 
 drivers/usb/net/usbnet.c                          |    8 
 drivers/usb/serial/belkin_sa.c                    |    6 
 drivers/usb/serial/cyberjack.c                    |    8 
 drivers/usb/serial/digi_acceleport.c              |   20 
 drivers/usb/serial/empeg.c                        |    9 
 drivers/usb/serial/ftdi_sio.c                     |   16 
 drivers/usb/serial/generic.c                      |    2 
 drivers/usb/serial/io_edgeport.c                  |   16 
 drivers/usb/serial/io_ti.c                        |   16 
 drivers/usb/serial/ipaq.c                         |    8 
 drivers/usb/serial/keyspan.c                      |   18 
 drivers/usb/serial/keyspan_pda.c                  |   10 
 drivers/usb/serial/kl5kusb105.c                   |    8 
 drivers/usb/serial/kobil_sct.c                    |   12 
 drivers/usb/serial/mct_u232.c                     |    8 
 drivers/usb/serial/omninet.c                      |    8 
 drivers/usb/serial/pl2303.c                       |    6 
 drivers/usb/serial/usb-serial.c                   |  219 ++++---
 drivers/usb/serial/usb-serial.h                   |    3 
 drivers/usb/serial/visor.c                        |   36 -
 drivers/usb/serial/whiteheat.c                    |   16 
 drivers/usb/storage/unusual_devs.h                |    6 
 drivers/usb/storage/usb.c                         |   23 
 include/linux/usb.h                               |    6 
 sound/usb/usbaudio.c                              |    8 
 46 files changed, 652 insertions(+), 989 deletions(-)
-----

<davej:redhat.com>:
  o USB: Add Minolta Dimage F300 to unusual_devs

<kevino:asti-usa.com>:
  o USB: bug in EHCI device reset through transaction

Daniele Bellucci:
  o USB: usbvideo cleanup on error

David Brownell:
  o USB: usb_start_wait_urb() rewrite
  o usb hc cleanup-after-death, oops fix
  o USB: usb hcd-pci suspend/resume updates
  o add usb_reset_configuration()
  o USB: dabusb doesn't claim every ez-usb an21xx device

David T. Hollis:
  o USB: usbnet.c - trailing 'else' that probably breaks net1080

Greg Kroah-Hartman:
  o USB: handle overloading of usb-serial functions in a much cleaner manner
  o USB: fix usb class device sysfs representation
  o USB: fix up usb-serial drivers now that port[] is an array of pointers
  o USB: fix usb serial port release problem by untieing it from the usb_serial structure

Mark W. McClelland:
  o USB: ov511 sysfs conversion (3/3)
  o USB: ov511 sysfs conversion (2/3)
  o USB: ov511 sysfs conversion (1/3)

Oliver Neukum:
  o USB: genelink_tx_fixup fails to check for memory allocation failure
  o USB: error check for claiming second interface in usbnet
  o USB: correct error handling in usb_driver_claim_interface() - comment
  o USB: correct error handling in usb_driver_claim_interface()
  o USB: return to old timeout handling
  o USB: ttusb_dec.c: another case of GFP_KERNEL in interrupt

