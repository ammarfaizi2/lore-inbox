Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCIBGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCIBGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVCIBGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:06:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:43440 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261204AbVCIBFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:05:21 -0500
Date: Tue, 8 Mar 2005 17:05:12 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.11
Message-ID: <20050309010512.GA12828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a lot of USB patches for 2.6.11.  All of these patches have
been in the past few -mm releases.  Most notable is the change of two
USB api functions to accept milliseconds instead of jiffies.  All USB
drivers in the kernel tree that use these functions have been fixed up
properly.

There are also three new USB drivers included here.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 CREDITS                                           |   12 
 Documentation/usb/error-codes.txt                 |   28 
 Documentation/usb/sn9c102.txt                     |   13 
 MAINTAINERS                                       |   40 
 drivers/bluetooth/bfusb.c                         |    8 
 drivers/char/watchdog/pcwd_usb.c                  |    2 
 drivers/media/dvb/b2c2/b2c2-usb-core.c            |   10 
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    4 
 drivers/media/dvb/dibusb/dvb-dibusb-firmware.c    |    2 
 drivers/media/dvb/dibusb/dvb-dibusb.h             |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    4 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    8 
 drivers/media/video/cpia_usb.c                    |    4 
 drivers/net/irda/irda-usb.c                       |    2 
 drivers/net/irda/stir4200.c                       |    6 
 drivers/usb/Kconfig                               |    2 
 drivers/usb/Makefile                              |    2 
 drivers/usb/atm/speedtch.c                        |    8 
 drivers/usb/class/audio.c                         |   56 
 drivers/usb/class/cdc-acm.c                       |   86 
 drivers/usb/class/cdc-acm.h                       |   49 
 drivers/usb/class/usblp.c                         |    2 
 drivers/usb/core/config.c                         |    3 
 drivers/usb/core/devices.c                        |   25 
 drivers/usb/core/devio.c                          |  260 +
 drivers/usb/core/hcd-pci.c                        |  159 -
 drivers/usb/core/hcd.c                            |  310 +-
 drivers/usb/core/hcd.h                            |   74 
 drivers/usb/core/hub.c                            |  126 
 drivers/usb/core/hub.h                            |    1 
 drivers/usb/core/message.c                        |   79 
 drivers/usb/core/sysfs.c                          |   92 
 drivers/usb/core/usb.c                            |    5 
 drivers/usb/gadget/Kconfig                        |    8 
 drivers/usb/gadget/dummy_hcd.c                    |   81 
 drivers/usb/gadget/ether.c                        |  250 -
 drivers/usb/gadget/gadget_chips.h                 |    6 
 drivers/usb/gadget/net2280.c                      |   25 
 drivers/usb/gadget/omap_udc.c                     |   30 
 drivers/usb/gadget/pxa2xx_udc.c                   |    1 
 drivers/usb/gadget/rndis.c                        |    2 
 drivers/usb/gadget/serial.c                       |  157 -
 drivers/usb/gadget/zero.c                         |    2 
 drivers/usb/host/Kconfig                          |   40 
 drivers/usb/host/ehci-hcd.c                       |   53 
 drivers/usb/host/ehci-hub.c                       |    4 
 drivers/usb/host/ehci-q.c                         |    6 
 drivers/usb/host/ehci-sched.c                     |    8 
 drivers/usb/host/ehci.h                           |    8 
 drivers/usb/host/ohci-au1xxx.c                    |  136 
 drivers/usb/host/ohci-dbg.c                       |    4 
 drivers/usb/host/ohci-hcd.c                       |   47 
 drivers/usb/host/ohci-lh7a404.c                   |  138 
 drivers/usb/host/ohci-omap.c                      |  197 -
 drivers/usb/host/ohci-ppc-soc.c                   |  422 ++
 drivers/usb/host/ohci-pxa27x.c                    |  127 
 drivers/usb/host/ohci-q.c                         |    9 
 drivers/usb/host/ohci-sa1111.c                    |  130 
 drivers/usb/host/ohci.h                           |   48 
 drivers/usb/host/sl811-hcd.c                      |   73 
 drivers/usb/host/uhci-debug.c                     |    9 
 drivers/usb/host/uhci-hcd.c                       | 1501 ----------
 drivers/usb/host/uhci-q.c                         | 1488 ++++++++++
 drivers/usb/image/mdc800.c                        |   42 
 drivers/usb/input/aiptek.c                        |   23 
 drivers/usb/input/ati_remote.c                    |   38 
 drivers/usb/input/hid-core.c                      |   38 
 drivers/usb/input/mtouchusb.c                     |   22 
 drivers/usb/input/powermate.c                     |    2 
 drivers/usb/input/touchkitusb.c                   |   19 
 drivers/usb/input/usbkbd.c                        |   20 
 drivers/usb/input/usbmouse.c                      |   19 
 drivers/usb/input/wacom.c                         |  672 ++--
 drivers/usb/media/ibmcam.c                        |    4 
 drivers/usb/media/konicawc.c                      |    2 
 drivers/usb/media/ov511.c                         |    6 
 drivers/usb/media/se401.c                         |    6 
 drivers/usb/media/sn9c102.h                       |   12 
 drivers/usb/media/sn9c102_core.c                  |   52 
 drivers/usb/media/ultracam.c                      |    4 
 drivers/usb/media/vicam.c                         |    4 
 drivers/usb/media/w9968cf.h                       |    2 
 drivers/usb/misc/Kconfig                          |    2 
 drivers/usb/misc/Makefile                         |    2 
 drivers/usb/misc/auerswald.c                      |   21 
 drivers/usb/misc/cytherm.c                        |    2 
 drivers/usb/misc/idmouse.c                        |   16 
 drivers/usb/misc/legousbtower.c                   |    4 
 drivers/usb/misc/phidgetkit.c                     |   29 
 drivers/usb/misc/phidgetservo.c                   |    4 
 drivers/usb/misc/rio500.c                         |    8 
 drivers/usb/misc/sisusbvga/Kconfig                |   14 
 drivers/usb/misc/sisusbvga/Makefile               |    6 
 drivers/usb/misc/sisusbvga/sisusb.c               | 3150 +++++++++++++++++++++-
 drivers/usb/misc/sisusbvga/sisusb.h               |  284 +
 drivers/usb/misc/usblcd.c                         |    4 
 drivers/usb/misc/usbled.c                         |    2 
 drivers/usb/misc/usbtest.c                        |   10 
 drivers/usb/misc/uss720.c                         |   12 
 drivers/usb/mon/Kconfig                           |   22 
 drivers/usb/mon/Makefile                          |    7 
 drivers/usb/mon/mon_main.c                        |  377 ++
 drivers/usb/mon/mon_stat.c                        |   74 
 drivers/usb/mon/mon_text.c                        |  395 ++
 drivers/usb/mon/usb_mon.h                         |   51 
 drivers/usb/net/Kconfig                           |   21 
 drivers/usb/net/Makefile                          |    3 
 drivers/usb/net/catc.c                            |    2 
 drivers/usb/net/kaweth.c                          |   13 
 drivers/usb/net/pegasus.c                         |   61 
 drivers/usb/net/pegasus.h                         |    1 
 drivers/usb/net/rtl8150.c                         |    4 
 drivers/usb/net/usbnet.c                          |  589 +++-
 drivers/usb/net/zd1201.c                          | 1905 +++++++++++++
 drivers/usb/net/zd1201.h                          |  151 +
 drivers/usb/serial/belkin_sa.c                    |    2 
 drivers/usb/serial/cyberjack.c                    |    7 
 drivers/usb/serial/cypress_m8.c                   |    6 
 drivers/usb/serial/ezusb.c                        |    2 
 drivers/usb/serial/ftdi_sio.c                     |    5 
 drivers/usb/serial/ftdi_sio.h                     |    1 
 drivers/usb/serial/io_edgeport.c                  |   49 
 drivers/usb/serial/io_ti.c                        |    7 
 drivers/usb/serial/ipaq.c                         |    2 
 drivers/usb/serial/ipw.c                          |   18 
 drivers/usb/serial/ir-usb.c                       |    2 
 drivers/usb/serial/keyspan_pda.c                  |   14 
 drivers/usb/serial/kl5kusb105.c                   |    2 
 drivers/usb/serial/mct_u232.c                     |    2 
 drivers/usb/serial/ti_usb_3410_5052.c             |    6 
 drivers/usb/serial/visor.c                        |    4 
 drivers/usb/serial/whiteheat.c                    |    5 
 drivers/usb/storage/Kconfig                       |   24 
 drivers/usb/storage/Makefile                      |    2 
 drivers/usb/storage/protocol.c                    |   39 
 drivers/usb/storage/scsiglue.c                    |   31 
 drivers/usb/storage/shuttle_usbat.c               | 1272 +++++++-
 drivers/usb/storage/shuttle_usbat.h               |   86 
 drivers/usb/storage/transport.c                   |   34 
 drivers/usb/storage/transport.h                   |    6 
 drivers/usb/storage/unusual_devs.h                |   90 
 drivers/usb/storage/usb.c                         |   50 
 drivers/usb/storage/usb.h                         |    6 
 drivers/usb/usb-skeleton.c                        |    4 
 drivers/w1/dscore.c                               |   10 
 fs/compat_ioctl.c                                 |  458 ---
 include/linux/compat_ioctl.h                      |    6 
 include/linux/pci_ids.h                           |    8 
 include/linux/usb.h                               |   17 
 include/linux/usb_cdc.h                           |  162 +
 include/linux/usbdevice_fs.h                      |   23 
 sound/usb/usbmixer.c                              |    4 
 sound/usb/usx2y/usX2Yhwdep.c                      |    2 
 153 files changed, 12391 insertions(+), 4804 deletions(-)
