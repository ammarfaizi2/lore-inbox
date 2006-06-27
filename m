Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWF0N3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWF0N3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWF0N3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:29:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:49639 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932238AbWF0N3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:29:22 -0400
Date: Tue, 27 Jun 2006 09:29:21 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanups for Becker-derived drivers
Message-ID: <20060627132920.GA26367@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just checked this into netdev-2.6.git#upstream...

	Jeff




commit 5e4860c2f5dd64bdc9dedc657c246129659b5bbe
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 09:25:28 2006 -0400

    [netdrvr] via-velocity: remove io_size struct member, it is invariant
    
    Replace io_size struct members with VELOCITY_IO_SIZE constant.
    
    Also, constify chip_info_table[].
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 8a8b0fe4ac1cf49e4d1f170de20bc1c91206dc9c
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 09:20:08 2006 -0400

    [netdrvr] via-velocity: misc. cleanups
    
    - const-ify pci_device_id table
    - clean up pci_device_id table with PCI_DEVICE()
    - don't store internal pointer in pci_device_id table,
      use pci_device_id::driver_data as an integer index
    - use dev_printk() for messages where eth%d prefix is unavailable
    - formatting fixes
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit d573eb578808b9531e50b38222c56cf8792b4d86
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 09:12:38 2006 -0400

    [netdrvr] minor cleanups in Becker-derived drivers
    
    - fealnx: convert #define to enum
    - fealnx, sundance: mark chip info table __devinitdata
    - fealnx: use dev_printk() during probe
    - fealnx: formatting cleanups
    - starfire: remove obsolete comment
    - sundance, via-rhine: add some whitespace where useful, in tables
    - sundance: prefer "{ }" table terminator
    - via-rhine: mark PCI probe table const
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit c66fdbba1d9c058ea4a93c2be84c142cd24710ad
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 08:56:23 2006 -0400

    [netdrvr] via-velocity: use netdev_priv() where appropriate
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 61c874a20369c61840bbe70c77b8703a7e70834b
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 08:54:34 2006 -0400

    [netdrvr] Remove Becker-template 'io_size' member, when invariant
    
    Becker-derived drivers often have the 'io_size' member in their chip
    info struct, indicating the minimum required size of the I/O resource
    (usually a PCI BAR).  For many situations, this number is either
    constant or irrelevant (due to pci_iomap convenience behavior).
    
    This change removes the io_size invariant member, and replaces it with a
    compile-time constant.
    
    Drivers updated: fealnx, gt96100eth, winbond-840, yellowfin
    
    Additionally,
    - gt96100eth: unused 'drv_flags' removed from gt96100eth
    - winbond-840: unused struct match_info removed
    - winbond-840: mark pci_id_tbl[] const, __devinitdata
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 5a60e801d0db1421e1f5753e96edd63975023ace
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 07:57:22 2006 -0400

    [netdrvr] Remove Linux-specific changelogs from several Becker template drivers
    
    When in-kernel net drivers branched from Donald Becker's vanilla driver
    set, in the days before BitKeeper and git, a driver changelog was
    maintained in the driver source code.  These days, the kernel's
    changelog is far superior and much more accurate, so the in-driver
    changelogs are removed.
    
    Another relic of the Becker/kernel split was version numbering, using
    "foo-LKx.y.z" notation, resulting in weird version numbers like
    "1.17b-LK1.1.9".  These drivers are for older hardware, and see few
    changes these days, so the version numbers were all bumped to something
    more simple.
    
    Finally, in xircom_tulip_cb specifically, an additional cleanup removes
    the always-enabled CARDBUS cpp macro.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 45d2b49000fa6cd65e2409bf7c121b374c4974cd
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 07:38:33 2006 -0400

    [netdrvr] epic100: minor cleanups
    
    - Remove in-source changelog, it's in the global kernel history.
    - convert silly and useless version to useful one
    - replace invariant pci_id_tbl[]::io_size uses with EPIC_TOTAL_SIZE
    - remove now-unused io_size member from pci_id_tbl[]
    - current kernel style prefers dev_printk() for the rare ethernet driver
      messages that cannot print an 'eth%d' prefix.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>


 drivers/net/dl2k.c                  |   43 ------------
 drivers/net/epic100.c               |   71 ++------------------
 drivers/net/fealnx.c                |   20 +++--
 drivers/net/gt96100eth.c            |    3 
 drivers/net/gt96100eth.h            |    2 
 drivers/net/hamachi.c               |   13 ---
 drivers/net/natsemi.c               |  117 ----------------------------------
 drivers/net/starfire.c              |  123 ------------------------------------
 drivers/net/sundance.c              |  106 ++++---------------------------
 drivers/net/tulip/winbond-840.c     |   29 +++-----
 drivers/net/tulip/xircom_tulip_cb.c |   27 +------
 drivers/net/via-rhine.c             |  121 ++---------------------------------
 drivers/net/via-velocity.c          |  102 ++++++++++++++---------------
 drivers/net/via-velocity.h          |    4 -
 drivers/net/yellowfin.c             |   39 ++---------
 15 files changed, 132 insertions(+), 688 deletions(-)


diff --git a/drivers/net/dl2k.c b/drivers/net/dl2k.c
index 038447f..be997cb 100644
--- a/drivers/net/dl2k.c
+++ b/drivers/net/dl2k.c
@@ -9,49 +9,10 @@
     the Free Software Foundation; either version 2 of the License, or
     (at your option) any later version.
 */
-/*
-    Rev		Date		Description
-    ==========================================================================
-    0.01	2001/05/03	Created DL2000-based linux driver
-    0.02	2001/05/21	Added VLAN and hardware checksum support.
-    1.00	2001/06/26	Added jumbo frame support.
-    1.01	2001/08/21	Added two parameters, rx_coalesce and rx_timeout.
-    1.02	2001/10/08	Supported fiber media.
-    				Added flow control parameters.
-    1.03	2001/10/12	Changed the default media to 1000mbps_fd for 
-    				the fiber devices.
-    1.04	2001/11/08	Fixed Tx stopped when tx very busy.
-    1.05	2001/11/22	Fixed Tx stopped when unidirectional tx busy.
-    1.06	2001/12/13	Fixed disconnect bug at 10Mbps mode.
-    				Fixed tx_full flag incorrect.
-				Added tx_coalesce paramter.
-    1.07	2002/01/03	Fixed miscount of RX frame error.
-    1.08	2002/01/17	Fixed the multicast bug.
-    1.09	2002/03/07	Move rx-poll-now to re-fill loop.	
-    				Added rio_timer() to watch rx buffers. 
-    1.10	2002/04/16	Fixed miscount of carrier error.
-    1.11	2002/05/23	Added ISR schedule scheme
-    				Fixed miscount of rx frame error for DGE-550SX.
-    				Fixed VLAN bug.
-    1.12	2002/06/13	Lock tx_coalesce=1 on 10/100Mbps mode.
-    1.13	2002/08/13	1. Fix disconnection (many tx:carrier/rx:frame
-    				   errs) with some mainboards.
-    				2. Use definition "DRV_NAME" "DRV_VERSION" 
-				   "DRV_RELDATE" for flexibility.	
-    1.14	2002/08/14	Support ethtool.	
-    1.15	2002/08/27	Changed the default media to Auto-Negotiation
-				for the fiber devices.    
-    1.16	2002/09/04      More power down time for fiber devices auto-
-    				negotiation.
-				Fix disconnect bug after ifup and ifdown.
-    1.17	2002/10/03	Fix RMON statistics overflow. 
-			     	Always use I/O mapping to access eeprom, 
-				avoid system freezing with some chipsets.
 
-*/
 #define DRV_NAME	"D-Link DL2000-based linux driver"
