Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWCTXBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWCTXBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWCTXBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:01:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:30924
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932164AbWCTXBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:01:21 -0500
Date: Mon, 20 Mar 2006 15:01:02 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes and patches for 2.6.16
Message-ID: <20060320230102.GA26427@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB changes for 2.6.16.  They consist of the following
changes:

	- new drivers added
	- semaphore to mutex changes
	- uhci driver rework (has had a lot of testing in -mm)
	- kzalloc conversion
	- gadget driver updates
	- lots of other driver updates for new devices and new features.
	- remove the obsolete OSS USB audio drivers (they don't work
	  very well, and for newer devices not at all.  ALSA has much
	  better USB device support.)

All of these changes have been in the -mm tree for a number of weeks, if
not months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 CREDITS                                            |    2 
 Documentation/usb/et61x251.txt                     |   10 
 Documentation/usb/sn9c102.txt                      |   11 
 Documentation/usb/zc0301.txt                       |  254 +
 MAINTAINERS                                        |    8 
 arch/mips/au1000/common/cputable.c                 |    2 
 arch/mips/au1000/common/platform.c                 |    4 
 drivers/block/ub.c                                 |  245 -
 drivers/net/irda/irda-usb.c                        |    5 
 drivers/usb/Kconfig                                |    9 
 drivers/usb/Makefile                               |    4 
 drivers/usb/class/Kconfig                          |   47 
 drivers/usb/class/Makefile                         |    2 
 drivers/usb/class/audio.c                          | 3869 ---------------------
 drivers/usb/class/audio.h                          |  110 
 drivers/usb/class/cdc-acm.c                        |   23 
 drivers/usb/class/usb-midi.c                       | 2153 -----------
 drivers/usb/class/usb-midi.h                       |  164 
 drivers/usb/class/usblp.c                          |   15 
 drivers/usb/core/devices.c                         |    7 
 drivers/usb/core/devio.c                           |   24 
 drivers/usb/core/hcd-pci.c                         |   11 
 drivers/usb/core/hcd.c                             |  153 
 drivers/usb/core/hcd.h                             |    4 
 drivers/usb/core/hub.c                             |   45 
 drivers/usb/core/message.c                         |   17 
 drivers/usb/core/notify.c                          |   15 
 drivers/usb/core/usb.c                             |    5 
 drivers/usb/gadget/Kconfig                         |   17 
 drivers/usb/gadget/Makefile                        |    1 
 drivers/usb/gadget/at91_udc.c                      | 1773 +++++++++
 drivers/usb/gadget/at91_udc.h                      |  181 
 drivers/usb/gadget/dummy_hcd.c                     |    3 
 drivers/usb/gadget/ether.c                         |   53 
 drivers/usb/gadget/file_storage.c                  |    4 
 drivers/usb/gadget/gadget_chips.h                  |   30 
 drivers/usb/gadget/goku_udc.c                      |    3 
 drivers/usb/gadget/inode.c                         |    6 
 drivers/usb/gadget/lh7a40x_udc.c                   |    3 
 drivers/usb/gadget/net2280.c                       |    3 
 drivers/usb/gadget/omap_udc.c                      |    6 
 drivers/usb/gadget/pxa2xx_udc.c                    |    3 
 drivers/usb/gadget/serial.c                        |    9 
 drivers/usb/gadget/zero.c                          |   15 
 drivers/usb/host/Kconfig                           |    2 
 drivers/usb/host/ehci-au1xxx.c                     |  297 +
 drivers/usb/host/ehci-fsl.c                        |  366 +
 drivers/usb/host/ehci-fsl.h                        |   37 
 drivers/usb/host/ehci-hcd.c                        |   13 
 drivers/usb/host/ehci-hub.c                        |    4 
 drivers/usb/host/ehci-mem.c                        |   11 
 drivers/usb/host/ehci-pci.c                        |   25 
 drivers/usb/host/ehci-q.c                          |   17 
 drivers/usb/host/ehci-sched.c                      |   20 
 drivers/usb/host/ehci.h                            |   18 
 drivers/usb/host/hc_crisv10.c                      |   12 
 drivers/usb/host/isp116x-hcd.c                     |    5 
 drivers/usb/host/ohci-at91.c                       |  306 +
 drivers/usb/host/ohci-au1xxx.c                     |  102 
 drivers/usb/host/ohci-hcd.c                        |   54 
 drivers/usb/host/ohci-hub.c                        |   12 
 drivers/usb/host/ohci-pci.c                        |   15 
 drivers/usb/host/sl811-hcd.c                       |    3 
 drivers/usb/host/uhci-debug.c                      |  356 -
 drivers/usb/host/uhci-hcd.c                        |  127 
 drivers/usb/host/uhci-hcd.h                        |  196 -
 drivers/usb/host/uhci-hub.c                        |   21 
 drivers/usb/host/uhci-q.c                          | 1294 +++----
 drivers/usb/image/mdc800.c                         |   67 
 drivers/usb/input/ati_remote.c                     |    2 
 drivers/usb/input/hid-core.c                       |  175 
 drivers/usb/input/hid-lgff.c                       |    6 
 drivers/usb/input/hid-tmff.c                       |    3 
 drivers/usb/input/hid.h                            |   10 
 drivers/usb/input/hiddev.c                         |    6 
 drivers/usb/media/Kconfig                          |   15 
 drivers/usb/media/Makefile                         |    7 
 drivers/usb/media/dabusb.c                         |   36 
 drivers/usb/media/dabusb.h                         |    2 
 drivers/usb/media/et61x251.h                       |   28 
 drivers/usb/media/et61x251_core.c                  |  321 -
 drivers/usb/media/et61x251_sensor.h                |    5 
 drivers/usb/media/et61x251_tas5130d1b.c            |   10 
 drivers/usb/media/ov511.c                          |   97 
 drivers/usb/media/ov511.h                          |   11 
 drivers/usb/media/pwc/pwc-ctrl.c                   |    1 
 drivers/usb/media/pwc/pwc-if.c                     |    9 
 drivers/usb/media/se401.c                          |   16 
 drivers/usb/media/se401.h                          |    3 
 drivers/usb/media/sn9c102.h                        |   28 
 drivers/usb/media/sn9c102_core.c                   |  326 -
 drivers/usb/media/sn9c102_ov7630.c                 |   33 
 drivers/usb/media/sn9c102_pas202bca.c              |  238 +
 drivers/usb/media/sn9c102_pas202bcb.c              |    2 
 drivers/usb/media/sn9c102_sensor.h                 |   15 
 drivers/usb/media/sn9c102_tas5110c1b.c             |   14 
 drivers/usb/media/sn9c102_tas5130d1b.c             |   12 
 drivers/usb/media/stv680.c                         |   20 
 drivers/usb/media/stv680.h                         |    2 
 drivers/usb/media/usbvideo.c                       |   31 
 drivers/usb/media/usbvideo.h                       |    5 
 drivers/usb/media/vicam.c                          |   22 
 drivers/usb/media/w9968cf.c                        |   88 
 drivers/usb/media/w9968cf.h                        |   14 
 drivers/usb/media/zc0301.h                         |  192 +
 drivers/usb/media/zc0301_core.c                    | 2055 +++++++++++
 drivers/usb/media/zc0301_pas202bcb.c               |  361 +
 drivers/usb/media/zc0301_sensor.h                  |  103 
 drivers/usb/misc/auerswald.c                       |    6 
 drivers/usb/misc/cytherm.c                         |    3 
 drivers/usb/misc/idmouse.c                         |   28 
 drivers/usb/misc/ldusb.c                           |   14 
 drivers/usb/misc/legousbtower.c                    |   11 
 drivers/usb/misc/phidgetkit.c                      |    9 
 drivers/usb/misc/phidgetservo.c                    |    3 
 drivers/usb/misc/sisusbvga/sisusb.c                |    5 
 drivers/usb/misc/sisusbvga/sisusb.h                |    8 
 drivers/usb/misc/usblcd.c                          |    3 
 drivers/usb/misc/usbled.c                          |    3 
 drivers/usb/misc/usbtest.c                         |    9 
 drivers/usb/mon/mon_main.c                         |   22 
 drivers/usb/mon/mon_text.c                         |   24 
 drivers/usb/mon/usb_mon.h                          |    2 
 drivers/usb/net/pegasus.c                          |    1 
 drivers/usb/net/pegasus.h                          |   26 
 drivers/usb/net/rtl8150.c                          |    4 
 drivers/usb/net/zd1201.c                           |    9 
 drivers/usb/serial/Kconfig                         |    7 
 drivers/usb/serial/Makefile                        |    1 
 drivers/usb/serial/cp2101.c                        |    7 
 drivers/usb/serial/cypress_m8.c                    |   73 
 drivers/usb/serial/cypress_m8.h                    |    5 
 drivers/usb/serial/ftdi_sio.c                      |    4 
 drivers/usb/serial/ftdi_sio.h                      |    7 
 drivers/usb/serial/garmin_gps.c                    |    3 
 drivers/usb/serial/io_edgeport.c                   |    3 
 drivers/usb/serial/io_ti.c                         |    6 
 drivers/usb/serial/ir-usb.c                        |    3 
 drivers/usb/serial/keyspan.c                       |    6 
 drivers/usb/serial/kobil_sct.c                     |   16 
 drivers/usb/serial/mct_u232.c                      |    3 
 drivers/usb/serial/navman.c                        |  157 
 drivers/usb/serial/omninet.c                       |   10 
 drivers/usb/serial/option.c                        |    3 
 drivers/usb/serial/pl2303.c                        |    8 
 drivers/usb/serial/pl2303.h                        |    4 
 drivers/usb/serial/ti_usb_3410_5052.c              |    3 
 drivers/usb/serial/usb-serial.c                    |    6 
 drivers/usb/serial/visor.c                         |    3 
 drivers/usb/storage/datafab.c                      |    3 
 drivers/usb/storage/isd200.c                       |   10 
 drivers/usb/storage/jumpshot.c                     |    3 
 drivers/usb/storage/scsiglue.c                     |    9 
 drivers/usb/storage/sddr55.c                       |    3 
 drivers/usb/storage/shuttle_usbat.c                |    3 
 drivers/usb/storage/unusual_devs.h                 |   32 
 drivers/usb/storage/usb.c                          |   25 
 drivers/usb/storage/usb.h                          |    5 
 include/asm-mips/mach-mips/cpu-feature-overrides.h |    4 
 include/linux/fsl_devices.h                        |   27 
 include/linux/usb.h                                |    2 
 include/linux/usb_gadget.h                         |    7 
 162 files changed, 8918 insertions(+), 8775 deletions(-)

