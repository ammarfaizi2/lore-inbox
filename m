Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUJDXFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUJDXFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbUJDXFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:05:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:29587 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268696AbUJDW5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:57:12 -0400
Date: Mon, 04 Oct 2004 15:58:01 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com,
       paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6][1/12] arch/ppc/kernel/pci.c replace pci_find_device with pci_get_device
Message-ID: <298570000.1096930681@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I have replaced this call with pci_get_device.
If someone with a PPC system could verify it I would appreciate it. This is the only
one in ppc/kernel all the others are under ppc/platform. There will be 12 total.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/kernel/pci.c linux-2.6.9-rc3-mm2patch/arch/ppc/kernel/pci.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/kernel/pci.c	2004-10-04 11:38:04.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/ppc/kernel/pci.c	2004-10-04 14:36:09.000000000 -0700
@@ -503,7 +503,7 @@ pcibios_allocate_resources(int pass)
 	u16 command;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -540,7 +540,7 @@ pcibios_assign_resources(void)
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */
@@ -866,7 +866,7 @@ pci_device_from_OF_node(struct device_no
 	 */
 	if (!pci_to_OF_bus_map)
 		return 0;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		if (pci_to_OF_bus_map[dev->bus->number] != *bus)
 			continue;
 		if (dev->devfn != *devfn)

