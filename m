Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTBDIkp>; Tue, 4 Feb 2003 03:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTBDIkp>; Tue, 4 Feb 2003 03:40:45 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:44806 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S267154AbTBDIko>;
	Tue, 4 Feb 2003 03:40:44 -0500
Date: Tue, 4 Feb 2003 11:45:26 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pci: make pci_direct_conf1 structure nonstatic
Message-ID: <20030204084526.GA361@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this triial patch is needed to use pci access functions from 
i386/pci/direct.c by the visws pci code. To achieve this patch
makes pci_direct_conf1 structure (which hold pci pointers of access 
functions) nonstatic. PCI id for SGI lithium hostbridge is added also.

SGI visws supports pci type 1 pci access, but needs different 
bus and irq enumeration logic.

Please consider applying.

Best regards.
 
-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pci

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/arch/i386/pci/direct.c linux-2.5.59/arch/i386/pci/direct.c
--- linux-2.5.59.vanilla/arch/i386/pci/direct.c	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/arch/i386/pci/direct.c	Mon Feb  3 15:55:11 2003
@@ -83,7 +83,7 @@
 		PCI_FUNC(devfn), where, size, value);
 }
 
-static struct pci_ops pci_direct_conf1 = {
+struct pci_ops pci_direct_conf1 = {
 	.read =		pci_conf1_read,
 	.write =	pci_conf1_write,
 };
diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/include/linux/pci_ids.h linux-2.5.59/include/linux/pci_ids.h
--- linux-2.5.59.vanilla/include/linux/pci_ids.h	Wed Jan 15 20:28:37 2003
+++ linux-2.5.59/include/linux/pci_ids.h	Mon Feb  3 15:55:12 2003
@@ -844,6 +844,7 @@
 
 #define PCI_VENDOR_ID_SGI		0x10a9
 #define PCI_DEVICE_ID_SGI_IOC3		0x0003
+#define PCI_VENDOR_ID_SGI_LITHIUM	0x1002
 
 #define PCI_VENDOR_ID_ACC		0x10aa
 #define PCI_DEVICE_ID_ACC_2056		0x0000

--u3/rZRmxL6MmkK24--
