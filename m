Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWJPII5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWJPII5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWJPII5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:08:57 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:19819 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161204AbWJPII4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:08:56 -0400
Message-ID: <45333E0B.7000905@sw.ru>
Date: Mon, 16 Oct 2006 12:08:43 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       devel@openvz.org
CC: Andrey Mirkin <amirkin@sw.ru>
Subject: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit DMA capability
 fix
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------040508000705040309060803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508000705040309060803
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

From: Andrey Mirkin (amirkin@sw.ru)

It is known that 2 LSI Logic MegaRAID SATA RAID Controllers (150-4 and 150-6)
don't support 64-bit DMA. Unfortunately currently this check is wrong and driver
 sets 64-bit DMA mode for these devices.

Signed-off-by:	Andrey Mirkin <amirkin@sw.ru>
Ack-by:		Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c.mgst6	2006-10-16
10:26:50.000000000 +0400
+++ linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2006-10-16
11:30:55.000000000 +0400
@@ -884,7 +884,7 @@ megaraid_init_mbox(adapter_t *adapter)

 	if (((magic64 == HBA_SIGNATURE_64_BIT) &&
 		((adapter->pdev->subsystem_device !=
-		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) ||
+		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) &&
 		(adapter->pdev->subsystem_device !=
 		PCI_SUBSYS_ID_MEGARAID_SATA_150_4))) ||
 		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&


--------------040508000705040309060803
Content-Type: text/plain;
 name="diff-megaraid-sata1506-20061016"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-megaraid-sata1506-20061016"

--- linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c.mgst6	2006-10-16 10:26:50.000000000 +0400
+++ linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2006-10-16 11:30:55.000000000 +0400
@@ -884,7 +884,7 @@ megaraid_init_mbox(adapter_t *adapter)
 
 	if (((magic64 == HBA_SIGNATURE_64_BIT) &&
 		((adapter->pdev->subsystem_device !=
-		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) ||
+		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) &&
 		(adapter->pdev->subsystem_device !=
 		PCI_SUBSYS_ID_MEGARAID_SATA_150_4))) ||
 		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&


--------------040508000705040309060803--
