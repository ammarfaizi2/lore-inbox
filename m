Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319113AbSH2G2s>; Thu, 29 Aug 2002 02:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319114AbSH2G2s>; Thu, 29 Aug 2002 02:28:48 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:3087 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319113AbSH2G2o>;
	Thu, 29 Aug 2002 02:28:44 -0400
Date: Wed, 28 Aug 2002 23:32:22 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH]  USB changes for 2.5.32
Message-ID: <20020829063222.GA416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Lots of __FUNCTION__ fixups for the USB code, and some other updates.

Please pull from:  http://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/ehci.txt           |   69 +++++---
 Documentation/usb/ohci.txt           |  121 +++-----------
 drivers/usb/class/bluetty.c          |  134 ++++++++--------
 drivers/usb/core/buffer.c            |   44 +++++
 drivers/usb/core/hcd-pci.c           |   10 -
 drivers/usb/core/hcd.c               |    3 
 drivers/usb/core/hcd.h               |   17 +-
 drivers/usb/core/urb.c               |    1 
 drivers/usb/core/usb.c               |  114 ++++++++++++++
 drivers/usb/host/ehci-dbg.c          |  270 ++++++++++++++++++++++++++-------
 drivers/usb/host/ohci-q.c            |    8 
 drivers/usb/media/ibmcam.c           |   14 -
 drivers/usb/media/konicawc.c         |    4 
 drivers/usb/media/ultracam.c         |    4 
 drivers/usb/media/usbvideo.c         |   44 ++---
 drivers/usb/media/usbvideo.h         |   58 +++----
 drivers/usb/misc/brlvger.c           |    4 
 drivers/usb/serial/belkin_sa.c       |    6 
 drivers/usb/serial/cyberjack.c       |   70 ++++----
 drivers/usb/serial/digi_acceleport.c |   33 +---
 drivers/usb/serial/empeg.c           |   55 +++---
 drivers/usb/serial/ftdi_sio.c        |   88 +++++-----
 drivers/usb/serial/io_edgeport.c     |  283 +++++++++++++++++------------------
 drivers/usb/serial/io_ti.c           |   56 +++---
 drivers/usb/serial/ipaq.c            |   44 ++---
 drivers/usb/serial/ir-usb.c          |    2 
 drivers/usb/serial/keyspan.c         |   18 --
 drivers/usb/serial/keyspan.h         |    1 
 drivers/usb/serial/keyspan_pda.c     |   10 -
 drivers/usb/serial/kl5kusb105.c      |  108 ++++++-------
 drivers/usb/serial/mct_u232.c        |   37 ++--
 drivers/usb/serial/omninet.c         |   24 +-
 drivers/usb/serial/pl2303.c          |   99 ++++++------
 drivers/usb/serial/pl2303.h          |    3 
 drivers/usb/serial/safe_serial.c     |   26 +--
 drivers/usb/serial/usbserial.c       |  117 +++++++-------
 drivers/usb/serial/visor.c           |  100 ++++++------
 drivers/usb/serial/whiteheat.c       |   66 +++-----
 include/linux/usb.h                  |    8 
 39 files changed, 1235 insertions(+), 938 deletions(-)
-----

ChangeSet@1.555, 2002-08-28 23:16:56-07:00, greg@kroah.com
  USB: brlvger driver: fixed __FUNCTION__ usage

 drivers/usb/misc/brlvger.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.554, 2002-08-28 23:16:05-07:00, greg@kroah.com
  USB: bluetty driver: fixed __FUNCTION__ usages.

 drivers/usb/class/bluetty.c |  134 ++++++++++++++++++++++----------------------
 1 files changed, 67 insertions(+), 67 deletions(-)
------

ChangeSet@1.553, 2002-08-28 22:55:17-07:00, greg@kroah.com
  USB: serial drivers: fixed __FUNCTION__ usages that I missed before.

 drivers/usb/serial/ftdi_sio.c  |   17 +++++++++--------
 drivers/usb/serial/usbserial.c |    4 ++--
 drivers/usb/serial/visor.c     |   12 +++++++-----
 3 files changed, 18 insertions(+), 15 deletions(-)
------

