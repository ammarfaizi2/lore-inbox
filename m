Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319092AbSHMWl7>; Tue, 13 Aug 2002 18:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319093AbSHMWl7>; Tue, 13 Aug 2002 18:41:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:56337 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319092AbSHMWl5>;
	Tue, 13 Aug 2002 18:41:57 -0400
Date: Tue, 13 Aug 2002 15:41:48 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.31
Message-ID: <20020813224148.GB23021@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  http://linuxusb.bkbits.net/linus-2.5

 drivers/usb/core/hcd.c         |   33 ++++++++++++++++++++++++++
 drivers/usb/core/usb.c         |    4 +--
 drivers/usb/host/ehci-q.c      |   50 ++++++----------------------------------
 drivers/usb/host/ehci-sched.c  |   19 ++-------------
 drivers/usb/host/ehci.h        |    1 
 drivers/usb/host/ohci-q.c      |   50 ++++++----------------------------------
 drivers/usb/host/ohci-sa1111.c |    8 ++++++
 drivers/usb/host/uhci-hcd.c    |   51 ++++-------------------------------------
 drivers/usb/host/uhci-hcd.h    |    3 --
 drivers/usb/net/cdc-ether.c    |   10 +++++---
 10 files changed, 74 insertions(+), 155 deletions(-)
------

ChangeSet@1.505, 2002-08-13 15:31:04-07:00, greg@kroah.com
  USB: check to see if we have a disconnect function before trying to call it.

 drivers/usb/core/usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.474.2.7, 2002-08-13 14:37:05-07:00, oliver@neukum.name
  [PATCH] Problem with CDC Ethernet driver (CDCEther.c)
  
    - fixed deadlock

 drivers/usb/net/cdc-ether.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)
------

ChangeSet@1.474.2.6, 2002-08-13 14:06:15-07:00, greg@kroah.com
  USB: moved put_bus to its proper place (as the last thing we do shutting down.)

 drivers/usb/core/usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.474.2.5, 2002-08-13 13:09:23-07:00, david-b@pacbell.net
  [PATCH] HCDs support new DMA APIs (part 2 of 2)
  
  - teaches the shared "hcd" code to set urb->*_dma whenever the device
    driver didn't, by creating singleshot mappings.

 drivers/usb/core/hcd.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+)
------

ChangeSet@1.474.2.4, 2002-08-13 13:09:05-07:00, david-b@pacbell.net
  [PATCH] HCDs support new DMA APIs (part 1 of 2)
  
  -  teaches the hardware-specific code to
     use urb->*_dma instead of creating mappings.
     (And tells ohci-sa1111 to init its buffer pools.)
     EHCI and UHCI also eliminated duplicated state;
     all the HCDs are now a smidgeon smaller.
  
  Sanity checked by enumerating, including through
  a hub, and using a USB Ethernet adapter, with each
  of the three host controllers.
  
  Worth noting:  this removes pci_dma_sync_single()
  calls from UHCI.  On x86 (and some others) that's
  a NOP, but for UHCI on other platforms (rare except
  maybe on IA64, as I understand) this anticipates
  the upcoming patch to remove interrupt automagic.
  (I'll likely submit that after a Linus release that
  catches up to your USB tree. :)

 drivers/usb/host/ehci-q.c      |   50 ++++++----------------------------------
 drivers/usb/host/ehci-sched.c  |   19 ++-------------
 drivers/usb/host/ehci.h        |    1 
 drivers/usb/host/ohci-q.c      |   50 ++++++----------------------------------
 drivers/usb/host/ohci-sa1111.c |    8 ++++++
 drivers/usb/host/uhci-hcd.c    |   51 ++++-------------------------------------
 drivers/usb/host/uhci-hcd.h    |    3 --
 7 files changed, 32 insertions(+), 150 deletions(-)
------

