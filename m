Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUJRS5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUJRS5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJRS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:57:04 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:62423 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S267335AbUJRSzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:55:44 -0400
Subject: [PATCH] Replace custom Dprintk macro with pr_debug - nmi.c
From: Daniele Pizzoni <auouo@tin.it>
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098129428.3024.61.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 21:57:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substituted custom Dprintk macro with pr_debug

Signed-off-by: Daniele Pizzoni


Index: linux-2.6.9-rc4/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/nmi.c	2004-10-18 19:41:13.798118432 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/nmi.c	2004-10-18 21:50:57.884757392 +0200
@@ -13,6 +13,8 @@
  *  Mikael Pettersson	: PM converted to driver model. Disable/enable API.
  */
 
+//#define DEBUG // pr_debug
+#include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
@@ -332,7 +334,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	pr_debug("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
@@ -354,7 +356,7 @@ static void setup_p6_watchdog(void)
 		| P6_NMI_EVENT;
 
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	pr_debug("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
@@ -395,7 +397,7 @@ static int setup_p4_watchdog(void)
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
+	pr_debug("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);