-#define DRV_VERSION	"v1.17b"
-#define DRV_RELDATE	"2006/03/10"
+#define DRV_VERSION	"v1.18"
+#define DRV_RELDATE	"2006/06/27"
 #include "dl2k.h"
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index ee34a16..8dacd0d 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -19,62 +19,15 @@
 
 	Information and updates available at
 	http://www.scyld.com/network/epic100.html
+	[this link no longer provides anything useful -jgarzik]
 
 	---------------------------------------------------------------------
 
-	Linux kernel-specific changes:
-
-	LK1.1.2 (jgarzik):
-	* Merge becker version 1.09 (4/08/2000)
-
-	LK1.1.3:
-	* Major bugfix to 1.09 driver (Francis Romieu)
-
-	LK1.1.4 (jgarzik):
-	* Merge becker test version 1.09 (5/29/2000)
-
-	LK1.1.5:
-	* Fix locking (jgarzik)
-	* Limit 83c175 probe to ethernet-class PCI devices (rgooch)
-
-	LK1.1.6:
-	* Merge becker version 1.11
-	* Move pci_enable_device before any PCI BAR len checks
-
-	LK1.1.7:
-	* { fill me in }
-
-	LK1.1.8:
-	* ethtool driver info support (jgarzik)
-
-	LK1.1.9:
-	* ethtool media get/set support (jgarzik)
-
-	LK1.1.10:
-	* revert MII transceiver init change (jgarzik)
-
-	LK1.1.11:
-	* implement ETHTOOL_[GS]SET, _NWAY_RST, _[GS]MSGLVL, _GLINK (jgarzik)
-	* replace some MII-related magic numbers with constants
-
-	LK1.1.12:
-	* fix power-up sequence
-
-	LK1.1.13:
-	* revert version 1.1.12, power-up sequence "fix"
-
-	LK1.1.14 (Kryzsztof Halasa):
-	* fix spurious bad initializations
-	* pound phy a la SMSC's app note on the subject
-
-	AC1.1.14ac
-	* fix power up/down for ethtool that broke in 1.11
-
 */
 
 #define DRV_NAME        "epic100"
