Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUB1AMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbUB1AKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:10:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:51365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263219AbUB1AJv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:51 -0500
Subject: Re: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <10779269823390@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:42 -0800
Message-Id: <10779269823562@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1614, 2004/02/24 11:07:43-08:00, rmk-pci@arm.linux.org.uk

[PATCH] PCI: Don't report pci_request_regions() failure twice

pci_request_regions() reports an error when pci_request_region() fails.
However, since pci_request_region() already reports an error on failure,
pci_request_regions() has some unwanted duplication.


 drivers/pci/pci.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri Feb 27 15:57:30 2004
+++ b/drivers/pci/pci.c	Fri Feb 27 15:57:30 2004
@@ -535,11 +535,6 @@
 	return 0;
 
 err_out:
-	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%lx@%lx for device %s\n",
-		pci_resource_flags(pdev, i) & IORESOURCE_IO ? "I/O" : "mem",
-		i + 1, /* PCI BAR # */
-		pci_resource_len(pdev, i), pci_resource_start(pdev, i),
-		pci_name(pdev));
 	while(--i >= 0)
 		pci_release_region(pdev, i);
 		

