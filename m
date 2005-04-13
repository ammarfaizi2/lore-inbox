Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVDMXvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDMXvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDMXvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:51:15 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:36872 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261240AbVDMXoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:55 -0400
Date: Wed, 13 Apr 2005 19:38:46 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 9/10] tg3: check TG3_FLG2_5750_PLUS flag to set TG3_FLG2_5705_PLUS flag
Message-ID: <04132005193846.8835@laptop>
In-Reply-To: <04132005193845.8775@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use check of TG3_FLG2_5750_PLUS in tg3_get_invariants to set
TG3_FLG2_5705_PLUS flag.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 18:13:24.632333096 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 18:13:19.559031079 -0400
@@ -7928,15 +7928,14 @@ static int __devinit tg3_get_invariants(
 	tp->pci_hdr_type     = (cacheline_sz_reg >> 16) & 0xff;
 	tp->pci_bist         = (cacheline_sz_reg >> 24) & 0xff;
 
-	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) ||
-	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) ||
-	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752))
-		tp->tg3_flags2 |= TG3_FLG2_5705_PLUS;
-
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
 	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 		tp->tg3_flags2 |= TG3_FLG2_5750_PLUS;
 
+	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) ||
+	    (tp->tg3_flags2 & TG3_FLG2_5750_PLUS))
+		tp->tg3_flags2 |= TG3_FLG2_5705_PLUS;
+
 	if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS)
 		tp->tg3_flags2 |= TG3_FLG2_HW_TSO;
 
