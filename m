Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270049AbUJTHGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270049AbUJTHGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269515AbUJSXHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:07:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:64137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270094AbUJSWqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:23 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257344160@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <10982257342890@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.20, 2004/10/06 12:01:08-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-ppc64-kernel-pci.c

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc64/kernel/pci.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)


diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	2004-10-19 15:25:59 -07:00
+++ b/arch/ppc64/kernel/pci.c	2004-10-19 15:25:59 -07:00
@@ -236,11 +236,10 @@
 
 static void __init pcibios_claim_one_bus(struct pci_bus *b)
 {
-	struct list_head *ld;
+	struct pci_dev *dev;
 	struct pci_bus *child_bus;
 
-	for (ld = b->devices.next; ld != &b->devices; ld = ld->next) {
-		struct pci_dev *dev = pci_dev_b(ld);
+	list_for_each_entry(dev, &b->devices, bus_list) {
 		int i;
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -259,12 +258,10 @@
 #ifndef CONFIG_PPC_ISERIES
 static void __init pcibios_claim_of_setup(void)
 {
-	struct list_head *lb;
+	struct pci_bus *b;
 
-	for (lb = pci_root_buses.next; lb != &pci_root_buses; lb = lb->next) {
-		struct pci_bus *b = pci_bus_b(lb);
+	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_claim_one_bus(b);
-	}
 }
 #endif
 