-#define DRV_VERSION     "1.11+LK1.1.14+AC1.1.14"
-#define DRV_RELDATE     "June 2, 2004"
+#define DRV_VERSION     "2.0"
+#define DRV_RELDATE     "June 27, 2006"
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -205,19 +158,15 @@ typedef enum {
 
 struct epic_chip_info {
 	const char *name;
-        int io_size;                            /* Needed for I/O region check or ioremap(). */
         int drv_flags;                          /* Driver use, intended as capability flags. */
 };
 
 
 /* indexed by chip_t */
 static const struct epic_chip_info pci_id_tbl[] = {
-	{ "SMSC EPIC/100 83c170",
-	  EPIC_TOTAL_SIZE, TYPE2_INTR | NO_MII | MII_PWRDWN },
-	{ "SMSC EPIC/100 83c170",
-	  EPIC_TOTAL_SIZE, TYPE2_INTR },
-	{ "SMSC EPIC/C 83c175",
-	  EPIC_TOTAL_SIZE, TYPE2_INTR | MII_PWRDWN },
+	{ "SMSC EPIC/100 83c170",	TYPE2_INTR | NO_MII | MII_PWRDWN },
+	{ "SMSC EPIC/100 83c170",	TYPE2_INTR },
+	{ "SMSC EPIC/C 83c175",		TYPE2_INTR | MII_PWRDWN },
 };
 
 
@@ -386,8 +335,8 @@ #endif
 		goto out;
 	irq = pdev->irq;
 
-	if (pci_resource_len(pdev, 0) < pci_id_tbl[chip_idx].io_size) {
-		printk (KERN_ERR "card %d: no PCI region space\n", card_idx);
+	if (pci_resource_len(pdev, 0) < EPIC_TOTAL_SIZE) {
+		dev_printk(KERN_ERR, &pdev->dev, "no PCI region space\n");
 		ret = -ENODEV;
 		goto err_out_disable;
 	}
@@ -402,7 +351,7 @@ #endif
 
 	dev = alloc_etherdev(sizeof (*ep));
 	if (!dev) {
-		printk (KERN_ERR "card %d: no memory for eth device\n", card_idx);
+		dev_printk(KERN_ERR, &pdev->dev, "no memory for eth device\n");
 		goto err_out_free_res;
 	}
 	SET_MODULE_OWNER(dev);
@@ -414,7 +363,7 @@ #else
 	ioaddr = pci_resource_start (pdev, 1);
 	ioaddr = (long) ioremap (ioaddr, pci_resource_len (pdev, 1));
 	if (!ioaddr) {
-		printk (KERN_ERR DRV_NAME " %d: ioremap failed\n", card_idx);
+		dev_printk(KERN_ERR, &pdev->dev, "ioremap failed\n");
 		goto err_out_free_netdev;
 	}
 #endif
diff --git a/drivers/net/fealnx.c b/drivers/net/fealnx.c
index 13eca7e..958ea51 100644
--- a/drivers/net/fealnx.c
+++ b/drivers/net/fealnx.c
@@ -124,7 +124,9 @@ MODULE_PARM_DESC(multicast_filter_limit,
 MODULE_PARM_DESC(options, "fealnx: Bits 0-3: media type, bit 17: full duplex");
 MODULE_PARM_DESC(full_duplex, "fealnx full duplex setting(s) (1)");
 
-#define MIN_REGION_SIZE 136
+enum {
+	MIN_REGION_SIZE		= 136,
+};
 
 /* A chip capabilities table, matching the entries in pci_tbl[] above. */
 enum chip_capability_flags {
@@ -146,14 +148,13 @@ enum phy_type_flags {
 
 struct chip_info {
 	char *chip_name;
-	int io_size;
 	int flags;
 };
 
-static const struct chip_info skel_netdrv_tbl[] = {
-	{"100/10M Ethernet PCI Adapter", 136, HAS_MII_XCVR},
-	{"100/10M Ethernet PCI Adapter", 136, HAS_CHIP_XCVR},
-	{"1000/100/10M Ethernet PCI Adapter", 136, HAS_MII_XCVR},
+static const struct chip_info skel_netdrv_tbl[] __devinitdata = {
+ 	{ "100/10M Ethernet PCI Adapter",	HAS_MII_XCVR },
+	{ "100/10M Ethernet PCI Adapter",	HAS_CHIP_XCVR },
+	{ "1000/100/10M Ethernet PCI Adapter",	HAS_MII_XCVR },
 };
 
 /* Offsets to the Command and Status Registers. */
@@ -504,13 +505,14 @@ #endif
 	
 	len = pci_resource_len(pdev, bar);
 	if (len < MIN_REGION_SIZE) {
-		printk(KERN_ERR "%s: region size %ld too small, aborting\n",
-		       boardname, len);
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "region size %ld too small, aborting\n", len);
 		return -ENODEV;
 	}
 
 	i = pci_request_regions(pdev, boardname);
-	if (i) return i;
+	if (i)
+		return i;
 	
 	irq = pdev->irq;
 
diff --git a/drivers/net/gt96100eth.c b/drivers/net/gt96100eth.c
index 2d24354..243c9a5 100644
--- a/drivers/net/gt96100eth.c
+++ b/drivers/net/gt96100eth.c
@@ -699,7 +699,6 @@ static int __init gt96100_probe1(struct 
 	memset(gp, 0, sizeof(*gp)); // clear it
 
 	gp->port_num = port_num;
-	gp->io_size = GT96100_ETH_IO_SIZE;
 	gp->port_offset = port_num * GT96100_ETH_IO_SIZE;
 	gp->phy_addr = phy_addr;
 	gp->chip_rev = chip_rev;
@@ -1531,7 +1530,7 @@ static void gt96100_cleanup_module(void)
 				+ sizeof(gt96100_td_t) * TX_RING_SIZE,
 				gp->rx_ring);
 			free_netdev(gtif->dev);
-			release_region(gtif->iobase, gp->io_size);
+			release_region(gtif->iobase, GT96100_ETH_IO_SIZE);
 		}
 	}
 }
diff --git a/drivers/net/gt96100eth.h b/drivers/net/gt96100eth.h
index 395869c..cda81c9 100644
--- a/drivers/net/gt96100eth.h
+++ b/drivers/net/gt96100eth.h
@@ -332,7 +332,6 @@ struct gt96100_private {
 	mib_counters_t mib;
 	struct net_device_stats stats;
 
-	int io_size;
 	int port_num;  // 0 or 1
 	int chip_rev;
 	u32 port_offset;
@@ -341,7 +340,6 @@ struct gt96100_private {
 	u32 last_psr; // last value of the port status register
 
 	int options;     /* User-settable misc. driver options. */
-	int drv_flags;
 	struct timer_list timer;
 	spinlock_t lock; /* Serialise access to device */
 };
diff --git a/drivers/net/hamachi.c b/drivers/net/hamachi.c
index 0ea4cb4..2b91099 100644
--- a/drivers/net/hamachi.c
+++ b/drivers/net/hamachi.c
@@ -20,22 +20,15 @@
 
 	Support and updates available at
 	http://www.scyld.com/network/hamachi.html
+	[link no longer provides useful info -jgarzik]
 	or
 	http://www.parl.clemson.edu/~keithu/hamachi.html
 
-
-
-	Linux kernel changelog:
-
-	LK1.0.1:
-	- fix lack of pci_dev<->dev association
-	- ethtool support (jgarzik)
-
 */
 
 #define DRV_NAME	"hamachi"
-#define DRV_VERSION	"1.01+LK1.0.1"
-#define DRV_RELDATE	"5/18/2001"
+#define DRV_VERSION	"2.0"
+#define DRV_RELDATE	"June 27, 2006"
 
 
 /* A few user-configurable values. */
diff --git a/drivers/net/natsemi.c b/drivers/net/natsemi.c
index 5657049..963377c 100644
--- a/drivers/net/natsemi.c
+++ b/drivers/net/natsemi.c
@@ -20,120 +20,9 @@
 
 	Support information and updates available at
 	http://www.scyld.com/network/netsemi.html
+	[link no longer provides useful info -jgarzik]
 
 
-	Linux kernel modifications:
-
-	Version 1.0.1:
-		- Spinlock fixes
-		- Bug fixes and better intr performance (Tjeerd)
-	Version 1.0.2:
-		- Now reads correct MAC address from eeprom
-	Version 1.0.3:
-		- Eliminate redundant priv->tx_full flag
-		- Call netif_start_queue from dev->tx_timeout
-		- wmb() in start_tx() to flush data
-		- Update Tx locking
-		- Clean up PCI enable (davej)
-	Version 1.0.4:
-		- Merge Donald Becker's natsemi.c version 1.07
-	Version 1.0.5:
-		- { fill me in }
-	Version 1.0.6:
-		* ethtool support (jgarzik)
-		* Proper initialization of the card (which sometimes
-		fails to occur and leaves the card in a non-functional
-		state). (uzi)
-
-		* Some documented register settings to optimize some
-		of the 100Mbit autodetection circuitry in rev C cards. (uzi)
-
-		* Polling of the PHY intr for stuff like link state
-		change and auto- negotiation to finally work properly. (uzi)
-
-		* One-liner removal of a duplicate declaration of
-		netdev_error(). (uzi)
-
-	Version 1.0.7: (Manfred Spraul)
-		* pci dma
-		* SMP locking update
-		* full reset added into tx_timeout
-		* correct multicast hash generation (both big and little endian)
-			[copied from a natsemi driver version
-			 from Myrio Corporation, Greg Smith]
-		* suspend/resume
-
-	version 1.0.8 (Tim Hockin <thockin@sun.com>)
-		* ETHTOOL_* support
-		* Wake on lan support (Erik Gilling)
-		* MXDMA fixes for serverworks
-		* EEPROM reload
-
-	version 1.0.9 (Manfred Spraul)
-		* Main change: fix lack of synchronize
-		netif_close/netif_suspend against a last interrupt
-		or packet.
-		* do not enable superflous interrupts (e.g. the
-		drivers relies on TxDone - TxIntr not needed)
-		* wait that the hardware has really stopped in close
-		and suspend.
-		* workaround for the (at least) gcc-2.95.1 compiler
-		problem. Also simplifies the code a bit.
-		* disable_irq() in tx_timeout - needed to protect
-		against rx interrupts.
-		* stop the nic before switching into silent rx mode
-		for wol (required according to docu).
-
-	version 1.0.10:
-		* use long for ee_addr (various)
-		* print pointers properly (DaveM)
-		* include asm/irq.h (?)
-
-	version 1.0.11:
-		* check and reset if PHY errors appear (Adrian Sun)
-		* WoL cleanup (Tim Hockin)
-		* Magic number cleanup (Tim Hockin)
-		* Don't reload EEPROM on every reset (Tim Hockin)
-		* Save and restore EEPROM state across reset (Tim Hockin)
-		* MDIO Cleanup (Tim Hockin)
-		* Reformat register offsets/bits (jgarzik)
-
-	version 1.0.12:
-		* ETHTOOL_* further support (Tim Hockin)
-
-	version 1.0.13:
-		* ETHTOOL_[G]EEPROM support (Tim Hockin)
-
-	version 1.0.13:
-		* crc cleanup (Matt Domsch <Matt_Domsch@dell.com>)
-
-	version 1.0.14:
-		* Cleanup some messages and autoneg in ethtool (Tim Hockin)
-
-	version 1.0.15:
-		* Get rid of cable_magic flag
-		* use new (National provided) solution for cable magic issue
-
-	version 1.0.16:
-		* call netdev_rx() for RxErrors (Manfred Spraul)
-		* formatting and cleanups
-		* change options and full_duplex arrays to be zero
-		  initialized
-		* enable only the WoL and PHY interrupts in wol mode
-
-	version 1.0.17:
-		* only do cable_magic on 83815 and early 83816 (Tim Hockin)
-		* create a function for rx refill (Manfred Spraul)
-		* combine drain_ring and init_ring (Manfred Spraul)
-		* oom handling (Manfred Spraul)
-		* hands_off instead of playing with netif_device_{de,a}ttach
-		  (Manfred Spraul)
-		* be sure to write the MAC back to the chip (Manfred Spraul)
-		* lengthen EEPROM timeout, and always warn about timeouts
-		  (Manfred Spraul)
-		* comments update (Manfred)
-		* do the right thing on a phy-reset (Manfred and Tim)
-
 	TODO:
 	* big endian support with CFG:BEM instead of cpu_to_le32
 */
@@ -166,8 +55,8 @@ #include <asm/irq.h>
 #include <asm/uaccess.h>
 
 #define DRV_NAME	"natsemi"
-#define DRV_VERSION	"1.07+LK1.0.17"
-#define DRV_RELDATE	"Sep 27, 2002"
+#define DRV_VERSION	"2.0"
+#define DRV_RELDATE	"June 27, 2006"
 
 #define RX_OFFSET	2
 
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index c158eed..e0f1aaf 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -22,129 +22,13 @@
 
 	Support and updates available at
 	http://www.scyld.com/network/starfire.html
+	[link no longer provides useful info -jgarzik]
 
-	-----------------------------------------------------------
-
-	Linux kernel-specific changes:
-
-	LK1.1.1 (jgarzik):
-	- Use PCI driver interface
-	- Fix MOD_xxx races
-	- softnet fixups
-
-	LK1.1.2 (jgarzik):
-	- Merge Becker version 0.15
-
-	LK1.1.3 (Andrew Morton)
-	- Timer cleanups
-
-	LK1.1.4 (jgarzik):
-	- Merge Becker version 1.03
-
-	LK1.2.1 (Ion Badulescu <ionut@cs.columbia.edu>)
-	- Support hardware Rx/Tx checksumming
-	- Use the GFP firmware taken from Adaptec's Netware driver
-
-	LK1.2.2 (Ion Badulescu)
-	- Backported to 2.2.x
-
-	LK1.2.3 (Ion Badulescu)
-	- Fix the flaky mdio interface
-	- More compat clean-ups
-
-	LK1.2.4 (Ion Badulescu)
-	- More 2.2.x initialization fixes
-
-	LK1.2.5 (Ion Badulescu)
-	- Several fixes from Manfred Spraul
-
-	LK1.2.6 (Ion Badulescu)
-	- Fixed ifup/ifdown/ifup problem in 2.4.x
-
-	LK1.2.7 (Ion Badulescu)
-	- Removed unused code
-	- Made more functions static and __init
-
-	LK1.2.8 (Ion Badulescu)
-	- Quell bogus error messages, inform about the Tx threshold
-	- Removed #ifdef CONFIG_PCI, this driver is PCI only
-
-	LK1.2.9 (Ion Badulescu)
-	- Merged Jeff Garzik's changes from 2.4.4-pre5
-	- Added 2.2.x compatibility stuff required by the above changes
-
-	LK1.2.9a (Ion Badulescu)
-	- More updates from Jeff Garzik
-
-	LK1.3.0 (Ion Badulescu)
-	- Merged zerocopy support
-
-	LK1.3.1 (Ion Badulescu)
-	- Added ethtool support
-	- Added GPIO (media change) interrupt support
-
-	LK1.3.2 (Ion Badulescu)
-	- Fixed 2.2.x compatibility issues introduced in 1.3.1
-	- Fixed ethtool ioctl returning uninitialized memory
-
-	LK1.3.3 (Ion Badulescu)
-	- Initialize the TxMode register properly
-	- Don't dereference dev->priv after freeing it
-
-	LK1.3.4 (Ion Badulescu)
-	- Fixed initialization timing problems
-	- Fixed interrupt mask definitions
-
-	LK1.3.5 (jgarzik)
-	- ethtool NWAY_RST, GLINK, [GS]MSGLVL support
-
-	LK1.3.6:
-	- Sparc64 support and fixes (Ion Badulescu)
-	- Better stats and error handling (Ion Badulescu)
-	- Use new pci_set_mwi() PCI API function (jgarzik)
-
-	LK1.3.7 (Ion Badulescu)
-	- minimal implementation of tx_timeout()
-	- correctly shutdown the Rx/Tx engines in netdev_close()
-	- added calls to netif_carrier_on/off
-	(patch from Stefan Rompf <srompf@isg.de>)
-	- VLAN support
-
-	LK1.3.8 (Ion Badulescu)
-	- adjust DMA burst size on sparc64
-	- 64-bit support
-	- reworked zerocopy support for 64-bit buffers
-	- working and usable interrupt mitigation/latency
-	- reduced Tx interrupt frequency for lower interrupt overhead
-
-	LK1.3.9 (Ion Badulescu)
-	- bugfix for mcast filter
-	- enable the right kind of Tx interrupts (TxDMADone, not TxDone)
-
-	LK1.4.0 (Ion Badulescu)
-	- NAPI support
-
-	LK1.4.1 (Ion Badulescu)
-	- flush PCI posting buffers after disabling Rx interrupts
-	- put the chip to a D3 slumber on driver unload
-	- added config option to enable/disable NAPI
-
-	LK1.4.2 (Ion Badulescu)
-	- finally added firmware (GPL'ed by Adaptec)
-	- removed compatibility code for 2.2.x
-
-	LK1.4.2.1 (Ion Badulescu)
-	- fixed 32/64 bit issues on i386 + CONFIG_HIGHMEM
-	- added 32-bit padding to outgoing skb's, removed previous workaround
-
-TODO:	- fix forced speed/duplexing code (broken a long time ago, when
-	somebody converted the driver to use the generic MII code)
-	- fix VLAN support
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.4.2.1"
-#define DRV_RELDATE	"October 3, 2005"
+#define DRV_VERSION	"2.0"
+#define DRV_RELDATE	"June 27, 2006"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -847,7 +731,6 @@ #endif
 		goto err_out_free_netdev;
 	}
 
-	/* ioremap is borken in Linux-2.2.x/sparc64 */
 	base = ioremap(ioaddr, io_size);
 	if (!base) {
 		printk(KERN_ERR DRV_NAME " %d: cannot remap %#x @ %#lx, aborting\n",
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index f13b2a1..01ba7f8 100644
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -16,91 +16,13 @@
 
 	Support and updates available at
 	http://www.scyld.com/network/sundance.html
+	[link no longer provides useful info -jgarzik]
 
-
-	Version LK1.01a (jgarzik):
-	- Replace some MII-related magic numbers with constants
-
-	Version LK1.02 (D-Link):
-	- Add new board to PCI ID list
-	- Fix multicast bug
-
-	Version LK1.03 (D-Link):
-	- New Rx scheme, reduce Rx congestion
-	- Option to disable flow control
-
-	Version LK1.04 (D-Link):
-	- Tx timeout recovery
-	- More support for ethtool.
-
-	Version LK1.04a:
-	- Remove unused/constant members from struct pci_id_info
-	(which then allows removal of 'drv_flags' from private struct)
-	(jgarzik)
-	- If no phy is found, fail to load that board (jgarzik)
-	- Always start phy id scan at id 1 to avoid problems (Donald Becker)
-	- Autodetect where mii_preable_required is needed,
-	default to not needed.  (Donald Becker)
-
-	Version LK1.04b:
-	- Remove mii_preamble_required module parameter (Donald Becker)
-	- Add per-interface mii_preamble_required (setting is autodetected)
-	  (Donald Becker)
-	- Remove unnecessary cast from void pointer (jgarzik)
-	- Re-align comments in private struct (jgarzik)
-
-	Version LK1.04c (jgarzik):
-	- Support bitmapped message levels (NETIF_MSG_xxx), and the
-	  two ethtool ioctls that get/set them
-	- Don't hand-code MII ethtool support, use standard API/lib
-
-	Version LK1.04d:
-	- Merge from Donald Becker's sundance.c: (Jason Lunz)
-		* proper support for variably-sized MTUs
-		* default to PIO, to fix chip bugs
-	- Add missing unregister_netdev (Jason Lunz)
-	- Add CONFIG_SUNDANCE_MMIO config option (jgarzik)
-	- Better rx buf size calculation (Donald Becker)
-
-	Version LK1.05 (D-Link):
-	- Fix DFE-580TX packet drop issue (for DL10050C)
-	- Fix reset_tx logic
-
-	Version LK1.06 (D-Link):
-	- Fix crash while unloading driver
-
-	Versin LK1.06b (D-Link):
-	- New tx scheme, adaptive tx_coalesce
-	
-	Version LK1.07 (D-Link):
-	- Fix tx bugs in big-endian machines
-	- Remove unused max_interrupt_work module parameter, the new 
-	  NAPI-like rx scheme doesn't need it.
-	- Remove redundancy get_stats() in intr_handler(), those 
-	  I/O access could affect performance in ARM-based system
-	- Add Linux software VLAN support
-	
-	Version LK1.08 (Philippe De Muyter phdm@macqel.be):
-	- Fix bug of custom mac address 
-	(StationAddr register only accept word write) 
-
-	Version LK1.09 (D-Link):
-	- Fix the flowctrl bug.	
-	- Set Pause bit in MII ANAR if flow control enabled.	
-
-	Version LK1.09a (ICPlus):
-	- Add the delay time in reading the contents of EEPROM
-
-	Version LK1.10 (Philippe De Muyter phdm@macqel.be):
-	- Make 'unblock interface after Tx underrun' work
-
-	Version LK1.11 (Pedro Alejandro Lopez-Valencia palopezv at gmail.com):
-	- Add support for IC Plus Corporation IP100A chipset
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.01+LK1.11"
-#define DRV_RELDATE	"14-Jun-2006"
+#define DRV_VERSION	"1.1"
+#define DRV_RELDATE	"27-Jun-2006"
 
 
 /* The user-configurable values.
@@ -282,15 +204,15 @@ #ifndef CONFIG_SUNDANCE_MMIO
 #define USE_IO_OPS 1
 #endif
 
-static struct pci_device_id sundance_pci_tbl[] = {
-	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
-	{0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
-	{0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
-	{0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3},
-	{0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
-	{0,}
+static const struct pci_device_id sundance_pci_tbl[] = {
+	{ 0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0 },
+	{ 0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1 },
+	{ 0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2 },
+	{ 0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3 },
+	{ 0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+	{ 0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
+	{ 0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, sundance_pci_tbl);
 
@@ -301,7 +223,7 @@ enum {
 struct pci_id_info {
         const char *name;
 };
-static const struct pci_id_info pci_id_tbl[] = {
+static const struct pci_id_info pci_id_tbl[] __devinitdata = {
 	{"D-Link DFE-550TX FAST Ethernet Adapter"},
 	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter"},
 	{"D-Link DFE-580TX 4 port Server Adapter"},
@@ -309,7 +231,7 @@ static const struct pci_id_info pci_id_t
 	{"D-Link DL10050-based FAST Ethernet Adapter"},
 	{"Sundance Technology Alta"},
 	{"IC Plus Corporation IP100A FAST Ethernet Adapter"},
-	{NULL,},			/* 0 terminated list. */
+	{ }	/* terminate list. */
 };
 
 /* This driver was written to use PCI memory space, however x86-oriented
diff --git a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
index 602a6e5..a1e3159 100644
--- a/drivers/net/tulip/winbond-840.c
+++ b/drivers/net/tulip/winbond-840.c
@@ -224,24 +224,21 @@ static const struct pci_device_id w840_p
 };
 MODULE_DEVICE_TABLE(pci, w840_pci_tbl);
 
+enum {
+	netdev_res_size		= 128,	/* size of PCI BAR resource */
+};
+
 struct pci_id_info {
         const char *name;
-        struct match_info {
-                int     pci, pci_mask, subsystem, subsystem_mask;
-                int revision, revision_mask;                            /* Only 8 bits. */
-        } id;
-        int io_size;                            /* Needed for I/O region check or ioremap(). */
-        int drv_flags;                          /* Driver use, intended as capability flags. */
+        int drv_flags;		/* Driver use, intended as capability flags. */
 };
-static struct pci_id_info pci_id_tbl[] = {
-	{"Winbond W89c840",			/* Sometime a Level-One switch card. */
-	 { 0x08401050, 0xffffffff, 0x81530000, 0xffff0000 },
-	   128, CanHaveMII | HasBrokenTx | FDXOnNoMII},
-	{"Winbond W89c840", { 0x08401050, 0xffffffff, },
-	   128, CanHaveMII | HasBrokenTx},
-	{"Compex RL100-ATX", { 0x201111F6, 0xffffffff,},
-	   128, CanHaveMII | HasBrokenTx},
-	{NULL,},					/* 0 terminated list. */
+
+static const struct pci_id_info pci_id_tbl[] __devinitdata = {
+	{ 				/* Sometime a Level-One switch card. */
+	  "Winbond W89c840",	CanHaveMII | HasBrokenTx | FDXOnNoMII},
+	{ "Winbond W89c840",	CanHaveMII | HasBrokenTx},
+	{ "Compex RL100-ATX",	CanHaveMII | HasBrokenTx},
+	{ }	/* terminate list. */
 };
 
 /* This driver was written to use PCI memory space, however some x86 systems
@@ -399,7 +396,7 @@ static int __devinit w840_probe1 (struct
 #ifdef USE_IO_OPS
 	bar = 0;
 #endif
-	ioaddr = pci_iomap(pdev, bar, pci_id_tbl[chip_idx].io_size);
+	ioaddr = pci_iomap(pdev, bar, netdev_res_size);
 	if (!ioaddr)
 		goto err_out_free_res;
 
diff --git a/drivers/net/tulip/xircom_tulip_cb.c b/drivers/net/tulip/xircom_tulip_cb.c
index 887d724..8b5f5d8 100644
--- a/drivers/net/tulip/xircom_tulip_cb.c
+++ b/drivers/net/tulip/xircom_tulip_cb.c
@@ -10,26 +10,11 @@
 	410 Severn Ave., Suite 210
 	Annapolis MD 21403
 
-	-----------------------------------------------------------
-
-	Linux kernel-specific changes:
-
-	LK1.0 (Ion Badulescu)
-	- Major cleanup
-	- Use 2.4 PCI API
-	- Support ethtool
-	- Rewrite perfect filter/hash code
-	- Use interrupts for media changes
-
-	LK1.1 (Ion Badulescu)
-	- Disallow negotiation of unsupported full-duplex modes
 */
 
 #define DRV_NAME	"xircom_tulip_cb"
-#define DRV_VERSION	"0.91+LK1.1"
-#define DRV_RELDATE	"October 11, 2001"
-
-#define CARDBUS 1
+#define DRV_VERSION	"0.92"
+#define DRV_RELDATE	"June 27, 2006"
 
 /* A few user-configurable values. */
 
@@ -307,10 +292,10 @@ struct xircom_private {
 	struct xircom_tx_desc tx_ring[TX_RING_SIZE];
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct sk_buff* tx_skbuff[TX_RING_SIZE];
-#ifdef CARDBUS
+
 	/* The X3201-3 requires 4-byte aligned tx bufs */
 	struct sk_buff* tx_aligned_skbuff[TX_RING_SIZE];
-#endif
+
 	/* The addresses of receive-in-place skbuffs. */
 	struct sk_buff* rx_skbuff[RX_RING_SIZE];
 	u16 setup_frame[PKT_SETUP_SZ / sizeof(u16)];	/* Pseudo-Tx frame to init address table. */
@@ -909,10 +894,8 @@ static void xircom_init_ring(struct net_
 		tp->tx_skbuff[i] = NULL;
 		tp->tx_ring[i].status = 0;
 		tp->tx_ring[i].buffer2 = virt_to_bus(&tp->tx_ring[i+1]);
-#ifdef CARDBUS
 		if (tp->chip_id == X3201_3)
 			tp->tx_aligned_skbuff[i] = dev_alloc_skb(PKT_BUF_SZ);
-#endif /* CARDBUS */
 	}
 	tp->tx_ring[i-1].buffer2 = virt_to_bus(&tp->tx_ring[0]);
 }
@@ -932,12 +915,10 @@ xircom_start_xmit(struct sk_buff *skb, s
 	entry = tp->cur_tx % TX_RING_SIZE;
 
 	tp->tx_skbuff[entry] = skb;
-#ifdef CARDBUS
 	if (tp->chip_id == X3201_3) {
 		memcpy(tp->tx_aligned_skbuff[entry]->data,skb->data,skb->len);
 		tp->tx_ring[entry].buffer1 = virt_to_bus(tp->tx_aligned_skbuff[entry]->data);
 	} else
-#endif
 		tp->tx_ring[entry].buffer1 = virt_to_bus(skb->data);
 
 	if (tp->cur_tx - tp->dirty_tx < TX_RING_SIZE/2) {/* Typical path */
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index c80a4f1..a16b0d6 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -25,117 +25,13 @@
 	version. He may or may not be interested in bug reports on this
 	code. You can find his versions at:
 	http://www.scyld.com/network/via-rhine.html
-
-
-	Linux kernel version history:
-
-	LK1.1.0:
-	- Jeff Garzik: softnet 'n stuff
-
-	LK1.1.1:
-	- Justin Guyett: softnet and locking fixes
-	- Jeff Garzik: use PCI interface
-
-	LK1.1.2:
-	- Urban Widmark: minor cleanups, merges from Becker 1.03a/1.04 versions
-
-	LK1.1.3:
-	- Urban Widmark: use PCI DMA interface (with thanks to the eepro100.c
-			 code) update "Theory of Operation" with
-			 softnet/locking changes
-	- Dave Miller: PCI DMA and endian fixups
-	- Jeff Garzik: MOD_xxx race fixes, updated PCI resource allocation
-
-	LK1.1.4:
-	- Urban Widmark: fix gcc 2.95.2 problem and
-	                 remove writel's to fixed address 0x7c
-
-	LK1.1.5:
-	- Urban Widmark: mdio locking, bounce buffer changes
-	                 merges from Beckers 1.05 version
-	                 added netif_running_on/off support
-
-	LK1.1.6:
-	- Urban Widmark: merges from Beckers 1.08b version (VT6102 + mdio)
-	                 set netif_running_on/off on startup, del_timer_sync
-
-	LK1.1.7:
-	- Manfred Spraul: added reset into tx_timeout
-
-	LK1.1.9:
-	- Urban Widmark: merges from Beckers 1.10 version
-	                 (media selection + eeprom reload)
-	- David Vrabel:  merges from D-Link "1.11" version
-	                 (disable WOL and PME on startup)
-
-	LK1.1.10:
-	- Manfred Spraul: use "singlecopy" for unaligned buffers
-	                  don't allocate bounce buffers for !ReqTxAlign cards
-
-	LK1.1.11:
-	- David Woodhouse: Set dev->base_addr before the first time we call
-			   wait_for_reset(). It's a lot happier that way.
-			   Free np->tx_bufs only if we actually allocated it.
-
-	LK1.1.12:
-	- Martin Eriksson: Allow Memory-Mapped IO to be enabled.
-
-	LK1.1.13 (jgarzik):
-	- Add ethtool support
-	- Replace some MII-related magic numbers with constants
-
-	LK1.1.14 (Ivan G.):
-	- fixes comments for Rhine-III
-	- removes W_MAX_TIMEOUT (unused)
-	- adds HasDavicomPhy for Rhine-I (basis: linuxfet driver; my card
-	  is R-I and has Davicom chip, flag is referenced in kernel driver)
-	- sends chip_id as a parameter to wait_for_reset since np is not
-	  initialized on first call
-	- changes mmio "else if (chip_id==VT6102)" to "else" so it will work
-	  for Rhine-III's (documentation says same bit is correct)
-	- transmit frame queue message is off by one - fixed
-	- adds IntrNormalSummary to "Something Wicked" exclusion list
-	  so normal interrupts will not trigger the message (src: Donald Becker)
-	(Roger Luethi)
-	- show confused chip where to continue after Tx error
-	- location of collision counter is chip specific
-	- allow selecting backoff algorithm (module parameter)
-
-	LK1.1.15 (jgarzik):
-	- Use new MII lib helper generic_mii_ioctl
-
-	LK1.1.16 (Roger Luethi)
-	- Etherleak fix
-	- Handle Tx buffer underrun
-	- Fix bugs in full duplex handling
-	- New reset code uses "force reset" cmd on Rhine-II
-	- Various clean ups
-
-	LK1.1.17 (Roger Luethi)
-	- Fix race in via_rhine_start_tx()
-	- On errors, wait for Tx engine to turn off before scavenging
-	- Handle Tx descriptor write-back race on Rhine-II
-	- Force flushing for PCI posted writes
-	- More reset code changes
-
-	LK1.1.18 (Roger Luethi)
-	- No filtering multicast in promisc mode (Edward Peng)
-	- Fix for Rhine-I Tx timeouts
-
-	LK1.1.19 (Roger Luethi)
-	- Increase Tx threshold for unspecified errors
-
-	LK1.2.0-2.6 (Roger Luethi)
-	- Massive clean-up
-	- Rewrite PHY, media handling (remove options, full_duplex, backoff)
-	- Fix Tx engine race for good
-	- Craig Brind: Zero padded aligned buffers for short packets.
+	[link no longer provides useful info -jgarzik]
 
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.2.0-2.6"
-#define DRV_RELDATE	"June-10-2004"
+#define DRV_VERSION	"1.4.0"
+#define DRV_RELDATE	"June-27-2006"
 
 
 /* A few user-configurable values.
@@ -356,12 +252,11 @@ enum rhine_quirks {
 /* Beware of PCI posted writes */
 #define IOSYNC	do { ioread8(ioaddr + StationAddr); } while (0)
 
-static struct pci_device_id rhine_pci_tbl[] =
-{
-	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, }, /* VT86C100A */
-	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, }, /* VT6102 */
-	{0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, }, /* 6105{,L,LOM} */
-	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, }, /* VT6105M */
+static const struct pci_device_id rhine_pci_tbl[] = {
+	{ 0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, },	/* VT86C100A */
+	{ 0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, },	/* VT6102 */
+	{ 0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, },	/* 6105{,L,LOM} */
+	{ 0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, },	/* VT6105M */
 	{ }	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rhine_pci_tbl);
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index 09e05fe..7412400 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -231,7 +231,8 @@ static int rx_copybreak = 200;
 module_param(rx_copybreak, int, 0644);
 MODULE_PARM_DESC(rx_copybreak, "Copy breakpoint for copy-only-tiny-frames");
 
-static void velocity_init_info(struct pci_dev *pdev, struct velocity_info *vptr, struct velocity_info_tbl *info);
+static void velocity_init_info(struct pci_dev *pdev, struct velocity_info *vptr,
+			       const struct velocity_info_tbl *info);
 static int velocity_get_pci_info(struct velocity_info *, struct pci_dev *pdev);
 static void velocity_print_info(struct velocity_info *vptr);
 static int velocity_open(struct net_device *dev);
@@ -296,9 +297,9 @@ #endif				/* !CONFIG_PM */
  *	Internal board variants. At the moment we have only one
  */
 
-static struct velocity_info_tbl chip_info_table[] = {
-	{CHIP_TYPE_VT6110, "VIA Networking Velocity Family Gigabit Ethernet Adapter", 256, 1, 0x00FFFFFFUL},
-	{0, NULL}
+static const struct velocity_info_tbl chip_info_table[] __devinitdata = {
+	{CHIP_TYPE_VT6110, "VIA Networking Velocity Family Gigabit Ethernet Adapter", 1, 0x00FFFFFFUL},
+	{ }
 };
 
 /*
@@ -306,10 +307,9 @@ static struct velocity_info_tbl chip_inf
  *	device driver. Used for hotplug autoloading.
  */
 
-static struct pci_device_id velocity_id_table[] __devinitdata = {
-	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_612X,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (unsigned long) chip_info_table},
-	{0, }
+static const struct pci_device_id velocity_id_table[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_612X) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, velocity_id_table);
@@ -343,7 +343,7 @@ static char __devinit *get_chip_name(enu
 static void __devexit velocity_remove1(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 
 #ifdef CONFIG_PM
 	unsigned long flags;
@@ -688,21 +688,23 @@ static int __devinit velocity_found1(str
 	static int first = 1;
 	struct net_device *dev;
 	int i;
-	struct velocity_info_tbl *info = (struct velocity_info_tbl *) ent->driver_data;
+	const struct velocity_info_tbl *info = &chip_info_table[ent->driver_data];
 	struct velocity_info *vptr;
 	struct mac_regs __iomem * regs;
 	int ret = -ENOMEM;
 
+	/* FIXME: this driver, like almost all other ethernet drivers,
+	 * can support more than MAX_UNITS.
+	 */
 	if (velocity_nics >= MAX_UNITS) {
-		printk(KERN_NOTICE VELOCITY_NAME ": already found %d NICs.\n", 
-				velocity_nics);
+		dev_printk(KERN_NOTICE, &pdev->dev, "already found %d NICs.\n", 
+			   velocity_nics);
 		return -ENODEV;
 	}
 
 	dev = alloc_etherdev(sizeof(struct velocity_info));
-
-	if (dev == NULL) {
-		printk(KERN_ERR VELOCITY_NAME ": allocate net device failed.\n");
+	if (!dev) {
+		dev_printk(KERN_ERR, &pdev->dev, "allocate net device failed.\n");
 		goto out;
 	}
 	
@@ -710,7 +712,7 @@ static int __devinit velocity_found1(str
 	
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
-	vptr = dev->priv;
+	vptr = netdev_priv(dev);
 
 
 	if (first) {
@@ -733,17 +735,17 @@ static int __devinit velocity_found1(str
 
 	ret = velocity_get_pci_info(vptr, pdev);
 	if (ret < 0) {
-		printk(KERN_ERR VELOCITY_NAME ": Failed to find PCI device.\n");
+		/* error message already printed */
 		goto err_disable;
 	}
 
 	ret = pci_request_regions(pdev, VELOCITY_NAME);
 	if (ret < 0) {
-		printk(KERN_ERR VELOCITY_NAME ": Failed to find PCI device.\n");
+		dev_printk(KERN_ERR, &pdev->dev, "No PCI resources.\n");
 		goto err_disable;
 	}
 
-	regs = ioremap(vptr->memaddr, vptr->io_size);
+	regs = ioremap(vptr->memaddr, VELOCITY_IO_SIZE);
 	if (regs == NULL) {
 		ret = -EIO;
 		goto err_release_res;
@@ -861,13 +863,14 @@ static void __devinit velocity_print_inf
  *	discovered.
  */
 
-static void __devinit velocity_init_info(struct pci_dev *pdev, struct velocity_info *vptr, struct velocity_info_tbl *info)
+static void __devinit velocity_init_info(struct pci_dev *pdev,
+					 struct velocity_info *vptr,
+					 const struct velocity_info_tbl *info)
 {
 	memset(vptr, 0, sizeof(struct velocity_info));
 
 	vptr->pdev = pdev;
 	vptr->chip_id = info->chip_id;
-	vptr->io_size = info->io_size;
 	vptr->num_txq = info->txqueue;
 	vptr->multicast_limit = MCAM_SIZE;
 	spin_lock_init(&vptr->lock);
@@ -885,8 +888,7 @@ static void __devinit velocity_init_info
 
 static int __devinit velocity_get_pci_info(struct velocity_info *vptr, struct pci_dev *pdev)
 {
-
-	if(pci_read_config_byte(pdev, PCI_REVISION_ID, &vptr->rev_id) < 0)
+	if (pci_read_config_byte(pdev, PCI_REVISION_ID, &vptr->rev_id) < 0)
 		return -EIO;
 		
 	pci_set_master(pdev);
@@ -894,24 +896,20 @@ static int __devinit velocity_get_pci_in
 	vptr->ioaddr = pci_resource_start(pdev, 0);
 	vptr->memaddr = pci_resource_start(pdev, 1);
 	
-	if(!(pci_resource_flags(pdev, 0) & IORESOURCE_IO))
-	{
-		printk(KERN_ERR "%s: region #0 is not an I/O resource, aborting.\n",
-				pci_name(pdev));
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_IO)) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "region #0 is not an I/O resource, aborting.\n");
 		return -EINVAL;
 	}
 
-	if((pci_resource_flags(pdev, 1) & IORESOURCE_IO))
-	{
-		printk(KERN_ERR "%s: region #1 is an I/O resource, aborting.\n",
-				pci_name(pdev));
+	if ((pci_resource_flags(pdev, 1) & IORESOURCE_IO)) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "region #1 is an I/O resource, aborting.\n");
 		return -EINVAL;
 	}
 
-	if(pci_resource_len(pdev, 1) < 256)
-	{
-		printk(KERN_ERR "%s: region #1 is too small.\n", 
-				pci_name(pdev));
+	if (pci_resource_len(pdev, 1) < VELOCITY_IO_SIZE) {
+		dev_printk(KERN_ERR, &pdev->dev, "region #1 is too small.\n");
 		return -EINVAL;
 	}
 	vptr->pdev = pdev;
@@ -1730,7 +1728,7 @@ #endif
  
 static int velocity_open(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	int ret;
 
 	vptr->rx_buf_sz = (dev->mtu <= 1504 ? PKT_BUF_SZ : dev->mtu + 32);
@@ -1787,7 +1785,7 @@ err_free_desc_rings:
  
 static int velocity_change_mtu(struct net_device *dev, int new_mtu)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	unsigned long flags;
 	int oldmtu = dev->mtu;
 	int ret = 0;
@@ -1863,7 +1861,7 @@ static void velocity_shutdown(struct vel
 
 static int velocity_close(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 
 	netif_stop_queue(dev);
 	velocity_shutdown(vptr);
@@ -1896,7 +1894,7 @@ static int velocity_close(struct net_dev
  
 static int velocity_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	int qnum = 0;
 	struct tx_desc *td_ptr;
 	struct velocity_td_info *tdinfo;
@@ -2051,7 +2049,7 @@ #endif
 static int velocity_intr(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_instance;
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	u32 isr_status;
 	int max_count = 0;
 
@@ -2106,7 +2104,7 @@ static int velocity_intr(int irq, void *
  
 static void velocity_set_multi(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	struct mac_regs __iomem * regs = vptr->mac_regs;
 	u8 rx_mode;
 	int i;
@@ -2155,7 +2153,7 @@ static void velocity_set_multi(struct ne
  
 static struct net_device_stats *velocity_get_stats(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	
 	/* If the hardware is down, don't touch MII */
 	if(!netif_running(dev))
@@ -2198,7 +2196,7 @@ static struct net_device_stats *velocity
  
 static int velocity_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	int ret;
 
 	/* If we are asked for information and the device is power
@@ -2827,7 +2825,7 @@ static void enable_flow_control_ability(
  
 static int velocity_ethtool_up(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	if (!netif_running(dev))
 		pci_set_power_state(vptr->pdev, PCI_D0);
 	return 0;
@@ -2843,14 +2841,14 @@ static int velocity_ethtool_up(struct ne
  
 static void velocity_ethtool_down(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	if (!netif_running(dev))
 		pci_set_power_state(vptr->pdev, PCI_D3hot);
 }
 
 static int velocity_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	struct mac_regs __iomem * regs = vptr->mac_regs;
 	u32 status;
 	status = check_connection_type(vptr->mac_regs);
@@ -2875,7 +2873,7 @@ static int velocity_get_settings(struct 
 
 static int velocity_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	u32 curr_status;
 	u32 new_status = 0;
 	int ret = 0;
@@ -2898,14 +2896,14 @@ static int velocity_set_settings(struct 
 
 static u32 velocity_get_link(struct net_device *dev)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	struct mac_regs __iomem * regs = vptr->mac_regs;
 	return BYTE_REG_BITS_IS_ON(PHYSR0_LINKGD, &regs->PHYSR0)  ? 0 : 1;
 }
 
 static void velocity_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	strcpy(info->driver, VELOCITY_NAME);
 	strcpy(info->version, VELOCITY_VERSION);
 	strcpy(info->bus_info, pci_name(vptr->pdev));
@@ -2913,7 +2911,7 @@ static void velocity_get_drvinfo(struct 
 
 static void velocity_ethtool_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	wol->supported = WAKE_PHY | WAKE_MAGIC | WAKE_UCAST | WAKE_ARP;
 	wol->wolopts |= WAKE_MAGIC;
 	/*
@@ -2929,7 +2927,7 @@ static void velocity_ethtool_get_wol(str
 
 static int velocity_ethtool_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 
 	if (!(wol->wolopts & (WAKE_PHY | WAKE_MAGIC | WAKE_UCAST | WAKE_ARP)))
 		return -EFAULT;
@@ -2994,7 +2992,7 @@ static struct ethtool_ops velocity_ethto
  
 static int velocity_mii_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct velocity_info *vptr = dev->priv;
+	struct velocity_info *vptr = netdev_priv(dev);
 	struct mac_regs __iomem * regs = vptr->mac_regs;
 	unsigned long flags;
 	struct mii_ioctl_data *miidata = if_mii(ifr);
diff --git a/drivers/net/via-velocity.h b/drivers/net/via-velocity.h
index f1b2640..496c3d5 100644
--- a/drivers/net/via-velocity.h
+++ b/drivers/net/via-velocity.h
@@ -31,6 +31,8 @@ #define VELOCITY_NAME          "via-velo
 #define VELOCITY_FULL_DRV_NAM  "VIA Networking Velocity Family Gigabit Ethernet Adapter Driver"
 #define VELOCITY_VERSION       "1.13"
 
+#define VELOCITY_IO_SIZE	256
+
 #define PKT_BUF_SZ          1540
 
 #define MAX_UNITS           8
@@ -1191,7 +1193,6 @@ enum chip_type {
 struct velocity_info_tbl {
 	enum chip_type chip_id;
 	char *name;
-	int io_size;
 	int txqueue;
 	u32 flags;
 };
@@ -1751,7 +1752,6 @@ struct velocity_info {
 	struct mac_regs __iomem * mac_regs;
 	unsigned long memaddr;
 	unsigned long ioaddr;
-	u32 io_size;
 
 	u8 rev_id;
 
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index 569305f..116636b 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -19,37 +19,13 @@
 
 	Support and updates available at
 	http://www.scyld.com/network/yellowfin.html
+	[link no longer provides useful info -jgarzik]
 
-
-	Linux kernel changelog:
-	-----------------------
-
-	LK1.1.1 (jgarzik): Port to 2.4 kernel
-
-	LK1.1.2 (jgarzik):
-	* Merge in becker version 1.05
-
-	LK1.1.3 (jgarzik):
-	* Various cleanups
-	* Update yellowfin_timer to correctly calculate duplex.
-	(suggested by Manfred Spraul)
-
-	LK1.1.4 (val@nmt.edu):
-	* Fix three endian-ness bugs
-	* Support dual function SYM53C885E ethernet chip
-	
-	LK1.1.5 (val@nmt.edu):
-	* Fix forced full-duplex bug I introduced
-
-	LK1.1.6 (val@nmt.edu):
-	* Only print warning on truly "oversized" packets
-	* Fix theoretical bug on gigabit cards - return to 1.1.3 behavior
-	
 */
 
 #define DRV_NAME	"yellowfin"
-#define DRV_VERSION	"1.05+LK1.1.6"
-#define DRV_RELDATE	"Feb 11, 2002"
+#define DRV_VERSION	"2.0"
+#define DRV_RELDATE	"Jun 27, 2006"
 
 #define PFX DRV_NAME ": "
 
@@ -239,8 +215,11 @@ enum capability_flags {
 	HasMACAddrBug=32, /* Only on early revs.  */
 	DontUseEeprom=64, /* Don't read the MAC from the EEPROm. */
 };
+
 /* The PCI I/O space extent. */
-#define YELLOWFIN_SIZE 0x100
+enum {
+	YELLOWFIN_SIZE	= 0x100,
+};
 
 struct pci_id_info {
         const char *name;
@@ -248,16 +227,14 @@ struct pci_id_info {
                 int     pci, pci_mask, subsystem, subsystem_mask;
                 int revision, revision_mask;                            /* Only 8 bits. */
         } id;
-        int io_size;                            /* Needed for I/O region check or ioremap(). */
         int drv_flags;                          /* Driver use, intended as capability flags. */
 };
 
 static const struct pci_id_info pci_id_tbl[] = {
 	{"Yellowfin G-NIC Gigabit Ethernet", { 0x07021000, 0xffffffff},
-	 YELLOWFIN_SIZE,
 	 FullTxStatus | IsGigabit | HasMulticastBug | HasMACAddrBug | DontUseEeprom},
 	{"Symbios SYM83C885", { 0x07011000, 0xffffffff},
-	 YELLOWFIN_SIZE, HasMII | DontUseEeprom },
+	  HasMII | DontUseEeprom },
 	{ }
 };
 