---------------

A. Maitland Bottoms:
      USB: ftdi_sio: add Icom ID1 USB product and vendor ids

Adrian Bunk:
      USB: remove OBSOLETE_OSS_USB_DRIVER drivers
      USB: drivers/usb/core/message.c: make usb_get_string() static
      USB: vicam.c: fix a NULL pointer dereference

Alan Stern:
      usbhid: add error handling
      UHCI: use one QH per endpoint, not per URB
      UHCI: use dummy TDs
      UHCI: remove main list of URBs
      UHCI: improve debugging code
      UHCI: Don't log short transfers
      uhci-hcd: fix mistaken usage of list_prepare_entry
      USB core and HCDs: don't put_device while atomic
      usbcore: fix compile error with CONFIG_USB_SUSPEND=n
      USB: UHCI: Increase port-reset completion delay for HP controllers
      USB: usbcore: Don't assume a USB configuration includes any interfaces

Andrew Morton:
      USB: optimise devio.c usbdev_read fix

Andrew Victor:
      USB: add support for OCHI on AT91rm9200

Aras Vaichas:
      USB: ethernet gadget driver section fixups

Arjan van de Ven:
      USB: convert a bunch of USB semaphores to mutexes

Clemens Ladisch:
      USB: EHCI full speed ISO bugfixes

