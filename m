Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUKEFYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUKEFYC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUKEFYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:24:02 -0500
Received: from ozlabs.org ([203.10.76.45]:47520 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262606AbUKEFX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:23:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16779.2320.322595.471570@cargo.ozlabs.ibm.com>
Date: Fri, 5 Nov 2004 16:01:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: hannal@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 pmac_pci.c replace pci_find_device with pci_get_device
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Hanna Linder.

As pci_find_device is going away using the new for_each_pci_dev macro.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/pmac_pci.c test/arch/ppc64/kernel/pmac_pci.c
--- linux-2.5/arch/ppc64/kernel/pmac_pci.c	2004-10-26 16:06:41.000000000 +1000
+++ test/arch/ppc64/kernel/pmac_pci.c	2004-11-05 13:15:58.000000000 +1100
@@ -663,7 +663,7 @@
 {
 	struct pci_dev *dev = NULL;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+	for_each_pci_dev(dev)
 		pci_read_irq_line(dev);
 
 	pci_fix_bus_sysdata();
