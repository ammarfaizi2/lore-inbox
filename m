Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264741AbSJ3RpV>; Wed, 30 Oct 2002 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbSJ3RpU>; Wed, 30 Oct 2002 12:45:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:59151 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264741AbSJ3RpP>;
	Wed, 30 Oct 2002 12:45:15 -0500
Date: Wed, 30 Oct 2002 09:48:49 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.44
Message-ID: <20021030174848.GB1628@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some more changesets that touch the usb.h file, removing some old
macros, cleaning up some old #defines, and fixing up the structures to
help out the USB gadget people.  Because of this, almost all USB drivers
had to be fixed up.  I've tried to fix up the whole tree, but some
things might have slipped through again.  Please let me know if anyone
has any compilation problems.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/DocBook/writing_usb_driver.tmpl |    2 
 Documentation/usb/URB.txt                     |    4 
 drivers/bluetooth/hci_usb.c                   |   58 +++++------
 drivers/isdn/hisax/st5481_b.c                 |    8 -
 drivers/isdn/hisax/st5481_d.c                 |   12 +-
 drivers/isdn/hisax/st5481_usb.c               |   24 ++--
 drivers/media/video/cpia_usb.c                |    4 
 drivers/net/irda/irda-usb.c                   |   46 ++++-----
 drivers/usb/class/audio.c                     |  127 +++++++++++++-------------
 drivers/usb/class/bluetty.c                   |   26 ++---
 drivers/usb/class/cdc-acm.c                   |   34 +++---
 drivers/usb/class/usb-midi.c                  |   32 +++---
 drivers/usb/class/usblp.c                     |   28 ++---
 drivers/usb/core/config.c                     |   89 ++++++++++--------
 drivers/usb/core/devices.c                    |   16 +--
 drivers/usb/core/devio.c                      |   21 ++--
 drivers/usb/core/driverfs.c                   |    8 -
 drivers/usb/core/hcd.c                        |   10 +-
 drivers/usb/core/hub.c                        |   22 ++--
 drivers/usb/core/message.c                    |   55 +++++------
 drivers/usb/core/urb.c                        |   12 +-
 drivers/usb/core/usb-debug.c                  |   18 +--
 drivers/usb/core/usb.c                        |   50 +++++-----
 drivers/usb/host/ehci-q.c                     |    2 
 drivers/usb/host/ehci-sched.c                 |    2 
 drivers/usb/host/hc_simple.c                  |   10 +-
 drivers/usb/host/hc_sl811_rh.c                |    2 
 drivers/usb/host/ohci-hcd.c                   |    6 -
 drivers/usb/host/ohci-mem.c                   |    7 -
 drivers/usb/host/ohci-q.c                     |   51 ++++------
 drivers/usb/host/uhci-hcd.c                   |   12 +-
 drivers/usb/image/hpusbscsi.c                 |   32 +++---
 drivers/usb/image/mdc800.c                    |   24 ++--
 drivers/usb/image/microtek.c                  |   24 ++--
 drivers/usb/image/scanner.c                   |   16 +--
 drivers/usb/input/aiptek.c                    |    2 
 drivers/usb/input/hid-core.c                  |   16 +--
 drivers/usb/input/powermate.c                 |    6 -
 drivers/usb/input/usbkbd.c                    |    8 -
 drivers/usb/input/usbmouse.c                  |    6 -
 drivers/usb/input/wacom.c                     |    2 
 drivers/usb/input/xpad.c                      |    2 
 drivers/usb/media/dabusb.c                    |    6 -
 drivers/usb/media/ibmcam.c                    |   10 +-
 drivers/usb/media/konicawc.c                  |   24 ++--
 drivers/usb/media/ov511.c                     |    6 -
 drivers/usb/media/pwc-if.c                    |   16 +--
 drivers/usb/media/se401.c                     |    6 -
 drivers/usb/media/stv680.c                    |    2 
 drivers/usb/media/ultracam.c                  |   16 +--
 drivers/usb/media/usbvideo.c                  |    2 
 drivers/usb/media/vicam.c                     |    6 -
 drivers/usb/misc/Config.help                  |    3 
 drivers/usb/misc/auerswald.c                  |   18 +--
 drivers/usb/misc/brlvger.c                    |   10 +-
 drivers/usb/misc/speedtouch.c                 |   10 +-
 drivers/usb/misc/tiglusb.c                    |    4 
 drivers/usb/misc/usbtest.c                    |   30 +++---
 drivers/usb/misc/uss720.c                     |    8 -
 drivers/usb/net/catc.c                        |   15 +--
 drivers/usb/net/cdc-ether.c                   |   56 +++++------
 drivers/usb/net/kaweth.c                      |   12 +-
 drivers/usb/net/pegasus.c                     |   22 ++--
 drivers/usb/net/rtl8150.c                     |   16 +--
 drivers/usb/net/usbnet.c                      |   18 +--
 drivers/usb/serial/cyberjack.c                |    4 
 drivers/usb/serial/empeg.c                    |    6 -
 drivers/usb/serial/ftdi_sio.c                 |    6 -
 drivers/usb/serial/io_edgeport.c              |    4 
 drivers/usb/serial/io_ti.c                    |    8 -
 drivers/usb/serial/ipaq.c                     |    6 -
 drivers/usb/serial/ir-usb.c                   |    4 
 drivers/usb/serial/keyspan.c                  |   10 +-
 drivers/usb/serial/kl5kusb105.c               |    6 -
 drivers/usb/serial/mct_u232.c                 |    2 
 drivers/usb/serial/omninet.c                  |    4 
 drivers/usb/serial/safe_serial.c              |    4 
 drivers/usb/serial/usb-serial.c               |   10 +-
 drivers/usb/storage/scsiglue.c                |    2 
 drivers/usb/storage/transport.c               |    8 -
 drivers/usb/storage/usb.c                     |   29 +++--
 drivers/usb/usb-skeleton.c                    |    6 -
 include/linux/usb.h                           |  119 ++++++++----------------
 include/linux/usb_ch9.h                       |   91 +++++++++++++++++-
 sound/usb/usbaudio.c                          |   78 +++++++--------
 sound/usb/usbmidi.c                           |   78 +++++++--------
 86 files changed, 903 insertions(+), 834 deletions(-)
