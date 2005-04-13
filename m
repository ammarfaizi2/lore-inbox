Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVDMXuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVDMXuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVDMXue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:50:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:36360 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261237AbVDMXoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:55 -0400
Date: Wed, 13 Apr 2005 19:38:45 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 8/10] tg3: use TG3_FLG2_57{05,50}_PLUS flags in tg3_get_invariants
Message-ID: <04132005193845.8775@laptop>
In-Reply-To: <04132005193845.8720@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite checks in tg3_get_invariants to use TG3_FLG2_5705_PLUS and
TG3_FLG2_5750_PLUS flags.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 18:11:46.207874683 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 18:11:36.696183379 -0400
@@ -7937,8 +7937,7 @@ static int __devinit tg3_get_invariants(
 	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 		tp->tg3_flags2 |= TG3_FLG2_5750_PLUS;
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+	if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS)
 		tp->tg3_flags2 |= TG3_FLG2_HW_TSO;
 
 	if (pci_find_capability(tp->pdev, PCI_CAP_ID_EXP) != 0)
@@ -8068,9 +8067,7 @@ static int __devinit tg3_get_invariants(
 	if (tp->pci_chip_rev_id == CHIPREV_ID_5704_A0)
 		tp->tg3_flags2 |= TG3_FLG2_PHY_5704_A0_BUG;
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+	if (tp->tg3_flags2 & TG3_FLG2_5705_PLUS)
 		tp->tg3_flags2 |= TG3_FLG2_PHY_BER_BUG;
 
 	/* Only 5701 and later support tagged irq status mode.
