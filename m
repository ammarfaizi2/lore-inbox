Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbUKLXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUKLXbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUKLX3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:29:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49046 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262680AbUKLXWk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:40 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301718611@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <1100301718867@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.8, 2004/11/12 14:04:45-08:00, hannal@us.ibm.com

[PATCH] lopec.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I have replaced this call with
pci_get_device.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/lopec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/lopec.c b/arch/ppc/platforms/lopec.c
--- a/arch/ppc/platforms/lopec.c	2004-11-12 15:11:04 -08:00
+++ b/arch/ppc/platforms/lopec.c	2004-11-12 15:11:04 -08:00
@@ -189,7 +189,7 @@
 static void
 lopec_ide_probe(void)
 {
-	struct pci_dev *dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	struct pci_dev *dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 					      PCI_DEVICE_ID_WINBOND_82C105,
 					      NULL);
 	lopec_ide_ports_known = 1;
@@ -200,6 +200,7 @@
 		lopec_ide_ctl_regbase[0] = dev->resource[1].start;
 		lopec_ide_ctl_regbase[1] = dev->resource[3].start;
 		lopec_idedma_regbase = dev->resource[4].start;
+		pci_dev_put(dev);
 	}
 }
 

