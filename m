Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269880AbUJMWRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269880AbUJMWRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269881AbUJMWRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:17:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54777 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269880AbUJMWRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:17:22 -0400
Date: Wed, 13 Oct 2004 15:17:23 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, chas@cmf.nrl.navy.mil
Subject: [PATCH 2.6] firestream.c replace pci_find_device with pci_get_device
Message-ID: <196320000.1097705843@w-hlinder.beaverton.ibm.com>
In-Reply-To: <194130000.1097705759@w-hlinder.beaverton.ibm.com>
References: <194130000.1097705759@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. I have compile tested it. If anyone has this ATM card
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc4-mm1cln/drivers/atm/firestream.c linux-2.6.9-rc4-mm1patch2/drivers/atm/firestream.c
--- linux-2.6.9-rc4-mm1cln/drivers/atm/firestream.c	2004-10-12 14:15:10.000000000 -0700
+++ linux-2.6.9-rc4-mm1patch2/drivers/atm/firestream.c	2004-10-13 13:51:35.570994152 -0700
@@ -2021,7 +2021,7 @@ int __init fs_detect(void)
 
 	func_enter ();
 	pci_dev = NULL;
-	while ((pci_dev = pci_find_device(PCI_VENDOR_ID_FUJITSU_ME,
+	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_FUJITSU_ME,
 					  PCI_DEVICE_ID_FUJITSU_FS50, 
 					  pci_dev))) {
 		if (fs_register_and_init (pci_dev, &fs_pci_tbl[0]))
@@ -2029,7 +2029,7 @@ int __init fs_detect(void)
 		devs++;
 	}
 
-	while ((pci_dev = pci_find_device(PCI_VENDOR_ID_FUJITSU_ME,
+	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_FUJITSU_ME,
 					  PCI_DEVICE_ID_FUJITSU_FS155, 
 					  pci_dev))) {
 		if (fs_register_and_init (pci_dev, FS_IS155)) 

