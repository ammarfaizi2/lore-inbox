Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTFSX2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFSX2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:28:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:17567 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261939AbTFSXZp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10560659701205@kroah.com>
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <1056065970863@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1327.5.3, 2003/06/18 14:56:52-07:00, davidm@napali.hpl.hp.com

[PATCH] PCI: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket

Trivial build fix: pci_domain_nr() cannot be declared unless
CONFIG_PCI is defined (otherwise, struct pci_bus hasn't been defined).


 include/linux/pci.h |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun 19 16:32:17 2003
+++ b/include/linux/pci.h	Thu Jun 19 16:32:17 2003
@@ -743,6 +743,15 @@
 	return rc;
 }
 
+/*
+ * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
+ * a PCI domain is defined to be a set of PCI busses which share
+ * configuration space.
+ */
+#ifndef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
+#endif
+
 #endif /* !CONFIG_PCI */
 
 /* these helpers provide future and backwards compatibility
@@ -799,16 +808,6 @@
 #define PCIPCI_VIAETBF		8
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
-
-/*
- * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
- * a PCI domain is defined to be a set of PCI busses which share
- * configuration space.
- */
-
-#ifndef CONFIG_PCI_DOMAINS
-static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */

