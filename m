Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbTFYVTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFYVTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:19:40 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:40642
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265072AbTFYVTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:19:37 -0400
Date: Wed, 25 Jun 2003 17:33:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.5 net driver merges
Message-ID: <20030625213348.GA22088@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.73-bk3-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/Kconfig               |   22 
 drivers/net/Makefile              |    3 
 drivers/net/Makefile.lib          |    1 
 drivers/net/Space.c               |   11 
 drivers/net/acenic.c              |    3 
 drivers/net/au1000_eth.c          |   70 +--
 drivers/net/au1000_eth.h          |   11 
 drivers/net/declance.c            |  453 ++++++++++---------
 drivers/net/e100/e100_main.c      |   15 
 drivers/net/e1000/e1000_ethtool.c |   12 
 drivers/net/eepro100.c            |   16 
 drivers/net/gt96100eth.c          |   17 
 drivers/net/ioc3-eth.c            |  107 ----
 drivers/net/irda/Kconfig          |    4 
 drivers/net/irda/Makefile         |    1 
 drivers/net/irda/au1k_ir.c        |  868 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ixgb/ixgb_ethtool.c   |    8 
 drivers/net/meth.c                |  862 +++++++++++++++++++++++++++++++++++++
 drivers/net/meth.h                |  273 +++++++++++
 drivers/net/pcmcia/3c574_cs.c     |   37 -
 drivers/net/pcmcia/3c589_cs.c     |   40 -
 drivers/net/pcmcia/fmvj18x_cs.c   |   34 -
 drivers/net/pcmcia/nmclan_cs.c    |   33 -
 drivers/net/pcmcia/smc91c92_cs.c  |   75 +--
 drivers/net/sb1250-mac.c          |  731 +++++++++++++++++++++-----------
 drivers/net/sgiseeq.c             |  213 ++++-----
 drivers/net/sgiseeq.h             |    2 
 drivers/net/sungem.c              |    3 
 drivers/net/sunhme.c              |    3 
 drivers/net/tulip/tulip_core.c    |   12 
 30 files changed, 3043 insertions(+), 897 deletions(-)

through these ChangeSets:

<ralf@linux-mips.org> (03/06/25 1.1458)
   [netdrvr] misc small mips updates
   
   Add missing CONFIG_TC35805 entry to Kconfig.
   Update CONFIG_NET_SB1250_MAC Kconfig entry.
   Minor cosmetic updates to gt96100eth.

<ralf@linux-mips.org> (03/06/25 1.1457)
   [netdrvr tulip] add mips cobalt support

<ralf@linux-mips.org> (03/06/25 1.1456)
   [netdrvr] update sb1250-mac

<ralf@linux-mips.org> (03/06/25 1.1455)
   [netdrvr] au1000_eth update

<ralf@linux-mips.org> (03/06/25 1.1454)
   [netdrvr] update declance

<ralf@linux-mips.org> (03/06/25 1.1453)
   [netdrvr] update ioc3_eth

<ralf@linux-mips.org> (03/06/25 1.1452)
   [netdrvr] sgiseeq update

<ralf@linux-mips.org> (03/06/25 1.1451)
   [netdrvr] add driver "meth", for SGI O2 MACE fast eth

<jgarzik@redhat.com> (03/06/25 1.1450)
   [irda] add driver for mips Alchemy Au1000 SIR/FIR
   
   Submitted by Ralf Baechle <ralf@linux-mips.org>

<shemminger@osdl.org> (03/06/24 1.1449)
   [PATCH] 2.5.70 - eepro100 - use alloc_etherdev
   
   Ignore earlier patch -- this one locks and free's as appropriate.
   Tested on 2.5.72 with SMP.
   
   Of course, it begs the question why have two (now three) versions of drivers for
   the same hardware...

<scott.feldman@intel.com> (03/06/24 1.1448)
   [PATCH] Remove CAP_NET_ADMIN check for SIOCETHTOOL's
   
   dev_ioctl already checks capable(CAP_NET_ADMIN), so no need to do so in
   drivers.

<daniel.ritz@gmx.ch> (03/06/24 1.1447)
   [PATCH] alloc_etherdev for smc91c92_cs
   
   net_device is no longer allocated as part of the driver's private structure,
   instead it's allocated via alloc_netdev. compile tested only since no hardware
   against 2.5.73-bk
   
   
   -daniel
   
   ===== smc91c92_cs.c 1.18 vs edited =====

<daniel.ritz@gmx.ch> (03/06/24 1.1446)
   [PATCH] alloc_etherdev for nmclan_cs
   
   net_device is no longer allocated as part of the driver's private structure,
   instead it's allocated via alloc_netdev. compile tested only since no hardware
   against 2.5.73-bk
   
   
   -daniel
   
   ===== nmclan_cs.c 1.14 vs edited =====

<daniel.ritz@gmx.ch> (03/06/24 1.1445)
   [PATCH] alloc_etherdev for fmvj18x_cs
   
   net_device is no longer allocated as part of the driver's private structure,
   instead it's allocated via alloc_netdev. compile tested only since no hardware
   against 2.5.73-bk
   
   
   -daniel
   
   ===== fmvj18x_cs.c 1.21 vs edited =====

<daniel.ritz@gmx.ch> (03/06/24 1.1444)
   [PATCH] alloc_etherdev for 3c589_cs
   
   net_device is no longer allocated as part of the driver's private structure,
   instead it's allocated via alloc_netdev. compile tested only since no hardware
   against 2.5.73-bk
   
   
   -daniel
   
   ===== drivers/net/pcmcia/3c589_cs.c 1.17 vs edited =====

<daniel.ritz@gmx.ch> (03/06/24 1.1443)
   [PATCH] alloc_etherdev for 3c574_cs
   
   net_device is no longer allocated as part of the driver's private structure,
   instead it's allocated via alloc_netdev. compile tested only since no hardware
   against 2.5.73-bk
   
   
   -daniel
   
   
   ===== drivers/net/pcmcia/3c574_cs.c 1.17 vs edited =====

