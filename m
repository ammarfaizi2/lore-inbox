Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSL1H4Q>; Sat, 28 Dec 2002 02:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSL1H4Q>; Sat, 28 Dec 2002 02:56:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34825 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265484AbSL1H4J>;
	Sat, 28 Dec 2002 02:56:09 -0500
Date: Fri, 27 Dec 2002 23:59:59 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.53
Message-ID: <20021228075959.GA14314@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a lot of little USB changes, mostly all of them are conversions
to using the driver core model better for usb and usb-serial devices.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/dma.txt                  |  104 +++++++++++++++
 Documentation/usb/usb-serial.txt           |   34 +++-
 drivers/bluetooth/hci_usb.c                |    6 
 drivers/input/joystick/iforce/iforce-usb.c |    6 
 drivers/isdn/hisax/st5481_b.c              |    2 
 drivers/isdn/hisax/st5481_d.c              |    2 
 drivers/isdn/hisax/st5481_init.c           |    6 
 drivers/isdn/hisax/st5481_usb.c            |    2 
 drivers/media/video/cpia_usb.c             |   10 -
 drivers/net/irda/irda-usb.c                |    6 
 drivers/usb/class/audio.c                  |    6 
 drivers/usb/class/bluetty.c                |    6 
 drivers/usb/class/cdc-acm.c                |    6 
 drivers/usb/class/usb-midi.c               |    6 
 drivers/usb/class/usblp.c                  |    8 -
 drivers/usb/core/buffer.c                  |  100 --------------
 drivers/usb/core/config.c                  |    1 
 drivers/usb/core/devio.c                   |    4 
 drivers/usb/core/hcd-pci.c                 |    3 
 drivers/usb/core/hcd.c                     |   20 +-
 drivers/usb/core/hcd.h                     |   37 -----
 drivers/usb/core/hub.c                     |   10 -
 drivers/usb/core/usb-debug.c               |    2 
 drivers/usb/core/usb.c                     |  200 ++++++++++++++---------------
 drivers/usb/host/ehci-hcd.c                |    9 -
 drivers/usb/host/hc_sl811_rh.c             |    2 
 drivers/usb/host/ohci-hcd.c                |    2 
 drivers/usb/host/ohci-sa1111.c             |    3 
 drivers/usb/host/uhci-hcd.c                |    2 
 drivers/usb/image/hpusbscsi.c              |    6 
 drivers/usb/image/mdc800.c                 |    6 
 drivers/usb/image/microtek.c               |    6 
 drivers/usb/image/scanner.c                |   24 ++-
 drivers/usb/input/aiptek.c                 |    6 
 drivers/usb/input/hid-core.c               |   10 +
 drivers/usb/input/hid-input.c              |    5 
 drivers/usb/input/hid.h                    |    1 
 drivers/usb/input/pid.c                    |    5 
 drivers/usb/input/powermate.c              |    6 
 drivers/usb/input/usbkbd.c                 |    6 
 drivers/usb/input/usbmouse.c               |    6 
 drivers/usb/input/wacom.c                  |    6 
 drivers/usb/input/xpad.c                   |    6 
 drivers/usb/media/dabusb.c                 |    6 
 drivers/usb/media/dsbr100.c                |    6 
 drivers/usb/media/ibmcam.c                 |    2 
 drivers/usb/media/konicawc.c               |    2 
 drivers/usb/media/ov511.c                  |    6 
 drivers/usb/media/pwc-if.c                 |    6 
 drivers/usb/media/se401.c                  |    6 
 drivers/usb/media/stv680.c                 |    6 
 drivers/usb/media/ultracam.c               |   35 -----
 drivers/usb/media/usbvideo.c               |    4 
 drivers/usb/media/vicam.c                  |    6 
 drivers/usb/misc/auerswald.c               |    6 
 drivers/usb/misc/brlvger.c                 |    6 
 drivers/usb/misc/rio500.c                  |    6 
 drivers/usb/misc/speedtouch.c              |    6 
 drivers/usb/misc/tiglusb.c                 |    6 
 drivers/usb/misc/usblcd.c                  |    6 
 drivers/usb/misc/usbtest.c                 |    9 -
 drivers/usb/misc/uss720.c                  |    6 
 drivers/usb/net/catc.c                     |    6 
 drivers/usb/net/cdc-ether.c                |    4 
 drivers/usb/net/kaweth.c                   |   11 -
 drivers/usb/net/pegasus.c                  |    6 
 drivers/usb/net/rtl8150.c                  |    6 
 drivers/usb/net/usbnet.c                   |   17 +-
 drivers/usb/serial/Kconfig                 |    4 
 drivers/usb/serial/belkin_sa.c             |   18 +-
 drivers/usb/serial/bus.c                   |   12 -
 drivers/usb/serial/cyberjack.c             |   22 +--
 drivers/usb/serial/digi_acceleport.c       |   75 +++++-----
 drivers/usb/serial/empeg.c                 |   12 -
 drivers/usb/serial/ezusb.c                 |    4 
 drivers/usb/serial/ftdi_sio.c              |   29 ++--
 drivers/usb/serial/generic.c               |    6 
 drivers/usb/serial/io_edgeport.c           |   90 ++++++-------
 drivers/usb/serial/io_ti.c                 |  108 +++++++--------
 drivers/usb/serial/ipaq.c                  |   56 ++++++--
 drivers/usb/serial/ipaq.h                  |   53 ++++++-
 drivers/usb/serial/ir-usb.c                |   20 +-
 drivers/usb/serial/keyspan.c               |  100 ++++++--------
 drivers/usb/serial/keyspan_pda.c           |   20 +-
 drivers/usb/serial/kl5kusb105.c            |   35 ++---
 drivers/usb/serial/kobil_sct.c             |   19 +-
 drivers/usb/serial/mct_u232.c              |   28 ++--
 drivers/usb/serial/omninet.c               |    6 
 drivers/usb/serial/pl2303.c                |   44 +++---
 drivers/usb/serial/usb-serial.c            |   48 +++---
 drivers/usb/serial/usb-serial.h            |   29 +++-
 drivers/usb/serial/visor.c                 |   67 ++++-----
 drivers/usb/serial/whiteheat.c             |   54 ++++---
 drivers/usb/storage/usb.c                  |    6 
 drivers/usb/usb-skeleton.c                 |    8 -
 include/linux/usb.h                        |   31 ++--
 sound/usb/usbaudio.c                       |    4 
 97 files changed, 990 insertions(+), 908 deletions(-)
