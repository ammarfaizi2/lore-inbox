Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSEWAwK>; Wed, 22 May 2002 20:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSEWAwJ>; Wed, 22 May 2002 20:52:09 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:13062 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315459AbSEWAwE>;
	Wed, 22 May 2002 20:52:04 -0400
Date: Wed, 22 May 2002 17:51:51 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB gadget support for 2.5.17
Message-ID: <20020523005151.GA6753@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, second try at the USB device/target/gadget/fish code :)

Pull from:  bk://linuxusb.bkbits.net/usbd-2.5


I've renamed the subdirectory to drivers/usb/gadget and fixed all of the
symbols and build issues involved in doing that.  I've also ripped out
almost all of the debug logic that used to be present in these drivers.
It was overkill, and implemented rather poorly (imho).

I've also cleaned up other places in the code where I noticed things were not
done sanely, but it's possible I have missed other portions of strangeness.
Any pointers to odd bits that people have questions about are greatly
appreciated.

The build process is a bit strange, but I need some help from Stuart
Lynne to change that, as it involves restructuring the gadget controller
code in some pretty serious ways.

I've included the whole change history of this code.  Linus if you want
just a clean changeset with the single patch on your latest tree, let me
know and I can do it.  If not, this repo is merged up to your latest
tree.

For those without bitkeeper a patch against 2.5.17 can be found at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.5/usb-gadget-2.5.17.patch.bz2


 drivers/usb/Config.in                    |    2 
 drivers/usb/Makefile                     |    4 
 drivers/usb/gadget/Config.help           |   80 +
 drivers/usb/gadget/Config.in             |   58 +
 drivers/usb/gadget/Makefile              |   53 
 drivers/usb/gadget/ep0.c                 |  676 ++++++++++++
 drivers/usb/gadget/gen/Config.in         |    7 
 drivers/usb/gadget/gen/Makefile          |   24 
 drivers/usb/gadget/gen/udc.c             |  598 ++++++++++
 drivers/usb/gadget/gen/udc.h             |   37 
 drivers/usb/gadget/l7205/Config.help     |    2 
 drivers/usb/gadget/l7205/Config.in       |    8 
 drivers/usb/gadget/l7205/Makefile        |   71 +
 drivers/usb/gadget/l7205/hardware.h      |  623 +++++++++++
 drivers/usb/gadget/l7205/l7205.h         |  179 +++
 drivers/usb/gadget/l7205/udc.c           | 1494 ++++++++++++++++++++++++++
 drivers/usb/gadget/l7205/udc.h           |   38 
 drivers/usb/gadget/net_fd/Config.help    |   83 +
 drivers/usb/gadget/net_fd/Config.in      |   45 
 drivers/usb/gadget/net_fd/Makefile       |   14 
 drivers/usb/gadget/net_fd/crc32.c        |   63 +
 drivers/usb/gadget/net_fd/crc32.h        |   77 +
 drivers/usb/gadget/net_fd/net-fd.c       | 1735 +++++++++++++++++++++++++++++++
 drivers/usb/gadget/net_fd/net-fd.h       |   30 
 drivers/usb/gadget/net_fd/netproto.c     | 1115 +++++++++++++++++++
 drivers/usb/gadget/net_fd/netproto.h     |  499 ++++++++
 drivers/usb/gadget/net_fd/rndis.c        |  152 ++
 drivers/usb/gadget/serial_fd/Config.help |   68 +
 drivers/usb/gadget/serial_fd/Config.in   |   29 
 drivers/usb/gadget/serial_fd/Makefile    |   14 
 drivers/usb/gadget/serial_fd/crc10.c     |   48 
 drivers/usb/gadget/serial_fd/crc10.h     |   83 +
 drivers/usb/gadget/serial_fd/serial.c    |  994 +++++++++++++++++
 drivers/usb/gadget/serial_fd/serproto.c  |  787 ++++++++++++++
 drivers/usb/gadget/serial_fd/serproto.h  |   42 
 drivers/usb/gadget/sl11/Config.help      |    6 
 drivers/usb/gadget/sl11/Config.in        |    7 
 drivers/usb/gadget/sl11/Makefile         |   73 +
 drivers/usb/gadget/sl11/sl11.h           |  222 +++
 drivers/usb/gadget/sl11/udc.c            | 1385 ++++++++++++++++++++++++
 drivers/usb/gadget/sl11/udc.h            |   37 
 drivers/usb/gadget/superh/Config.help    |    4 
 drivers/usb/gadget/superh/Config.in      |    7 
 drivers/usb/gadget/superh/Makefile       |   71 +
 drivers/usb/gadget/superh/hardware.h     |  173 +++
 drivers/usb/gadget/superh/lio.c          |   71 +
 drivers/usb/gadget/superh/udc.c          |  875 +++++++++++++++
 drivers/usb/gadget/superh/udc.h          |   37 
 drivers/usb/gadget/usb_gadget.c          | 1257 ++++++++++++++++++++++
 drivers/usb/gadget/usbd-arch.h           |  306 +++++
 drivers/usb/gadget/usbd-bi.c             | 1043 ++++++++++++++++++
 drivers/usb/gadget/usbd-bi.h             |  302 +++++
 drivers/usb/gadget/usbd-bus.c            |  532 +++++++++
 drivers/usb/gadget/usbd-bus.h            |   91 +
 drivers/usb/gadget/usbd-debug.c          |   76 +
 drivers/usb/gadget/usbd-debug.h          |   87 +
 drivers/usb/gadget/usbd-func.c           | 1077 +++++++++++++++++++
 drivers/usb/gadget/usbd-func.h           |  713 ++++++++++++
 drivers/usb/gadget/usbd-inline.h         |  475 ++++++++
 drivers/usb/gadget/usbd-module.h         |   58 +
 drivers/usb/gadget/usbd-monitor.c        |  780 +++++++++++++
 drivers/usb/gadget/usbd-serialnumber.c   |  214 +++
 drivers/usb/gadget/usbd.h                |  898 ++++++++++++++++
 63 files changed, 20708 insertions(+), 1 deletion(-)
