Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVGJVvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVGJVvj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVGJVt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:49:26 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:5059
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262121AbVGJVrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:47:24 -0400
Message-ID: <20050710235037.3.patchmail@tglx.tec.linutronix.de>
References: <1121031634.26713.243.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: ralf@linux-mips.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS:  [PATCH resend] C99 initializers for hw_interrupt_type structures
Date: Sun, 10 Jul 2005 23:47:24 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 au1000/common/irq.c           |   60 +++++++++++++++------------------
 ddb5xxx/ddb5074/nile4_pic.c   |   15 +++-----
 ddb5xxx/ddb5476/vrc5476_irq.c |   15 +++-----
 ddb5xxx/ddb5477/irq_5477.c    |   15 +++-----
 ite-boards/generic/irq.c      |   29 +++++++---------
 jazz/irq.c                    |   15 +++-----
 jmr3927/rbhma3100/irq.c       |   14 +++----
 kernel/i8259.c                |   15 +++-----
 kernel/irq-msc01.c            |   30 +++++++---------
 kernel/irq-mv6434x.c          |   15 +++-----
 kernel/irq-rm7000.c           |   14 +++----
 kernel/irq-rm9000.c           |   28 +++++++--------
 kernel/irq_cpu.c              |   15 +++-----
 lasat/interrupt.c             |   15 +++-----
 mips-boards/atlas/atlas_int.c |   15 +++-----
 momentum/ocelot_c/cpci-irq.c  |   15 +++-----
 momentum/ocelot_c/uart-irq.c  |   15 +++-----
 sgi-ip32/ip32-irq.c           |   75 +++++++++++++++++++-----------------------
 sibyte/sb1250/irq.c           |   18 ++++------
 sni/irq.c                     |   15 +++-----
 vr4181/common/irq.c           |   30 +++++++---------
 21 files changed, 225 insertions(+), 253 deletions(-)
