Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVDMXv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVDMXv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDMXvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:51:53 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35080 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261241AbVDMXo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:57 -0400
Date: Wed, 13 Apr 2005 19:38:45 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 5/10] tg3: define TG3_FLG2_5750_PLUS flag
Message-ID: <04132005193845.8597@laptop>
In-Reply-To: <04132005193844.8539@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define TG3_FLG2_5750_PLUS flag and set it in tg3_get_invariants for
ASIC_REV_5750 or ASIC_REV_5752.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |    4 ++++
 drivers/net/tg3.h |    1 +
 2 files changed, 5 insertions(+)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 17:47:31.186930125 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 17:47:16.409928291 -0400
@@ -7951,6 +7951,10 @@ static int __devinit tg3_get_invariants(
 
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
 	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+		tp->tg3_flags2 |= TG3_FLG2_5750_PLUS;
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 		tp->tg3_flags2 |= TG3_FLG2_HW_TSO;
 
 	if (pci_find_capability(tp->pdev, PCI_CAP_ID_EXP) != 0)
--- bcm5752-support/drivers/net/tg3.h.orig	2005-04-08 17:47:35.536341972 -0400
+++ bcm5752-support/drivers/net/tg3.h	2005-04-08 17:44:48.578234813 -0400
@@ -2101,6 +2101,7 @@ struct tg3 {
 #define TG3_FLG2_HW_TSO			0x00010000
 #define TG3_FLG2_SERDES_PREEMPHASIS	0x00020000
 #define TG3_FLG2_5705_PLUS		0x00040000
+#define TG3_FLG2_5750_PLUS		0x00080000
 
 	u32				split_mode_max_reqs;
 #define SPLIT_MODE_5704_MAX_REQ		3
