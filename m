Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTFTDc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 23:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFTDc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 23:32:28 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:8119
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S262185AbTFTDc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 23:32:26 -0400
Date: Thu, 19 Jun 2003 23:46:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] net driver merges
Message-ID: <20030620034626.GA3366@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.72-bk2-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/amd8111e.c          |   12 +++--
 drivers/net/bonding/bond_main.c |   88 +++------------------------------------
 drivers/net/ixgb/ixgb_ethtool.c |    1 
 drivers/net/pcmcia/xirc2ps_cs.c |   89 ++++++++++++++++------------------------
 drivers/net/pcnet32.c           |    2 
 drivers/net/sis900.c            |    1 
 drivers/net/tulip/Kconfig       |    2 
 7 files changed, 54 insertions(+), 141 deletions(-)

through these ChangeSets:

<mikpe@csd.uu.se> (03/06/19 1.1366)
   [netdrvr tulip] Kconfig help text fix
   
   While there is a separate driver for 2104x tulips (CONFIG_DE2104X),
   drivers/net/tulip/Kconfig states that CONFIG_TULIP also supports
   2104x tulips. This is not the case since that support was removed
   in December 2001. A user with an old tulip may thus be tricked into
   configuring the wrong driver. (I was, on my PMac 4400.)
   
   The patch below removes this misinformation from tulip's Kconfig.
   

<jgarzik@redhat.com> (03/06/19 1.1365)
   [netdrvr sis900] add new phy id to phy table
   
   (pulled change from 2.4)

<daniel.ritz@gmx.ch> (03/06/19 1.1364)
   [PATCH] xirc2ps_cs update
   
   the second patch:
   replaces busy_loop with a simple macro doing a schedule_timeout. busy_loop was never
   called from interrupt conext anyway, so no need for that. and the sti() is gone.
   
   rgds
   -daniel

<daniel.ritz@gmx.ch> (03/06/19 1.1363)
   [PATCH] xirc2ps_cs update
   
   hi
   
   this patch does:
   - net_device is no longer allocated as part of the driver's private structure,
     instead it's allocated via alloc_netdev
   - xirc2ps_detach calls xirc2ps_release if necessary (like the other drivers)
   
   against 2.5.70-bk.
   
   rgds
   -daniel

<zwane@linuxpower.ca> (03/06/19 1.1362)
   [PATCH] Remove warning due to comparison in drivers/net/pcnet32.c
   
   drivers/net/pcnet32.c: In function `pcnet32_init_ring':
   drivers/net/pcnet32.c:1006: warning: comparison between pointer and integer

<bunk@fs.tum.de> (03/06/19 1.1361)
   [netdrvr ixgb] fix clash with newly-updated ethtool.h

<reeja.john@amd.com> (03/06/19 1.1360)
   [netdrvr amd8111e] fix spinlock recursion / if close failure

<ak@muc.de> (03/06/19 1.1359)
   [PATCH] Remove copied inet_aton code in bond_main.c
   
   According to a report the my_inet_aton code in bond_main.c is copied
   from 4.4BSD, but it doesn't carry a BSD copyright license. In addition
   it is somewhat redundant with the standard in_aton.  Convert it
   to use the linux function.
   
   Error handling is a bit worse than before, but not much.
   
   Patch for 2.5 bonding. The 2.4 version has the same problem, but afaik
   it is scheduled to be replaced by the 2.5 codebase anyways.
   
   -Andi

