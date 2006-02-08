Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWBHDXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWBHDXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWBHDT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:2433 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030491AbWBHDTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 22/29] eeh_driver NULL noise removal
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1F6frq-0006Dl-5B@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138796604 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/platforms/pseries/eeh_driver.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

d04e4e115bd9df2b748cb30abd610f3c0eb1e303
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 6373372..e3cbba4 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -333,7 +333,7 @@ void handle_eeh_events (struct eeh_event
 		rc = eeh_reset_device(frozen_pdn, NULL);
 		if (rc)
 			goto hard_fail;
-		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
+		pci_walk_bus(frozen_bus, eeh_report_reset, NULL);
 	}
 
 	/* If all devices reported they can proceed, the re-enable PIO */
@@ -342,11 +342,11 @@ void handle_eeh_events (struct eeh_event
 		rc = eeh_reset_device(frozen_pdn, NULL);
 		if (rc)
 			goto hard_fail;
-		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
+		pci_walk_bus(frozen_bus, eeh_report_reset, NULL);
 	}
 
 	/* Tell all device drivers that they can resume operations */
-	pci_walk_bus(frozen_bus, eeh_report_resume, 0);
+	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
 
 	return;
 	
@@ -367,7 +367,7 @@ hard_fail:
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
 
 	/* Notify all devices that they're about to go down. */
-	pci_walk_bus(frozen_bus, eeh_report_failure, 0);
+	pci_walk_bus(frozen_bus, eeh_report_failure, NULL);
 
 	/* Shut down the device drivers for good. */
 	pcibios_remove_pci_devices(frozen_bus);
-- 
0.99.9.GIT

