Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWDXWlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDXWlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWDXWlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:41:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:45062 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751335AbWDXWlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:41:46 -0400
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="28006025:sNHT2086892115"
Subject: [patch] pciehp: dont call pci_enable_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 15:50:59 -0700
Message-Id: <1145919059.6478.29.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 24 Apr 2006 22:41:40.0326 (UTC) FILETIME=[40C76860:01C667F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call pci_enable_device from pciehp because the pcie port service driver
already does this.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    3 ---
 1 files changed, 3 deletions(-)

--- 2.6-git-pcie.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ 2.6-git-pcie/drivers/pci/hotplug/pciehp_hpc.c
@@ -1404,9 +1404,6 @@ int pcie_init(struct controller * ctrl, 
 	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, 
 		pdev->subsystem_vendor, pdev->subsystem_device);
 
-	if (pci_enable_device(pdev))
-		goto abort_free_ctlr;
-	
 	mutex_init(&ctrl->crit_sect);
 	/* setup wait queue */
 	init_waitqueue_head(&ctrl->queue);
