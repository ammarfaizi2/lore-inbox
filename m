Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWJFFgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWJFFgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWJFFgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:36:05 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:18102 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932207AbWJFFfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:36 -0400
Subject: [PATCH 4/9] sound/pci/au88x0/au88x0.c: ioremap balanced with
	iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:57 +0530
Message-Id: <1160113137.19143.139.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 au88x0.c |    1 +
 1 files changed, 1 insertion(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/pci/au88x0/au88x0.c linux-2.6.19-rc1/sound/pci/au88x0/au88x0.c
--- linux-2.6.19-rc1-orig/sound/pci/au88x0/au88x0.c	2006-09-21 10:15:52.000000000 +0530
+++ linux-2.6.19-rc1/sound/pci/au88x0/au88x0.c	2006-10-05 16:22:35.000000000 +0530
@@ -128,6 +128,7 @@ static int snd_vortex_dev_free(struct sn
 	// Take down PCI interface.
 	synchronize_irq(vortex->irq);
 	free_irq(vortex->irq, vortex);
+	iounmap(vortex->mmio);
 	pci_release_regions(vortex->pci_dev);
 	pci_disable_device(vortex->pci_dev);
 	kfree(vortex);


