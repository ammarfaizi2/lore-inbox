Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUJSP4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUJSP4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269479AbUJSP4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:56:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:30897 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269474AbUJSPzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:55:53 -0400
Date: Tue, 19 Oct 2004 08:55:14 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.9
Message-ID: <20041019155514.GA747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of various USB fixes and cleanups for 2.6.9.  All
of these patches have been in the past few -mm releases.

There's loads of stuff in here, see the summary at the end of this email
for a list of everything.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/misc/speedtch.c                 | 1373 -----------------
 CREDITS                                     |  137 +
 Documentation/kernel-parameters.txt         |   22 
 Documentation/usb/sn9c102.txt               |  111 -
 MAINTAINERS                                 |   77 -
 arch/arm/mach-pxa/pxa27x.c                  |   88 +
 drivers/block/ub.c                          |  169 +-
 drivers/net/irda/stir4200.c                 |   10 
 drivers/pci/quirks.c                        |  472 ++++++
 drivers/usb/Kconfig                         |    6 
 drivers/usb/Makefile                        |    4 
 drivers/usb/atm/Kconfig                     |   30 
 drivers/usb/atm/Makefile                    |    7 
 drivers/usb/atm/speedtch.c                  | 1546 +++++++++++++++-----
 drivers/usb/atm/usb_atm.c                   | 2143 +++++++++++++++++++++-------
 drivers/usb/atm/usb_atm.h                   |  187 ++
 drivers/usb/class/Kconfig                   |    3 
 drivers/usb/class/audio.c                   |   37 
 drivers/usb/class/bluetty.c                 |   48 
 drivers/usb/class/cdc-acm.c                 |   91 -
 drivers/usb/class/cdc-acm.h                 |    1 
 drivers/usb/class/usb-midi.c                |   19 
 drivers/usb/class/usblp.c                   |   28 
 drivers/usb/core/devices.c                  |   18 
 drivers/usb/core/devio.c                    |   57 
 drivers/usb/core/hcd-pci.c                  |   16 
 drivers/usb/core/hcd.c                      |   99 -
 drivers/usb/core/hcd.h                      |   10 
 drivers/usb/core/hub.c                      |  425 ++---
 drivers/usb/core/inode.c                    |  121 -
 drivers/usb/core/message.c                  |   62 
 drivers/usb/core/sysfs.c                    |   64 
 drivers/usb/core/urb.c                      |    7 
 drivers/usb/core/usb.c                      |  200 ++
 drivers/usb/core/usb.h                      |   10 
 drivers/usb/gadget/Kconfig                  |   15 
 drivers/usb/gadget/dummy_hcd.c              |   39 
 drivers/usb/gadget/ether.c                  |   46 
 drivers/usb/gadget/file_storage.c           |   43 
 drivers/usb/gadget/gadget_chips.h           |    6 
 drivers/usb/gadget/goku_udc.c               |   14 
 drivers/usb/gadget/lh7a40x_udc.c            |    7 
 drivers/usb/gadget/net2280.c                |   74 
 drivers/usb/gadget/omap_udc.c               |  146 +
 drivers/usb/gadget/omap_udc.h               |   11 
 drivers/usb/gadget/pxa2xx_udc.c             |   34 
 drivers/usb/gadget/rndis.c                  |   51 
 drivers/usb/gadget/zero.c                   |    2 
 drivers/usb/host/ehci-hcd.c                 |   35 
 drivers/usb/host/ehci-hub.c                 |    4 
 drivers/usb/host/ehci.h                     |    7 
 drivers/usb/host/hc_sl811.c                 |    8 
 drivers/usb/host/ohci-dbg.c                 |   16 
 drivers/usb/host/ohci-hcd.c                 |  533 ++++--
 drivers/usb/host/ohci-hub.c                 |  193 --
 drivers/usb/host/ohci-lh7a404.c             |   30 
 drivers/usb/host/ohci-omap.c                |   30 
 drivers/usb/host/ohci-pci.c                 |   69 
 drivers/usb/host/ohci-pxa27x.c              |  460 ++++++
 drivers/usb/host/ohci-sa1111.c              |   25 
 drivers/usb/host/ohci.h                     |  108 +
 drivers/usb/host/uhci-hcd.c                 |  508 +-----
 drivers/usb/host/uhci-hcd.h                 |   36 
 drivers/usb/host/uhci-hub.c                 |  292 ++-
 drivers/usb/image/Kconfig                   |    7 
 drivers/usb/image/hpusbscsi.c               |   12 
 drivers/usb/image/mdc800.c                  |   18 
 drivers/usb/image/microtek.c                |   17 
 drivers/usb/image/microtek.h                |    1 
 drivers/usb/input/aiptek.c                  |    8 
 drivers/usb/input/ati_remote.c              |    7 
 drivers/usb/input/hid-core.c                |  164 +-
 drivers/usb/input/kbtab.c                   |    8 
 drivers/usb/input/mtouchusb.c               |    4 
 drivers/usb/input/pid.c                     |    2 
 drivers/usb/input/powermate.c               |    2 
 drivers/usb/input/touchkitusb.c             |    4 
 drivers/usb/input/usbkbd.c                  |    4 
 drivers/usb/input/usbmouse.c                |    4 
 drivers/usb/input/wacom.c                   |    8 
 drivers/usb/input/xpad.c                    |    4 
 drivers/usb/media/Kconfig                   |    6 
 drivers/usb/media/dabusb.c                  |    6 
 drivers/usb/media/konicawc.c                |   20 
 drivers/usb/media/ov511.c                   |    4 
 drivers/usb/media/se401.c                   |    6 
 drivers/usb/media/sn9c102.h                 |   23 
 drivers/usb/media/sn9c102_core.c            |  154 +-
 drivers/usb/media/sn9c102_pas106b.c         |   14 
 drivers/usb/media/sn9c102_pas202bcb.c       |   21 
 drivers/usb/media/sn9c102_sensor.h          |   61 
 drivers/usb/media/sn9c102_tas5110c1b.c      |   49 
 drivers/usb/media/sn9c102_tas5130d1b.c      |   64 
 drivers/usb/media/stv680.c                  |    4 
 drivers/usb/media/usbvideo.c                |    4 
 drivers/usb/misc/Kconfig                    |   12 
 drivers/usb/misc/Makefile                   |    1 
 drivers/usb/misc/auerswald.c                |   28 
 drivers/usb/misc/legousbtower.c             |    8 
 drivers/usb/misc/speedtch.c                 |   65 
 drivers/usb/misc/tiglusb.c                  |    1 
 drivers/usb/misc/uss720.c                   |    4 
 drivers/usb/net/catc.c                      |   16 
 drivers/usb/net/kaweth.c                    |   28 
 drivers/usb/net/pegasus.c                   |   12 
 drivers/usb/net/rtl8150.c                   |   28 
 drivers/usb/net/usbnet.c                    |   38 
 drivers/usb/serial/Kconfig                  |   10 
 drivers/usb/serial/Makefile                 |    1 
 drivers/usb/serial/belkin_sa.c              |    8 
 drivers/usb/serial/cyberjack.c              |    6 
 drivers/usb/serial/digi_acceleport.c        |   32 
 drivers/usb/serial/empeg.c                  |   32 
 drivers/usb/serial/ftdi_sio.c               |   24 
 drivers/usb/serial/ftdi_sio.h               |   15 
 drivers/usb/serial/generic.c                |    4 
 drivers/usb/serial/io_edgeport.c            |   18 
 drivers/usb/serial/io_ti.c                  |   18 
 drivers/usb/serial/ipaq.c                   |   23 
 drivers/usb/serial/ipw.c                    |  496 ++++++
 drivers/usb/serial/ir-usb.c                 |    4 
 drivers/usb/serial/keyspan_pda.c            |   12 
 drivers/usb/serial/kl5kusb105.c             |   12 
 drivers/usb/serial/kobil_sct.c              |   14 
 drivers/usb/serial/mct_u232.c               |   12 
 drivers/usb/serial/omninet.c                |    4 
 drivers/usb/serial/pl2303.c                 |  432 +++++
 drivers/usb/serial/usb-serial.c             |  245 +--
 drivers/usb/serial/usb-serial.h             |    1 
 drivers/usb/serial/visor.c                  |    6 
 drivers/usb/serial/whiteheat.c              |   16 
 drivers/usb/storage/isd200.c                |   12 
 drivers/usb/storage/protocol.c              |   98 -
 drivers/usb/storage/scsiglue.c              |   31 
 drivers/usb/storage/transport.c             |   25 
 drivers/usb/storage/unusual_devs.h          |  136 -
 drivers/usb/storage/usb.c                   |   70 
 drivers/usb/storage/usb.h                   |    3 
 include/asm-i386/mach-summit/mach_mpparse.h |    3 
 include/linux/usb.h                         |   29 
 include/linux/usbdevice_fs.h                |   10 
 141 files changed, 8360 insertions(+), 4993 deletions(-)
