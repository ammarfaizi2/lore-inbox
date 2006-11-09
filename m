Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966062AbWKIXYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966062AbWKIXYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966066AbWKIXYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:24:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23721 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966062AbWKIXYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:24:46 -0500
Date: Fri, 10 Nov 2006 00:24:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Some sx1 cleanups
Message-ID: <20061109232415.GF2616@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should bring sx1 patches little closer to mainline's coding
style.... It would be nice to see them applied. I was pretty careful
not to break anything, but these are only compile-tested (did not
figure out how to produce working kernel, yet).

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 441a236..0e50ab3 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -5,9 +5,8 @@
  *
  * Support for the Siemens SX1 mobile phone.
  *
- * Original version : Vovan888-at-gmail com
- *
- * Maintainters : Vovan888, Sergge
+ * Original version: Vladimir Ananiev (vovan888 at gmail com)
+ * Maintainters: Vovan888, Sergge
  *                oslik.ru
  *
  * This program is free software; you can redistribute it and/or modify
@@ -41,21 +40,9 @@ #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/omap-alsa.h>
-//#include <asm/hardware/clock.h>
 #include <asm/arch/keypad.h>
 
-//----------------------------------------------------------------------------------
-#define OMAP_I2C_DEBUG	0
-
-#if (OMAP_I2C_DEBUG > 0)
-#define DBG(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#define DBG_IRQ(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#else
-#define DBG(format, args...)
-#define DBG_IRQ(format, args...)
-#endif
-
-int i2c_write_byte (u8 devaddr, u8 regoffset, u8 value)
+int i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
 {
 	struct i2c_adapter *adap;
 	int err;
@@ -69,9 +56,8 @@ int i2c_write_byte (u8 devaddr, u8 regof
 	msg->flags = 0;
 	msg->len = 2;
 	msg->buf = data;
-	data[0] = regoffset;	// register num
-	data[1] = value;	// register data
-//	printk("Sofia write: %x %x\n", reg, val);
+	data[0] = regoffset;	/* register num */
+	data[1] = value;	/* register data */
 	err = i2c_transfer(adap, msg, 1);
 	if (err >= 0)
 		return 0;
@@ -80,7 +66,7 @@ int i2c_write_byte (u8 devaddr, u8 regof
 
 /* Read from I2C device
  */
-int i2c_read_byte (u8 devaddr, u8 regoffset, u8 * value)
+int i2c_read_byte(u8 devaddr, u8 regoffset, u8 *value)
 {
 	struct i2c_adapter *adap;
 	int err;
@@ -95,8 +81,7 @@ int i2c_read_byte (u8 devaddr, u8 regoff
 	msg->flags = 0;
 	msg->len = 1;
 	msg->buf = data;
-	data[0] = regoffset;	// register num
-//	printk("Sofia write: %x %x\n", reg, val);
+	data[0] = regoffset;	/* register num */
 	err = i2c_transfer(adap, msg, 1);
 
 	msg->addr = devaddr;	/* I2C address */
@@ -106,73 +91,85 @@ int i2c_read_byte (u8 devaddr, u8 regoff
 	err = i2c_transfer(adap, msg, 1);
 	*value = data[0];
 
-	DBG("I2C: Read data is %x\n", (u8) * data);
 	if (err >= 0)
 		return 0;
 	return err;
 }
-// set keylight intensity
-int sx1_setkeylight ( u8 keylight )
+
+/* set intensity of keyboard backlight */
+int sx1_setkeylight(u8 keylight)
 {
-	if ( keylight > SOFIA_MAX_LIGHT_VAL )
+	if (keylight > SOFIA_MAX_LIGHT_VAL)
 		keylight = SOFIA_MAX_LIGHT_VAL;
-	return i2c_write_byte( SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight );
+	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight);
 }
-// get current keylight intensity
-int sx1_getkeylight ( u8 * keylight )
+
+/* get current intensity of keyboard backlight */
+int sx1_getkeylight(u8 *keylight)
 {
-	return i2c_read_byte( SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight );
+	return i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight);
 }
-// set LCD backlight intensity
-int sx1_setbacklight ( u8 backlight )
+
+/* set LCD backlight intensity */
+int sx1_setbacklight(u8 backlight)
 {
-	if ( backlight > SOFIA_MAX_LIGHT_VAL )
+	if (backlight > SOFIA_MAX_LIGHT_VAL)
 		backlight = SOFIA_MAX_LIGHT_VAL;
-	return i2c_write_byte( SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG, backlight );
+	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG, backlight);
 }
-// get current LCD backlight intensity
-int sx1_getbacklight ( u8 * backlight )
+
+/* get current LCD backlight intensity */
+int sx1_getbacklight (u8 *backlight)
 {
-	return i2c_read_byte( SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG, backlight );
+	return i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG, backlight);
 }
-// set LCD backlight power on/off
-int sx1_setmmipower ( u8 onoff )
+
+/* set LCD backlight power on/off */
+int sx1_setmmipower(u8 onoff)
 {
 	int err;
 	u8  dat = 0;
-	if(  (err = i2c_read_byte( SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat )) < 0 )
+
+	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	if (err < 0)
 		return err;
-	if ( onoff )
+	if (onoff)
 		dat |= SOFIA_MMILIGHT_POWER;
 	else
 		dat &= ~SOFIA_MMILIGHT_POWER;
-	return i2c_write_byte( SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat );
+	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat );
 }
