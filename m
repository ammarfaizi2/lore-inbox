Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVC0UaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVC0UaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVC0UaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:30:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13840 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261521AbVC0UaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:30:10 -0500
Date: Sun, 27 Mar 2005 22:30:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pnp/pnpbios/rsparser.c: fix an array overflow
Message-ID: <20050327203008.GR4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/pnp/pnpbios/rsparser.c.old	2005-03-23 03:04:17.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/pnp/pnpbios/rsparser.c	2005-03-23 03:05:21.000000000 +0100
@@ -72,7 +72,9 @@
 pnpbios_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
 {
 	int i = 0;
-	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_DMA) i++;
+	while (i < PNP_MAX_DMA && 
+			!(res->dma_resource[i].flags & IORESOURCE_UNSET))
+		i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
 		if (dma == -1) {

