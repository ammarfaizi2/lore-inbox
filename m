Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbTEJJiv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTEJJiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:38:51 -0400
Received: from palrel11.hp.com ([156.153.255.246]:38550 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263704AbTEJJiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:38:50 -0400
Date: Sat, 10 May 2003 02:51:28 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: qla1280 mem-mapped I/O fix
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the fix in the second hunk, I don't see any reason not to turn on
MEMORY_MAPPED_IO in qla1280.  It seems to work fine on my machine
with this controller (ia64 Big Sur).

	--david

diff -Nru a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
--- a/drivers/scsi/qla1280.c	Sat May 10 01:47:43 2003
+++ b/drivers/scsi/qla1280.c	Sat May 10 01:47:43 2003
@@ -284,7 +284,7 @@
 #define  QL1280_TARGET_MODE_SUPPORT    0	/* Target mode support */
 #define  QL1280_LUN_SUPPORT            0
 #define  WATCHDOGTIMER                 0
-#define  MEMORY_MAPPED_IO              0
+#define  MEMORY_MAPPED_IO              1
 #define  DEBUG_QLA1280_INTR            0
 #define  USE_NVRAM_DEFAULTS	       0
 #define  DEBUG_PRINT_NVRAM             0
@@ -2634,7 +2634,7 @@
 	/*
 	 * Get memory mapped I/O address.
 	 */
-	pci_read_config_word (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
+	pci_read_config_dword (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
 	mmapbase &= PCI_BASE_ADDRESS_MEM_MASK;
 
 	/*
