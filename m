Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbTCTHjh>; Thu, 20 Mar 2003 02:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbTCTHjh>; Thu, 20 Mar 2003 02:39:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34537 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263217AbTCTHjf>; Thu, 20 Mar 2003 02:39:35 -0500
Date: Wed, 19 Mar 2003 23:50:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <garzik@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixup warning for acenic
Message-ID: <14240000.1048146629@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, it's war on warnings hour. Get this from acenic,

drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined but not used

And indeed it doesn't *seem* to be used (though I'm less than confident
about that) ... can we just rip it out? Or should this be wrapped in
#ifdef MODULE or something (I'm compiling it in)?

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/net/acenic.c acenic_fix/drivers/net/acenic.c
--- virgin/drivers/net/acenic.c	Wed Mar  5 07:37:02 2003
+++ acenic_fix/drivers/net/acenic.c	Wed Mar 19 23:44:28 2003
@@ -131,34 +131,6 @@
 #define PCI_DEVICE_ID_SGI_ACENIC	0x0009
 #endif
 
-#if LINUX_VERSION_CODE >= 0x20400
-static struct pci_device_id acenic_pci_tbl[] __initdata = {
-	{ PCI_VENDOR_ID_ALTEON, PCI_DEVICE_ID_ALTEON_ACENIC_FIBRE,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ PCI_VENDOR_ID_ALTEON, PCI_DEVICE_ID_ALTEON_ACENIC_COPPER,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3C985,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ PCI_VENDOR_ID_NETGEAR, PCI_DEVICE_ID_NETGEAR_GA620,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ PCI_VENDOR_ID_NETGEAR, PCI_DEVICE_ID_NETGEAR_GA620T,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	/*
-	 * Farallon used the DEC vendor ID on their cards incorrectly,
-	 * then later Alteon's ID.
-	 */
-	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_FARALLON_PN9000SX,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ PCI_VENDOR_ID_ALTEON, PCI_DEVICE_ID_FARALLON_PN9100T,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_ACENIC,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
-	{ }
-};
-MODULE_DEVICE_TABLE(pci, acenic_pci_tbl);
-#endif
-
-
 #ifndef MODULE_LICENSE
 #define MODULE_LICENSE(a)
 #endif

