Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbTAGUlY>; Tue, 7 Jan 2003 15:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAGUkS>; Tue, 7 Jan 2003 15:40:18 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:53194 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S267493AbTAGUbw>;
	Tue, 7 Jan 2003 15:31:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 7/7: use pci_find_capability in sworks-agp.c
Date: Tue, 7 Jan 2003 13:40:32 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071340.32120.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.977   -> 1.978  
#	drivers/char/agp/sworks-agp.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.978
# AGP: sworks - Use pci_find_capability.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:58 2003
+++ b/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:58 2003
@@ -229,7 +229,6 @@
 	struct aper_size_info_lvl2 *current_size;
 	u32 temp;
 	u8 enable_reg;
-	u8 cap_ptr;
 	u32 cap_id;
 	u16 cap_reg;
 
@@ -257,18 +256,7 @@
 			      SVWRKS_AGP_ENABLE, enable_reg);
 	agp_bridge.tlb_flush(NULL);
 
-	pci_read_config_byte(serverworks_private.svrwrks_dev, 0x34, &cap_ptr);
-	if (cap_ptr != 0) {
-		do {
-			pci_read_config_dword(serverworks_private.svrwrks_dev,
-					      cap_ptr, &cap_id);
-
-			if ((cap_id & 0xff) != 0x02)
-				cap_ptr = (cap_id >> 8) & 0xff;
-		}
-		while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0));
-	}
-	agp_bridge.capndx = cap_ptr;
+	agp_bridge.capndx = pci_find_capability(serverworks_private.svrwrks_dev, PCI_CAP_ID_AGP);
 
 	/* Fill in the mode register */
 	pci_read_config_dword(serverworks_private.svrwrks_dev,

