Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVAHGoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVAHGoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAHGmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:42:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:27014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261936AbVAHFsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:51 -0500
Date: Fri, 7 Jan 2005 21:46:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB and Driver Core patches for 2.6.10
Message-ID: <20050108054626.GB8065@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a bunch of USB and Driver core patches for 2.6.10 (I had to
merge the trees due to some merge conflicts that came up between them.)

Highlights include:
	- delete the tiglusb driver (works just fine from userspace, and
	  the author asked for it to be done.)
	- 2 new usb-serial drivers
	- AOE drivers added to the tree
	- debugfs added.
	- usb host controller driver churn (hopefully this is now
	  settled down...)
	- some new sysfs attributes for pci devices on platforms that
	  support them
	- all usb config fields are now in native (le16) byte order, and
	  all in-tree USB drivers have been fixed up to properly handle
	  this.
	- lots of bug fixes and other assorted goodness.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel and linux-kernel as a
follow-up thread for those who want to see them.

thanks,

greg k-h


 drivers/usb/misc/tiglusb.c                        |  592 ------
 drivers/usb/misc/tiglusb.h                        |   43 
 Documentation/Changes                             |   20 
 Documentation/DocBook/kernel-api.tmpl             |    9 
 Documentation/aoe/aoe.txt                         |   75 
 Documentation/aoe/autoload.sh                     |   17 
 Documentation/aoe/mkdevs.sh                       |   33 
 Documentation/aoe/mkshelf.sh                      |   23 
 Documentation/aoe/status.sh                       |   15 
 Documentation/feature-removal-schedule.txt        |   26 
 Documentation/filesystems/sysfs-pci.txt           |   90 +
 Documentation/stable_api_nonsense.txt             |    4 
 Documentation/usb/sn9c102.txt                     |  202 +-
 MAINTAINERS                                       |   18 
 arch/ia64/Kconfig                                 |   26 
 arch/mips/au1000/common/usbdev.c                  |    6 
 arch/ppc64/Kconfig                                |    6 
 arch/s390/Kconfig                                 |    6 
 drivers/Makefile                                  |    2 
 drivers/base/Kconfig                              |    2 
 drivers/base/bus.c                                |    2 
 drivers/base/class.c                              |   18 
 drivers/base/platform.c                           |   52 
 drivers/block/Kconfig                             |    8 
 drivers/block/aoe/Makefile                        |    6 
 drivers/block/aoe/aoe.h                           |  166 +
 drivers/block/aoe/aoeblk.c                        |  255 ++-
 drivers/block/aoe/aoechr.c                        |  323 +++
 drivers/block/aoe/aoecmd.c                        |  627 +++++++
 drivers/block/aoe/aoedev.c                        |  194 ++
 drivers/block/aoe/aoemain.c                       |   93 +
 drivers/block/aoe/aoenet.c                        |  185 ++
 drivers/bluetooth/bfusb.c                         |    2 
 drivers/bluetooth/hci_usb.c                       |   10 
 drivers/char/misc.c                               |   14 
 drivers/char/watchdog/pcwd_usb.c                  |    8 
 drivers/isdn/hisax/hfc_usb.c                      |   15 
 drivers/isdn/hisax/st5481_b.c                     |    2 
 drivers/isdn/hisax/st5481_d.c                     |    2 
 drivers/isdn/hisax/st5481_init.c                  |    3 
 drivers/isdn/hisax/st5481_usb.c                   |    4 
 drivers/media/dvb/b2c2/b2c2-usb-core.c            |    2 
 drivers/media/dvb/dibusb/dvb-dibusb.c             |   12 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    6 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    8 
 drivers/net/irda/irda-usb.c                       |    6 
 drivers/net/irda/stir4200.c                       |    4 
 drivers/net/pcmcia/Kconfig                        |    2 
 drivers/net/tokenring/Kconfig                     |    2 
 drivers/net/wireless/Kconfig                      |    2 
 drivers/parport/Kconfig                           |    2 
 drivers/pci/hotplug/Kconfig                       |    2 
 drivers/pci/hotplug/pciehp_core.c                 |    1 
 drivers/pci/hotplug/shpchp_core.c                 |    1 
 drivers/pci/pci-sysfs.c                           |  163 +
 drivers/pci/probe.c                               |   83 
 drivers/pcmcia/Kconfig                            |    2 
 drivers/usb/Makefile                              |    4 
 drivers/usb/README                                |   33 
 drivers/usb/atm/speedtch.c                        |   31 
 drivers/usb/atm/usb_atm.c                         |   34 
 drivers/usb/atm/usb_atm.h                         |   19 
 drivers/usb/class/audio.c                         |    7 
 drivers/usb/class/bluetty.c                       |    6 
 drivers/usb/class/cdc-acm.c                       |   21 
 drivers/usb/class/cdc-acm.h                       |    3 
 drivers/usb/class/usb-midi.c                      |   30 
 drivers/usb/class/usb-midi.h                      |    4 
 drivers/usb/class/usblp.c                         |   19 
 drivers/usb/core/config.c                         |    4 
 drivers/usb/core/devices.c                        |   14 
 drivers/usb/core/devio.c                          |   65 
 drivers/usb/core/hcd-pci.c                        |   23 
 drivers/usb/core/hcd.c                            |  234 +-
 drivers/usb/core/hcd.h                            |   47 
 drivers/usb/core/hub.c                            |  706 ++++----
 drivers/usb/core/hub.h                            |    2 
 drivers/usb/core/inode.c                          |    4 
 drivers/usb/core/message.c                        |   54 
 drivers/usb/core/otg_whitelist.h                  |   16 
 drivers/usb/core/sysfs.c                          |   26 
 drivers/usb/core/urb.c                            |    2 
 drivers/usb/core/usb.c                            |   84 
 drivers/usb/core/usb.h                            |    2 
 drivers/usb/gadget/Kconfig                        |   35 
 drivers/usb/gadget/dummy_hcd.c                    |  134 -
 drivers/usb/gadget/epautoconf.c                   |    3 
 drivers/usb/gadget/file_storage.c                 |    2 
 drivers/usb/gadget/omap_udc.c                     |    2 
 drivers/usb/gadget/serial.c                       |    2 
 drivers/usb/host/ehci-dbg.c                       |   30 
 drivers/usb/host/ehci-hcd.c                       |  130 -
 drivers/usb/host/ehci-hub.c                       |   26 
 drivers/usb/host/ehci-mem.c                       |   31 
 drivers/usb/host/ehci-q.c                         |   68 
 drivers/usb/host/ehci-sched.c                     |  424 ++--
 drivers/usb/host/ehci.h                           |   50 
 drivers/usb/host/hc_crisv10.c                     |   34 
 drivers/usb/host/ohci-dbg.c                       |   22 
 drivers/usb/host/ohci-hcd.c                       |   73 
 drivers/usb/host/ohci-hub.c                       |   29 
 drivers/usb/host/ohci-lh7a404.c                   |   45 
 drivers/usb/host/ohci-mem.c                       |   25 
 drivers/usb/host/ohci-omap.c                      |   61 
 drivers/usb/host/ohci-pci.c                       |    8 
 drivers/usb/host/ohci-pxa27x.c                    |   43 
 drivers/usb/host/ohci-q.c                         |   82 
 drivers/usb/host/ohci-sa1111.c                    |   30 
 drivers/usb/host/ohci.h                           |   25 
 drivers/usb/host/sl811-hcd.c                      |  347 +---
 drivers/usb/host/sl811.h                          |   18 
 drivers/usb/host/uhci-debug.c                     |   36 
 drivers/usb/host/uhci-hcd.c                       |  182 --
 drivers/usb/host/uhci-hcd.h                       |   28 
 drivers/usb/image/mdc800.c                        |   45 
 drivers/usb/image/microtek.c                      |    4 
 drivers/usb/input/aiptek.c                        |    6 
 drivers/usb/input/ati_remote.c                    |   19 
 drivers/usb/input/hid-core.c                      |   16 
 drivers/usb/input/hid-ff.c                        |    4 
 drivers/usb/input/hid-input.c                     |  469 ++---
 drivers/usb/input/hid-lgff.c                      |    4 
 drivers/usb/input/hiddev.c                        |    6 
 drivers/usb/input/kbtab.c                         |    6 
 drivers/usb/input/mtouchusb.c                     |    6 
 drivers/usb/input/powermate.c                     |   13 
 drivers/usb/input/touchkitusb.c                   |    6 
 drivers/usb/input/usbkbd.c                        |    6 
 drivers/usb/input/usbmouse.c                      |    6 
 drivers/usb/input/wacom.c                         |    6 
 drivers/usb/input/xpad.c                          |   10 
 drivers/usb/media/Makefile                        |    2 
 drivers/usb/media/dabusb.c                        |    9 
 drivers/usb/media/ibmcam.c                        |   25 
 drivers/usb/media/konicawc.c                      |   18 
 drivers/usb/media/ov511.c                         |   20 
 drivers/usb/media/se401.c                         |   22 
 drivers/usb/media/sn9c102.h                       |   13 
 drivers/usb/media/sn9c102_core.c                  |  119 -
 drivers/usb/media/sn9c102_hv7131d.c               |  271 +++
 drivers/usb/media/sn9c102_mi0343.c                |  363 ++++
 drivers/usb/media/sn9c102_pas106b.c               |   45 
 drivers/usb/media/sn9c102_pas202bcb.c             |   49 
 drivers/usb/media/sn9c102_sensor.h                |   62 
 drivers/usb/media/sn9c102_tas5110c1b.c            |   28 
 drivers/usb/media/sn9c102_tas5130d1b.c            |   26 
 drivers/usb/media/stv680.c                        |    3 
 drivers/usb/media/ultracam.c                      |   16 
 drivers/usb/media/vicam.c                         |    6 
 drivers/usb/media/w9968cf.c                       |    8 
 drivers/usb/misc/Kconfig                          |   20 
 drivers/usb/misc/Makefile                         |    1 
 drivers/usb/misc/auerswald.c                      |   21 
 drivers/usb/misc/emi26.c                          |    8 
 drivers/usb/misc/emi62.c                          |    6 
 drivers/usb/misc/legousbtower.c                   |   11 
 drivers/usb/misc/usblcd.c                         |   15 
 drivers/usb/misc/usbtest.c                        |   25 
 drivers/usb/misc/uss720.c                         |    3 
 drivers/usb/net/catc.c                            |    5 
 drivers/usb/net/kaweth.c                          |    9 
 drivers/usb/serial/Kconfig                        |   23 
 drivers/usb/serial/Makefile                       |    2 
 drivers/usb/serial/belkin_sa.c                    |    4 
 drivers/usb/serial/ftdi_sio.c                     |  135 +
 drivers/usb/serial/ftdi_sio.h                     |   51 
 drivers/usb/serial/garmin_gps.c                   | 1553 ++++++++++++++++++
 drivers/usb/serial/io_edgeport.c                  |    4 
 drivers/usb/serial/io_ti.c                        |    4 
 drivers/usb/serial/keyspan.c                      |   24 
 drivers/usb/serial/keyspan_pda.c                  |    6 
 drivers/usb/serial/kobil_sct.c                    |    2 
 drivers/usb/serial/mct_u232.c                     |  157 -
 drivers/usb/serial/ti_fw_3410.h                   |  885 ++++++++++
 drivers/usb/serial/ti_fw_5052.h                   |  885 ++++++++++
 drivers/usb/serial/ti_usb_3410_5052.c             | 1866 +++++++++++++++++++++-
 drivers/usb/serial/ti_usb_3410_5052.h             |  224 ++
 drivers/usb/serial/usb-serial.c                   |   29 
 drivers/usb/serial/usb-serial.h                   |    4 
 drivers/usb/serial/visor.c                        |    8 
 drivers/usb/serial/visor.h                        |    6 
 drivers/usb/storage/scsiglue.c                    |    2 
 drivers/usb/storage/transport.c                   |   16 
 drivers/usb/storage/unusual_devs.h                |  122 -
 drivers/usb/storage/usb.c                         |   20 
 drivers/usb/storage/usb.h                         |    1 
 drivers/usb/usb-skeleton.c                        |    2 
 drivers/w1/dscore.c                               |    2 
 fs/Makefile                                       |    2 
 fs/debugfs/Makefile                               |    4 
 fs/debugfs/file.c                                 |  262 +++
 fs/debugfs/inode.c                                |  330 +++
 fs/sysfs/bin.c                                    |   27 
 fs/sysfs/dir.c                                    |    2 
 fs/sysfs/mount.c                                  |   34 
 fs/sysfs/sysfs.h                                  |    3 
 include/linux/debugfs.h                           |   92 +
 include/linux/device.h                            |    7 
 include/linux/if_ether.h                          |    3 
 include/linux/kobject.h                           |    2 
 include/linux/miscdevice.h                        |    7 
 include/linux/module.h                            |   19 
 include/linux/pci.h                               |    3 
 include/linux/sysfs.h                             |    6 
 include/linux/usb.h                               |   96 -
 include/linux/usb_ch9.h                           |   27 
 init/Kconfig                                      |   34 
 kernel/ksysfs.c                                   |    3 
 kernel/module.c                                   |  224 +-
 kernel/params.c                                   |  384 +---
 lib/Kconfig.debug                                 |   10 
 scripts/ver_linux                                 |    2 
 sound/usb/usbaudio.c                              |  124 -
 sound/usb/usbmidi.c                               |   16 
 sound/usb/usbmixer.c                              |   12 
 sound/usb/usx2y/usX2Yhwdep.c                      |    8 
 sound/usb/usx2y/usbusx2y.c                        |   22 
 sound/usb/usx2y/usbusx2yaudio.c                   |   24 
 218 files changed, 12619 insertions(+), 4089 deletions(-)