-// set  MMC power on/off
-int sx1_setmmcpower ( u8 onoff )
+
+/* set MMC power on/off */
+int sx1_setmmcpower(u8 onoff)
 {
 	int err;
 	u8  dat = 0;
-	if(  (err = i2c_read_byte( SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat )) < 0 )
+
+	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	if (err < 0)
 		return err;
-	if ( onoff )
+	if (onoff)
 		dat |= SOFIA_MMC_POWER;
 	else
 		dat &= ~SOFIA_MMC_POWER;
-	return i2c_write_byte( SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat );
+	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
 }
-// set  USB power on/off
-int sx1_setusbpower ( u8 onoff )
+
+/* set USB power on/off */
+int sx1_setusbpower(u8 onoff)
 {
 	int err;
 	u8  dat = 0;
-	if(  (err = i2c_read_byte( SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat )) < 0 )
+
+	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	if (err < 0)
 		return err;
-	if ( onoff )
+	if (onoff)
 		dat |= SOFIA_USB_POWER;
 	else
 		dat &= ~SOFIA_USB_POWER;
-	return i2c_write_byte( SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat );
+	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
 }
 
 
@@ -184,37 +181,37 @@ EXPORT_SYMBOL(sx1_setmmipower);
 EXPORT_SYMBOL(sx1_setmmcpower);
 EXPORT_SYMBOL(sx1_setusbpower);
 
