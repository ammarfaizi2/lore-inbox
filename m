Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVCCLSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVCCLSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCCLRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:17:02 -0500
Received: from router.activetools.si ([213.250.28.33]:51097 "EHLO vafel.at.lan")
	by vger.kernel.org with ESMTP id S261623AbVCCLOL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:14:11 -0500
Subject: [PATCH] initialize a spin lock in gianfar driver
From: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
To: kumar.gala@freescale.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Mar 2005 12:13:56 +0100
Message-Id: <1109848436.29455.33.camel@x.at.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the mdio_lock spin lock in mii_info struct, which is
otherwise accessed prior to initialization.

Signed-off-by: Jaka Močnik <jaka@activetools.si>

--- linux-2.6.11/drivers/net/gianfar.c	2005-03-03 10:36:51.000000000 +0100
+++ linux-2.6.11-sgn/drivers/net/gianfar.c	2005-03-03 10:36:38.822996013 +0100
@@ -377,6 +377,8 @@
 			ADVERTISED_1000baseT_Full);
 	mii_info->autoneg = 1;

+	spin_lock_init(&mii_info->mdio_lock);
+
 	mii_info->mii_id = priv->einfo->phyid;

 	mii_info->dev = dev;