ChangeSet@1.552, 2002-08-28 22:53:57-07:00, greg@kroah.com
  USB: safe_serial driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/safe_serial.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)
------

ChangeSet@1.551, 2002-08-28 22:53:23-07:00, greg@kroah.com
  USB: io_ti driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/io_ti.c |   56 ++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)
------

ChangeSet@1.550, 2002-08-28 17:23:46-07:00, greg@kroah.com
  USB: fix debugging code to allow USB_NO_DMA_MAP.
    
  Thanks to Oliver Neukum for finding this

 drivers/usb/core/urb.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.548, 2002-08-28 16:14:22-07:00, david-b@pacbell.net
  [PATCH] ohci on sparc64
  
  DaveM noticed he needed a pci_dma_sync_single() after the
  DMA conversion late in 32 ; here's the patch.
  
  FYI this driver was previously having to unmap/remap in
  that location, this is an improvement!  :)

 drivers/usb/host/ohci-q.c |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.547, 2002-08-28 16:13:59-07:00, david-b@pacbell.net
  [PATCH] ehci, registers to driverfs (for debug)
  
  When debugging, it's useful to see what the registers are
  saying is up without needing to poke around in the kernel.
  This patch exposes them.

 drivers/usb/host/ehci-dbg.c |  270 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 216 insertions(+), 54 deletions(-)
------

ChangeSet@1.546, 2002-08-28 16:13:39-07:00, david-b@pacbell.net
  [PATCH] USB dma and scatterlists
  
  This patch (almost all from DaveM) wraps up the DMA API work
  by adding the scatterlist map/sync/unmap support.  And removes
  the corresponding FIXME.

 drivers/usb/core/buffer.c |   44 +++++++++++++++++
 drivers/usb/core/hcd.c    |    3 +
 drivers/usb/core/hcd.h    |   17 ++++++
 drivers/usb/core/usb.c    |  114 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h       |    8 +++
 5 files changed, 184 insertions(+), 2 deletions(-)
------

ChangeSet@1.545, 2002-08-28 15:44:45-07:00, greg@kroah.com
  USB: added break support for 2 port keyspan devices.

 drivers/usb/serial/keyspan.h |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.544, 2002-08-28 15:43:59-07:00, greg@kroah.com
  USB: keyspan driver: minor formatting fixes.

 drivers/usb/serial/keyspan.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)
------

ChangeSet@1.543, 2002-08-28 15:43:09-07:00, greg@kroah.com
  USB: ir-usb driver: gcc3 warning fix

 drivers/usb/serial/ir-usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.542, 2002-08-28 15:42:03-07:00, greg@kroah.com
  USB: io_edgeport driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/io_edgeport.c |  283 +++++++++++++++++++--------------------
 1 files changed, 142 insertions(+), 141 deletions(-)
------

ChangeSet@1.541, 2002-08-28 15:40:54-07:00, greg@kroah.com
  USB: empeg driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/empeg.c |   55 ++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 27 deletions(-)
------

ChangeSet@1.540, 2002-08-28 15:40:25-07:00, greg@kroah.com
  USB: digi_acceleport driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/digi_acceleport.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)
------

ChangeSet@1.539, 2002-08-28 15:37:13-07:00, greg@kroah.com
  USB: kl5usb105 driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/kl5kusb105.c |  108 +++++++++++++++++++---------------------
 1 files changed, 52 insertions(+), 56 deletions(-)
------

ChangeSet@1.538, 2002-08-28 15:36:33-07:00, greg@kroah.com
  USB: mct_u232 driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/mct_u232.c |   37 ++++++++++++++++++-------------------
 1 files changed, 18 insertions(+), 19 deletions(-)
------

ChangeSet@1.537, 2002-08-28 15:35:47-07:00, greg@kroah.com
  USB: omninet driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/omninet.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)
------

ChangeSet@1.536, 2002-08-28 15:35:08-07:00, greg@kroah.com
  USB: pl2303 driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/pl2303.c |   98 ++++++++++++++++++++++----------------------
 1 files changed, 49 insertions(+), 49 deletions(-)
------