-//----------------------------------------------------------------------------------
+/* ------------------------------------------------------------------------- */
 
 static int sx1_keymap[] = {
-        KEY(5, 3, GROUP_0 | 117), // camera Qt::Key_F17
-        KEY(0, 4, GROUP_0 | 114), // voice memo Qt::Key_F14
-        KEY(1, 4, GROUP_2 | 114), // voice memo
-        KEY(2, 4, GROUP_3 | 114), // voice memo
-        KEY(0, 0, GROUP_1 | KEY_F12),   // red button Qt::Key_Hangup
+        KEY(5, 3, GROUP_0 | 117), /* camera Qt::Key_F17 */
+        KEY(0, 4, GROUP_0 | 114), /* voice memo Qt::Key_F14 */
+        KEY(1, 4, GROUP_2 | 114), /* voice memo */
+        KEY(2, 4, GROUP_3 | 114), /* voice memo */
+        KEY(0, 0, GROUP_1 | KEY_F12),   /* red button Qt::Key_Hangup */
         KEY(4, 3, GROUP_1 | KEY_LEFT),
         KEY(2, 3, GROUP_1 | KEY_DOWN),
         KEY(1, 3, GROUP_1 | KEY_RIGHT),
         KEY(0, 3, GROUP_1 | KEY_UP),
-        KEY(3, 3, GROUP_1 | KEY_POWER), //joystick press or Qt::Key_Select
+        KEY(3, 3, GROUP_1 | KEY_POWER), /* joystick press or Qt::Key_Select */
         KEY(5, 0, GROUP_1 | KEY_1),
         KEY(4, 0, GROUP_1 | KEY_2),
         KEY(3, 0, GROUP_1 | KEY_3),
         KEY(3, 4, GROUP_1 | KEY_4),
         KEY(4, 4, GROUP_1 | KEY_5),
-        KEY(5, 4, GROUP_1 | KEY_KPASTERISK),// *
+        KEY(5, 4, GROUP_1 | KEY_KPASTERISK), /* * */
         KEY(4, 1, GROUP_1 | KEY_6),
         KEY(5, 1, GROUP_1 | KEY_7),
         KEY(3, 1, GROUP_1 | KEY_8),
         KEY(3, 2, GROUP_1 | KEY_9),
         KEY(5, 2, GROUP_1 | KEY_0),
-        KEY(4, 2, GROUP_1 | 113),// #   F13     Toggle input method Qt::Key_F13
-        KEY(0, 1, GROUP_1 | KEY_F11),// green button Qt::Key_Call
-        KEY(1, 2, GROUP_1 | KEY_YEN),// left soft Qt::Key_Context1
-        KEY(2, 2, GROUP_1 | KEY_F8),// right soft Qt::Key_Back
-        KEY(2, 1, GROUP_1 | KEY_LEFTSHIFT), //shift
-        KEY(1, 1, GROUP_1 | KEY_BACKSPACE), // C  (clear)
-        KEY(0, 2, GROUP_1 | KEY_F7), // menu Qt::Key_Menu
+        KEY(4, 2, GROUP_1 | 113), /* #   F13     Toggle input method Qt::Key_F13 */
+        KEY(0, 1, GROUP_1 | KEY_F11), /* green button Qt::Key_Call */
+        KEY(1, 2, GROUP_1 | KEY_YEN), /* left soft Qt::Key_Context1 */
+        KEY(2, 2, GROUP_1 | KEY_F8),  /* right soft Qt::Key_Back */
+        KEY(2, 1, GROUP_1 | KEY_LEFTSHIFT), /* shift */
+        KEY(1, 1, GROUP_1 | KEY_BACKSPACE), /* C  (clear) */
+        KEY(0, 2, GROUP_1 | KEY_F7), /* menu Qt::Key_Menu */
 	0
 };
 
@@ -286,62 +283,41 @@ static struct omap_mcbsp_reg_cfg mcbsp_r
 	.srgr1 = FWID(15),
 	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
 
-//	.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-	.pcr0 = CLKXP | CLKRP,        // mcbsp: slave
+	.pcr0 = CLKXP | CLKRP,        /* mcbsp: slave */
 };
+
 /* Playback interface - McBSP1 */
 static struct omap_mcbsp_reg_cfg mcbsp1_regs = {
-	// SPCR2=30
-	.spcr2 = XINTM(3),
-	// SPCR1=30
-	.spcr1 = RINTM(3),
-	// RCR2=00
-	.rcr2  =0,
-// RCR1=140
-	.rcr1  = RFRLEN1(1) | RWDLEN1(OMAP_MCBSP_WORD_16),
-// XCR2 = 0
-	.xcr2  =0,
-// XCR1 = 140
-	.xcr1  = XFRLEN1(1) | XWDLEN1(OMAP_MCBSP_WORD_16),
-// SRGR1=0f0c
-	.srgr1 = FWID(15) | CLKGDV(12),
-// SRGR2=101f
-	.srgr2 = FSGM | FPER(31),
-// PCR0=0f0f
-	.pcr0  = FSXM | FSRM | CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
+	.spcr2 = XINTM(3),			/* SPCR2=30 */
+	.spcr1 = RINTM(3),			/* SPCR1=30 */
+	.rcr2  = 0,				/* RCR2 =00 */
+	.rcr1  = RFRLEN1(1) | RWDLEN1(OMAP_MCBSP_WORD_16),  /* RCR1=140 */
+	.xcr2  =0,				/* XCR2 = 0 */
+	.xcr1  = XFRLEN1(1) | XWDLEN1(OMAP_MCBSP_WORD_16),  /* XCR1 = 140 */
+	.srgr1 = FWID(15) | CLKGDV(12),		/* SRGR1=0f0c */
+	.srgr2 = FSGM | FPER(31), 		/* SRGR2=101f */
+	.pcr0  = FSXM | FSRM | CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP, 
+						/* PCR0 =0f0f */
 };
