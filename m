Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTE0Fly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTE0Fly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:41:54 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:64963
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S261678AbTE0Flw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:41:52 -0400
Date: Tue, 27 May 2003 01:55:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] net driver merges
Message-ID: <20030527055505.GA27014@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.70-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/bonding/bond_3ad.c  |   95 ++++++++++++---------
 drivers/net/bonding/bond_main.c |   12 ++
 drivers/net/eepro.c             |    2 
 drivers/net/pcnet32.c           |    7 +
 drivers/net/sundance.c          |   33 +++++--
 drivers/net/wan/lmc/lmc_debug.c |    2 
 drivers/net/wan/lmc/lmc_main.c  |  174 +++++++++-------------------------------
 drivers/net/wan/lmc/lmc_media.c |    7 -
 drivers/net/wan/lmc/lmc_proto.c |   14 ---
 drivers/net/wan/lmc/lmc_var.h   |    9 --
 10 files changed, 137 insertions(+), 218 deletions(-)

through these ChangeSets:

<engebret@us.ibm.com> (03/05/27 1.1436)
   [netdrvr pcnet32] bug fixes
   
   I would like to see a couple of the pcnet32 changes that I think we can
   agree on be put into the trees so a couple of the potential defects can be
   avoided.  The following patch contains just these pieces.  The only
   controversial one is an arbitrary change in the number of iterations in a
   while loop spinning on hardware state.   No matter how this is done, I am
   not especially fond of this bit of code as it has no reasonable error
   recovery path -- however, as a half-way, incremental solution, increasing
   the polling time should help as the 100 value was certainly found to be
   insufficient.  1000 may not be sufficient either, but it is certainly no
   worse.
   
   Both of the other changes were hit in testing (and I belive the wmb() at a
   customer even), so it would help reduce some debug if these go in.  Any
   feedback is appreciated - thanks.

<jgarzik@redhat.com> (03/05/27 1.1435)
   [netdrvr eepro] update MODULE_AUTHOR per old-author request

<edward_peng@dlink.com.tw> (03/05/27 1.1434)
   [netdrvr sundance] fix another flow control bug

<edward_peng@dlink.com.tw> (03/05/27 1.1433)
   [netdrvr sundance] fix flow control bug

<bunk@fs.tum.de> (03/05/27 1.1432)
   [wan lmc] remove 2.0.x-era code
   
   The patch below removes obsolete #if'd code for kernel 2.0 and 2.2 from
   drivers/net/wan/lmc/* (this includes the expansion of some #define's 
   that were definded differently for different kernel versions).

<shmulik.hen@intel.com> (03/05/27 1.1431)
   [netdrvr bonding] fix ABI version control problem
   
   This fix makes bonding not commit to a specific ABI version if the ioctl
   command is not supported by bonding.
   
   (It also removes the '\n' in the continuous printk reporting the link down
   event in bond_mii_monitor - it got in there by mistake in our previous
   patch set and caused log messages to appear funny in some situations).

<shmulik.hen@intel.com> (03/05/27 1.1430)
   [netdrvr bonding] fix long failover in 802.3ad mode
   
   This patch fixes the bug reported by Jay on April 3rd regarding long
   failover time when releasing the last slave in the active aggregator. The
   fix, as suggested by Jay, is to follow the spec recommendation and send a
   LACPDU to the partner saying this port is no longer aggregatable and
   therefore trigger an immediate re-selection of a new aggregator instead of
   waiting the entire expiration timeout.

