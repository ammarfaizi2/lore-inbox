Return-Path: <linux-kernel-owner+w=401wt.eu-S964829AbWLMA33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWLMA33 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWLMA33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:29:29 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50417 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964829AbWLMA32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:29:28 -0500
Date: Tue, 12 Dec 2006 18:29:15 -0600
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2/2]: Use newly defined PCI channel offline routine
Message-ID: <20061213002915.GA27870@austin.ibm.com>
References: <20061212225559.GL4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212225559.GL4329@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use newly minted routine to access the PCI channel state.

Signed-off-by: Linas Vepstas <linas@linas.org>

----
 drivers/net/e1000/e1000_main.c |    2 +-
 drivers/net/ixgb/ixgb_main.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-git7/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/e1000/e1000_main.c	2006-12-12 16:38:34.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/e1000/e1000_main.c	2006-12-12 16:40:51.000000000 -0600
@@ -3449,7 +3449,7 @@ e1000_update_stats(struct e1000_adapter 
 	 */
 	if (adapter->link_speed == 0)
 		return;
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev))
 		return;
 
 	spin_lock_irqsave(&adapter->stats_lock, flags);
Index: linux-2.6.19-git7/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/ixgb/ixgb_main.c	2006-12-12 16:38:34.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/ixgb/ixgb_main.c	2006-12-12 16:41:00.000000000 -0600
@@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
 	struct pci_dev *pdev = adapter->pdev;
 
 	/* Prevent stats update while adapter is being reset */
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev))
 		return;
 
 	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
