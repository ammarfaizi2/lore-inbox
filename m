Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVC2TSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVC2TSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVC2TSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:18:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7851 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261315AbVC2TQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:16:57 -0500
Date: Tue, 29 Mar 2005 21:15:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rmk@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix u32 vs. pm_message_t in arm
Message-ID: <20050329191543.GA8309@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t confusion in arm. I was not able to
even compile it, but it should not cause any problems. Please apply,

								Pavel

--- clean/arch/arm/common/sa1111.c	2005-02-28 00:50:39.000000000 +0100
+++ linux/arch/arm/common/sa1111.c	2005-03-27 23:33:55.000000000 +0200
@@ -800,7 +800,7 @@
 
 #ifdef CONFIG_PM
 
-static int sa1111_suspend(struct device *dev, u32 state, u32 level)
+static int sa1111_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct sa1111 *sachip = dev_get_drvdata(dev);
 	struct sa1111_save_data *save;
--- clean/arch/arm/kernel/time.c	2005-01-22 21:24:50.000000000 +0100
+++ linux/arch/arm/kernel/time.c	2005-03-27 23:33:55.000000000 +0200
@@ -178,7 +178,7 @@
 
 static SYSDEV_ATTR(event, 0200, NULL, leds_store);
 
-static int leds_suspend(struct sys_device *dev, u32 state)
+static int leds_suspend(struct sys_device *dev, pm_message_t state)
 {
 	leds_event(led_stop);
 	return 0;
@@ -351,7 +351,7 @@
 }
 
 #ifdef CONFIG_PM
-static int timer_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct sys_timer *timer = container_of(dev, struct sys_timer, dev);
 
--- clean/arch/arm/mach-integrator/integrator_ap.c	2005-01-12 11:07:37.000000000 +0100
+++ linux/arch/arm/mach-integrator/integrator_ap.c	2005-03-27 23:33:55.000000000 +0200
@@ -137,7 +137,7 @@
 #ifdef CONFIG_PM
 static unsigned long ic_irq_enable;
 
-static int irq_suspend(struct sys_device *dev, u32 state)
+static int irq_suspend(struct sys_device *dev, pm_message_t state)
 {
 	ic_irq_enable = readl(VA_IC_BASE + IRQ_ENABLE);
 	return 0;
--- clean/arch/arm/mach-integrator/time.c	2005-02-28 00:50:39.000000000 +0100
+++ linux/arch/arm/mach-integrator/time.c	2005-03-27 23:33:55.000000000 +0200
@@ -158,7 +158,7 @@
 
 static struct timespec rtc_delta;
 
-static int rtc_suspend(struct amba_device *dev, u32 state)
+static int rtc_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct timespec rtc;
 
--- clean/arch/arm/mach-pxa/corgi_ssp.c	2005-01-22 21:24:51.000000000 +0100
+++ linux/arch/arm/mach-pxa/corgi_ssp.c	2005-03-27 23:33:55.000000000 +0200
@@ -210,7 +210,7 @@
 	return 0;
 }
 
-static int corgi_ssp_suspend(struct device *dev, u32 state, u32 level)
+static int corgi_ssp_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		ssp_flush(&corgi_ssp_dev);
--- clean/arch/arm/mach-s3c2410/dma.c	2005-03-19 00:31:04.000000000 +0100
+++ linux/arch/arm/mach-s3c2410/dma.c	2005-03-27 23:33:55.000000000 +0200
@@ -1092,7 +1092,7 @@
 
 #ifdef CONFIG_PM
 
-static int s3c2410_dma_suspend(struct sys_device *dev, u32 state)
+static int s3c2410_dma_suspend(struct sys_device *dev, pm_message_t state)
 {
 	s3c2410_dma_chan_t *cp = container_of(dev, s3c2410_dma_chan_t, dev);
 
--- clean/arch/arm/mach-s3c2410/s3c2440.c	2005-03-19 00:31:04.000000000 +0100
+++ linux/arch/arm/mach-s3c2410/s3c2440.c	2005-03-27 23:33:55.000000000 +0200
@@ -159,7 +159,7 @@
 	SAVE_ITEM(S3C2440_GPJUP)
 };
 
