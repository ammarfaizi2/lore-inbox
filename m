Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313935AbSDPWyk>; Tue, 16 Apr 2002 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313936AbSDPWyj>; Tue, 16 Apr 2002 18:54:39 -0400
Received: from granite.he.net ([216.218.226.66]:14096 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S313935AbSDPWyg>;
	Tue, 16 Apr 2002 18:54:36 -0400
Date: Tue, 16 Apr 2002 15:54:33 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB device support for 2.5.8
Message-ID: <20020416155433.A11902@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These changesets add USB device support to the kernel.  It is the Lineo
code cleaned up a bit and dropped into the drivers/usb/device/
directory.  Over time, the code will migrate into other usb directories
as the core of the device and host code merge together.  This release
provides a version that builds properly, and provides a good base for
people to start working with.

Thanks to Stuart Lynne from Lineo for releasing this code and working to
have it included in the tree.

Pull from:  bk://linuxusb.bkbits.net/usbd-2.5

 drivers/usb/Config.in                            |    2 
 drivers/usb/Makefile                             |    7 
 drivers/usb/device/Config.help                   |   76 +
 drivers/usb/device/Config.in                     |   42 
 drivers/usb/device/Makefile                      |   84 +
 drivers/usb/device/bi/Config.in                  |   31 
 drivers/usb/device/bi/Makefile                   |   32 
 drivers/usb/device/bi/gen/Config.in              |    7 
 drivers/usb/device/bi/gen/Makefile               |   24 
 drivers/usb/device/bi/gen/udc.c                  |  600 ++++++++
 drivers/usb/device/bi/gen/udc.h                  |   37 
 drivers/usb/device/bi/l7205/Config.help          |    2 
 drivers/usb/device/bi/l7205/Config.in            |    8 
 drivers/usb/device/bi/l7205/Makefile             |   71 
 drivers/usb/device/bi/l7205/hardware.h           |  623 ++++++++
 drivers/usb/device/bi/l7205/l7205.h              |  179 ++
 drivers/usb/device/bi/l7205/udc.c                | 1494 ++++++++++++++++++++
 drivers/usb/device/bi/l7205/udc.h                |   38 
 drivers/usb/device/bi/sa1100/Config.help         |   11 
 drivers/usb/device/bi/sa1100/Config.in           |   13 
 drivers/usb/device/bi/sa1100/Makefile            |   77 +
 drivers/usb/device/bi/sa1100/ctl.h               |  320 ++++
 drivers/usb/device/bi/sa1100/dma-sa1100.c        |  270 +++
 drivers/usb/device/bi/sa1100/dma.h               |   64 
 drivers/usb/device/bi/sa1100/ep0.c               |  522 +++++++
 drivers/usb/device/bi/sa1100/recv.c              |  379 +++++
 drivers/usb/device/bi/sa1100/sa1100-dma-inline.h |  144 +
 drivers/usb/device/bi/sa1100/sa1100.h            |  198 ++
 drivers/usb/device/bi/sa1100/send.c              |  282 +++
 drivers/usb/device/bi/sa1100/tick.c              |  200 ++
 drivers/usb/device/bi/sa1100/udc.c               | 1096 ++++++++++++++
 drivers/usb/device/bi/sa1100/udc.h               |   38 
 drivers/usb/device/bi/sl11/Config.help           |    6 
 drivers/usb/device/bi/sl11/Config.in             |    7 
 drivers/usb/device/bi/sl11/Makefile              |   73 
 drivers/usb/device/bi/sl11/sl11.h                |  222 +++
 drivers/usb/device/bi/sl11/udc.c                 | 1387 ++++++++++++++++++
 drivers/usb/device/bi/sl11/udc.h                 |   37 
 drivers/usb/device/bi/superh/Config.help         |    4 
 drivers/usb/device/bi/superh/Config.in           |    7 
 drivers/usb/device/bi/superh/Makefile            |   71 
 drivers/usb/device/bi/superh/hardware.h          |  173 ++
 drivers/usb/device/bi/superh/lio.c               |   71 
 drivers/usb/device/bi/superh/udc.c               |  877 +++++++++++
 drivers/usb/device/bi/superh/udc.h               |   37 
 drivers/usb/device/bi/usbd-bi.c                  | 1063 ++++++++++++++
 drivers/usb/device/bi/usbd-bi.h                  |  302 ++++
 drivers/usb/device/crc10.c                       |   48 
 drivers/usb/device/crc10.h                       |   83 +
 drivers/usb/device/crc16.c                       |   65 
 drivers/usb/device/crc16.h                       |   78 +
 drivers/usb/device/crc32.c                       |   63 
 drivers/usb/device/crc32.h                       |   77 +
 drivers/usb/device/crc8.c                        |   63 
 drivers/usb/device/crc8.h                        |   80 +
 drivers/usb/device/ep0.c                         |  676 +++++++++
 drivers/usb/device/net_fd/Config.help            |   83 +
 drivers/usb/device/net_fd/Config.in              |   45 
 drivers/usb/device/net_fd/Makefile               |   14 
 drivers/usb/device/net_fd/net-fd.c               | 1701 +++++++++++++++++++++++
 drivers/usb/device/net_fd/net-fd.h               |   30 
 drivers/usb/device/net_fd/netproto.c             | 1129 +++++++++++++++
 drivers/usb/device/net_fd/netproto.h             |  501 ++++++
 drivers/usb/device/net_fd/rndis.c                |  148 ++
 drivers/usb/device/serial_fd/Config.help         |   68 
 drivers/usb/device/serial_fd/Config.in           |   29 
 drivers/usb/device/serial_fd/Makefile            |   59 
 drivers/usb/device/serial_fd/serial.c            |  998 +++++++++++++
 drivers/usb/device/serial_fd/serproto.c          |  812 ++++++++++
 drivers/usb/device/serial_fd/serproto.h          |   44 
 drivers/usb/device/usbd-arch.h                   |  306 ++++
 drivers/usb/device/usbd-bus.c                    |  532 +++++++
 drivers/usb/device/usbd-bus.h                    |   91 +
 drivers/usb/device/usbd-debug.c                  |  261 +++
 drivers/usb/device/usbd-debug.h                  |  112 +
 drivers/usb/device/usbd-func.c                   | 1100 ++++++++++++++
 drivers/usb/device/usbd-func.h                   |  713 +++++++++
 drivers/usb/device/usbd-inline.h                 |  475 ++++++
 drivers/usb/device/usbd-module.h                 |   60 
 drivers/usb/device/usbd-monitor.c                |  782 ++++++++++
 drivers/usb/device/usbd-serialnumber.c           |  216 ++
 drivers/usb/device/usbd.c                        | 1297 +++++++++++++++++
 drivers/usb/device/usbd.h                        |  898 ++++++++++++
 83 files changed, 25044 insertions(+), 1 deletion(-)
------

ChangeSet@1.492, 2002-04-16 14:15:02-07:00, greg@kroah.com
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

ChangeSet@1.456.2.16, 2002-04-15 10:37:22-07:00, sl@lineo.com
  [PATCH] remove reference to current->nice
  
  USB device minor change
  
  remove reference to current->nice

 drivers/usb/device/bi/usbd-bi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.456.2.15, 2002-04-15 10:36:43-07:00, greg@kroah.com
  USB devices
  
  added the device tree to the build process.

 drivers/usb/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.456.2.14, 2002-04-12 14:17:31-07:00, greg@kroah.com
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

ChangeSet@1.456.2.13, 2002-04-12 14:02:52-07:00, greg@kroah.com
  USB devices
  
  fixed up some Config.in problems.

 drivers/usb/device/Config.in |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.456.2.11, 2002-04-11 16:54:12-07:00, greg@kroah.com
  USB device
  
  removed some files accidentally checked in.

 drivers/usb/device/bi/l7205/save/ctl.c       | 1598 ---------------------------
 drivers/usb/device/bi/l7205/save/ctl.h       |  305 -----
 drivers/usb/device/bi/l7205/save/recv.c      |  181 ---
 drivers/usb/device/bi/l7205/save/send.c      |  259 ----
 drivers/usb/device/bi/sa1100/PATCH-NOCALYPSO |   47 
 5 files changed, 2390 deletions(-)
------

ChangeSet@1.456.2.10, 2002-04-11 16:43:19-07:00, greg@kroah.com
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

ChangeSet@1.456.2.9, 2002-04-11 15:31:48-07:00, sl@lineo.com
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

