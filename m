Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVIFLyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVIFLyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVIFLyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:54:33 -0400
Received: from tim.rpsys.net ([194.106.48.114]:62871 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964829AbVIFLyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:54:22 -0400
Subject: [-mm patch 5/5] SharpSL: Add new ARM PXA machines Spitz and Borzoi
	with partial Akita Support
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:53:52 +0100
Message-Id: <1126007632.8338.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the platform support code for two new Sharp Zaurus Models, Spitz
(SL-C3000) and Borzoi (SL-C3100). 

This patch also adds most of the foundations for Akita (SL-C1000)
Support. The missing link for Akita is the driver for its I2C io
expander. Once this has been finished, the missing Kconfig option and
machine declaration can easily be added to this code.

Index: linux-2.6.13/include/asm-arm/arch-pxa/spitz.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13/include/asm-arm/arch-pxa/spitz.h	2005-09-06 00:14:13.000000000 +0100
@@ -0,0 +1,161 @@
+/*
+ * Hardware specific definitions for SL-Cx000 series of PDAs
+ *
+ * Copyright (c) 2005 Alexander Wykes
+ * Copyright (c) 2005 Richard Purdie
+ *
+ * Based on Sharp's 2.4 kernel patches
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_ARCH_SPITZ_H
+#define __ASM_ARCH_SPITZ_H  1
+#endif
+
+/* Spitz/Akita GPIOs */
+
+#define SPITZ_GPIO_KEY_INT         (0) /* Key Interrupt */
+#define SPITZ_GPIO_RESET           (1)
+#define SPITZ_GPIO_nSD_DETECT      (9)
+#define SPITZ_GPIO_TP_INT          (11) /* Touch Panel interrupt */
+#define SPITZ_GPIO_AK_INT          (13) /* Remote Control */
+#define SPITZ_GPIO_ADS7846_CS      (14)
+#define SPITZ_GPIO_SYNC            (16)
+#define SPITZ_GPIO_MAX1111_CS      (20)
+#define SPITZ_GPIO_FATAL_BAT       (21)
+#define SPITZ_GPIO_HSYNC           (22)
+#define SPITZ_GPIO_nSD_CLK         (32)
+#define SPITZ_GPIO_USB_DEVICE      (35)
+#define SPITZ_GPIO_USB_HOST        (37)
+#define SPITZ_GPIO_USB_CONNECT     (41)
+#define SPITZ_GPIO_LCDCON_CS       (53)
+#define SPITZ_GPIO_nPCE            (54)
+#define SPITZ_GPIO_nSD_WP          (81)
+#define SPITZ_GPIO_ON_RESET        (89)
+#define SPITZ_GPIO_BAT_COVER       (90)
+#define SPITZ_GPIO_CF_CD           (94)
+#define SPITZ_GPIO_ON_KEY          (95)
+#define SPITZ_GPIO_SWA             (97)
+#define SPITZ_GPIO_SWB             (96)
+#define SPITZ_GPIO_CHRG_FULL       (101)
+#define SPITZ_GPIO_CO              (101)
+#define SPITZ_GPIO_CF_IRQ          (105)
+#define SPITZ_GPIO_AC_IN           (115)
+#define SPITZ_GPIO_HP_IN           (116)
+
+/* Spitz Only GPIOs */
+
+#define SPITZ_GPIO_CF2_IRQ         (106) /* CF slot1 Ready */
+#define SPITZ_GPIO_CF2_CD          (93)
+
+
+/* Spitz/Akita Keyboard Definitions */
+
+#define SPITZ_KEY_STROBE_NUM         (12)
+#define SPITZ_KEY_SENSE_NUM          (8)
+#define SPITZ_GPIO_G0_STROBE_BIT     0x0f800000
+#define SPITZ_GPIO_G1_STROBE_BIT     0x00100000
+#define SPITZ_GPIO_G2_STROBE_BIT     0x01000000
+#define SPITZ_GPIO_G3_STROBE_BIT     0x00041880
+#define SPITZ_GPIO_G0_SENSE_BIT      0x00021000
+#define SPITZ_GPIO_G1_SENSE_BIT      0x000000d4
+#define SPITZ_GPIO_G2_SENSE_BIT      0x08000000
+#define SPITZ_GPIO_G3_SENSE_BIT      0x00000000
+
+#define SPITZ_GPIO_KEY_STROBE0       88
+#define SPITZ_GPIO_KEY_STROBE1       23
+#define SPITZ_GPIO_KEY_STROBE2       24
+#define SPITZ_GPIO_KEY_STROBE3       25
+#define SPITZ_GPIO_KEY_STROBE4       26
+#define SPITZ_GPIO_KEY_STROBE5       27
+#define SPITZ_GPIO_KEY_STROBE6       52
+#define SPITZ_GPIO_KEY_STROBE7       103
+#define SPITZ_GPIO_KEY_STROBE8       107
+#define SPITZ_GPIO_KEY_STROBE9       -1
+#define SPITZ_GPIO_KEY_STROBE10      108
+#define SPITZ_GPIO_KEY_STROBE11      114
+
+#define SPITZ_GPIO_KEY_SENSE0        12
+#define SPITZ_GPIO_KEY_SENSE1        17
+#define SPITZ_GPIO_KEY_SENSE2        91
+#define SPITZ_GPIO_KEY_SENSE3        34
+#define SPITZ_GPIO_KEY_SENSE4        36
+#define SPITZ_GPIO_KEY_SENSE5        38
+#define SPITZ_GPIO_KEY_SENSE6        39
+#define SPITZ_GPIO_KEY_SENSE7        -1
+
+
+/* Spitz Scoop Device (No. 1) GPIOs */
+/* Suspend States in comments */
+#define SPITZ_SCP_LED_GREEN     SCOOP_GPCR_PA11  /* Keep */
+#define SPITZ_SCP_JK_B          SCOOP_GPCR_PA12  /* Keep */
+#define SPITZ_SCP_CHRG_ON       SCOOP_GPCR_PA13  /* Keep */
+#define SPITZ_SCP_MUTE_L        SCOOP_GPCR_PA14  /* Low */
+#define SPITZ_SCP_MUTE_R        SCOOP_GPCR_PA15  /* Low */
+#define SPITZ_SCP_CF_POWER      SCOOP_GPCR_PA16  /* Keep */
+#define SPITZ_SCP_LED_ORANGE    SCOOP_GPCR_PA17  /* Keep */
+#define SPITZ_SCP_JK_A          SCOOP_GPCR_PA18  /* Low */
+#define SPITZ_SCP_ADC_TEMP_ON   SCOOP_GPCR_PA19  /* Low */
+
+#define SPITZ_SCP_IO_DIR      (SPITZ_SCP_LED_GREEN | SPITZ_SCP_JK_B | SPITZ_SCP_CHRG_ON | \
+                               SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_LED_ORANGE | \
+                               SPITZ_SCP_CF_POWER | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
+#define SPITZ_SCP_IO_OUT      (SPITZ_SCP_CHRG_ON | SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R)
+#define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
+#define SPITZ_SCP_SUS_SET     0
+
+/* Spitz Scoop Device (No. 2) GPIOs */
+/* Suspend States in comments */
+#define SPITZ_SCP2_IR_ON           SCOOP_GPCR_PA11  /* High */
+#define SPITZ_SCP2_AKIN_PULLUP     SCOOP_GPCR_PA12  /* Keep */
+#define SPITZ_SCP2_RESERVED_1      SCOOP_GPCR_PA13  /* High */
+#define SPITZ_SCP2_RESERVED_2      SCOOP_GPCR_PA14  /* Low */
+#define SPITZ_SCP2_RESERVED_3      SCOOP_GPCR_PA15  /* Low */
+#define SPITZ_SCP2_RESERVED_4      SCOOP_GPCR_PA16  /* Low */
+#define SPITZ_SCP2_BACKLIGHT_CONT  SCOOP_GPCR_PA17  /* Low */
+#define SPITZ_SCP2_BACKLIGHT_ON    SCOOP_GPCR_PA18  /* Low */
+#define SPITZ_SCP2_MIC_BIAS        SCOOP_GPCR_PA19  /* Low */
+
+#define SPITZ_SCP2_IO_DIR (SPITZ_SCP2_IR_ON | SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1 | \
+                           SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
+                           SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
+
+#define SPITZ_SCP2_IO_OUT   (SPITZ_SCP2_IR_ON | SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1)
+#define SPITZ_SCP2_SUS_CLR  (SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
+                             SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
+#define SPITZ_SCP2_SUS_SET  (SPITZ_SCP2_IR_ON | SPITZ_SCP2_RESERVED_1)
+
+
+/* Spitz IRQ Definitions */
+
+#define SPITZ_IRQ_GPIO_KEY_INT        IRQ_GPIO(SPITZ_GPIO_KEY_INT)
+#define SPITZ_IRQ_GPIO_AC_IN          IRQ_GPIO(SPITZ_GPIO_AC_IN)
+#define SPITZ_IRQ_GPIO_AK_INT         IRQ_GPIO(SPITZ_GPIO_AK_INT)
+#define SPITZ_IRQ_GPIO_HP_IN          IRQ_GPIO(SPITZ_GPIO_HP_IN)
+#define SPITZ_IRQ_GPIO_TP_INT         IRQ_GPIO(SPITZ_GPIO_TP_INT)
+#define SPITZ_IRQ_GPIO_SYNC           IRQ_GPIO(SPITZ_GPIO_SYNC)
+#define SPITZ_IRQ_GPIO_ON_KEY         IRQ_GPIO(SPITZ_GPIO_ON_KEY)
+#define SPITZ_IRQ_GPIO_SWA            IRQ_GPIO(SPITZ_GPIO_SWA)
+#define SPITZ_IRQ_GPIO_SWB            IRQ_GPIO(SPITZ_GPIO_SWB)
+#define SPITZ_IRQ_GPIO_BAT_COVER      IRQ_GPIO(SPITZ_GPIO_BAT_COVER)
+#define SPITZ_IRQ_GPIO_FATAL_BAT      IRQ_GPIO(SPITZ_GPIO_FATAL_BAT)
+#define SPITZ_IRQ_GPIO_CO             IRQ_GPIO(SPITZ_GPIO_CO)
+#define SPITZ_IRQ_GPIO_CF_IRQ         IRQ_GPIO(SPITZ_GPIO_CF_IRQ)
+#define SPITZ_IRQ_GPIO_CF_CD          IRQ_GPIO(SPITZ_GPIO_CF_CD)
+#define SPITZ_IRQ_GPIO_CF2_IRQ        IRQ_GPIO(SPITZ_GPIO_CF2_IRQ)
+#define SPITZ_IRQ_GPIO_nSD_INT        IRQ_GPIO(SPITZ_GPIO_nSD_INT)
+#define SPITZ_IRQ_GPIO_nSD_DETECT     IRQ_GPIO(SPITZ_GPIO_nSD_DETECT)
+
+/*
+ * Shared data structures
+ */
+extern struct platform_device spitzscoop_device;
+extern struct platform_device spitzscoop2_device;
+extern struct platform_device spitzssp_device;
+extern struct sharpsl_charger_machinfo spitz_pm_machinfo;
+
+extern void spitz_lcd_power(int on);
Index: linux-2.6.13/arch/arm/mach-pxa/spitz.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13/arch/arm/mach-pxa/spitz.c	2005-09-06 00:18:59.000000000 +0100
@@ -0,0 +1,384 @@
+/*
+ * Support for Sharp SL-Cxx00 Series of PDAs
+ * Models: SL-C3000 (Spitz), SL-C1000 (Akita) and SL-C3100 (Borzoi)
+ *
+ * Copyright (c) 2005 Richard Purdie
+ *
+ * Based on Sharp's 2.4 kernel patches/lubbock.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/major.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/mmc/host.h>
+
+#include <asm/setup.h>
+#include <asm/memory.h>
+#include <asm/mach-types.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/irq.h>
+#include <asm/arch/mmc.h>
+#include <asm/arch/udc.h>
+#include <asm/arch/ohci.h>
+#include <asm/arch/pxafb.h>
+#include <asm/arch/akita.h>
+#include <asm/arch/spitz.h>
+#include <asm/arch/sharpsl.h>
+
+#include <asm/mach/sharpsl_param.h>
+#include <asm/hardware/scoop.h>
+
+#include "generic.h"
+#include "sharpsl.h"
+
+/*
+ * Spitz SCOOP Device #1
+ */
+static struct resource spitz_scoop_resources[] = {
+	[0] = {
+		.start		= 0x10800000,
+		.end		= 0x10800fff,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct scoop_config spitz_scoop_setup = {
+	.io_dir 	= SPITZ_SCP_IO_DIR,
+	.io_out		= SPITZ_SCP_IO_OUT,
+	.suspend_clr = SPITZ_SCP_SUS_CLR,
+	.suspend_set = SPITZ_SCP_SUS_SET,
+};
+
+struct platform_device spitzscoop_device = {
+	.name		= "sharp-scoop",
+	.id		= 0,
+	.dev		= {
+ 		.platform_data	= &spitz_scoop_setup,
+	},
+	.num_resources	= ARRAY_SIZE(spitz_scoop_resources),
+	.resource	= spitz_scoop_resources,
+};
+
+/*
+ * Spitz SCOOP Device #2
+ */
+static struct resource spitz_scoop2_resources[] = {
+	[0] = {
+		.start		= 0x08800040,
+		.end		= 0x08800fff,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct scoop_config spitz_scoop2_setup = {
+	.io_dir 	= SPITZ_SCP2_IO_DIR,
+	.io_out		= SPITZ_SCP2_IO_OUT,
+	.suspend_clr = SPITZ_SCP2_SUS_CLR,
+	.suspend_set = SPITZ_SCP2_SUS_SET,
+};
+
+struct platform_device spitzscoop2_device = {
+	.name		= "sharp-scoop",
+	.id		= 1,
+	.dev		= {
+ 		.platform_data	= &spitz_scoop2_setup,
+	},
+	.num_resources	= ARRAY_SIZE(spitz_scoop2_resources),
+	.resource	= spitz_scoop2_resources,
+};
+
+static struct scoop_pcmcia_dev spitz_pcmcia_scoop[] = {
+{
+	.dev        = &spitzscoop_device.dev,
+	.irq        = SPITZ_IRQ_GPIO_CF_IRQ,
+	.cd_irq     = SPITZ_IRQ_GPIO_CF_CD,
+	.cd_irq_str = "PCMCIA0 CD",
+},{
+	.dev        = &spitzscoop2_device.dev,
+	.irq        = SPITZ_IRQ_GPIO_CF2_IRQ,
+	.cd_irq     = -1,
+},
+};
+
+
+/*
+ * Spitz SSP Device
+ *
+ * Set the parent as the scoop device because a lot of SSP devices
+ * also use scoop functions and this makes the power up/down order
+ * work correctly.
+ */
+struct platform_device spitzssp_device = {
+	.name		= "corgi-ssp",
+	.dev		= {
+ 		.parent = &spitzscoop_device.dev,
+	},
+	.id		= -1,
+};
+
+struct corgissp_machinfo spitz_ssp_machinfo = {
+	.port		= 2,
+	.cs_lcdcon	= SPITZ_GPIO_LCDCON_CS,
+	.cs_ads7846	= SPITZ_GPIO_ADS7846_CS,
+	.cs_max1111	= SPITZ_GPIO_MAX1111_CS,
+	.clk_lcdcon	= 520,
+	.clk_ads7846	= 14,
+	.clk_max1111	= 56,
+};
+
+
+/*
+ * Spitz Backlight Device
+ */
+static struct platform_device spitzbl_device = {
+	.name		= "corgi-bl",
+	.id		= -1,
+};
+
+
+/*
+ * Spitz Keyboard Device
+ */
+static struct platform_device spitzkbd_device = {
+	.name		= "spitz-keyboard",
+	.id		= -1,
+};
+
+
+/*
+ * Spitz Touch Screen Device
+ */
+static struct resource spitzts_resources[] = {
+	[0] = {
+		.start		= SPITZ_GPIO_TP_INT,
+		.end		= SPITZ_GPIO_TP_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device spitzts_device = {
+	.name		= "corgi-ts",
+	.dev		= {
+ 		.parent = &spitzssp_device.dev,
+	},
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(spitzts_resources),
+	.resource	= spitzts_resources,
+};
+
+
+/*
+ * MMC/SD Device
+ *
+ * The card detect interrupt isn't debounced so we delay it by HZ/4
+ * to give the card a chance to fully insert/eject.
+ */
+static struct mmc_detect {
+	struct timer_list detect_timer;
+	void *devid;
+} mmc_detect;
+
+static void mmc_detect_callback(unsigned long data)
+{
+	mmc_detect_change(mmc_detect.devid);
+}
+
+static irqreturn_t spitz_mmc_detect_int(int irq, void *devid, struct pt_regs *regs)
+{
+	mmc_detect.devid=devid;
+	mod_timer(&mmc_detect.detect_timer, jiffies + HZ/4);
+	printk(KERN_WARNING "MMC detect callback\n");
+	return IRQ_HANDLED;
+}
+
+static int spitz_mci_init(struct device *dev, irqreturn_t (*unused_detect_int)(int, void *, struct pt_regs *), void *data)
+{
+	int err;
+
+	/* setup GPIO for PXA27x MMC controller	*/
+	pxa_gpio_mode(GPIO32_MMCCLK_MD);
+	pxa_gpio_mode(GPIO112_MMCCMD_MD);
+	pxa_gpio_mode(GPIO92_MMCDAT0_MD);
+	pxa_gpio_mode(GPIO109_MMCDAT1_MD);
+	pxa_gpio_mode(GPIO110_MMCDAT2_MD);
+	pxa_gpio_mode(GPIO111_MMCDAT3_MD);
+	pxa_gpio_mode(SPITZ_GPIO_nSD_DETECT | GPIO_IN);
+	pxa_gpio_mode(SPITZ_GPIO_nSD_WP | GPIO_IN);
+
+	init_timer(&mmc_detect.detect_timer);
+	mmc_detect.detect_timer.function = mmc_detect_callback;
+	mmc_detect.detect_timer.data = (unsigned long) &mmc_detect;
+
+	err = request_irq(SPITZ_IRQ_GPIO_nSD_DETECT, spitz_mmc_detect_int, SA_INTERRUPT,
+			     "MMC card detect", data);
+	if (err) {
+		printk(KERN_ERR "spitz_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
+		return -1;
+	}
+
+	set_irq_type(SPITZ_IRQ_GPIO_nSD_DETECT, IRQT_BOTHEDGE);
+
+	return 0;
+}
+
+/* Power control is shared with one of the CF slots so we have a mess */
+static void spitz_mci_setpower(struct device *dev, unsigned int vdd)
+{
+	struct pxamci_platform_data* p_d = dev->platform_data;
+
+	unsigned short cpr = read_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR);
+
+	if (( 1 << vdd) & p_d->ocr_mask) {
+		/* printk(KERN_DEBUG "%s: on\n", __FUNCTION__); */
+		set_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_CF_POWER);
+		mdelay(2);
+		write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, cpr | 0x04);
+	} else {
+		/* printk(KERN_DEBUG "%s: off\n", __FUNCTION__); */
+		write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, cpr & ~0x04);
+		
+		if (!(cpr | 0x02)) {
+			mdelay(1);
+			reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_CF_POWER);
+		}
+	}
+}
+
+static int spitz_mci_get_ro(struct device *dev)
+{
+	return GPLR(SPITZ_GPIO_nSD_WP) & GPIO_bit(SPITZ_GPIO_nSD_WP);
+}
+
+static void spitz_mci_exit(struct device *dev, void *data)
+{
+	free_irq(SPITZ_IRQ_GPIO_nSD_DETECT, data);
+	del_timer(&mmc_detect.detect_timer);
+}
+
+static struct pxamci_platform_data spitz_mci_platform_data = {
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.init 		= spitz_mci_init,
+	.get_ro		= spitz_mci_get_ro,
+	.setpower 	= spitz_mci_setpower,
+	.exit		= spitz_mci_exit,
+};
+
+
+/*
+ * Spitz PXA Framebuffer
+ */
+static struct pxafb_mach_info spitz_pxafb_info __initdata = {
+        .pixclock       = 19231,
+        .xres           = 480,
+        .yres           = 640,
+        .bpp            = 16,
+        .hsync_len      = 40,
+        .left_margin    = 46,
+        .right_margin   = 125,
+        .vsync_len      = 3,
+        .upper_margin   = 1,
+        .lower_margin   = 0,
+        .sync           = 0,
+        .lccr0          = LCCR0_Color | LCCR0_Sngl | LCCR0_Act | LCCR0_LDDALT | LCCR0_OUC | LCCR0_CMDIM | LCCR0_RDSTM,
+        .lccr3          = LCCR3_PixRsEdg | LCCR3_OutEnH,
+        .pxafb_backlight_power  = NULL,
+        .pxafb_lcd_power = spitz_lcd_power,
+};
+
+
+static struct platform_device *devices[] __initdata = {
+	&spitzscoop_device,
+	&spitzssp_device,
+	&spitzkbd_device,
+	&spitzts_device,
+	&spitzbl_device,
+	&spitzbattery_device,
+};
+
+static void __init common_init(void)
+{
+	PMCR = 0x00;
+
+	/* setup sleep mode values */
+	PWER  = 0x00000002;
+	PFER  = 0x00000000;
+	PRER  = 0x00000002;
+	PGSR0 = 0x0158C000;
+	PGSR1 = 0x00FF0080;
+	PGSR2 = 0x0001C004;
+
+	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
+	PCFR |= PCFR_OPDE;
+
+	corgi_ssp_set_machinfo(&spitz_ssp_machinfo);
+
+	pxa_gpio_mode(SPITZ_GPIO_HSYNC | GPIO_IN);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+	pxa_set_mci_info(&spitz_mci_platform_data);
+	pxafb_device.dev.parent = &spitzssp_device.dev;
+	set_pxa_fb_info(&spitz_pxafb_info);
+}
+
+static void __init spitz_init(void)
+{
+	scoop_num = 2;
+	scoop_devs = &spitz_pcmcia_scoop[0];
+
+	common_init();
+
+	platform_device_register(&spitzscoop2_device);
+}
+
+static void __init fixup_spitz(struct machine_desc *desc,
+		struct tag *tags, char **cmdline, struct meminfo *mi)
+{
+	sharpsl_save_param();
+	mi->nr_banks=1;
+	mi->bank[0].start = 0xa0000000;
+	mi->bank[0].node = 0;
+	mi->bank[0].size = (64*1024*1024);
+}
+
+#ifdef CONFIG_MACH_SPITZ
+MACHINE_START(SPITZ, "SHARP Spitz")
+	.phys_ram	= 0xa0000000,
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.fixup		= fixup_spitz,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa_init_irq,
+	.init_machine	= spitz_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_BORZOI
+MACHINE_START(BORZOI, "SHARP Borzoi")
+	.phys_ram	= 0xa0000000,
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.fixup		= fixup_spitz,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa_init_irq,
+	.init_machine	= spitz_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
\ No newline at end of file
Index: linux-2.6.13/arch/arm/mach-pxa/Makefile
===================================================================
--- linux-2.6.13.orig/arch/arm/mach-pxa/Makefile	2005-09-06 00:09:29.000000000 +0100
+++ linux-2.6.13/arch/arm/mach-pxa/Makefile	2005-09-06 00:18:59.000000000 +0100
@@ -12,6 +12,7 @@
 obj-$(CONFIG_MACH_MAINSTONE) += mainstone.o
 obj-$(CONFIG_ARCH_PXA_IDP) += idp.o
 obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o corgi_lcd.o ssp.o
+obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o corgi_ssp.o corgi_lcd.o ssp.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 
 # Support for blinky lights
Index: linux-2.6.13/include/asm-arm/arch-pxa/akita.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13/include/asm-arm/arch-pxa/akita.h	2005-09-06 00:18:59.000000000 +0100
@@ -0,0 +1,30 @@
+/*
+ * Hardware specific definitions for SL-C1000 (Akita)
+ *
+ * Copyright (c) 2005 Richard Purdie
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/* Akita IO Expander GPIOs */
+
+#define AKITA_IOEXP_RESERVED_7      (1 << 7)
+#define AKITA_IOEXP_IR_ON           (1 << 6)
+#define AKITA_IOEXP_AKIN_PULLUP     (1 << 5)
+#define AKITA_IOEXP_BACKLIGHT_CONT  (1 << 4)
+#define AKITA_IOEXP_BACKLIGHT_ON    (1 << 3)
+#define AKITA_IOEXP_MIC_BIAS        (1 << 2)
+#define AKITA_IOEXP_RESERVED_1      (1 << 1)
+#define AKITA_IOEXP_RESERVED_0      (1 << 0)
+
+/* Direction Bitfield  0=output  1=input */
+#define AKITA_IOEXP_IO_DIR	0
+/* Default Values */
+#define AKITA_IOEXP_IO_OUT	(AKITA_IOEXP_IR_ON | AKITA_IOEXP_AKIN_PULLUP)
+
+void akita_set_ioexp(struct device *dev, unsigned char bitmask);
+void akita_reset_ioexp(struct device *dev, unsigned char bitmask);
+
Index: linux-2.6.13/arch/arm/mach-pxa/Kconfig
===================================================================
--- linux-2.6.13.orig/arch/arm/mach-pxa/Kconfig	2005-09-06 00:09:29.000000000 +0100
+++ linux-2.6.13/arch/arm/mach-pxa/Kconfig	2005-09-06 00:18:59.000000000 +0100
@@ -20,40 +20,66 @@
 	select PXA25x
 
 config PXA_SHARPSL
-	bool "SHARP SL-5600 and SL-C7xx Models"
-	select PXA25x
+	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
 	select SHARP_SCOOP
 	select SHARP_PARAM
 	help
 	  Say Y here if you intend to run this kernel on a
-	  Sharp SL-5600 (Poodle), Sharp SL-C700 (Corgi),
-	  SL-C750 (Shepherd) or a Sharp SL-C760 (Husky)
-	  handheld computer.
+	  Sharp Zaurus SL-5600 (Poodle), SL-C700 (Corgi), 
+	  SL-C750 (Shepherd), SL-C760 (Husky), SL-C1000 (Akita), 
+	  SL-C3000 (Spitz) or SL-C3100 (Borzoi) handheld computer.
 
 endchoice
 
+if PXA_SHARPSL
+
+choice
+	prompt "Select target Sharp Zaurus device range"
+
+config PXA_SHARPSL_25x
+	bool "Sharp PXA25x models (SL-5600 and SL-C7xx)"
+	select PXA25x
+
+config PXA_SHARPSL_27x
+	bool "Sharp PXA270 models (SL-Cxx00)"
+	select PXA27x
+
+endchoice
+
+endif	
+
 endmenu
 
 config MACH_POODLE
 	bool "Enable Sharp SL-5600 (Poodle) Support"
-	depends PXA_SHARPSL
+	depends PXA_SHARPSL_25x
 	select SHARP_LOCOMO
 
 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
-	depends PXA_SHARPSL
+	depends PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx
 
 config MACH_SHEPHERD
 	bool "Enable Sharp SL-C750 (Shepherd) Support"
-	depends PXA_SHARPSL
+	depends PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx
 
 config MACH_HUSKY
 	bool "Enable Sharp SL-C760 (Husky) Support"
-	depends PXA_SHARPSL
+	depends PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx
 
+config MACH_SPITZ
+	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
+	depends PXA_SHARPSL_27x
+	select PXA_SHARP_Cxx00
+
+config MACH_BORZOI
+	bool "Enable Sharp Zaurus SL-3100 (Borzoi) Support"
+	depends PXA_SHARPSL_27x
+	select PXA_SHARP_Cxx00
+
 config PXA25x
 	bool
 	help
@@ -74,4 +100,9 @@
 	help
 	  Enable support for all Sharp C7xx models
 
+config PXA_SHARP_Cxx00
+	bool
+	help
+	  Enable common support for Sharp Cxx00 models
+
 endif