ChangeSet@1.535, 2002-08-28 15:34:33-07:00, greg@kroah.com
  USB: cyberjack driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/cyberjack.c |   70 ++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 35 deletions(-)
------

ChangeSet@1.534, 2002-08-28 15:32:55-07:00, greg@kroah.com
  USB: belkin serial driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/belkin_sa.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.533, 2002-08-27 23:05:09-07:00, david-b@pacbell.net
  [PATCH] usb/core/hcd-pci, pci cleanup
  
  This doesn't really do what it was expected to do,
  and even that shouldn't be needed.  So:  remove.

 drivers/usb/core/hcd-pci.c |   10 ----------
 1 files changed, 10 deletions(-)
------

ChangeSet@1.532, 2002-08-27 15:42:29-07:00, greg@kroah.com
  USB: keyspan_pda driver: fixed __FUNCTION__ usages.

 drivers/usb/serial/keyspan_pda.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.531, 2002-08-27 15:41:35-07:00, greg@kroah.com
  USB: ftdi_sio driver: fixed __FUNCTION__ usages

 drivers/usb/serial/ftdi_sio.c |   71 ++++++++++++++++++++----------------------
 1 files changed, 35 insertions(+), 36 deletions(-)
------

ChangeSet@1.530, 2002-08-27 15:07:01-07:00, spse@secret.org.uk
  [PATCH] more typedef removal from usbvideo
  
  This patch removes some more typedefs from usbvideo and related files
  
  typedef struct { .. } RingQueue_t -> struct RingQueue
  typedef struct { .. } usbvideo_sbuf_t -> struct usbvideo_sbuf
  typedef struct { .. } usbvideo_frame_t -> struct usbvideo_frame
  typedef struct { .. } usbvideo_statistics_t -> struct usbvideo_statistics
  typedef struct { .. } usbvideo_cb_t -> struct usbvideo_cb

 drivers/usb/media/ibmcam.c   |   14 +++++-----
 drivers/usb/media/konicawc.c |    4 +-
 drivers/usb/media/ultracam.c |    4 +-
 drivers/usb/media/usbvideo.c |   44 ++++++++++++++++----------------
 drivers/usb/media/usbvideo.h |   58 ++++++++++++++++++++-----------------------
 5 files changed, 61 insertions(+), 63 deletions(-)
------

ChangeSet@1.529, 2002-08-27 15:06:25-07:00, david-b@pacbell.net
  [PATCH] Documentation/usb/{o,u}hci.txt
  
  This updates the EHCI and OHCI writeups.  OHCI hadn't been
  updated forever.

 Documentation/usb/ehci.txt |   69 +++++++++++++++----------
 Documentation/usb/ohci.txt |  121 +++++++++++----------------------------------
 2 files changed, 72 insertions(+), 118 deletions(-)
------

ChangeSet@1.528, 2002-08-27 14:59:39-07:00, greg@kroah.com
  USB: whiteheat driver: fixed __FUNCTION__ use

 drivers/usb/serial/whiteheat.c |   66 +++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 34 deletions(-)
------

ChangeSet@1.527, 2002-08-27 14:58:47-07:00, greg@kroah.com
  USB: visor driver: fixed __FUNCTION__ usages

 drivers/usb/serial/visor.c |   88 ++++++++++++++++++++++-----------------------
 1 files changed, 44 insertions(+), 44 deletions(-)
------

ChangeSet@1.526, 2002-08-27 14:58:14-07:00, greg@kroah.com
  USB: usbserial core: fixed __FUNCTION__ usages.
  
  also changed the license to be GPL v2 only.

 drivers/usb/serial/usbserial.c |  113 +++++++++++++++++++++--------------------
 1 files changed, 58 insertions(+), 55 deletions(-)
------

ChangeSet@1.525, 2002-08-27 14:57:18-07:00, greg@kroah.com
  USB: ipaq driver: fixed __FUNCTION__ usages

 drivers/usb/serial/ipaq.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)
------

ChangeSet@1.524, 2002-08-27 14:56:24-07:00, greg@kroah.com
  USB: added new pl2303 device, thanks to Tasos Chronis <tasosc@otenet.gr>

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