-static int s3c2440_suspend(struct sys_device *dev, u32 state)
+static int s3c2440_suspend(struct sys_device *dev, pm_message_t state)
 {
 	s3c2410_pm_do_save(s3c2440_sleep, ARRAY_SIZE(s3c2440_sleep));
 	return 0;
--- clean/arch/arm/mach-sa1100/irq.c	2004-03-11 18:10:36.000000000 +0100
+++ linux/arch/arm/mach-sa1100/irq.c	2005-03-27 23:33:55.000000000 +0200
@@ -218,7 +218,7 @@
 	unsigned int	iccr;
 } sa1100irq_state;
 
-static int sa1100irq_suspend(struct sys_device *dev, u32 state)
+static int sa1100irq_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct sa1100irq_state *st = &sa1100irq_state;
 
--- clean/arch/arm/mach-sa1100/neponset.c	2005-03-19 00:31:04.000000000 +0100
+++ linux/arch/arm/mach-sa1100/neponset.c	2005-03-27 23:33:55.000000000 +0200
@@ -178,7 +178,7 @@
 /*
  * LDM power management.
  */
-static int neponset_suspend(struct device *dev, u32 state, u32 level)
+static int neponset_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	/*
 	 * Save state.
--- clean/arch/arm/oprofile/common.c	2005-02-14 14:12:15.000000000 +0100
+++ linux/arch/arm/oprofile/common.c	2005-03-27 23:33:55.000000000 +0200
@@ -26,7 +26,7 @@
 static int pmu_create_files(struct super_block *, struct dentry *);
 
 #ifdef CONFIG_PM
-static int pmu_suspend(struct sys_device *dev, u32 state)
+static int pmu_suspend(struct sys_device *dev, pm_message_t state)
 {
 	if (pmu_enabled)
 		pmu_stop();
--- clean/include/asm-arm/arch-integrator/lm.h	2003-09-28 22:06:34.000000000 +0200
+++ linux/include/asm-arm/arch-integrator/lm.h	2005-03-27 23:34:31.000000000 +0200
@@ -10,7 +10,7 @@
 	struct device_driver	drv;
 	int			(*probe)(struct lm_device *);
 	void			(*remove)(struct lm_device *);
-	int			(*suspend)(struct lm_device *, u32);
+	int			(*suspend)(struct lm_device *, pm_message_t);
 	int			(*resume)(struct lm_device *);
 };
 
--- clean/include/asm-arm/hardware/amba.h	2004-04-05 10:45:28.000000000 +0200
+++ linux/include/asm-arm/hardware/amba.h	2005-03-27 23:34:31.000000000 +0200
@@ -31,7 +31,7 @@
 	int			(*probe)(struct amba_device *, void *);
 	int			(*remove)(struct amba_device *);
 	void			(*shutdown)(struct amba_device *);
-	int			(*suspend)(struct amba_device *, u32);
+	int			(*suspend)(struct amba_device *, pm_message_t);
 	int			(*resume)(struct amba_device *);
 	struct amba_id		*id_table;
 };
--- clean/include/asm-arm/hardware/locomo.h	2005-03-19 00:32:11.000000000 +0100
+++ linux/include/asm-arm/hardware/locomo.h	2005-03-27 23:34:31.000000000 +0200
@@ -181,7 +181,7 @@
 	unsigned int		devid;
 	int (*probe)(struct locomo_dev *);
 	int (*remove)(struct locomo_dev *);
-	int (*suspend)(struct locomo_dev *, u32);
+	int (*suspend)(struct locomo_dev *, pm_message_t);
 	int (*resume)(struct locomo_dev *);
 };
 
--- clean/include/asm-arm/hardware/sa1111.h	2005-02-28 00:50:44.000000000 +0100
+++ linux/include/asm-arm/hardware/sa1111.h	2005-03-27 23:34:31.000000000 +0200
@@ -567,7 +567,7 @@
 	unsigned int		devid;
 	int (*probe)(struct sa1111_dev *);
 	int (*remove)(struct sa1111_dev *);
-	int (*suspend)(struct sa1111_dev *, u32);
+	int (*suspend)(struct sa1111_dev *, pm_message_t);
 	int (*resume)(struct sa1111_dev *);
 };
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
