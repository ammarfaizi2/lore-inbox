Return-Path: <linux-kernel-owner+w=401wt.eu-S932419AbWLLUB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWLLUB5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWLLUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:01:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:50619 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbWLLUB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:01:56 -0500
Date: Tue, 12 Dec 2006 14:01:51 -0600
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       jesse.brandeburg@intel.com, auke-jan.h.kok@intel.com
Subject: [PATCH 2/2]: Use newly defined PCI channel offline routine
Message-ID: <20061212200151.GH4329@austin.ibm.com>
References: <20061212195524.GG4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212195524.GG4329@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use newly minted routine to access the PCI channel state.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/e1000/e1000_main.c |    2 +-
 drivers/net/ixgb/ixgb_main.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-git7/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/e1000/e1000_main.c	2006-12-05 17:11:01.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/e1000/e1000_main.c	2006-12-05 17:13:31.000000000 -0600
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
--- linux-2.6.19-git7.orig/drivers/net/ixgb/ixgb_main.c	2006-12-05 17:11:01.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/ixgb/ixgb_main.c	2006-12-05 17:13:31.000000000 -0600
@@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
 	struct pci_dev *pdev = adapter->pdev;
 
 	/* Prevent stats update while adapter is being reset */
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev))
 		return;
 
 	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
