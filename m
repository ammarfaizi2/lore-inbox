Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTHZWsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTHZWsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:48:42 -0400
Received: from havoc.gtf.org ([63.247.75.124]:28122 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263023AbTHZWsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:48:39 -0400
Date: Tue, 26 Aug 2003 18:48:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: romieu@fr.zoreil.com
Subject: [bk patches] 2.5.x net driver queue
Message-ID: <20030826224837.GA9628@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6

Patch users:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test4-bk2-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/3c501.c             |   91 +-------
 drivers/net/3c501.h             |    2 
 drivers/net/3c503.c             |   71 ------
 drivers/net/3c505.c             |   96 +-------
 drivers/net/3c507.c             |   97 +-------
 drivers/net/3c515.c             |   94 +-------
 drivers/net/3c523.c             |   73 ------
 drivers/net/3c527.c             |   94 +-------
 drivers/net/3c59x.c             |   47 +---
 drivers/net/8139cp.c            |  444 +++++++++++++++-------------------------
 drivers/net/Kconfig             |    2 
 drivers/net/pcmcia/3c574_cs.c   |   28 --
 drivers/net/pcmcia/3c589_cs.c   |   81 +------
 drivers/net/pcmcia/axnet_cs.c   |   28 --
 drivers/net/pcmcia/fmvj18x_cs.c |   75 +-----
 drivers/net/pcmcia/ibmtr_cs.c   |   35 ---
 drivers/net/pcmcia/nmclan_cs.c  |   77 ++----
 drivers/net/pcmcia/pcnet_cs.c   |   41 ---
 drivers/net/pcmcia/xirc2ps_cs.c |   28 --
 drivers/net/sis190.c            |  157 +++++++-------
 drivers/net/sis900.c            |   43 +--
 drivers/net/tulip/dmfe.c        |   62 +----
 drivers/net/tulip/xircom_cb.c   |   38 ---
 drivers/net/wireless/ray_cs.c   |   32 --
 24 files changed, 559 insertions(+), 1277 deletions(-)

through these ChangeSets:

<romieu@fr.zoreil.com> (03/08/26 1.1306)
   [netdrvr sis190] remove unneeded alignment code, other small fixes
   
   Driver does not need to enforce 256 byte alignment for data returned
   from pci_alloc_consistent().
   - {rx/tx}_dma_aligned and {rx/td}_dma_raw are both replaced by {rx/tx}_dma;
   - {rx/tx}_desc_raw is replaced by direct use of {Rx/Tx}DescArray;
   - SiS190_open()
     + fixup for a lack of kmalloc() failure handling;
     + (return status) there is no need for both retval/rc: merge them;
     + anonymous printk() fixup: the name of the guilty device is printed;
   - define {RX/TX}_DESC_TOTAL_SIZE because I am too lazy to read twice the
     same lengthy arithmetic expression.
   
   

<jgarzik@redhat.com> (03/08/26 1.1305)
   [wireless ray_cs] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1304)
   [netdrvr xircom_cb] ethtool_ops support
   
   Also, export PCI bus id via ETHTOOL_GDRVINFO.

<jgarzik@redhat.com> (03/08/26 1.1303)
   [netdrvr pcmcia] convert several drivers to ethtool_ops
   
   Drivers updated: fmvj18x_cs, ibmtr_cs, nmclan_cs, pcnet_cs,
   xirc2ps_cs.

<jgarzik@redhat.com> (03/08/26 1.1302)
   [netdrvr pcmcia] ethtool_ops for 3c574, 3c589, axnet

<jgarzik@redhat.com> (03/08/26 1.1301)
   [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe

<jgarzik@redhat.com> (03/08/26 1.1300)
   [netdrvr] ethtool_ops support in 3c503, 3c505, 3c507

<jgarzik@redhat.com> (03/08/26 1.1299)
   [netdrvr 3c501] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1298)
   [netdrvr sis190] make driver depend on CONFIG_BROKEN
   
   Until RX path is cleaned up to use PCI DMA API and
   not virt_to_bus.

<jgarzik@redhat.com> (03/08/26 1.1297)
   [netdrvr sis190] convert TX path to use PCI DMA API
   
   Also, minor changes:
   * mark ->hard_start_xmit ETH_ZLEN test as unlikely()
   * use cpu_to_le32() and le32_to_cpu() in TX path
   * fix two leak in error path, in ->hard_start_xmit
   * don't test netif_queue_stopped() in TX completion path,
     netif_wake_queue() already does that.

<jgarzik@redhat.com> (03/08/26 1.1296)
   [netdrvr 8139cp] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1295)
   [netdrvr sis900] ethtool_ops support

<willy@debian.org> (03/08/26 1.1294)
   [netdrvr 3c59x] ethtool_ops support

<romieu@fr.zoreil.com> (03/08/26 1.1293)
   [netdrvr sis190] pass irq argument to synchronize_irq()
   
   Looks like this driver wasn't tested on SMP :)

<bunk@fs.tum.de> (03/08/26 1.1292)
   [netdrvr sis190] fix build with older gcc
   
   older gcc's do not support C99/C++ style of variable declarations.

