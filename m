Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUENWqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUENWqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUENWqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:46:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:20180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263062AbUENWqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:46:24 -0400
Date: Fri, 14 May 2004 15:45:16 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.6.6
Message-ID: <20040514224516.GA16814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are USB patches for 2.6.62.  There are a bunch of different things
here:
	- interface access fixups
	- bugfixes
	- a few new drivers
	- lots more bugfixes

All of these (with the exception of a few minor patches from today) have
been in the -mm tree for quite some time.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/mtouchusb.txt      |   91 +---
 MAINTAINERS                          |   14 
 drivers/bluetooth/bfusb.c            |    9 
 drivers/bluetooth/hci_usb.c          |    2 
 drivers/isdn/hisax/st5481_b.c        |    9 
 drivers/isdn/hisax/st5481_d.c        |    9 
 drivers/isdn/hisax/st5481_usb.c      |   10 
 drivers/media/video/cpia_usb.c       |    4 
 drivers/net/irda/irda-usb.c          |    2 
 drivers/usb/Makefile                 |    1 
 drivers/usb/class/bluetty.c          |    4 
 drivers/usb/class/cdc-acm.c          |  275 ++++++------
 drivers/usb/core/config.c            |  368 +++++++++-------
 drivers/usb/core/devices.c           |   47 +-
 drivers/usb/core/devio.c             |  410 +++++++++---------
 drivers/usb/core/hcd-pci.c           |   77 ++-
 drivers/usb/core/hcd.c               |   51 +-
 drivers/usb/core/hcd.h               |   13 
 drivers/usb/core/hub.c               |  652 +++++++++++++++++++++--------
 drivers/usb/core/hub.h               |    2 
 drivers/usb/core/inode.c             |    6 
 drivers/usb/core/message.c           |  103 +++-
 drivers/usb/core/urb.c               |   23 -
 drivers/usb/core/usb.c               |  132 ++----
 drivers/usb/gadget/dummy_hcd.c       |  166 ++++++-
 drivers/usb/gadget/file_storage.c    |    2 
 drivers/usb/gadget/gadget_chips.h    |    2 
 drivers/usb/gadget/serial.c          |    6 
 drivers/usb/gadget/zero.c            |   65 ++
 drivers/usb/host/ehci-dbg.c          |   30 +
 drivers/usb/host/ehci-hcd.c          |  138 +++---
 drivers/usb/host/ehci-hub.c          |  182 ++++++++
 drivers/usb/host/ehci-mem.c          |   39 +
 drivers/usb/host/ehci-q.c            |   10 
 drivers/usb/host/ehci-sched.c        |    6 
 drivers/usb/host/ehci.h              |   22 -
 drivers/usb/host/ohci-dbg.c          |   14 
 drivers/usb/host/ohci-hcd.c          |  138 ++++--
 drivers/usb/host/ohci-hub.c          |  296 +++++++++++++
 drivers/usb/host/ohci-mem.c          |    3 
 drivers/usb/host/ohci-pci.c          |  176 +-------
 drivers/usb/host/ohci-q.c            |   21 
 drivers/usb/host/ohci.h              |   38 +
 drivers/usb/host/uhci-hcd.c          |   91 +++-
 drivers/usb/host/uhci-hcd.h          |   16 
 drivers/usb/image/mdc800.c           |   12 
 drivers/usb/input/Kconfig            |   13 
 drivers/usb/input/Makefile           |    1 
 drivers/usb/input/aiptek.c           |    4 
 drivers/usb/input/hid-core.c         |   22 -
 drivers/usb/input/kbtab.c            |    2 
 drivers/usb/input/mtouchusb.c        |  111 +----
 drivers/usb/input/touchkitusb.c      |  310 ++++++++++++++
 drivers/usb/input/wacom.c            |    4 
 drivers/usb/media/dsbr100.c          |  228 ++++++----
 drivers/usb/media/ibmcam.c           |    9 
 drivers/usb/media/konicawc.c         |   17 
 drivers/usb/media/ov511.c            |   14 
 drivers/usb/media/pwc-if.c           |    7 
 drivers/usb/media/se401.c            |    2 
 drivers/usb/media/ultracam.c         |    9 
 drivers/usb/media/vicam.c            |    2 
 drivers/usb/media/w9968cf.h          |    4 
 drivers/usb/misc/Kconfig             |   12 
 drivers/usb/misc/Makefile            |    1 
 drivers/usb/misc/cytherm.c           |    9 
 drivers/usb/misc/emi26.c             |    2 
 drivers/usb/misc/emi26_fw.h          |    6 
 drivers/usb/misc/emi62.c             |    2 
 drivers/usb/misc/emi62_fw_m.h        |    7 
 drivers/usb/misc/emi62_fw_s.h        |    7 
 drivers/usb/misc/legousbtower.c      |  767 ++++++++++++++++++++++-------------
 drivers/usb/misc/phidgetservo.c      |  361 +++++++++++++++-
 drivers/usb/misc/tiglusb.c           |   64 ++
 drivers/usb/misc/usbtest.c           |    6 
 drivers/usb/misc/uss720.c            |    2 
 drivers/usb/net/kaweth.c             |   18 
 drivers/usb/net/pegasus.c            |    4 
 drivers/usb/net/rtl8150.c            |    8 
 drivers/usb/net/usbnet.c             |   56 +-
 drivers/usb/serial/belkin_sa.c       |   28 -
 drivers/usb/serial/console.c         |    5 
 drivers/usb/serial/cyberjack.c       |   31 -
 drivers/usb/serial/digi_acceleport.c |   18 
 drivers/usb/serial/empeg.c           |   34 -
 drivers/usb/serial/ftdi_sio.c        |  125 ++---
 drivers/usb/serial/generic.c         |   21 
 drivers/usb/serial/io_edgeport.c     |  140 ++----
 drivers/usb/serial/io_ti.c           |  102 +---
 drivers/usb/serial/ipaq.c            |   33 -
 drivers/usb/serial/ir-usb.c          |   41 -
 drivers/usb/serial/keyspan.c         |    9 
 drivers/usb/serial/keyspan.h         |   19 
 drivers/usb/serial/keyspan_pda.c     |   25 -
 drivers/usb/serial/kl5kusb105.c      |   58 --
 drivers/usb/serial/kobil_sct.c       |    7 
 drivers/usb/serial/omninet.c         |   48 --
 drivers/usb/serial/pl2303.c          |   39 -
 drivers/usb/serial/pl2303.h          |    3 
 drivers/usb/serial/safe_serial.c     |   15 
 drivers/usb/serial/usb-serial.c      |   99 +---
 drivers/usb/serial/usb-serial.h      |   67 ---
 drivers/usb/serial/visor.c           |   49 --
 drivers/usb/serial/visor.h           |    1 
 drivers/usb/serial/whiteheat.c       |   23 -
 drivers/usb/storage/datafab.c        |    2 
 drivers/usb/storage/isd200.c         |   26 -
 drivers/usb/storage/jumpshot.c       |    2 
 drivers/usb/storage/scsiglue.c       |   19 
 drivers/usb/storage/shuttle_usbat.c  |  142 +++---
 drivers/usb/storage/shuttle_usbat.h  |   20 
 drivers/usb/storage/transport.c      |   58 +-
 drivers/usb/storage/unusual_devs.h   |   40 +
 drivers/usb/storage/usb.c            |    4 
 drivers/usb/storage/usb.h            |    6 
 include/linux/usb.h                  |   46 +-
 include/linux/usbdevice_fs.h         |    1 
 117 files changed, 4466 insertions(+), 2818 deletions(-)
