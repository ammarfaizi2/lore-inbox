Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbTAOXQG>; Wed, 15 Jan 2003 18:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTAOXQG>; Wed, 15 Jan 2003 18:16:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21516 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267007AbTAOXQE>;
	Wed, 15 Jan 2003 18:16:04 -0500
Date: Wed, 15 Jan 2003 15:24:34 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.58
Message-ID: <20030115232434.GD25816@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 MAINTAINERS                     |    6 ++---
 drivers/usb/class/bluetty.c     |    7 ------
 drivers/usb/class/cdc-acm.c     |    4 ---
 drivers/usb/core/hcd.c          |    2 -
 drivers/usb/core/hcd.h          |    3 --
 drivers/usb/core/usb.c          |    1 
 drivers/usb/misc/speedtouch.c   |   45 ++++++++++++++++++++--------------------
 drivers/usb/serial/bus.c        |   13 +++++++++++
 drivers/usb/serial/usb-serial.c |    1 
 drivers/usb/storage/scsiglue.c  |    6 ++++-
 include/linux/usb.h             |    4 ++-
 11 files changed, 52 insertions(+), 40 deletions(-)
-----

ChangeSet@1.942, 2003-01-15 14:50:56-08:00, greg@kroah.com
  USB: added .owner for USB drivers that have a struct tty_driver

 drivers/usb/class/bluetty.c     |    7 +------
 drivers/usb/class/cdc-acm.c     |    4 +---
 drivers/usb/serial/usb-serial.c |    1 +
 3 files changed, 3 insertions(+), 9 deletions(-)
------

ChangeSet@1.879.84.7, 2003-01-15 13:23:54-08:00, baldrick@wanadoo.fr
  [PATCH] USB: SpeedTouch not Speed Touch
  
    speedtouch: use SpeedTouch everywhere (was sometimes Speed Touch).

 drivers/usb/misc/speedtouch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.84.6, 2003-01-15 13:23:22-08:00, baldrick@wanadoo.fr
  [PATCH] USB: make more speedtouch functions static
  
    speedtouch: make more functions static.

 drivers/usb/misc/speedtouch.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)
------

ChangeSet@1.879.84.5, 2003-01-15 13:22:47-08:00, baldrick@wanadoo.fr
  [PATCH] USB: kill speedtouch tasklet when shutdown
  
    speedtouch: kill receive queue tasklet on shutdown (race pointed
  out by Oliver Neukum).

 drivers/usb/misc/speedtouch.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.879.84.4, 2003-01-15 13:22:21-08:00, david-b@pacbell.net
  [PATCH] maintain hcd_dev queue in FIFO order
  
  Current uses of the urb_list have all been to make
  sure we have some list of pending urbs, so we can
  clean them all up after HCs die, and avoid trying
  to unlink something that's not actually linked.
  So order hasn't mattered.
  
  This makes the order be FIFO, which is more useful
  for other purposes.  Like being the HCD's internal
  schedule, or dumping for debug.

 drivers/usb/core/hcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.879.84.3, 2003-01-15 12:48:26-08:00, henning@meier-geinitz.de
  [PATCH] Change maintainership of USB scanner driver

 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.879.84.2, 2003-01-14 17:49:55-08:00, greg@kroah.com
  [PATCH] USB: add dev attribute for usb-serial devices in sysfs

 drivers/usb/serial/bus.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)
------

ChangeSet@1.879.76.2, 2003-01-13 17:31:46-08:00, greg@kroah.com
  [PATCH] USB: put the usb storage's SCSI device in the proper place in sysfs.
  
  Also makes usb_ifnum_to_if() a public function

 drivers/usb/core/hcd.h         |    3 ---
 drivers/usb/core/usb.c         |    1 +
 drivers/usb/storage/scsiglue.c |    5 ++++-
 include/linux/usb.h            |    4 +++-
 4 files changed, 8 insertions(+), 5 deletions(-)
------

ChangeSet@1.879.76.1, 2003-01-13 17:25:34-08:00, patmans@us.ibm.com
  [PATCH] USB storage sysfs fix
  
  It looks like there is a missing scsi_set_device() call in scsiglue.c,
  (similiar to what happens if we handled NULL dev pointer in scis_add_host)
  so all the usb scsi devices end up under /sysfs/devices.
  
  I don't have any usb mass storage devices, this patch against 2.5 bk
  compiles but otherwise is not tested. It should put the usb-scsi mass
  storage devices below the usb sysfs dev (I assume in your case under
  /sysfs/devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.4).

 drivers/usb/storage/scsiglue.c |    1 +
 1 files changed, 1 insertion(+)
------