-----

ChangeSet@1.871, 2002-10-30 09:41:59-08:00, greg@kroah.com
  USB: fix usbmidi driver for no automatic resubmission of interrupt urbs

 sound/usb/usbmidi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
------

ChangeSet@1.850.1.12, 2002-10-30 00:12:57-08:00, david-b@pacbell.net
  [PATCH] usbtest mentions url
  
  This mentions the web page with information about how to use
  the 'usbtest' driver.

 drivers/usb/misc/Config.help |    3 +++
 1 files changed, 3 insertions(+)
------

ChangeSet@1.850.1.11, 2002-10-30 00:12:42-08:00, david-b@pacbell.net
  [PATCH] ohci td error cleanup
  
  This is a version of a patch I sent out last Friday to help
  address some of the "bad entry" errors that some folk
  were seeing, seemingly only with control requests.  The fix
  is just to not try being clever: remove one TD at a time and
  patch the ED as if that TD had completed normally, then do
  the next ... don't try to patch just once in this fault case.
  (And it nukes some debug info I accidently submitted.)
  
  I've gotten preliminary feedback that this helps.

 drivers/usb/host/ohci-mem.c |    7 ------
 drivers/usb/host/ohci-q.c   |   49 ++++++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 33 deletions(-)
------

ChangeSet@1.850.1.10, 2002-10-30 00:06:10-08:00, greg@kroah.com
  USB: drivers/net/irda fixups due to USB structure changes.

 drivers/net/irda/irda-usb.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)
------

ChangeSet@1.850.1.9, 2002-10-30 00:05:31-08:00, greg@kroah.com
  USB: drivers/isdn/hisax fixups due to USB structure changes.

 drivers/isdn/hisax/st5481_b.c   |    8 ++++----
 drivers/isdn/hisax/st5481_d.c   |    8 ++++----
 drivers/isdn/hisax/st5481_usb.c |   18 +++++++++---------
 3 files changed, 17 insertions(+), 17 deletions(-)
