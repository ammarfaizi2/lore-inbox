Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWEDX7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWEDX7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWEDX7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:59:32 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62127 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751485AbWEDX7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:59:31 -0400
Date: Fri, 5 May 2006 01:55:49 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
Message-ID: <20060504235549.GA9128@electric-eye.fr.zoreil.com>
References: <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI> <20060502214520.GC26357@electric-eye.fr.zoreil.com> <20060502215559.GA1119@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI> <20060503233558.GA27232@electric-eye.fr.zoreil.com> <1146750276.11422.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146750276.11422.0.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> :
[...]
> My initial patches are here:
> 
> http://www.cs.helsinki.fi/u/penberg/linux/ip1000/

Nice. Thanks.

> I consider your tree the master now. Please let me know when you have
> recreated the history, so I can clone your tree. Thanks.

The new serie is available in branch 'netdev-ipg' at
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git

Former branch 'netdev-ipg' was moved to 'netdev-ipg.log'.

I have added a new patch (see (way) below).

$ git log master..

commit 17adeb85054a693224a2ab7787a224c722bdd4eb
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Fri May 5 01:42:12 2006 +0200

    ip1000: ethtool {get/set}_settings support
    
    The patch shoehorns the driver into the usual mii/ethtool framework.
    mii_mutex will prove useful when the link management tasks issued in
    irq context are moved to user/workqueue context. Next step.
    
    At least the current code should not be _too_ broken.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 997a02f4c4b3cf2ec0177ba33ffda6d550396eb7
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Thu May 4 00:29:59 2006 +0200

    ip1000: remove forward declarations
    
    It makes no sense in a new driver.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit b141c4ec3572f3151b2eb037ef5e7aba8d190445
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Thu May 4 00:04:57 2006 +0200

    ip1000: replace #define with enum
    
    Added some underscores to improve readability.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 9d27e1ab51b2295d72ea254bbc8de5b5797a4139
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Wed May 3 22:51:16 2006 +0200

    ip1000: removal of useless #defines
    
    IPG_TX_NOTBUSY apart (one occurence in ipg.c), the #defines appear
    nowhere in the sources.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 42ad0c39990c1897ee56dfc34bb4a7b2de76ace0
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Wed May 3 22:44:47 2006 +0200

    ip1000: redundancy with mii.h - take II
    
    Replace a bunch of #define with their counterpart from mii.h
    
    It is applied to the usual MII registers this time.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit be97a643f5d955208c0be7aa9e16a05c7737a2be
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 23:25:44 2006 +0200

    ip1000: redundancy with mii.h
    
    Replace a bunch of #define with their counterpart from mii.h
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 273a5a5f0815a35cf06faeafea6fc47503d364cb
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 22:15:34 2006 +0200

    ip1000: sanitize the pci device table
    
    - vendor id belong to include/linux/pci_id.h ;
    - the pci table does not include all the devices in nics_supported ;
    - qualify the pci table as __devinitdata ;
    - kill 50 LOC.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit e1e773d79369783d68fd7f66fffbe154929df837
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 01:07:48 2006 +0200

    ip1000: plug leaks in the error path of ipg_nic_open
    
    Added ipg_{rx/tx}_clear() to factor out some code.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 9cb655fddfd2d169bc7574e849fa5eb179fef12c
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 00:15:54 2006 +0200

    ip1000: leaks in ipg_probe
    
    The error paths are badly broken.
    
    Bonus:
    - remove duplicate initialization of sp;
    - remove useless NULL initialization of dev;
    - USE_IO_OPS is not used (and the driver does not seem to care about
      posted writes, rejoice).
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 2b5d40c1c4cf795c31d2683bcdff646a8984115d
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Mon May 1 23:52:37 2006 +0200

    ip1000: removal of unreachable code
    
    map/unmap is done in ipg_{probe/remove}
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 5b8bde4d4c02e3d54672d0c431941d9357c35417
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Mon May 1 22:40:29 2006 +0200

    ip1000: speed-up access to the PHY registers
    
    Reduce delays when reading/writing the PHY registers so we clock the
    MII management interface at 2.5 MHz (the maximum according to the
    datasheet) instead of 500 Hz.
    
    Signed-off-by: David Vrabel <dvrabel@cantab.net>

