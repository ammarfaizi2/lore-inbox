Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129540AbRCAHb7>; Thu, 1 Mar 2001 02:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRCAHbl>; Thu, 1 Mar 2001 02:31:41 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:23813 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129540AbRCAHbf>; Thu, 1 Mar 2001 02:31:35 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A9DF64F.1255C6C9@yahoo.com>
Date: Thu, 01 Mar 2001 02:12:15 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.2 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
CC: linux-parport@torque.net
Subject: [PATCH] smaller parport_pc for non-PCI boxes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is quite a bit of PCI stuff that gets compiled into parport_pc.c
even when CONFIG_PCI isn't enabled.  This patch cuts down the size quite 
a bit (more than 4k off the object, about 1k off the zImage) for the 
older non-PCI machines which are typically resource starved anyway... 

Patch is against 2.4.2

Paul.


--- drivers/parport/parport_pc.c~	Wed Feb 14 02:41:01 2001
+++ drivers/parport/parport_pc.c	Thu Mar  1 00:54:19 2001
@@ -11,6 +11,7 @@
  * Cleaned up include files - Russell King <linux@arm.uk.linux.org>
  * DMA support - Bert De Jonghe <bert@sophis.be>
  * Many ECP bugs fixed.  Fred Barnes & Jamie Lokier, 1999
+ * More PCI support now conditional on CONFIG_PCI, 03/2001, Paul G. 
  */
 
 /* This driver should work with any hardware that is broadly compatible
@@ -2182,6 +2183,7 @@
 }
 
 
+#ifdef CONFIG_PCI
 /* Via support maintained by Jeff Garzik <jgarzik@mandrakesoft.com> */
 static int __devinit sio_via_686a_probe (struct pci_dev *pdev)
 {
@@ -2547,7 +2549,6 @@
 
 static int __init parport_pc_init_superio (void)
 {
-#ifdef CONFIG_PCI
 	const struct pci_device_id *id;
 	struct pci_dev *pdev;
 
@@ -2558,10 +2559,13 @@
 
 		return parport_pc_superio_info[id->driver_data].probe (pdev);
 	}
-#endif /* CONFIG_PCI */
 
 	return 0; /* zero devices found */
 }
+#else
+static struct pci_driver parport_pc_pci_driver;
+static int __init parport_pc_init_superio(void) {return 0;}
+#endif /* CONFIG_PCI */
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
 static int __init __attribute__((unused))



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

