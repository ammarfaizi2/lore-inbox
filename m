Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbUKECE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUKECE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbUKECE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:04:27 -0500
Received: from ozlabs.org ([203.10.76.45]:33181 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262562AbUKECEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:04:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16778.54308.410570.309987@cargo.ozlabs.ibm.com>
Date: Fri, 5 Nov 2004 12:15:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: hannal@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 iSeries_pci.c use for_each_pci_dev()
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Hanna Linder.

As pci_find_device is going away using the new for_each_pci_dev macro.
If someone with a PPC64 system could test it I would appreciate it.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/iSeries_pci.c test/arch/ppc64/kernel/iSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/iSeries_pci.c	2004-10-30 09:25:20.000000000 +1000
+++ test/arch/ppc64/kernel/iSeries_pci.c	2004-11-05 11:59:48.645822176 +1100
@@ -312,8 +312,7 @@
 	mf_displaySrc(0xC9000100);
 
 	printk("pcibios_final_fixup\n");
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev))
-			!= NULL) {
+	for_each_pci_dev(pdev) {
 		node = find_Device_Node(pdev->bus->number, pdev->devfn);
 		printk("pci dev %p (%x.%x), node %p\n", pdev,
 		       pdev->bus->number, pdev->devfn, node);
