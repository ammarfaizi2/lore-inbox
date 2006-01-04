Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWADW0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWADW0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWADW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:26:19 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:7128 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030309AbWADW0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:26:17 -0500
Date: Wed, 4 Jan 2006 14:26:06 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.15
Message-ID: <20060104222606.GA13522@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB patches for 2.6.15.  They contain a few new
drivers, and a bunch of bugfixes and other stuff.  All of these patches
have been in the -mm tree for quite a while.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/DocBook/usb.tmpl             |    1 
 MAINTAINERS                                |    8 
 arch/arm/mach-pxa/mainstone.c              |   21 
 arch/arm/mach-pxa/pxa27x.c                 |    6 
 drivers/block/Kconfig                      |    3 
 drivers/block/ub.c                         |  439 ++++--
 drivers/bluetooth/bcm203x.c                |    1 
 drivers/bluetooth/bfusb.c                  |    1 
 drivers/bluetooth/bpa10x.c                 |    1 
 drivers/bluetooth/hci_usb.c                |    1 
 drivers/char/watchdog/pcwd_usb.c           |    1 
 drivers/input/joystick/iforce/iforce-usb.c |    1 
 drivers/isdn/hisax/hfc_usb.c               |    1 
 drivers/isdn/hisax/st5481_init.c           |    1 
 drivers/media/dvb/b2c2/flexcop-usb.c       |    1 
 drivers/media/dvb/cinergyT2/cinergyT2.c    |    1 
 drivers/media/dvb/dvb-usb/a800.c           |    1 
 drivers/media/dvb/dvb-usb/cxusb.c          |    1 
 drivers/media/dvb/dvb-usb/dibusb-mb.c      |    1 
 drivers/media/dvb/dvb-usb/dibusb-mc.c      |    1 
 drivers/media/dvb/dvb-usb/digitv.c         |    1 
 drivers/media/dvb/dvb-usb/dtt200u.c        |    1 
 drivers/media/dvb/dvb-usb/nova-t-usb2.c    |    1 
 drivers/media/dvb/dvb-usb/umt-010.c        |    1 
 drivers/media/dvb/dvb-usb/vp702x.c         |    1 
 drivers/media/dvb/dvb-usb/vp7045.c         |    1 
 drivers/media/video/cpia_usb.c             |    1 
 drivers/media/video/em28xx/em28xx-video.c  |    1 
 drivers/net/irda/irda-usb.c                |    1 
 drivers/net/irda/stir4200.c                |    1 
 drivers/usb/Makefile                       |    1 
 drivers/usb/atm/Kconfig                    |   13 
 drivers/usb/atm/Makefile                   |    1 
 drivers/usb/atm/cxacru.c                   |    1 
 drivers/usb/atm/speedtch.c                 |    1 
 drivers/usb/atm/ueagle-atm.c               | 1842 ++++++++++++++++++++++++++++-
 drivers/usb/atm/usbatm.c                   |    4 
 drivers/usb/atm/xusbatm.c                  |    1 
 drivers/usb/class/audio.c                  |    1 
 drivers/usb/class/cdc-acm.c                |  234 ++-
 drivers/usb/class/cdc-acm.h                |   33 
 drivers/usb/class/usb-midi.c               |    1 
 drivers/usb/class/usblp.c                  |   45 
 drivers/usb/core/Makefile                  |    2 
 drivers/usb/core/buffer.c                  |    3 
 drivers/usb/core/devices.c                 |   24 
 drivers/usb/core/devio.c                   |    3 
 drivers/usb/core/driver.c                  |  588 ++++++++-
 drivers/usb/core/hcd.c                     |   10 
 drivers/usb/core/hcd.h                     |    1 
 drivers/usb/core/hub.c                     |  542 ++++----
 drivers/usb/core/hub.h                     |    3 
 drivers/usb/core/message.c                 |   12 
 drivers/usb/core/usb.c                     |  462 -------
 drivers/usb/core/usb.h                     |    6 
 drivers/usb/gadget/dummy_hcd.c             |   95 -
 drivers/usb/gadget/file_storage.c          |   93 -
 drivers/usb/gadget/serial.c                |    2 
 drivers/usb/host/Makefile                  |    4 
 drivers/usb/host/ehci-hcd.c                |   11 
 drivers/usb/host/ehci-hub.c                |    4 
 drivers/usb/host/ehci-pci.c                |   20 
 drivers/usb/host/ehci-q.c                  |   14 
 drivers/usb/host/isp116x-hcd.c             |  464 +++----
 drivers/usb/host/isp116x.h                 |   83 -
 drivers/usb/host/ohci-hcd.c                |   14 
 drivers/usb/host/ohci-hub.c                |    2 
 drivers/usb/host/ohci-pxa27x.c             |  129 +-
 drivers/usb/host/pci-quirks.c              |    6 
 drivers/usb/host/sl811-hcd.c               |   14 
 drivers/usb/host/sl811_cs.c                |    5 
 drivers/usb/host/uhci-debug.c              |   14 
 drivers/usb/host/uhci-hcd.c                |   32 
 drivers/usb/host/uhci-hcd.h                |   32 
 drivers/usb/host/uhci-q.c                  |   30 
 drivers/usb/image/mdc800.c                 |    1 
 drivers/usb/image/microtek.c               |    1 
 drivers/usb/input/Kconfig                  |   14 
 drivers/usb/input/Makefile                 |    1 
 drivers/usb/input/acecad.c                 |    1 
 drivers/usb/input/aiptek.c                 |    7 
 drivers/usb/input/appletouch.c             |    1 
 drivers/usb/input/ati_remote.c             |   22 
 drivers/usb/input/ati_remote2.c            |  477 +++++++
 drivers/usb/input/fixp-arith.h             |    2 
 drivers/usb/input/hid-core.c               |    3 
 drivers/usb/input/hid-input.c              |    4 
 drivers/usb/input/hiddev.c                 |    1 
 drivers/usb/input/itmtouch.c               |    1 
 drivers/usb/input/kbtab.c                  |    1 
 drivers/usb/input/keyspan_remote.c         |    3 
 drivers/usb/input/mtouchusb.c              |    1 
 drivers/usb/input/powermate.c              |    1 
 drivers/usb/input/touchkitusb.c            |  149 +-
 drivers/usb/input/usbkbd.c                 |    1 
 drivers/usb/input/usbmouse.c               |    1 
 drivers/usb/input/wacom.c                  |    1 
 drivers/usb/input/xpad.c                   |    7 
 drivers/usb/input/yealink.c                |    1 
 drivers/usb/media/dabusb.c                 |    1 
 drivers/usb/media/dsbr100.c                |    1 
 drivers/usb/media/ibmcam.c                 |    2 
 drivers/usb/media/konicawc.c               |    6 
 drivers/usb/media/ov511.c                  |    3 
 drivers/usb/media/pwc/pwc-ctrl.c           |    2 
 drivers/usb/media/pwc/pwc-if.c             |    1 
 drivers/usb/media/se401.c                  |    1 
 drivers/usb/media/sn9c102_core.c           |   24 
 drivers/usb/media/stv680.c                 |    1 
 drivers/usb/media/stv680.h                 |    6 
 drivers/usb/media/usbvideo.c               |    4 
 drivers/usb/media/vicam.c                  |    1 
 drivers/usb/media/w9968cf.c                |    7 
 drivers/usb/misc/auerswald.c               |    5 
 drivers/usb/misc/cytherm.c                 |    1 
 drivers/usb/misc/emi26.c                   |    1 
 drivers/usb/misc/emi62.c                   |    1 
 drivers/usb/misc/idmouse.c                 |    1 
 drivers/usb/misc/ldusb.c                   |    1 
 drivers/usb/misc/legousbtower.c            |    1 
 drivers/usb/misc/phidgetkit.c              |    1 
 drivers/usb/misc/phidgetservo.c            |    1 
 drivers/usb/misc/rio500.c                  |    5 
 drivers/usb/misc/sisusbvga/sisusb.c        |   11 
 drivers/usb/misc/usblcd.c                  |    1 
 drivers/usb/misc/usbled.c                  |    1 
 drivers/usb/misc/usbtest.c                 |    1 
 drivers/usb/misc/uss720.c                  |    1 
 drivers/usb/mon/mon_text.c                 |   19 
 drivers/usb/net/asix.c                     |    5 
 drivers/usb/net/catc.c                     |    1 
 drivers/usb/net/cdc_ether.c                |    1 
 drivers/usb/net/cdc_subset.c               |    1 
 drivers/usb/net/gl620a.c                   |    1 
 drivers/usb/net/kaweth.c                   |    1 
 drivers/usb/net/net1080.c                  |    1 
 drivers/usb/net/pegasus.c                  |  144 +-
 drivers/usb/net/plusb.c                    |    1 
 drivers/usb/net/rndis_host.c               |    1 
 drivers/usb/net/rtl8150.c                  |    1 
 drivers/usb/net/zaurus.c                   |    1 
 drivers/usb/net/zd1201.c                   |   11 
 drivers/usb/serial/airprime.c              |    2 
 drivers/usb/serial/anydata.c               |    2 
 drivers/usb/serial/belkin_sa.c             |    2 
 drivers/usb/serial/cp2101.c                |    2 
 drivers/usb/serial/cyberjack.c             |    2 
 drivers/usb/serial/cypress_m8.c            |    1 
 drivers/usb/serial/digi_acceleport.c       |    2 
 drivers/usb/serial/empeg.c                 |    2 
 drivers/usb/serial/ftdi_sio.c              |    6 
 drivers/usb/serial/ftdi_sio.h              |   13 
 drivers/usb/serial/garmin_gps.c            |    2 
 drivers/usb/serial/generic.c               |    2 
 drivers/usb/serial/hp4x.c                  |    2 
 drivers/usb/serial/io_edgeport.c           |    6 
 drivers/usb/serial/io_edgeport.h           |    3 
 drivers/usb/serial/io_fw_boot2.h           |    2 
 drivers/usb/serial/io_ti.c                 |    4 
 drivers/usb/serial/ipaq.c                  |    2 
 drivers/usb/serial/ipw.c                   |    2 
 drivers/usb/serial/ir-usb.c                |    2 
 drivers/usb/serial/keyspan.h               |    2 
 drivers/usb/serial/keyspan_pda.c           |    2 
 drivers/usb/serial/kl5kusb105.c            |    2 
 drivers/usb/serial/kobil_sct.c             |    2 
 drivers/usb/serial/mct_u232.c              |    2 
 drivers/usb/serial/omninet.c               |    2 
 drivers/usb/serial/option.c                |    2 
 drivers/usb/serial/pl2303.c                |    4 
 drivers/usb/serial/safe_serial.c           |    6 
 drivers/usb/serial/ti_usb_3410_5052.c      |    9 
 drivers/usb/serial/usb-serial.c            |   48 
 drivers/usb/serial/usb-serial.h            |    4 
 drivers/usb/serial/visor.c                 |    2 
 drivers/usb/serial/whiteheat.c             |    2 
 drivers/usb/storage/Kconfig                |   23 
 drivers/usb/storage/Makefile               |    5 
 drivers/usb/storage/alauda.c               | 1119 +++++++++++++++++
 drivers/usb/storage/alauda.h               |  100 +
 drivers/usb/storage/debug.c                |    1 
 drivers/usb/storage/initializers.h         |    4 
 drivers/usb/storage/libusual.c             |  320 ++++-
 drivers/usb/storage/onetouch.c             |   27 
 drivers/usb/storage/protocol.h             |   14 
 drivers/usb/storage/sddr09.c               |  216 ++-
 drivers/usb/storage/sddr09.h               |   15 
 drivers/usb/storage/transport.h            |   31 
 drivers/usb/storage/unusual_devs.h         |   74 -
 drivers/usb/storage/usb.c                  |  160 --
 drivers/usb/storage/usb.h                  |   40 
 drivers/usb/usb-skeleton.c                 |   35 
 drivers/w1/dscore.c                        |    1 
 include/asm-arm/arch-pxa/ohci.h            |   18 
 include/linux/usb.h                        |   33 
 include/linux/usb_usual.h                  |  126 +
 sound/usb/usbaudio.c                       |    1 
 sound/usb/usx2y/usbusx2y.c                 |    1 
 198 files changed, 6714 insertions(+), 2188 deletions(-)