-----

<ak:sensi.org>:
  o USB: USB CDC OBEX driver
  o USB: export inteface and configuration strings to sysfs

<catab:deuroconsult.ro>:
  o USB: cdc-acm-usb-use-uninit-mem-bug.patch

<hj.oertel:surfeu.de>:
  o USB: usb/serial RM vendor/product id for ftdi_sio

<petkov:uni-muenster.de>:
  o USB: remove calls to usb_unlink_urb() in net/kaweth.c
  o USB: remove calls to usb_unlink_urb() in net/pegasus.c
  o USB: remove calls to usb_unlink_urb in net/usbnet.c
  o USB: remove _some_ calls to usb_unlink_urb in misc/auerswald.c
  o USB: remove calls to usb_unlink_urb in misc/legousbtower.c
  o USB: remove calls to usb_unlink_urb in net/catc.c
  o USB: remove calls to usb_unlink_urb() in input/touchkitusb.c
  o USB: remove calls to usb_unlink_urb in input/powermate.c
  o USB: remove calls to usb_unlink_urb in image/mdc800.c (v2)
  o USB: remove calls to usb_unlink_urb() in input/pid.c
  o USB: remove calls to usb_unlink_urb in input/usbkbd.c
  o USB: usb_unlink_urb removal from input/aiptek.c
  o USB: remove calls to usb_unlink_urb in input/mtouchusb.c
  o USB: usb_unlink_urb removal from input/hid-core.c
  o USB: remove usb_unlink_urb() calls in input/kbtab.c
  o USB: remove calls to usb_unlink_urb in core/message.c
  o USB: remove calls to usb_unlink_urb in input/usbmouse.c
  o USB: remove calls to usb_unlink_urb in input/wacom.c
  o USB: usb_unlink_urb removal from input/ati_remote.c
  o USB: remove calls to usb_unlink_urb in input/xpad.c
  o USB: remove calls to usb_unlink_urb in media/konicawc.c
  o USB: remove call to usb_unlink_urb in media/ov511.c
  o USB: remove calls to usb_unlink_urb in media/se401.c
  o USB: remove calls to usb_unlink_urb in media/stv680.c
  o USB: remove call to usb_unlink_urb() in media/usbvideo.c
  o USB: remove calls to usb_unlink_urb() in image/hpusbscsi.c
  o USB: remove calls to usb_unlink_urb in class/usb-midi.c
  o USB: remove calls to usb_unlink_urb in class/cdc-acm.c
  o USB: remove calls to usb_unlink_urb in class/bluetty.c
  o USB: remove calls to usb_unlink_urb in class/audio.c
  o USB: fix up usblp usb_unlink_urb() warning

