Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUEXS7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUEXS7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUEXS7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:59:44 -0400
Received: from sandershosting.com ([69.26.136.138]:7594 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S264412AbUEXS7k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:59:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200405241457.18407@sandersweb.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] isapnp sb16 virtual pc
Date: Mon, 24 May 2004 14:59:45 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds support for the emulated Soundblaster 16 in Virtual PC 2004.
Thanks,
-- 
David Sanders
linux@sandersweb.net


--- sound/isa/sb/sb16.c-orig	Sun May  9 22:33:13 2004
+++ sound/isa/sb/sb16.c	Mon May 24 14:24:24 2004
@@ -247,6 +247,8 @@ static struct pnp_card_device_id snd_sb1
 	{ .id = "CTLXXXX" , .devs = { { "CTL0044" }, { "CTL0023" } } },
 	{ .id = "CTLXXXX" , .devs = { { "CTL0045" }, { "CTL0022" } } },
 #endif /* SNDRV_SBAWE */
+	/* Sound Blaster 16 PnP (Virtual PC 2004)*/
+	{ .id = "tBA03b0", .devs = { { "PNPb003" } } },
 	{ .id = "", }
 };
 

--- sound/oss/sb_card.c-orig	Sun May  9 22:32:52 2004
+++ sound/oss/sb_card.c	Mon May 24 14:23:47 2004
@@ -181,6 +181,13 @@ static void sb_dev2cfg(struct pnp_dev *d
 		scc->mpucnf.io_base = pnp_port_start(dev,1);
 		return;
 	}
+	if(!strncmp("tBA",scc->card_id,3)) {
+		scc->conf.io_base   = pnp_port_start(dev,0);
+		scc->conf.irq       = pnp_irq(dev,0);
+		scc->conf.dma       = pnp_dma(dev,0);
+		scc->conf.dma2      = pnp_dma(dev,1);
+		return;
+	}
 	if(!strncmp("ESS",scc->card_id,3)) {
 		scc->conf.io_base   = pnp_port_start(dev,0);
 		scc->conf.irq       = pnp_irq(dev,0);


--- sound/oss/sb_card.h-orig	Sun May  9 22:32:37 2004
+++ sound/oss/sb_card.h	Mon May 24 14:31:15 2004
@@ -140,6 +140,8 @@ static struct pnp_card_device_id sb_pnp_
 	{.id = "RTL3000", .driver_data = 0, .devs = { {.id="@@@2001"},
 						     {.id="@X@2001"},
 						     {.id="@H@0001"}, } },
+	/* Sound Blaster 16 (Virtual PC 2004) */
+	{.id = "tBA03b0", .driver_data = 0, .devs = { {.id="PNPb003"}, } },
 	/* -end- */
 	{.id = "", }
 };