commit d4a621ceadb0e4ee83a644be4ffef8bdef687249
Author: David Vrabel <dvrabel@cantab.net>
Date:   Mon May 1 21:34:19 2006 +0200

    ip1000: root_dev removal and PHY initialization
    
    - Remove ether_crc_le() -- use crc32_le() instead.
    - No more nonsense with root_dev -- ipg_remove() now works.
    - Move PHY and MAC address initialization into the ipg_probe().
      It was previously filling in the MAC address on open which breaks
      some user space.
    - Folded ipg_nic_init into ipg_probe since it was broke otherwise.
    
    Signed-off-by: David Vrabel <dvrabel@cantab.net>

commit ae6f7b51bfb69a60062d390f10c83396c37f0301
Author: David Vrabel <dvrabel@cantab.net>
Date:   Mon May 1 13:20:49 2006 +0200

    ip1000: remove changelogs
    
    Signed-off-by: David Vrabel <dvrabel@cantab.net>

commit 7aeb86e2db5deac7d8357d6d794550999fd5e7c6
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 12:45:16 2006 +0300

    ip1000: alloc_etherdev already allocates memory for private data
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit 49b94ecdf8124c988160585d460b1cc643ee07e0
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 12:42:02 2006 +0300

    ip1000: remove unused forward declarations
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit e85531a2d8c23b6ff17b3a8cd6d14e6c09954240
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 12:16:58 2006 +0300

    ip1000: interrupt handler code cleanups
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit 822b9f528c47df857514e33d1ad98a9a551a3b00
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 12:05:09 2006 +0300

    ip1000: rename baseaddr to ioaddr
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit e8e5f8dece06429793074df6f956a8c4cb60c362
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 12:02:51 2006 +0300

    ip1000: remove device register write macros
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit 8e1a207d9e0d355aa2949ef4e5710e8c8987b01b
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 11:41:01 2006 +0300

    ip1000: kill obfuscating register read macros
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit fd3e0c5b3599375024e1e7fc3ddb00f7f5bc0c53
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sun Apr 30 00:03:23 2006 +0300

    ip1000: use iomap for pio/mmio
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit 7ed56b01680978afc5db87f684de81398366bf84
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sat Apr 29 14:02:34 2006 +0300

    ip1000: use static for private symbols
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit b83bac329befd061bb66377d33b1efd4dd39a931
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sat Apr 29 13:19:36 2006 +0300

    ip1000: sparse fixes
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit 65229dd8a40d887364f3aa60277ac3f0e8c64041
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sat Apr 29 13:06:27 2006 +0300

    ip1000: iomem annotations
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

commit d79a8a846188eee278f5b490b7f15c070f1245d4
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Sat Apr 29 12:41:45 2006 +0300

    ip1000: new gigabit ethernet device driver
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

----------------8<-----------------------------------------------------------

Patch of the day:

The patch shoehorns the driver into the usual mii/ethtool framework.
mii_mutex will prove useful when the link management tasks issued in
irq context are moved to user/workqueue context. Next step.

At least the current code should not be _too_ broken.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

---

 drivers/net/ipg.c |  344 ++++++++++++++++++++---------------------------------
 drivers/net/ipg.h |    3 
 2 files changed, 130 insertions(+), 217 deletions(-)

8e15d782fa4a0f483a71faec7ba17697d9397e76
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 31cde6c..5d19269 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -15,7 +15,9 @@
  * craig_rich@sundanceti.com
  */
 #include <linux/crc32.h>
+#include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/mutex.h>
 
 #define IPG_RX_RING_BYTES	(sizeof(struct RFD) * IPG_RFDLIST_LENGTH)
 #define IPG_TX_RING_BYTES	(sizeof(struct TFD) * IPG_TFDLIST_LENGTH)
@@ -161,8 +163,7 @@ static u16 read_phy_bit(void __iomem * i
 	return bit_data;
 }
 