-----


<050035w:acadiau.ca>:
  o USB: fix error in usb_skel.c

<brian:murphy.dk>:
  o USB: usbfs: remove debug message
  o USB: set timeout message to debug level: message.c
  o USB: usbfs fix for data loss in message.c

<hwelte:hmw-consulting.de>:
  o [PATCH 2.6] maintainers / documentation update cyberjack

<radford:golemgroup.com>:
  o USB ftdi_sio: an rs485 adaptor from 4n-galaxy.de

Alan Stern:
  o USB Storage: Unusual_devs entry for Nikon DSC D70
  o USB Documentation update: USB error codes
  o USB: Don't return IRQ_NONE for edge-triggered interrupts
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USB: Fix race in URB submission vs. endpoint-disable
  o USB: Clear endpoint toggles in usb_set_interface
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o USBcore: implement usb_add_hcd and usb_remove_hcd
  o usb-storage: Don't log expected signatures
  o USB: UHCI: Fix build errors when CONFIG_DEBUG_FS isn't set
  o USB: Revised fixups for root-hub message handler
  o USB UHCI: split code from uhci-hcd.c to new file uhci-q.c
  o USB: Initialize connected ports on newly-activated hubs
  o USB: Make use_both_schemes=y the default
  o USB: Retry more aggressively during device initialization