-----

<al.fracchetti:tin.it>:
  o USB Storage: Kyocera Finecsm 3L -unusual_devs.h

<c.lucas:ifrance.com>:
  o USB: esthetic and trivial patch

<colin:colino.net>:
  o USB: cosmetic fixes for cdc-acm

<linux-usb:nerds-incorporated.org>:
  o USB: Alcatel TD10 Serial to USB converter cable support

<sean:mess.org>:
  o USB: fix PhidgetServo driver
  o USB: add new USB PhidgetServo driver

<stuber:loria.fr>:
  o USB: LEGO USB Tower driver v0.95

Alan Stern:
  o USB: Don't delete interfaces until all are unbound
  o USB: Accept devices with funky interface/altsetting numbers
  o USB Gadget: Fix file-storage gadget Request Sense length
  o (as268) Import device-reset changes from gadget-2.6 tree
  o USB: Small change to CPiA USB driver
  o USB Storage: unusual_devs.h update
  o USB: Reduce kernel stack usage
  o USB: Altsetting update for USB IrDA driver
  o USB: USB altsetting updates for IDSN Hisax driver
  o USB: Lock devices during tree traversal
  o USB: Allocate interface structures dynamically
  o USB: Altsetting updates for usb/serial
  o USB: Altsetting update for USB net drivers
  o USB: Altsetting update for USB misc drivers
  o USB: Altsetting updates for USB media drivers
  o USB: Cosmetic improvements for the UHCI driver
  o USB: Ignore URB_NO_INTERRUPT flag in UHCI
  o USB: Eliminate dead code from the UHCI driver
  o USB: Implement endpoint_disable() for UHCI
  o USB: unusual_devs.h update
  o USB: Remove unusual_devs entries for Minolta DiMAGE 7, 7Hi

