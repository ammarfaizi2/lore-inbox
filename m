Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVCNKIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVCNKIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVCNKIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:08:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:62415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261428AbVCNKHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:07:50 -0500
Date: Mon, 14 Mar 2005 02:02:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Richter <thor@math.TU-Berlin.DE>
Cc: linux-kernel@vger.kernel.org,
       "Steven R. Brudenell" <steven@brudenell.name>
Subject: Re: Fw: [Bugme-new] [Bug 4334] New: kernel support for netmos
 9835/9735 crippled since 2.6.9
Message-Id: <20050314020245.130b2d70.akpm@osdl.org>
In-Reply-To: <200503140930.KAA08568@mersenne.math.tu-berlin.de>
References: <20050313123754.78ab76a0.akpm@osdl.org>
	<200503140930.KAA08568@mersenne.math.tu-berlin.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Richter <thor@math.TU-Berlin.DE> wrote:
>
> 
> Hi Andrew,
>  
> > I'm inclined to simply revert that change.
> 
> In case the mentioned lines do cause problems, please do not hesitate
> to remove them. As the comments indicate, the patch was completely
> untested as I haven't had the cards available. However, please ensure
> that the parallel port remains available for the 9835/9735 in case
> they are removed from the parport module. Their references should be
> removed *only* from parport_pc, not from the PCI name database.
> 

OK.  Like this?

Steven, do you agree?

diff -puN drivers/parport/parport_pc.c~parport_pc-revert-netmos-patch drivers/parport/parport_pc.c
--- 25/drivers/parport/parport_pc.c~parport_pc-revert-netmos-patch	2005-03-14 01:55:52.000000000 -0800
+++ 25-akpm/drivers/parport/parport_pc.c	2005-03-14 01:59:32.000000000 -0800
@@ -2738,8 +2738,6 @@ enum parport_pc_pci_cards {
 	netmos_9855,
 	netmos_9735,
 	netmos_9835,
-	netmos_9755,
-	netmos_9715
 };
 
 
@@ -2813,10 +2811,8 @@ static struct parport_pc_pci {
 	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
 	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
 	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
-	/* netmos_9735 */               { 1, { { 2, 3 }, } },  /* untested */
-	/* netmos_9835 */               { 1, { { 2, 3 }, } },  /* untested */
-        /* netmos_9755 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
-        /* netmos_9715 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
+	/* netmos_9735 */		{ 1, { { 2, 3 }, } },
+	/* netmos_9835 */		{ 1, { { 2, 3 }, } },
 };
 
 static struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2899,10 +2895,6 @@ static struct pci_device_id parport_pc_p
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9755,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
diff -puN include/linux/pci_ids.h~parport_pc-revert-netmos-patch include/linux/pci_ids.h
--- 25/include/linux/pci_ids.h~parport_pc-revert-netmos-patch	2005-03-14 01:55:52.000000000 -0800
+++ 25-akpm/include/linux/pci_ids.h	2005-03-14 01:55:52.000000000 -0800
@@ -2530,8 +2530,6 @@
 #define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
-#define PCI_DEVICE_ID_NETMOS_9755	0x9755
-#define PCI_DEVICE_ID_NETMOS_9715	0x9715
 
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014
_

