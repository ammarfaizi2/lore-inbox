Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTH0WnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbTH0WnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:43:17 -0400
Received: from havoc.gtf.org ([63.247.75.124]:53735 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262465AbTH0WnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:43:04 -0400
Date: Wed, 27 Aug 2003 18:43:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [patch] 2.4.x net driver queue
Message-ID: <20030827224304.GA11863@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So that I may synchronize with a few folks, here is the current net
driver queue for 2.4.x.  A fair chunk of the older commits have been
submitted to Marcelo.


BK users:

	Outta luck until M pulls previous batch :)

Patch users:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.23-pre1-netdrvr1.patch.bz2

This will update the following files:

 Documentation/networking/ifenslave.c |    1 
 drivers/net/3c501.c                  |   93 --
 drivers/net/3c503.c                  |   71 -
 drivers/net/3c505.c                  |   92 --
 drivers/net/3c507.c                  |   97 --
 drivers/net/3c515.c                  |   94 --
 drivers/net/3c523.c                  |   73 -
 drivers/net/3c527.c                  |   94 --
 drivers/net/3c59x.c                  |   50 -
 drivers/net/8139cp.c                 |  472 ++++-------
 drivers/net/8139too.c                |  424 ++++------
 drivers/net/bonding/bond_alb.c       |  144 +++
 drivers/net/bonding/bond_alb.h       |    8 
 drivers/net/bonding/bond_main.c      | 1416 ++++++++++++++++++++---------------
 drivers/net/bonding/bonding.h        |    3 
 drivers/net/dmfe.c                   |   61 -
 drivers/net/pcmcia/3c574_cs.c        |   30 
 drivers/net/pcmcia/3c589_cs.c        |   83 --
 drivers/net/pcmcia/aironet4500_cs.c  |   76 -
 drivers/net/pcmcia/axnet_cs.c        |   31 
 drivers/net/pcmcia/fmvj18x_cs.c      |   75 -
 drivers/net/pcmcia/ibmtr_cs.c        |   35 
 drivers/net/pcmcia/netwave_cs.c      |   69 -
 drivers/net/pcmcia/nmclan_cs.c       |   77 -
 drivers/net/pcmcia/pcnet_cs.c        |   43 -
 drivers/net/pcmcia/ray_cs.c          |   32 
 drivers/net/pcmcia/wavelan_cs.c      |   30 
 drivers/net/pcmcia/xirc2ps_cs.c      |   28 
 drivers/net/pcmcia/xircom_cb.c       |   38 
 drivers/net/sis900.c                 |   72 -
 drivers/net/wireless/airo.c          |  753 +++++++++++++++---
 include/linux/list.h                 |   13 
 include/linux/netdevice.h            |    4 
 net/core/ethtool.c                   |   12 
 34 files changed, 2346 insertions(+), 2348 deletions(-)

through these ChangeSets:

<willy@debian.org> (03/08/27 1.1107)
   [netdrvr 8139too] ethtool_ops support

<willy@debian.org> (03/08/27 1.1106)
   [ethtool] fix ethtool_get_strings counting bug

<shmulik.hen@intel.com> (03/08/27 1.1105)
   [netdrvr bonding] Enhance netdev notification handling.
   
   Also, add comment block and bump version.

<shmulik.hen@intel.com> (03/08/27 1.1104)
   [netdrvr bonding] Consolidate /proc code, add CHANGENAME handler

<shmulik.hen@intel.com> (03/08/27 1.1103)
   [netdrvr bonding] support for changing MAC addr, MTU in ALB/TLB modes

<shmulik.hen@intel.com> (03/08/27 1.1102)
   [netdrvr bonding] support for changing HW address and MTU

<shmulik.hen@intel.com> (03/08/27 1.1101)
   [netdrvr bonding] Decouple promiscuous handling from the multicast mode setting.

<shmulik.hen@intel.com> (03/08/27 1.1100)
   [netdrvr bonding] Modes that don't use primary don't use the new prop. code

<shmulik.hen@intel.com> (03/08/27 1.1099)
   [netdrvr bonding] Change monitoring function to use new slave setting propagation