-u16 read_phy_register(struct net_device * dev,
-		      int phy_address, int phy_register)
+static int mdio_read(struct net_device * dev, int phy_address, int phy_register)
 {
 	/* Read a register from the Physical Layer device located
 	 * on the IPG NIC, using the IPG PHYCTRL register.
@@ -176,7 +177,7 @@ u16 read_phy_register(struct net_device 
 	u8 databit;
 	u8 phyctrlpolarity;
 
-	IPG_DEBUG_MSG("read_phy_register\n");
+	IPG_DEBUG_MSG("mdio_read\n");
 
 	/* The GMII mangement frame structure for a read is as follows:
 	 *
@@ -274,8 +275,8 @@ u16 read_phy_register(struct net_device 
 	return field[6];
 }
 
-static void write_phy_register(struct net_device *dev,
-			       int phy_address, int phy_register, u16 writeval)
+static void mdio_write(struct net_device *dev,
+		       int phy_address, int phy_register, int val)
 {
 	/* Write to a register from the Physical Layer device located
 	 * on the IPG NIC, using the IPG PHYCTRL register.
@@ -289,7 +290,7 @@ static void write_phy_register(struct ne
 	u8 databit;
 	u8 phyctrlpolarity;
 
-	IPG_DEBUG_MSG("write_phy_register\n");
+	IPG_DEBUG_MSG("mdio_write\n");
 
 	/* The GMII mangement frame structure for a read is as follows:
 	 *
@@ -318,7 +319,7 @@ static void write_phy_register(struct ne
 	fieldlen[4] = 5;	/* REGAD */
 	field[5] = 0x0002;
 	fieldlen[5] = 2;	/* TA */
-	field[6] = writeval;
+	field[6] = val & 0xffff;
 	fieldlen[6] = 16;	/* DATA */
 	field[7] = 0x0000;
 	fieldlen[7] = 1;	/* IDLE */
@@ -486,7 +487,7 @@ static int ipg_tmi_fiber_detect(struct n
 
 	IPG_DEBUG_MSG("_tmi_fiber_detect\n");
 
-	phyid = read_phy_register(dev, phyaddr, MII_PHYSID1);
+	phyid = mdio_read(dev, phyaddr, MII_PHYSID1);
 
 	IPG_DEBUG_MSG("PHY ID = %x\n", phyid);
 
@@ -497,15 +498,14 @@ static int ipg_tmi_fiber_detect(struct n
 }
 #endif
 
+/* Find the GMII PHY address. */
 static int ipg_find_phyaddr(struct net_device *dev)
 {
-	/* Find the GMII PHY address. */
-
-	int i;
-	int phyaddr;
-	u32 status;
+	int phyaddr, i;
 
 	for (i = 0; i < 32; i++) {
+		u32 status;
+
 		/* Search for the correct PHY address among 32 possible. */
 		phyaddr = (IPG_NIC_PHY_ADDRESS + i) % 32;
 
@@ -513,13 +513,13 @@ static int ipg_find_phyaddr(struct net_d
 		   GMII_PHY_ID1
 		 */
 
-		status = read_phy_register(dev, phyaddr, MII_BMSR);
+		status = mdio_read(dev, phyaddr, MII_BMSR);
 
 		if ((status != 0xFFFF) && (status != 0))
 			return phyaddr;
 	}
 
-	return -1;
+	return 0x1f;
 }
 
 #ifdef NOTGRACE
@@ -618,10 +618,11 @@ #endif
 		       dev->name);
 		return -EILSEQ;
 	}
+	sp->mii_if.phy_id = phyaddr;
 
 	IPG_DEBUG_MSG("GMII/MII PHY address = %x\n", phyaddr);
 
-	status = read_phy_register(dev, phyaddr, MII_BMSR);
+	status = mdio_read(dev, phyaddr, MII_BMSR);
 
 	printk("PHYStatus = %x \n", status);
 	if ((status & BMSR_ANEGCAPABLE) == 0) {
@@ -631,8 +632,8 @@ #endif
 		return -EILSEQ;
 	}
 
-	advertisement = read_phy_register(dev, phyaddr, MII_ADVERTISE);
-	linkpartner_ability = read_phy_register(dev, phyaddr, MII_LPA);
+	advertisement = mdio_read(dev, phyaddr, MII_ADVERTISE);
+	linkpartner_ability = mdio_read(dev, phyaddr, MII_LPA);
 
 	printk("PHYadvertisement=%x LinkPartner=%x \n", advertisement,
 	       linkpartner_ability);
@@ -660,8 +661,8 @@ #endif
 			/* In 1000BASE-X using IPG's internal PCS
 			 * layer, so write to the GMII duplex bit.
 			 */
-			write_phy_register(dev, phyaddr, MII_BMCR,
-				read_phy_register(dev, phyaddr, MII_BMCR) |
+			mdio_write(dev, phyaddr, MII_BMCR,
+				mdio_read(dev, phyaddr, MII_BMCR) |
 					   ADVERTISE_1000HALF); // Typo ?
 
 		} else {
@@ -670,8 +671,8 @@ #endif
 			/* In 1000BASE-X using IPG's internal PCS
 			 * layer, so write to the GMII duplex bit.
 			 */
-			write_phy_register(dev, phyaddr, MII_BMCR,
-				read_phy_register(dev, phyaddr, MII_BMCR) &
+			mdio_write(dev, phyaddr, MII_BMCR,
+				mdio_read(dev, phyaddr, MII_BMCR) &
 					   ~ADVERTISE_1000HALF); // Typo ?
 		}
 	}
@@ -683,10 +684,8 @@ #endif
 		 * link partner abilities exchanged via next page
 		 * transfers.
 		 */
-		gigadvertisement =
-			read_phy_register(dev, phyaddr, MII_CTRL1000);
-		giglinkpartner_ability =
-			read_phy_register(dev, phyaddr, MII_STAT1000);
+		gigadvertisement = mdio_read(dev, phyaddr, MII_CTRL1000);
+		giglinkpartner_ability = mdio_read(dev, phyaddr, MII_STAT1000);
 
 		/* Compare the full duplex bits in the 1000BASE-T GMII
 		 * registers for the local device, and the link partner.
@@ -795,11 +794,10 @@ #define LPA_PAUSE_ANY	(LPA_1000XPAUSE_AS
 			/* PAUSE is not being advertised. Advertise
 			 * PAUSE and restart auto-negotiation.
 			 */
-			write_phy_register(dev, phyaddr, MII_ADVERTISE,
+			mdio_write(dev, phyaddr, MII_ADVERTISE,
 				(advertisement |
 				 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM));
-			write_phy_register(dev, phyaddr, MII_BMCR,
-					   BMCR_ANRESTART);
+			mdio_write(dev, phyaddr, MII_BMCR, BMCR_ANRESTART);
 
 			return -EAGAIN;
 		}
@@ -845,10 +843,9 @@ #define LPA_PAUSE_ANY	(LPA_1000XPAUSE_AS
 			/* PAUSE is not being advertised. Advertise
 			 * PAUSE and restart auto-negotiation.
 			 */
-			write_phy_register(dev, phyaddr, MII_ADVERTISE,
-					   advertisement | ADVERTISE_PAUSE_CAP);
-			write_phy_register(dev, phyaddr, MII_BMCR,
-					   BMCR_ANRESTART);
+			mdio_write(dev, phyaddr, MII_ADVERTISE,
+				   advertisement | ADVERTISE_PAUSE_CAP);
+			mdio_write(dev, phyaddr, MII_BMCR, BMCR_ANRESTART);
 			return -EAGAIN;
 		}
 
