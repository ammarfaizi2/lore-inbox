Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSEFGjH>; Mon, 6 May 2002 02:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314230AbSEFGjG>; Mon, 6 May 2002 02:39:06 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:51407 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314138AbSEFGjF>; Mon, 6 May 2002 02:39:05 -0400
Date: Mon, 6 May 2002 08:17:52 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: twaugh@redhat.com
Subject: [PATCH] Add NetMos 9835 to parport_serial
Message-ID: <Pine.LNX.4.44.0205060813370.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested simultaneous serial i/o and parallel port. The base_baud of 115200 
i just chose as a safe default, i didn't try pushing it any further. 
During testing of parport interrupt sharing, i noticed an oddity whereupon 
parport was allowed to register the same irq even though it didn't specify 
SA_SHIRQ and serial did a request_irq before parport. But then again it 
was late saturday and the booze was plenty...

Regards,
	Zwane Mwaikambo

--- linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c.orig	Sun May  5 14:24:36 2002
+++ linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c	Sun May  5 14:38:57 2002
@@ -41,6 +41,7 @@
 	avlab_2s1p,
 	avlab_2s1p_650,
 	avlab_2s1p_850,
+	netmos_9835
 };
 
 
@@ -74,6 +75,7 @@
 	/* avlab_2s1p     */		{ 1, { { 2, 3}, } },
 	/* avlab_2s1p_650 */		{ 1, { { 2, 3}, } },
 	/* avlab_2s1p_850 */		{ 1, { { 2, 3}, } },
+	/* netmos_9835 */		{ 1, { { 2, 3}, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
@@ -92,6 +94,8 @@
 	{ 0x14db, 0x2160, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p},
 	{ 0x14db, 0x2161, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_650},
 	{ 0x14db, 0x2162, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_850},
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -129,6 +133,7 @@
 /* avlab_2s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_2s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_2s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9835 */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 };
 
 struct parport_serial_private {
@@ -266,6 +271,10 @@
                                         "hi" as an offset (see SYBA
                                         def.) */
 		/* TODO: test if sharing interrupts works */
+
+		/* not with the netmos card i tested with, due to the
+		 * parport ISR methinks -Zwane
+		*/
 		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
 			"I/O at %#lx(%#lx)\n",
 			parport_serial_pci_tbl[i].vendor,

-- 
http://function.linuxpower.ca
		

