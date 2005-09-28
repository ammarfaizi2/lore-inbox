Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVI1XJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVI1XJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVI1XJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:09:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6822 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751207AbVI1XJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:09:09 -0400
Date: Thu, 29 Sep 2005 00:09:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] arm/versatile iomem annotations
Message-ID: <20050928230902.GE7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-sata_qstor/arch/arm/mach-versatile/core.c RC14-rc2-git6-armv-iomem/arch/arm/mach-versatile/core.c
--- RC14-rc2-git6-sata_qstor/arch/arm/mach-versatile/core.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git6-armv-iomem/arch/arm/mach-versatile/core.c	2005-09-28 13:02:03.000000000 -0400
@@ -52,8 +52,9 @@
  *
  * Setup a VA for the Versatile Vectored Interrupt Controller.
  */
-#define VA_VIC_BASE		 IO_ADDRESS(VERSATILE_VIC_BASE)
-#define VA_SIC_BASE		 IO_ADDRESS(VERSATILE_SIC_BASE)
+#define __io_address(n)		__io(IO_ADDRESS(n))
+#define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
+#define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
 
 static void vic_mask_irq(unsigned int irq)
 {
@@ -214,7 +215,7 @@
 	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
 }
 
-#define VERSATILE_REFCOUNTER	(IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_24MHz_OFFSET)
+#define VERSATILE_REFCOUNTER	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_24MHz_OFFSET)
 
 /*
  * This is the Versatile sched_clock implementation.  This has
@@ -231,7 +232,7 @@
 }
 
 
-#define VERSATILE_FLASHCTRL    (IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_FLASH_OFFSET)
+#define VERSATILE_FLASHCTRL    (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_FLASH_OFFSET)
 
 static int versatile_flash_init(void)
 {
@@ -309,7 +310,7 @@
 	.resource	= smc91x_resources,
 };
 
-#define VERSATILE_SYSMCI	(IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_MCI_OFFSET)
+#define VERSATILE_SYSMCI	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_MCI_OFFSET)
 
 unsigned int mmc_status(struct device *dev)
 {
@@ -343,11 +344,11 @@
 
 static void versatile_oscvco_set(struct clk *clk, struct icst307_vco vco)
 {
-	unsigned long sys_lock = IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_LOCK_OFFSET;
+	void __iomem *sys_lock = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LOCK_OFFSET;
 #if defined(CONFIG_ARCH_VERSATILE_PB)
-	unsigned long sys_osc = IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSC4_OFFSET;
+	void __iomem *sys_osc = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSC4_OFFSET;
 #elif defined(CONFIG_MACH_VERSATILE_AB)
-	unsigned long sys_osc = IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSC1_OFFSET;
+	void __iomem *sys_osc = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSC1_OFFSET;
 #endif
 	u32 val;
 
@@ -483,7 +484,7 @@
  */
 static struct clcd_panel *versatile_clcd_panel(void)
 {
-	unsigned long sys_clcd = IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
+	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
 	struct clcd_panel *panel = &vga;
 	u32 val;
 
@@ -510,7 +511,7 @@
  */
 static void versatile_clcd_disable(struct clcd_fb *fb)
 {
-	unsigned long sys_clcd = IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
+	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
 	u32 val;
 
 	val = readl(sys_clcd);
@@ -522,7 +523,7 @@
 	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light off
 	 */
 	if (fb->panel == &sanyo_2_5_in) {
-		unsigned long versatile_ib2_ctrl = IO_ADDRESS(VERSATILE_IB2_CTRL);
+		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
 		unsigned long ctrl;
 
 		ctrl = readl(versatile_ib2_ctrl);
@@ -537,7 +538,7 @@
  */
 static void versatile_clcd_enable(struct clcd_fb *fb)
 {
-	unsigned long sys_clcd = IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
+	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
 	u32 val;
 
 	val = readl(sys_clcd);
@@ -571,7 +572,7 @@
 	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light on
 	 */
 	if (fb->panel == &sanyo_2_5_in) {
-		unsigned long versatile_ib2_ctrl = IO_ADDRESS(VERSATILE_IB2_CTRL);
+		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
 		unsigned long ctrl;
 
 		ctrl = readl(versatile_ib2_ctrl);
@@ -720,7 +721,7 @@
 };
 
 #ifdef CONFIG_LEDS
-#define VA_LEDS_BASE (IO_ADDRESS(VERSATILE_SYS_BASE) + VERSATILE_SYS_LED_OFFSET)
+#define VA_LEDS_BASE (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LED_OFFSET)
 
 static void versatile_leds_event(led_event_t ledevt)
 {
@@ -778,11 +779,11 @@
 /*
  * Where is the timer (VA)?
  */
-#define TIMER0_VA_BASE		 IO_ADDRESS(VERSATILE_TIMER0_1_BASE)
-#define TIMER1_VA_BASE		(IO_ADDRESS(VERSATILE_TIMER0_1_BASE) + 0x20)
-#define TIMER2_VA_BASE		 IO_ADDRESS(VERSATILE_TIMER2_3_BASE)
-#define TIMER3_VA_BASE		(IO_ADDRESS(VERSATILE_TIMER2_3_BASE) + 0x20)
-#define VA_IC_BASE		 IO_ADDRESS(VERSATILE_VIC_BASE) 
+#define TIMER0_VA_BASE		 __io_address(VERSATILE_TIMER0_1_BASE)
+#define TIMER1_VA_BASE		(__io_address(VERSATILE_TIMER0_1_BASE) + 0x20)
+#define TIMER2_VA_BASE		 __io_address(VERSATILE_TIMER2_3_BASE)
+#define TIMER3_VA_BASE		(__io_address(VERSATILE_TIMER2_3_BASE) + 0x20)
+#define VA_IC_BASE		 __io_address(VERSATILE_VIC_BASE) 
 
 /*
  * How long is the timer interval?
@@ -877,12 +878,12 @@
 	 *	VERSATILE_REFCLK is 32KHz
 	 *	VERSATILE_TIMCLK is 1MHz
 	 */
-	val = readl(IO_ADDRESS(VERSATILE_SCTL_BASE));
+	val = readl(__io_address(VERSATILE_SCTL_BASE));
 	writel((VERSATILE_TIMCLK << VERSATILE_TIMER1_EnSel) |
 	       (VERSATILE_TIMCLK << VERSATILE_TIMER2_EnSel) | 
 	       (VERSATILE_TIMCLK << VERSATILE_TIMER3_EnSel) |
 	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
-	       IO_ADDRESS(VERSATILE_SCTL_BASE));
+	       __io_address(VERSATILE_SCTL_BASE));
 
 	/*
 	 * Initialise to a known state (all timers off)
diff -urN RC14-rc2-git6-sata_qstor/include/asm-arm/arch-versatile/io.h RC14-rc2-git6-armv-iomem/include/asm-arm/arch-versatile/io.h
--- RC14-rc2-git6-sata_qstor/include/asm-arm/arch-versatile/io.h	2005-08-28 23:09:48.000000000 -0400
+++ RC14-rc2-git6-armv-iomem/include/asm-arm/arch-versatile/io.h	2005-09-28 13:02:03.000000000 -0400
@@ -22,7 +22,11 @@
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-#define __io(a)			((void __iomem *)(a))
+static inline void __iomem *__io(unsigned long addr)
+{
+	return (void __iomem *)addr;
+}
+#define __io(a)	__io(a)
 #define __mem_pci(a)		(a)
 #define __mem_isa(a)		(a)
 