------

ChangeSet@1.850.1.8, 2002-10-30 00:04:37-08:00, greg@kroah.com
  USB: drivers/usb fixups due to USB structure changes.

 drivers/bluetooth/hci_usb.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)
------

ChangeSet@1.850.1.7, 2002-10-30 00:03:43-08:00, greg@kroah.com
  USB: sound/usb fixups due to USB structure changes.

 sound/usb/usbaudio.c |   12 ++++++------
 sound/usb/usbmidi.c  |   28 ++++++++++++++--------------
 2 files changed, 20 insertions(+), 20 deletions(-)
------

ChangeSet@1.850.1.6, 2002-10-30 00:02:56-08:00, greg@kroah.com
  USB: drivers/usb fixups due to USB structure changes.

 drivers/usb/image/microtek.c  |    2 +-
 drivers/usb/media/stv680.c    |    2 +-
 drivers/usb/misc/speedtouch.c |    2 +-
 drivers/usb/misc/uss720.c     |    8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)
------

ChangeSet@1.850.1.5, 2002-10-30 00:01:46-08:00, greg@kroah.com
  USB: usb serial driver fixes due to USB structure changes.

 drivers/usb/serial/io_ti.c       |    8 ++++----
 drivers/usb/serial/safe_serial.c |    2 +-
 drivers/usb/serial/usb-serial.c  |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.850.1.4, 2002-10-29 23:43:32-08:00, david-b@pacbell.net
  [PATCH] USB: clean up usb structures some more
  
  This patch splits up the usb structures to have two structs,
  "usb_XXX_descriptor" with just the descriptor, and "usb_host_XXX" (or
  something similar) to wrap it and add the "extra" pointers plus the
  array of related descriptors that the host parsed during enumeration.
  (2 or 3 words extra in each"usb_host_XXX".)  This further matches the
  "on the wire" data and enables the gadget drivers to share the same
  header file.
  
  Covers all the linux/drivers/usb/* and linux/sound/usb/* stuff, but
  not a handful of other drivers (bluetooth, iforce, hisax, irda) that
  are out of the usb tree and will likely be affected.

 drivers/usb/class/audio.c       |  111 ++++++++++++++++++++--------------------
 drivers/usb/class/bluetty.c     |    8 +-
 drivers/usb/class/cdc-acm.c     |   30 +++++-----
 drivers/usb/class/usb-midi.c    |   28 +++++-----
 drivers/usb/class/usblp.c       |   24 ++++----
 drivers/usb/core/config.c       |   89 ++++++++++++++++++--------------
 drivers/usb/core/devices.c      |   16 ++---
 drivers/usb/core/devio.c        |   19 +++---
 drivers/usb/core/driverfs.c     |    8 +-
 drivers/usb/core/hub.c          |   20 +++----
 drivers/usb/core/message.c      |   49 +++++++++--------
 drivers/usb/core/usb-debug.c    |   18 +++---
 drivers/usb/core/usb.c          |   50 ++++++++++--------
 drivers/usb/image/hpusbscsi.c   |   20 +++----
 drivers/usb/image/mdc800.c      |   18 +++---
 drivers/usb/image/microtek.c    |   18 +++---
 drivers/usb/image/scanner.c     |   14 ++---
 drivers/usb/input/aiptek.c      |    2 
 drivers/usb/input/hid-core.c    |   16 +++--
 drivers/usb/input/powermate.c   |    6 +-
 drivers/usb/input/usbkbd.c      |    8 +-
 drivers/usb/input/usbmouse.c    |    6 +-
 drivers/usb/input/wacom.c       |    2 
 drivers/usb/input/xpad.c        |    2 
 drivers/usb/media/dabusb.c      |    4 -
 drivers/usb/media/ibmcam.c      |   10 +--
 drivers/usb/media/konicawc.c    |   20 +++----
 drivers/usb/media/ov511.c       |    4 -
 drivers/usb/media/pwc-if.c      |   14 ++---
 drivers/usb/media/se401.c       |    2 
 drivers/usb/media/ultracam.c    |   16 ++---
 drivers/usb/media/vicam.c       |    6 +-
 drivers/usb/misc/auerswald.c    |    2 
 drivers/usb/misc/brlvger.c      |    8 +-
 drivers/usb/misc/tiglusb.c      |    4 -
 drivers/usb/misc/usbtest.c      |   30 +++++-----
 drivers/usb/net/catc.c          |    3 -
 drivers/usb/net/cdc-ether.c     |   48 ++++++++---------
 drivers/usb/net/kaweth.c        |    2 
 drivers/usb/net/pegasus.c       |    2 
 drivers/usb/net/rtl8150.c       |    2 
 drivers/usb/net/usbnet.c        |    6 +-
 drivers/usb/serial/usb-serial.c |    8 +-
 drivers/usb/storage/scsiglue.c  |    2 
 drivers/usb/storage/usb.c       |   27 +++++----
 drivers/usb/usb-skeleton.c      |    2 
 include/linux/usb.h             |   90 +++++++++++---------------------
 include/linux/usb_ch9.h         |   91 ++++++++++++++++++++++++++++++--
 sound/usb/usbaudio.c            |   60 ++++++++++-----------
 sound/usb/usbmidi.c             |   38 ++++++-------
 50 files changed, 587 insertions(+), 496 deletions(-)
------

ChangeSet@1.850.1.3, 2002-10-29 15:44:25-08:00, greg@kroah.com
  USB: Fixes for previous USB_* flag patch.

 drivers/usb/core/hcd.c   |    4 ++--
 drivers/usb/net/usbnet.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.850.1.2, 2002-10-29 15:27:28-08:00, jbm@joshisanerd.com
  [PATCH] [PATCH] fix a FIXME in usb.h
  
  In ush.h, there's a FIXME for the URB transfer flags. This patch is
  basically a global search and replace to change those all from USB_ to
  URB_.
  
  It touches a few things that aren't directly USB-related, and so should
  probably be passed by those authors, but I figured i should put it here to
  get feedback (ie: "No, moron, you did it all wrong!" or "Oops, that FIXME
  wasn't supposed to be there") before bothering them.

 Documentation/usb/URB.txt       |    4 ++--
 drivers/bluetooth/hci_usb.c     |    6 +++---
 drivers/isdn/hisax/st5481_d.c   |    4 ++--
 drivers/isdn/hisax/st5481_usb.c |    2 +-
 drivers/media/video/cpia_usb.c  |    4 ++--
 drivers/net/irda/irda-usb.c     |   20 ++++++++++----------
 drivers/usb/class/audio.c       |   16 ++++++++--------
 drivers/usb/class/cdc-acm.c     |    4 ++--
 drivers/usb/core/devio.c        |    2 +-
 drivers/usb/core/hcd.c          |    6 +++---
 drivers/usb/core/message.c      |    2 +-
 drivers/usb/core/urb.c          |   12 ++++++------
 drivers/usb/host/ehci-q.c       |    2 +-
 drivers/usb/host/ehci-sched.c   |    2 +-
 drivers/usb/host/hc_simple.c    |   10 +++++-----
 drivers/usb/host/hc_sl811_rh.c  |    2 +-
 drivers/usb/host/ohci-hcd.c     |    6 +++---
 drivers/usb/host/ohci-q.c       |    2 +-
 drivers/usb/host/uhci-hcd.c     |   12 ++++++------
 drivers/usb/media/dabusb.c      |    2 +-
 drivers/usb/media/konicawc.c    |    4 ++--
 drivers/usb/media/ov511.c       |    2 +-
 drivers/usb/media/pwc-if.c      |    2 +-
 drivers/usb/media/usbvideo.c    |    2 +-
 drivers/usb/misc/auerswald.c    |    4 ++--
 drivers/usb/net/catc.c          |    4 ++--
 drivers/usb/net/cdc-ether.c     |    2 +-
 drivers/usb/net/kaweth.c        |    2 +-
 drivers/usb/net/pegasus.c       |    2 +-
 drivers/usb/net/rtl8150.c       |    2 +-
 drivers/usb/net/usbnet.c        |    4 ++--
 drivers/usb/serial/ir-usb.c     |    4 ++--
 drivers/usb/serial/keyspan.c    |    8 ++++----
 drivers/usb/storage/transport.c |    4 ++--
 include/linux/usb.h             |   18 ++++++++----------
 sound/usb/usbaudio.c            |    6 +++---
 36 files changed, 94 insertions(+), 96 deletions(-)
------

ChangeSet@1.850.1.1, 2002-10-29 15:20:41-08:00, jbm@joshisanerd.com
  [PATCH] Eliminate Old Prototypes from 2.5.44
  
  Attached patch is the result of:
  
  dignity:~/src/linux-2.5.44 $ for x in `rgrep -l "FILL_.*URB"  *`;
  do cp -v $x $x.backup;
  cat $x.backup | perl -pe 's/FILL_CONTROL_URB/usb_fill_control_urb/g;
   s/FILL_BULK_URB/usb_fill_bulk_urb/g;
   s/FILL_INT_URB/usb_fill_int_urb/g;' > $x;
  done
  
  and a manual removal of the define's in usb.h.

 Documentation/DocBook/writing_usb_driver.tmpl |    2 +-
 drivers/bluetooth/hci_usb.c                   |    8 ++++----
 drivers/isdn/hisax/st5481_usb.c               |    4 ++--
 drivers/net/irda/irda-usb.c                   |    6 +++---
 drivers/usb/class/bluetty.c                   |   18 +++++++++---------
 drivers/usb/class/usb-midi.c                  |    4 ++--
 drivers/usb/class/usblp.c                     |    4 ++--
 drivers/usb/core/hub.c                        |    2 +-
 drivers/usb/core/message.c                    |    4 ++--
 drivers/usb/image/hpusbscsi.c                 |   12 ++++++------
 drivers/usb/image/mdc800.c                    |    6 +++---
 drivers/usb/image/microtek.c                  |    4 ++--
 drivers/usb/image/scanner.c                   |    2 +-
 drivers/usb/media/se401.c                     |    4 ++--
 drivers/usb/misc/auerswald.c                  |   12 ++++++------
 drivers/usb/misc/brlvger.c                    |    2 +-
 drivers/usb/misc/speedtouch.c                 |    8 ++++----
 drivers/usb/net/catc.c                        |    8 ++++----
 drivers/usb/net/cdc-ether.c                   |    6 +++---
 drivers/usb/net/kaweth.c                      |    8 ++++----
 drivers/usb/net/pegasus.c                     |   18 +++++++++---------
 drivers/usb/net/rtl8150.c                     |   12 ++++++------
 drivers/usb/net/usbnet.c                      |    6 +++---
 drivers/usb/serial/cyberjack.c                |    4 ++--
 drivers/usb/serial/empeg.c                    |    6 +++---
 drivers/usb/serial/ftdi_sio.c                 |    6 +++---
 drivers/usb/serial/io_edgeport.c              |    4 ++--
 drivers/usb/serial/ipaq.c                     |    6 +++---
 drivers/usb/serial/keyspan.c                  |    2 +-
 drivers/usb/serial/kl5kusb105.c               |    6 +++---
 drivers/usb/serial/mct_u232.c                 |    2 +-
 drivers/usb/serial/omninet.c                  |    4 ++--
 drivers/usb/serial/safe_serial.c              |    2 +-
 drivers/usb/storage/transport.c               |    4 ++--
 drivers/usb/storage/usb.c                     |    2 +-
 drivers/usb/usb-skeleton.c                    |    4 ++--
 include/linux/usb.h                           |   11 -----------
 sound/usb/usbmidi.c                           |    6 +++---
 38 files changed, 109 insertions(+), 120 deletions(-)
------


