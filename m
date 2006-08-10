Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWHJUYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWHJUYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWHJUPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:16 -0400
Received: from ns1.suse.de ([195.135.220.2]:33936 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932589AbWHJTgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:05 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [48/145] x86_64: Remove old "focus disabled" chipset errata workaround
Message-Id: <20060810193602.C6D9D13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:02 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

The new systems already use focus disabled and the comment was 
completely outdated.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/apic.c |   28 ++--------------------------
 1 files changed, 2 insertions(+), 26 deletions(-)

Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -399,32 +399,8 @@ void __cpuinit setup_local_APIC (void)
 	 */
 	value |= APIC_SPIV_APIC_ENABLED;
 
-	/*
-	 * Some unknown Intel IO/APIC (or APIC) errata are biting us with
-	 * certain networking cards. If high frequency interrupts are
-	 * happening on a particular IOAPIC pin, plus the IOAPIC routing
-	 * entry is masked/unmasked at a high rate as well then sooner or
-	 * later IOAPIC line gets 'stuck', no more interrupts are received
-	 * from the device. If focus CPU is disabled then the hang goes
-	 * away, oh well :-(
-	 *
-	 * [ This bug can be reproduced easily with a level-triggered
-	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
-	 *   BX chipset. ]
-	 */
-	/*
-	 * Actually disabling the focus CPU check just makes the hang less
-	 * frequent as it makes the interrupt distributon model be more
-	 * like LRU than MRU (the short-term load is more even across CPUs).
-	 * See also the comment in end_level_ioapic_irq().  --macro
-	 */
-#if 1
-	/* Enable focus processor (bit==0) */
-	value &= ~APIC_SPIV_FOCUS_DISABLED;
-#else
-	/* Disable focus processor (bit==1) */
-	value |= APIC_SPIV_FOCUS_DISABLED;
-#endif
+	/* We always use processor focus */
+
 	/*
 	 * Set spurious IRQ vector
 	 */
