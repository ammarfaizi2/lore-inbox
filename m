Return-Path: <linux-kernel-owner+w=401wt.eu-S1755178AbXAAIbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbXAAIbf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbXAAIbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:31:35 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:38379 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbXAAIbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:31:33 -0500
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org,
       Muli Ben-Yehuda <muli@il.ibm.com>
Subject: [PATCH] x86-64 Calgary: tighten up printks
Reply-To: Muli Ben-Yehuda <muli@il.ibm.com>
Date: Mon, 01 Jan 2007 10:31:31 +0200
Message-Id: <11676402912842-git-send-email-muli@il.ibm.com>
X-Mailer: git-send-email 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
---
 arch/x86_64/kernel/pci-calgary.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/kernel/pci-calgary.c b/arch/x86_64/kernel/pci-calgary.c
index 87d90cb..3d65b1d 100644
--- a/arch/x86_64/kernel/pci-calgary.c
+++ b/arch/x86_64/kernel/pci-calgary.c
@@ -1068,6 +1068,8 @@ void __init detect_calgary(void)
 	if (!early_pci_allowed())
 		return;
 
+	printk(KERN_DEBUG "Calgary: detecting Calgary via BIOS EBDA area\n");
+
 	ptr = (unsigned long)phys_to_virt(get_bios_ebda());
 
 	rio_table_hdr = NULL;
@@ -1088,14 +1090,14 @@ void __init detect_calgary(void)
 		offset = *((unsigned short *)(ptr + offset));
 	}
 	if (!rio_table_hdr) {
-		printk(KERN_ERR "Calgary: Unable to locate "
-				"Rio Grande Table in EBDA - bailing!\n");
+		printk(KERN_DEBUG "Calgary: Unable to locate Rio Grande table "
+		       "in EBDA - bailing!\n");
 		return;
 	}
 
 	ret = build_detail_arrays();
 	if (ret) {
-		printk(KERN_ERR "Calgary: build_detail_arrays ret %d\n", ret);
+		printk(KERN_DEBUG "Calgary: build_detail_arrays ret %d\n", ret);
 		return;
 	}
 
@@ -1128,6 +1130,9 @@ void __init detect_calgary(void)
 		}
 	}
 
+	printk(KERN_DEBUG "Calgary: finished detection, Calgary %s\n",
+	       calgary_found ? "found" : "not found");
+
 	if (calgary_found) {
 		iommu_detected = 1;
 		calgary_detected = 1;
-- 
1.4.1

