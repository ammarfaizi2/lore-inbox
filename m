Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWC3V16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWC3V16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWC3V16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:27:58 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43479 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750964AbWC3V15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:27:57 -0500
Date: Thu, 30 Mar 2006 15:27:33 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: fix device name printing, again.
Message-ID: <20060330212732.GO2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul, please apply and send upstram.

--linas

[PATCH] powerpc/pseries: fix device name printing, again.

The recent patch to print device names in EEH reset messages
was lacking ... this patch works better.

Signed-off-by: Linas Vepstas <linas@linas.org>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-30 14:43:51.000000000 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-30 14:47:31.000000000 -0600
@@ -292,9 +292,10 @@ struct pci_dn * handle_eeh_events (struc
 	frozen_pdn = PCI_DN(frozen_dn);
 	frozen_pdn->eeh_freeze_count++;
 
-	pci_str = pci_name (frozen_pdn->pcidev);
-	drv_str = pcid_name (frozen_pdn->pcidev);
-	if (!pci_str) {
+	if (frozen_pdn->pcidev) {
+		pci_str = pci_name (frozen_pdn->pcidev);
+		drv_str = pcid_name (frozen_pdn->pcidev);
+	} else {
 		pci_str = pci_name (event->dev);
 		drv_str = pcid_name (event->dev);
 	}
