Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVF0WBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVF0WBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVF0WBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:01:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:58850 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261867AbVF0WAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:00:53 -0400
Date: Mon, 27 Jun 2005 15:00:42 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.12
Message-ID: <20050627220042.GA23269@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB patches against your latest git tree.  They include:
	- new host controller driver
	- rewrite of the usb atm driver
	- lots of gadget fixes and changes
	- USB OTG header definitions
	- lots of usb host controller driver tweaks.
	- loads of other fixes all over the place.

All of these patches have been in the -mm tree for the past few months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h


 arch/arm/mach-omap/usb.c          |    8 
 drivers/usb/Makefile              |    1 
 drivers/usb/atm/Kconfig           |   50 
 drivers/usb/atm/Makefile          |    7 
 drivers/usb/atm/cxacru.c          |  878 +++++++++++++++++
 drivers/usb/atm/speedtch.c        | 1103 ++++++++++-----------
 drivers/usb/atm/usb_atm.c         | 1188 -----------------------
 drivers/usb/atm/usb_atm.h         |  176 ---
 drivers/usb/atm/usbatm.c          | 1266 ++++++++++++++++++++++++-
 drivers/usb/atm/usbatm.h          |  186 +++
 drivers/usb/atm/xusbatm.c         |  196 +++
 drivers/usb/class/cdc-acm.c       |  209 +++-
 drivers/usb/class/cdc-acm.h       |   25 
 drivers/usb/class/usblp.c         |    3 
 drivers/usb/core/devio.c          |    6 
 drivers/usb/core/hcd.c            |  281 +++--
 drivers/usb/core/hcd.h            |   19 
 drivers/usb/core/hub.c            |   19 
 drivers/usb/core/hub.h            |   11 
 drivers/usb/gadget/Kconfig        |   11 
 drivers/usb/gadget/dummy_hcd.c    |  825 ++++++++++------
 drivers/usb/gadget/ether.c        |  359 ++-----
 drivers/usb/gadget/file_storage.c |   67 -
 drivers/usb/gadget/goku_udc.c     |   28 
 drivers/usb/gadget/inode.c        |   12 
 drivers/usb/gadget/ndis.h         |   14 
 drivers/usb/gadget/net2280.c      |   51 -
 drivers/usb/gadget/omap_udc.c     |  303 ++++--
 drivers/usb/gadget/omap_udc.h     |    4 
 drivers/usb/gadget/pxa2xx_udc.c   |   43 
 drivers/usb/gadget/pxa2xx_udc.h   |   10 
 drivers/usb/gadget/rndis.c        |  517 +++++-----
 drivers/usb/gadget/rndis.h        |   95 -
 drivers/usb/gadget/serial.c       |   36 
 drivers/usb/gadget/zero.c         |    6 
 drivers/usb/host/Kconfig          |   13 
 drivers/usb/host/Makefile         |    1 
 drivers/usb/host/ehci-dbg.c       |   59 +
 drivers/usb/host/ehci-hcd.c       |   58 -
 drivers/usb/host/ehci-hub.c       |    2 
 drivers/usb/host/ehci-q.c         |    2 
 drivers/usb/host/ehci-sched.c     |   17 
 drivers/usb/host/isp116x-hcd.c    | 1909 +++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/isp116x.h        |  583 +++++++++++
 drivers/usb/host/ohci-hcd.c       |   60 -
 drivers/usb/host/ohci-mem.c       |    1 
 drivers/usb/host/ohci-omap.c      |    4 
 drivers/usb/host/ohci.h           |    2 
 drivers/usb/host/sl811-hcd.c      |   20 
 drivers/usb/host/uhci-debug.c     |   32 
 drivers/usb/host/uhci-hcd.c       | 1211 ++++++++++++------------
 drivers/usb/host/uhci-hcd.h       |   73 -
 drivers/usb/host/uhci-hub.c       |   91 +
 drivers/usb/host/uhci-q.c         |   58 -
 drivers/usb/input/ati_remote.c    |    1 
 drivers/usb/media/stv680.c        |    8 
 drivers/usb/media/stv680.h        |    5 
 drivers/usb/misc/idmouse.c        |  149 +-
 drivers/usb/misc/usbtest.c        |   60 +
 drivers/usb/net/usbnet.c          |    2 
 drivers/usb/net/zd1201.c          |   41 
 drivers/usb/net/zd1201.h          |    1 
 drivers/usb/serial/cyberjack.c    |   19 
 drivers/usb/serial/generic.c      |   24 
 drivers/usb/serial/ipaq.c         |    5 
 drivers/usb/serial/ipw.c          |   14 
 drivers/usb/serial/ir-usb.c       |   16 
 drivers/usb/serial/keyspan_pda.c  |   19 
 drivers/usb/serial/omninet.c      |   17 
 drivers/usb/serial/safe_serial.c  |   13 
 drivers/usb/serial/usb-serial.c   |    1 
 drivers/usb/serial/usb-serial.h   |    3 
 drivers/usb/storage/scsiglue.c    |   54 -
 drivers/usb/storage/scsiglue.h    |    1 
 drivers/usb/storage/transport.c   |  118 +-
 drivers/usb/storage/transport.h   |    1 
 include/asm-arm/arch-omap/usb.h   |    9 
 include/linux/usb_ch9.h           |  183 +++
 include/linux/usb_gadget.h        |    2 
 include/linux/usb_isp116x.h       |   47 
 80 files changed, 8883 insertions(+), 4139 deletions(-)