@@ -2671,8 +2668,7 @@ static void ipg_set_phy_default_param(un
 				address = *phy_param;
 				value = *(phy_param + 1);
 				phy_param += 2;
-				write_phy_register(dev,
-						   phy_address, address, value);
+				mdio_write(dev, phy_address, address, value);
 				length -= 4;
 			}
 
@@ -2710,14 +2706,47 @@ static int read_eeprom(struct net_device
 	return ret;
 }
 
+static void ipg_init_mii(struct net_device *dev)
+{
+	struct ipg_nic_private *sp = netdev_priv(dev);
+	struct mii_if_info *mii_if = &sp->mii_if;
+	int phyaddr;
+
+	mii_if->dev          = dev;
+	mii_if->mdio_read    = mdio_read;
+	mii_if->mdio_write   = mdio_write;
+	mii_if->phy_id_mask  = 0x1f;
+	mii_if->reg_num_mask = 0x1f;
+
+	mii_if->phy_id = phyaddr = ipg_find_phyaddr(dev);
+
+	if (phyaddr != 0x1f) {
+		u16 mii_phyctrl, mii_1000cr;
+		u8 revisionid = 0;
+
+		mii_1000cr  = mdio_read(dev, phyaddr, MII_CTRL1000);
+		mii_1000cr |= ADVERTISE_1000FULL | ADVERTISE_1000HALF |
+			GMII_PHY_1000BASETCONTROL_PreferMaster;
+		mdio_write(dev, phyaddr, MII_CTRL1000, mii_1000cr);
+
+		mii_phyctrl = mdio_read(dev, phyaddr, MII_BMCR);
+
+		/* Set default phyparam */
+		pci_read_config_byte(sp->pdev, PCI_REVISION_ID, &revisionid);
+		ipg_set_phy_default_param(revisionid, dev, phyaddr);
+
+		/* Reset PHY */
+		mii_phyctrl |= BMCR_RESET | BMCR_ANRESTART;
+		mdio_write(dev, phyaddr, MII_BMCR, mii_phyctrl);
+
+	}
+}
+
 static int ipg_hw_init(struct net_device *dev)
 {
-	int phyaddr = 0;
-	int error = 0;
-	int i;
-	void __iomem *ioaddr = ipg_ioaddr(dev);
-	u8 revisionid = 0;
 	struct ipg_nic_private *sp = netdev_priv(dev);
+	void __iomem *ioaddr = sp->ioaddr;
+	int i, rc;
 
 	/* Reset all functions within the IPG. Do not assert
 	 * RST_OUT as not compatible with some PHYs.
@@ -2729,34 +2758,11 @@ static int ipg_hw_init(struct net_device
 	/* Read LED Mode Configuration from EEPROM */
 	sp->LED_Mode = read_eeprom(dev, 6);
 
-	error = ipg_reset(dev, i);
-	if (error < 0) {
-		return error;
-	}
-
-	ioaddr = ipg_ioaddr(dev);
-
-	/* Reset PHY. */
-	phyaddr = ipg_find_phyaddr(dev);
-
-	if (phyaddr != -1) {
-		u16 mii_phyctrl, mii_1000cr;
-		mii_1000cr =
-			read_phy_register(dev, phyaddr, MII_CTRL1000);
-		write_phy_register(dev, phyaddr, MII_CTRL1000,
-			mii_1000cr | ADVERTISE_1000FULL | ADVERTISE_1000HALF |
-				   GMII_PHY_1000BASETCONTROL_PreferMaster);
-
-		mii_phyctrl = read_phy_register(dev, phyaddr, MII_BMCR);
-		/* Set default phyparam */
-		pci_read_config_byte(sp->pdev, PCI_REVISION_ID, &revisionid);
-		ipg_set_phy_default_param(revisionid, dev, phyaddr);
-
-		/* reset Phy */
-		write_phy_register(dev, phyaddr, MII_BMCR,
-			(mii_phyctrl | BMCR_RESET | BMCR_ANRESTART));
+	rc = ipg_reset(dev, i);
+	if (rc < 0)
+		goto out;
 
-	}
+	ipg_init_mii(dev);
 
 	/* Read MAC Address from EERPOM Jesse20040128EEPROM_VALUE */
 	sp->StationAddr0 = read_eeprom(dev, 16);
@@ -2774,161 +2780,21 @@ static int ipg_hw_init(struct net_device
 	dev->dev_addr[3] = (ioread16(ioaddr + STATION_ADDRESS_1) & 0xff00) >> 8;
 	dev->dev_addr[4] =  ioread16(ioaddr + STATION_ADDRESS_2) & 0x00ff;
 	dev->dev_addr[5] = (ioread16(ioaddr + STATION_ADDRESS_2) & 0xff00) >> 8;
-
-	return 0;
+out:
+	return rc;
 }
 
-static int ipg_nic_do_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
+static int ipg_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	/* IOCTL commands for IPG NIC.
-	 *
-	 * SIOCDEVPRIVATE       nothing
-	 * SIOCDEVPRIVATE+1     register read
-	 *                      ifr_data[0] = 0x08, 0x10, 0x20
-	 *                      ifr_data[1] = register offset
-	 *                      ifr_data[2] = value read
-	 * SIOCDEVPRIVATE+2     register write
-	 *                      ifr_data[0] = 0x08, 0x10, 0x20
-	 *                      ifr_data[1] = register offset
-	 *                      ifr_data[2] = value to write
-	 * SIOCDEVPRIVATE+3     GMII register read
-	 *                      ifr_data[1] = register offset
-	 * SIOCDEVPRIVATE+4     GMII register write
-	 *                      ifr_data[1] = register offset
-	 *                      ifr_data[2] = value to write
-	 * SIOCDEVPRIVATE+5     PCI register read
-	 *                      ifr_data[0] = 0x08, 0x10, 0x20
-	 *                      ifr_data[1] = register offset
-	 *                      ifr_data[2] = value read
-	 * SIOCDEVPRIVATE+6     PCI register write
-	 *                      ifr_data[0] = 0x08, 0x10, 0x20
-	 *                      ifr_data[1] = register offset
-	 *                      ifr_data[2] = value to write
-	 *
-	 */
-
-	u8 val8;
-	u16 val16;
-	u32 val32;
-	unsigned int *data;
-	int phyaddr = 0;
-	void __iomem *ioaddr = ipg_ioaddr(dev);
 	struct ipg_nic_private *sp = netdev_priv(dev);
+	struct mii_ioctl_data *data = if_mii(ifr);
+	int rc;
 
-	IPG_DEBUG_MSG("_nic_do_ioctl\n");
-
-	data = (unsigned int *)&req->ifr_data;
-
-	switch (cmd) {
-	case SIOCDEVPRIVATE:
-		return 0;
-
-	case SIOCDEVPRIVATE + 1:
-		switch (data[0]) {
-		case 0x08:
-			data[2] = ioread8(ioaddr + data[1]);
-			return 0;
-
-		case 0x10:
-			data[2] = ioread16(ioaddr + data[1]);
-			return 0;
-
-		case 0x20:
-			data[2] = ioread32(ioaddr + data[1]);
-			return 0;
-
-		default:
-			data[2] = 0x00;
-			return -EINVAL;
-		}
-
-	case SIOCDEVPRIVATE + 2:
-		switch (data[0]) {
-		case 0x08:
-			iowrite8(data[2], ioaddr + data[1]);
-			return 0;
-
-		case 0x10:
-			iowrite16(data[2], ioaddr + data[1]);
-			return 0;
-
-		case 0x20:
-			iowrite32(data[2], ioaddr + data[1]);
-			return 0;
-
-		default:
-			return -EINVAL;
-		}
-
-	case SIOCDEVPRIVATE + 3:
-		phyaddr = ipg_find_phyaddr(dev);
-
-		if (phyaddr == -1)
-			return -EINVAL;
-
-		data[2] = read_phy_register(dev, phyaddr, data[1]);
-
-		return 0;
-
-	case SIOCDEVPRIVATE + 4:
-		phyaddr = ipg_find_phyaddr(dev);
-
-		if (phyaddr == -1)
-			return -EINVAL;
-
-		write_phy_register(dev, phyaddr, data[1], (u16) data[2]);
-
-		return 0;
-
-	case SIOCDEVPRIVATE + 5:
-		switch (data[0]) {
-		case 0x08:
-			pci_read_config_byte(sp->pdev, data[1], &val8);
-			data[2] = (unsigned int)val8;
-			return 0;
-
-		case 0x10:
-			pci_read_config_word(sp->pdev, data[1], &val16);
-			data[2] = (unsigned int)val16;
-			return 0;
-
-		case 0x20:
-			pci_read_config_dword(sp->pdev, data[1], &val32);
-			data[2] = (unsigned int)val32;
-			return 0;
-
-		default:
-			data[2] = 0x00;
-			return -EINVAL;
-		}
-
-	case SIOCDEVPRIVATE + 6:
-		switch (data[0]) {
-		case 0x08:
-			pci_write_config_byte(sp->pdev, data[1], (u8) data[2]);
-			return 0;
-
-		case 0x10:
-			pci_write_config_word(sp->pdev, data[1], (u16) data[2]);
-			return 0;
-
-		case 0x20:
-			pci_write_config_dword(sp->pdev, data[1],
-					       (u32) data[2]);
-			return 0;
+	mutex_lock(&sp->mii_mutex);
+	rc = generic_mii_ioctl(&sp->mii_if, data, cmd, NULL);
+	mutex_unlock(&sp->mii_mutex);
 
-		default:
-			return -EINVAL;
-		}
-
-	case SIOCSIFMTU:
-		{
-			return 0;
-		}
-
-	default:
-		return -EOPNOTSUPP;
-	}
+	return rc;
 }
 
 static int ipg_nic_change_mtu(struct net_device *dev, int new_mtu)