Craig Shelley:
      USB: cp2101: add new device IDs

David Brownell:
      USB: EHCI and NF2 quirk
      USB: EHCI unlink tweaks
      USB: add support for AT91 gadget
      USB: minor gadget/rndis tweak
      recognize three more usb peripheral controllers
      USB: usbcore sets up root hubs earlier
      USB: ohci uses driver model wakeup flags
      USB: remove usbcore-specific wakeup flags
      USB: gadget driver section fixups

Dick Streefland:
      USB: support for USB-to-serial cable from Speed Dragon Multimedia

Eric Sesterhenn:
      USB: kzalloc() conversion for rest of drivers/usb
      USB: kzalloc() conversion in drivers/usb/gadget

Eugene Teo:
      USB: Fix irda-usb use after use

Franck Bui-Huu:
      USB: Zero driver: Removed duplicated code

Greg Kroah-Hartman:
      USB: fix initdata issue in isp116x-hcd
      USB serial: add navman driver
      USB: omninet: fix up debugging comments

Horst Schirmeier:
      USB: usbcore: usb_set_configuration oops (NULL ptr dereference)
      USB: fix check_ctrlrecip to allow control transfers in state ADDRESS

Jordan Crouse:
      USB: EHCI for AU1200
      USB: OHCI for AU1200

