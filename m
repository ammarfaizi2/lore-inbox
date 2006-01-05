Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWAEPup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWAEPup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWAEPup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:50:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:2014 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751463AbWAEPun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:50:43 -0500
Date: Thu, 5 Jan 2006 09:44:49 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <afleming@freescale.com>
Subject: [PATCH] gianfar: Use new PHY_ID_FMT macro
Message-ID: <Pine.LNX.4.44.0601050943150.31237-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the driver produce the string used by phy_connect and have
board specific code pass the integer mii bus id and phy device id
for the specific controller instance.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 2b67fe22e3c88ad9941c9e9f7b668d0fe661be88
tree 9fb376123d3cf4bc335b98b0f902ab08acb86f37
parent 1a6720f78a7fb69451983e6b73723b57594ecac1
author Kumar Gala <galak@kernel.crashing.org> Thu, 05 Jan 2006 09:46:17 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 05 Jan 2006 09:46:17 -0600

 drivers/net/gianfar.c       |    5 ++++-
 include/linux/fsl_devices.h |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 637b73a..0c18dbd 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -399,12 +399,15 @@ static int init_phy(struct net_device *d
 		priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT ?
 		SUPPORTED_1000baseT_Full : 0;
 	struct phy_device *phydev;
+	char phy_id[BUS_ID_SIZE];
 
 	priv->oldlink = 0;
 	priv->oldspeed = 0;
 	priv->oldduplex = -1;
 
-	phydev = phy_connect(dev, priv->einfo->bus_id, &adjust_link, 0);
+	snprintf(phy_id, BUS_ID_SIZE, PHY_ID_FMT, priv->einfo->bus_id, priv->einfo->phy_id);
+
+	phydev = phy_connect(dev, phy_id, &adjust_link, 0);
 
 	if (IS_ERR(phydev)) {
 		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index a7a2b85..a9f1cfd 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -50,7 +50,8 @@ struct gianfar_platform_data {
 
 	/* board specific information */
 	u32 board_flags;
-	const char *bus_id;
+	u32 bus_id;
+	u32 phy_id;
 	u8 mac_addr[6];
 };
 



