Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSIANuP>; Sun, 1 Sep 2002 09:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSIANuP>; Sun, 1 Sep 2002 09:50:15 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:33925 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317022AbSIANuO>; Sun, 1 Sep 2002 09:50:14 -0400
Date: Sun, 1 Sep 2002 16:11:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Greg Kroah-Hartmann <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] set pci dma mask for ohci-hcd
Message-ID: <Pine.LNX.4.44.0209011610390.26729-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.33/drivers/usb/host/ohci-pci.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.33/drivers/usb/host/ohci-pci.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ohci-pci.c
--- linux-2.5.33/drivers/usb/host/ohci-pci.c	31 Aug 2002 22:30:41 -0000	1.1.1.1
+++ linux-2.5.33/drivers/usb/host/ohci-pci.c	1 Sep 2002 12:41:23 -0000
@@ -36,6 +36,11 @@
 	int		ret;
 
 	if (hcd->pdev) {
+		if (pci_set_dma_mask(hcd->pdev, 0xFFFFFFFF)) {
+			err("couldn't set PCI dma mask");
+			return -EIO;
+		}
+
 		ohci->hcca = pci_alloc_consistent (hcd->pdev,
 				sizeof *ohci->hcca, &ohci->hcca_dma);
 		if (!ohci->hcca)

-- 
function.linuxpower.ca