-----

<eolson:mit.edu>:
  o ftdi_sio: Add sysfs attributes for event character and latency
  o usb-serial: add tty_hangup on disconnect

<jlamanna:gmail.com>:
  o USB: ov511.c - vfree() checking cleanups

Adrian Bunk:
  o select HOTPLUG

Al Borchers:
  o USB: serial driver for TI USB 3410/5052 chips (2/3)
  o USB: serial driver for TI USB 3410/5052 chips (1/3)
  o USB: serial driver for TI USB 3410/5052 chips (3/3)

Alan Stern:
  o USB: Another hub driver cleanup [13/13]
  o USB: Hub driver cleanups [12/13]
  o USB: Hub driver: several bug fixes and simplifications [11/13]
  o USB: Create usb_hcd structures within usbcore [6/13]
  o USB: Create usb_hcd structures within usbcore [5/13]
  o USB: Create usb_hcd structures within usbcore [4/13]
  o USB: Create usb_hcd structures within usbcore [3/13]
  o USB: Create usb_hcd structures within usbcore [2/13]
  o USB: Create usb_hcd structures within usbcore [1/13]
  o USB: dummy_hcd: update to match the new endpoint changes

Andrew Morton:
  o debugfs-typo-fix

Chris Wright:
  o sysfs: Allocate sysfs_dirent structures from their own slab