------

ChangeSet@1.657, 2002-05-22 17:29:16-07:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/usbd-2.5

 drivers/usb/Makefile |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)
------

ChangeSet@1.529.1.6, 2002-05-22 17:18:51-07:00, greg@kroah.com
  USB Gadget debug interface removal
  
  	- USBD -> USB_GADGET name changes
  	- ripped out the debug table interface, as it was overkill.
  	- reformatted a bunch of the tables.

 drivers/usb/gadget/net_fd/net-fd.c      |  713 ++++++++++++++++----------------
 drivers/usb/gadget/net_fd/netproto.c    |   14 
 drivers/usb/gadget/net_fd/netproto.h    |    2 
 drivers/usb/gadget/net_fd/rndis.c       |   54 +-
 drivers/usb/gadget/serial_fd/serial.c   |  421 +++++++++---------
 drivers/usb/gadget/serial_fd/serproto.c |   28 -
 drivers/usb/gadget/serial_fd/serproto.h |    4 
 drivers/usb/gadget/usb_gadget.c         |   44 -
 drivers/usb/gadget/usbd-bi.c            |   34 -
 drivers/usb/gadget/usbd-debug.c         |  149 ------
 drivers/usb/gadget/usbd-debug.h         |   21 
 11 files changed, 630 insertions(+), 854 deletions(-)
------

ChangeSet@1.529.1.5, 2002-05-22 17:15:11-07:00, greg@kroah.com
  USB Gadget name changes
  
  USBD -> USB_GADGET CONFIG and #define name changes.

 drivers/usb/gadget/gen/udc.c           |    6 -
 drivers/usb/gadget/gen/udc.h           |    2 
 drivers/usb/gadget/l7205/udc.c         |    8 -
 drivers/usb/gadget/l7205/udc.h         |    2 
 drivers/usb/gadget/sl11/udc.c          |    2 
 drivers/usb/gadget/sl11/udc.h          |    2 
 drivers/usb/gadget/superh/udc.c        |    6 -
 drivers/usb/gadget/usbd-arch.h         |  176 ++++++++++++++++-----------------
 drivers/usb/gadget/usbd-bus.c          |   10 -
 drivers/usb/gadget/usbd-func.c         |    2 
 drivers/usb/gadget/usbd-inline.h       |   16 +--
 drivers/usb/gadget/usbd-module.h       |    4 
 drivers/usb/gadget/usbd-monitor.c      |   16 +--
 drivers/usb/gadget/usbd-serialnumber.c |    6 -
 drivers/usb/gadget/usbd.h              |    8 -
 15 files changed, 133 insertions(+), 133 deletions(-)
------

ChangeSet@1.529.1.4, 2002-05-22 17:12:04-07:00, greg@kroah.com
  USB Gadget Config and build changes
  
  changed CONFIG_USBD to CONFIG_USB_GADGET to reflect the directory change.

 drivers/usb/gadget/usbd.c                | 1285 -------------------------------
 drivers/usb/Makefile                     |    2 
 drivers/usb/gadget/Config.help           |   30 
 drivers/usb/gadget/Config.in             |   36 
 drivers/usb/gadget/Makefile              |   29 
 drivers/usb/gadget/gen/Config.in         |    2 
 drivers/usb/gadget/gen/Makefile          |    2 
 drivers/usb/gadget/l7205/Config.help     |    2 
 drivers/usb/gadget/l7205/Config.in       |    4 
 drivers/usb/gadget/l7205/Makefile        |    2 
 drivers/usb/gadget/net_fd/Config.help    |   34 
 drivers/usb/gadget/net_fd/Config.in      |   46 -
 drivers/usb/gadget/net_fd/Makefile       |    2 
 drivers/usb/gadget/serial_fd/Config.help |   26 
 drivers/usb/gadget/serial_fd/Config.in   |   30 
 drivers/usb/gadget/serial_fd/Makefile    |    2 
 drivers/usb/gadget/sl11/Config.help      |    2 
 drivers/usb/gadget/sl11/Config.in        |    2 
 drivers/usb/gadget/sl11/Makefile         |    2 
 drivers/usb/gadget/superh/Config.help    |    2 
 drivers/usb/gadget/superh/Config.in      |    2 
 drivers/usb/gadget/superh/Makefile       |    2 
 drivers/usb/gadget/usb_gadget.c          | 1285 +++++++++++++++++++++++++++++++
 23 files changed, 1417 insertions(+), 1414 deletions(-)
------

ChangeSet@1.529.1.3, 2002-05-10 09:04:33-07:00, greg@kroah.com
  Merge bk://linuxusb@bkbits.net/usbd-2.5
  into kroah.com:/home/greg/linux/BK/usbd-2.5

 drivers/usb/device/usbd-debug.c |  225 ----------------------------------------
 drivers/usb/device/usbd-debug.h |  104 ------------------
 drivers/usb/gadget/usbd-debug.c |  225 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/usbd-debug.h |  104 ++++++++++++++++++
 4 files changed, 329 insertions(+), 329 deletions(-)
