Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUIOSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUIOSWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIOSWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:22:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267278AbUIOSB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:01:27 -0400
Date: Wed, 15 Sep 2004 19:01:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] build acpiphp modular and on i386/x86_64 [6/5]
Message-ID: <20040915180123.GG642@parcelfarce.linux.theplanet.co.uk>
References: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After the first five patches I sent, in order to build acpiphp on
i386/x86_64 or as a module on ia64, we need these exports and defines
currently.  I have a much better scheme in mind but it's not ready yet.
I promise I'll replace this with something much more portable.

diff -urpNX build-tools/dontdiff hotplug-2.6/arch/ia64/pci/pci.c modular-2.6/arch/ia64/pci/pci.c
--- hotplug-2.6/arch/ia64/pci/pci.c	2004-09-13 09:30:28.000000000 -0600
+++ modular-2.6/arch/ia64/pci/pci.c	2004-09-15 11:54:17.886305856 -0600
@@ -354,6 +354,7 @@ pcibios_fixup_device_resources (struct p
 		pci_claim_resource(dev, i);
 	}
 }
+EXPORT_SYMBOL(pcibios_fixup_device_resources);
 
 /*
  *  Called after each bus is probed, but before its children are examined.
diff -urpNX build-tools/dontdiff hotplug-2.6/include/asm-i386/pci.h modular-2.6/include/asm-i386/pci.h
--- hotplug-2.6/include/asm-i386/pci.h	2004-03-16 08:40:36.000000000 -0700
+++ modular-2.6/include/asm-i386/pci.h	2004-09-15 10:50:02.126390608 -0600
@@ -99,6 +99,9 @@ static inline void pcibios_add_platform_
 {
 }
 
+/* XXX: temporary hack for acpiphp */
+#define pcibios_fixup_device_resources()	do { } while (0)
+
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
diff -urpNX build-tools/dontdiff hotplug-2.6/include/asm-ia64/pci.h modular-2.6/include/asm-ia64/pci.h
--- hotplug-2.6/include/asm-ia64/pci.h	2004-09-02 13:56:21.000000000 -0600
+++ modular-2.6/include/asm-ia64/pci.h	2004-09-15 10:52:39.422526206 -0600
@@ -125,6 +125,9 @@ extern unsigned long pcibios_bus_address
 #define pci_bus_address(busdev, addr, flags) \
 		pcibios_bus_address(PCI_CONTROLLER(busdev), (addr), (flags))
 
+/* XXX: temporary hack for acpiphp */
+extern void pcibios_fixup_device_resources(struct pci_dev *, struct pci_bus *);
+
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff -urpNX build-tools/dontdiff hotplug-2.6/include/asm-x86_64/pci.h modular-2.6/include/asm-x86_64/pci.h
--- hotplug-2.6/include/asm-x86_64/pci.h	2004-09-13 09:31:17.000000000 -0600
+++ modular-2.6/include/asm-x86_64/pci.h	2004-09-15 10:50:16.191929342 -0600
@@ -132,6 +132,9 @@ static inline void pcibios_add_platform_
 {
 }
 
+/* XXX: temporary hack for acpiphp */
+#define pcibios_fixup_device_resources()	do { } while (0)
+
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
