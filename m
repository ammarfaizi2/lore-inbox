Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVCEPq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVCEPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCEPgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:36:42 -0500
Received: from coderock.org ([193.77.147.115]:37027 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261900AbVCEPfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:24 -0500
Subject: [patch 02/12] arch/i386/pci/i386.c: Use new for_each_pci_dev macro
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, hannal@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:11 +0100
Message-Id: <20050305153512.06F531F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




As requested by Christoph Hellwig I've created a new macro called
for_each_pci_dev. It is a wrapper for this common use of pci_get/find_device:

(while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL))

This macro will return the pci_dev *for all pci devices.  Here is the first patch I 
used to test this macro with. Compiled and booted on my T23. There will be
53 more patches using this new macro.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/pci/i386.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/pci/i386.c~for-each-pci-dev-arch_i386_pci_i386 arch/i386/pci/i386.c
--- kj/arch/i386/pci/i386.c~for-each-pci-dev-arch_i386_pci_i386	2005-03-05 16:09:19.000000000 +0100
+++ kj-domen/arch/i386/pci/i386.c	2005-03-05 16:09:19.000000000 +0100
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