------

ChangeSet@1.529.2.1, 2002-05-10 09:01:29-07:00, greg@kroah.com
  usbd debugging code cleanup. 

 drivers/usb/device/usbd-debug.c |   15 ++++++---------
 drivers/usb/device/usbd-debug.h |   13 ++++---------
 2 files changed, 10 insertions(+), 18 deletions(-)
------

ChangeSet@1.529.1.2, 2002-05-10 01:40:46-07:00, greg@kroah.com
  renamed drivers/usb/device/ to drivers/usb/gadget/

 drivers/usb/device/Config.help           |   76 -
 drivers/usb/device/Config.in             |   58 -
 drivers/usb/device/Makefile              |   52 
 drivers/usb/device/ep0.c                 |  676 ------------
 drivers/usb/device/gen/Config.in         |    7 
 drivers/usb/device/gen/Makefile          |   24 
 drivers/usb/device/gen/udc.c             |  598 ----------
 drivers/usb/device/gen/udc.h             |   37 
 drivers/usb/device/l7205/Config.help     |    2 
 drivers/usb/device/l7205/Config.in       |    8 
 drivers/usb/device/l7205/Makefile        |   71 -
 drivers/usb/device/l7205/hardware.h      |  623 -----------
 drivers/usb/device/l7205/l7205.h         |  179 ---
 drivers/usb/device/l7205/udc.c           | 1494 ---------------------------
 drivers/usb/device/l7205/udc.h           |   38 
 drivers/usb/device/net_fd/Config.help    |   83 -
 drivers/usb/device/net_fd/Config.in      |   45 
 drivers/usb/device/net_fd/Makefile       |   14 
 drivers/usb/device/net_fd/crc32.c        |   63 -
 drivers/usb/device/net_fd/crc32.h        |   77 -
 drivers/usb/device/net_fd/net-fd.c       | 1700 -------------------------------
 drivers/usb/device/net_fd/net-fd.h       |   30 
 drivers/usb/device/net_fd/netproto.c     | 1129 --------------------
 drivers/usb/device/net_fd/netproto.h     |  501 ---------
 drivers/usb/device/net_fd/rndis.c        |  148 --
 drivers/usb/device/serial_fd/Config.help |   68 -
 drivers/usb/device/serial_fd/Config.in   |   29 
 drivers/usb/device/serial_fd/Makefile    |   14 
 drivers/usb/device/serial_fd/crc10.c     |   48 
 drivers/usb/device/serial_fd/crc10.h     |   83 -
 drivers/usb/device/serial_fd/serial.c    |  997 ------------------
 drivers/usb/device/serial_fd/serproto.c  |  815 --------------
 drivers/usb/device/serial_fd/serproto.h  |   44 
 drivers/usb/device/sl11/Config.help      |    6 
 drivers/usb/device/sl11/Config.in        |    7 
 drivers/usb/device/sl11/Makefile         |   73 -
 drivers/usb/device/sl11/sl11.h           |  222 ----
 drivers/usb/device/sl11/udc.c            | 1385 -------------------------
 drivers/usb/device/sl11/udc.h            |   37 
 drivers/usb/device/superh/Config.help    |    4 
 drivers/usb/device/superh/Config.in      |    7 
 drivers/usb/device/superh/Makefile       |   71 -
 drivers/usb/device/superh/hardware.h     |  173 ---
 drivers/usb/device/superh/lio.c          |   71 -
 drivers/usb/device/superh/udc.c          |  875 ---------------
 drivers/usb/device/superh/udc.h          |   37 
 drivers/usb/device/usbd-arch.h           |  306 -----
 drivers/usb/device/usbd-bi.c             | 1063 -------------------
 drivers/usb/device/usbd-bi.h             |  302 -----
 drivers/usb/device/usbd-bus.c            |  532 ---------
 drivers/usb/device/usbd-bus.h            |   91 -
 drivers/usb/device/usbd-debug.c          |  228 ----
 drivers/usb/device/usbd-debug.h          |  109 -
 drivers/usb/device/usbd-func.c           | 1077 -------------------
 drivers/usb/device/usbd-func.h           |  713 -------------
 drivers/usb/device/usbd-inline.h         |  475 --------
 drivers/usb/device/usbd-module.h         |   58 -
 drivers/usb/device/usbd-monitor.c        |  780 --------------
 drivers/usb/device/usbd-serialnumber.c   |  214 ---
 drivers/usb/device/usbd.c                | 1285 -----------------------
 drivers/usb/device/usbd.h                |  898 ----------------
 drivers/usb/Config.in                    |    2 
 drivers/usb/Makefile                     |    4 
 drivers/usb/gadget/Config.help           |   76 +
 drivers/usb/gadget/Config.in             |   58 +
 drivers/usb/gadget/Makefile              |   54 
 drivers/usb/gadget/ep0.c                 |  676 ++++++++++++
 drivers/usb/gadget/gen/Config.in         |    7 
 drivers/usb/gadget/gen/Makefile          |   24 
 drivers/usb/gadget/gen/udc.c             |  598 ++++++++++
 drivers/usb/gadget/gen/udc.h             |   37 
 drivers/usb/gadget/l7205/Config.help     |    2 
 drivers/usb/gadget/l7205/Config.in       |    8 
 drivers/usb/gadget/l7205/Makefile        |   71 +
 drivers/usb/gadget/l7205/hardware.h      |  623 +++++++++++
 drivers/usb/gadget/l7205/l7205.h         |  179 +++
 drivers/usb/gadget/l7205/udc.c           | 1494 +++++++++++++++++++++++++++
 drivers/usb/gadget/l7205/udc.h           |   38 
 drivers/usb/gadget/net_fd/Config.help    |   83 +
 drivers/usb/gadget/net_fd/Config.in      |   45 
 drivers/usb/gadget/net_fd/Makefile       |   14 
 drivers/usb/gadget/net_fd/crc32.c        |   63 +
 drivers/usb/gadget/net_fd/crc32.h        |   77 +
 drivers/usb/gadget/net_fd/net-fd.c       | 1700 +++++++++++++++++++++++++++++++
 drivers/usb/gadget/net_fd/net-fd.h       |   30 
 drivers/usb/gadget/net_fd/netproto.c     | 1129 ++++++++++++++++++++
 drivers/usb/gadget/net_fd/netproto.h     |  501 +++++++++
 drivers/usb/gadget/net_fd/rndis.c        |  148 ++
 drivers/usb/gadget/serial_fd/Config.help |   68 +
 drivers/usb/gadget/serial_fd/Config.in   |   29 
 drivers/usb/gadget/serial_fd/Makefile    |   14 
 drivers/usb/gadget/serial_fd/crc10.c     |   48 
 drivers/usb/gadget/serial_fd/crc10.h     |   83 +
 drivers/usb/gadget/serial_fd/serial.c    |  997 ++++++++++++++++++
 drivers/usb/gadget/serial_fd/serproto.c  |  815 ++++++++++++++
 drivers/usb/gadget/serial_fd/serproto.h  |   44 
 drivers/usb/gadget/sl11/Config.help      |    6 
 drivers/usb/gadget/sl11/Config.in        |    7 
 drivers/usb/gadget/sl11/Makefile         |   73 +
 drivers/usb/gadget/sl11/sl11.h           |  222 ++++
 drivers/usb/gadget/sl11/udc.c            | 1385 +++++++++++++++++++++++++
 drivers/usb/gadget/sl11/udc.h            |   37 
 drivers/usb/gadget/superh/Config.help    |    4 
 drivers/usb/gadget/superh/Config.in      |    7 
 drivers/usb/gadget/superh/Makefile       |   71 +
 drivers/usb/gadget/superh/hardware.h     |  173 +++
 drivers/usb/gadget/superh/lio.c          |   71 +
 drivers/usb/gadget/superh/udc.c          |  875 +++++++++++++++
 drivers/usb/gadget/superh/udc.h          |   37 
 drivers/usb/gadget/usbd-arch.h           |  306 +++++
 drivers/usb/gadget/usbd-bi.c             | 1063 +++++++++++++++++++
 drivers/usb/gadget/usbd-bi.h             |  302 +++++
 drivers/usb/gadget/usbd-bus.c            |  532 +++++++++
 drivers/usb/gadget/usbd-bus.h            |   91 +
 drivers/usb/gadget/usbd-debug.c          |  228 ++++
 drivers/usb/gadget/usbd-debug.h          |  109 +
 drivers/usb/gadget/usbd-func.c           | 1077 +++++++++++++++++++
 drivers/usb/gadget/usbd-func.h           |  713 +++++++++++++
 drivers/usb/gadget/usbd-inline.h         |  475 ++++++++
 drivers/usb/gadget/usbd-module.h         |   58 +
 drivers/usb/gadget/usbd-monitor.c        |  780 ++++++++++++++
 drivers/usb/gadget/usbd-serialnumber.c   |  214 +++
 drivers/usb/gadget/usbd.c                | 1285 +++++++++++++++++++++++
 drivers/usb/gadget/usbd.h                |  898 ++++++++++++++++
 124 files changed, 20936 insertions(+), 20932 deletions(-)
