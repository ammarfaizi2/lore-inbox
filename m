Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263386AbVCEF0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbVCEF0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 00:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVCEFRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 00:17:51 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:52990 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S263583AbVCEFOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 00:14:24 -0500
Date: Fri, 4 Mar 2005 23:12:59 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: jgarzik@pobox.com
cc: jaka@activetools.si, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org, netdev@oss.sgi.com
Subject: [PATCH] initialize a spin lock in gianfar driver
Message-ID: <Pine.LNX.4.61.0503042305570.23572@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the mdio_lock spin lock in mii_info struct, which is otherwise 
accessed prior to initialization.

Signed-off-by: Jaka Mocnik <jaka@activetools.si>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2005-03-04 23:03:27 -06:00
+++ b/drivers/net/gianfar.c	2005-03-04 23:03:27 -06:00
@@ -377,6 +377,8 @@
 			ADVERTISED_1000baseT_Full);
 	mii_info->autoneg = 1;
 
+	spin_lock_init(&mii_info->mdio_lock);
+
 	mii_info->mii_id = priv->einfo->phyid;
 
 	mii_info->dev = dev;