Dave Jones:
  o driver core: Fix up vesafb failure probing

David Brownell:
  o USB: ehci "hc died" on startup (chip bug workaround)
  o USB: ohci diagnostic tweak
  o USB: usb makefile tweaks
  o USB: definitions for USB2 debug device, debug port
  o USB: minor usb doc/comment fixes
  o Driver Core: handle bridged platform bus segments
  o USB: fix serial gadget oops during enumeration
  o USB: fix Scheduling while atomic warning when resuming
  o USB: ohci build tweaks
  o USB: Hub driver: improve error checking and retries [10/13]
  o USB: gadget kconfig doc updates
  o USB: EHCI periodic schedule tree
  o USB: EHCI "park" mode disabled
  o USB: HCDs and per-device state (16/15)
  o USB: better messages for "no-IRQ" cases (15/15)
  o USB: UHCI and HCD API change (14/15)
  o USB: OHCI and HCD API changes (13/15)
  o USB: EHCI and HCD API updates (12/15)
  o USB: maintain usb_host_endpoint.urb_list (11/15)
  o USB: remove some now-unused HCD infrastructure (10/15)
  o USB: HCD/usb_bus interface cleanup (9/15)
  o USB: usbtest and usb_dev->epmaxpacket (8/15)
  o USB: EHCI HCD and usb_dev->epmaxpacket (7/15)
  o USB: CRIS HCD and usb_dev->epmaxpacket (6/15)
  o USB: auerswald and usb_dev->ep[] (5/15)
  o USB: ALSA and usb_dev->ep[] (4/15)
  o USB: usbfs changes for usb_dev->ep[] (3/15)
  o USB: usbcore changes for usb_dev->ep[](2/15)
  o USB: usb_dev->ep[] not usb_dev->epmaxpacket (1/15)
  o USB: update drivers/usb/README