------

ChangeSet@1.529.1.1, 2002-05-09 17:46:12-07:00, greg@kroah.com
  merge

 drivers/usb/Config.in |    2 ++
 drivers/usb/Makefile  |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.447.19.11, 2002-04-19 17:35:21-07:00, greg@kroah.com
  USB gadget code
  
  removed the urb_link typedef
  removed the urb_send_status_t typedef

 drivers/usb/device/usbd-inline.h |   22 +++++++++++-----------
 drivers/usb/device/usbd.h        |   10 +++++-----
 2 files changed, 16 insertions(+), 16 deletions(-)
------

ChangeSet@1.447.19.10, 2002-04-17 17:15:10-07:00, greg@kroah.com
  USB gadget
  
  	- moved the crc* files around and deleted the unused ones.
  	- cleaned up the serial_fd code a bunch (now compiles cleanly)
  	- removed unneeded code from usbd-func.c

 drivers/usb/device/crc10.c              |   48 ------------------
 drivers/usb/device/crc10.h              |   83 --------------------------------
 drivers/usb/device/crc16.c              |   65 -------------------------
 drivers/usb/device/crc16.h              |   78 ------------------------------
 drivers/usb/device/crc32.c              |   63 ------------------------
 drivers/usb/device/crc32.h              |   77 -----------------------------
 drivers/usb/device/crc8.c               |   63 ------------------------
 drivers/usb/device/crc8.h               |   80 ------------------------------
 drivers/usb/device/net_fd/Makefile      |    2 
 drivers/usb/device/net_fd/crc32.c       |   63 ++++++++++++++++++++++++
 drivers/usb/device/net_fd/crc32.h       |   77 +++++++++++++++++++++++++++++
 drivers/usb/device/net_fd/net-fd.c      |    3 -
 drivers/usb/device/serial_fd/Makefile   |   51 +------------------
 drivers/usb/device/serial_fd/crc10.c    |   48 ++++++++++++++++++
 drivers/usb/device/serial_fd/crc10.h    |   83 ++++++++++++++++++++++++++++++++
 drivers/usb/device/serial_fd/serial.c   |   13 ++---
 drivers/usb/device/serial_fd/serproto.c |    9 ++-
 drivers/usb/device/usbd-func.c          |   41 +++------------
 18 files changed, 299 insertions(+), 648 deletions(-)