-----

ChangeSet@1.974, 2002-12-27 23:51:49-08:00, greg@kroah.com
  [PATCH] USB: more dev_printk() cleanups.

 drivers/usb/core/usb-debug.c |    2 +-
 drivers/usb/core/usb.c       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.973, 2002-12-27 23:37:51-08:00, greg@kroah.com
  [PATCH] USB: fix kaweth driver which was accessing the struct usb_device refcnt variable directly.

 drivers/usb/net/kaweth.c |    5 -----
 1 files changed, 5 deletions(-)
------

ChangeSet@1.972, 2002-12-27 23:29:19-08:00, greg@kroah.com
  [PATCH] USB: use the driver model to handle reference counting of struct usb_device

 drivers/usb/core/config.c |    1 
 drivers/usb/core/usb.c    |   78 +++++++++++++++++++++++++++++-----------------
 include/linux/usb.h       |    1 
 3 files changed, 51 insertions(+), 29 deletions(-)
------

ChangeSet@1.971, 2002-12-27 19:29:40-08:00, greg@kroah.com
  [PATCH] USB: rename usb_free_dev() to usb_put_dev()
  
  This was done to make the next reference count patch easier,
  and because almost everyone was already calling usb_put_dev() anyway...

 drivers/usb/core/hub.c         |    4 ++--
 drivers/usb/core/usb.c         |    7 +++----
 drivers/usb/host/ehci-hcd.c    |    2 +-
 drivers/usb/host/hc_sl811_rh.c |    2 +-
 drivers/usb/host/ohci-hcd.c    |    2 +-
 drivers/usb/host/uhci-hcd.c    |    2 +-
 include/linux/usb.h            |    3 +--
 7 files changed, 10 insertions(+), 12 deletions(-)
------

ChangeSet@1.970, 2002-12-27 15:05:33-08:00, greg@kroah.com
  [PATCH] USB: fix up some bugs in the cpia driver

 drivers/media/video/cpia_usb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.969, 2002-12-27 15:05:14-08:00, greg@kroah.com
  [PATCH] USB drivers outside /drivers/usb: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/bluetooth/hci_usb.c                |    6 +++---
 drivers/input/joystick/iforce/iforce-usb.c |    6 +++---
 drivers/isdn/hisax/st5481_init.c           |    6 +++---
 drivers/media/video/cpia_usb.c             |    6 +++---
 drivers/net/irda/irda-usb.c                |    6 +++---
 sound/usb/usbaudio.c                       |    4 ++--
 6 files changed, 17 insertions(+), 17 deletions(-)