---------------

Alan Stern:
  USB: usbcore: inverted test for resuming interfaces
  USB UHCI: Detect invalid ports
  USB: dummy_hcd: sparse cleanups
  USB: dummy_hcd: add suspend/resume support
  USB dummy_hcd: Centralize link state computations
  USB dummy_hcd: Use separate pdevs for HC and UDC
  USB dummy_hcd: Use root-hub interrupts instead of polling
  USB: dummy_hcd: USB_PORT_FEAT changed to USB_PORT_STAT
  USB dummy_hcd: Partial OTG emulation
  ohci-omap, sl811, dummy: remove hub_set_power_budget
  usbcore: register root hub in usb_add_hcd
  USB HCDs: no longer need to register root hub
  usbcore: Remove hub_set_power_budget
  UHCI: Don't store device pointer in QH or TD
  usbcore support for root-hub IRQ instead of polling
  USB UHCI: Add shutdown method
  USB UHCI: improved reset handling
  USB UHCI: Use root-hub IRQs while suspended
  USB UHCI: Fix up loose ends
  USB UHCI: Minor improvements
  USB UHCI: Add root hub states
  USB UHCI: Add root-hub suspend/resume support
  USB UHCI: subroutine reordering
  USB: g_file_storage: export "stall" parameter
  USB: g_file_storage: Consolidate min()s

Andrew Morton:
  USB: fix usbatm gcc-2.95.x bug
  USB: fix speedtch.c merge with next patch.

C. Adam Oldham:
  USB: Fix race condition in usblp_write

Colin Leroy:
  USB: check for device in zd1201_resume
  USB: PM support for zd1201

David Brownell:
  USB: usbnet debug message fix
  USB: resolve ethernet gadget build glitch on pxa
  USB: wireless usb <linux/usb_ch9.h> declarations
  USB: ehci-hcd - fix page pointer allocation in itd_patch()
  USB gadget: drain rndis response queue on disconnect
  USB: fix drivers/usb/gadget/ether.c compile error
  USB: misc ehci updates
  USB: goku_udc updates (sparse, SETUP api change)
  USB: pxa2xx_udc updates
  USB: net2280 updates (sparse, SETUP api change)
  USB: gadget driver updates (SETUP api change)
  USB: Kconfig fixes for usb/gadget
  USB: ethernet gadget updates (mostly cleanup)
  USB: more omap_udc updates (dma and omap1710)
  USB: rndis updates (mostly cleanup)
  USB: usbtest updates
  USB: add reboot notifier to ohci
  USB: turn a user mode driver error into a hard error
  USB: omap_udc updates (mostly cleanups)

Domen Puncer:
  USB: usblp: 2x up() in usblp_read

Duncan Sands:
  USB: usbatm kcalloc cleanup
  USB ATM: avoid oops on bind failure; plug memory leak
  USB ATM: reduce log spamming
  USB ATM: bits and bobs
  USB ATM: generic DSL modem driver xusbatm
  USB ATM: port speedtch to new usbatm core
  USB ATM: driver for the Conexant AccessRunner chipset cxacru
  USB ATM: new usbatm core

Florian Echtler:
  USB: upgrade of the idmouse driver

Greg Kroah-Hartman:
  USB: add ability for usb-serial drivers to determine if their write urb is currently being used.

Kiril Jovchev:
  USB: add support for Creative WebCam mini to stv680 driver

Matthew Dharm:
  USB Storage: retry hard errors
  USB Storage: port reset on transport error
  USB Storage: endpoint toggles and reset delays

Olav Kongas:
  USB: Fix oops at rmmod after failed probe in isp116x-hcd
  USB: Add isp116x-hcd USB host controller driver

Oliver Neukum:
  USB: fix acm trouble with terminals

Vincent Vanackere:
  USB: fix atiremote input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)

