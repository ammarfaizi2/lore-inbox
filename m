Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbUKLXlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUKLXlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUKLXlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:41:17 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10115 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262709AbUKLXWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:54 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017202596@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <11003017203241@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.21, 2004/11/12 14:11:07-08:00, hannal@us.ibm.com

[PATCH] mcpn765.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device
and pci_dev_put.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/mcpn765.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/arch/ppc/platforms/mcpn765.c b/arch/ppc/platforms/mcpn765.c
--- a/arch/ppc/platforms/mcpn765.c	2004-11-12 15:09:26 -08:00
+++ b/arch/ppc/platforms/mcpn765.c	2004-11-12 15:09:27 -08:00
@@ -185,7 +185,7 @@
 	struct pci_dev	*dev;
 	u_char		c;
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_0,
 				   NULL)) == NULL) {
 		printk("No VIA ISA bridge found\n");
@@ -209,8 +209,8 @@
 	pci_write_config_dword(dev, 0x54, 0);
 	pci_write_config_byte(dev, 0x58, 0);
 
-
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	pci_dev_put(dev);
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_1,
 				   NULL)) == NULL) {
 		printk("No VIA ISA bridge found\n");
@@ -225,6 +225,7 @@
 	pci_read_config_byte(dev, 0x40, &c);
 	c |= 0x03;
 	pci_write_config_byte(dev, 0x40, c);
+	pci_dev_put(dev);
 
 	return;
 }

