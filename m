Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbUKMAz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUKMAz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUKLXpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:45:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8067 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262714AbUKLXWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:55 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301720853@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <11003017202596@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.20, 2004/11/12 14:10:46-08:00, hannal@us.ibm.com

[PATCH] prpmc750.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/prpmc750.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/prpmc750.c b/arch/ppc/platforms/prpmc750.c
--- a/arch/ppc/platforms/prpmc750.c	2004-11-12 15:09:34 -08:00
+++ b/arch/ppc/platforms/prpmc750.c	2004-11-12 15:09:34 -08:00
@@ -109,7 +109,7 @@
 	 * resource subsystem doesn't fixup the
 	 * PCI mem resources on the CL5446.
 	 */
-	if ((dev = pci_find_device(PCI_VENDOR_ID_CIRRUS,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_CIRRUS,
 				   PCI_DEVICE_ID_CIRRUS_5446, 0))) {
 		dev->resource[0].start += PRPMC750_PCI_PHY_MEM_OFFSET;
 		dev->resource[0].end += PRPMC750_PCI_PHY_MEM_OFFSET;
@@ -121,6 +121,7 @@
 		outb(0x0f, 0x3c4);
 		/* Set proper DRAM config */
 		outb(0xdf, 0x3c5);
+		pci_dev_put(dev);
 	}
 }
 