-/* TODO PCM interface - McBSP2 */
+
+/* TODO: PCM interface - McBSP2 */
 static struct omap_mcbsp_reg_cfg mcbsp2_regs = {
-	// SPCR2=F1
-	.spcr2 = FRST | GRST | XRST | XINTM(3),
-	// SPCR1=30
-	.spcr1 = RINTM(3) | RRST,
-	// RCR2=00
-	.rcr2  =0,
-// RCR1=140
-	.rcr1  = RFRLEN1(1) | RWDLEN1(OMAP_MCBSP_WORD_16),
-// XCR2 = 0
-	.xcr2  =0,
-// XCR1 = 140
-	.xcr1  = XFRLEN1(1) | XWDLEN1(OMAP_MCBSP_WORD_16),
-// SRGR1=0f0c
-	.srgr1 = FWID(15) | CLKGDV(12),
-// SRGR2=101f
-	.srgr2 = FSGM | FPER(31),
-// PCR0=0f0f
+	.spcr2 = FRST | GRST | XRST | XINTM(3),	/* SPCR2=F1 */
+	.spcr1 = RINTM(3) | RRST,		/* SPCR1=30 */
+	.rcr2  = 0,				/* RCR2 =00 */
+	.rcr1  = RFRLEN1(1) | RWDLEN1(OMAP_MCBSP_WORD_16), /* RCR1 = 140 */
+	.xcr2  = 0,				/* XCR2 = 0 */
+	.xcr1  = XFRLEN1(1) | XWDLEN1(OMAP_MCBSP_WORD_16), /* XCR1 = 140 */
+	.srgr1 = FWID(15) | CLKGDV(12),		/* SRGR1=0f0c */
+	.srgr2 = FSGM | FPER(31), 		/* SRGR2=101f */
 	.pcr0  = FSXM | FSRM | CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-	//.pcr0 = CLKXP | CLKRP,        /* mcbsp: slave */
+						/* PCR0=0f0f */
+	/* mcbsp: slave */
 };
 
 static struct omap_alsa_codec_config sx1_alsa_config = {
 	.name                   = "SX1 EGold",
 	.mcbsp_regs_alsa        = &mcbsp1_regs,
-	.codec_configure_dev    = NULL, // tsc2101_configure,
-	.codec_set_samplerate   = NULL, // tsc2101_set_samplerate,
-	.codec_clock_setup      = NULL, // tsc2101_clock_setup,
-	.codec_clock_on         = NULL, // tsc2101_clock_on,
-	.codec_clock_off        = NULL, // tsc2101_clock_off,
-	.get_default_samplerate = NULL, // tsc2101_get_default_samplerate,
 };
 
 static struct platform_device sx1_mcbsp1_device = {
@@ -352,7 +328,7 @@ static struct platform_device sx1_mcbsp1
 	},
 };
 
-/*-------------------------------------------------------------------------------------*/
+/* ------------------------------------------------------------------------ */
 static struct mtd_partition sx1_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -375,13 +351,6 @@ static struct mtd_partition sx1_partitio
 	      .size		= SZ_2M  - 2 * SZ_128K,
 	      .mask_flags	= 0
 	},
-	/* rest of flash1 is a file system */
-/*	{
-	      .name		= "rootfs",
-	      .offset		= MTDPART_OFS_APPEND,
-	      .size		= SZ_8M - SZ_2M - 2 * SZ_128K,
-	      .mask_flags	= 0
-	},*/
 	/* file system */
 	{
 	      .name		= "filesystem",
@@ -397,12 +366,16 @@ static struct flash_platform_data sx1_fl
 	.parts		= sx1_partitions,
 	.nr_parts	= ARRAY_SIZE(sx1_partitions),
 };
-// MTD flash at 01800000 - new flashes
+
+/* MTD flash at 01800000 - new flashes */
 static struct resource sx1_flash_resource = {
+#ifndef CONFIG_SX1_OLD_FLASH
 	.start		= OMAP_CS0_PHYS,
 	.end		= OMAP_CS0_PHYS + SZ_32M - 1,
-/*	.start		= OMAP_CS0_PHYS + SZ_16M + SZ_8M,
-	.end		= OMAP_CS0_PHYS + SZ_16M + SZ_8M + SZ_8M - 1, */
+#else
+	.start		= OMAP_CS0_PHYS + SZ_16M + SZ_8M,
+	.end		= OMAP_CS0_PHYS + SZ_16M + SZ_8M + SZ_8M - 1,
+#endif
 	.flags		= IORESOURCE_MEM,
 };
 