------

ChangeSet@1.447.19.9, 2002-04-17 14:58:05-07:00, greg@kroah.com
  USB gadget sl11 driver
  
  fixed compiler warning.

 drivers/usb/device/sl11/udc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.447.19.8, 2002-04-17 14:47:36-07:00, greg@kroah.com
  USB gadget
  
  allowed the usbd-monitor and usbd-serialnumber files to be built.
  cleaned up the global namespace a bit.

 drivers/usb/device/Makefile       |    2 ++
 drivers/usb/device/usbd-monitor.c |   32 ++++++++++++++++----------------
 drivers/usb/device/usbd.c         |   12 +-----------
 3 files changed, 19 insertions(+), 27 deletions(-)
------

ChangeSet@1.447.19.7, 2002-04-17 14:32:01-07:00, greg@kroah.com
  USB gadget
  
  usbd-debug:
  	added needed header file
  	removed duplicate functions (now calls the kernel str functions.)

 drivers/usb/device/usbd-debug.c |   67 ++++++++++------------------------------
 drivers/usb/device/usbd-debug.h |   21 +++++-------
 2 files changed, 26 insertions(+), 62 deletions(-)
------

ChangeSet@1.447.19.5, 2002-04-17 12:57:50-07:00, greg@kroah.com
  USB gadget drivers
  
  moved the target drivers out of the 'bi' subdirectory.

 drivers/usb/device/bi/Config.in          |   26 
 drivers/usb/device/bi/Makefile           |   31 
 drivers/usb/device/bi/gen/Config.in      |    7 
 drivers/usb/device/bi/gen/Makefile       |   24 
 drivers/usb/device/bi/gen/udc.c          |  600 ------------
 drivers/usb/device/bi/gen/udc.h          |   37 
 drivers/usb/device/bi/l7205/Config.help  |    2 
 drivers/usb/device/bi/l7205/Config.in    |    8 
 drivers/usb/device/bi/l7205/Makefile     |   71 -
 drivers/usb/device/bi/l7205/hardware.h   |  623 ------------
 drivers/usb/device/bi/l7205/l7205.h      |  179 ---
 drivers/usb/device/bi/l7205/udc.c        | 1494 -------------------------------
 drivers/usb/device/bi/l7205/udc.h        |   38 
 drivers/usb/device/bi/sl11/Config.help   |    6 
 drivers/usb/device/bi/sl11/Config.in     |    7 
 drivers/usb/device/bi/sl11/Makefile      |   73 -
 drivers/usb/device/bi/sl11/sl11.h        |  222 ----
 drivers/usb/device/bi/sl11/udc.c         | 1387 ----------------------------
 drivers/usb/device/bi/sl11/udc.h         |   37 
 drivers/usb/device/bi/superh/Config.help |    4 
 drivers/usb/device/bi/superh/Config.in   |    7 
 drivers/usb/device/bi/superh/Makefile    |   71 -
 drivers/usb/device/bi/superh/hardware.h  |  173 ---
 drivers/usb/device/bi/superh/lio.c       |   71 -
 drivers/usb/device/bi/superh/udc.c       |  877 ------------------
 drivers/usb/device/bi/superh/udc.h       |   37 
 drivers/usb/device/bi/usbd-bi.c          | 1063 ----------------------
 drivers/usb/device/bi/usbd-bi.h          |  302 ------
 drivers/usb/device/Config.in             |   22 
 drivers/usb/device/Makefile              |   21 
 drivers/usb/device/gen/Config.in         |    7 
 drivers/usb/device/gen/Makefile          |   24 
 drivers/usb/device/gen/udc.c             |  600 ++++++++++++
 drivers/usb/device/gen/udc.h             |   37 
 drivers/usb/device/l7205/Config.help     |    2 
 drivers/usb/device/l7205/Config.in       |    8 
 drivers/usb/device/l7205/Makefile        |   71 +
 drivers/usb/device/l7205/hardware.h      |  623 ++++++++++++
 drivers/usb/device/l7205/l7205.h         |  179 +++
 drivers/usb/device/l7205/udc.c           | 1494 +++++++++++++++++++++++++++++++
 drivers/usb/device/l7205/udc.h           |   38 
 drivers/usb/device/sl11/Config.help      |    6 
 drivers/usb/device/sl11/Config.in        |    7 
 drivers/usb/device/sl11/Makefile         |   73 +
 drivers/usb/device/sl11/sl11.h           |  222 ++++
 drivers/usb/device/sl11/udc.c            | 1387 ++++++++++++++++++++++++++++
 drivers/usb/device/sl11/udc.h            |   37 
 drivers/usb/device/superh/Config.help    |    4 
 drivers/usb/device/superh/Config.in      |    7 
 drivers/usb/device/superh/Makefile       |   71 +
 drivers/usb/device/superh/hardware.h     |  173 +++
 drivers/usb/device/superh/lio.c          |   71 +
 drivers/usb/device/superh/udc.c          |  877 ++++++++++++++++++
 drivers/usb/device/superh/udc.h          |   37 
 drivers/usb/device/usbd-bi.c             | 1063 ++++++++++++++++++++++
 drivers/usb/device/usbd-bi.h             |  302 ++++++
 56 files changed, 7445 insertions(+), 7495 deletions(-)
