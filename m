Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279470AbRJZXJa>; Fri, 26 Oct 2001 19:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279476AbRJZXJV>; Fri, 26 Oct 2001 19:09:21 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:2311 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S279470AbRJZXJG>; Fri, 26 Oct 2001 19:09:06 -0400
Date: Fri, 26 Oct 2001 19:09:40 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
cc: Sebastian Droege <sebastian.droege@gmx.de>
Subject: [PATCH] pcibios_set_irq_routing undefined in 2.4.13-ac[12]
Message-ID: <Pine.LNX.4.33.0110261905260.22934-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here's the trivial fix for undefined symbols pcibios_set_irq_routing and
pcibios_get_irq_routing_table if PCI access is direct only on i386
architecture.

The patch is against 2.4.13-ac2

----------------------------------
--- linux.orig/arch/i386/kernel/i386_ksyms.c
+++ linux/arch/i386/kernel/i386_ksyms.c
@@ -112,6 +112,9 @@ EXPORT_SYMBOL(pci_free_consistent);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(pcibios_penalize_isa_irq);
 EXPORT_SYMBOL(pci_mem_start);
+#endif
+
+#ifdef CONFIG_PCI_BIOS
 EXPORT_SYMBOL(pcibios_set_irq_routing);
 EXPORT_SYMBOL(pcibios_get_irq_routing_table);
 #endif
----------------------------------

Regards,
Pavel Roskin

