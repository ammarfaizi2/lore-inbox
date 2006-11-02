Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423027AbWKBBKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbWKBBKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423039AbWKBBKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:10:51 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:3264 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423027AbWKBBKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:10:49 -0500
Date: Wed, 1 Nov 2006 19:10:44 -0600
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Auke Kok <sofar@foo-projects.org>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH 2/2 v2]: Use newly defined PCI channel offline routine
Message-ID: <20061102011044.GB3623@austin.ibm.com>
References: <20061101235417.GV6360@austin.ibm.com> <20061102000035.GW6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102000035.GW6360@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 06:00:35PM -0600, Linas Vepstas wrote:
[...]
Resubmit, per Auke ...

--linas

Use newly minted routine to access the PCI channel state.

Signed-off-by: Linas Vepstas <linas@linas.org>

----
 drivers/net/e1000/e1000_main.c |    2 +-
 drivers/net/ixgb/ixgb_main.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/e1000/e1000_main.c	2006-11-01 18:40:48.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c	2006-11-01 18:44:11.000000000 -0600
@@ -3297,7 +3297,7 @@ e1000_update_stats(struct e1000_adapter 
 	 */
 	if (adapter->link_speed == 0)
 		return;
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev))
 		return;
 
 	spin_lock_irqsave(&adapter->stats_lock, flags);
Index: linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/ixgb/ixgb_main.c	2006-11-01 18:40:48.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c	2006-11-01 18:44:39.000000000 -0600
@@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
 	struct pci_dev *pdev = adapter->pdev;
 
 	/* Prevent stats update while adapter is being reset */
-	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+	if (pci_channel_offline(pdev))
 		return;
 
 	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
