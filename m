Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSI3RzM>; Mon, 30 Sep 2002 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSI3RyY>; Mon, 30 Sep 2002 13:54:24 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5125 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262808AbSI3RxU>;
	Mon, 30 Sep 2002 13:53:20 -0400
Date: Mon, 30 Sep 2002 10:56:32 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20-pre8
Message-ID: <20020930175631.GA1592@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates for 2.4.20-pre8.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 drivers/usb/hcd.c                  |   94 +++--
 drivers/usb/hcd.h                  |    1 
 drivers/usb/hcd/ehci-dbg.c         |  525 +++++++++++++++++++++++++++---
 drivers/usb/hcd/ehci-hcd.c         |  512 ++++++++++++++++++++++--------
 drivers/usb/hcd/ehci-hub.c         |   16 
 drivers/usb/hcd/ehci-q.c           |  575 ++++++++++++++++++---------------
 drivers/usb/hcd/ehci-sched.c       |  630 +++++++++++++++----------------------
 drivers/usb/hcd/ehci.h             |   87 ++++-
 drivers/usb/hpusbscsi.c            |   31 -
 drivers/usb/kaweth.c               |   27 -
 drivers/usb/serial/visor.c         |    6 
 drivers/usb/serial/visor.h         |    1 
 drivers/usb/storage/sddr55.c       |    2 
 drivers/usb/storage/unusual_devs.h |   15 
 14 files changed, 1603 insertions(+), 919 deletions(-)
-----

ChangeSet@1.694, 2002-09-30 10:38:00-07:00, greg@kroah.com
  USB: added Palm Zire support to the visor driver
  
  thanks to Martin Brachtl for the information.

 drivers/usb/serial/visor.c |    6 ++++--
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)
------

ChangeSet@1.693, 2002-09-26 22:44:15-07:00, rgcrettol@datacomm.ch
  [PATCH] USB 2.0 HDD Walker / ST-HW-818SLIM usb-storage fix
  

 drivers/usb/storage/unusual_devs.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.692, 2002-09-26 22:43:37-07:00, tim@physik3.uni-rostock.de
  [PATCH] fix compares of jiffies
  
  on rechecking the current stable kernel code, I found some places where jiffies
  were compared in a way that seems to break when they wrap. For these,
  I made up patches to use the macros "time_before()" or "time_after()"
  that are supposed to handle wraparound correctly.

 drivers/usb/storage/sddr55.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.691, 2002-09-26 22:42:59-07:00, brihall@pcisys.net
  [PATCH] Update for JMTek USBDrive
  
  Attached is a patch against the 2.4.19 linux kernel. It adds an entry
  for another version of the JMTek USBDrive (driverless), and also updates
  my email address.

 drivers/usb/storage/unusual_devs.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)
------

ChangeSet@1.690, 2002-09-26 22:42:30-07:00, oliver@neukum.name
  [PATCH] USB: fixes for kaweth
  
  this fixes a few SMP locking issues for kaweth.

 drivers/usb/kaweth.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)
------

ChangeSet@1.689, 2002-09-26 22:41:50-07:00, oliver@neukum.name
  [PATCH] USB: update of hpusbscsi
  
  this fixes an unplugging problem and an SMP deadlock.

 drivers/usb/hpusbscsi.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)
------

ChangeSet@1.688, 2002-09-26 22:41:18-07:00, david-b@pacbell.net
  [PATCH] EHCI matching 2.5.38bk3
  
  This basically brings the 2.4 code into sync with the current
  2.5 code.  There've been a number of bugfixes and other changes,
  code cleanup and so on, so I'll just summarize some of the
  functional changes:
  
    - Fixes races and other qh unlink problems
  
    - Copes with rude eject from cardbus
  
    - Supports USB 1.1 interrupt transactions
      through USB 2.0 hubs
  
    - Should work with VIA VT8235 (KT333/KT400)
  
    - Filed down a lot of rough ends

 drivers/usb/hcd/ehci-dbg.c   |  525 +++++++++++++++++++++++++++++++----
 drivers/usb/hcd/ehci-hcd.c   |  512 +++++++++++++++++++++++++---------
 drivers/usb/hcd/ehci-hub.c   |   16 -
 drivers/usb/hcd/ehci-q.c     |  575 +++++++++++++++++++++------------------
 drivers/usb/hcd/ehci-sched.c |  630 +++++++++++++++++--------------------------
 drivers/usb/hcd/ehci.h       |   87 +++++
 6 files changed, 1495 insertions(+), 850 deletions(-)
------

ChangeSet@1.687, 2002-09-26 22:40:46-07:00, david-b@pacbell.net
  [PATCH] Re: [PATCH 2.4.20-pre7 1 of 2] usbcore/hcd updates
  
  Here's the first of those two patches, to usbcore's "hcd" glue:
  
   - removes something I left in pre7 to simplify these patches.
   - does pci map/unmap for the hardware-aware layer
   - knows that none fault mode is no longer allowed

 drivers/usb/hcd.c |   94 ++++++++++++++++++++++++++++++++----------------------
 drivers/usb/hcd.h |    1 
 2 files changed, 57 insertions(+), 38 deletions(-)
------