Julian Bradfield:
      USB: PL2303 and TIOCMIWAIT

Kumar Gala:
      USB: EHCI and Freescale 83xx quirk
      USB: Fix masking bug initialization of Freescale EHCI controller

Lonnie Mendez:
      USB: cypress_m8: add support for the Nokia ca42-version 2 cable

Luca Risolia:
      USB: Add ZC0301 Video4Linux2 driver
      USB: ZC0301 driver updates
      USB: CREDITS: Add credits about the ZC0301 and ET61X[12]51 USB drivers
      USB: SN9C10x driver updates
      USB: ET61X[12]51 driver updates
      USB: ZC0301 driver updates
      USB: ZC0301 driver bugfix

Malte Doersam:
      USB: Pegasus: Linksys USBVPN1 support + cleanup

Matthew Martin:
      USB: Fix warning in drivers/usb/media/ov511.c

Oliver Neukum:
      USB: optimise devio.c::usbdev_read
      USB: mdc800.c to kzalloc
      USB: kzalloc for storage
      USB: kzalloc for hid
      USB: kzalloc in dabusb
      USB: kzalloc in w9968cf
      USB: kzalloc in usbvideo
      USB: kzalloc in cytherm
      USB: kzalloc in idmouse
      USB: kzalloc in ldusb
      USB: kzalloc in PhidgetInterfaceKit
      USB: kzalloc in PhidgetServo
      USB: kzalloc in usbled
      USB: kzalloc in sisusbvga

Pekka Enberg:
      USB: remove LINUX_VERSION_CODE macro usage

Pete Zaitcev:
      ub: use kzalloc
      USB: ub 01 remove first_open
      USB: ub 02 remove diag
      USB: ub 03 drop stall clearing
      USB: storage: another unusual_devs.h entry
      USB: storage: unusual_devs.h entry 0420:0001

Petko Manolov:
      USB: rtl8150 small fix

Phil Dibowitz:
      USB: storage: sandisk unusual_devices entry

Randy Vinson:
      USB: EHCI for Freescale 83xx

Rodolfo Quesada:
      USB: storage: new unusual_devs.h entry: Mitsumi 7in1 Card Reader

Wolfgang Rohdewald:
      USB: add support for Creativelabs Silvercrest USB keyboard