------

ChangeSet@1.447.19.4, 2002-04-16 17:56:53-07:00, greg@kroah.com
  USB devices
  
  Deleted the SA1100 code due to conflicting code in the ARM tree.

 drivers/usb/device/bi/sa1100/Config.help         |   11 
 drivers/usb/device/bi/sa1100/Config.in           |   13 
 drivers/usb/device/bi/sa1100/Makefile            |   77 -
 drivers/usb/device/bi/sa1100/ctl.h               |  320 ------
 drivers/usb/device/bi/sa1100/dma-sa1100.c        |  270 -----
 drivers/usb/device/bi/sa1100/dma.h               |   64 -
 drivers/usb/device/bi/sa1100/ep0.c               |  522 ----------
 drivers/usb/device/bi/sa1100/recv.c              |  379 -------
 drivers/usb/device/bi/sa1100/sa1100-dma-inline.h |  144 ---
 drivers/usb/device/bi/sa1100/sa1100.h            |  198 ----
 drivers/usb/device/bi/sa1100/send.c              |  282 -----
 drivers/usb/device/bi/sa1100/tick.c              |  200 ----
 drivers/usb/device/bi/sa1100/udc.c               | 1096 -----------------------
 drivers/usb/device/bi/sa1100/udc.h               |   38 
 drivers/usb/device/bi/Config.in                  |    5 
 drivers/usb/device/bi/Makefile                   |    1 
 16 files changed, 3620 deletions(-)
------

ChangeSet@1.447.19.3, 2002-04-16 14:15:02-07:00, greg@kroah.com
  USB device code
  
  	- cleaned up the Makefiles
  	- removed hotplug.c and hotplug.h
  	- added MODULE_LICENSE() for some of the modules
  	- fixed a few compiler errors and warnings.

 drivers/usb/device/hotplug.c           |   92 ---------------------------------
 drivers/usb/device/hotplug.h           |   28 ----------
 drivers/usb/device/Makefile            |   69 +++---------------------
 drivers/usb/device/bi/Makefile         |   59 ++-------------------
 drivers/usb/device/bi/gen/Makefile     |   48 -----------------
 drivers/usb/device/bi/gen/udc.c        |   16 ++---
 drivers/usb/device/bi/gen/udc.h        |    2 
 drivers/usb/device/net_fd/Makefile     |   46 ----------------
 drivers/usb/device/net_fd/net-fd.c     |    1 
 drivers/usb/device/usbd-monitor.c      |   22 ++++---
 drivers/usb/device/usbd-serialnumber.c |   16 ++---
 drivers/usb/device/usbd.c              |   53 +++++++++++++------
 drivers/usb/device/usbd.h              |   12 ++--
 13 files changed, 89 insertions(+), 375 deletions(-)
------

ChangeSet@1.447.5.16, 2002-04-15 10:37:22-07:00, sl@lineo.com
  [PATCH] remove reference to current->nice
  
  USB device minor change
  
  remove reference to current->nice

 drivers/usb/device/bi/usbd-bi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.447.5.15, 2002-04-15 10:36:43-07:00, greg@kroah.com
  USB devices
  
  added the device tree to the build process.

 drivers/usb/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.447.5.14, 2002-04-12 14:17:31-07:00, greg@kroah.com
  USB device
  
  Added Config.help entries for the USB device configure items.

 drivers/usb/device/Config.help           |   76 ++++++++++++++++++++++++++++
 drivers/usb/device/bi/l7205/Config.help  |    2 
 drivers/usb/device/bi/sa1100/Config.help |   11 ++++
 drivers/usb/device/bi/sl11/Config.help   |    6 ++
 drivers/usb/device/bi/superh/Config.help |    4 +
 drivers/usb/device/net_fd/Config.help    |   83 +++++++++++++++++++++++++++++++
 drivers/usb/device/serial_fd/Config.help |   68 +++++++++++++++++++++++++
 7 files changed, 250 insertions(+)
------

ChangeSet@1.447.5.13, 2002-04-12 14:02:52-07:00, greg@kroah.com
  USB devices
  
  fixed up some Config.in problems.

 drivers/usb/device/Config.in |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.447.5.11, 2002-04-11 16:54:12-07:00, greg@kroah.com
  USB device
  
  removed some files accidentally checked in.

 drivers/usb/device/bi/l7205/save/ctl.c       | 1598 ---------------------------
 drivers/usb/device/bi/l7205/save/ctl.h       |  305 -----
 drivers/usb/device/bi/l7205/save/recv.c      |  181 ---
 drivers/usb/device/bi/l7205/save/send.c      |  259 ----
 drivers/usb/device/bi/sa1100/PATCH-NOCALYPSO |   47 
 5 files changed, 2390 deletions(-)
