Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbTDENqe (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbTDENqe (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:46:34 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:12257 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262199AbTDENqd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 08:46:33 -0500
Date: Sat, 5 Apr 2003 15:57:51 +0200 (MEST)
Message-Id: <200304051357.h35DvpaT015065@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.21-pre7] fix dmi_scan breakage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmi_scan in -pre7 causes linkage errors when CONFIG_PCI=n,
since neither broken_440gx_bios nor pci_probe exist then.
This patch works around that.

/Mikael

--- linux-2.4.21-pre7/arch/i386/kernel/dmi_scan.c.~1~	2003-04-05 12:35:30.000000000 +0200
+++ linux-2.4.21-pre7/arch/i386/kernel/dmi_scan.c	2003-04-05 14:22:32.000000000 +0200
@@ -427,8 +427,10 @@
 #ifdef CONFIG_X86_IO_APIC
 	skip_ioapic_setup = 0;
 #endif
+#ifdef CONFIG_PCI
 	broken_440gx_bios = 1;
 	pci_probe |= PCI_BIOS_IRQ_SCAN;
+#endif
 	
 	return 0;
 }