Alex Sanks:
  o USB: don't power down net2280 on suspend

Alexander Nyberg:
  o USB: Fix use after free in usb/core/devices.c

Bernard Blackham:
  o USB: fix types in usb suspend

Christopher Li:
  o USB: compat ioctl for submiting URB

Craig Nadler:
  o USB: ehci updates for TDI/ATG silicon

Daniel Drake:
  o usb-storage: More flexible signature checking mechanism
  o USB: Add USBAT-based CompactFlash storage support
  o USB: Add USBAT02 storage support
  o USB: shuttle_usbat cleanups and generalisations

David Brownell:
  o USB: fix ohci Kconfig entry
  o USB: usbnet uses NET_IP_ALIGN
  o USB: teach gadget drivers about s3c2410_udc
  o USB: ohci ppc driver (2/2):  ohci-ppc-soc.c
  o USB: ohci ppc driver (1/2):  big-endian tweaks
  o USB: cdc-acm uses <linux/usb_cdc.h>
  o USB: serial/acm gadget uses <linux/usb_cdc.h>
  o USB: Ethernet/RNDIS gadget driver uses <linux/usb_cdc.h>
  o USB: usbnet uses <linux/usb_cdc.h>
  o USB: usbnet, cleanups and suspend/resume calls
  o USB: pxa2xx_udc isn't for pxa27x
  o USB: omap_udc handles two more devel boards
  o USB: Ethernet/RNDIS build fix on PXA25x
  o USB: add <linux/usb_cdc.h>
  o USB: ohci-omap updates
  o USB: add 'distrust_firmware' option to ohci

David T. Hollis:
  o USB: Add ASIX AX88772 10/100 Ethernet support to usbnet

Eugeny S. Mints:
  o USB: pxa2xx_udc tweak

Greg Kroah-Hartman:
  o USB: fix up HZ change in zd1201 driver
  o USB: fix up compiler warnings when CONFIG_USB_DEBUG is not set
  o USB: fix memory leak in get_string if usb_string() call failed
  o USB: cache the iConfiguration string, if present
  o USB: make iInterface string cached
  o USB: remove string fetches from the usb-storage core, have them used the cached versions instead
  o USB: fix up the input drivers to use the built in strings, instead of re-reading them from the device
  o USB: cache the product, manufacturer, and serial number strings at device insertion
  o USB: revert wacom driver patch
  o USB: remove UB checks in the usb-storage driver
  o USB: give sisusb a valid minor number (133 - 140)
  o USB: fix sparse bitwise warnings in the sisusb.c driver

