Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTFJVgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTFJVfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:35:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42396 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263837AbTFJShJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:09 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709711559@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270970425@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:31 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1391, 2003/06/10 10:53:11-07:00, greg@kroah.com

[PATCH] PCI: remove pci_bus_b() call in arch/i386/pci/common.c


 arch/i386/pci/common.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Tue Jun 10 11:15:05 2003
+++ b/arch/i386/pci/common.c	Tue Jun 10 11:15:05 2003
@@ -104,11 +104,9 @@
 
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
-	struct list_head *list;
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 
-	list_for_each(list, &pci_root_buses) {
-		bus = pci_bus_b(list);
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		if (bus->number == busnum) {
 			/* Already scanned */
 			return bus;