<util:deuroconsult.ro>:
  o USB Serial: Correct a use of out of range variable

<wouter-kernel:fort-knox.rave.org>:
  o USB: usb audio is for oss only

Al Borchers:
  o USB: close waits for drain in pl2303
  o USB: circular buffer for pl2303
  o USB: corrected digi_acceleport 2.6.9-rc1 fix for hang on disconnect

Alan Stern:
  o USB Storage: new unusual_devs entry
  o USB: Fix data toggle handling in the UHCI driver
  o USB: Use list_for_each_entry etc. in UHCI driver
  o USB: Activate new hubs and resumed hubs the same way
  o USB: Suspend update for dummy_hcd
  o USB: Support system suspend in File-Storage Gadget
  o USB: Allow device resets for hubs
  o USB: Descriptor listing bugfix for g_file_storage
  o USB: Add locking support for USB device resets
  o USB: Updated USB device locking
  o USB: Fix off-by-one error in the hub driver
  o USB: Improve UHCI suspend/resume
  o USB: Unusual_devs entry for Panasonic cameras
  o USB: New submission procedure for unusual_devs.h
  o USB: Add OTG support to g_file_storage
  o USB: Internal port numbers start at 0
  o USB: Centralize logical disconnects in the hub driver
  o USB: Nag message for usb_kill_urb
  o USB: Remove inappropriate unusual_devs.h entry
  o USB: Suspend/resume/wakeup support for UHCI root hub ports
  o USB: Make usbcore use usb_kill_urb()

