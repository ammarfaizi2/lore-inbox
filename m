Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTJYA2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTJYA2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 20:28:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:11657 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262174AbTJYA2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 20:28:43 -0400
Date: Fri, 24 Oct 2003 17:19:47 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.23-pre8
Message-ID: <20031025001947.GA1491@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and changes against 2.4.23-pre8.  The big
stuff here is an update to the sl811 USB host driver, and a new video
USB driver.  There is also a bunch of smaller bugfixes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h


 CREDITS                            |   18 
 Documentation/Configure.help       |  254 ++
 Documentation/usb/sl811hc.txt      |  331 +++
 Documentation/usb/w9968cf.txt      |  486 ++++
 drivers/usb/brlvger.c              |    6 
 drivers/usb/Config.in              |    1 
 drivers/usb/gadget/Config.in       |   24 
 drivers/usb/gadget/ether.c         |  130 -
 drivers/usb/gadget/zero.c          |   25 
 drivers/usb/hc_simple.c            | 1072 ---------
 drivers/usb/hc_simple.h            |  231 --
 drivers/usb/hc_sl811.c             | 1359 ------------
 drivers/usb/hc_sl811.h             |  385 ---
 drivers/usb/hc_sl811_rh.c          |  526 ----
 drivers/usb/host/Config.in         |    6 
 drivers/usb/host/ehci-dbg.c        |   10 
 drivers/usb/host/ehci.h            |    1 
 drivers/usb/host/ehci-q.c          |   30 
 drivers/usb/host/hc_simple.c       | 1089 ++++++++++
 drivers/usb/host/hc_simple.h       |  230 ++
 drivers/usb/host/hc_sl811.c        | 1484 +++++++++++++
 drivers/usb/host/hc_sl811.h        |  386 +++
 drivers/usb/host/hc_sl811_rh.c     |  536 ++++
 drivers/usb/host/Makefile          |    1 
 drivers/usb/host/sl811.c           |  204 +
 drivers/usb/Makefile               |    4 
 drivers/usb/scanner.c              |   13 
 drivers/usb/scanner.h              |   17 
 drivers/usb/serial/ftdi_sio.c      |   54 
 drivers/usb/serial/ftdi_sio.h      |   13 
 drivers/usb/serial/visor.c         |    2 
 drivers/usb/serial/visor.h         |    1 
 drivers/usb/storage/unusual_devs.h |   14 
 drivers/usb/usbnet.c               |    4 
 drivers/usb/w9968cf.c              | 3989 +++++++++++++++++++++++++++++++++++++
 drivers/usb/w9968cf_decoder.h      |   86 
 drivers/usb/w9968cf_externaldef.h  |   95 
 drivers/usb/w9968cf.h              |  321 ++
 include/asm-arm/hc_sl811-hw.h      |  139 +
 include/asm-arm/sl811-hw.h         |  148 +
 include/asm-i386/hc_sl811-hw.h     |  139 +
 include/asm-i386/sl811-hw.h        |  133 +
 include/linux/i2c-id.h             |    1 
 include/linux/usb_ch9.h            |   42 
 include/linux/videodev.h           |   71 
 MAINTAINERS                        |    7 
 46 files changed, 10305 insertions(+), 3813 deletions(-)
-----

<car.busse:gmx.de>:
  o USB: one more digicam for unusual_devs.h

<henry.ne:arcor.de>:
  o USB: Update SL811, HC_SL811 driver

<luca:libero.it>:
  o USB: add W996[87]CF driver

Adrian Bunk:
  o USB: add USB gadget Configure help entries

Alan Stern:
  o USB: fix for earlier unusual_devs.h patch

Daniel Drake:
  o USB brlvger: Debug code fixes

David Brownell:
  o USB: usb gadget Config.in updates
  o USB: <linux/usb_ch9.h> updates
  o USB: usb "gadget zero" tweaks
  o USB: ehci-hcd, misc bugfixes
  o USB: usb ethernet gadget

Dax Kelson:
  o USB: Add Handspring Treo 600 ids

Greg Kroah-Hartman:
  o USB: fix build bug with usbnet and older versions of gcc
  o USB: fix compiler error in sl811.c

Henning Meier-Geinitz:
  o USB: scanner driver: use static declarations (3/3)
  o USB: scanner driver: added USB_CLASS_CDC_DATA (2/3)
  o USB: scanner driver: new device ids (1/3)

Ian Abbott:
  o USB: ftdi_sio - version bump 1.3.5
  o USB: ftdi_sio - Perle UltraPort new ids - 2 of 2
  o USB: ftdi_sio - Perle UltraPort new ids - 1 of 2

