Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTIZBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 21:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTIZBF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 21:05:27 -0400
Received: from havoc.gtf.org ([63.247.75.124]:22760 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262104AbTIZBFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 21:05:02 -0400
Date: Thu, 25 Sep 2003 21:02:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [bk patches] 2.6.x net driver updates
Message-ID: <20030926010218.GA32679@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/wireless/arlan.c          | 2078 ------------------------------
 Documentation/networking/sk98lin.txt  |  140 --
 drivers/net/3c503.c                   |    9 
 drivers/net/3c509.c                   |    9 
 drivers/net/8390.c                    |   11 
 drivers/net/Kconfig                   |  170 --
 drivers/net/ac3200.c                  |   10 
 drivers/net/appletalk/Kconfig         |    6 
 drivers/net/arcnet/Kconfig            |   40 
 drivers/net/e2100.c                   |   10 
 drivers/net/hamradio/Kconfig          |   41 
 drivers/net/hamradio/baycom_epp.c     |   79 -
 drivers/net/hamradio/baycom_par.c     |   57 
 drivers/net/hamradio/baycom_ser_fdx.c |   60 
 drivers/net/hamradio/baycom_ser_hdx.c |   57 
 drivers/net/hamradio/hdlcdrv.c        |   90 -
 drivers/net/hp-plus.c                 |   11 
 drivers/net/hp.c                      |   11 
 drivers/net/ne.c                      |    9 
 drivers/net/ne2.c                     |    8 
 drivers/net/ne2k-pci.c                |   49 
 drivers/net/ne2k_cbus.c               |   55 
 drivers/net/pcmcia/Kconfig            |   69 -
 drivers/net/saa9730.c                 |  201 ++
 drivers/net/saa9730.h                 |    1 
 drivers/net/sk98lin/h/skdrv1st.h      |    7 
 drivers/net/sk98lin/h/skdrv2nd.h      |   24 
 drivers/net/sk98lin/h/skgeinit.h      |   19 
 drivers/net/sk98lin/h/sktypes.h       |    7 
 drivers/net/sk98lin/h/skversion.h     |   31 
 drivers/net/sk98lin/skdim.c           |   18 
 drivers/net/sk98lin/skge.c            |  350 +++--
 drivers/net/sk98lin/skproc.c          |  325 +---
 drivers/net/smc-ultra.c               |   13 
 drivers/net/tlan.c                    |    7 
 drivers/net/tokenring/Kconfig         |   66 
 drivers/net/tulip/Kconfig             |   48 
 drivers/net/wan/Kconfig               |  111 -
 drivers/net/wd.c                      |   10 
 drivers/net/wireless/Kconfig          |   32 
 drivers/net/wireless/Makefile         |    4 
 drivers/net/wireless/arlan-main.c     | 2329 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/arlan-proc.c     |   25 
 drivers/net/wireless/arlan.h          |  106 -
 drivers/net/wireless/atmel.c          |    2 
 drivers/net/wireless/atmel_cs.c       |    4 
 include/linux/hdlcdrv.h               |    1 
 47 files changed, 3157 insertions(+), 3663 deletions(-)

through these ChangeSets:

<trivial@rustcorp.com.au> (03/09/25 1.1357)
   [PATCH] [PATCH 2.6.0-test1] remove check_region from drivers_net_3c509.c
   
   From:  Domen Puncer <root@coderock.org>

<buffer@antifork.org> (03/09/25 1.1356)
   [PATCH] saa9730 (minor revision)
   
   Don't know if the patch I released few days ago was still
   applied. This is a minor revision of that patch which converts
   saa9730 to spinlocks thus removing save_and_cli() and
   restore_flags() calls.
   
   Regards,
   Angelo Dell'Aera

<simon@thekelleys.org.uk> (03/09/25 1.1355)
   [PATCH] - atmel wireless driver
   
   This does two things:
   
   1) Fix alignment problem on PARISC64 (and maybe other 64bit archs.)
   2) Add another couple of cards to the table.
   
   Cheers,
   
   Simon.

<p_gortmaker@yahoo.com> (03/09/25 1.1354)
   [PATCH] Remove emacs cruft from 8390 drivers

<p_gortmaker@yahoo.com> (03/09/25 1.1353)
   [PATCH] ne2k_cbus tidy up

<p_gortmaker@yahoo.com> (03/09/25 1.1352)
   [PATCH] ne2k-pci full duplex with RealTek

<shemminger@osdl.org> (03/09/25 1.1351)
   [PATCH] (3/4) baycom/hdlcdrv unregister
   
   If baycom driver has never been opened, it will attempt to free
   an IRQ that it never registered when removed.  The problem is that hdlcdrv
   does not keep track of open/close state.

<shemminger@osdl.org> (03/09/25 1.1350)
   [PATCH] (2/4) baycom c99 initializers