Andrew Morton:
  o PCI: fix up usb quirk __init marks

Bjorn Helgaas:
  o HCD PCI probe: print actual, not ioremapped, address

Craig Hughes:
  o USB: host side fixes for pxa2xx/ethernet/rndis gadgets, like gumstix

David Brownell:
  o USB: OHCI autodetects "need" for init reset quirk
  o USB Gadget: debug files now Kconfigured
  o USB: OHCI support for PXA27x
  o USB Gadget: Ethernet/RNDIS gadget, minor updates
  o USB: net2280 updates
  o USB: ohci init refactor
  o USB: omap_udc supports 5910/1510 chips
  o USB: khubd looks at ports after probe
  o USB: ohci updates
  o USB: gadget_is_n9604
  o export usb_set_device_state(), use in ohci
  o USB: EHCI SMP fix
  o USB: OHCI init cleanups

David T. Hollis:
  o USB: Add Surecom USB Ethernet device ids to usbnet

David Woodhouse:
  o USB SpeedTouch / ATM: Make it work on 64-bit hosts
  o USB: SpeedTouch / ATM update
  o USB: Fix assertion logic in USB ATM core
  o USB: Reformat usb-atm code and rework SpeedTouch firmware loading
  o USB: Generic USB ATM/DSL core and completed SpeedTouch driver

Duncan Sands:
  o USB SpeedTouch cleanup
  o usb: extract sensible strings from buggy string descriptors
  o usb speedtch: convert to using usb_kill_urb
  o usb speedtch: no side-effects in BUG_ON

Eric Valette:
  o USB: rtl8150.c ethernet driver : usb_unlink_urb ->usb_kill_urb

Greg Kroah-Hartman:
  o USB: add serial ipw driver
  o USB: add bulk_in_size for usb-serial devices
  o USB: add endian markups to the ub driver
  o USB: fix incorrect usage of usb_kill_urb in rtl8150 driver
  o USB:  oops, revert drivers/usb/core/message.c change
  o USB: fix up some minor sparse warnings in the uhci driver
  o USB: fix up __iomem warnings in the ohci driver
  o USB: fix up __iomem warnings in the ehci driver
  o USB: fix hcd-pci's __iomem warnings
  o PCI: fix __iomem warnings in quirk code
  o USB: fix usb_unlink_urb() usage in generic usb-serial driver
  o USB: fix usb_unlink_urb() usage in keyspan_pda driver
  o USB: fix usb_unlink_urb() usage in ftdi_sio driver
  o USB: fix usb_unlink_urb() usage in io_ti driver
  o USB: fix usb_unlink_urb() usage in kobil_sct driver
  o USB: fix usb_unlink_urb() usage in kl5kusb105 driver
  o USB: fix usb_unlink_urb() usage in visor driver
  o USB: fix usb_unlink_urb() usage in omninet driver
  o USB: fix usb_unlink_urb() usage in mct_u232 driver
  o USB: fix usb_unlink_urb() usage in empeg driver
  o USB: fix usb_unlink_urb() usage in digi_acceleport driver
  o USB: fix usb_unlink_urb() usage in ipaq driver
  o USB: fix usb_unlink_urb() usage in ir-usb driver
  o USB: fix usb_unlink_urb() usage in io_edgeport driver
  o USB: fix usb_unlink_urb() usage in whiteheat driver
  o USB: fix usb_unlink_urb() usage in cyberjack driver
  o USB: fix usb_unlink_urb() usage in belkin_sa driver
  o USB: fix usb_unlink_urb() usage in usb-serial core
  o USB: fix usb_unlink_urb() usage in pl2303 driver
  o USB: make usb_unlink_urb() message only show up if CONFIG_DEBUG_KERNEL is enabled
  o USB: remove usbdevfs filesystem name, usbfs is the proper one to use