---
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/au1000/common/irq.c linux-2.6.13-rc2-armirq/arch/mips/au1000/common/irq.c
--- linux-2.6.13-rc2/arch/mips/au1000/common/irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/au1000/common/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -253,47 +253,43 @@
 
 
 static struct hw_interrupt_type rise_edge_irq_type = {
-	"Au1000 Rise Edge",
-	startup_irq,
-	shutdown_irq,
-	local_enable_irq,
-	local_disable_irq,
-	mask_and_ack_rise_edge_irq,
-	end_irq,
-	NULL
+	.typename = "Au1000 Rise Edge",
+	.startup = startup_irq,
+	.shutdown = shutdown_irq,
+	.enable = local_enable_irq,
+	.disable = local_disable_irq,
+	.ack = mask_and_ack_rise_edge_irq,
+	.end = end_irq,
 };
 
 static struct hw_interrupt_type fall_edge_irq_type = {
-	"Au1000 Fall Edge",
-	startup_irq,
-	shutdown_irq,
-	local_enable_irq,
-	local_disable_irq,
-	mask_and_ack_fall_edge_irq,
-	end_irq,
-	NULL
+	.typename = "Au1000 Fall Edge",
+	.startup = startup_irq,
+	.shutdown = shutdown_irq,
+	.enable = local_enable_irq,
+	.disable = local_disable_irq,
+	.ack = mask_and_ack_fall_edge_irq,
+	.end = end_irq,
 };
 
 static struct hw_interrupt_type either_edge_irq_type = {
-	"Au1000 Rise or Fall Edge",
-	startup_irq,
-	shutdown_irq,
-	local_enable_irq,
-	local_disable_irq,
-	mask_and_ack_either_edge_irq,
-	end_irq,
-	NULL
+	.typename = "Au1000 Rise or Fall Edge",
+	.startup = startup_irq,
+	.shutdown = shutdown_irq,
+	.enable = local_enable_irq,
+	.disable = local_disable_irq,
+	.ack = mask_and_ack_either_edge_irq,
+	.end = end_irq,
 };
 
 static struct hw_interrupt_type level_irq_type = {
-	"Au1000 Level",
-	startup_irq,
-	shutdown_irq,
-	local_enable_irq,
-	local_disable_irq,
-	mask_and_ack_level_irq,
-	end_irq,
-	NULL
+	.typename = "Au1000 Level",
+	.startup = startup_irq,
+	.shutdown = shutdown_irq,
+	.enable = local_enable_irq,
+	.disable = local_disable_irq,
+	.ack = mask_and_ack_level_irq,
+	.end = end_irq,
 };
 
 #ifdef CONFIG_PM
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/ddb5xxx/ddb5074/nile4_pic.c linux-2.6.13-rc2-armirq/arch/mips/ddb5xxx/ddb5074/nile4_pic.c
--- linux-2.6.13-rc2/arch/mips/ddb5xxx/ddb5074/nile4_pic.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/ddb5xxx/ddb5074/nile4_pic.c	2005-07-09 13:10:41.000000000 +0200
@@ -209,14 +209,13 @@
 #define nile4_irq_shutdown nile4_disable_irq
 
 static hw_irq_controller nile4_irq_controller = {
-    "nile4",
-    nile4_irq_startup,
-    nile4_irq_shutdown,
-    nile4_enable_irq,
-    nile4_disable_irq,
-    nile4_ack_irq,
-    nile4_irq_end,
-    NULL
+	.typename = "nile4",
+	.startup = nile4_irq_startup,
+	.shutdown = nile4_irq_shutdown,
+	.enable = nile4_enable_irq,
+	.disable = nile4_disable_irq,
+	.ack = nile4_ack_irq,
+	.end = nile4_irq_end,
 };
 
 void nile4_irq_setup(u32 base) {
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c linux-2.6.13-rc2-armirq/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c
--- linux-2.6.13-rc2/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -53,14 +53,13 @@
 }
 
 static hw_irq_controller vrc5476_irq_controller = {
-	"vrc5476",
-	vrc5476_irq_startup,
-	vrc5476_irq_shutdown,
-	vrc5476_irq_enable,
-	vrc5476_irq_disable,
-	vrc5476_irq_ack,
-	vrc5476_irq_end,
-	NULL				/* no affinity stuff for UP */
+	.typename = "vrc5476",
+	.startup = vrc5476_irq_startup,
+	.shutdown = vrc5476_irq_shutdown,
+	.enable = vrc5476_irq_enable,
+	.disable = vrc5476_irq_disable,
+	.ack = vrc5476_irq_ack,
+	.end = vrc5476_irq_end
 };
 
 void __init
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/ddb5xxx/ddb5477/irq_5477.c linux-2.6.13-rc2-armirq/arch/mips/ddb5xxx/ddb5477/irq_5477.c
--- linux-2.6.13-rc2/arch/mips/ddb5xxx/ddb5477/irq_5477.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/ddb5xxx/ddb5477/irq_5477.c	2005-07-09 13:10:41.000000000 +0200
@@ -90,14 +90,13 @@
 }
 
 hw_irq_controller vrc5477_irq_controller = {
-	"vrc5477_irq",
-	vrc5477_irq_startup,
-	vrc5477_irq_shutdown,
-	vrc5477_irq_enable,
-	vrc5477_irq_disable,
-	vrc5477_irq_ack,
-	vrc5477_irq_end,
-	NULL			/* no affinity stuff for UP */
+	.typename = "vrc5477_irq",
+	.startup = vrc5477_irq_startup,
+	.shutdown = vrc5477_irq_shutdown,
+	.enable = vrc5477_irq_enable,
+	.disable = vrc5477_irq_disable,
+	.ack = vrc5477_irq_ack,
+	.end = vrc5477_irq_end
 };
 
 void __init vrc5477_irq_init(u32 irq_base)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/ite-boards/generic/irq.c linux-2.6.13-rc2-armirq/arch/mips/ite-boards/generic/irq.c