@@ -415,7 +388,8 @@ static struct platform_device sx1_flash_
 	.num_resources	= 1,
 	.resource	= &sx1_flash_resource,
 };
-/*-------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------- */
 static struct omap_usb_config sx1_usb_config __initdata = {
 	.otg		= 0,
 	.register_dev	= 1,
@@ -425,7 +399,8 @@ static struct omap_usb_config sx1_usb_co
 	.pins[1]	= 0,
 	.pins[2]	= 0,
 };
-/*-------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------- */
 static struct omap_mmc_config sx1_mmc_config __initdata = {
 	.mmc [0] = {
 		.enabled 	= 1,
@@ -440,17 +415,17 @@ static struct platform_device sx1_lcd_de
         .name           = "lcd_sx1",
         .id             = -1,
 };
-/*-------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------- */
 static struct platform_device *sx1_devices[] __initdata = {
 	&sx1_flash_device,
 	&sx1_kp_device,
 	&sx1_lcd_device,
 	&sx1_mcbsp1_device,
-//	&h2_irda_device,
 };
-/*-------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------- */
 static struct omap_lcd_config sx1_lcd_config __initdata = {
-/*	.panel_name	= "sx1", */
 	.ctrl_name	= "internal",
 };
 
@@ -465,7 +440,8 @@ static struct omap_board_config_kernel s
 	{ OMAP_TAG_LCD,		&sx1_lcd_config },
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
-/*-------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------- */
 static void __init omap_sx1_init(void)
 {
 	platform_add_devices(sx1_devices, ARRAY_SIZE(sx1_devices));
@@ -474,28 +450,27 @@ static void __init omap_sx1_init(void)
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
 
-//	turn on USB
-/*	sx1_setusbpower(1); cant do it here `cause i2c is not ready*/
-	omap_request_gpio(1);	// A_IRDA_OFF
-	omap_request_gpio(11);	// A_SWITCH
-	omap_request_gpio(15);	// A_USB_ON
-	omap_set_gpio_direction(1, 0);// gpio1 -> output
-	omap_set_gpio_direction(11, 0);// gpio11 -> output
-	omap_set_gpio_direction(15, 0);// gpio15 -> output
-// set GPIO data
-	omap_set_gpio_dataout(1, 1);//A_IRDA_OFF = 1
-	omap_set_gpio_dataout(11, 0);//A_SWITCH = 0
-	omap_set_gpio_dataout(15, 0);//A_USB_ON = 0
+	/* turn on USB; sx1_setusbpower(1); cant do it here, because
+	   i2c is not ready. */
+	omap_request_gpio(1);	/* A_IRDA_OFF */
+	omap_request_gpio(11);	/* A_SWITCH   */
+	omap_request_gpio(15);	/* A_USB_ON   */
+	omap_set_gpio_direction(1, 0); /* Set all to output */
+	omap_set_gpio_direction(11, 0);
+	omap_set_gpio_direction(15, 0);
+	omap_set_gpio_dataout(1, 1);  /* A_IRDA_OFF = 1 */
+	omap_set_gpio_dataout(11, 0); /* A_SWITCH = 0   */
+	omap_set_gpio_dataout(15, 0); /* A_USB_ON = 0   */
 
 }
-/*-------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------- */
 static void __init omap_sx1_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
 }