<shmulik.hen@intel.com> (03/08/27 1.1098)
   [netdrvr bonding] update slave setting propagation
   
   Distinguish between modes that use a primary slave from
   those that don't, and propagate settings accordingly; Consolidate
   change_active opeartions and add reselect_active and find_best
   opeartions.

<shmulik.hen@intel.com> (03/08/27 1.1097)
   [netdrvr bonding] add another ifenslave.c include

<shmulik.hen@intel.com> (03/08/27 1.1096)
   [netdrvr bonding] update credits/version

<shmulik.hen@intel.com> (03/08/27 1.1095)
   [netdrvr bonding] use linked list to handle multiple bond devices

<shmulik.hen@intel.com> (03/08/27 1.1094)
   [netdrvr bonding] fix /proc read function

<shmulik.hen@intel.com> (03/08/27 1.1093)
   [list] backport list_for_each_entry_safe macro from 2.6

<jgarzik@redhat.com> (03/08/26 1.1091)
   [wireless airo] build fixes

<javier@tudela.mad.ttd.net> (03/08/26 1.1090)
   [wireless airo] add support for MIC and latest firmwares

<greg@kroah.com> (03/08/26 1.1089)
   [netdrvr sis900] don't call pci_find_device from irq context
   
   I realized that I've had this patch in my tree for a while, and forgot
   to send it to you and lkml.  The patch below fixes bug number 923:
   	http://bugme.osdl.org/show_bug.cgi?id=923
   (basically keeps us from calling pci_find_device from interrupt
   context.)
   
   It's been tested by a few people with this device, and they say it works
   just fine for them.  Please forward it on up the food chain.

<hirofumi@mail.parknet.co.jp> (03/08/26 1.1088)
   [netdrvr 8139too] add more h/w revision ids

<hirofumi@mail.parknet.co.jp> (03/08/26 1.1087)
   [netdrvr 8139too] remove unused RxConfigMask

<hirofumi@mail.parknet.co.jp> (03/08/26 1.1086)
   [netdrvr 8139too] lwake unlock fix

<srompf@isg.de> (03/08/26 1.1085)
   [netdrvr 8139too] use mii_check_media lib function,
   instead of homebrew MII bitbanging.

<jgarzik@redhat.com> (03/08/26 1.1076.1.14)
   [netdrvr 8139too] minor bits from 2.6
   
   Keeping the driver in sync to ease maintenance headaches.

<jgarzik@redhat.com> (03/08/26 1.1076.1.13)
   [netdrvr pcmcia] ethtool_ops support for several more pcmcia drivers
   
   Drivers updated: fmvj18x_cs, ibmtr_cs, netwave_cs, nmclan_cs,
   pcnet_cs, ray_cs, wavelan_cs, xirc2ps_cs, xircom_cb.

<jgarzik@redhat.com> (03/08/26 1.1076.1.12)
   [netdrvr pcmcia] use SET_ETHTOOL_OPS in 3c574, 3c589, aironet4500, and axnet

<jgarzik@redhat.com> (03/08/26 1.1076.1.11)
   [NET] add SET_ETHTOOL_OPS back-compat hook

<jgarzik@redhat.com> (03/08/26 1.1076.1.10)
   [netdrvr pcmcia] ethtool_ops for 3c574, 3c589, aironet4500, axnet

<jgarzik@redhat.com> (03/08/26 1.1076.1.9)
   [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe

<jgarzik@redhat.com> (03/08/26 1.1076.1.8)
   [netdrvr] ethtool_ops support in 3c503, 3c505, 3c507

<jgarzik@redhat.com> (03/08/26 1.1076.1.7)
   [netdrvr 3c501] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1076.1.6)
   [netdrvr 3c59x] add a piece missed in previous ethtool_ops patch
   
   Contributed by Matthew Wilcox.

<jgarzik@redhat.com> (03/08/26 1.1076.1.5)
   [netdrvr 8139cp] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1076.1.4)
   [netdrvr 8139cp] minor bits from 2.6

<jgarzik@redhat.com> (03/08/26 1.1076.1.3)
   [netdrvr sis900] minor bits from 2.6

<jgarzik@redhat.com> (03/08/26 1.1076.1.2)
   [netdrvr sis900] ethtool_ops support

<willy@debian.org> (03/08/26 1.1076.1.1)
   [netdrvr 3c59x] ethtool_ops support