--- linux-2.6.13-rc2/arch/mips/ite-boards/generic/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/ite-boards/generic/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -138,14 +138,13 @@
 }
 
 static struct hw_interrupt_type it8172_irq_type = {
-	"ITE8172",
-	startup_ite_irq,
-	shutdown_ite_irq,
-	enable_it8172_irq,
-	disable_it8172_irq,
-	mask_and_ack_ite_irq,
-	end_ite_irq,
-	NULL
+	.typename = "ITE8172",
+	.startup = startup_ite_irq,
+	.shutdown = shutdown_ite_irq,
+	.enable = enable_it8172_irq,
+	.disable = disable_it8172_irq,
+	.ack = mask_and_ack_ite_irq,
+	.end = end_ite_irq,
 };
 
 
@@ -159,13 +158,13 @@
 #define end_none	enable_none
 
 static struct hw_interrupt_type cp0_irq_type = {
-	"CP0 Count",
-	startup_none,
-	shutdown_none,
-	enable_none,
-	disable_none,
-	ack_none,
-	end_none
+	.typename = "CP0 Count",
+	.startup = startup_none,
+	.shutdown = shutdown_none,
+	.enable = enable_none,
+	.disable = disable_none,
+	.ack = ack_none,
+	.end = end_none
 };
 
 void enable_cpu_timer(void)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/jazz/irq.c linux-2.6.13-rc2-armirq/arch/mips/jazz/irq.c
--- linux-2.6.13-rc2/arch/mips/jazz/irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/jazz/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -58,14 +58,13 @@
 }
 
 static struct hw_interrupt_type r4030_irq_type = {
-	"R4030",
-	startup_r4030_irq,
-	shutdown_r4030_irq,
-	enable_r4030_irq,
-	disable_r4030_irq,
-	mask_and_ack_r4030_irq,
-	end_r4030_irq,
-	NULL
+	.typename = "R4030",
+	.startup = startup_r4030_irq,
+	.shutdown = shutdown_r4030_irq,
+	.enable = enable_r4030_irq,
+	.disable = disable_r4030_irq,
+	.ack = mask_and_ack_r4030_irq,
+	.end = end_r4030_irq,
 };
 
 void __init init_r4030_ints(void)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/jmr3927/rbhma3100/irq.c linux-2.6.13-rc2-armirq/arch/mips/jmr3927/rbhma3100/irq.c
--- linux-2.6.13-rc2/arch/mips/jmr3927/rbhma3100/irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/jmr3927/rbhma3100/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -412,13 +412,13 @@
 }
 
 static hw_irq_controller jmr3927_irq_controller = {
-	"jmr3927_irq",
-	jmr3927_irq_startup,
-	jmr3927_irq_shutdown,
-	jmr3927_irq_enable,
-	jmr3927_irq_disable,
-	jmr3927_irq_ack,
-	jmr3927_irq_end,
+	.typename = "jmr3927_irq",
+	.startup = jmr3927_irq_startup,
+	.shutdown = jmr3927_irq_shutdown,
+	.enable = jmr3927_irq_enable,
+	.disable = jmr3927_irq_disable,
+	.ack = jmr3927_irq_ack,
+	.end = jmr3927_irq_end,
 };
 
 void jmr3927_irq_init(u32 irq_base)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/kernel/i8259.c linux-2.6.13-rc2-armirq/arch/mips/kernel/i8259.c
