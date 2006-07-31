Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWGaN4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWGaN4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWGaN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:56:39 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:61927 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750892AbWGaN4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:56:24 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/6] AVR32: Don't assume anything about MAX_NR_ZONES
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:55:56 +0200
Message-Id: <11543541601753-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1154354160566-git-send-email-hskinnemoen@atmel.com>
References: <1154354160566-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zero out zones_size with memset() and initialize just the zones
we need. This should avoid breakage when zones come and go.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mm/init.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/avr32/mm/init.c b/arch/avr32/mm/init.c
index 0cb82de..7bbbd7e 100644
--- a/arch/avr32/mm/init.c
+++ b/arch/avr32/mm/init.c
@@ -380,7 +380,7 @@ void __init paging_init(void)
 
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
-		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0 };
+		unsigned long zones_size[MAX_NR_ZONES];
 		unsigned long low, start_pfn;
 
 		start_pfn = pgdat->bdata->node_boot_start;
@@ -388,8 +388,8 @@ void __init paging_init(void)
 		low = pgdat->bdata->node_low_pfn;
 
 		/* All memory is DMA-able */
+		memset(zones_size, 0, sizeof(zones_size));
 		zones_size[ZONE_DMA] = low - start_pfn;
-		zones_size[ZONE_NORMAL] = 0;
 
 		printk("Node %u: start_pfn = 0x%lx, low = 0x%lx\n",
 		       nid, start_pfn, low);
-- 
1.4.0

