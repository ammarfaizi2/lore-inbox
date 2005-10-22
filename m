Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVJVUnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVJVUnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 16:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVJVUnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 16:43:21 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:26009 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750808AbVJVUnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 16:43:20 -0400
X-Mailbox-Line: From laurent@antares.localdomain sam oct 22 21:41:44 2005
Message-Id: <20051022194143.998478000@antares.localdomain>
References: <20051022194123.683082000@antares.localdomain>
Date: Sat, 22 Oct 2005 21:41:26 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: Wim Van Sebroeck <wim@iguana.be>, Kenji Hollis <kenji@bitgate.com>,
       Alan Cox <alan@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: updates .owner field of struct pci_driver
Content-Disposition: inline; filename=watchdog_pci_driver_owner_field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

--
 drivers/char/watchdog/pcwd_pci.c |    1 +
 drivers/char/watchdog/wdt_pci.c  |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6-stable/drivers/char/watchdog/pcwd_pci.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/watchdog/pcwd_pci.c
+++ linux-2.6-stable/drivers/char/watchdog/pcwd_pci.c
@@ -644,6 +644,7 @@
 MODULE_DEVICE_TABLE(pci, pcipcwd_pci_tbl);
 
 static struct pci_driver pcipcwd_driver = {
+	.owner		= THIS_MODULE,
 	.name		= WATCHDOG_NAME,
 	.id_table	= pcipcwd_pci_tbl,
 	.probe		= pcipcwd_card_init,
Index: linux-2.6-stable/drivers/char/watchdog/wdt_pci.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/watchdog/wdt_pci.c
+++ linux-2.6-stable/drivers/char/watchdog/wdt_pci.c
@@ -711,6 +711,7 @@
 
 
 static struct pci_driver wdtpci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "wdt_pci",
 	.id_table	= wdtpci_pci_tbl,
 	.probe		= wdtpci_init_one,

--

