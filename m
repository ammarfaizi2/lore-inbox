Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266713AbUGWJV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266713AbUGWJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUGWJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 05:21:59 -0400
Received: from baikonur.stro.at ([213.239.196.228]:58542 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266713AbUGWJV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:21:56 -0400
Date: Fri, 23 Jul 2004 11:21:53 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [patch-kj] use list_for_each() drivers/pci/setup-bus.c
Message-ID: <20040723092153.GD14000@stro.at>
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

 linux-2.6.7-bk20-max/drivers/pci/setup-bus.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/pci/setup-bus.c~list_for_each-pci-setup-bus drivers/pci/setup-bus.c
--- linux-2.6.7-bk20/drivers/pci/setup-bus.c~list_for_each-pci-setup-bus	2004-07-11 14:41:20.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/pci/setup-bus.c	2004-07-11 14:41:20.000000000 +0200
@@ -537,10 +537,11 @@ pci_assign_unassigned_resources(void)
 
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
-	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next)
+	list_for_each(ln, &pci_root_buses) {
 		pci_bus_size_bridges(pci_bus_b(ln));
+	}
 	/* Depth last, allocate resources and update the hardware. */
-	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
+	list_for_each(ln, &pci_root_buses) {
 		pci_bus_assign_resources(pci_bus_b(ln));
 		pci_enable_bridges(pci_bus_b(ln));
 	}