-/*-------------------------------------------------------------------------------------*/
 
 static void __init omap_sx1_map_io(void)
 {
diff --git a/drivers/video/omap/lcd_sx1.c b/drivers/video/omap/lcd_sx1.c
index 818a9ce..3a8e023 100644
--- a/drivers/video/omap/lcd_sx1.c
+++ b/drivers/video/omap/lcd_sx1.c
@@ -22,19 +22,16 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/arch/gpio.h>
-#include <linux/delay.h>
 #include <asm/arch/omapfb.h>
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/mux.h>
-//#include <asm/arch/board-sx1.h>
-// #define OMAPFB_DBG 1
 
 /*
  * OMAP310 GPIO registers
  */
-//#define OMAP1510_GPIO_BASE		0xfffce000
 #define GPIO_DATA_INPUT		0xfffce000
 #define GPIO_DATA_OUTPUT	0xfffce004
 #define GPIO_DIR_CONTROL	0xfffce008
@@ -50,11 +47,8 @@ #define _A_LCD_RESET	9
 #define _A_LCD_SSC_CS	12
 #define _A_LCD_SSC_A0	13
 
-// MCBPS3_PCR0
-// A_LCD_SSC_CLK
 #define DSP_REG		0xE1017024
 
-// from videodriver.dll
 const unsigned char INIT_1[12] = {
 	0x1C, 0x02, 0x88, 0x00, 0x1E, 0xE0, 0x00, 0xDC, 0x00, 0x02, 0x00
 };
@@ -74,152 +68,147 @@ const unsigned char INIT_3[15] = {
 	0x14, 0x26, 0x33, 0x3D, 0x45, 0x4D, 0x53, 0x59,
 	0x5E, 0x63, 0x67, 0x6D, 0x71, 0x78, 0xFF
 };
-// from videodriver.dll
-static void epson_sendbyte( int flag, unsigned char byte)
+
+static void epson_sendbyte(int flag, unsigned char byte)
 {
+	int i, shifter = 0x80;
 
-	int	i, shifter = 0x80;
-	if( !flag )
-		omap_set_gpio_dataout( _A_LCD_SSC_A0, 0 );
-	mdelay( 2 );
-	omap_set_gpio_dataout( A_LCD_SSC_RD, 1 );
+	if (!flag)
+		omap_set_gpio_dataout(_A_LCD_SSC_A0, 0);
+	mdelay(2);
+	omap_set_gpio_dataout(A_LCD_SSC_RD, 1);
 
-	omap_set_gpio_dataout( A_LCD_SSC_SD, flag );
+	omap_set_gpio_dataout(A_LCD_SSC_SD, flag);
 
-	OMAP_MCBSP_WRITE( OMAP1510_MCBSP3_BASE, PCR0, 0x2200 );
-	OMAP_MCBSP_WRITE( OMAP1510_MCBSP3_BASE, PCR0, 0x2202 );
-	for( i = 0; i < 8; i++ ) {
-		OMAP_MCBSP_WRITE( OMAP1510_MCBSP3_BASE, PCR0, 0x2200 );
-		omap_set_gpio_dataout( A_LCD_SSC_SD, shifter & byte );
-		OMAP_MCBSP_WRITE( OMAP1510_MCBSP3_BASE, PCR0, 0x2202 );
+	OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2200);
+	OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2202);
+	for (i = 0; i < 8; i++) {
+		OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2200);
+		omap_set_gpio_dataout(A_LCD_SSC_SD, shifter & byte);
+		OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2202);
 		shifter >>= 1;
 	}
-	omap_set_gpio_dataout( _A_LCD_SSC_A0, 1 );
+	omap_set_gpio_dataout(_A_LCD_SSC_A0, 1);
 }
 
-static void InitSystem(void)
+static void init_system(void)
 {
-//from videodriver.dll
-// EN_PERCK - enable peripheral clock
-//	omap_writew( omap_readw(ARM_IDLECT2) | 0x02 , ARM_IDLECT2);
-// PER_EN - MPUPER_nRST signal enable
-//	omap_writew( omap_readw(ARM_RSTCT2) | 0x01 , ARM_RSTCT2);
-//	omap_writew( (omap_readw(MPUI_CTRL) & ~0x30004 ) | 0xFF1B , MPUI_CTRL);
-//	omap_writew( 0x02 , MPUI_DSP_BOOT_CONFIG);
-
 	omap_mcbsp_request(OMAP_MCBSP3);
 	omap_mcbsp_stop(OMAP_MCBSP3);
-
-
 }
