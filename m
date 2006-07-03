Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWGCARp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGCARp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGCARo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:17:44 -0400
Received: from www.osadl.org ([213.239.205.134]:61880 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750809AbWGCARn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:17:43 -0400
Subject: [PATCH] ARM: fixup irqflags breakage after ARM genirq merge
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 02:20:05 +0200
Message-Id: <1151886005.24611.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The irgflags consolidation did conflict with the ARM to generic IRQ
conversion and was not applied for ARM. Fix it up.

Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 arch/arm/common/time-acorn.c             |    2 +-
 arch/arm/kernel/irq.c                    |   24 ++++++++++++------------
 arch/arm/mach-aaec2000/core.c            |    2 +-
 arch/arm/mach-at91rm9200/time.c          |    2 +-
 arch/arm/mach-clps711x/time.c            |    2 +-
 arch/arm/mach-clps7500/core.c            |    2 +-
 arch/arm/mach-ebsa110/core.c             |    2 +-
 arch/arm/mach-ep93xx/core.c              |    2 +-
 arch/arm/mach-footbridge/dc21285-timer.c |    2 +-
 arch/arm/mach-footbridge/dc21285.c       |   10 +++++-----
 arch/arm/mach-footbridge/isa-timer.c     |    4 ++--
 arch/arm/mach-h720x/cpu-h7201.c          |    2 +-
 arch/arm/mach-h720x/cpu-h7202.c          |    2 +-
 arch/arm/mach-imx/time.c                 |    2 +-
 arch/arm/mach-integrator/core.c          |    2 +-
 arch/arm/mach-integrator/time.c          |    2 +-
 arch/arm/mach-iop3xx/iop321-time.c       |    2 +-
 arch/arm/mach-iop3xx/iop331-time.c       |    2 +-
 arch/arm/mach-ixp2000/core.c             |    2 +-
 arch/arm/mach-ixp23xx/core.c             |    2 +-
 arch/arm/mach-ixp4xx/common.c            |    2 +-
 arch/arm/mach-ixp4xx/nas100d-power.c     |    2 +-
 arch/arm/mach-ixp4xx/nslu2-power.c       |    4 ++--
 arch/arm/mach-lh7a40x/time.c             |    2 +-
 arch/arm/mach-netx/time.c                |    2 +-
 arch/arm/mach-omap1/board-osk.c          |    2 +-
 arch/arm/mach-omap1/fpga.c               |    2 +-
 arch/arm/mach-omap1/pm.c                 |    2 +-
 arch/arm/mach-omap1/serial.c             |    2 +-
 arch/arm/mach-omap1/time.c               |    4 ++--
 arch/arm/mach-omap2/board-apollon.c      |    6 +++---
 arch/arm/mach-omap2/timer-gp.c           |    2 +-
 arch/arm/mach-pnx4008/time.c             |    2 +-
 arch/arm/mach-pxa/corgi.c                |    2 +-
 arch/arm/mach-pxa/lubbock.c              |    2 +-
 arch/arm/mach-pxa/mainstone.c            |    2 +-
 arch/arm/mach-pxa/poodle.c               |    2 +-
 arch/arm/mach-pxa/sharpsl_pm.c           |    8 ++++----
 arch/arm/mach-pxa/spitz.c                |    2 +-
 arch/arm/mach-pxa/time.c                 |    2 +-
 arch/arm/mach-pxa/tosa.c                 |    2 +-
 arch/arm/mach-realview/core.c            |    2 +-
 arch/arm/mach-rpc/dma.c                  |    2 +-
 arch/arm/mach-s3c2410/dma.c              |    2 +-
 arch/arm/mach-s3c2410/time.c             |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.c       |    4 ++--
 arch/arm/mach-sa1100/collie_pm.c         |    4 ++--
 arch/arm/mach-sa1100/dma.c               |    2 +-
 arch/arm/mach-sa1100/h3600.c             |    2 +-
 arch/arm/mach-sa1100/time.c              |    2 +-
 arch/arm/mach-shark/core.c               |    2 +-
 arch/arm/mach-versatile/core.c           |    2 +-
 arch/arm/oprofile/op_model_xscale.c      |    2 +-
 arch/arm/plat-omap/dma.c                 |    2 +-
 arch/arm/plat-omap/pm.c                  |    2 +-
 arch/arm/plat-omap/timer32k.c            |    2 +-
 include/asm-arm/floppy.h                 |    2 +-
 include/asm-arm/irq.h                    |    2 +-
 include/asm-arm/signal.h                 |    6 ------
 59 files changed, 83 insertions(+), 89 deletions(-)

Index: linux-2.6.git/include/asm-arm/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm/floppy.h	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/include/asm-arm/floppy.h	2006-07-03 00:54:19.000000000 +0200
@@ -25,7 +25,7 @@
 
 #define fd_inb(port)		inb((port))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
-					    SA_INTERRUPT,"floppy",NULL)
+					    IRQF_DISABLED,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
 #define fd_disable_irq()	disable_irq(IRQ_FLOPPYDISK)
 #define fd_enable_irq()		enable_irq(IRQ_FLOPPYDISK)
