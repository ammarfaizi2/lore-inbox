Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270721AbUJUSmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270721AbUJUSmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbUJUSll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:41:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59107 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270721AbUJUSgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:36:06 -0400
Date: Thu, 21 Oct 2004 11:35:49 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.6] cyclades.c: replace pci_find_device
Message-ID: <267570000.1098383749@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device.
If someone with this hardware could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9cln/drivers/char/cyclades.c linux-2.6.9patch/drivers/char/cyclades.c
--- linux-2.6.9cln/drivers/char/cyclades.c	2004-10-18 16:35:53.000000000 -0700
+++ linux-2.6.9patch/drivers/char/cyclades.c	2004-10-20 15:31:49.803025392 -0700
@@ -4765,7 +4765,7 @@ cy_detect_pci(void)
         for (i = 0; i < NR_CARDS; i++) {
                 /* look for a Cyclades card by vendor and device id */
                 while((device_id = cy_pci_dev_id[dev_index]) != 0) {
-                        if((pdev = pci_find_device(PCI_VENDOR_ID_CYCLADES,
+                        if((pdev = pci_get_device(PCI_VENDOR_ID_CYCLADES,
                                         device_id, pdev)) == NULL) {
                                 dev_index++;    /* try next device id */
                         } else {

