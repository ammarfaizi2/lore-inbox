Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbUKLXlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUKLXlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUKLXdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:33:31 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28045 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262674AbUKLXWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:38 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017202524@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <1100301720853@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.19, 2004/11/12 14:10:24-08:00, hannal@us.ibm.com

[PATCH] sandpoint.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/sandpoint.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c	2004-11-12 15:09:42 -08:00
+++ b/arch/ppc/platforms/sandpoint.c	2004-11-12 15:09:42 -08:00
@@ -575,7 +575,7 @@
 static void
 sandpoint_ide_probe(void)
 {
-	struct pci_dev *pdev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	struct pci_dev *pdev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 			PCI_DEVICE_ID_WINBOND_82C105, NULL);
 
 	if (pdev) {
@@ -584,6 +584,7 @@
 		sandpoint_ide_ctl_regbase[0]=pdev->resource[1].start;
 		sandpoint_ide_ctl_regbase[1]=pdev->resource[3].start;
 		sandpoint_idedma_regbase=pdev->resource[4].start;
+		pci_dev_put(dev);
 	}
 
 	sandpoint_ide_ports_known = 1;