Index: linux-2.6.git/include/asm-arm/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm/signal.h	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/include/asm-arm/signal.h	2006-07-03 00:54:19.000000000 +0200
@@ -82,7 +82,6 @@ typedef unsigned long sigset_t;
  *			is running in 26-bit.
  * SA_ONSTACK		allows alternate signal stacks (see sigaltstack(2)).
  * SA_RESTART		flag to get restarting signals (which were the default long ago)
- * SA_INTERRUPT		is a no-op, but left due to historical reasons. Use the
  * SA_NODEFER		prevents the current signal from being masked in the handler.
  * SA_RESETHAND		clears the handler when the signal is delivered.
  *
@@ -101,7 +100,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 
 /* 
@@ -113,10 +111,6 @@ typedef unsigned long sigset_t;
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-#define SA_TIMER		0x40000000
-#endif
-
 #include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
Index: linux-2.6.git/arch/arm/common/time-acorn.c
===================================================================
--- linux-2.6.git.orig/arch/arm/common/time-acorn.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/common/time-acorn.c	2006-07-03 00:54:19.000000000 +0200
@@ -77,7 +77,7 @@ ioc_timer_interrupt(int irq, void *dev_i
 
 static struct irqaction ioc_timer_irq = {
 	.name		= "timer",
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.handler	= ioc_timer_interrupt
 };
 
Index: linux-2.6.git/arch/arm/mach-aaec2000/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-aaec2000/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-aaec2000/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -142,7 +142,7 @@ aaec2000_timer_interrupt(int irq, void *
 
 static struct irqaction aaec2000_timer_irq = {
 	.name		= "AAEC-2000 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= aaec2000_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-clps711x/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-clps711x/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-clps711x/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -58,7 +58,7 @@ p720t_timer_interrupt(int irq, void *dev
 
 static struct irqaction clps711x_timer_irq = {
 	.name		= "CLPS711x Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= p720t_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-clps7500/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-clps7500/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-clps7500/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -316,7 +316,7 @@ clps7500_timer_interrupt(int irq, void *
 
 static struct irqaction clps7500_timer_irq = {
 	.name		= "CLPS7500 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= clps7500_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-ebsa110/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ebsa110/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ebsa110/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -199,7 +199,7 @@ ebsa110_timer_interrupt(int irq, void *d
 
 static struct irqaction ebsa110_timer_irq = {
 	.name		= "EBSA110 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= ebsa110_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ep93xx/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ep93xx/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -116,7 +116,7 @@ static int ep93xx_timer_interrupt(int ir
 
 static struct irqaction ep93xx_timer_irq = {
 	.name		= "ep93xx timer",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= ep93xx_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-footbridge/dc21285.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-footbridge/dc21285.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-footbridge/dc21285.c	2006-07-03 00:54:19.000000000 +0200
@@ -332,15 +332,15 @@ void __init dc21285_preinit(void)
 	/*
 	 * We don't care if these fail.
 	 */
-	request_irq(IRQ_PCI_SERR, dc21285_serr_irq, SA_INTERRUPT,
+	request_irq(IRQ_PCI_SERR, dc21285_serr_irq, IRQF_DISABLED,
 		    "PCI system error", &serr_timer);
-	request_irq(IRQ_PCI_PERR, dc21285_parity_irq, SA_INTERRUPT,
+	request_irq(IRQ_PCI_PERR, dc21285_parity_irq, IRQF_DISABLED,
 		    "PCI parity error", &perr_timer);
-	request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, SA_INTERRUPT,
+	request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, IRQF_DISABLED,
 		    "PCI abort", NULL);
-	request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, SA_INTERRUPT,
+	request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, IRQF_DISABLED,
 		    "Discard timer", NULL);
