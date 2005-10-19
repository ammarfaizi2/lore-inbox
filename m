Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVJSRsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJSRsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVJSRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:48:14 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:32922 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751174AbVJSRsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:48:13 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] skge support for Marvell chips in Toshiba laptops
Date: Wed, 19 Oct 2005 10:47:53 -0700
User-Agent: KMail/1.8.91
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JboVDXOqdlNZtNG"
Message-Id: <200510191047.53212.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_JboVDXOqdlNZtNG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a small patch to add the PCI ID and chip type of the chip in my 
Toshiba laptop to the skge driver.  I haven't tested it much (just 
insmoded it and run ethtool against the corresponding eth1 device), but 
it doesn't crash my system, so unless this configuration has already 
been tested and is known to have problems, it might be good to add this 
patch.

I'll test some more with a real network when I get home.

Thanks,
Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>


--Boundary-00=_JboVDXOqdlNZtNG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="skge-toshiba.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="skge-toshiba.patch"

--- linux-2.6.14-rc4.orig/drivers/net/skge.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4/drivers/net/skge.c	2005-10-19 10:40:56.000000000 -0700
@@ -77,6 +77,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_YU) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, PCI_DEVICE_ID_DLINK_DGE510T), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4351), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) }, /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, PCI_DEVICE_ID_CNET_GIGACARD) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_LINKSYS, PCI_DEVICE_ID_LINKSYS_EG1064) },
@@ -2932,6 +2933,7 @@
 	case CHIP_ID_YUKON:
 	case CHIP_ID_YUKON_LITE:
 	case CHIP_ID_YUKON_LP:
+	case CHIP_ID_YUKON_FE:
 		if (phy_type < SK_PHY_MARV_COPPER && pmd_type != 'S')
 			hw->copper = 1;
 

--Boundary-00=_JboVDXOqdlNZtNG--
