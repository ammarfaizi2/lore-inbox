Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267116AbSLDWQL>; Wed, 4 Dec 2002 17:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbSLDWQL>; Wed, 4 Dec 2002 17:16:11 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:29710 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S267116AbSLDWQK> convert rfc822-to-8bit; Wed, 4 Dec 2002 17:16:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.4.20 cciss  patch 01 - adds support for the SA641, SA642 and SA6400 controllers.
Date: Wed, 4 Dec 2002 16:23:37 -0600
Message-ID: <A2C35BB97A9A384CA2816D24522A53BB03991726@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.20 cciss  patch 01 - adds support for the SA641, SA642 and SA6400 controllers.
Thread-Index: AcKb48rIqn3VeHF2TYG9m/4OigiIRQ==
From: "White, Charles" <Charles.White@hp.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>, "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Dec 2002 22:23:38.0246 (UTC) FILETIME=[CAD25A60:01C29BE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds support for the SA641, SA642 and SA6400
controllers to the cciss driver in the 2.2.20 tree. 



diff -urN linux-2.4.20.orig/Documentation/cciss.txt
linux-2.4.20.cciss_p01/Documentation/cciss.txt
--- linux-2.4.20.orig/Documentation/cciss.txt	Fri Aug  2 20:39:42 2002
+++ linux-2.4.20.cciss_p01/Documentation/cciss.txt	Wed Dec  4
15:05:43 2002
@@ -9,6 +9,9 @@
 	* SA 5i 
 	* SA 532
 	* SA 5312
+	* SA 641
+	* SA 642
+	* SA 6400
 
 If nodes are not already created in the /dev/cciss directory
 
diff -urN linux-2.4.20.orig/drivers/block/cciss.c
linux-2.4.20.cciss_p01/drivers/block/cciss.c
--- linux-2.4.20.orig/drivers/block/cciss.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.20.cciss_p01/drivers/block/cciss.c	Wed Dec  4
15:09:39 2002
@@ -56,6 +56,11 @@
 #include "cciss.h"
 #include <linux/cciss_ioctl.h>
 
+/* remove when PCI_DEVICE_ID_COMPAQ_CCISSC is in pci_ids.h */
+#ifndef PCI_DEVICE_ID_COMPAQ_CCISSC
+#define PCI_DEVICE_ID_COMPAQ_CCISSC 0x46
+#endif
+
 /* define the PCI info for the cards we can control */
 const struct pci_device_id cciss_pci_device_id[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
@@ -66,6 +71,12 @@
                         0x0E11, 0x4082, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
                         0x0E11, 0x4083, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CCISSC,
+                        0x0E11, 0x409A, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CCISSC,
+                        0x0E11, 0x409B, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CCISSC,
+                        0x0E11, 0x409C, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -81,6 +92,9 @@
 	{ 0x40800E11, "Smart Array 5i", &SA5B_access},
 	{ 0x40820E11, "Smart Array 532", &SA5B_access},
 	{ 0x40830E11, "Smart Array 5312", &SA5B_access},
+	{ 0x409A0E11, "Smart Array 641", &SA5_access},
+	{ 0x409B0E11, "Smart Array 642", &SA5_access},
+	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode
*/