Jeroen Vreeken:
  o USB: add zd1201 wireless lan driver

Luca Risolia:
  o USB: SN9C10x driver bugfix
  o USB: SN9C10x driver bugfix

Matthew Dharm:
  o USB Storage: devices which don't process PREVENT-ALLOW MEDIUM REMOVAL
  o USB storage: make IGNORE_RESIDUE apply for reads (in addition to writes)
  o USB Storage: Remove fix_capacity routine

Nishanth Aravamudan:
  o usb/ftdi_sio: convert WDR_TIMEOUT to milliseconds
  o usb/usblp: convert USBLP_WRITE_TIMEOUT to milliseconds
  o dvb/ttusb_dec: change parameters of usb_{control,bulk}_msg() to msecs
  o dvb/dvb-ttusb-budget: change parameters of usb_{control,bulk}_msg() to msecs
  o dvb/dvb-dibusb: change parameters of usb_{control,bulk}_msg() to msecs
  o dvb/cinergyT2: change parameters of usb_{control,bulk}_msg() to msecs
  o video/cpia_usb: change parameters of usb_{control,bulk}_msg() to msecs
  o dvb/dvb-dibusb-firmware: change parameters of usb_{control,bulk}_msg() to msecs
  o dvb/b2c2-usb-core: change parameters of usb_{control,bulk}_msg() to msecs
  o sound/usX2Yhwdep: change parameters of usb_{control,bulk}_msg() to msecs
  o sound/usbmixer: change parameters of usb_{control,bulk}_msg() to msecs
  o w1/dscore: change parameters of usb_{control,bulk}_msg() to msecs
  o net/stir4200: change parameters of usb_{control,bulk}_msg() to msecs
  o net/irda-usb: change parameters of usb_{control,bulk}_msg() to msecs
  o char/pcwd_usb: change parameters of usb_{control,bulk}_msg() to msecs
  o bluetooth/bfusb: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/usb-skeleton: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/whiteheat: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/rio500: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/visor: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ti_usb_3410_5052: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/mct_u232: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/kl5kusb105: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/keyspan_pda: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ir-usb: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ipw: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ipaq: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/io_ti: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ezusb: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/belkin_sa: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/usbnet: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/rtl8150: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/catc: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/uss720: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/usbled: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/phidgetservo: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/phidgetkit: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/legousbtower: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/idmouse: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/w9968cf: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/auerswald: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/vicam: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ultracam: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/sn9c102: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/se401: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ov511: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/konicawc: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/ibmcam: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/wacom: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/mtouchusb: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/aipteke: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/powermate: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/usbtest: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/cytherm: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/hid-core: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/hub: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/devio: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/usblp: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/cdc-acm: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/audio: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/speedtch: change parameters of usb_{control,bulk}_msg() to msecs
  o usb/message: move msecs change into usb_start_wait_urb()
  o usb/message: change parameters of usb_control_msg() to msecs
  o include/usb: change USB_CTRL_{SET,GET}_TIMEOUT to msecs
  o usb/message: make usb_{control,bulk}_msg() use msecs
  o usb/mdc800: replace wake_up() with wake_up_interruptible()
  o usb/io_edgeport: remove interruptible_sleep_on_timeout() usage
  o usb/kaweth: use wait_event_timeout()
  o usb/hid-core: use wait_event_timeout()
  o usb/ati_remote: use wait_event_timeout()
  o usb/auerswald: use wait_event_timeout()
  o usb/mdc800: use wait_event_timeout()
  o usb/io_edgeport: replace interruptible_sleep_on_timeout() with wait_event_timeout()
  o usb/cypress_m8: replace schedule_timeout() with msleep()

Pete Zaitcev:
  o USB: add usbmon, a USB monitoring framework

Petko Manolov:
  o USB: pegasus and rtl8150 cset for proper link detection

Phil Dibowitz:
  o [PATCH] Add US_FL_GO_SLOW flag,
  o USB: unusual_devs.h update

Ping Cheng:
  o USB: wacom tablet driver

Sean Young:
  o USB: PhidgetKit driver update

Thomas Brinker:
  o USB: ethernet gadget driver aligns IP headers

Thomas Winischhofer:
  o USB: SiS USB2VGA minor fix
  o USB: add SiS USB2VGA kernel driver

