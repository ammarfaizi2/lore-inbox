Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266121AbSLITfg>; Mon, 9 Dec 2002 14:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbSLITfg>; Mon, 9 Dec 2002 14:35:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50186 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266121AbSLITfd>;
	Mon, 9 Dec 2002 14:35:33 -0500
Date: Mon, 9 Dec 2002 11:42:18 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Yet more USB changes for 2.5.50
Message-ID: <20021209194217.GE32686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/usb/class/usb-midi.h     |    4 
 drivers/usb/core/devio.c         |   12 
 drivers/usb/host/ehci-q.c        |   15 
 drivers/usb/image/hpusbscsi.h    |   28 -
 drivers/usb/media/dsbr100.c      |    3 
 drivers/usb/serial/Kconfig       |   19 +
 drivers/usb/serial/Makefile      |    1 
 drivers/usb/serial/io_tables.h   |  152 ++++----
 drivers/usb/serial/keyspan.h     |  364 +++++++++----------
 drivers/usb/serial/kobil_sct.c   |  735 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/serial/kobil_sct.h   |   60 +++
 drivers/usb/serial/safe_serial.c |   12 
 drivers/usb/serial/visor.c       |   63 +++
 drivers/usb/serial/visor.h       |    1 
 drivers/usb/storage/transport.c  |  167 +++-----
 drivers/usb/storage/transport.h  |    5 
 drivers/usb/storage/usb.c        |   80 ----
 drivers/usb/storage/usb.h        |   11 
 sound/usb/usbmidi.c              |    2 
 19 files changed, 1253 insertions(+), 481 deletions(-)
-----

ChangeSet@1.831.15.16, 2002-12-09 11:27:38-08:00, ahaas@airmail.net
  [PATCH] C99 initializer for drivers/usb/storage/usb.c
  
  Here's a small patch for the file. The patch is against 2.5.50.

 drivers/usb/storage/usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.831.15.15, 2002-12-09 11:00:37-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] PATCH: usb-storage: make internal structs more consistent
  
  This patch makes ss->ep_int just like ep_in and ep_out for improved code
  symmetry and readability.  It may (on some architectures) also shrink the
  size of the per-device data structure.

 drivers/usb/storage/transport.c |    4 ++--
 drivers/usb/storage/usb.c       |   15 +++++++++------
 drivers/usb/storage/usb.h       |    3 ++-
 3 files changed, 13 insertions(+), 9 deletions(-)
------

ChangeSet@1.831.15.14, 2002-12-09 10:59:40-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: make CBI interrupt URBs one-shot
  
  Change interrupt used for CBI from periodic to one-shot.  This (a) reduces
  consumed bandwidth, (b) makes the logic clearer, and (c) makes the abort
  mechanism more uniform.

 drivers/usb/storage/transport.c |  163 ++++++++++++++--------------------------
 drivers/usb/storage/transport.h |    5 -
 drivers/usb/storage/usb.c       |   63 ---------------
 drivers/usb/storage/usb.h       |    8 -
 4 files changed, 67 insertions(+), 172 deletions(-)
------

ChangeSet@1.831.15.13, 2002-12-09 10:23:16-08:00, greg@kroah.com
  [PATCH] USB: fixup kobil_sct driver to build properly with urb callback changes.
  

 drivers/usb/serial/kobil_sct.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.831.15.12, 2002-12-09 10:16:21-08:00, wahrenbruch@kobil.de
  [PATCH] USB: kobil_sct driver for 2.5.50
  

 drivers/usb/serial/Kconfig     |   19 +
 drivers/usb/serial/Makefile    |    1 
 drivers/usb/serial/kobil_sct.c |  727 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/kobil_sct.h |   60 +++
 4 files changed, 807 insertions(+)
------

ChangeSet@1.831.15.11, 2002-12-09 10:08:07-08:00, david-b@pacbell.net
  [PATCH] patch 2.5.50+, ehci-hcd loop termination
  
  While in search of a different bug, I found this one
  that got in with the recent 'async_next' patch.  The
  schedule scan termination changed (had to), but it
  wasn't quite correct.  Slower and/or misbehaving
  devices might have wedged a CPU ... fix is simple,
  only restart the scan when the list may have changed.

 drivers/usb/host/ehci-q.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)
------

ChangeSet@1.831.15.10, 2002-12-09 10:05:28-08:00, oliver@oenone.homelinux.org
  [PATCH] USB usbfs: fix race between disconnect and usbdev_open
  

 drivers/usb/core/devio.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)
------

ChangeSet@1.831.15.9, 2002-12-09 09:49:29-08:00, greg@kroah.com
  [PATCH] USB: Add Treo 300 id to the visor driver supported devices list.
  

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.831.15.8, 2002-12-09 09:12:49-08:00, greg@kroah.com
  [PATCH] USB: Fix compile error in usbmidi driver.
  

 sound/usb/usbmidi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.831.15.7, 2002-12-06 19:42:39-06:00, greg@kroah.com
  [PATCH] USB: initial attempt at Treo 300 support for the visor driver
  
  Thanks to Troy Benjegerdes and Jason Carnahan for first cuts at this...

 drivers/usb/serial/visor.c |   61 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 57 insertions(+), 4 deletions(-)
------

ChangeSet@1.831.15.6, 2002-12-06 13:34:39-06:00, ahaas@airmail.net
  [PATCH] C99 initializer for drivers/usb/class/usb-midi.h
  
  Here's a trivial patch for the file to switch it to use C99
  initializers. The patch is against 2.5.50.

 drivers/usb/class/usb-midi.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.831.15.5, 2002-12-06 13:34:20-06:00, ahaas@airmail.net
  [PATCH] C99 initializers for drivers/usb/serial
  
  Here are patches for switching two files over to use C99 initializers.
  The patches are against 2.5.50.

 drivers/usb/serial/io_tables.h |  152 ++++++++---------
 drivers/usb/serial/keyspan.h   |  364 ++++++++++++++++++++---------------------
 2 files changed, 258 insertions(+), 258 deletions(-)
------

ChangeSet@1.831.15.4, 2002-12-06 13:33:59-06:00, ahaas@airmail.net
  [PATCH] C99 initializer for drivers/usb/serial/safe_serial.c
  
  Here's  small patch for the file fixing a few initializers to use C99
  style. The patch is against 2.5.50.

 drivers/usb/serial/safe_serial.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.831.15.3, 2002-12-06 13:33:35-06:00, ahaas@airmail.net
  [PATCH] C99 initializer for drivers/usb/image/hpusbscsi.h
  
  Here's a patch for switching the file to use C99 initializers. The patch
  is against 2.5.50.

 drivers/usb/image/hpusbscsi.h |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)
------

ChangeSet@1.831.15.2, 2002-12-06 13:32:51-06:00, kraxel@bytesex.org
  [PATCH] dsb usb radio fix
  
    This patch fixes stupid cut+paste bug in dsbr100.

 drivers/usb/media/dsbr100.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