------

ChangeSet@1.968, 2002-12-27 15:04:53-08:00, greg@kroah.com
  [PATCH] USB storage driver: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/storage/usb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.967, 2002-12-27 15:04:35-08:00, greg@kroah.com
  [PATCH] USB net drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/net/catc.c      |    6 +++---
 drivers/usb/net/cdc-ether.c |    4 ++--
 drivers/usb/net/kaweth.c    |    6 +++---
 drivers/usb/net/pegasus.c   |    6 +++---
 drivers/usb/net/rtl8150.c   |    6 +++---
 drivers/usb/net/usbnet.c    |    6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)
------

ChangeSet@1.966, 2002-12-27 15:04:16-08:00, greg@kroah.com
  [PATCH] USB skeleton: missed a dev_get_drvdata usage

 drivers/usb/usb-skeleton.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.965, 2002-12-27 15:03:57-08:00, greg@kroah.com
  [PATCH] USB input drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/input/aiptek.c    |    6 +++---
 drivers/usb/input/hid-core.c  |    6 +++---
 drivers/usb/input/powermate.c |    6 +++---
 drivers/usb/input/usbkbd.c    |    6 +++---
 drivers/usb/input/usbmouse.c  |    6 +++---
 drivers/usb/input/wacom.c     |    6 +++---
 drivers/usb/input/xpad.c      |    6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)
------

ChangeSet@1.964, 2002-12-27 15:03:38-08:00, greg@kroah.com
  [PATCH] USB image drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/image/hpusbscsi.c |    6 +++---
 drivers/usb/image/mdc800.c    |    6 +++---
 drivers/usb/image/microtek.c  |    6 +++---
 drivers/usb/image/scanner.c   |    8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)
------

ChangeSet@1.963, 2002-12-27 15:03:18-08:00, greg@kroah.com
  [PATCH] USB class drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/class/audio.c    |    6 +++---
 drivers/usb/class/bluetty.c  |    6 +++---
 drivers/usb/class/cdc-acm.c  |    6 +++---
 drivers/usb/class/usb-midi.c |    6 +++---
 drivers/usb/class/usblp.c    |    8 ++++----
 5 files changed, 16 insertions(+), 16 deletions(-)
------

ChangeSet@1.962, 2002-12-27 15:02:58-08:00, greg@kroah.com
  [PATCH] USB skeleton driver: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/usb-skeleton.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.961, 2002-12-27 15:02:39-08:00, greg@kroah.com
  [PATCH] USB media drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/media/dabusb.c   |    6 +++---
 drivers/usb/media/dsbr100.c  |    6 +++---
 drivers/usb/media/ibmcam.c   |    2 +-
 drivers/usb/media/konicawc.c |    2 +-
 drivers/usb/media/ov511.c    |    6 +++---
 drivers/usb/media/pwc-if.c   |    6 +++---
 drivers/usb/media/se401.c    |    6 +++---
 drivers/usb/media/stv680.c   |    6 +++---
 drivers/usb/media/ultracam.c |    2 +-
 drivers/usb/media/usbvideo.c |    4 ++--
 drivers/usb/media/vicam.c    |    6 +++---
 11 files changed, 26 insertions(+), 26 deletions(-)
------

ChangeSet@1.960, 2002-12-27 15:02:19-08:00, greg@kroah.com
  [PATCH] USB core drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/core/devio.c |    4 ++--
 drivers/usb/core/hub.c   |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.959, 2002-12-27 15:01:53-08:00, greg@kroah.com
  [PATCH] USB serial drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/serial/usb-serial.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.958, 2002-12-27 15:01:29-08:00, greg@kroah.com
  [PATCH] USB misc drivers: remove direct calls to dev_set* and dev_get*
  
  change dev_set_drvdata() and dev_get_drvdata() to
  usb_set_intfdata() and usb_get_intfdata()

 drivers/usb/misc/auerswald.c  |    6 +++---
 drivers/usb/misc/brlvger.c    |    6 +++---
 drivers/usb/misc/rio500.c     |    6 +++---
 drivers/usb/misc/speedtouch.c |    6 +++---
 drivers/usb/misc/tiglusb.c    |    6 +++---
 drivers/usb/misc/usblcd.c     |    6 +++---
 drivers/usb/misc/usbtest.c    |    8 ++++----
 drivers/usb/misc/uss720.c     |    6 +++---
 8 files changed, 25 insertions(+), 25 deletions(-)
