Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263388AbTC2HAf>; Sat, 29 Mar 2003 02:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263389AbTC2HAf>; Sat, 29 Mar 2003 02:00:35 -0500
Received: from srv1.mail.cv.net ([167.206.112.40]:47806 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id <S263388AbTC2HAe>;
	Sat, 29 Mar 2003 02:00:34 -0500
Date: Sat, 29 Mar 2003 02:11:49 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: [TRIVIAL PATCH] Compile error in 2.4.21-pre5-ac3 without PCI
X-X-Sender: proski@localhost.localdomain
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.51.0303290010060.32041@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm getting this error when compiling Linux 2.4.21-pre5-ac3 for a 486
system without PCI:

arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x3454): undefined reference to
`broken_440gx_bios'
arch/i386/kernel/kernel.o(.text.init+0x345e): undefined reference to
`pci_probe'

Following patch fixes both issues.  pci_probe is available only if PCI
support is compiled in, broken_440gx_bios is available if PCI is used and
the system is not a SGI workstation.

==============================
--- linux.orig/arch/i386/kernel/dmi_scan.c
+++ linux/arch/i386/kernel/dmi_scan.c
@@ -427,8 +427,12 @@ static __init int broken_pirq(struct dmi
 #ifdef CONFIG_X86_IO_APIC
 	skip_ioapic_setup = 0;
 #endif
+#ifdef CONFIG_PCI
+#ifndef CONFIG_VISWS
 	broken_440gx_bios = 1;
+#endif
 	pci_probe |= PCI_BIOS_IRQ_SCAN;
+#endif

 	return 0;
 }
==============================

-- 
Regards,
Pavel Roskin
