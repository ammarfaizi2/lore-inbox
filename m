Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbULKQ2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbULKQ2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbULKQ2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:28:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17926 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261963AbULKQ2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:28:15 -0500
Date: Sat, 11 Dec 2004 17:28:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] proposed FB_MATROX_G Kconfig changes
Message-ID: <20041211162805.GS22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current Kconfig entries for the Matrox G cards are wuite confusing:

config FB_MATROX_G450
        bool "G100/G200/G400/G450/G550 support"
        depends on FB_MATROX

config FB_MATROX_G100A
        bool "G100/G200/G400 support"
        depends on FB_MATROX && !FB_MATROX_G450


The patch below contains:
- remove FB_MATROX_G100{,A} and rename FB_MATROX_G to FB_MATROX_G450
  (FB_MATROX_G450 included support from the G100 to the G550, so
   I don't see any non-historic reason why to call it G450)
- small update for the FB_MATROX_G Kconfig text


The disadvantage of this patch is, that you can no longer select support 
only for the G100-G400 without supporting the G450 and G550. But 
compared with the current confusing Kconfig setup, I don't think that's 
a big issue.


diffstat output:
 drivers/video/Kconfig                   |   32 ++++--------------------
 drivers/video/matrox/Makefile           |    3 --
 drivers/video/matrox/matroxfb_DAC1064.c |   25 +++++++-----------
 drivers/video/matrox/matroxfb_DAC1064.h |    2 -
 drivers/video/matrox/matroxfb_base.c    |    6 ++--
 drivers/video/matrox/matroxfb_base.h    |    2 -
 drivers/video/matrox/matroxfb_g450.h    |    2 -
 7 files changed, 23 insertions(+), 49 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/drivers/video/Kconfig.old	2004-12-11 17:01:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/Kconfig	2004-12-11 17:02:32.000000000 +0100
@@ -574,7 +574,7 @@
 	  packed pixel and 32 bpp packed pixel. You can also use font widths
 	  different from 8.
 
-config FB_MATROX_G450
+config FB_MATROX_G
 	bool "G100/G200/G400/G450/G550 support"
 	depends on FB_MATROX
 	---help---
@@ -585,10 +585,10 @@
 	  different from 8.
 
 	  If you need support for G400 secondary head, you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section, and then to "Matrox I2C support" and "G400 second head
-	  support" here in the framebuffer section. G450/G550 secondary head
-	  and digital output are supported without additional modules.
+	  "I2C support" in the character devices section, and then to
+	  "Matrox I2C support" and "G400 second head support" here in the
+	  framebuffer section. G450/G550 secondary head and digital output
+	  are supported without additional modules.
 
 	  The driver starts in monitor mode. You must use the matroxset tool 
 	  (available at <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to 
@@ -605,26 +605,6 @@
 	  G450/G550 hardware can display TV picture only from secondary CRTC,
 	  and it performs no scaling, so picture must have 525 or 625 lines.
 
-config FB_MATROX_G100A
-	bool "G100/G200/G400 support"
-	depends on FB_MATROX && !FB_MATROX_G450
-	---help---
-	  Say Y here if you have a Matrox G100, G200 or G400 based
-	  video card. If you select "Advanced lowlevel driver options", you
-	  should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp packed
-	  pixel and 32 bpp packed pixel. You can also use font widths
-	  different from 8.
-
-	  If you need support for G400 secondary head, you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section, and then to "Matrox I2C support" and "G400 second head
-	  support" here in the framebuffer section.
-
-config FB_MATROX_G100
-	bool
-	depends on FB_MATROX && (FB_MATROX_G450 || FB_MATROX_G100A)
-	default y
-
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
 	depends on FB_MATROX && I2C
@@ -644,7 +624,7 @@
 
 config FB_MATROX_MAVEN
 	tristate "G400 second head support"
-	depends on FB_MATROX_G100 && FB_MATROX_I2C
+	depends on FB_MATROX_G && FB_MATROX_I2C
 	---help---
 	  WARNING !!! This support does not work with G450 !!!
 
--- linux-2.6.10-rc2-mm4-full/drivers/video/matrox/Makefile.old	2004-12-11 16:54:44.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/matrox/Makefile	2004-12-11 17:26:44.000000000 +0100
@@ -4,8 +4,7 @@
 
 # Each configuration option enables a list of files.
 
-my-obj-$(CONFIG_FB_MATROX_G100)	  += g450_pll.o
-my-obj-$(CONFIG_FB_MATROX_G450)   += matroxfb_g450.o matroxfb_crtc2.o
+my-obj-$(CONFIG_FB_MATROX_G)      += g450_pll.o matroxfb_g450.o matroxfb_crtc2.o
 
 obj-$(CONFIG_FB_MATROX)           += matroxfb_base.o matroxfb_accel.o matroxfb_DAC1064.o matroxfb_Ti3026.o matroxfb_misc.o $(my-obj-y)
 obj-$(CONFIG_FB_MATROX_I2C)       += i2c-matroxfb.o
--- linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_base.h.old	2004-12-11 16:56:39.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_base.h	2004-12-11 16:56:50.000000000 +0100
@@ -127,7 +127,7 @@
 
 /* G-series and Mystique have (almost) same DAC */
 #undef NEED_DAC1064
-#if defined(CONFIG_FB_MATROX_MYSTIQUE) || defined(CONFIG_FB_MATROX_G100)
+#if defined(CONFIG_FB_MATROX_MYSTIQUE) || defined(CONFIG_FB_MATROX_G)
 #define NEED_DAC1064 1
 #endif
 
--- linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_base.c.old	2004-12-11 16:57:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_base.c	2004-12-11 17:00:23.000000000 +0100
@@ -1346,7 +1346,7 @@
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
 static struct video_board vbMystique		= {0x0800000, 0x0800000, FB_ACCEL_MATROX_MGA1064SG,	&matrox_mystique};
 #endif	/* CONFIG_FB_MATROX_MYSTIQUE */
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 static struct video_board vbG100		= {0x0800000, 0x0800000, FB_ACCEL_MATROX_MGAG100,	&matrox_G100};
 static struct video_board vbG200		= {0x1000000, 0x1000000, FB_ACCEL_MATROX_MGAG200,	&matrox_G100};
 #ifdef CONFIG_FB_MATROX_32MB
@@ -1430,7 +1430,7 @@
 		&vbMystique,
 		"Mystique 220 (PCI)"},
 #endif
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_MM,	0xFF,
 		0,			0,
 		DEVF_G100,
@@ -2105,7 +2105,7 @@
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 #endif
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_MM,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_AGP,
--- linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_DAC1064.h.old	2004-12-11 16:57:25.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_DAC1064.h	2004-12-11 16:58:38.000000000 +0100
@@ -9,7 +9,7 @@
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
 extern struct matrox_switch matrox_mystique;
 #endif
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 extern struct matrox_switch matrox_G100;
 #endif
 #ifdef NEED_DAC1064
--- linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_DAC1064.c.old	2004-12-11 16:55:39.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_DAC1064.c	2004-12-11 16:59:58.000000000 +0100
@@ -155,7 +155,7 @@
 	hw->MXoptionReg = mx;
 }
 