------

ChangeSet@1.946.3.22, 2002-12-27 11:52:10-08:00, greg@kroah.com
  USB: fix compiler warnings in the isdn usb drivers.

 drivers/isdn/hisax/st5481_b.c   |    2 +-
 drivers/isdn/hisax/st5481_d.c   |    2 +-
 drivers/isdn/hisax/st5481_usb.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.946.3.21, 2002-12-27 11:33:42-08:00, greg@kroah.com
  [PATCH] USB: remove private_data pointer from struct usb_interface, as it shouldn't be used anymore
  
  Also added usb_get_intfdata() and usb_set_intfdata() functions to set the
  struct usb_interface private pointer easier.

 drivers/usb/core/usb.c     |    4 ++--
 drivers/usb/misc/usbtest.c |    1 -
 include/linux/usb.h        |   11 ++++++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)
------

ChangeSet@1.946.3.20, 2002-12-27 10:38:45-08:00, pablo@menichini.com.ar
  [PATCH] Handle kmalloc fails: drivers/usb/input/pid.c
  
  This patch tries to check the return value of kmalloc taking the necesary
  action to solve the problem.

 drivers/usb/input/pid.c |    5 +++++
 1 files changed, 5 insertions(+)
------

ChangeSet@1.946.3.19, 2002-12-27 10:36:37-08:00, dmitri@users.sourceforge.net
  [PATCH] Extra parameters removed from the ultracam driver
  
  > > Ultracam was derived from ibmcam and probably copied the list of
  > > parameters too. IBM cameras have this parameter, and use it.
  >
  > This means that it says "MODULE_PARM(lighting, "i");" and there is no
  > variable called lightening.  The new module code is stricter about
  > this.  Someone please fix.
  
  Here is the patch for 2.5.53. It removes parameters that have no use
  in the ultracam driver (and they were broken anyway).

 drivers/usb/media/ultracam.c |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)
------

ChangeSet@1.946.3.17, 2002-12-26 18:24:58-08:00, greg@kroah.com
  [PATCH] USB: use usb_get_serial_data() and usb_set_serial_data() functions.

 drivers/usb/serial/digi_acceleport.c |   25 ++++++++++++-------------
 drivers/usb/serial/io_edgeport.c     |   18 +++++++++---------
 drivers/usb/serial/io_ti.c           |    8 ++++----
 drivers/usb/serial/keyspan.c         |   31 +++++++++++++++----------------
 drivers/usb/serial/visor.c           |   11 +++++------
 5 files changed, 45 insertions(+), 48 deletions(-)
------

ChangeSet@1.946.3.16, 2002-12-26 18:24:39-08:00, greg@kroah.com
  [PATCH] USB: add usb_get_serial_data() and usb_set_serial_data() functions.
  
  This is to access the private pointer in struct usb_serial

 drivers/usb/serial/usb-serial.h |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
------

ChangeSet@1.946.3.15, 2002-12-26 17:38:55-08:00, greg@kroah.com
  [PATCH] USB: fix up the usb-serial drivers due to the removal of the struct usb_serial_port private pointer.

 drivers/usb/serial/belkin_sa.c       |   18 ++++++-----
 drivers/usb/serial/cyberjack.c       |   22 ++++++-------
 drivers/usb/serial/digi_acceleport.c |   50 +++++++++++++++---------------
 drivers/usb/serial/ftdi_sio.c        |   29 ++++++++++-------
 drivers/usb/serial/io_edgeport.c     |   32 +++++++++----------
 drivers/usb/serial/io_ti.c           |   28 ++++++++---------
 drivers/usb/serial/ipaq.c            |   18 +++++------
 drivers/usb/serial/keyspan.c         |   57 ++++++++++++++++-------------------
 drivers/usb/serial/keyspan_pda.c     |   20 ++++++------
 drivers/usb/serial/kl5kusb105.c      |   35 +++++++++------------
 drivers/usb/serial/kobil_sct.c       |   19 +++++------
 drivers/usb/serial/mct_u232.c        |   28 ++++++++---------
 drivers/usb/serial/omninet.c         |    6 +--
 drivers/usb/serial/pl2303.c          |   24 +++++++-------
 drivers/usb/serial/whiteheat.c       |   54 +++++++++++++++++----------------
 15 files changed, 222 insertions(+), 218 deletions(-)
------

ChangeSet@1.946.3.14, 2002-12-26 17:38:28-08:00, greg@kroah.com
  [PATCH] USB: take out private pointer from struct usb_serial_port
  
  The struct device pointer should be used instead.

 drivers/usb/serial/usb-serial.h |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)
