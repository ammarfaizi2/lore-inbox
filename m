Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbUKEF0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUKEF0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUKEFYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:24:17 -0500
Received: from ozlabs.org ([203.10.76.45]:49824 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262610AbUKEFX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:23:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16779.3536.62705.365371@cargo.ozlabs.ibm.com>
Date: Fri, 5 Nov 2004 16:21:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: hannal@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 u3_iommu.c use for_each_pci_dev()
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Hanna Linder.

As pci_find_device is going away I've replaced it with pci_get_device
and pci_dev_put.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/u3_iommu.c test/arch/ppc64/kernel/u3_iommu.c
--- linux-2.5/arch/ppc64/kernel/u3_iommu.c	2004-10-25 18:18:33.000000000 +1000
+++ test/arch/ppc64/kernel/u3_iommu.c	2004-11-05 13:16:44.000000000 +1100
@@ -291,7 +291,7 @@
 	/* We only have one iommu table on the mac for now, which makes
 	 * things simple. Setup all PCI devices to point to this table
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/* We must use pci_device_to_OF_node() to make sure that
 		 * we get the real "final" pointer to the device in the
 		 * pci_dev sysdata and not the temporary PHB one
