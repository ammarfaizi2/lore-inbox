Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268385AbTAMWpW>; Mon, 13 Jan 2003 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTAMWpW>; Mon, 13 Jan 2003 17:45:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34310 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268385AbTAMWpJ>;
	Mon, 13 Jan 2003 17:45:09 -0500
Date: Mon, 13 Jan 2003 14:53:58 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.57
Message-ID: <20030113225357.GA9915@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/proc_usb_info.txt  |    2 
 drivers/usb/class/Kconfig            |    4 
 drivers/usb/class/audio.c            |    8 -
 drivers/usb/class/usb-midi.c         |   14 +-
 drivers/usb/core/hub.c               |   12 -
 drivers/usb/host/ehci-dbg.c          |   26 +--
 drivers/usb/host/ohci-dbg.c          |   22 +--
 drivers/usb/input/xpad.c             |    4 
 drivers/usb/misc/speedtouch.c        |  201 +++++-------------------------
 drivers/usb/serial/digi_acceleport.c |    6 
 drivers/usb/serial/usb-serial.c      |    2 
 drivers/usb/serial/visor.c           |  234 +++++++++++++++++++++--------------
 drivers/usb/serial/visor.h           |   31 ++++
 drivers/usb/storage/debug.c          |   32 ++--
 drivers/usb/usb-skeleton.c           |    2 
 15 files changed, 274 insertions(+), 326 deletions(-)
-----

ChangeSet@1.944, 2003-01-13 13:53:41-08:00, cobra@compuserve.com
  [PATCH] ohci/ehci debug updates for 2.5.56
  
    These two files needed to be touched after the recent changes to
  DRIVER_ATTR/driver_attribute structure members in 2.5.56.  Personally,
  it doesn't look to me like the size parameter should be removed, as now
  users will need to hardcode PAGE_SIZE into their functions, rather than
  it being passed from the place of allocation.  But I'm not familiar with
  the driverfs changes, so can't really say.
  
  These changes, or something similar, are needed to make ohci-dbg and
  ehci-dbg work at all in 2.5.56.  ehci is untested, but compiles here.
  I've tested the ohci changes and they appear to work.

 drivers/usb/host/ehci-dbg.c |   26 +++++++++-----------------
 drivers/usb/host/ohci-dbg.c |   22 +++++++++-------------
 2 files changed, 18 insertions(+), 30 deletions(-)
------

ChangeSet@1.889.26.18, 2003-01-13 11:16:47-08:00, greg@kroah.com
  Cset exclude: greg@kroah.com|ChangeSet|20030112082136|46568

 drivers/usb/core/hub.c |    6 ------
 1 files changed, 6 deletions(-)
------

ChangeSet@1.889.26.17, 2003-01-12 23:01:58-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: clean up debugging
  
  This patch makes the debug system only print out the valid bytes of a
  command.  Greg, please apply.
  
  Andries suggested this... while some would think that seeing the extra
  bytes might be good, it is kinda noisy.

 drivers/usb/storage/debug.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)
------

ChangeSet@1.889.26.16, 2003-01-12 23:01:32-08:00, cobra@compuserve.com
  [PATCH] Trivial USB doc patch
  
    David Brownell suggested I forward this to you.  I ran across it while
  trying to setup some USB debug info...

 Documentation/usb/proc_usb_info.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.889.26.15, 2003-01-12 00:21:36-08:00, greg@kroah.com
  [PATCH] USB: Fix from Jeff and Pete to keep khubd from being able to be killed by a signal

 drivers/usb/core/hub.c |    6 ++++++
 1 files changed, 6 insertions(+)
------

ChangeSet@1.889.26.14, 2003-01-12 00:18:09-08:00, oliver@oenone.homelinux.org
  [PATCH] USB xpad: fix URB leak in open error path
  
   - fix error path in open

 drivers/usb/input/xpad.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.889.26.13, 2003-01-12 00:17:49-08:00, oliver@oenone.homelinux.org
  [PATCH] USB audio: using GFP_KERNEL with a spinlock held
  
   - with a spinlock held GFP_ATOMIC must be used

 drivers/usb/class/audio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.889.26.12, 2003-01-12 00:17:30-08:00, greg@kroah.com
  [PATCH] USB midi: fix typo in previous patch

 drivers/usb/class/usb-midi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.889.26.11, 2003-01-12 00:17:10-08:00, oliver@oenone.homelinux.org
  [PATCH] USB midi fixes
  
      - correct write error path
      - use GFP_ATOMIC in interrupt

 drivers/usb/class/usb-midi.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.889.26.10, 2003-01-12 00:05:58-08:00, baldrick@wanadoo.fr
  [PATCH] remove duplicate spinlocks from speedtouch
  
    speedtouch: struct sk_buff_head has a spinlock built in, so no need for our own.

 drivers/usb/misc/speedtouch.c |   50 +++++++++---------------------------------
 1 files changed, 11 insertions(+), 39 deletions(-)
------

ChangeSet@1.889.26.9, 2003-01-12 00:03:35-08:00, greg@kroah.com
  [PATCH] USB: usb-skeleton MINOR_BASE change
  
  Mirrors a change made in the 2.4 version of the driver by Randy Dunlap.

 drivers/usb/usb-skeleton.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.889.26.8, 2003-01-11 23:57:23-08:00, greg@kroah.com
  [PATCH] USB bluetty: fix incorrect url in help text.

 drivers/usb/class/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.889.26.7, 2003-01-11 23:50:22-08:00, baldrick@wanadoo.fr
  [PATCH] remove redundant casts in speedtouch
  
    speedtouch: remove some redundant casts.

 drivers/usb/misc/speedtouch.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)
------

ChangeSet@1.889.26.6, 2003-01-11 23:49:44-08:00, baldrick@wanadoo.fr
  [PATCH] eliminate global minor array in speedtouch
  
  This is the mysterious masked patch I just sent, but with a name this time.
  
    speedtouch: get rid of the global minor_data array.  This means that there is now no
    limit to the number of devices that can be handled by the driver.

 drivers/usb/misc/speedtouch.c |   49 ++++++------------------------------------
 1 files changed, 8 insertions(+), 41 deletions(-)
------

ChangeSet@1.889.26.5, 2003-01-11 23:49:13-08:00, baldrick@wanadoo.fr
  [PATCH] get rid of speedtouch kernel thread
  
    speedtouch: remove the kernel thread and all the junk that went with it.
    The work it did can all be done in interrupt context, so use a tasklet instead.

 drivers/usb/misc/speedtouch.c |   79 +++---------------------------------------
 1 files changed, 7 insertions(+), 72 deletions(-)
------

ChangeSet@1.889.26.4, 2003-01-10 11:28:45-08:00, greg@kroah.com
  [PATCH] USB visor: Split up the initialization command logic to handle different device types better.

 drivers/usb/serial/visor.c |  234 ++++++++++++++++++++++++++++-----------------
 1 files changed, 147 insertions(+), 87 deletions(-)
------

ChangeSet@1.889.26.3, 2003-01-10 11:28:27-08:00, greg@kroah.com
  [PATCH] USB: visor driver, add the proper structure for the palm request 4 command

 drivers/usb/serial/visor.h |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletion(-)
------

ChangeSet@1.889.26.2, 2003-01-10 11:11:16-08:00, greg@kroah.com
  [PATCH] USB: Fix problem of sending the wrong device_id to the usb serial driver on probe()

 drivers/usb/serial/usb-serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.889.26.1, 2003-01-10 10:20:02-08:00, greg@kroah.com
  [PATCH] USB: fix error message when loading the digi_acceleport driver.

 drivers/usb/serial/digi_acceleport.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

