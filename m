Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUJDXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUJDXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUJDXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:54:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33456 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268037AbUJDXyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:54:25 -0400
Date: Mon, 04 Oct 2004 16:55:14 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6] [3/12] gemini_pci.c replace pci_find_device with pci_get_device
Message-ID: <307270000.1096934114@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I have replaced this call with pci_get_device.
If someone with a PPC system could verify it I would appreciate it.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

----

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/gemini_pci.c linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/gemini_pci.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/gemini_pci.c	2004-09-29 20:04:25.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/gemini_pci.c	2004-10-04 16:49:59.270903688 -0700
@@ -15,7 +15,7 @@ void __init gemini_pcibios_fixup(void)
 	int i;
 	struct pci_dev *dev = NULL;
 	
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		for(i = 0; i < 6; i++) {
 			if (dev->resource[i].flags & IORESOURCE_IO) {
 				dev->resource[i].start |= (0xfe << 24);

