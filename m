Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270810AbUJUSwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270810AbUJUSwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbUJUSuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:50:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:2965 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270785AbUJUSiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:38:51 -0400
Date: Thu, 21 Oct 2004 11:38:44 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, jgarzik@pobox.com
Subject: [PATCH 2.6] hw_random.c: replace pci_find_device
Message-ID: <268450000.1098383924@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As pci_find_device is going away I've replaced it with pci_get_device.
for_each_pci_dev is a macro wrapper around pci_get_device.
If someone with this hardware could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9cln/drivers/char/hw_random.c linux-2.6.9patch3/drivers/char/hw_random.c
--- linux-2.6.9cln/drivers/char/hw_random.c	2004-10-18 16:35:53.000000000 -0700
+++ linux-2.6.9patch3/drivers/char/hw_random.c	2004-10-20 14:52:42.000000000 -0700
@@ -581,7 +581,7 @@ static int __init rng_init (void)
 	DPRINTK ("ENTER\n");
 
 	/* Probe for Intel, AMD RNGs */
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	for_each_pci_dev(pdev) {
 		ent = pci_match_device (rng_pci_tbl, pdev);
 		if (ent) {
 			rng_ops = &rng_vendor_ops[ent->driver_data];

