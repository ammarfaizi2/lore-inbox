Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWHJUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWHJUYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHJUPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:32656 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932571AbWHJTgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:03 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [47/145] x86_64: Remove apic mismatch counter
Message-Id: <20060810193601.B97CB13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:01 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Nobody has been setting the mismatch counter and the ifdef was never 
set so remove it.
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/irq.c |    6 ------
 1 files changed, 6 deletions(-)

Index: linux/arch/x86_64/kernel/irq.c
===================================================================
--- linux.orig/arch/x86_64/kernel/irq.c
+++ linux/arch/x86_64/kernel/irq.c
@@ -20,9 +20,6 @@
 #include <asm/idle.h>
 
 atomic_t irq_err_count;
-#ifdef APIC_MISMATCH_DEBUG
-atomic_t irq_mis_count;
-#endif
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 /*
@@ -95,9 +92,6 @@ skip:
 			seq_printf(p, "%10u ", cpu_pda(j)->apic_timer_irqs);
 		seq_putc(p, '\n');
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#ifdef APIC_MISMATCH_DEBUG
-		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
-#endif
 	}
 	return 0;
 }
