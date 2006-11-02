Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752588AbWKBAAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbWKBAAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbWKBAAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:00:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:27075 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752588AbWKBAAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:00:41 -0500
Date: Wed, 1 Nov 2006 18:00:35 -0600
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Auke Kok <sofar@foo-projects.org>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH 2/2]: Use newly defined PCI channel offline routine
Message-ID: <20061102000035.GW6360@austin.ibm.com>
References: <20061101235417.GV6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101235417.GV6360@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: [PATCH 2/2]: Use newly defined PCI channel offline routine

Use newly minted routine to access the PCI channel state.

Signed-off-by: Linas Vepstas <linas@linas.org>

----
 drivers/net/e1000/e1000_main.c |    2 +-
 drivers/net/ixgb/ixgb_main.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/e1000/e1000_main.c	2006-11-01 16:15:24.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c	2006-11-01 16:20:55.000000000 -0600
@@ -3297,7 +3297,7 @@ e1000_update_stats(struct e1000_adapter 
 	 */
 	if (adapter->link_speed == 0)
 		return;
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev->error_state))
 		return;
 
 	spin_lock_irqsave(&adapter->stats_lock, flags);
Index: linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/ixgb/ixgb_main.c	2006-11-01 16:15:25.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c	2006-11-01 16:20:55.000000000 -0600
@@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
 	struct pci_dev *pdev = adapter->pdev;
 
 	/* Prevent stats update while adapter is being reset */
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev->error_state))
 		return;
 
 	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
