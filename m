Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWA3PMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWA3PMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWA3PMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:12:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932309AbWA3PMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:12:46 -0500
Date: Mon, 30 Jan 2006 10:10:29 -0600
From: Andy Gospodarek <andy@greyhouse.net>
To: netdev@vger.kernel.org, romieu@fr.zoreil.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RealTek RTL-8169 Full Duplex Patch
Message-ID: <20060130161029.GA11938@gospo.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allow the r8129 driver to set devices to be full-duplex only when
auto-negotiate is disabled.

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---

 r8169.c |    3 +++
 1 files changed, 3 insertions(+)

--- 2.6/drivers/net/r8169.c.orig	2006-01-23 12:55:19.224875000 -0600
+++ 2.6/drivers/net/r8169.c	2006-01-23 13:29:54.967655000 -0600
@@ -677,6 +677,9 @@
 
 		if (duplex == DUPLEX_HALF)
 			auto_nego &= ~(PHY_Cap_10_Full | PHY_Cap_100_Full);
+
+		if (duplex == DUPLEX_FULL)
+			auto_nego &= ~(PHY_Cap_10_Half | PHY_Cap_100_Half);
 	}
 
 	tp->phy_auto_nego_reg = auto_nego;



