Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbTIKPVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTIKPVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:21:11 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:17539 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S261400AbTIKPVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:21:06 -0400
X-Analyze: Velop Mail Shield v0.0.3
To: linux-kernel@vger.kernel.org
Subject: Support for Netmos 6 port 16550a serial card
Cc: marcelo@conectiva.com.br, marcelo@macp.eti.br
Message-Id: <20030911152101.CE8BD16CD2D@macp.eti.br>
Date: Thu, 11 Sep 2003 12:21:01 -0300 (BRT)
From: root@macp.eti.br (root)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follows a trivial patch to add support of a popular serial card in Brazil that
contains 6 standard 16550A uarts with a Netmos PCI glue. Only adds the
apropriate entries to the proper pci and serial ids. Please apply.

diff -urN linux-2.4.22/drivers/char/serial.c linux-2.4.22/drivers/char/serial.c
--- linux-2.4.21/drivers/char/serial.c	2003-09-11 12:11:54.000000000 -0300
+++ linux-2.4.22/drivers/char/serial.c	2003-09-10 14:17:22.000000000 -0300
@@ -4370,6 +4370,8 @@
 	pbn_computone_4,
 	pbn_computone_6,
 	pbn_computone_8,
+
+	netmos_9845
 };
 
 static struct pci_board pci_boards[] __devinitdata = {
@@ -4478,6 +4480,7 @@
 		0x40, 2, NULL, 0x200 },
 	{ SPCI_FL_BASE0, 8, 921600, /* IOMEM */		   /* pbn_computone_8 */
 		0x40, 2, NULL, 0x200 },
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 6, 115200 },			   /* netmos_9845 */
 };
 
 /*
@@ -4921,6 +4924,10 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_dci_pccom8 },
 
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9845
+		},
+
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
diff -urN linux-2.4.22/drivers/pci/pci.ids linux-2.4.22/drivers/pci/pci.ids
--- linux-2.4.21/drivers/pci/pci.ids	2003-09-11 12:11:55.000000000 -0300
+++ linux-2.4.22/drivers/pci/pci.ids	2003-09-10 14:17:22.000000000 -0300
@@ -7217,6 +7217,7 @@
 9710  NetMos Technology
 	9815  VScom 021H-EP2 2 port parallel adaptor
 	9835  222N-2 I/O Card (2S+1P)
+	9845  6 port 16550a serial card
 a0a0  AOPEN Inc.
 a0f1  UNISYS Corporation
 a200  NEC Corporation