------

ChangeSet@1.946.3.13, 2002-12-26 13:59:10-08:00, greg@kroah.com
  [PATCH] USB: convert pl2303 driver to use dev_err() and dev_info() macros

 drivers/usb/serial/pl2303.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)
------

ChangeSet@1.946.3.12, 2002-12-26 13:58:47-08:00, greg@kroah.com
  [PATCH] USB: convert keyspan driver to use dev_err() and dev_info() macros

 drivers/usb/serial/keyspan.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.946.3.11, 2002-12-26 13:58:26-08:00, greg@kroah.com
  [PATCH] USB: convert ir-usb driver to use dev_err() and dev_info() macros

 drivers/usb/serial/ir-usb.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)
------

ChangeSet@1.946.3.10, 2002-12-26 13:58:03-08:00, greg@kroah.com
  [PATCH] USB: convert io_ti driver to use dev_err() and dev_info() macros

 drivers/usb/serial/io_ti.c |   72 +++++++++++++++++++++++----------------------
 1 files changed, 37 insertions(+), 35 deletions(-)
------

ChangeSet@1.946.3.9, 2002-12-26 13:57:41-08:00, greg@kroah.com
  [PATCH] USB: convert io_edgeport driver to use dev_err() and dev_info() macros

 drivers/usb/serial/io_edgeport.c |   40 ++++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 19 deletions(-)
------

ChangeSet@1.946.3.8, 2002-12-26 13:57:20-08:00, greg@kroah.com
  [PATCH] USB: convert empeg driver to use dev_err() and dev_info() macros

 drivers/usb/serial/empeg.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.946.3.7, 2002-12-26 12:17:51-08:00, greg@kroah.com
  [PATCH] USB: convert usbserial core to use dev_err() and dev_info() macros

 drivers/usb/serial/bus.c        |   12 ++++++------
 drivers/usb/serial/ezusb.c      |    4 ++--
 drivers/usb/serial/generic.c    |    6 +++---
 drivers/usb/serial/usb-serial.c |   34 +++++++++++++++++-----------------
 4 files changed, 28 insertions(+), 28 deletions(-)
------

ChangeSet@1.946.3.6, 2002-12-26 12:13:26-08:00, greg@kroah.com
  [PATCH] USB: convert visor driver to use dev_err() and dev_info() macros

 drivers/usb/serial/visor.c |   56 +++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 27 deletions(-)
------

ChangeSet@1.946.3.5, 2002-12-26 12:13:04-08:00, greg@kroah.com
  [PATCH] USB: make the usbserial driver have the same name for the tty, usb, and module subsystems.

 drivers/usb/serial/usb-serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.946.3.4, 2002-12-24 10:27:27-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] USB ipaq driver update
  
  The ActiveSync USB "protocol" seems to be the same for all WinCE
  devices seen so far. So it seems reasonable to pre-emptively support
  all devices which work with ActiveSync.

 Documentation/usb/usb-serial.txt |   34 ++++++++++++++++---------
 drivers/usb/serial/Kconfig       |    4 +-
 drivers/usb/serial/ipaq.c        |   38 +++++++++++++++++++++++++--
 drivers/usb/serial/ipaq.h        |   53 +++++++++++++++++++++++++++++++++++----
 4 files changed, 106 insertions(+), 23 deletions(-)
------

ChangeSet@1.946.3.3, 2002-12-23 11:21:56-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: fix compilation error with debugging enabled
  
  This patch removes a now unnecessary debug line taht broke compilation
  when debugging was enabled.

 drivers/usb/image/scanner.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.946.3.2, 2002-12-23 11:21:38-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: Accept scanners with more than one interface
  
  This patch allows the scanner driver to accept devices with more than
  one interface. That's needed by some multi-function periphals (e.g.
  scanner+printer).

 drivers/usb/image/scanner.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)
------

ChangeSet@1.946.3.1, 2002-12-23 11:20:30-08:00, vojtech@suse.cz
  [PATCH] USB Joypad quirk
  
  Orginally from Vojtech Pavlik (16th June 2002 via email), to fix my
  'broken' USB joypad, Fully tested in both 2.4.x and 2.5.52 (and
  2.5.52-bk).

 drivers/usb/input/hid-core.c  |    4 ++++
 drivers/usb/input/hid-input.c |    5 +++++
 drivers/usb/input/hid.h       |    1 +
 3 files changed, 10 insertions(+)
------

