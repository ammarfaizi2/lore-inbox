Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270062AbUJTGsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270062AbUJTGsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270104AbUJSXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:10:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:6282 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270113AbUJSWq0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:26 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257353013@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <1098225735893@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.24, 2004/10/06 12:15:41-07:00, janitor@sternwelten.at

[PATCH] PCI pci_dev_b to list_for_each_entry: drivers-pci-setup-bus.c

list_for_each & pci_(dev|bus)_[bg] replaced by list_for_each_entry.


Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/setup-bus.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	2004-10-19 15:25:37 -07:00
+++ b/drivers/pci/setup-bus.c	2004-10-19 15:25:37 -07:00
@@ -533,16 +533,16 @@
 void __init
 pci_assign_unassigned_resources(void)
 {
-	struct list_head *ln;
+	struct pci_bus *bus;
 
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
-	list_for_each(ln, &pci_root_buses) {
-		pci_bus_size_bridges(pci_bus_b(ln));
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		pci_bus_size_bridges(bus);
 	}
 	/* Depth last, allocate resources and update the hardware. */
-	list_for_each(ln, &pci_root_buses) {
-		pci_bus_assign_resources(pci_bus_b(ln));
-		pci_enable_bridges(pci_bus_b(ln));
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		pci_bus_assign_resources(bus);
+		pci_enable_bridges(bus);
 	}
 }

