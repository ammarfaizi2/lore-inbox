Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSHSDxT>; Sun, 18 Aug 2002 23:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317735AbSHSDxT>; Sun, 18 Aug 2002 23:53:19 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:27662 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317624AbSHSDxR>;
	Sun, 18 Aug 2002 23:53:17 -0400
Date: Sun, 18 Aug 2002 20:52:20 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] And yet more USB changes for 2.5.31
Message-ID: <20020819035220.GA20612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  http://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/class/printer.c    | 1130 -----------------------------------------
 drivers/usb/class/Makefile     |    2 
 drivers/usb/class/usblp.c      | 1130 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/hcd.c         |   12 
 drivers/usb/core/hcd.h         |   65 ++
 drivers/usb/core/hub.c         |   25 
 drivers/usb/core/urb.c         |   47 -
 drivers/usb/core/usb.c         |   56 --
 drivers/usb/host/hc_sl811_rh.c |   50 +
 drivers/usb/host/uhci-hcd.h    |    3 
 drivers/usb/media/konicawc.c   |   35 +
 drivers/usb/media/usbvideo.c   |   82 +-
 drivers/usb/media/usbvideo.h   |   18 
 drivers/usb/serial/ipaq.h      |    2 
 drivers/usb/storage/isd200.c   |   38 -
 drivers/usb/storage/raw_bulk.c |   23 
 include/linux/usb.h            |  109 ---
 17 files changed, 1445 insertions(+), 1382 deletions(-)
------

ChangeSet@1.497, 2002-08-18 20:17:23-07:00, greg@kroah.com
  USB: rename printer.c to usblp.c as that's what it has been calling itself :)

 drivers/usb/class/printer.c | 1130 --------------------------------------------
 drivers/usb/class/Makefile  |    2 
 drivers/usb/class/usblp.c   | 1130 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1131 insertions(+), 1131 deletions(-)
------

ChangeSet@1.496, 2002-08-18 17:42:22-07:00, spse@secret.org.uk
  [PATCH] add callback for VIDIOCSWIN ioctl to usbvideo
  
  This patch adds a callback for VIDIOCSWIN ioctl to usbvideo so
  the webcam miniport drivers can implement handling for the ioctl.
  
  It also makes VIDIOCGWIN return the frame size for the current
  mode rather than the canvas size. For current drivers
  uvd->canvas == uvd->videosize since the frame size is set
  when the module is loaded.

 drivers/usb/media/usbvideo.c |    8 ++++++--
 drivers/usb/media/usbvideo.h |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)
------

ChangeSet@1.495, 2002-08-18 17:41:54-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB-storage: final abort handler cleanup, for real...
  
  Whoops!  Accidentally introduced a typo.  This patch should fix the typo...
  it's designed to apply after the last one.

 drivers/usb/storage/isd200.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.494, 2002-08-18 17:41:26-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB-storage: final abort handler cleanup
  
  This should be the final patch to make the abort mechanisms work properly.

 drivers/usb/storage/isd200.c   |   30 ++++++++++++++++++------------
 drivers/usb/storage/raw_bulk.c |   23 ++++++++++++-----------
 2 files changed, 30 insertions(+), 23 deletions(-)
------

ChangeSet@1.493, 2002-08-18 17:19:37-07:00, david-b@pacbell.net
  [PATCH] misc usbcore cleanups
  
  Another cleanup patch:
  
     - removes more usbcore-internal symbols from sight of device drivers
         * some are only for the uhci driver
         * most are shared just a bit more widely
     - DEVNUM_ROUND_ROBIN is no longer an internal option
     - usb_root_hub_string() gone, per the FIXME
     - various kerneldoc fixes and updates
     - uses legal value (en-us) for root hub strings
     - hub driver only shows port fixed/removable for compound devices

 drivers/usb/core/hcd.c         |   12 +---
 drivers/usb/core/hcd.h         |   65 +++++++++++++++++++++++-
 drivers/usb/core/hub.c         |   25 ++++-----
 drivers/usb/core/urb.c         |   47 +++++++++--------
 drivers/usb/core/usb.c         |   56 ---------------------
 drivers/usb/host/hc_sl811_rh.c |   50 ++++++++++++++++++
 drivers/usb/host/uhci-hcd.h    |    3 +
 include/linux/usb.h            |  109 +++++++----------------------------------
 8 files changed, 177 insertions(+), 190 deletions(-)
------

ChangeSet@1.492, 2002-08-17 13:44:21-07:00, ganesh@vxindia.veritas.com
  [PATCH] typo in usb/serial/ipaq.h
  
          this fixes HP's vendor ID in ipaq.h

 drivers/usb/serial/ipaq.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.491, 2002-08-17 13:38:56-07:00, spse@secret.org.uk
  [PATCH] konicawc - make snapshot button into input device
  
  This patch presents the snapshot button on the camera as an
  event input device.

 drivers/usb/media/konicawc.c |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)
------

ChangeSet@1.490, 2002-08-17 13:38:47-07:00, spse@secret.org.uk
  [PATCH] cleanup RingQueue_* functions in usbvideo.c
  
  This patch against 2.5.31 cleans up the RingQueue_* functions
  
  - make the buffer length be a power of 2 to speed up index manipulation
  - make RingQueue_Dequeue use memcpy() rather than a byte by byte copy
  - make RingQueue_Enqueue use memcpy() instead of memmove() as the memory
    regions do not overlap
  - Add RingQueue_Flush() and RingQueue_GetFreeSpace()
  - make RingQueue_GetLength() an inline

 drivers/usb/media/usbvideo.c |   74 ++++++++++++++++++++++++++++---------------
 drivers/usb/media/usbvideo.h |   17 ++++++++-
 2 files changed, 63 insertions(+), 28 deletions(-)
------