A.YOSHIYAMA:
      USB: usb-net: new device ID passed through module parameter

Adrian Bunk:
      USB: small cleanups
      USB: drivers/usb/misc/sisusbvga/sisusb.c: remove dead code

Alan Stern:
      USB: EHCI: fix conflation of buf == 0 with len == 0
      USB: file-storage gadget: Add reference count for children
      USB: central handling for host controllers that were reset during suspend/resume
      USB: dummy_hcd: rename variables
      USB: Fix locking for USB suspend/resume
      USB: Consider power budget when choosing configuration
      USB: Disconnect children during hub unbind
      USB: Remove USB private semaphore
      USB: Store port number in usb_device
      USB: Don't assume root-hub resume succeeds
      USB Gadget: dummy_hcd: updates to hcd->state
      USB Gadget: file_storage: remove "volatile" declarations
      USB: UHCI: edit some comments
      USB: UHCI: change uhci_explen macro
      USB: fix local variable clash

Arjan van de Ven:
      USB: mark various usb tables const

Chris Humbert:
      USB: don't allocate dma pools for PIO HCDs

Daniel Marjamaki:
      USB: ub 02 Removed unused variable

Daniel Marjamäki:
      USB: isp116x-hcd.c: Removed unused variable

Daniel Ritz:
      USB: input/touchkitusb: handle multiple packets