Herbert Xu:
  o USB: Fix hiddev devfs oops

Ian Abbott:
  o USB: Add B&B Electronics VID/PIDs to ftdi_sio

Jesse Barnes:
  o USB: handle usb host allocation failures gracefully

John Stultz:
  o USB: early usb handoff for 2.6

Kenji Kaneshige:
  o USB: add missing pci_disable_device for PCI-based USB HCD

Luca Risolia:
  o USB: SN9C10x driver updates
  o USB: SN9C10x driver update

Luiz Capitulino:
  o usb-serial: Add module version information
  o usb-serial: usb_serial_register() cleanup
  o usb-serial: return_serial() trivial cleanup
  o usb-serial: create_serial() return value trivial fix
  o usb-serial: Moves the search in device list out of usb_serial_probe()
  o USB: missing check in usb/serial/usb-serial.c
  o USB: remove ugly code from usb/serial/usb-serial.c

Matthew Dharm:
  o USB Storage: revert GetMaxLUN strictness
  o USB Storage: ignore bogus residue values
  o USB storage: delayed device scanning
  o USB Storage: change how INQUIRY is fixed up

Maximilian Attems:
  o list_for_each_entry: drivers-usb-class-audio.c
  o list_for_each_entry: drivers-usb-class-usb-midi.c
  o list_for_each_entry: drivers-usb-media-dabusb.c
  o list_for_each_entry: drivers-usb-host-hc_sl811.c
  o list_for_each_entry: drivers-usb-serial-ipaq.c
  o list_for_each_entry: drivers-usb-core-devices.c
  o usb/dabusb: insert set_current_state() before schedule_timeout()
  o usb/tiglusb: insert set_current_state() before schedule_timeout()

Nishanth Aravamudan:
  o usb/uss720: replace schedule_timeout() with msleep_interruptible()
  o usb/mdc800: cleanup set_current_state() around wait queues
  o usb/hid-core: add set_current_state() before schedule_timeout()
  o usb/kaweth: reorder set_current_state() and schedule_timeout()
  o usb/ati_remote: add set_current_state()
  o usb/file_storage: replace schedule_timeout() with msleep_interruptible()

Oliver Neukum:
  o USB: acm work around for misplaced
  o USB: maintainership of acm cdc
  o USB: switching microtek to usb_kill_urb
  o USB: correct interrupt interval for kaweth
  o USB: switching microtek to usb_kill_urb
  o USB: update of help text for hpusbscsi

Pavel Machek:
  o USB Storage: Unusual_dev patch for Finepix 1300 and 1400's

Pete Zaitcev:
  o USB: fix oops with latest ub driver in -mm tree
  o USB: Fixes for ub in 2.4.9-rc2-mm2
  o USB: Patch for 3 ub bugs in 2.6.9-rc1-mm4
  o USB: Fixes for ub in 2.4.9-rc1 from Oliver and Pat

Petko Manolov:
  o USB: small rtl8150 patch

Phil Dibowitz:
  o USB Storage: unusual_dev modification
  o USB Storage: Fix Kyocera order
  o USB Storage: Remove unusual_devs entries for Genesys Drives
  o USB Storage: Remove unusual_dev entry for IBM Storage Key

Steffen Zieger:
  o USB: Codemercs IO-Warrior support

Stephan Fuhrmann:
  o USB Storage: unusual_devs patch for new tekom entry

Stephan Walter:
  o USB Storage: unusual_devs patch for winward music disk

Vojtech Pavlik:
  o USB: Fix oops in usblp driver