--- linux-2.6.13-rc2/arch/mips/kernel/i8259.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/kernel/i8259.c	2005-07-09 13:10:41.000000000 +0200
@@ -52,14 +52,13 @@
 }
 
 static struct hw_interrupt_type i8259A_irq_type = {
-	"XT-PIC",
-	startup_8259A_irq,
-	shutdown_8259A_irq,
-	enable_8259A_irq,
-	disable_8259A_irq,
-	mask_and_ack_8259A,
-	end_8259A_irq,
-	NULL
+	.typename = "XT-PIC",
+	.startup = startup_8259A_irq,
+	.shutdown = shutdown_8259A_irq,
+	.enable = enable_8259A_irq,
+	.disable = disable_8259A_irq,
+	.ack = mask_and_ack_8259A,
+	.end = end_8259A_irq,
 };
 
 /*
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/kernel/irq-msc01.c linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-msc01.c
--- linux-2.6.13-rc2/arch/mips/kernel/irq-msc01.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-msc01.c	2005-07-09 13:10:41.000000000 +0200
@@ -129,25 +129,23 @@
 #define shutdown_msc_irq	disable_msc_irq
 
 struct hw_interrupt_type msc_levelirq_type = {
-	"SOC-it-Level",
-	startup_msc_irq,
-	shutdown_msc_irq,
-	enable_msc_irq,
-	disable_msc_irq,
-	level_mask_and_ack_msc_irq,
-	end_msc_irq,
-	NULL
+	.typename = "SOC-it-Level",
+	.startup = startup_msc_irq,
+	.shutdown = shutdown_msc_irq,
+	.enable = enable_msc_irq,
+	.disable = disable_msc_irq,
+	.ack = level_mask_and_ack_msc_irq,
+	.end = end_msc_irq,
 };
 
 struct hw_interrupt_type msc_edgeirq_type = {
-	"SOC-it-Edge",
-	startup_msc_irq,
-	shutdown_msc_irq,
-	enable_msc_irq,
-	disable_msc_irq,
-	edge_mask_and_ack_msc_irq,
-	end_msc_irq,
-	NULL
+	.typename = "SOC-it-Edge",
+	.startup =startup_msc_irq,
+	.shutdown = shutdown_msc_irq,
+	.enable = enable_msc_irq,
+	.disable = disable_msc_irq,
+	.ack = edge_mask_and_ack_msc_irq,
+	.end = end_msc_irq,
 };
 
 
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/kernel/irq-mv6434x.c linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-mv6434x.c
--- linux-2.6.13-rc2/arch/mips/kernel/irq-mv6434x.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-mv6434x.c	2005-07-09 13:10:41.000000000 +0200
@@ -135,14 +135,13 @@
 #define shutdown_mv64340_irq	disable_mv64340_irq
 
 struct hw_interrupt_type mv64340_irq_type = {
-	"MV-64340",
-	startup_mv64340_irq,
-	shutdown_mv64340_irq,
-	enable_mv64340_irq,
-	disable_mv64340_irq,
-	mask_and_ack_mv64340_irq,
-	end_mv64340_irq,
-	NULL
+	.typename = "MV-64340",
+	.startup = startup_mv64340_irq,
+	.shutdown = shutdown_mv64340_irq,
+	.enable = enable_mv64340_irq,
+	.disable = disable_mv64340_irq,
+	.ack = mask_and_ack_mv64340_irq,
+	.end = end_mv64340_irq,
 };
 
 void __init mv64340_irq_init(unsigned int base)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/kernel/irq-rm7000.c linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-rm7000.c
--- linux-2.6.13-rc2/arch/mips/kernel/irq-rm7000.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-rm7000.c	2005-07-09 13:10:41.000000000 +0200
@@ -72,13 +72,13 @@
 }
 
 static hw_irq_controller rm7k_irq_controller = {
-	"RM7000",
-	rm7k_cpu_irq_startup,
-	rm7k_cpu_irq_shutdown,
-	rm7k_cpu_irq_enable,
-	rm7k_cpu_irq_disable,
-	rm7k_cpu_irq_ack,
-	rm7k_cpu_irq_end,
+	.typename = "RM7000",
+	.startup = rm7k_cpu_irq_startup,
+	.shutdown = rm7k_cpu_irq_shutdown,
+	.enable = rm7k_cpu_irq_enable,
+	.disable = rm7k_cpu_irq_disable,
+	.ack = rm7k_cpu_irq_ack,
+	.end = rm7k_cpu_irq_end,
 };
 
 void __init rm7k_cpu_irq_init(int base)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/kernel/irq-rm9000.c linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-rm9000.c
--- linux-2.6.13-rc2/arch/mips/kernel/irq-rm9000.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/kernel/irq-rm9000.c	2005-07-09 13:10:41.000000000 +0200
@@ -106,23 +106,23 @@
 }
 
 static hw_irq_controller rm9k_irq_controller = {
-	"RM9000",
-	rm9k_cpu_irq_startup,
-	rm9k_cpu_irq_shutdown,
-	rm9k_cpu_irq_enable,
-	rm9k_cpu_irq_disable,
-	rm9k_cpu_irq_ack,
-	rm9k_cpu_irq_end,
+	.typename = "RM9000",
+	.startup = rm9k_cpu_irq_startup,
+	.shutdown = rm9k_cpu_irq_shutdown,
+	.enable = rm9k_cpu_irq_enable,
+	.disable = rm9k_cpu_irq_disable,
+	.ack = rm9k_cpu_irq_ack,
+	.end = rm9k_cpu_irq_end,
 };
 
 static hw_irq_controller rm9k_perfcounter_irq = {
-	"RM9000",
-	rm9k_perfcounter_irq_startup,
-	rm9k_perfcounter_irq_shutdown,
-	rm9k_cpu_irq_enable,
-	rm9k_cpu_irq_disable,
-	rm9k_cpu_irq_ack,
-	rm9k_cpu_irq_end,
+	.typename = "RM9000",
+	.startup = rm9k_perfcounter_irq_startup,
+	.shutdown = rm9k_perfcounter_irq_shutdown,
+	.enable = rm9k_cpu_irq_enable,
+	.disable = rm9k_cpu_irq_disable,
+	.ack = rm9k_cpu_irq_ack,
+	.end = rm9k_cpu_irq_end,
 };
 
 unsigned int rm9000_perfcount_irq;
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/kernel/irq_cpu.c linux-2.6.13-rc2-armirq/arch/mips/kernel/irq_cpu.c
--- linux-2.6.13-rc2/arch/mips/kernel/irq_cpu.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/kernel/irq_cpu.c	2005-07-09 13:10:41.000000000 +0200
@@ -92,14 +92,13 @@
 }
 
 static hw_irq_controller mips_cpu_irq_controller = {
-	"MIPS",
-	mips_cpu_irq_startup,
-	mips_cpu_irq_shutdown,
-	mips_cpu_irq_enable,
-	mips_cpu_irq_disable,
-	mips_cpu_irq_ack,
-	mips_cpu_irq_end,
-	NULL			/* no affinity stuff for UP */
+	.typename = "MIPS",
+	.startup = mips_cpu_irq_startup,
+	.shutdown = mips_cpu_irq_shutdown,
+	.enable = mips_cpu_irq_enable,
+	.disable = mips_cpu_irq_disable,
+	.ack = mips_cpu_irq_ack,
+	.end = mips_cpu_irq_end,
 };
 
 
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/lasat/interrupt.c linux-2.6.13-rc2-armirq/arch/mips/lasat/interrupt.c
--- linux-2.6.13-rc2/arch/mips/lasat/interrupt.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/lasat/interrupt.c	2005-07-09 13:10:41.000000000 +0200
@@ -71,14 +71,13 @@
 }
 
 static struct hw_interrupt_type lasat_irq_type = {
-	"Lasat",
-	startup_lasat_irq,
-	shutdown_lasat_irq,
-	enable_lasat_irq,
-	disable_lasat_irq,
-	mask_and_ack_lasat_irq,
-	end_lasat_irq,
-	NULL
+	.typename = "Lasat",
+	.startup = startup_lasat_irq,
+	.shutdown = shutdown_lasat_irq,
+	.enable = enable_lasat_irq,
+	.disable = disable_lasat_irq,
+	.ack = mask_and_ack_lasat_irq,
+	.end = end_lasat_irq,
 };
 
 static inline int ls1bit32(unsigned int x)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/mips-boards/atlas/atlas_int.c linux-2.6.13-rc2-armirq/arch/mips/mips-boards/atlas/atlas_int.c
