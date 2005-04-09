Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVDISGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVDISGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVDISGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:06:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261365AbVDISEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:04:01 -0400
Date: Sat, 9 Apr 2005 20:04:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>
Subject: [2.6 patch] drivers/pnp/pnpacpi/rsparser.c: fix an array overflow
Message-ID: <20050409180400.GF3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/drivers/pnp/pnpacpi/rsparser.c.old	2005-03-23 02:58:31.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/pnp/pnpacpi/rsparser.c	2005-03-23 03:02:49.000000000 +0100
@@ -94,8 +94,8 @@
 pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
 {
 	int i = 0;
-	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) &&
-			i < PNP_MAX_DMA)
+	while (i < PNP_MAX_DMA &&
+			!(res->dma_resource[i].flags & IORESOURCE_UNSET))
 		i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag

