Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWEQAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWEQAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWEQASa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:18:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11729 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932365AbWEQASQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:16 -0400
Date: Wed, 17 May 2006 02:18:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 38/50] genirq: ARM: Convert lh7a40x to generic irq handling
Message-ID: <20060517001810.GM12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Fixup the conversion to generic irq subsystem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c |    5 +++--
 arch/arm/mach-lh7a40x/time.c          |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-genirq.q/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
+++ linux-genirq.q/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <asm/hardware.h>
 #include <asm/setup.h>
@@ -162,7 +163,7 @@ static void lpd7a40x_cpld_handler (unsig
 {
 	unsigned int mask = CPLD_INTERRUPTS;
 
-	desc->chip->ack (irq);
+	desc->handler->ack (irq);
 
 	if ((mask & 0x1) == 0)	/* WLAN */
 		IRQ_DISPATCH (IRQ_LPD7A40X_ETH_INT);
@@ -170,7 +171,7 @@ static void lpd7a40x_cpld_handler (unsig
 	if ((mask & 0x2) == 0)	/* Touch */
 		IRQ_DISPATCH (IRQ_LPD7A400_TS);
 
-	desc->chip->unmask (irq); /* Level-triggered need this */
+	desc->handler->unmask (irq); /* Level-triggered need this */
 }
 
 
Index: linux-genirq.q/arch/arm/mach-lh7a40x/time.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-lh7a40x/time.c
+++ linux-genirq.q/arch/arm/mach-lh7a40x/time.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/time.h>
 
 #include <asm/hardware.h>
