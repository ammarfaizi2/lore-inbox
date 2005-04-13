Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVDNAHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVDNAHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDMXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:49:03 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35592 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261233AbVDMXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:54 -0400
Date: Wed, 13 Apr 2005 19:38:45 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 7/10] tg3: more use of TG3_FLG2_5705_PLUS flag
Message-ID: <04132005193845.8720@laptop>
In-Reply-To: <04132005193845.8656@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite of a couple of troublesome multi-way if statements to use
TG3_FLG2_5705_PLUS flag.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 18:00:31.886220435 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 18:08:55.969298725 -0400
@@ -5237,10 +5237,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 		      RDMAC_MODE_LNGREAD_ENAB);
 	if (tp->tg3_flags & TG3_FLAG_SPLIT_MODE)
 		rdmac_mode |= RDMAC_MODE_SPLIT_ENABLE;
-	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 &&
-	     tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) ||
-	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)) {
+	if ((tp->tg3_flags2 & TG3_FLG2_5705_PLUS) &&
+	     tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) {
 		if (tp->tg3_flags2 & TG3_FLG2_TSO_CAPABLE &&
 		    (tp->pci_chip_rev_id == CHIPREV_ID_5705_A1 ||
 		     tp->pci_chip_rev_id == CHIPREV_ID_5705_A2)) {
@@ -5353,10 +5351,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 	       WDMAC_MODE_FIFOURUN_ENAB | WDMAC_MODE_FIFOOREAD_ENAB |
 	       WDMAC_MODE_LNGREAD_ENAB);
 
-	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 &&
-	     tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) ||
-	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)) {
+	if ((tp->tg3_flags2 & TG3_FLG2_5705_PLUS) &&
+	     tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) {
 		if ((tp->tg3_flags & TG3_FLG2_TSO_CAPABLE) &&
 		    (tp->pci_chip_rev_id == CHIPREV_ID_5705_A1 ||
 		     tp->pci_chip_rev_id == CHIPREV_ID_5705_A2)) {
