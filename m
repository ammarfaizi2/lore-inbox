Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbUKMAz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUKMAz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbUKLXpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:45:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:32131 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262699AbUKLXWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:50 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301718867@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017192982@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.9, 2004/11/12 14:06:23-08:00, hannal@us.ibm.com

[PATCH] k2.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I have replaced this call with
pci_get_device.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/k2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/k2.c b/arch/ppc/platforms/k2.c
--- a/arch/ppc/platforms/k2.c	2004-11-12 15:10:57 -08:00
+++ b/arch/ppc/platforms/k2.c	2004-11-12 15:10:57 -08:00
@@ -116,7 +116,7 @@
 	/*
 	 * Enable DMA support on hdc
 	 */
-	ide_dev = pci_find_device(PCI_VENDOR_ID_AL,
+	ide_dev = pci_get_device(PCI_VENDOR_ID_AL,
 				  PCI_DEVICE_ID_AL_M5229, NULL);
 
 	if (ide_dev) {
@@ -126,6 +126,7 @@
 		ide_dma_base = pci_resource_start(ide_dev, 4);
 		outb(0x00, ide_dma_base + 0x2);
 		outb(0x20, ide_dma_base + 0xa);
+		pci_dev_put(ide_dev);
 	}
 #endif
 }