-	request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, SA_INTERRUPT,
+	request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, IRQF_DISABLED,
 		    "PCI data parity", NULL);
 
 	if (cfn_mode) {
Index: linux-2.6.git/arch/arm/mach-footbridge/dc21285-timer.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-footbridge/dc21285-timer.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-footbridge/dc21285-timer.c	2006-07-03 00:54:19.000000000 +0200
@@ -44,7 +44,7 @@ timer1_interrupt(int irq, void *dev_id, 
 static struct irqaction footbridge_timer_irq = {
 	.name		= "Timer1 timer tick",
 	.handler	= timer1_interrupt,
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 };
 
 /*
Index: linux-2.6.git/arch/arm/mach-footbridge/isa-timer.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-footbridge/isa-timer.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-footbridge/isa-timer.c	2006-07-03 01:09:29.000000000 +0200
@@ -73,7 +73,7 @@ isa_timer_interrupt(int irq, void *dev_i
 static struct irqaction isa_timer_irq = {
 	.name		= "ISA timer tick",
 	.handler	= isa_timer_interrupt,
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 };
 
 static void __init isa_timer_init(void)
Index: linux-2.6.git/arch/arm/mach-h720x/cpu-h7201.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-h720x/cpu-h7201.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-h720x/cpu-h7201.c	2006-07-03 00:54:19.000000000 +0200
@@ -41,7 +41,7 @@ h7201_timer_interrupt(int irq, void *dev
 
 static struct irqaction h7201_timer_irq = {
 	.name		= "h7201 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= h7201_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-h720x/cpu-h7202.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-h720x/cpu-h7202.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-h720x/cpu-h7202.c	2006-07-03 00:54:19.000000000 +0200
@@ -171,7 +171,7 @@ static struct irqchip h7202_timerx_chip 
 
 static struct irqaction h7202_timer_irq = {
 	.name		= "h7202 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= h7202_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-imx/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-imx/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-imx/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -72,7 +72,7 @@ imx_timer_interrupt(int irq, void *dev_i
 
 static struct irqaction imx_timer_irq = {
 	.name		= "i.MX Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= imx_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-integrator/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-integrator/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-integrator/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -282,7 +282,7 @@ integrator_timer_interrupt(int irq, void
 
 static struct irqaction integrator_timer_irq = {
 	.name		= "Integrator Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= integrator_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-integrator/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-integrator/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-integrator/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -125,7 +125,7 @@ static int rtc_probe(struct amba_device 
 
 	xtime.tv_sec = __raw_readl(rtc_base + RTC_DR);
 
-	ret = request_irq(dev->irq[0], arm_rtc_interrupt, SA_INTERRUPT,
+	ret = request_irq(dev->irq[0], arm_rtc_interrupt, IRQF_DISABLED,
 			  "rtc-pl030", dev);
 	if (ret)
 		goto map_out;
Index: linux-2.6.git/arch/arm/mach-iop3xx/iop321-time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-iop3xx/iop321-time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-iop3xx/iop321-time.c	2006-07-03 00:54:19.000000000 +0200
@@ -85,7 +85,7 @@ iop321_timer_interrupt(int irq, void *de
 static struct irqaction iop321_timer_irq = {
 	.name		= "IOP321 Timer Tick",
 	.handler	= iop321_timer_interrupt,
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 };
 
 static void __init iop321_timer_init(void)
Index: linux-2.6.git/arch/arm/mach-iop3xx/iop331-time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-iop3xx/iop331-time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-iop3xx/iop331-time.c	2006-07-03 00:54:19.000000000 +0200
@@ -82,7 +82,7 @@ iop331_timer_interrupt(int irq, void *de
 static struct irqaction iop331_timer_irq = {
 	.name		= "IOP331 Timer Tick",
 	.handler	= iop331_timer_interrupt,
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 };
 
 static void __init iop331_timer_init(void)
Index: linux-2.6.git/arch/arm/mach-ixp2000/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ixp2000/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ixp2000/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -224,7 +224,7 @@ static int ixp2000_timer_interrupt(int i
 
 static struct irqaction ixp2000_timer_irq = {
 	.name		= "IXP2000 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= ixp2000_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-ixp23xx/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ixp23xx/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ixp23xx/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -363,7 +363,7 @@ ixp23xx_timer_interrupt(int irq, void *d
 static struct irqaction ixp23xx_timer_irq = {
 	.name		= "IXP23xx Timer Tick",
 	.handler	= ixp23xx_timer_interrupt,
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 };
 
 void __init ixp23xx_init_timer(void)
Index: linux-2.6.git/arch/arm/mach-ixp4xx/common.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ixp4xx/common.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ixp4xx/common.c	2006-07-03 00:54:19.000000000 +0200
@@ -287,7 +287,7 @@ static irqreturn_t ixp4xx_timer_interrup
 
 static struct irqaction ixp4xx_timer_irq = {
 	.name		= "IXP4xx Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= ixp4xx_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-ixp4xx/nas100d-power.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ixp4xx/nas100d-power.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ixp4xx/nas100d-power.c	2006-07-03 00:54:19.000000000 +0200
@@ -42,7 +42,7 @@ static int __init nas100d_power_init(voi
 	set_irq_type(NAS100D_RB_IRQ, IRQT_LOW);
 
 	if (request_irq(NAS100D_RB_IRQ, &nas100d_reset_handler,
-		SA_INTERRUPT, "NAS100D reset button", NULL) < 0) {
+		IRQF_DISABLED, "NAS100D reset button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
 			NAS100D_RB_IRQ);
Index: linux-2.6.git/arch/arm/mach-ixp4xx/nslu2-power.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-ixp4xx/nslu2-power.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-ixp4xx/nslu2-power.c	2006-07-03 00:54:19.000000000 +0200
@@ -54,7 +54,7 @@ static int __init nslu2_power_init(void)
 	set_irq_type(NSLU2_PB_IRQ, IRQT_HIGH);
 
 	if (request_irq(NSLU2_RB_IRQ, &nslu2_reset_handler,
-		SA_INTERRUPT, "NSLU2 reset button", NULL) < 0) {
+		IRQF_DISABLED, "NSLU2 reset button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
 			NSLU2_RB_IRQ);
@@ -63,7 +63,7 @@ static int __init nslu2_power_init(void)
 	}
 
 	if (request_irq(NSLU2_PB_IRQ, &nslu2_power_handler,
-		SA_INTERRUPT, "NSLU2 power button", NULL) < 0) {
+		IRQF_DISABLED, "NSLU2 power button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Power Button IRQ %d not available\n",
 			NSLU2_PB_IRQ);
Index: linux-2.6.git/arch/arm/mach-lh7a40x/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-lh7a40x/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-lh7a40x/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -53,7 +53,7 @@ lh7a40x_timer_interrupt(int irq, void *d
 
 static struct irqaction lh7a40x_timer_irq = {
 	.name		= "LHA740x Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= lh7a40x_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-netx/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-netx/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-netx/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -54,7 +54,7 @@ netx_timer_interrupt(int irq, void *dev_
 
 static struct irqaction netx_timer_irq = {
 	.name           = "NetX Timer Tick",
-	.flags          = SA_INTERRUPT | SA_TIMER,
+	.flags          = IRQF_DISABLED | IRQF_TIMER,
 	.handler        = netx_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-omap1/board-osk.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap1/board-osk.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap1/board-osk.c	2006-07-03 00:54:19.000000000 +0200
@@ -357,7 +357,7 @@ static void __init osk_mistral_init(void
 		 */
 		ret = request_irq(OMAP_GPIO_IRQ(OMAP_MPUIO(2)),
 				&osk_mistral_wake_interrupt,
-				SA_SHIRQ, "mistral_wakeup",
+				IRQF_SHARED, "mistral_wakeup",
 				&osk_mistral_wake_interrupt);
 		if (ret != 0) {
 			omap_free_gpio(OMAP_MPUIO(2));
Index: linux-2.6.git/arch/arm/mach-omap1/fpga.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap1/fpga.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap1/fpga.c	2006-07-03 00:54:19.000000000 +0200
@@ -133,7 +133,7 @@ static struct irqchip omap_fpga_irq = {
  * mask_ack routine for all of the FPGA interrupts has been changed from
  * fpga_mask_ack_irq() to fpga_ack_irq() so that the specific FPGA interrupt
  * being serviced is left unmasked.  We can do this because the FPGA cascade
- * interrupt is installed with the SA_INTERRUPT flag, which leaves all
+ * interrupt is installed with the IRQF_DISABLED flag, which leaves all
  * interrupts masked at the CPU while an FPGA interrupt handler executes.
  *
  * Limited testing indicates that this workaround appears to be effective
Index: linux-2.6.git/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap1/pm.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap1/pm.c	2006-07-03 00:54:19.000000000 +0200
@@ -690,7 +690,7 @@ static irqreturn_t  omap_wakeup_interrup
 
 static struct irqaction omap_wakeup_irq = {
 	.name		= "peripheral wakeup",
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.handler	= omap_wakeup_interrupt
 };
 
Index: linux-2.6.git/arch/arm/mach-omap1/serial.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap1/serial.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap1/serial.c	2006-07-03 00:54:19.000000000 +0200
@@ -253,7 +253,7 @@ static void __init omap_serial_set_port_
 	}
 	omap_set_gpio_direction(gpio_nr, 1);
 	ret = request_irq(OMAP_GPIO_IRQ(gpio_nr), &omap_serial_wake_interrupt,
-			  SA_TRIGGER_RISING, "serial wakeup", NULL);
+			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
 		omap_free_gpio(gpio_nr);
 		printk(KERN_ERR "No interrupt for UART wake GPIO: %i\n",
Index: linux-2.6.git/arch/arm/mach-omap1/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap1/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap1/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -177,7 +177,7 @@ static irqreturn_t omap_mpu_timer_interr
 
 static struct irqaction omap_mpu_timer_irq = {
 	.name		= "mpu timer",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= omap_mpu_timer_interrupt,
 };
 
@@ -191,7 +191,7 @@ static irqreturn_t omap_mpu_timer1_inter
 
 static struct irqaction omap_mpu_timer1_irq = {
 	.name		= "mpu timer1 overflow",
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.handler	= omap_mpu_timer1_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-omap2/board-apollon.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap2/board-apollon.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap2/board-apollon.c	2006-07-03 00:54:19.000000000 +0200
@@ -234,17 +234,17 @@ static void __init apollon_sw_init(void)
 
 	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQT_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
-				SA_SHIRQ, "enter sw",
+				IRQF_SHARED, "enter sw",
 				&apollon_sw_interrupt))
 		return;
 	set_irq_type(OMAP_GPIO_IRQ(SW_UP_GPIO17), IRQT_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_UP_GPIO17), &apollon_sw_interrupt,
-				SA_SHIRQ, "up sw",
+				IRQF_SHARED, "up sw",
 				&apollon_sw_interrupt))
 		return;
 	set_irq_type(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), IRQT_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), &apollon_sw_interrupt,
