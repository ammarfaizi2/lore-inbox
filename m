Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTEKSYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTEKSYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:24:19 -0400
Received: from havoc.daloft.com ([64.213.145.173]:1190 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261840AbTEKSYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:24:15 -0400
Date: Sun, 11 May 2003 14:36:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK+PATCHES] net driver merges
Message-ID: <20030511183657.GA12221@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may grab the patch from

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk6-netdrvr1.bz2

This will update the following files:

 drivers/net/Kconfig                 |    2 
 drivers/net/bmac.c                  |   53 ++-
 drivers/net/depca.c                 |  282 +++++++++++---------
 drivers/net/mace.c                  |   15 -
 drivers/net/sb1000.c                |  287 ++++++++------------
 drivers/net/setup.c                 |   35 --
 drivers/net/tulip/tulip_core.c      |    7 
 drivers/net/wireless/netwave_cs.c   |   10 
 drivers/net/wireless/wavelan.c      |  184 +++----------
 drivers/net/wireless/wavelan.p.h    |    8 
 drivers/net/wireless/wavelan_cs.c   |  496 +++---------------------------------
 drivers/net/wireless/wavelan_cs.p.h |   35 --
 include/linux/wireless.h            |   89 ++++--
 include/net/iw_handler.h            |   67 ++++
 net/core/wireless.c                 |  281 +++++++++++++++++++-
 net/netsyms.c                       |    9 
 16 files changed, 837 insertions(+), 1023 deletions(-)

through these ChangeSets:

<mzyngier@freesurf.fr> (03/05/11 1.1112)
   [PATCH] depca update (was Re: [Patch] DMA mapping API for Alpha)
   
   this patch has been sleeping
   in Alan tree for quite some time. It updates the depca driver to the
   EISA/sysfs API, gets rid of check_region, and properly reserve memory
   region. Patch is against latest BK.

<dean@arctic.org> (03/05/11 1.1111)
   [PATCH] better ali1563 integrated ethernet support
   
   it turns out the tulip driver is a much better driver for the integrated
   ali1563 ethernet than the dmfe driver... the dmfe driver gets tx timeouts
   every ~15s and can't receive over 5MB/s.  but with the small tulip patch
   below i'm seeing 11MB/s+ in both directions without problems.

<paulus@samba.org> (03/05/11 1.1110)
   [PATCH] Update mac ethernet drivers
   
   This patch updates the bmac and mace ethernet drivers so that their
   interrupt routines return an irqreturn_t, and updates the bmac driver
   to use a spinlock rather than global cli/sti.

<jt@bougret.hpl.hp.com> (03/05/11 1.1109)
   [PATCH] WE-16 for Wavelan Pcmcia driver
   
           This patch update the Wavelan Pcmcia driver for Wireless
   Extensions 16, and also remove all the backward compatibility cruft
   that is broken anyway.

<jt@bougret.hpl.hp.com> (03/05/11 1.1108)
   [PATCH] WE-16 for Wavelan ISA driver
   
           This update the Wavelan ISA driver for Wireless Extension 16
   (going with my previous patch).

<jt@bougret.hpl.hp.com> (03/05/11 1.1107)
   [PATCH] Wireless Extension 16
   
           This patch for 2.5.68-bk11 will update Wireless Extension to
   version 16 :
           o increase bitrate and frequency number for 802.11g/802.11a
           o enhanced iwspy support
           o minor tweaks and cleanups
   
           This patch is only for the core of WE. The patches for the
   individual drivers have been sent to their respective maintainers.
   	Compared to the previous version I sent you a few weeks ago,
   I've just updated to the latest kernel.

<jt@bougret.hpl.hp.com> (03/05/11 1.1106)
   [PATCH] irq fixes for wavelan_cs/netwave_cs
   
           This patch for 2.5.68-bk11 will fix the irq handler of some
   obsolete wireless drivers (wavelan, wavelan_cs and netwave_cs) plus
   assorted fixes. All those drivers have been tested on a SMP box.

<hch@lst.de> (03/05/11 1.1105)
   [PATCH] switch sb1000 to new style net init & pnp
   
   This cleans up the driver big time and gets rid of a big ugly wart
   in setup.c.  Note that I don't have the hardware so this is only
   compile-tested.