David Brownell:
      USB: wakeup flag updates (1/3) sl811-hcd
      USB: EHCI updates (4/4) driver model wakeup flags
      USB: wakeup flag updates (3/3) isp116x-hcd
      USB: wakeup flag updates (2/3) uhci-hcd
      USB: hcd uses EXTRA_CFLAGS for -DDEBUG
      USB: ehci fix driver model wakeup flags

David Hollis:
      USB: asix.c - Add Linksys USB200M Rev 2 ids

David Kubicek:
      USB: Converting cdc acm to a ring queue

David Woodhouse:
      USB: Export IEEE-1284 device id in sysfs for usblp devices

fabien COSSE:
      USB Storage: add unusual_devs entry for NIKON Coolpix 2000

Fengwei Yin:
      USB: One potential problem in gadget/serial.c

Greg Kroah-Hartman:
      USB: reorg some functions out of the main usb.c file
      USB: make registering a usb driver automatically set the module owner
      USB: add dynamic id functionality to USB core
      USB: allow usb drivers to disable dynamic ids
      USB: remove .owner field from struct usb_driver

Horst Schirmeier:
      USB: pl2303_update_line_status data length fix

Ian Abbott:
      USB: ftdi_sio: new IDs for Teratronik devices

Jesper Juhl:
      USB: Remove unneeded kmalloc() return value casts