-static void SetupGPIO(void)
+
+static void setup_GPIO(void)
 {
-// from videodriver.dll
-// new wave
+	/* new wave */
 	omap_request_gpio(A_LCD_SSC_RD);
 	omap_request_gpio(A_LCD_SSC_SD);
 	omap_request_gpio(_A_LCD_RESET);
 	omap_request_gpio(_A_LCD_SSC_CS);
 	omap_request_gpio(_A_LCD_SSC_A0);
-// set GPIO direction
-	omap_set_gpio_direction(A_LCD_SSC_RD, 0);// gpio3 -> output
-	omap_set_gpio_direction(A_LCD_SSC_SD, 0);// gpio7 -> output
-	omap_set_gpio_direction(_A_LCD_RESET, 0);// gpio9 -> output
-	omap_set_gpio_direction(_A_LCD_SSC_CS, 0);// gpio12 -> output
-	omap_set_gpio_direction(_A_LCD_SSC_A0, 0);// gpio13 -> output
-// set GPIO data
-	omap_set_gpio_dataout( A_LCD_SSC_RD, 1 );
-	omap_set_gpio_dataout( A_LCD_SSC_SD, 0 );
-	omap_set_gpio_dataout( _A_LCD_RESET, 0 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_A0, 1 );
+
+	/* set all GPIOs to output */
+	omap_set_gpio_direction(A_LCD_SSC_RD, 0);
+	omap_set_gpio_direction(A_LCD_SSC_SD, 0);
+	omap_set_gpio_direction(_A_LCD_RESET, 0);
+	omap_set_gpio_direction(_A_LCD_SSC_CS, 0);
+	omap_set_gpio_direction(_A_LCD_SSC_A0, 0);
+
+	/* set GPIO data */
+	omap_set_gpio_dataout(A_LCD_SSC_RD, 1);
+	omap_set_gpio_dataout(A_LCD_SSC_SD, 0);
+	omap_set_gpio_dataout(_A_LCD_RESET, 0);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_A0, 1);
 }
 
