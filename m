Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264545AbTCZAn4>; Tue, 25 Mar 2003 19:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264546AbTCZAnz>; Tue, 25 Mar 2003 19:43:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9235 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264545AbTCZAnu>;
	Tue, 25 Mar 2003 19:43:50 -0500
Date: Tue, 25 Mar 2003 16:54:17 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.66
Message-ID: <20030326005417.GA19868@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small USB changes.  Basically all little cleanups and
bugfixes, nothing major.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 CREDITS                         |    4 
 MAINTAINERS                     |    5 
 drivers/usb/Makefile            |    1 
 drivers/usb/class/audio.c       |    1 
 drivers/usb/class/cdc-acm.c     |    2 
 drivers/usb/core/buffer.c       |    1 
 drivers/usb/core/hcd.c          |    9 
 drivers/usb/core/hub.c          |   56 +--
 drivers/usb/core/message.c      |    1 
 drivers/usb/core/usb-debug.c    |    1 
 drivers/usb/core/usb.c          |   13 
 drivers/usb/host/ohci-hcd.c     |    1 
 drivers/usb/image/mdc800.c      |    1 
 drivers/usb/media/ov511.c       |    1 
 drivers/usb/media/stv680.c      |    1 
 drivers/usb/misc/emi26.c        |   37 +-
 drivers/usb/misc/speedtch.c     |  646 ++++++++++++++++------------------------
 drivers/usb/misc/usbtest.c      |    7 
 drivers/usb/net/cdc-ether.c     |   19 -
 drivers/usb/serial/kobil_sct.c  |   17 -
 drivers/usb/storage/isd200.c    |    5 
 drivers/usb/storage/scsiglue.c  |   54 +--
 drivers/usb/storage/transport.c |    3 
 drivers/usb/storage/usb.c       |    6 
 drivers/usb/usb-skeleton.c      |    6 
 25 files changed, 385 insertions(+), 513 deletions(-)
-----

ChangeSet@1.985.10.21, 2003-03-25 15:16:26-08:00, greg@kroah.com
  USB: remove unneeded #include <linux/version.h>

 drivers/usb/class/audio.c    |    1 -
 drivers/usb/core/buffer.c    |    1 -
 drivers/usb/core/usb-debug.c |    1 -
 drivers/usb/host/ohci-hcd.c  |    1 -
 drivers/usb/image/mdc800.c   |    1 -
 drivers/usb/media/ov511.c    |    1 -
 drivers/usb/media/stv680.c   |    1 -
 7 files changed, 7 deletions(-)
------

ChangeSet@1.985.10.20, 2003-03-25 14:13:46-08:00, bhards@bigpond.net.au
  [PATCH] USB: CDC Ethernet maintainer transfer

 CREDITS     |    4 ++++
 MAINTAINERS |    5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)
------

ChangeSet@1.985.10.19, 2003-03-25 14:11:56-08:00, bhards@bigpond.net.au
  [PATCH] USB: CDC Ethernet zero packet fix

 drivers/usb/net/cdc-ether.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)
------

ChangeSet@1.985.10.18, 2003-03-25 13:59:05-08:00, greg@kroah.com
  [PATCH] USB: fix compiler warning in usb-storage

 drivers/usb/storage/scsiglue.c |    1 -
 1 files changed, 1 deletion(-)
------

ChangeSet@1.985.10.17, 2003-03-25 13:49:07-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: cleanup
  
  This patch changes some debugging output to be a bit more clear, and
  removes some un-needed code -- it's no longer possible for us to have
  active URBs in the disconnect path.

 drivers/usb/storage/usb.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)
------

ChangeSet@1.985.10.16, 2003-03-25 13:45:59-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: initialize urb status
  
  This patch initializes the URB status before it's used.  While not
  technically required, it's good programming practice (and a similar bug
  just bit us on 2.4 with UHCI).

 drivers/usb/storage/transport.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.985.10.15, 2003-03-25 13:45:34-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: LUN and isd200
  
  This patch (developed with assistance from Jan Harkes
  <jaharkes@cs.cmu.edu>) makes the LUN field of a bulk-only transport come
  from a known-good source, rather than the likely-good command-byte.  It
  also updates the ISD200 driver to work with this change.

 drivers/usb/storage/isd200.c    |    5 +++++
 drivers/usb/storage/transport.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.985.10.14, 2003-03-25 13:30:08-08:00, oliver@neukum.name
  [PATCH] USB: storage: add logging to reset
  
    - add logging to reset

 drivers/usb/storage/scsiglue.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)
------