--- linux-2.6.13-rc2/arch/mips/mips-boards/atlas/atlas_int.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/mips-boards/atlas/atlas_int.c	2005-07-09 13:10:41.000000000 +0200
@@ -76,14 +76,13 @@
 }
 
 static struct hw_interrupt_type atlas_irq_type = {
-	"Atlas",
-	startup_atlas_irq,
-	shutdown_atlas_irq,
-	enable_atlas_irq,
-	disable_atlas_irq,
-	mask_and_ack_atlas_irq,
-	end_atlas_irq,
-	NULL
+	.typename = "Atlas",
+	.startup = startup_atlas_irq,
+	.shutdown = shutdown_atlas_irq,
+	.enable = enable_atlas_irq,
+	.disable = disable_atlas_irq,
+	.ack = mask_and_ack_atlas_irq,
+	.end = end_atlas_irq,
 };
 
 static inline int ls1bit32(unsigned int x)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/momentum/ocelot_c/cpci-irq.c linux-2.6.13-rc2-armirq/arch/mips/momentum/ocelot_c/cpci-irq.c
--- linux-2.6.13-rc2/arch/mips/momentum/ocelot_c/cpci-irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/momentum/ocelot_c/cpci-irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -129,14 +129,13 @@
 #define shutdown_cpci_irq	disable_cpci_irq
 
 struct hw_interrupt_type cpci_irq_type = {
-	"CPCI/FPGA",
-	startup_cpci_irq,
-	shutdown_cpci_irq,
-	enable_cpci_irq,
-	disable_cpci_irq,
-	mask_and_ack_cpci_irq,
-	end_cpci_irq,
-	NULL
+	.typename = "CPCI/FPGA",
+	.startup = startup_cpci_irq,
+	.shutdown = shutdown_cpci_irq,
+	.enable = enable_cpci_irq,
+	.disable = disable_cpci_irq,
+	.ack = mask_and_ack_cpci_irq,
+	.end = end_cpci_irq,
 };
 
 void cpci_irq_init(void)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/momentum/ocelot_c/uart-irq.c linux-2.6.13-rc2-armirq/arch/mips/momentum/ocelot_c/uart-irq.c
