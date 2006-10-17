Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWJQUmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWJQUmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWJQUmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:42:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7599 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750821AbWJQUmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:42:09 -0400
Date: Tue, 17 Oct 2006 15:42:06 -0500
To: akpm@osdl.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Auke Kok <auke-jan.h.kok@intel.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH] e1000: Reset all functions after a PCI error
Message-ID: <20061017204206.GG6537@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply and forward upstream.

--linas

During the handling of the PCI error recovery sequence,
the current e1000 driver erroneously blocks a device reset
for any but the first PCI function. It shouldn't -- this 
is a cut-n-paste error from a different driver (which
tolerated only one hardware reset per hardware card). 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>

----
 drivers/net/e1000/e1000_main.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/e1000/e1000_main.c	2006-10-17 15:02:25.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c	2006-10-17 15:03:35.000000000 -0500
@@ -4914,10 +4914,6 @@ static pci_ers_result_t e1000_io_slot_re
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	/* Perform card reset only on one instance of the card */
-	if (PCI_FUNC (pdev->devfn) != 0)
-		return PCI_ERS_RESULT_RECOVERED;
-
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
 
