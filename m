Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbTFRU4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTFRU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:56:14 -0400
Received: from palrel13.hp.com ([156.153.255.238]:45507 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265528AbTFRU4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:56:13 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.54572.443092.996206@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 14:10:04 -0700
To: torvalds@transmeta.com
Cc: willy@fc.hp.com, linux-kernel@vger.kernel.org
Subject: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial build fix: pci_domain_nr() cannot be declared unless
CONFIG_PCI is defined (otherwise, struct pci_bus hasn't been defined).

	--david

diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Jun 18 13:32:49 2003
+++ b/include/linux/pci.h	Wed Jun 18 13:32:49 2003
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
