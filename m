Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUHWTAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUHWTAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUHWS6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:58:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:12484 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267311AbUHWShF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:05 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286082835@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <1093286082458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.7, 2004/08/02 15:35:34-07:00, domen@coderock.org

[PATCH] PCI: use list_for_each() drivers/pci/setup-bus.c

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/setup-bus.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	2004-08-23 11:08:16 -07:00
+++ b/drivers/pci/setup-bus.c	2004-08-23 11:08:16 -07:00
@@ -537,10 +537,11 @@
 
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

