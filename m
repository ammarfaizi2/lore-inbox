Return-Path: <linux-kernel-owner+w=401wt.eu-S1751599AbXALE2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbXALE2G (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbXALEXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:23:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbXALEW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:22:57 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=jGJ/TKVxSHXqgIo1Qp1riwo/cQYW1cZRExyduLFZEK6EGxZiw92+dk6qgJ8zO+EqyUl2W8R7wM8XvPABMTLIpB3FIRWeXch7hNBS0l0TPuL/1QLZ6edWjjY1u2kHodP4x083kxioSEXq47O4Hj5Xg1VNgEy++LbNhOqL4ZzzHS0=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:26:34 +0100
Message-Id: <20070112042634.28794.88254.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 4/19] ia64: add pci_get_legacy_ide_irq()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ia64: add pci_get_legacy_ide_irq()

Add pci_get_legacy_ide_irq() identical to the one used by i386/x86_64.
Fixes amd74xx driver build on ia64 (bugzilla bug #6644).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 include/asm-ia64/pci.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: a/include/asm-ia64/pci.h
===================================================================
--- a.orig/include/asm-ia64/pci.h
+++ a/include/asm-ia64/pci.h
@@ -167,4 +167,10 @@ pcibios_select_root(struct pci_dev *pdev
 
 #define pcibios_scan_all_fns(a, b)	0
 
+#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return channel ? 15 : 14;
+}
+
 #endif /* _ASM_IA64_PCI_H */
