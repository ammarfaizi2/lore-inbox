Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319761AbSILR0i>; Thu, 12 Sep 2002 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319771AbSILR0i>; Thu, 12 Sep 2002 13:26:38 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:17160 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319761AbSILR0f>;
	Thu, 12 Sep 2002 13:26:35 -0400
Date: Thu, 12 Sep 2002 10:27:59 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] more USB changes for 2.5.34
Message-ID: <20020912172758.GO19784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more USB changes for 2.5.34.

Pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/class/usb-midi.c   |   10 +--
 drivers/usb/host/ehci-hcd.c    |   15 ++++-
 drivers/usb/host/ehci-q.c      |   59 ++++++++++++++-------
 drivers/usb/host/ehci-sched.c  |  113 -----------------------------------------
 drivers/usb/host/ehci.h        |    3 -
 drivers/usb/image/hpusbscsi.c  |    8 ++
 drivers/usb/image/microtek.c   |   19 +++++-
 drivers/usb/misc/Config.in     |    2 
 drivers/usb/net/kaweth.c       |   48 +++++++++++------
 drivers/usb/net/usbnet.c       |   75 ++++++++++++++++++---------
 drivers/usb/serial/belkin_sa.c |    1 
 drivers/usb/serial/belkin_sa.h |    1 
 12 files changed, 168 insertions(+), 186 deletions(-)
-----

ChangeSet@1.658, 2002-09-12 10:13:30-07:00, lopezp@grupocp.es
  [PATCH] usbmidi patch
  
  I have changed the name of a local variable "l" to be "j", because with some
  fonts should be difficult to see if [1+l+i] means [2+i] or what.

 drivers/usb/class/usb-midi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.657, 2002-09-12 09:51:15-07:00, oliver@neukum.name
  [PATCH] fixes for races in kaweth probe
  
  using init_etherdev(0, 0) in probe is a race. The struct net_device must be
  allocate and filled before init_etherdev is called, or there's a race which
  creates a network interface that isn't usable.
  The patch for kaweth for 2.5 fixes it.

 drivers/usb/net/kaweth.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)
------

ChangeSet@1.656, 2002-09-11 23:02:27-07:00, david-b@pacbell.net
  [PATCH] ehci, async idle timout
  
  One more patch:  this turns off async schedule processing
  if there are no control or bulk transactions for a while
  (currently HZ/3).  Consequence:  no PCI accesses unless
  there's work to do.  (And a FIXME comment is gone!)

 drivers/usb/host/ehci-hcd.c |    8 +++++++-
 drivers/usb/host/ehci-q.c   |   14 +++++++++-----
 drivers/usb/host/ehci.h     |    3 ++-
 3 files changed, 18 insertions(+), 7 deletions(-)
------

ChangeSet@1.655, 2002-09-11 17:49:43-07:00, rct@gherkin.frus.com
  [PATCH] 2.5.X config: USB speedtouch driver
  
   Minor nit: the subject driver depends on ATM, so a config-time check to
   see if ATM support is enabled is appropriate.

 drivers/usb/misc/Config.in |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.654, 2002-09-11 17:32:42-07:00, greg@kroah.com
  USB: compile time fix for previous kaweth patch.

 drivers/usb/net/kaweth.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.653, 2002-09-11 17:30:42-07:00, oliver@neukum.name
  [PATCH] open/close fix for kaweth
  
  this handles the error case.

 drivers/usb/net/kaweth.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)
------

ChangeSet@1.652, 2002-09-11 17:28:55-07:00, oliver@neukum.name
  [PATCH] new ids for hpusbscsi
  
  new device ids for hpusbscsi

 drivers/usb/image/hpusbscsi.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)
------

ChangeSet@1.651, 2002-09-11 17:28:14-07:00, oliver@neukum.name
  [PATCH] fix for error handling in microtek
  

 drivers/usb/image/microtek.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)
------

ChangeSet@1.650, 2002-09-11 17:04:08-07:00, david-b@pacbell.net
  [PATCH] ehci misc fixes
  
  This removes some bugs:
  
   - a short read problem with control requests
   - only creates one control qh (memleak fix)
   - adds an omitted hardware handshake
   - reset timeout in octal, say what?
   - a couple BUG()s outlived their value
  
  Plus it deletes unused stub code for split ISO
  and updates some internal doc.

 drivers/usb/host/ehci-hcd.c   |    7 ++
 drivers/usb/host/ehci-q.c     |   45 +++++++++++-----
 drivers/usb/host/ehci-sched.c |  113 ------------------------------------------
 3 files changed, 39 insertions(+), 126 deletions(-)
------

ChangeSet@1.649, 2002-09-11 17:03:32-07:00, david-b@pacbell.net
  [PATCH] usbnet, Epson client
  
    * Tells about some Epson firmware that uses this as part
      of a Linux interop solution (PDA-ish SoCs, hmm)
    * Includes some GeneSys info from emails
    * Minor cleanups

 drivers/usb/net/usbnet.c |   75 +++++++++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 24 deletions(-)
------

ChangeSet@1.648, 2002-09-11 17:03:02-07:00, mlang@delysid.org
  [PATCH] HandyTech HandyLink patch
  
  HandyTech's Braille displays support a USB port, those are
  implemented with a GoHubs usb serial converter.  The only difference
  is that the pID is 0x1200, not 0x1000.

 drivers/usb/serial/belkin_sa.c |    1 +
 drivers/usb/serial/belkin_sa.h |    1 +
 2 files changed, 2 insertions(+)
------

