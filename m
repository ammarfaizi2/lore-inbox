Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbTFFF3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbTFFF3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:29:07 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:712
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265316AbTFFF26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:28:58 -0400
Date: Fri, 6 Jun 2003 01:42:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [BK PATCHES] net driver merges
Message-ID: <20030606054231.GA3545@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may obtain the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.70-bk10-netdrvr1.patch.bz2

This will update the following files:

 MAINTAINERS                      |    7 
 drivers/net/8139cp.c             |    2 
 drivers/net/Makefile             |    2 
 drivers/net/arcnet/arc-rawmode.c |   10 
 drivers/net/arcnet/arcnet.c      |   10 
 drivers/net/arcnet/rfc1051.c     |   10 
 drivers/net/arcnet/rfc1201.c     |   12 
 drivers/net/dl2k.h               |    1 
 drivers/net/ns83820.c            |    2 
 drivers/net/pcmcia/fmvj18x_cs.c  |   12 
 drivers/net/sb1000.c             |   22 
 drivers/net/sk98lin/skge.c       |    2 
 drivers/net/tg3.c                |    2 
 drivers/net/wireless/Kconfig     |   15 
 drivers/net/wireless/Makefile    |    1 
 drivers/net/wireless/atmel.c     | 3943 +++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/atmel_cs.c  |  768 +++++++
 include/linux/ethtool.h          |   27 
 18 files changed, 4791 insertions(+), 57 deletions(-)

through these ChangeSets:

<yoshfuji@linux-ipv6.org> (03/06/06 1.1313)
   [netdrvr] C99 initializers for arcnet

<scott.feldman@intel.com> (03/06/06 1.1312)
   [PATCH] remove ethtool privileged references
   
   dev_ioctl already checks capable(CAP_NET_ADMIN) for SOICETHTOOL, so
   privileged reference are not necessary.

<scott.feldman@intel.com> (03/06/06 1.1311)
   [PATCH] 10GbE ethtool support
   
   Add 10GbE support for ethtool.

<zwane@linuxpower.ca> (03/06/06 1.1310)
   [PATCH] cli/sti cleanup for fmvj18x
   
   This one should be safe as we're protected by the xmit_lock in all instances

<jgarzik@redhat.com> (03/06/06 1.1309)
   [netdrvr] add MAINTAINERS entry for atmel wireless driver

<srk@thekelleys.org.uk> (03/06/06 1.1308)
   [netdrvr] add atmel[_cs], new wireless driver
   
   Attached is a driver for Atmel at76c50x WiFi cards. This code started
   out as a GPL release from Atmel of pretty horrible quality and I've
   extensively re-worked it with the aim of making it acceptable in the
   kernel. Please could you take a look and either pass it into the patch
   stream or let me know what's wrong with it?
   
   The code has been tested on at least three different brand cards by
   different people. Jean Tourrilhes took a look at an earlier version an
   was positive. He's put incorporating this into 2.6 as a priority 1.
   The patch works fine on 2.5.70.
   
   The firmware issue has been addressed now. The only firmware in the
   driver is a small stub which reads the MAC address from NVRAM on the
   card. The source for that is included so there are no GPL issues. The
   main firmware is loaded from userspace using Manuel Estrada Sainz's
   sysfs firmware class. I know that the  patch for that has been
   accepted but it hasn't turned up anywhere I can see yet. The 
   driver compiles fine even without the firmware class. I've made a
   package of the firmware images which is available from my website.
   
   The remaining issues with the driver are migrating PCMCIA to the new
   driver model and PCI support. I'm happy to produce followup patches as
   the PCMCIA system gets evolved to the new driver model: the timing on
   that is controlled by others. This set of chips includes a PCI version
   and the driver should support that, but AFAIK there is no PCI hardware
   available anywhere. If Atmel can provide me with some it will be
   simple to add PCI support.
   
   The driver uses the CRC32 library module and the firmware loader. I've
   not put in dependencies on those, but when the lastest set of patches
   go into Kconfig I'll set it up so that selecting the Atmel driver
   selects CRC32 and FW_LOADER too.

<shemminger@osdl.org> (03/06/06 1.1307)
   [PATCH] sb1000 driver bugs
   
   Inspecting the sb1000 driver showed some interesting bugs:
   	- net device pointer is used before the device is allocated; gcc
   	  does catch this.
   	- unregister is called even though device not registered successfully
   	- net device is not freed on remove.
   
   Compiles but don't have hardware to test.  Don't know how it ever worked though.

<reeja.john@amd.com> (03/06/05 1.1306)
   [netdrvr amd8111e] link against mii lib

<jgarzik@redhat.com> (03/06/05 1.1305)
   [netdrvr skge] add ULL modifier to 64-bit constant

<jgarzik@redhat.com> (03/06/05 1.1304)
   [netdrvr] gcc 3.3 cleanups
   
   Mostly adding 'ULL' modifier to 64-bit constants.

