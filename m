Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVIJMVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVIJMVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVIJMVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:39 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:52103 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750782AbVIJMVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:16 -0400
Date: Sat, 10 Sep 2005 14:21:08 +0200
Message-Id: <200509101221.j8ACL8oq017230@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 1/10] drivers/char: pci_find_device remove (drivers/char/ip2main.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ip2main.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -442,6 +442,7 @@ cleanup_module(void)
 #ifdef CONFIG_PCI
 		if (ip2config.type[i] == PCI && ip2config.pci_dev[i]) {
 			pci_disable_device(ip2config.pci_dev[i]);
+			pci_dev_put(ip2config.pci_dev[i]);
 			ip2config.pci_dev[i] = NULL;
 		}
 #endif
@@ -594,9 +595,10 @@ ip2_loadmain(int *iop, int *irqp, unsign
 		case PCI:
 #ifdef CONFIG_PCI
 			{
-				struct pci_dev *pci_dev_i = NULL;
-				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
-							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
+				struct pci_dev *pci_dev_i;
+				pci_dev_i = pci_get_device(
+					PCI_VENDOR_ID_COMPUTONE,
+					PCI_DEVICE_ID_COMPUTONE_IP2EX, NULL);
 				if (pci_dev_i != NULL) {
 					unsigned int addr;
 