-				SA_SHIRQ, "down sw",
+				IRQF_SHARED, "down sw",
 				&apollon_sw_interrupt))
 		return;
 }
Index: linux-2.6.git/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-omap2/timer-gp.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-omap2/timer-gp.c	2006-07-03 00:54:19.000000000 +0200
@@ -52,7 +52,7 @@ static irqreturn_t omap2_gp_timer_interr
 
 static struct irqaction omap2_gp_timer_irq = {
 	.name		= "gp timer",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= omap2_gp_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-pnx4008/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pnx4008/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pnx4008/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -86,7 +86,7 @@ static irqreturn_t pnx4008_timer_interru
 
 static struct irqaction pnx4008_timer_irq = {
 	.name = "PNX4008 Tick Timer",
-	.flags = SA_INTERRUPT | SA_TIMER,
+	.flags = IRQF_DISABLED | IRQF_TIMER,
 	.handler = pnx4008_timer_interrupt
 };
 
Index: linux-2.6.git/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/corgi.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/corgi.c	2006-07-03 00:54:19.000000000 +0200
@@ -225,7 +225,7 @@ static int corgi_mci_init(struct device 
 	corgi_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
 	err = request_irq(CORGI_IRQ_GPIO_nSD_DETECT, corgi_detect_int,
-			  SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+			  IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "corgi_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
Index: linux-2.6.git/arch/arm/mach-pxa/lubbock.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/lubbock.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/lubbock.c	2006-07-03 00:54:19.000000000 +0200
@@ -419,7 +419,7 @@ static int lubbock_mci_init(struct devic
 	init_timer(&mmc_timer);
 	mmc_timer.data = (unsigned long) data;
 	return request_irq(LUBBOCK_SD_IRQ, lubbock_detect_int,
-			SA_SAMPLE_RANDOM, "lubbock-sd-detect", data);
+			IRQF_SAMPLE_RANDOM, "lubbock-sd-detect", data);
 }
 
 static int lubbock_mci_get_ro(struct device *dev)
Index: linux-2.6.git/arch/arm/mach-pxa/mainstone.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/mainstone.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/mainstone.c	2006-07-03 00:54:19.000000000 +0200
@@ -331,7 +331,7 @@ static int mainstone_mci_init(struct dev
 	 */
 	MST_MSCWR1 &= ~MST_MSCWR1_MS_SEL;
 
-	err = request_irq(MAINSTONE_MMC_IRQ, mstone_detect_int, SA_INTERRUPT,
+	err = request_irq(MAINSTONE_MMC_IRQ, mstone_detect_int, IRQF_DISABLED,
 			     "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "mainstone_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
Index: linux-2.6.git/arch/arm/mach-pxa/poodle.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/poodle.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/poodle.c	2006-07-03 00:54:19.000000000 +0200
@@ -212,7 +212,7 @@ static int poodle_mci_init(struct device
 	poodle_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
 	err = request_irq(POODLE_IRQ_GPIO_nSD_DETECT, poodle_detect_int,
-			  SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+			  IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "poodle_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
Index: linux-2.6.git/arch/arm/mach-pxa/sharpsl_pm.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/sharpsl_pm.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/sharpsl_pm.c	2006-07-03 00:54:19.000000000 +0200
@@ -142,18 +142,18 @@ void sharpsl_pm_pxa_init(void)
 	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batlock | GPIO_IN);
 
 	/* Register interrupt handlers */
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, SA_INTERRUPT, "AC Input Detect", sharpsl_ac_isr)) {
+	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED, "AC Input Detect", sharpsl_ac_isr)) {
 		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin));
 	}
 	else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin),IRQT_BOTHEDGE);
 
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, SA_INTERRUPT, "Battery Cover", sharpsl_fatal_isr)) {
+	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED, "Battery Cover", sharpsl_fatal_isr)) {
 		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock));
 	}
 	else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock),IRQT_FALLING);
 
 	if (sharpsl_pm.machinfo->gpio_fatal) {
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, SA_INTERRUPT, "Fatal Battery", sharpsl_fatal_isr)) {
+		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED, "Fatal Battery", sharpsl_fatal_isr)) {
 			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal));
 		}
 		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal),IRQT_FALLING);
