Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268269AbTBNVS6>; Fri, 14 Feb 2003 16:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268321AbTBNVSe>; Fri, 14 Feb 2003 16:18:34 -0500
Received: from havoc.daloft.com ([64.213.145.173]:22481 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268269AbTBNVRG>;
	Fri, 14 Feb 2003 16:17:06 -0500
Date: Fri, 14 Feb 2003 16:26:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] net driver stuff (yet more)
Message-ID: <20030214212654.GA19416@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clearly, my last submission was puny, and unworthy of true attention, so
this submission has doubled in size.   ;-)  Pretty much all fixes,
except for the new 3com Typhoon driver, and an eepro100 config option.

	Jeff





Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/tokenring/tmsisa.c   |  473 ----
 MAINTAINERS                      |    6 
 drivers/atm/nicstar.c            |    2 
 drivers/net/3c59x.c              |    8 
 drivers/net/Kconfig              |   31 
 drivers/net/Makefile             |    1 
 drivers/net/Makefile.lib         |    1 
 drivers/net/Space.c              |    8 
 drivers/net/bmac.c               |    2 
 drivers/net/eepro100.c           |    5 
 drivers/net/ns83820.c            |    4 
 drivers/net/pcnet32.c            |    4 
 drivers/net/sunbmac.c            |   13 
 drivers/net/sungem.c             |    4 
 drivers/net/sunqe.c              |    1 
 drivers/net/tokenring/Kconfig    |   23 
 drivers/net/tokenring/Makefile   |    3 
 drivers/net/tokenring/madgemc.c  |   27 
 drivers/net/tokenring/proteon.c  |  503 ++++
 drivers/net/tokenring/skisa.c    |  516 ++++
 drivers/net/tokenring/smctr.c    |   24 
 drivers/net/tokenring/tms380tr.c |   92 
 drivers/net/tokenring/tms380tr.h |    1 
 drivers/net/typhoon-firmware.h   | 4108 +++++++++++++++++++++++++++++++++++++++
 drivers/net/typhoon.c            | 2505 +++++++++++++++++++++++
 drivers/net/typhoon.h            |  613 +++++
 include/linux/pci_ids.h          |    8 
 27 files changed, 8423 insertions(+), 563 deletions(-)

through these ChangeSets:

<jochen@scram.de> (03/02/14 1.1064)
   Update several token ring drivers:
   
   New low level tms380 driver for Proteon 1392 / 1392+ cards
   (port from existing 2.2 kernel code)
   
   Add spinlock to fix race condition in tms380tr.
   
   Fix startup of tmsisa to not register and unregister devices multiple
   times, so hotplug doesn't run wild.
   
   Add support for statically compiling tmsisa into kernel.
   
   Remove unnecessary console SPAM during boot.
   
   Fixed probing of ISA devices in tmsisa.
   
   Fixed unsafe reference counting.
   
   Fixed __init function causing Oops with new module system.
   
   Rename tmsisa to skisa.
   

<jochen@scram.de> (03/02/14 1.1063)
   [tokenring madgemc] fix mem leaks, add proper refcounting

<pazke@orbita1.ru> (03/02/14 1.1053.2.16)
   [netdrvr eepro100] add PIO config option
   
   this trivial patch adds EEPRO100_PIO config option, which forces eepro100.c
   driver to use pio instead of mmio. This option is necessary to support
   onboard i82557 on sgi visual workstation.

<meissner@suse.de> (03/02/14 1.1053.2.15)
   [netdrvr pcnet32] fix multicast on big endian

<fubar@us.ibm.com> (03/02/14 1.1053.2.14)
   [netdrvr 3c59x] move netif_carrier_off() call outside vortex_debug test

<bbosch@iphase.com> (03/02/14 1.1053.2.13)
   [netdrvr ns83820] big endian fixes

<dave@thedillows.org> (03/02/14 1.1053.6.1)
   The initial release of the driver for the 3Com 3cr990 "Typhoon"
   series of network interface cards.
   
   Does:
   - NAPI
   - Zero copy Tx
   - VLAN hardware acceleration
   - TCP Segmentation offload

<Kare.Sars@lmf.ericsson.se> (03/02/14 1.1053.2.12)
   [atm nicstar] fix incorrect traffic class assumption
   
   I have encountered a bug in the nicstar ATM driver for linux.
   If you open a CBR TX only connection on a specific vpi/vci and later open a RX 
   only connection on the same vpi/vci, the RX connection will overwrite the 
   pointer to the SCQ of the TX connection. This changes the cell rate of the TX 
   channel and what is worse is that when the TX connection is closed we get a 
   segmentationfault and the TX part of the vpi/vci remains reserved.
   
   The bug in the driver is that if the opened channel is not TX CBR, the driver 
   assumes it is TX UBR. I have attached a patch that adds a check for TX UBR. 
   The patch is against RedHat kernel 2.4.18-3. I have checked linux vanilla 
   kernels 2.4.19 and 2.5.49 and not found a fix.

<davej@codemonkey.org.uk> (03/02/14 1.1053.2.11)
   [netdrvr sunbmac] probe path cleanup
   
   Merged from 2.4.x.

<davej@codemonkey.org.uk> (03/02/14 1.1053.2.10)
   [netdrvr sungem] be verbose about RX MAC fifo overflow
   
   Syncing this driver with the 2.4.x version.

<jgarzik@redhat.com> (03/02/14 1.1053.2.9)
   [netdrvr bmac] Remove unneeded memset()
   
   init_etherdev zeroes this memory for us, no need to do it again.
   Spotted by Dave Jones.

<davej@codemonkey.org.uk> (03/02/14 1.1053.2.8)
   [netdrvr sunqe] remove incorrect kfree()
   
   Use of init_etherdev's second argument causes the ->priv member
   to be allocated at the same time as the struct net_device
   itself.  Therefore, no additional kfree() is needed for the
   struct net_device ->priv member in this case.

<jochen@scram.de> (03/02/13 1.1053.4.1)
   [tokenring smctr] fix MAC address input
   
   After taking a second look, i just recognized that both cases (MAC adress
   all-zero or not) are handled exactly the same (by duplicated code), so the
   whole stuff is unnecessary.
   
   The whole function just reduces to a simple copy loop:

