Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbTFSA3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbTFSA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:29:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25813 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265654AbTFSA3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:29:39 -0400
Date: Wed, 18 Jun 2003 17:43:03 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.4.21
Message-ID: <20030619004303.GA3120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of USB bugfixes and updates against 2.4.21.  This
includes all of the pending USB patches that I had been holding during
the 2.4.21-rc timeframe.  They include 2 new USB drivers, USB 2.0
controller fixes, lots of usb-storage device additions, and other fixes
and tweaks.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 CREDITS                            |    8 
 Documentation/Configure.help       |   38 
 MAINTAINERS                        |   15 
 drivers/usb/CDCEther.c             |    7 
 drivers/usb/Config.in              |    2 
 drivers/usb/Makefile               |    6 
 drivers/usb/aiptek.c               | 1216 ++++++++++++++++-
 drivers/usb/ax8817x.c              | 1287 ++++++++++++++++++
 drivers/usb/catc.c                 |    8 
 drivers/usb/hid-core.c             |  140 +-
 drivers/usb/hid-input.c            |  233 ++-
 drivers/usb/hid.h                  |   32 
 drivers/usb/hiddev.c               |  295 ++--
 drivers/usb/host/ehci-hcd.c        |   25 
 drivers/usb/host/ehci-q.c          |   46 
 drivers/usb/host/ehci.h            |   51 
 drivers/usb/hub.c                  |   11 
 drivers/usb/kaweth.c               |    6 
 drivers/usb/pegasus.c              |   76 -
 drivers/usb/pegasus.h              |    3 
 drivers/usb/rtl8150.c              |   23 
 drivers/usb/scanner.c              |    5 
 drivers/usb/scanner.h              |   20 
 drivers/usb/serial/kobil_sct.c     |   23 
 drivers/usb/serial/pl2303.c        |   56 
 drivers/usb/serial/usbserial.c     |    1 
 drivers/usb/serial/visor.c         |   12 
 drivers/usb/speedcrc.c             |  124 +
 drivers/usb/speedcrc.h             |   30 
 drivers/usb/speedtouch.c           | 2554 ++++++++++++++++++++++++++++---------
 drivers/usb/storage/protocol.h     |    2 
 drivers/usb/storage/transport.c    |    2 
 drivers/usb/storage/transport.h    |    4 
 drivers/usb/storage/unusual_devs.h |  137 +
 drivers/usb/storage/usb.c          |    8 
 drivers/usb/storage/usb.h          |    2 
 drivers/usb/vicam.c                |   19 
 include/linux/hiddev.h             |   45 
 39 files changed, 5500 insertions(+), 1072 deletions(-)
-----

<hanno:gmx.de>:
  o USB: Patch for Vivicam 355

<richard.curnow:superh.com>:
  o USB: ehci-hcd.c needs to include <linux/bitops.h>

Alan Stern:
  o USB: US_SC_DEVICE and US_PR_DEVICE for 2.4

Ben Collins:
  o USB: Actually Fix 2.4 HID input
  o USB: fix keyboard leds
  o USB Multi-input quirk
  o USB: Happ UGCI added as BADPAD for workaround

Bryan W. Headley:
  o USB: Aiptek kernel driver 1.0 for Kernel 2.4

Christopher L. Cheney:
  o USB: vicam.c copyright patches

David Brownell:
  o USB: SMP ehci-q.c 1010 BUG()
  o USB: ehci i/o watchdog

David T. Hollis:
  o USB: AX8817X Driver for 2.4 Kernels

Duncan Sands:
  o USB speedtouch: parametrize the module
  o USB speedtouch: set owner fields
  o USB speedtouch: remove MOD_XXX_USE_COUNT
  o USB speedtouch: receive code rewrite
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: verbose debugging
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: replace yield()
  o USB speedtouch: add missing #include
  o USB speedtouch: trivial whitespace and name changes
  o USB speedtouch: remove trailing semicolon
  o USB speedtouch: compile fix
  o USB speedtouch: crc optimization
  o USB speedtouch: bump the version number
  o USB speedtouch: discard packets for non-existant vcc's
  o USB speedtouch: move MOD_INC_USE_COUNT
  o USB: Backport of USB speedtouch driver to 2.4

Geert Uytterhoeven:
  o USB: Big endian RTL8150

Greg Kroah-Hartman:
  o USB: clean up extra whitespace in visor.c driver
  o USB: fixup aiptek driver for older compilers
  o USB: add error reporting functionality to the pl2303 driver
  o USB: pegasus ethtool fixup
  o USB: fix break control for pl2303 driver
  o USB: add comment to storage/unusual_devs.h that specifies how to add new entries
  o USB: attempt to track down pl2303 oopses on close
  o USB: added support for Sony DSC-P8

Hartmut Wahl:
  o USB:  Patch for Samsung Digimax 410

Henning Meier-Geinitz:
  o USB: New vendor/product ids for scanner driver

James Courtier-Dutton:
  o USB: Add support for Pentax Still Camera to linux kernel

Johannes Erdfelt:
  o USB: fix 2.4 usbdevfs race

Lars Gemeinhardt:
  o USB: add support for Mello MP3 Player

Nicolas Dupeux:
  o USB: UNUSUAL_DEV for aiptek pocketcam

Olaf Hering:
  o USB: incorrect ethtool -i driver name
  o USB: incorrect ethtool -i driver name

Paul Stewart:
  o USB: HIDDev uref backport for 2.4?

Per Winkvist:
  o Re: unusual_devs.h patch that was in 2.5.68
  o USB: more unusual_devs.h changes

Petko Manolov:
  o USB: pegasus patch

Philipp Friedrich:
  o USB: unusual_devs.h patch

Sergey Vlasov:
  o USB: HIDDEV / UPS patches

Stefan M. Brandl:
  o USB: another usb storage addition

Thomas Wahrenbruch:
  o USB: kobil_sct.c added support for KAAN SIM Reader

Vojtech Pavlik:
  o USB: Fix HID logical min/max for 2.4
  o USB: Make Olympus cameras work with usb-storage

Walter Harms:
  o USB: fixes kernel_thread
  o USB: fixes kernel_thread

