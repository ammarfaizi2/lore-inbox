Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTHTWkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTHTWkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:40:09 -0400
Received: from [195.208.223.239] ([195.208.223.239]:41600 "EHLO
	pls.park.msu.ru") by vger.kernel.org with ESMTP id S262282AbTHTWj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:39:26 -0400
Date: Thu, 21 Aug 2003 02:40:44 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.6] PCI: undo recent pci_setup_bridge() change
Message-ID: <20030821024044.A954@pls.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That patch went into mainline by mistake - it was initial variant of a
fix for the problem with disabled P2P bridges. Which has already been
fixed properly in -test3.

Ivan.

--- 2.6/drivers/pci/setup-bus.c	Tue Aug 19 20:43:08 2003
+++ linux/drivers/pci/setup-bus.c	Wed Aug 20 02:03:49 2003
@@ -203,11 +203,6 @@ pci_setup_bridge(struct pci_bus *bus)
 	   Enable ISA in either case (FIXME!). */
 	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
-
-	/* Make sure the bridge COMMAND register has the appropriate
-	   bits set, just in case...
-	*/
-	pcibios_enable_device(bridge, 0xfff);
 }
 
 /* Check whether the bridge supports optional I/O and
