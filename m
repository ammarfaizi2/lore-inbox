Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269453AbUJFV2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbUJFV2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbUJFU20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31981 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269477AbUJFUXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:23:03 -0400
Date: Wed, 06 Oct 2004 13:23:28 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, hannal@us.ibm.com, kernel-janitors@lists.osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2.6] [1/54] arch/i386/pci/i386.c: Use new for_each_pci_dev macro 
Message-ID: <3600000.1097094208@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As requested by Christoph Hellwig I've created a new macro called
for_each_pci_dev. It is a wrapper for this common use of pci_get/find_device:

(while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL))

This macro will return the pci_dev *for all pci devices.  Here is the first patch I 
used to test this macro with. Compiled and booted on my T23. There will be
53 more patches using this new macro.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/i386/pci/i386.c linux-2.6.9-rc3-mm2patch2/arch/i386/pci/i386.c
--- linux-2.6.9-rc3-mm2cln/arch/i386/pci/i386.c	2004-10-04 11:38:04.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch2/arch/i386/pci/i386.c	2004-10-06 12:25:50.449991552 -0700
@@ -124,7 +124,7 @@ static void __init pcibios_allocate_reso
 	u16 command;
 	struct resource *r, *pr;
 
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for(idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -168,7 +168,7 @@ static int __init pcibios_assign_resourc
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */



