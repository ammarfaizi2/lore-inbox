Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUGWJTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUGWJTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 05:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUGWJTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 05:19:21 -0400
Received: from baikonur.stro.at ([213.239.196.228]:38348 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263085AbUGWJTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:19:19 -0400
Date: Fri, 23 Jul 2004 11:19:16 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [patch-kj] use list_for_each() i386/pci/pcbios.c
Message-ID: <20040723091916.GC14000@stro.at>
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

 linux-2.6.7-bk20-max/arch/i386/pci/pcbios.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/pci/pcbios.c~list_for_each-i386pci-pcbios arch/i386/pci/pcbios.c
--- linux-2.6.7-bk20/arch/i386/pci/pcbios.c~list_for_each-i386pci-pcbios	2004-07-11 14:41:13.000000000 +0200
+++ linux-2.6.7-bk20-max/arch/i386/pci/pcbios.c	2004-07-11 14:41:13.000000000 +0200
@@ -365,7 +365,7 @@ void __devinit pcibios_sort(void)
 		idx = found = 0;
 		while (pci_bios_find_device(dev->vendor, dev->device, idx, &bus, &devfn) == PCIBIOS_SUCCESSFUL) {
 			idx++;
-			for (ln=pci_devices.next; ln != &pci_devices; ln=ln->next) {
+			list_for_each(ln, &pci_devices) {
 				d = pci_dev_g(ln);
 				if (d->bus->number == bus && d->devfn == devfn) {
 					list_del(&d->global_list);