ChangeSet@1.985.10.13, 2003-03-25 13:29:44-08:00, oliver@neukum.name
  [PATCH] USB: storage device reset cleanup
  
  > In the absence of far-reaching changes to the API, my suggestion is to
  > have the emulated SCSI bus reset code in usb-storage do nothing but log an
  > error message and return an error code.  For the time being, considering
  > how infrequently these resets occur, we can simply rely on the user
  > unplugging the USB cable and putting it back in or cycling the power to
  > the drive.  (Yes, there are situations where these resets crop up
  > regularly -- but they are the result of some other incompatibility that a
  > device reset won't fix anyway.)
  
  OK, as the consensus seems to be that in the short run changing things
  for a full reset implementation is not worth it, here's an implementation
  that does the best we can do without.
  It issues a reset only if we can be sure that there are no other users
  of the device in question.
  As the version currently in the storage driver is broken anyway,
  this is a definite improvement. And it addresses the need of exporting
  the probe/remove functions for storage's sake.

 drivers/usb/storage/scsiglue.c |   40 ++++++++++++++--------------------------
 1 files changed, 14 insertions(+), 26 deletions(-)
------

ChangeSet@1.985.10.12, 2003-03-25 13:23:01-08:00, oliver@neukum.name
  [PATCH] USB: Another memory allocation in block IO error handling path
  
    - memory allocation in block io error code path with GFP_KERNEL

 drivers/usb/core/hub.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.985.10.11, 2003-03-25 13:07:05-08:00, greg@kroah.com
  [PATCH] USB: fix Makefile to allow usb midi driver to be built if it's the only class driver selected.

 drivers/usb/Makefile |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.985.10.10, 2003-03-25 12:41:14-08:00, randy.dunlap@verizon.net
  [PATCH] USB: usb/misc/emi26.c stack reduction
  
  Reduces stack usage in emi26_load_firmware().

 drivers/usb/misc/emi26.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)
------

ChangeSet@1.985.10.9, 2003-03-25 12:40:48-08:00, oliver.spang@siemens.com
  [PATCH] USB: Compiler error in cdc-acm when DEBUG defined

 drivers/usb/class/cdc-acm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.985.10.8, 2003-03-25 11:54:38-08:00, joe@perches.com
  [PATCH] USB: usb_skeleton.c trivial fix
  
  Remove redundant __FILE__.

 drivers/usb/usb-skeleton.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.985.10.7, 2003-03-25 11:54:15-08:00, david-b@pacbell.net
  [PATCH] USB: usb-skeleton, usbtest use "real" device ids
  
  I'll be switching "gadget zero" to use real product IDs
  (donated by NetChip), and these are the two drivers that
  will need to recognize them.

 drivers/usb/misc/usbtest.c |    5 +++++
 drivers/usb/usb-skeleton.c |    4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)
------

ChangeSet@1.985.10.6, 2003-03-25 11:53:49-08:00, ink@jurassic.park.msu.ru
  [PATCH] USB: missing include
  
  at least Alpha needs mm.h for "page_address".

 drivers/usb/core/message.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.985.10.5, 2003-03-25 11:34:31-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: eliminate ATM open/close races
  
  The list of open vccs is modified by open/close, and traversed by the
  receive tasklet.  This is the last race I know of in this driver.

 drivers/usb/misc/speedtch.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)
------

ChangeSet@1.985.10.4, 2003-03-25 11:34:04-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: per vcc data cleanups
  
  Use struct list_head rather than a singly linked list in udsl_vcc_data.  Reject
  attempts to open multiple vccs with the same vpi/vci pair.  Some cleanups too.

 drivers/usb/misc/speedtch.c |  204 +++++++++++++++++++++-----------------------
 1 files changed, 98 insertions(+), 106 deletions(-)
------

ChangeSet@1.985.10.3, 2003-03-25 11:33:39-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: trivial cleanups

 drivers/usb/misc/speedtch.c |  110 ++++++++++++++++++++------------------------
 1 files changed, 51 insertions(+), 59 deletions(-)
------

ChangeSet@1.985.10.2, 2003-03-25 11:33:14-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: code reorganization
  
  Remove dead code from sarlib, reorganize live sarlib code (trivial transformations).

 drivers/usb/misc/speedtch.c |  312 ++++++++++++++------------------------------
 1 files changed, 100 insertions(+), 212 deletions(-)
------

ChangeSet@1.889.379.5, 2003-03-21 17:01:26-08:00, david-b@pacbell.net
  [PATCH] add missing usb_put_urb() after error
  
  This is a multi-part message in MIME format.

 drivers/usb/core/hcd.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)
------

ChangeSet@1.889.379.4, 2003-03-21 17:00:25-08:00, chris@wirex.com
  [PATCH] USB: potential dereference of user pointer errors in kobil_sct.c

 drivers/usb/serial/kobil_sct.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)
------

ChangeSet@1.889.379.3, 2003-03-21 12:54:21-08:00, david-b@pacbell.net
  [PATCH] usbtest catch -ENOMEM
  
  Smatch seems to be returning mostly false positives,
  but not this time.

 drivers/usb/misc/usbtest.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.889.379.2, 2003-03-21 12:53:59-08:00, david-b@pacbell.net
  [PATCH] usb hub diagnostics
  
  More uniformity-in-diagnostics work, and don't emit
  a error message in one known non-error case.

 drivers/usb/core/hub.c |   54 ++++++++++++++++++++++++++-----------------------
 1 files changed, 29 insertions(+), 25 deletions(-)
------

ChangeSet@1.889.379.1, 2003-03-21 12:53:36-08:00, david-b@pacbell.net
  [PATCH] usb_connect() kerneldoc
  
  previous text was wrong/confusing, all it does
  is pick a number.  this routine should be merged
  with usb_new_device() someday, but doing that
  would mean changing the hcds (as well as hub.c)
  so it's not worth it yet.

Push file://home/greg/linux/BK/gregkh-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/usb/core/usb.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)
------

