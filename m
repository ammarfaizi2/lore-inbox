Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266579AbUBQVdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266608AbUBQVaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:30:07 -0500
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:64529 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S266627AbUBQV2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:28:39 -0500
Subject: [PATCH]2.6.3-rc2 MSI Documentation
From: Martine Silbermann <Martine.Silbermann@hp.com>
To: greg@kraoh.com, linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Cc: Martine.Silbermann@hp.com
Content-Type: multipart/mixed; boundary="=-vgxj9wz8oh7D8Lyg0qhc"
Organization: 
Message-Id: <1077053311.7426.5.camel@wcswing.americas.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Feb 2004 16:28:31 -0500
X-OriginalArrivalTime: 17 Feb 2004 21:28:36.0764 (UTC) FILETIME=[00BE2DC0:01C3F59D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vgxj9wz8oh7D8Lyg0qhc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While trying to enable MSI I noticed that the documentation 
that describes how to do it is slightly out of date. This 
is mostly due to the fact that the code for MSI support has 
been incorporated in the 2.6.1 kernel. Below is a patch that 
should bring this documentation current.

Martine

--=-vgxj9wz8oh7D8Lyg0qhc
Content-Disposition: attachment; filename=patch-2.6.3-rc2-MSI-doc
Content-Type: text/plain; name=patch-2.6.3-rc2-MSI-doc; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc2/Documentation/MSI-HOWTO.txt	2004-02-09 22:00:01.000000000 -0500
+++ linux-2.6.3-rc2_mine/Documentation/MSI-HOWTO.txt	2004-02-12 14:54:39.602300480 -0500
@@ -1,6 +1,8 @@
 		The MSI Driver Guide HOWTO
 	Tom L Nguyen tom.l.nguyen@intel.com
 			10/03/2003
+	Revised Feb 12, 2004 by Martine Silbermann
+		email: Martine.Silbermann@hp.com
 
 1. About this guide
 
@@ -90,17 +92,14 @@
 5. Configuring a driver to use MSI/MSI-X
 
 By default, the kernel will not enable MSI/MSI-X on all devices that
-support this capability once the patch is installed. A kernel
-configuration option must be selected to enable MSI/MSI-X support.
+support this capability. The CONFIG_PCI_USE_VECTOR kernel option
+must be selected to enable MSI/MSI-X support.
 
 5.1 Including MSI support into the kernel
 
-To include MSI support into the kernel requires users to patch the
-VECTOR-base patch first and then the MSI patch because the MSI
-support needs VECTOR based scheme. Once these patches are installed,
-setting CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
-the option for MSI-capable device drivers to selectively enable MSI
-(using pci_enable_msi as desribed below).
+To allow MSI-Capable device drivers to selectively enable MSI (using
+pci_enable_msi as described below), the VECTOR based scheme needs to
+be enabled by setting CONFIG_PCI_USE_VECTOR.
 
 Since the target of the inbound message is the local APIC, providing
 CONFIG_PCI_USE_VECTOR is dependent on whether CONFIG_X86_LOCAL_APIC
@@ -125,12 +124,12 @@
 	|	     | <===============	| 			 |
 	| MSI MODE   |	  	     	| PIN-IRQ ASSERTION MODE |
 	| 	     | ===============>	|			 |
- 	 ------------	free_irq      	 ------------------------
+ 	 ------------  msi_free_vectors  ------------------------
 
 5.2 Configuring for MSI support
 
 Due to the non-contiguous fashion in vector assignment of the
-existing Linux kernel, this patch does not support multiple
+existing Linux kernel, this version does not support multiple
 messages regardless of the device function is capable of supporting
 more than one vector. The bus driver initializes only entry 0 of
 this capability if pci_enable_msi(...) is called successfully by
@@ -232,7 +231,7 @@
 CONFIG_X86_LOCAL_APIC. Once CONFIG_X86_LOCAL_APIC=y, setting
 CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
 the option for MSI-capable device drivers to selectively enable
-MSI (using pci_enable_msi as desribed below).
+MSI (using pci_enable_msi as described below).
 
 Note that CONFIG_X86_IO_APIC setting is irrelevant because MSI
 vector is allocated new during runtime and MSI support does not

--=-vgxj9wz8oh7D8Lyg0qhc--

