Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUFTXzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUFTXzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 19:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUFTXzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 19:55:33 -0400
Received: from aun.it.uu.se ([130.238.12.36]:4775 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263032AbUFTXzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 19:55:32 -0400
Date: Mon, 21 Jun 2004 01:55:25 +0200 (MEST)
Message-Id: <200406202355.i5KNtPdp021261@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: len.brown@intel.com
Subject: [PATCH] 2.4.27-rc1 i386 and x86_64 ACPI mpparse timer bug
Cc: Hans-Frieder Vogt <hfvogt@arcor.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.27-rc1 reintroduced the double-speed timer ACPI bug.
Both x86-64 and i386 are affected.

The patch below fixes it on my box. It's a backport of a
patch Hans-Frieder Vogt made for 2.6.7-bk2, extended to
also handle i386.

/Mikael Pettersson

diff -ruN linux-2.4.27-rc1/arch/i386/kernel/mpparse.c linux-2.4.27-rc1.mpparse-fix/arch/i386/kernel/mpparse.c
--- linux-2.4.27-rc1/arch/i386/kernel/mpparse.c	2004-06-21 00:39:30.000000000 +0200
+++ linux-2.4.27-rc1.mpparse-fix/arch/i386/kernel/mpparse.c	2004-06-21 00:50:01.000000000 +0200
@@ -1211,7 +1211,7 @@
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
+				(mp_irqs[idx].mpc_dstapic == mp_ioapics[ioapic].mpc_apicid) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
diff -ruN linux-2.4.27-rc1/arch/x86_64/kernel/mpparse.c linux-2.4.27-rc1.mpparse-fix/arch/x86_64/kernel/mpparse.c
--- linux-2.4.27-rc1/arch/x86_64/kernel/mpparse.c	2004-06-21 00:39:30.000000000 +0200
+++ linux-2.4.27-rc1.mpparse-fix/arch/x86_64/kernel/mpparse.c	2004-06-21 00:50:01.000000000 +0200
@@ -866,7 +866,7 @@
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
+				(mp_irqs[idx].mpc_dstapic == intsrc.mpc_dstapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
