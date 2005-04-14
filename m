Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVDNSVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVDNSVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVDNSVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:21:04 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:34526 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261330AbVDNSUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:20:53 -0400
Message-ID: <425EB470.9040203@am.sony.com>
Date: Thu, 14 Apr 2005 11:20:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
CC: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: {PATCH] Fix IBM EMAC driver ioctl bug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IBM EMAC driver ioctl bug.

I found IBM EMAC driver bug.
So mii-tool command print wrong status.

  # mii-tool
  eth0: 10 Mbit, half duplex, no link
  eth1: 10 Mbit, half duplex, no link

I can get correct status on fixed kernel.

  # mii-tool
  eth0: negotiated 100baseTx-FD, link okZZ
  eth1: negotiated 100baseTx-FD, link ok

Hiroaki Fuse

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
---

Index: linux-2.6.11/drivers/net/ibm_emac/ibm_emac_core.c
===================================================================
--- linux-2.6.11.orig/drivers/net/ibm_emac/ibm_emac_core.c	2005-04-14 10:54:20.014023550 -0700
+++ linux-2.6.11/drivers/net/ibm_emac/ibm_emac_core.c	2005-04-14 10:55:24.723458722 -0700
@@ -1587,7 +1587,7 @@
 static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ocp_enet_private *fep = dev->priv;
-	uint *data = (uint *) & rq->ifr_ifru;
+	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:

-EOF