------

ChangeSet@1.447.5.10, 2002-04-11 16:43:19-07:00, greg@kroah.com
  USB device code
  
  ran Lindent on the code

 drivers/usb/device/moduse.c                      |   16 
 drivers/usb/device/test10.c                      |  150 -
 drivers/usb/device/test8.c                       |   71 
 drivers/usb/device/usbd-build.h                  |    1 
 drivers/usb/device/usbd-export.h                 |    1 
 drivers/usb/device/bi/gen/udc.c                  |  321 +--
 drivers/usb/device/bi/gen/udc.h                  |    2 
 drivers/usb/device/bi/l7205/l7205.h              |   72 
 drivers/usb/device/bi/l7205/udc.c                | 1916 ++++++++++----------
 drivers/usb/device/bi/l7205/udc.h                |    2 
 drivers/usb/device/bi/sa1100/ctl.h               |   95 -
 drivers/usb/device/bi/sa1100/dma-sa1100.c        |  291 +--
 drivers/usb/device/bi/sa1100/dma.h               |   15 
 drivers/usb/device/bi/sa1100/ep0.c               |  691 +++----
 drivers/usb/device/bi/sa1100/recv.c              |  502 ++---
 drivers/usb/device/bi/sa1100/sa1100-dma-inline.h |  121 -
 drivers/usb/device/bi/sa1100/sa1100.h            |   79 
 drivers/usb/device/bi/sa1100/send.c              |  321 +--
 drivers/usb/device/bi/sa1100/tick.c              |  165 -
 drivers/usb/device/bi/sa1100/udc.c               | 1069 +++++------
 drivers/usb/device/bi/sa1100/udc.h               |    5 
 drivers/usb/device/bi/sl11/sl11.h                |   37 
 drivers/usb/device/bi/sl11/udc.c                 | 1460 +++++++--------
 drivers/usb/device/bi/sl11/udc.h                 |    5 
 drivers/usb/device/bi/superh/hardware.h          |    2 
 drivers/usb/device/bi/superh/lio.c               |   60 
 drivers/usb/device/bi/superh/udc.c               |  861 ++++-----
 drivers/usb/device/bi/superh/udc.h               |    4 
 drivers/usb/device/bi/usbd-bi.c                  | 1378 +++++++-------
 drivers/usb/device/bi/usbd-bi.h                  |   71 
 drivers/usb/device/crc10.c                       |   36 
 drivers/usb/device/crc10.h                       |   41 
 drivers/usb/device/crc16.c                       |   66 
 drivers/usb/device/crc16.h                       |   31 
 drivers/usb/device/crc32.c                       |   65 
 drivers/usb/device/crc32.h                       |   32 
 drivers/usb/device/crc8.c                        |   67 
 drivers/usb/device/crc8.h                        |   31 
 drivers/usb/device/ep0.c                         |  946 +++++-----
 drivers/usb/device/hotplug.c                     |   54 
 drivers/usb/device/hotplug.h                     |    4 
 drivers/usb/device/net_fd/net-fd.c               | 2150 +++++++++++------------
 drivers/usb/device/net_fd/netproto.c             | 1213 ++++++------
 drivers/usb/device/net_fd/netproto.h             |  363 +--
 drivers/usb/device/net_fd/rndis.c                |   79 
 drivers/usb/device/serial_fd/serial.c            | 1158 ++++++------
 drivers/usb/device/serial_fd/serproto.c          | 1120 +++++------
 drivers/usb/device/serial_fd/serproto.h          |   21 
 drivers/usb/device/usbd-bus.c                    |  661 +++----
 drivers/usb/device/usbd-bus.h                    |   23 
 drivers/usb/device/usbd-debug.c                  |  477 ++---
 drivers/usb/device/usbd-debug.h                  |   21 
 drivers/usb/device/usbd-func.c                   | 1621 ++++++++---------
 drivers/usb/device/usbd-func.h                   |  732 +++----
 drivers/usb/device/usbd-inline.h                 |  525 ++---
 drivers/usb/device/usbd-monitor.c                |  876 ++++-----
 drivers/usb/device/usbd-serialnumber.c           |  140 -
 drivers/usb/device/usbd.c                        | 1626 ++++++++---------
 drivers/usb/device/usbd.h                        |  401 ++--
 59 files changed, 11957 insertions(+), 12407 deletions(-)
------