@@ -162,7 +162,7 @@ void sharpsl_pm_pxa_init(void)
 	if (sharpsl_pm.machinfo->batfull_irq)
 	{
 		/* Register interrupt handler. */
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, SA_INTERRUPT, "CO", sharpsl_chrg_full_isr)) {
+		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED, "CO", sharpsl_chrg_full_isr)) {
 			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull));
 		}
 		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull),IRQT_RISING);
Index: linux-2.6.git/arch/arm/mach-pxa/spitz.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/spitz.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/spitz.c	2006-07-03 00:54:19.000000000 +0200
@@ -308,7 +308,7 @@ static int spitz_mci_init(struct device 
 	spitz_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
 	err = request_irq(SPITZ_IRQ_GPIO_nSD_DETECT, spitz_detect_int,
-			  SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+			  IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "spitz_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
Index: linux-2.6.git/arch/arm/mach-pxa/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -117,7 +117,7 @@ pxa_timer_interrupt(int irq, void *dev_i
 
 static struct irqaction pxa_timer_irq = {
 	.name		= "PXA Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= pxa_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-pxa/tosa.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/tosa.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/tosa.c	2006-07-03 00:54:19.000000000 +0200
@@ -185,7 +185,7 @@ static int tosa_mci_init(struct device *
 
 	tosa_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
-	err = request_irq(TOSA_IRQ_GPIO_nSD_DETECT, tosa_detect_int, SA_INTERRUPT,
+	err = request_irq(TOSA_IRQ_GPIO_nSD_DETECT, tosa_detect_int, IRQF_DISABLED,
 				"MMC/SD card detect", data);
 	if (err) {
 		printk(KERN_ERR "tosa_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
Index: linux-2.6.git/arch/arm/mach-realview/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-realview/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-realview/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -536,7 +536,7 @@ static irqreturn_t realview_timer_interr
 
 static struct irqaction realview_timer_irq = {
 	.name		= "RealView Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= realview_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-rpc/dma.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-rpc/dma.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-rpc/dma.c	2006-07-03 00:54:19.000000000 +0200
@@ -128,7 +128,7 @@ static irqreturn_t iomd_dma_handle(int i
 static int iomd_request_dma(dmach_t channel, dma_t *dma)
 {
 	return request_irq(dma->dma_irq, iomd_dma_handle,
-			   SA_INTERRUPT, dma->device_id, dma);
+			   IRQF_DISABLED, dma->device_id, dma);
 }
 
 static void iomd_free_dma(dmach_t channel, dma_t *dma)
Index: linux-2.6.git/arch/arm/mach-s3c2410/dma.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-s3c2410/dma.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-s3c2410/dma.c	2006-07-03 00:54:19.000000000 +0200
@@ -718,7 +718,7 @@ int s3c2410_dma_request(unsigned int cha
 		pr_debug("dma%d: %s : requesting irq %d\n",
 			 channel, __FUNCTION__, chan->irq);
 
-		err = request_irq(chan->irq, s3c2410_dma_irq, SA_INTERRUPT,
+		err = request_irq(chan->irq, s3c2410_dma_irq, IRQF_DISABLED,
 				  client->name, (void *)chan);
 
 		if (err) {
Index: linux-2.6.git/arch/arm/mach-s3c2410/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-s3c2410/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-s3c2410/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -138,7 +138,7 @@ s3c2410_timer_interrupt(int irq, void *d
 
 static struct irqaction s3c2410_timer_irq = {
 	.name		= "S3C2410 Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= s3c2410_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-s3c2410/usb-simtec.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-s3c2410/usb-simtec.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-s3c2410/usb-simtec.c	2006-07-03 00:54:19.000000000 +0200
@@ -85,8 +85,8 @@ static void usb_simtec_enableoc(struct s
 
 	if (on) {
 		ret = request_irq(IRQ_USBOC, usb_simtec_ocirq,
-				  SA_INTERRUPT | SA_TRIGGER_RISING |
-				   SA_TRIGGER_FALLING,
+				  IRQF_DISABLED | IRQF_TRIGGER_RISING |
+				   IRQF_TRIGGER_FALLING,
 				  "USB Over-current", info);
 		if (ret != 0) {
 			printk(KERN_ERR "failed to request usb oc irq\n");
Index: linux-2.6.git/arch/arm/mach-sa1100/collie_pm.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-sa1100/collie_pm.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-sa1100/collie_pm.c	2006-07-03 00:54:19.000000000 +0200
@@ -45,12 +45,12 @@ static void collie_charger_init(void)
 	}
 
 	/* Register interrupt handler. */
-	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, SA_INTERRUPT,
+	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, IRQF_DISABLED,
 			       "ACIN", sharpsl_ac_isr))) {
 		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_AC_IN);
 		return;
 	}
-	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, SA_INTERRUPT,
+	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, IRQF_DISABLED,
 			       "CO", sharpsl_chrg_full_isr))) {
 		free_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr);
 		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_CO);
Index: linux-2.6.git/arch/arm/mach-sa1100/dma.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-sa1100/dma.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-sa1100/dma.c	2006-07-03 00:54:19.000000000 +0200
@@ -124,7 +124,7 @@ int sa1100_request_dma (dma_device_t dev
 
 	i = dma - dma_chan;
 	regs = (dma_regs_t *)&DDAR(i);
-	err = request_irq(IRQ_DMA0 + i, dma_irq_handler, SA_INTERRUPT,
+	err = request_irq(IRQ_DMA0 + i, dma_irq_handler, IRQF_DISABLED,
 			  device_id, regs);
 	if (err) {
 		printk(KERN_ERR
Index: linux-2.6.git/arch/arm/mach-sa1100/h3600.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-sa1100/h3600.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-sa1100/h3600.c	2006-07-03 00:54:19.000000000 +0200
@@ -740,7 +740,7 @@ static void h3800_IRQ_demux(unsigned int
 static struct irqaction h3800_irq = {
 	.name		= "h3800_asic",
 	.handler	= h3800_IRQ_demux,
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 };
 
 u32 kpio_int_shadow = 0;
Index: linux-2.6.git/arch/arm/mach-sa1100/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-sa1100/time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-sa1100/time.c	2006-07-03 00:54:19.000000000 +0200
@@ -111,7 +111,7 @@ sa1100_timer_interrupt(int irq, void *de
 
 static struct irqaction sa1100_timer_irq = {
 	.name		= "SA11xx Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= sa1100_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-shark/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-shark/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-shark/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -90,7 +90,7 @@ shark_timer_interrupt(int irq, void *dev
 
 static struct irqaction shark_timer_irq = {
 	.name		= "Shark Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= shark_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-versatile/core.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-versatile/core.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-versatile/core.c	2006-07-03 00:54:19.000000000 +0200
@@ -869,7 +869,7 @@ static irqreturn_t versatile_timer_inter
 
 static struct irqaction versatile_timer_irq = {
 	.name		= "Versatile Timer Tick",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= versatile_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/oprofile/op_model_xscale.c
===================================================================
--- linux-2.6.git.orig/arch/arm/oprofile/op_model_xscale.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/oprofile/op_model_xscale.c	2006-07-03 00:54:19.000000000 +0200
@@ -384,7 +384,7 @@ static int xscale_pmu_start(void)
 	int ret;
 	u32 pmnc = read_pmnc();
 
-	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, SA_INTERRUPT,
+	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, IRQF_DISABLED,
 			"XScale PMU", (void *)results);
 
 	if (ret < 0) {
Index: linux-2.6.git/arch/arm/plat-omap/dma.c
===================================================================
--- linux-2.6.git.orig/arch/arm/plat-omap/dma.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/plat-omap/dma.c	2006-07-03 00:54:19.000000000 +0200
@@ -939,7 +939,7 @@ static irqreturn_t omap2_dma_irq_handler
 static struct irqaction omap24xx_dma_irq = {
 	.name = "DMA",
 	.handler = omap2_dma_irq_handler,
-	.flags = SA_INTERRUPT
+	.flags = IRQF_DISABLED
 };
 
 #else
Index: linux-2.6.git/arch/arm/plat-omap/pm.c
===================================================================
--- linux-2.6.git.orig/arch/arm/plat-omap/pm.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/plat-omap/pm.c	2006-07-03 00:54:19.000000000 +0200
@@ -580,7 +580,7 @@ static irqreturn_t  omap_wakeup_interrup
 
 static struct irqaction omap_wakeup_irq = {
 	.name		= "peripheral wakeup",
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.handler	= omap_wakeup_interrupt
 };
 
Index: linux-2.6.git/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-2.6.git.orig/arch/arm/plat-omap/timer32k.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/plat-omap/timer32k.c	2006-07-03 00:54:19.000000000 +0200
@@ -258,7 +258,7 @@ static struct dyn_tick_timer omap_dyn_ti
 
 static struct irqaction omap_32k_timer_irq = {
 	.name		= "32KHz timer",
-	.flags		= SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= omap_32k_timer_interrupt,
 };
 
Index: linux-2.6.git/arch/arm/mach-at91rm9200/at91rm9200_time.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-at91rm9200/at91rm9200_time.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-at91rm9200/at91rm9200_time.c	2006-07-03 00:54:19.000000000 +0200
@@ -85,7 +85,7 @@ static irqreturn_t at91rm9200_timer_inte
 
 static struct irqaction at91rm9200_timer_irq = {
 	.name		= "at91_tick",
-	.flags		= SA_SHIRQ | SA_INTERRUPT | SA_TIMER,
+	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER,
 	.handler	= at91rm9200_timer_interrupt
 };
 
Index: linux-2.6.git/arch/arm/mach-pxa/trizeps4.c
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pxa/trizeps4.c	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/arch/arm/mach-pxa/trizeps4.c	2006-07-03 00:54:19.000000000 +0200
@@ -283,7 +283,9 @@ static int trizeps4_mci_init(struct devi
 
 	pxa_gpio_mode(GPIO_MMC_DET | GPIO_IN);
 
-	err = request_irq(TRIZEPS4_MMC_IRQ, mci_detect_int, SA_INTERRUPT | SA_TRIGGER_RISING, "MMC card detect", data);
+	err = request_irq(TRIZEPS4_MMC_IRQ, mci_detect_int,
+			  IRQF_DISABLED | IRQF_TRIGGER_RISING,
+			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "trizeps4_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
 		return -1;
Index: linux-2.6.git/include/asm-arm/hw_irq.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm/hw_irq.h	2006-07-03 00:52:04.000000000 +0200
+++ linux-2.6.git/include/asm-arm/hw_irq.h	2006-07-03 00:54:19.000000000 +0200
@@ -9,7 +9,7 @@
 #if defined(CONFIG_NO_IDLE_HZ)
 # include <asm/dyntick.h>
 # define handle_dynamic_tick(action)					\
-	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick) {	\
+	if (!(action->flags & IRQF_TIMER) && system_timer->dyn_tick) {	\
 		write_seqlock(&xtime_lock);				\
 		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)	\
 			system_timer->dyn_tick->handler(irq, 0, regs);	\