-#ifdef CONFIG_FB_MATROX_G450
+#ifdef CONFIG_FB_MATROX_G
 static void g450_set_plls(WPMINFO2) {
 	u_int32_t c2_ctl;
 	unsigned int pxc;
@@ -253,7 +253,7 @@
 	hw->DACreg[POS1064_XMISCCTRL] &= M1064_XMISCCTRL_DAC_WIDTHMASK;
 	hw->DACreg[POS1064_XMISCCTRL] |= M1064_XMISCCTRL_LUT_EN;
 	hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_PLL;
-#ifdef CONFIG_FB_MATROX_G450
+#ifdef CONFIG_FB_MATROX_G
 	if (ACCESS_FBINFO(devflags.g450dac)) {
 		hw->DACreg[POS1064_XPWRCTRL] = 0x1F;	/* powerup everything */
 		hw->DACreg[POS1064_XOUTPUTCONN] = 0x00;	/* disable outputs */
@@ -498,7 +498,7 @@
 	.compute = m1064_compute,
 };
 
-#ifdef CONFIG_FB_MATROX_G450
+#ifdef CONFIG_FB_MATROX_G
 static int g450_compute(void* out, struct my_timming* m) {
 #define minfo ((struct matrox_fb_info*)out)
 	if (m->mnp < 0) {
@@ -541,7 +541,7 @@
 }
 #endif
 
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 static int MGAG100_init(WPMINFO struct my_timming* m) {
 	struct matrox_hw_state* hw = &ACCESS_FBINFO(hw);
 
@@ -562,7 +562,7 @@
 	if (DAC1064_init_2(PMINFO m)) return 1;
 	return 0;
 }
-#endif	/* G100 */
+#endif	/* G */
 
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
 static void MGA1064_ramdac_init(WPMINFO2) {
@@ -583,7 +583,7 @@
 }
 #endif
 
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 /* BIOS environ */
 static int x7AF4 = 0x10;	/* flags, maybe 0x10 = SDRAM, 0x00 = SGRAM??? */
 				/* G100 wants 0x10, G200 SGRAM does not care... */
@@ -692,8 +692,7 @@
 }
 #endif
 
-#ifdef CONFIG_FB_MATROX_G100
-#ifdef CONFIG_FB_MATROX_G450
+#ifdef CONFIG_FB_MATROX_G
 static void g450_mclk_init(WPMINFO2) {
 	/* switch all clocks to PCI source */
 	pci_write_config_dword(ACCESS_FBINFO(pcidev), PCI_OPTION_REG, ACCESS_FBINFO(hw).MXoptionReg | 4);
@@ -811,10 +810,6 @@
 	
 	return;
 }
-#else
-static inline void g450_preinit(WPMINFO2) {
-}
-#endif
 
 static int MGAG100_preinit(WPMINFO2) {
 	static const int vxres_g100[] = {  512,        640, 768,  800,  832,  960,
@@ -851,7 +846,7 @@
 	ACCESS_FBINFO(capable.plnwt) = ACCESS_FBINFO(devflags.accelerator) == FB_ACCEL_MATROX_MGAG100
 			? ACCESS_FBINFO(devflags.sgram) : 1;
 
-#ifdef CONFIG_FB_MATROX_G450
+#ifdef CONFIG_FB_MATROX_G
 	if (ACCESS_FBINFO(devflags.g450dac)) {
 		ACCESS_FBINFO(outputs[0]).output = &g450out;
 	} else
@@ -1043,7 +1038,7 @@
 }
 #endif
 
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 static void MGAG100_restore(WPMINFO2) {
 	int i;
 	struct matrox_hw_state* hw = &ACCESS_FBINFO(hw);
@@ -1077,7 +1072,7 @@
 EXPORT_SYMBOL(matrox_mystique);
 #endif
 
-#ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G
 struct matrox_switch matrox_G100 = {
 	MGAG100_preinit, MGAG100_reset, MGAG100_init, MGAG100_restore,
 };
--- linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_g450.h.old	2004-12-11 17:00:44.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/video/matrox/matroxfb_g450.h	2004-12-11 17:00:55.000000000 +0100
@@ -3,7 +3,7 @@
 
 #include "matroxfb_base.h"
 
-#ifdef CONFIG_FB_MATROX_G450
+#ifdef CONFIG_FB_MATROX_G
 void matroxfb_g450_connect(WPMINFO2);
 void matroxfb_g450_shutdown(WPMINFO2);
 #else