Andrew Morton:
  o USB: fix ohci-hcd build error

Daniel Ritz:
  o USB: add support for eGalax Touchscreen USB

Daniele Bellucci:
  o USB: audits in usb_init()

David Brownell:
  o USB: hcd-pci suspend tweak
  o USB: ohci resume fix
  o USB: usbhid calls itself "hid"
  o USB: missing probe() diagnostics for CDC Ethernet
  o USB: OHCI root hub suspend/resume/wakeup
  o USB: khubd turns port power back on after reset
  o USB: OHCI cleanups
  o USB: OHCI resume/reset stops deadlocking in PM code
  o USB: more functional HCD PCI PM glue
  o USB: EHCI power management updates
  o USB: usbnet handles Billionton Systems USB2AR
  o USB: dummy_hcd, root port wakeup/suspend
  o USB: reject urb submissions to suspended devices
  o USB Gadget: gadget zero and USB suspend/resume
  o USB: fix sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
  o USB: khubd fixes
  o USB: re-factor enumeration logic
  o USB: usbtest, smp unlink modes
  o USB: root hubs can report remote wakeup feature
  o USB: fix usbfs iso interval problem

Duncan Sands:
  o USB: compile fix for usbfs snooping
  o USB: Patch to remove interface indices from devio.c
  o USB: fix WARN_ON in usbfs
  o USB: usbfs: change extern inline to static inline
  o USB: be assertive in usbfs
  o USB usbfs: drop pointless racy check
  o USB usbfs: missing lock in proc_getdriver
  o USB usbfs: destroy submitted urbs only on the disconnected interface
  o USB usbfs: fix up releaseintf
  o USB usbfs: fix up proc_ioctl
  o USB usbfs: fix up proc_setconfig
  o USB usbfs: remove obsolete comment from proc_resetdevice
  o USB usbfs: replace the per-file semaphore with the per-device semaphore
  o USB usbfs: take a reference to the usb device

Greg Kroah-Hartman:
  o USB: convert visor to use module_param()
  o USB: convert pl2303 to use module_param()
  o USB: change usbserial core to use module_param()
  o USB: remove get_usb_serial() as it's pretty much unneeded
  o USB: remove serial_paranoia_check() function
  o USB: removed port_paranoia_check() call for usb serial drivers
  o USB: remove magic number field from struct usb_serial as it's pretty useless
  o USB: remove magic number field from usb_serial_port as it's pretty useless
  o USB: add snooping capability to usbfs for control messages
  o USB: make functions static in usb drivers that should be
  o USB: add support for Zire 31 devices
  o USB: fix build error in hci_usb driver due to urb reference count change
  o USB: remove the wait_for_urb function from bfusb driver as it's no longer needed
  o USB: fix compiler warnings in devices.c file
  o USB: fix incorrect usb-serial conversion for cur_altsetting from previous patch
  o USB: make ehci driver use a kref instead of an atomic_t
  o USB: removed unused atomic_t in keyspan driver structure
  o USB: switch struct urb to use a kref instead of it's own atomic_t
  o USB: fix devio compiler warnings created by previous patch

Hanna V. Linder:
  o USB: Add class support to drivers/usb/misc/tiglusb.c

Herbert Xu:
  o USB Storage: Sony Clie

Luiz Capitulino:
  o USB: fix media/dsbr100.c unused variable

Markus Demleitner:
  o USB: DSBR-100 tiny patch

Matthew Dharm:
  o USB: usb-storage driver changes for 2.6.x [4/4]
  o USB: usb-storage driver changes for 2.6.x [3/4]
  o USB: usb-storage driver changes for 2.6.x [2/4]
  o USB: usb-storage driver changes for 2.6.x [1/4]

Oliver Neukum:
  o USB: fixes of assumptions about waitqueues

Stefan Eletzhofer:
  o USB Gadget: fix g_serial debug module parm
  o USB Gadget: fix pxa define in gadget_chips.h

Todd E. Johnson:
  o USB: update for mtouchusb
  o USB: mtouchusb update for 2.6.6-rc2

Tony Lindgren:
  o USB: Merge support for Keyspan UPR-112 USB serial adapter from 2.4 to 2.6