Duncan Sands:
  o usb atm: macro consolidation, fixes debugging problem

Ed L. Cashin:
  o rename ETH_P_AOE
  o add ATA over Ethernet driver

Greg Kroah-Hartman:
  o add feature-removal-schedule.txt documentation
  o Fix up udev url in Documentation/Changes file
  o debugfs: add /sys/kernel/debug mount point for people to mount debugfs on
  o sysfs: export the /sys/kernel subsystem for people to use
  o USB: explicitly mark the endianness of some visor data fields
  o USB Gadget: fix up simple sparse warnings (NULL stuff) in dummy_hcd.c driver
  o USB: change wMaxPacketSize field in struct usb_config_descriptor to be __le16
  o USB: change wTotalLength field in struct usb_config_descriptor to be __le16
  o USB: convert the idVendor, idProduct, bcdDevice and bcdUSB fields to __le16
  o USB: change warning level in ftdi_sio driver of a debug message
  o USB: fix up some sparse warnings in the new garmin_gps driver
  o AOE: fix up sparse warnings and get rid of a kmalloc in the aoe driver
  o USB: convert uhci-hcd driver to use debugfs
  o debugfs: add debugfs
  o USB: delete the tiglusb driver as it's not needed
  o USB: fix sparse and compiler warnings in ti_usb_3410_5052.c
  o misc: remove miscdevice.h from pci hotplug drivers as they do not need it
  o Documentation: fix some grammer in the stable_api_nonsense.txt file
  o misc: remove device.h #include from miscdevice.h

