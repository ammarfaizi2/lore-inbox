Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWHJUVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWHJUVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWHJUPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:37 -0400
Received: from ns2.suse.de ([195.135.220.15]:26603 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932538AbWHJTfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:54 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [31/145] x86_64: Don't print virtual address in HPET initialization
Message-Id: <20060810193544.C653A13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:44 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

virtual addresses don't belong into kernel logs for non debugging

Cc: clemens@ladisch.de
Signed-off-by: Andi Kleen <ak@suse.de>

---
 drivers/char/hpet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/char/hpet.c
===================================================================
--- linux.orig/drivers/char/hpet.c
+++ linux/drivers/char/hpet.c
@@ -868,8 +868,8 @@ int hpet_alloc(struct hpet_data *hdp)
 	do_div(temp, period);
 	hpetp->hp_tick_freq = temp; /* ticks per second */
 
-	printk(KERN_INFO "hpet%d: at MMIO 0x%lx (virtual 0x%p), IRQ%s",
-		hpetp->hp_which, hdp->hd_phys_address, hdp->hd_address,
+	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
+		hpetp->hp_which, hdp->hd_phys_address,
 		hpetp->hp_ntimer > 1 ? "s" : "");
 	for (i = 0; i < hpetp->hp_ntimer; i++)
 		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
