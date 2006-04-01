Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWDANLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWDANLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 08:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWDANLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 08:11:08 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:11244 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751408AbWDANLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 08:11:06 -0500
Date: Sat, 1 Apr 2006 21:10:11 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 zone_sizes_init() fix
Message-ID: <20060401131011.GA10804@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that with MAX_NR_ZONES=4, the last element of zones_size[] is
left uninitialized in zone_sizes_init() on i386.

Fix this by using gcc's range initializer to protect from future changes.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.16-mm2.orig/arch/i386/mm/discontig.c
+++ linux-2.6.16-mm2/arch/i386/mm/discontig.c
@@ -355,7 +355,7 @@ void __init zone_sizes_init(void)
 
 
 	for_each_online_node(nid) {
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+		unsigned long zones_size[] = { [0 ... MAX_NR_ZONES-1] = 0 };
 		unsigned long *zholes_size;
 		unsigned int max_dma;
 
--- linux-2.6.16-mm2.orig/arch/i386/kernel/setup.c
+++ linux-2.6.16-mm2/arch/i386/kernel/setup.c
@@ -1203,7 +1203,7 @@ static unsigned long __init setup_memory
 
 void __init zone_sizes_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[] = { [0 ... MAX_NR_ZONES-1] = 0 };
 	unsigned int max_dma, low;
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
