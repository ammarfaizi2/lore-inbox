Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUGWJWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUGWJWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 05:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUGWJWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 05:22:10 -0400
Received: from baikonur.stro.at ([213.239.196.228]:57762 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266864AbUGWJWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:22:03 -0400
Date: Fri, 23 Jul 2004 11:22:01 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [patch-kj] use list_for_each() i386/pci/common.c
Message-ID: <20040723092201.GD1795@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use list_for_each() where applicable
- for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
+ list_for_each(list, &ymf_devs) {
pure cosmetic change, defined as a preprocessor macro in:
include/linux/list.h

patch against 2.6.7-bk20, please tell if you need against newer.

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-bk20-max/arch/i386/pci/common.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/pci/common.c~list_for_each-i386pci-common arch/i386/pci/common.c
--- linux-2.6.7-bk20/arch/i386/pci/common.c~list_for_each-i386pci-common	2004-07-11 14:41:10.000000000 +0200
+++ linux-2.6.7-bk20-max/arch/i386/pci/common.c	2004-07-11 14:41:10.000000000 +0200
@@ -70,7 +70,7 @@ static void __devinit pcibios_fixup_ghos
 	int i;
 
 	DBG("PCI: Scanning for ghost devices on bus %d\n", b->number);
-	for (ln=b->devices.next; ln != &b->devices; ln=ln->next) {
+	list_for_each(ln, &b->devices) {
 		d = pci_dev_b(ln);
 		if ((d->class >> 8) == PCI_CLASS_BRIDGE_HOST)
 			seen_host_bridge++;

