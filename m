Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTHURjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbTHURbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:14278 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262846AbTHURbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:31:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870694188@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870692308@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1285.1.2, 2003/08/20 16:33:09-07:00, ink@jurassic.park.msu.ru

[PATCH] PCI: undo recent pci_setup_bridge() change

That patch went into mainline by mistake - it was initial variant of a
fix for the problem with disabled P2P bridges. Which has already been
fixed properly in -test3.


 drivers/pci/setup-bus.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Thu Aug 21 10:21:45 2003
+++ b/drivers/pci/setup-bus.c	Thu Aug 21 10:21:45 2003
@@ -203,11 +203,6 @@
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

