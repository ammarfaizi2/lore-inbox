Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVALADe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVALADe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVAKXk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:40:28 -0500
Received: from coderock.org ([193.77.147.115]:710 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262948AbVAKXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:06 -0500
Subject: [patch 03/11] arch/i386/pci/i386.c: Use new for_each_pci_dev macro
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, hannal@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:34:58 +0100
Message-Id: <20050111233458.9B8E01F228@trashy.coderock.org>
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
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/pci/i386.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/pci/i386.c~for-each-pci-dev-arch_i386_pci_i386 arch/i386/pci/i386.c
--- kj/arch/i386/pci/i386.c~for-each-pci-dev-arch_i386_pci_i386	2005-01-10 17:59:57.000000000 +0100
+++ kj-domen/arch/i386/pci/i386.c	2005-01-10 17:59:57.000000000 +0100
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
_