--- linux-2.6.13-rc2/arch/mips/momentum/ocelot_c/uart-irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/momentum/ocelot_c/uart-irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -122,14 +122,13 @@
 #define shutdown_uart_irq	disable_uart_irq
 
 struct hw_interrupt_type uart_irq_type = {
-	"UART/FPGA",
-	startup_uart_irq,
-	shutdown_uart_irq,
-	enable_uart_irq,
-	disable_uart_irq,
-	mask_and_ack_uart_irq,
-	end_uart_irq,
-	NULL
+	.typename = "UART/FPGA",
+	.startup = startup_uart_irq,
+	.shutdown = shutdown_uart_irq,
+	.enable = enable_uart_irq,
+	.disable = disable_uart_irq,
+	.ack = mask_and_ack_uart_irq,
+	.end = end_uart_irq,
 };
 
 void uart_irq_init(void)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/sgi-ip32/ip32-irq.c linux-2.6.13-rc2-armirq/arch/mips/sgi-ip32/ip32-irq.c
--- linux-2.6.13-rc2/arch/mips/sgi-ip32/ip32-irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/sgi-ip32/ip32-irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -163,14 +163,13 @@
 #define mask_and_ack_cpu_irq disable_cpu_irq
 
 static struct hw_interrupt_type ip32_cpu_interrupt = {
-	"IP32 CPU",
-	startup_cpu_irq,
-	shutdown_cpu_irq,
-	enable_cpu_irq,
-	disable_cpu_irq,
-	mask_and_ack_cpu_irq,
-	end_cpu_irq,
-	NULL
+	.typename = "IP32 CPU",
+	.startup = startup_cpu_irq,
+	.shutdown = shutdown_cpu_irq,
+	.enable = enable_cpu_irq,
+	.disable = disable_cpu_irq,
+	.ack = mask_and_ack_cpu_irq,
+	.end = end_cpu_irq,
 };
 
 /*
@@ -234,14 +233,13 @@
 #define shutdown_crime_irq disable_crime_irq
 
 static struct hw_interrupt_type ip32_crime_interrupt = {
-	"IP32 CRIME",
-	startup_crime_irq,
-	shutdown_crime_irq,
-	enable_crime_irq,
-	disable_crime_irq,
-	mask_and_ack_crime_irq,
-	end_crime_irq,
-	NULL
+	.typename = "IP32 CRIME",
+	.startup = startup_crime_irq,
+	.shutdown = shutdown_crime_irq,
+	.enable = enable_crime_irq,
+	.disable = disable_crime_irq,
+	.ack = mask_and_ack_crime_irq,
+	.end = end_crime_irq,
 };
 
 /*
@@ -294,14 +292,13 @@
 #define mask_and_ack_macepci_irq disable_macepci_irq
 
 static struct hw_interrupt_type ip32_macepci_interrupt = {
-	"IP32 MACE PCI",
-	startup_macepci_irq,
-	shutdown_macepci_irq,
-	enable_macepci_irq,
-	disable_macepci_irq,
-	mask_and_ack_macepci_irq,
-	end_macepci_irq,
-	NULL
+	.typename = "IP32 MACE PCI",
+	.startup = startup_macepci_irq,
+	.shutdown = shutdown_macepci_irq,
+	.enable = enable_macepci_irq,
+	.disable = disable_macepci_irq,
+	.ack = mask_and_ack_macepci_irq,
+	.end = end_macepci_irq,
 };
 
 /* This is used for MACE ISA interrupts.  That means bits 4-6 in the
@@ -425,14 +422,13 @@
 #define shutdown_maceisa_irq disable_maceisa_irq
 
 static struct hw_interrupt_type ip32_maceisa_interrupt = {
-	"IP32 MACE ISA",
-	startup_maceisa_irq,
-	shutdown_maceisa_irq,
-	enable_maceisa_irq,
-	disable_maceisa_irq,
-	mask_and_ack_maceisa_irq,
-	end_maceisa_irq,
-	NULL
+	.typename = "IP32 MACE ISA",
+	.startup = startup_maceisa_irq,
+	.shutdown = shutdown_maceisa_irq,
+	.enable = enable_maceisa_irq,
+	.disable = disable_maceisa_irq,
+	.ack = mask_and_ack_maceisa_irq,
+	.end = end_maceisa_irq,
 };
 
 /* This is used for regular non-ISA, non-PCI MACE interrupts.  That means
@@ -476,14 +472,13 @@
 #define mask_and_ack_mace_irq disable_mace_irq
 
 static struct hw_interrupt_type ip32_mace_interrupt = {
-	"IP32 MACE",
-	startup_mace_irq,
-	shutdown_mace_irq,
-	enable_mace_irq,
-	disable_mace_irq,
-	mask_and_ack_mace_irq,
-	end_mace_irq,
-	NULL
+	.typename = "IP32 MACE",
+	.startup = startup_mace_irq,
+	.shutdown = shutdown_mace_irq,
+	.enable = enable_mace_irq,
+	.disable = disable_mace_irq,
+	.ack = mask_and_ack_mace_irq,
+	.end = end_mace_irq,
 };
 
 static void ip32_unknown_interrupt(struct pt_regs *regs)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/sibyte/sb1250/irq.c linux-2.6.13-rc2-armirq/arch/mips/sibyte/sb1250/irq.c
--- linux-2.6.13-rc2/arch/mips/sibyte/sb1250/irq.c	2005-07-09 13:04:25.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/sibyte/sb1250/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -71,17 +71,15 @@
 #endif
 
 static struct hw_interrupt_type sb1250_irq_type = {
-	"SB1250-IMR",
-	startup_sb1250_irq,
-	shutdown_sb1250_irq,
-	enable_sb1250_irq,
-	disable_sb1250_irq,
-	ack_sb1250_irq,
-	end_sb1250_irq,
+	.typename = "SB1250-IMR",
+	.startup = startup_sb1250_irq,
+	.shutdown = shutdown_sb1250_irq,
+	.enable = enable_sb1250_irq,
+	.disable = disable_sb1250_irq,
+	.ack = ack_sb1250_irq,
+	.end = end_sb1250_irq,
 #ifdef CONFIG_SMP
-	sb1250_set_affinity
-#else
-	NULL
+	.set_affinity = sb1250_set_affinity
 #endif
 };
 
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/sni/irq.c linux-2.6.13-rc2-armirq/arch/mips/sni/irq.c
--- linux-2.6.13-rc2/arch/mips/sni/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/sni/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -58,14 +58,13 @@
 }
 
 static struct hw_interrupt_type pciasic_irq_type = {
-	"ASIC-PCI",
-	startup_pciasic_irq,
-	shutdown_pciasic_irq,
-	enable_pciasic_irq,
-	disable_pciasic_irq,
-	mask_and_ack_pciasic_irq,
-	end_pciasic_irq,
-	NULL
+	.typename = "ASIC-PCI",
+	.startup = startup_pciasic_irq,
+	.shutdown = shutdown_pciasic_irq,
+	.enable = enable_pciasic_irq,
+	.disable = disable_pciasic_irq,
+	.ack = mask_and_ack_pciasic_irq,
+	.end = end_pciasic_irq,
 };
 
 /*
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/mips/vr4181/common/irq.c linux-2.6.13-rc2-armirq/arch/mips/vr4181/common/irq.c
--- linux-2.6.13-rc2/arch/mips/vr4181/common/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/mips/vr4181/common/irq.c	2005-07-09 13:10:41.000000000 +0200
@@ -86,14 +86,13 @@
 }
 
 static hw_irq_controller sys_irq_controller = {
-	"vr4181_sys_irq",
-	sys_irq_startup,
-	sys_irq_shutdown,
-	sys_irq_enable,
-	sys_irq_disable,
-	sys_irq_ack,
-	sys_irq_end,
-	NULL			/* no affinity stuff for UP */
+	.typename = "vr4181_sys_irq",
+	.startup = sys_irq_startup,
+	.shutdown = sys_irq_shutdown,
+	.enable = sys_irq_enable,
+	.disable = sys_irq_disable,
+	.ack = sys_irq_ack,
+	.end = sys_irq_end,
 };
 
 /* ---------------------- gpio irq ------------------------ */
@@ -162,14 +161,13 @@
 }
 
 static hw_irq_controller gpio_irq_controller = {
-	"vr4181_gpio_irq",
-	gpio_irq_startup,
-	gpio_irq_shutdown,
-	gpio_irq_enable,
-	gpio_irq_disable,
-	gpio_irq_ack,
-	gpio_irq_end,
-	NULL			/* no affinity stuff for UP */
+	.typename = "vr4181_gpio_irq",
+	.startup = gpio_irq_startup,
+	.shutdown = gpio_irq_shutdown,
+	.enable = gpio_irq_enable,
+	.disable = gpio_irq_disable,
+	.ack = gpio_irq_ack,
+	.end = gpio_irq_end,
 };
 
 /* ---------------------  IRQ init stuff ---------------------- */
