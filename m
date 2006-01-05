Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWAEPtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWAEPtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWAEPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:49:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:63965 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751424AbWAEPtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:49:06 -0500
Date: Thu, 5 Jan 2006 09:43:14 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: jgarizk@gate.crashing.org
cc: netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <afleming@freescale.com>
Subject: [PATCH] phy: Added a macro to represent the string format used to
 match a phy device
Message-ID: <Pine.LNX.4.44.0601050942450.31237-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PHY_ID_FMT macro to ensure that the format of the id string used by
a driver to match to its specific phy is consistent between the mdio_bus
and the driver.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 470500bb2f548d79e8981e4b1d9841f3d01dd657
tree 45768e543ada5fae24eaa207d031ef5371fd6319
parent 8d8188e951e8433057d0591b0b7db02c1cd9a28e
author Kumar Gala <galak@kernel.crashing.org> Thu, 05 Jan 2006 09:30:44 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 05 Jan 2006 09:30:44 -0600

 drivers/net/phy/mdio_bus.c |    2 +-
 drivers/net/phy/phy.c      |    2 +-
 include/linux/phy.h        |    3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 02940c0..459443b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -81,7 +81,7 @@ int mdiobus_register(struct mii_bus *bus
 
 			phydev->dev.parent = bus->dev;
 			phydev->dev.bus = &mdio_bus_type;
-			sprintf(phydev->dev.bus_id, "phy%d:%d", bus->id, i);
+			snprintf(phydev->dev.bus_id, BUS_ID_SIZE, PHY_ID_FMT, bus->id, i);
 
 			phydev->bus = bus;
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b8686e4..1474b7c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -42,7 +42,7 @@
  */
 void phy_print_status(struct phy_device *phydev)
 {
-	pr_info("%s: Link is %s", phydev->dev.bus_id,
+	pr_info("PHY: %s - Link is %s", phydev->dev.bus_id,
 			phydev->link ? "Up" : "Down");
 	if (phydev->link)
 		printk(" - %d/%s", phydev->speed,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 92a9696..331521a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -53,6 +53,9 @@
 
 #define PHY_MAX_ADDR 32
 
+/* Used when trying to connect to a specific phy (mii bus id:phy device id) */
+#define PHY_ID_FMT "%x:%02x"
+
 /* The Bus class for PHYs.  Devices which provide access to
  * PHYs should register using this structure */
 struct mii_bus {