@@ -2953,6 +2819,48 @@ static int ipg_nic_change_mtu(struct net
 	return 0;
 }
 
+static int ipg_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct ipg_nic_private *sp = netdev_priv(dev);
+	int rc;
+
+	mutex_lock(&sp->mii_mutex);
+	rc = mii_ethtool_gset(&sp->mii_if, cmd);
+	mutex_unlock(&sp->mii_mutex);
+
+	return rc;
+}
+
+static int ipg_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct ipg_nic_private *sp = netdev_priv(dev);
+	int rc;
+
+	mutex_lock(&sp->mii_mutex);
+	rc = mii_ethtool_sset(&sp->mii_if, cmd);
+	mutex_unlock(&sp->mii_mutex);
+
+	return rc;
+}
+
+static int ipg_nway_reset(struct net_device *dev)
+{
+	struct ipg_nic_private *sp = netdev_priv(dev);
+	int rc;
+
+	mutex_lock(&sp->mii_mutex);
+	rc = mii_nway_restart(&sp->mii_if);
+	mutex_unlock(&sp->mii_mutex);
+
+	return rc;
+}
+
+static struct ethtool_ops ipg_ethtool_ops = {
+	.get_settings = ipg_get_settings,
+	.set_settings = ipg_set_settings,
+	.nway_reset   = ipg_nway_reset,
+};
+
 static void ipg_remove(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -3011,6 +2919,7 @@ static int __devinit ipg_probe(struct pc
 
 	sp = netdev_priv(dev);
 	spin_lock_init(&sp->lock);
+	mutex_init(&sp->mii_mutex);
 
 	/* Declare IPG NIC functions for Ethernet device methods.
 	 */
@@ -3019,11 +2928,12 @@ static int __devinit ipg_probe(struct pc
 	dev->hard_start_xmit = &ipg_nic_hard_start_xmit;
 	dev->get_stats = &ipg_nic_get_stats;
 	dev->set_multicast_list = &ipg_nic_set_multicast_list;
-	dev->do_ioctl = &ipg_nic_do_ioctl;
+	dev->do_ioctl = ipg_ioctl;
 	dev->change_mtu = &ipg_nic_change_mtu;
 
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_ETHTOOL_OPS(dev, &ipg_ethtool_ops);
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
diff --git a/drivers/net/ipg.h b/drivers/net/ipg.h
index 6c55b0b..58b1417 100644
--- a/drivers/net/ipg.h
+++ b/drivers/net/ipg.h
@@ -870,6 +870,9 @@ #endif
 	u16 StationAddr1;	/* Station Address in EEPROM Reg 0x11 */
 	u16 StationAddr2;	/* Station Address in EEPROM Reg 0x12 */
 
+	struct mutex		mii_mutex;
+	struct mii_if_info	mii_if;
+
 #ifdef IPG_DEBUG
 	int TFDunavailCount;
 	int RFDlistendCount;
-- 
1.3.1

