Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269884AbUJMWU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269884AbUJMWU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbUJMWU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:20:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52730 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269878AbUJMWT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:19:59 -0400
Date: Wed, 13 Oct 2004 15:20:24 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, chas@cmf.nrl.navy.mil
Subject: [PATCH 2.6] zatm.c: replace pci_find_device with pci_get_device
Message-ID: <197610000.1097706024@w-hlinder.beaverton.ibm.com>
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

diff -Nrup linux-2.6.9-rc4-mm1cln/drivers/atm/zatm.c linux-2.6.9-rc4-mm1patch2/drivers/atm/zatm.c
--- linux-2.6.9-rc4-mm1cln/drivers/atm/zatm.c	2004-10-12 14:15:10.000000000 -0700
+++ linux-2.6.9-rc4-mm1patch2/drivers/atm/zatm.c	2004-10-13 14:53:39.875813760 -0700
@@ -1591,7 +1591,7 @@ static int __init zatm_module_init(void)
 		struct pci_dev *pci_dev;
 
 		pci_dev = NULL;
-		while ((pci_dev = pci_find_device(PCI_VENDOR_ID_ZEITNET,type ?
+		while ((pci_dev = pci_get_device(PCI_VENDOR_ID_ZEITNET,type ?
 		    PCI_DEVICE_ID_ZEITNET_1225 : PCI_DEVICE_ID_ZEITNET_1221,
 		    pci_dev))) {
 			if (pci_enable_device(pci_dev)) break;