<shemminger@osdl.org> (03/09/25 1.1349)
   [PATCH] (1/4) Update baycom drivers for 2.6
   
   Update baycom drivers for 2.6.0-test5
   	- get rid of MOD_INC/DEC
   	    (looked into hdlcdrv_ops and don't need to have owner field because
   	     baycom drivers unregister on  unload).
   	- use alloc_netdev instead of static device structures.
   	- hdlcdrv_register returns device instead of getting passed one.
   	- put private data in space allocated at dev->priv in alloc_netdev
   	- shorten name of hdlcdrv_register_hdlcdrv to hdlcdrv_register
   
   I don't have actual baycom hardware, but driver builds and loads/unloads.
   Real hardware initialization doesn't happen until open.
   
   The first one is the important patch, the other three are just code review
   type cleanups.

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.23)
   [PATCH] Remove modules.txt drivers_net_pcmcia_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.22)
   [PATCH] Remove modules.txt drivers_net_wan_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.21)
   [PATCH] Remove modules.txt drivers_net_tokenring_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.20)
   [PATCH] Remove modules.txt drivers_net_hamradio_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>
   
     Cheers, n.

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.19)
   [PATCH] Remove modules.txt drivers_net_arcnet_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.18)
   [PATCH] Remove modules.txt drivers_net_wireless_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.17)
   [PATCH] Remove modules.txt drivers_net_tulip_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<trivial@rustcorp.com.au> (03/09/25 1.1325.8.16)
   [PATCH] Remove modules.txt drivers_net_appletalk_Kconfig
   
   From:  Nicolas Kaiser <nikai@nikai.net>

<mlindner@syskonnect.de> (03/09/25 1.1325.8.15)
   [netdrvr sk98lin] fix leaks on error, and related cleanups

<mlindner@syskonnect.de> (03/09/25 1.1325.8.14)
   [netdrvr sk98lin] bump version number

<mlindner@syskonnect.de> (03/09/25 1.1325.8.13)
   [netdrvr sk98lin] small fixes
   
   Patch 3/5 (Update to version 6.17)
   * Add: Removed SkNumber and SkDoDiv
   * Add: Counter output as (unsigned long long)

<mlindner@syskonnect.de> (03/09/25 1.1325.8.12)
   [netdrvr sk98lin] update readme, remove old changelog

<mlindner@syskonnect.de> (03/09/25 1.1325.8.11)
   [netdrvr sk98lin] small updates
   
   
   Patch 1/5 (Update to version 6.17)
   * Add: Better parameter check
   * Add: UDP and TCP HW Csum changes
   * Add: Interrupt Moderation infos

<shemminger@osdl.org> (03/09/25 1.1325.8.10)
   [PATCH] (8/8) arlan -- proper jiffies usage
   
   Add proper management of jiffies and time values, rather than punting
   and doing long long arithmetic on usecs.

<shemminger@osdl.org> (03/09/25 1.1325.8.9)
   [PATCH] (7/8) arlan -- more dead wood removal
   
   Still more driver data which was updated but never used.

<shemminger@osdl.org> (03/09/25 1.1325.8.8)
   [PATCH] (6/8) arlan -- add spinlock
   
   Convert bogus test_and_set local wait, to a real spin_lock so it
   has a chance of working on an SMP.  This also does the right thing
   and locks out interrupts while giving commands on UP;  maybe the
   comment in Kconfig was because there was never a proper mutex...
   
   Don't have real hardware to try this, but it can't be worse than
   the previous code.

<shemminger@osdl.org> (03/09/25 1.1325.8.7)
   [PATCH] (5/8) arlan -- more set never used elements
   
   Still more places state is saved and never used.

<shemminger@osdl.org> (03/09/25 1.1325.8.6)
   [PATCH] (4/8) arlan -- trailing semicolons.
   
   Get rid of extra trailing semicolons

<shemminger@osdl.org> (03/09/25 1.1325.8.5)
   [PATCH] (3/8) arlan -- get rid of unnecessary casts.
   
   Get rid of unneeded casts to cleanup readability.

<shemminger@osdl.org> (03/09/25 1.1325.8.4)
   [PATCH] (2/8) arlan -- get rid of some dead wood
   
   This code is littered with unused structure elements and globals.
   Eliminate some of the fields set and never used.
   
   More in later patches.

<shemminger@osdl.org> (03/09/25 1.1325.8.3)
   [PATCH] (1/8) arlan -- merge arlan-proc with main code
   
   The arlan driver tries to build it's /proc interface into a separate module,
   which leads to circular dependencies and other ugliness.  This patch
   moves arlan.c to arlan-main.c and changes initialization builds one module arlan.o
   
   Patch is for 2.6.0-test5

<mpm@selenic.com> (03/09/24 1.1325.8.2)
   [netdrvr tlan] netif_carrier_* support

<mlindner@syskonnect.de> (03/09/24 1.1325.8.1)
   [netdrvr sk98lin] Remove useless configure options
   
   here is a new version of the sk98lin driver (v6.18) with some changes
   for kernel 2.6.0-test4. This is a diff between the latest patched kernel
   version with sk98lin driver v6.17.
   
   Patch 1/3
   * Remove bogus config stuff