Luiz Fernando Capitulino:
      USB: usbserial: Adds missing checks and bug fix.
      USB: usbserial: race-condition fix.

Marcelo Feitoza Parisi:
      USB: ati_remote: use time_before() and friends

Matthew Dharm:
      USB Storage: sddr09 cleanups
      USB Storage: make OneTouch PM-aware
      USB Storage: cleanups of sddr09
      USB Storage: update MAINTAINERS
      USB Storage: more sddr09 cleanups
      USB Storage: add alauda support

matthieu castet:
      USB: Eagle and ADI 930 usb adsl modem driver fix
      USB: Eagle and ADI 930 usb adsl modem driver

Nathan Lynch:
      USB: zd1201: make sysfs device symlink

Olav Kongas:
      USB: isp116x-hcd: support reiniting HC on resume
      USB: isp116x-hcd: cleanup
      USB: isp116x-hcd: minor cleanup
      USB: fix buffer size limiting in skeleton driver

Oliver Neukum:
      USB: Limiting of resource use in skeleton driver

Paul Walmsley:
      USB: usb-storage: add debug entry for REPORT LUNS

Pavel Fedin:
      USB: Support for Posiflex PP-7000 retail printer in Linux

Pavel Machek:
      USB: Cleanups for usb gadget mass-storage

Pete Zaitcev:
      USB: make bias writeable in libusual
      USB: drivers/usb/storage/libusual
      USB: Let usbmon collect less garbage
      USB: ub 00 implement retries and resets
      USB: ub 01 rename
      USB: ioctl compat for usblp.c
      USB: replace __setup("nousb") with __module_param_call
      USB: fix usb_find_interface for ppc64

Petko Manolov:
      USB: usb-net: removes redundant return

Phil Dibowitz:
      USB Storage: Fix unusual_devs.h order

Richard Purdie:
      USB: pxa27x OHCI - Separate platform code from main driver
      USB: Add pxa27x OHCI PM functions
      USB: Correct ohci-pxa27x suspend/resume struct confusion

Sam Bishop:
      USB: fix usb-skeleton limit resource usage patch.

Tobias Klauser:
      USB: Use ARRAY_SIZE macro

Ville Syrjälä:
      USB: add driver for ATI/Philips USB RF remotes

