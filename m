Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUJCV0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUJCV0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 17:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUJCV0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 17:26:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:21902 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268163AbUJCV0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 17:26:11 -0400
Date: Sun, 3 Oct 2004 23:33:33 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>,
       linux-atm-general <linux-atm-general@lists.sourceforge.net>
Subject: [PATCH] fix warning about wrong format in drivers/atm/ambassador.c::do_pci_device
Message-ID: <Pine.LNX.4.61.0410032325010.2954@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc spits the following at me when building drivers/atm/ambassador.c :

  CC      drivers/atm/ambassador.o
drivers/atm/ambassador.c: In function `do_pci_device':
drivers/atm/ambassador.c:2295: warning: unsigned int format, long unsigned int arg (arg 2)
drivers/atm/ambassador.c:2295: warning: unsigned int format, long unsigned int arg (arg 2)

Here's a trivial fix.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk3-orig/drivers/atm/ambassador.c linux-2.6.9-rc3-bk3/drivers/atm/ambassador.c
--- linux-2.6.9-rc3-bk3-orig/drivers/atm/ambassador.c	2004-09-30 05:03:55.000000000 +0200
+++ linux-2.6.9-rc3-bk3/drivers/atm/ambassador.c	2004-10-03 23:23:19.000000000 +0200
@@ -2293,7 +2293,7 @@ static int __init do_pci_device(struct p
 	u8 irq = pci_dev->irq;
 
 	PRINTD (DBG_INFO, "found Madge ATM adapter (amb) at"
-		" IO %x, IRQ %u, MEM %p", pci_resource_start(pci_dev, 1),
+		" IO %lx, IRQ %u, MEM %p", pci_resource_start(pci_dev, 1),
 		irq, bus_to_virt(pci_resource_start(pci_dev, 0)));
 
 	// check IO region


