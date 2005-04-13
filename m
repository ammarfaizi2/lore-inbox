Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVDMXzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDMXzD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVDMXxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:53:04 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:38408 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261243AbVDMXpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:45:41 -0400
Date: Wed, 13 Apr 2005 19:38:46 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 10/10] tg3: add support for bcm5752 rev a1
Message-ID: <04132005193846.8893@laptop>
In-Reply-To: <04132005193846.8835@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace existing ASIC_REV_5752 definition with ASIC_REV_5752_A0,
and add definition for ASIC_REV_5752_A1. Then, add ASIC_REV_5752_A1
to check for setting TG3_FLG2_5750_PLUS in tg3_get_invariants.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |    3 ++-
 drivers/net/tg3.h |    5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-12 14:19:06.302429500 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-12 14:17:50.963846711 -0400
@@ -7929,7 +7929,8 @@ static int __devinit tg3_get_invariants(
 	tp->pci_bist         = (cacheline_sz_reg >> 24) & 0xff;
 
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752_A0 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752_A1)
 		tp->tg3_flags2 |= TG3_FLG2_5750_PLUS;
 
 	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) ||
--- bcm5752-support/drivers/net/tg3.h.orig	2005-04-12 14:19:06.288431435 -0400
+++ bcm5752-support/drivers/net/tg3.h	2005-04-12 14:17:50.981844223 -0400
@@ -125,6 +125,8 @@
 #define  CHIPREV_ID_5750_A0		 0x4000
 #define  CHIPREV_ID_5750_A1		 0x4001
 #define  CHIPREV_ID_5750_A3		 0x4003
+#define  CHIPREV_ID_5752_A0		 0x5000
+#define  CHIPREV_ID_5752_A1		 0x6001
 #define  GET_ASIC_REV(CHIP_REV_ID)	((CHIP_REV_ID) >> 12)
 #define   ASIC_REV_5700			 0x07
 #define   ASIC_REV_5701			 0x00
@@ -132,7 +134,8 @@
 #define   ASIC_REV_5704			 0x02
 #define   ASIC_REV_5705			 0x03
 #define   ASIC_REV_5750			 0x04
-#define   ASIC_REV_5752			 0x05
+#define   ASIC_REV_5752_A0		 0x05
+#define   ASIC_REV_5752_A1		 0x06
 #define  GET_CHIP_REV(CHIP_REV_ID)	((CHIP_REV_ID) >> 8)
 #define   CHIPREV_5700_AX		 0x70
 #define   CHIPREV_5700_BX		 0x71
