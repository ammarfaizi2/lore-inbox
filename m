Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTIISmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTIISmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:42:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:38377 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264351AbTIISmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:42:19 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Message-Id: <1063132902.1356.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 20:41:42 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: [PATCH] Power: call save_state on PCI devices along with suspend
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick !

Don't we want that ? It will help if any driver currently relies on
the save_state callback to be called...

Ben.

diff -urN linux-2.5/drivers/pci/pci-driver.c linuxppc-2.5-benh/drivers/pci/pci-driver.c
--- linux-2.5/drivers/pci/pci-driver.c	2003-09-09 20:16:09.000000000 +0200
+++ linuxppc-2.5-benh/drivers/pci/pci-driver.c	2003-09-09 20:05:59.000000000 +0200
@@ -163,6 +163,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	/* Compatibility with drivers using obsolete save_state */
+	if (drv && drv->save_state)
+		return drv->save_state(pci_dev,state);
 	if (drv && drv->suspend)
 		return drv->suspend(pci_dev,state);
 	return 0;


