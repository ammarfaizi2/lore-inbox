Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUHXKwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUHXKwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUHXKwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:52:45 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:22271 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S267440AbUHXKwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:52:34 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408241052.MAA09594@cleopatra.math.tu-berlin.de>
Subject: Re: [PATCH] NetMOS 9805 ParPort interface
In-Reply-To: <20040823113206.7ca77d79.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Aug 2004 12:52:14 +0200 (CEST)
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, hi Marcelo,

sorry, my time is currently pretty limited. 

So here we go:

i) Apply the following to drivers/parport_pc.c:

/* snip */

--- parport_pc.c.old	Tue Aug 24 11:53:22 2004
+++ parport_pc.c	Tue Aug 24 12:12:31 2004
@@ -2636,6 +2636,10 @@
 	netmos_9805,
 	netmos_9815,
 	netmos_9855,
+	netmos_9735,
+	netmos_9835,
+	netmos_9755,
+	netmos_9715
 };
 
 
@@ -2709,6 +2713,10 @@
 	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
 	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
 	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
+	/* netmos_9735 */               { 1, { { 2, 3 }, } },  /* untested */
+	/* netmos_9835 */               { 1, { { 2, 3 }, } },  /* untested */
+        /* netmos_9755 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
+        /* netmos_9715 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
 };
 
 static struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2786,6 +2794,14 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9755,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);

/* snip */

and the following to include/linux/pci_ids.h:

/* snip */

--- pci_ids.h.old	Tue Aug 24 12:05:44 2004
+++ pci_ids.h	Tue Aug 24 12:15:21 2004
@@ -2313,6 +2313,8 @@
 #define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
+#define PCI_DEVICE_ID_NETMOS_9755	0x9755
+#define PCI_DEVICE_ID_NETMOS_9715	0x9715
 
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014

/* snip */

NetMOS 9805 support is already in the kernel, this patch adds the support
for the missing 9735,9855,9755 and 9715 chips.

And another remark: The 9735 and 9835 seem to be chips with serial *and*
parallel interfaces, so I suppose they are already claimed somewhere in
the serial driver. I don't know whether this causes any problems. I'm sorry
that I can't test, I've only a 9805 here. Any idea how these "dual" chips have
to be handled by the kernel?

So long,
	Thomas