ChangeSet@1.447.5.9, 2002-04-11 15:31:48-07:00, sl@lineo.com
  USB device controller
  
  Added initial USB device controller support.

 drivers/usb/Config.in                            |    2 
 drivers/usb/device/Config.in                     |   46 
 drivers/usb/device/Makefile                      |  131 +
 drivers/usb/device/bi/Config.in                  |   37 
 drivers/usb/device/bi/Makefile                   |   79 +
 drivers/usb/device/bi/gen/Config.in              |   13 
 drivers/usb/device/bi/gen/Makefile               |   72 
 drivers/usb/device/bi/gen/udc.c                  |  597 ++++++++
 drivers/usb/device/bi/gen/udc.h                  |   37 
 drivers/usb/device/bi/l7205/Config.in            |   14 
 drivers/usb/device/bi/l7205/Makefile             |   71 
 drivers/usb/device/bi/l7205/hardware.h           |  623 ++++++++
 drivers/usb/device/bi/l7205/l7205.h              |  179 ++
 drivers/usb/device/bi/l7205/save/ctl.c           | 1598 +++++++++++++++++++++
 drivers/usb/device/bi/l7205/save/ctl.h           |  305 ++++
 drivers/usb/device/bi/l7205/save/recv.c          |  181 ++
 drivers/usb/device/bi/l7205/save/send.c          |  259 +++
 drivers/usb/device/bi/l7205/udc.c                | 1472 ++++++++++++++++++++
 drivers/usb/device/bi/l7205/udc.h                |   38 
 drivers/usb/device/bi/sa1100/Config.in           |   23 
 drivers/usb/device/bi/sa1100/Makefile            |   77 +
 drivers/usb/device/bi/sa1100/PATCH-NOCALYPSO     |   89 +
 drivers/usb/device/bi/sa1100/ctl.h               |  325 ++++
 drivers/usb/device/bi/sa1100/dma-sa1100.c        |  271 +++
 drivers/usb/device/bi/sa1100/dma.h               |   65 
 drivers/usb/device/bi/sa1100/ep0.c               |  533 +++++++
 drivers/usb/device/bi/sa1100/recv.c              |  369 +++++
 drivers/usb/device/bi/sa1100/sa1100-dma-inline.h |  145 +
 drivers/usb/device/bi/sa1100/sa1100.h            |  199 ++
 drivers/usb/device/bi/sa1100/send.c              |  281 +++
 drivers/usb/device/bi/sa1100/tick.c              |  213 ++
 drivers/usb/device/bi/sa1100/udc.c               | 1081 ++++++++++++++
 drivers/usb/device/bi/sa1100/udc.h               |   41 
 drivers/usb/device/bi/sl11/Config.in             |   12 
 drivers/usb/device/bi/sl11/Makefile              |   73 
 drivers/usb/device/bi/sl11/sl11.h                |  223 +++
 drivers/usb/device/bi/sl11/udc.c                 | 1395 +++++++++++++++++++
 drivers/usb/device/bi/sl11/udc.h                 |   38 
 drivers/usb/device/bi/superh/Config.in           |   12 
 drivers/usb/device/bi/superh/Makefile            |   71 
 drivers/usb/device/bi/superh/hardware.h          |  175 ++
 drivers/usb/device/bi/superh/lio.c               |   71 
 drivers/usb/device/bi/superh/udc.c               |  870 +++++++++++
 drivers/usb/device/bi/superh/udc.h               |   37 
 drivers/usb/device/bi/usbd-bi.c                  | 1065 ++++++++++++++
 drivers/usb/device/bi/usbd-bi.h                  |  301 ++++
 drivers/usb/device/crc10.c                       |   52 
 drivers/usb/device/crc10.h                       |   86 +
 drivers/usb/device/crc16.c                       |   67 
 drivers/usb/device/crc16.h                       |   81 +
 drivers/usb/device/crc32.c                       |   64 
 drivers/usb/device/crc32.h                       |   81 +
 drivers/usb/device/crc8.c                        |   66 
 drivers/usb/device/crc8.h                        |   83 +
 drivers/usb/device/ep0.c                         |  648 ++++++++
 drivers/usb/device/hotplug.c                     |   94 +
 drivers/usb/device/hotplug.h                     |   30 
 drivers/usb/device/moduse.c                      |   16 
 drivers/usb/device/net_fd/Config.in              |   59 
 drivers/usb/device/net_fd/Makefile               |   58 
 drivers/usb/device/net_fd/net-fd.c               | 1682 +++++++++++++++++++++++
 drivers/usb/device/net_fd/net-fd.h               |   30 
 drivers/usb/device/net_fd/netproto.c             | 1132 +++++++++++++++
 drivers/usb/device/net_fd/netproto.h             |  504 ++++++
 drivers/usb/device/net_fd/rndis.c                |  147 ++
 drivers/usb/device/serial_fd/Config.in           |   44 
 drivers/usb/device/serial_fd/Makefile            |   59 
 drivers/usb/device/serial_fd/serial.c            |  982 +++++++++++++
 drivers/usb/device/serial_fd/serproto.c          |  832 +++++++++++
 drivers/usb/device/serial_fd/serproto.h          |   43 
 drivers/usb/device/test10.c                      |  150 ++
 drivers/usb/device/test8.c                       |   71 
 drivers/usb/device/usbd-arch.h                   |  306 ++++
 drivers/usb/device/usbd-build.h                  |    1 
 drivers/usb/device/usbd-bus.c                    |  523 +++++++
 drivers/usb/device/usbd-bus.h                    |   92 +
 drivers/usb/device/usbd-debug.c                  |  278 +++
 drivers/usb/device/usbd-debug.h                  |  117 +
 drivers/usb/device/usbd-export.h                 |    1 
 drivers/usb/device/usbd-func.c                   | 1205 ++++++++++++++++
 drivers/usb/device/usbd-func.h                   |  713 +++++++++
 drivers/usb/device/usbd-inline.h                 |  488 ++++++
 drivers/usb/device/usbd-module.h                 |   60 
 drivers/usb/device/usbd-monitor.c                |  796 ++++++++++
 drivers/usb/device/usbd-serialnumber.c           |  218 ++
 drivers/usb/device/usbd.c                        | 1348 ++++++++++++++++++
 drivers/usb/device/usbd.h                        |  911 ++++++++++++
 87 files changed, 28027 insertions(+)
------