-static void DysplayInit(void)
+static void display_init(void)
 {
-//	unsigned short	w;
-	int	i;
+	int i;
 
-	omap_cfg_reg( MCBSP3_CLKX );
+	omap_cfg_reg(MCBSP3_CLKX);
 
-//	w = omap_readl(FUNC_MUX_CTRL_0);
-//	w |= 0x40; w &= ~8;
-//	omap_writel( w, FUNC_MUX_CTRL_0);
-
-//	mdelay(2); //small pause
-//	omap_writel( omap_readl(FUNC_MUX_CTRL_1) | 0x80000000, FUNC_MUX_CTRL_1 );
 	mdelay(2);
-	SetupGPIO();
+	setup_GPIO();
 	mdelay(2);
-// reset LCD
-	omap_set_gpio_dataout( A_LCD_SSC_SD, 1 );
-//	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	epson_sendbyte( 0, 0x25 );
 
-	omap_set_gpio_dataout( _A_LCD_RESET, 0 );
+	/* reset LCD */
+	omap_set_gpio_dataout(A_LCD_SSC_SD, 1);
+	epson_sendbyte(0, 0x25);
+
+	omap_set_gpio_dataout(_A_LCD_RESET, 0);
 	mdelay(10);
-	omap_set_gpio_dataout( _A_LCD_RESET, 1 );
+	omap_set_gpio_dataout(_A_LCD_RESET, 1);
 
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
 	mdelay(2);
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 1
-	epson_sendbyte( 0, 0xCA );
-	for( i = 0; i < 10; i++)
-		epson_sendbyte( 1, INIT_1[i] );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 2
-	epson_sendbyte( 0, 0xCB );
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD, phase 1 */
+	epson_sendbyte(0, 0xCA);
+	for (i = 0; i < 10; i++)
+		epson_sendbyte(1, INIT_1[i]);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 2 */
+	epson_sendbyte(0, 0xCB);
 	for( i = 0; i < 125; i++)
-		epson_sendbyte( 1, INIT_2[i] );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 2
-	epson_sendbyte( 0, 0xCC );
+		epson_sendbyte(1, INIT_2[i]);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 2a */
+	epson_sendbyte(0, 0xCC);
 	for( i = 0; i < 14; i++)
-		epson_sendbyte( 1, INIT_3[i] );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 3
-	epson_sendbyte( 0, 0xBC );
-	epson_sendbyte( 1, 0x08 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 4
-	epson_sendbyte( 0, 0x07 );
-	epson_sendbyte( 1, 0x05 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 5
-	epson_sendbyte( 0, 0x94 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 6
-	epson_sendbyte( 0, 0xC6 );
-	epson_sendbyte( 1, 0x80 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	mdelay(100); // there was 1000
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 7
-	epson_sendbyte( 0, 0x16 );
-	epson_sendbyte( 1, 0x02 );
-	epson_sendbyte( 1, 0x00 );
-	epson_sendbyte( 1, 0xB1 );
-	epson_sendbyte( 1, 0x00 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 8
-	epson_sendbyte( 0, 0x76 );
-	epson_sendbyte( 1, 0x00 );
-	epson_sendbyte( 1, 0x00 );
-	epson_sendbyte( 1, 0xDB );
-	epson_sendbyte( 1, 0x00 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );
-// init LCD phase 9
-	epson_sendbyte( 0, 0xAF );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );
+		epson_sendbyte(1, INIT_3[i]);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 3 */
+	epson_sendbyte(0, 0xBC);
+	epson_sendbyte(1, 0x08);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 4 */
+	epson_sendbyte(0, 0x07);
+	epson_sendbyte(1, 0x05);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 5 */
+	epson_sendbyte(0, 0x94);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 6 */
+	epson_sendbyte(0, 0xC6);
+	epson_sendbyte(1, 0x80);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	mdelay(100); /* used to be 1000 */
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 7 */
+	epson_sendbyte(0, 0x16);
+	epson_sendbyte(1, 0x02);
+	epson_sendbyte(1, 0x00);
+	epson_sendbyte(1, 0xB1);
+	epson_sendbyte(1, 0x00);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 8 */
+	epson_sendbyte(0, 0x76);
+	epson_sendbyte(1, 0x00);
+	epson_sendbyte(1, 0x00);
+	epson_sendbyte(1, 0xDB);
+	epson_sendbyte(1, 0x00);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
+
+	/* init LCD phase 9 */
+	epson_sendbyte(0, 0xAF);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
 }
 
 static int sx1_panel_init(struct omapfb_device *fbdev)
@@ -233,43 +222,35 @@ static void sx1_panel_cleanup(void)
 
 static void sx1_panel_disable(void)
 {
-
 	printk(KERN_INFO "SX1: LCD panel disable\n");
-	sx1_setmmipower( 0 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );// TK1DisplayController__UnSelect
+	sx1_setmmipower(0);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
 
-	epson_sendbyte( 0, 0x25 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );// TK1DisplayController__Select
+	epson_sendbyte(0, 0x25);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
 
-	epson_sendbyte( 0, 0xAE );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );// TK1DisplayController__UnSelect
+	epson_sendbyte(0, 0xAE);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
 	mdelay(100);
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 0 );// TK1DisplayController__Select
-
-	epson_sendbyte( 0, 0x95 );
-	omap_set_gpio_dataout( _A_LCD_SSC_CS, 1 );// TK1DisplayController__UnSelect
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 0);
 
+	epson_sendbyte(0, 0x95);
+	omap_set_gpio_dataout(_A_LCD_SSC_CS, 1);
 }
 
 static int sx1_panel_enable(void)
 {
-//	sx1_panel_disable(); // try to disable panel first, if we boot from Symbian
+#if 0
+	sx1_panel_disable(); /* try to disable panel first, if we boot from Symbian */
+#endif
 	
 	printk(KERN_INFO "lcd_sx1: LCD panel enable\n");
-	InitSystem();
-	DysplayInit();
-
-	sx1_setmmipower( 1 );
-	sx1_setbacklight( 0x18 );
-	sx1_setkeylight ( 0x06 );
-
-/*	PRNERR("LCD-CONTROL = %x\n",omap_readl(0xFFFEC000));
-	PRNERR("LCD-Timing0 = %x\n",omap_readl(0xFFFEC004));
-	PRNERR("LCD-Timing1 = %x\n",omap_readl(0xFFFEC008));
-	PRNERR("LCD-Timing2 = %x\n",omap_readl(0xFFFEC00C));
-	PRNERR("LCD-Status  = %x\n",omap_readl(0xFFFEC010));
-	PRNERR("LCD-subpanl = %x\n",omap_readl(0xFFFEC014));*/
+	init_system();
+	display_init();
 
+	sx1_setmmipower(1);
+	sx1_setbacklight(0x18);
+	sx1_setkeylight (0x06);
 	return 0;
 }
 
@@ -284,7 +265,6 @@ struct lcd_panel sx1_panel = {
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
 			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_INV_PIX_CLOCK |
 			  OMAP_LCDC_INV_OUTPUT_EN,
-//	.signals    = 0x0F,
 
 	.x_res 		= 176,
 	.y_res 		= 220,
@@ -296,7 +276,6 @@ struct lcd_panel sx1_panel = {
 	.vsw 		= 2,
 	.vfp 		= 1,
 	.vbp 		= 1,
-//	.pcd 		= 3,
 	.pixel_clock	= 1500,
 
 	.init    = sx1_panel_init,
 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