Hermann Kneissel:
  o Re: garmin gps driver patch 0.23

Jesper Juhl:
  o add printing of udev version to scripts/ver_linux

Jesse Barnes:
  o fix oops when reading resourceN files in sysfs
  o PCI: add legacy resources to sysfs for pci busses
  o driver core: allow struct bin_attributes in class devices
  o PCI: export PCI resources in sysfs
  o sysfs: add mmap support to struct bin_attribute files

Kumar Gala:
  o Driver Core: Add platform_get_resource_byname & platform_get_resource_byirq

Luca Risolia:
  o USB: SN9C10x driver updates

Matthew Dharm:
  o USB Storage: Increase Genesys delay
  o USB Storage: support 'bulk32' devices

Oliver Neukum:
  o USB: another workaround for cdc-acm
  o USB: additional device id for kaweth driver

Pete Zaitcev:
  o Clean mct_u232 in 2.6.10-rc2

Phil Dibowitz:
  o USB Storage: unusual_devs: prolific atapi controler
  o USB Storage: unusual_devs: prolific atapi controler
  o USB Storage: Remove old XLATE-only entries from unusual_devs.h
  o USB Storage: Remove MODE_XLATE flag from unusual_devs.h

Randy Dunlap:
  o add cpufreq info to Documentation/feature-removal-schedule.txt

Robert Love:
  o add class_device to miscdevice

Tejun Heo:
  o module sysfs: module parameters reimplemented using attr group
  o module sysfs: sections attr reimplemented using attr group
  o module sysfs: expand module_attribute methods
  o module sysfs: make module.mkobj inline

