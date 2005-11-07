Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbVKGUOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbVKGUOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbVKGUOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:14:44 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:34195 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S965272AbVKGUOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:14:43 -0500
Date: Mon, 7 Nov 2005 18:14:12 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm@osdl.org
Cc: linux.nics@intel.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] Fix sparse warning in e100 driver.
Message-Id: <20051107181412.084467d6.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes the following sparse warnings:

drivers/net/e100.c:1481:13: warning: Using plain integer as NULL pointer
drivers/net/e100.c:1481:13: warning: Using plain integer as NULL pointer
drivers/net/e100.c:1767:27: warning: Using plain integer as NULL pointer
drivers/net/e100.c:1847:27: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/net/e100.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -1478,7 +1478,7 @@ static inline int e100_rx_alloc_skb(stru
 
 	if(pci_dma_mapping_error(rx->dma_addr)) {
 		dev_kfree_skb_any(rx->skb);
-		rx->skb = 0;
+		rx->skb = NULL;
 		rx->dma_addr = 0;
 		return -ENOMEM;
 	}
@@ -1764,7 +1764,7 @@ static int e100_up(struct nic *nic)
 	if((err = e100_hw_init(nic)))
 		goto err_clean_cbs;
 	e100_set_multicast_list(nic->netdev);
-	e100_start_receiver(nic, 0);
+	e100_start_receiver(nic, NULL);
 	mod_timer(&nic->watchdog, jiffies);
 	if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
 		nic->netdev->name, nic->netdev)))
@@ -1844,7 +1844,7 @@ static int e100_loopback_test(struct nic
 		mdio_write(nic->netdev, nic->mii.phy_id, MII_BMCR,
 			BMCR_LOOPBACK);
 
-	e100_start_receiver(nic, 0);
+	e100_start_receiver(nic, NULL);
 
 	if(!(skb = dev_alloc_skb(ETH_DATA_LEN))) {
 		err = -ENOMEM;


-- 
Luiz Fernando N. Capitulino
