Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbSKWXYH>; Sat, 23 Nov 2002 18:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbSKWXYH>; Sat, 23 Nov 2002 18:24:07 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:37900 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S267097AbSKWXYC>;
	Sat, 23 Nov 2002 18:24:02 -0500
Date: Sun, 24 Nov 2002 00:31:03 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com, rob@osinvestor.com
Subject: [PATCH] linux-2.5.49 - Watchdog drivers
Message-ID: <20021124003103.A8544@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Dave,

included the patch for linux-2.5.49 to make the watchdog drivers working again.
Could you apply this to the current tree please?

PS: the patch is also ftp-able at: ftp://medelec.uia.ac.be/pub/linux/kernel-patches/wd-2.5.49-patch

Greetings,
Wim.

diff -urN linux-2.5.49/drivers/char/Makefile linux-2.5.49-watchdog-patch/drivers/char/Makefile
--- linux-2.5.49/drivers/char/Makefile	Fri Nov 22 22:41:09 2002
+++ linux-2.5.49-watchdog-patch/drivers/char/Makefile	Sun Nov 24 00:00:48 2002
@@ -77,12 +77,11 @@
 obj-$(CONFIG_NWFLASH) += nwflash.o
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 
-obj-$(CONFIG_WATCHDOGS)	+= watchdog/
+obj-$(CONFIG_WATCHDOG)	+= watchdog/
 obj-$(CONFIG_MWAVE) += mwave/
 obj-$(CONFIG_AGP) += agp/
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
-
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
diff -urN linux-2.5.49/drivers/char/i810-tco.h linux-2.5.49-watchdog-patch/drivers/char/i810-tco.h
--- linux-2.5.49/drivers/char/i810-tco.h	Fri Nov 22 22:40:52 2002
+++ linux-2.5.49-watchdog-patch/drivers/char/i810-tco.h	Thu Jan  1 01:00:00 1970
@@ -1,42 +0,0 @@
-/*
- *	i810-tco 0.05:	TCO timer driver for i8xx chipsets
- *
- *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
- *				http://www.kernelconcepts.de
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *	
- *	Neither kernel concepts nor Nils Faerber admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
- *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
- *				developed for
- *                              Jentro AG, Haar/Munich (Germany)
- *
- *	TCO timer driver for i8xx chipsets
- *	based on softdog.c by Alan Cox <alan@redhat.com>
- *
- *	For history and the complete list of supported I/O Controller Hub's
- *	see i810-tco.c
- */
-
-
-/*
- * Some address definitions for the i810 TCO
- */
-
-#define	TCOBASE		ACPIBASE + 0x60	/* TCO base address		*/
-#define TCO1_RLD	TCOBASE + 0x00	/* TCO Timer Reload and Current Value */
-#define TCO1_TMR	TCOBASE + 0x01	/* TCO Timer Initial Value	*/
-#define	TCO1_DAT_IN	TCOBASE + 0x02	/* TCO Data In Register		*/
-#define	TCO1_DAT_OUT	TCOBASE + 0x03	/* TCO Data Out Register	*/
-#define	TCO1_STS	TCOBASE + 0x04	/* TCO1 Status Register		*/
-#define	TCO2_STS	TCOBASE + 0x06	/* TCO2 Status Register		*/
-#define TCO1_CNT	TCOBASE + 0x08	/* TCO1 Control Register	*/
-#define TCO2_CNT	TCOBASE + 0x0a	/* TCO2 Control Register	*/
-
-#define	SMI_EN		ACPIBASE + 0x30	/* SMI Control and Enable Register */
diff -urN linux-2.5.49/drivers/char/watchdog/i810-tco.h linux-2.5.49-watchdog-patch/drivers/char/watchdog/i810-tco.h
--- linux-2.5.49/drivers/char/watchdog/i810-tco.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.49-watchdog-patch/drivers/char/watchdog/i810-tco.h	Sun Nov 24 00:23:52 2002
@@ -0,0 +1,42 @@
+/*
+ *	i810-tco 0.05:	TCO timer driver for i8xx chipsets
+ *
+ *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
+ *				http://www.kernelconcepts.de
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither kernel concepts nor Nils Faerber admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
+ *
+ *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
+ *				developed for
+ *                              Jentro AG, Haar/Munich (Germany)
+ *
+ *	TCO timer driver for i8xx chipsets
+ *	based on softdog.c by Alan Cox <alan@redhat.com>
+ *
+ *	For history and the complete list of supported I/O Controller Hub's
+ *	see i810-tco.c
+ */
+
+
+/*
+ * Some address definitions for the i810 TCO
+ */
+
+#define	TCOBASE		ACPIBASE + 0x60	/* TCO base address		*/
+#define TCO1_RLD	TCOBASE + 0x00	/* TCO Timer Reload and Current Value */
+#define TCO1_TMR	TCOBASE + 0x01	/* TCO Timer Initial Value	*/
+#define	TCO1_DAT_IN	TCOBASE + 0x02	/* TCO Data In Register		*/
+#define	TCO1_DAT_OUT	TCOBASE + 0x03	/* TCO Data Out Register	*/
+#define	TCO1_STS	TCOBASE + 0x04	/* TCO1 Status Register		*/
+#define	TCO2_STS	TCOBASE + 0x06	/* TCO2 Status Register		*/
+#define TCO1_CNT	TCOBASE + 0x08	/* TCO1 Control Register	*/
+#define TCO2_CNT	TCOBASE + 0x0a	/* TCO2 Control Register	*/
+
+#define	SMI_EN		ACPIBASE + 0x30	/* SMI Control and Enable Register */
diff -urN linux-2.5.49/drivers/char/watchdog/wd501p.h linux-2.5.49-watchdog-patch/drivers/char/watchdog/wd501p.h
--- linux-2.5.49/drivers/char/watchdog/wd501p.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.49-watchdog-patch/drivers/char/watchdog/wd501p.h	Sun Nov 24 00:24:08 2002
@@ -0,0 +1,91 @@
+/*
+ *	Industrial Computer Source WDT500/501 driver for Linux 1.3.x
+ *
+ *	(c) Copyright 1995	CymruNET Ltd
+ *				Innovation Centre
+ *				Singleton Park
+ *				Swansea
+ *				Wales
+ *				UK
+ *				SA2 8PP
+ *
+ *	http://www.cymru.net
+ *
+ *	This driver is provided under the GNU General Public License, incorporated
+ *	herein by reference. The driver is provided without warranty or
+ *	support.
+ *
+ *	Release 0.04.
+ *
+ */
+
+#include <linux/config.h>
+
+#define WDT_COUNT0		(io+0)
+#define WDT_COUNT1		(io+1)
+#define WDT_COUNT2		(io+2)
+#define WDT_CR			(io+3)
+#define WDT_SR			(io+4)	/* Start buzzer on PCI write */
+#define WDT_RT			(io+5)	/* Stop buzzer on PCI write */
+#define WDT_BUZZER		(io+6)	/* PCI only: rd=disable, wr=enable */
+#define WDT_DC			(io+7)
+
+/* The following are only on the PCI card, they're outside of I/O space on
+ * the ISA card: */
+#define WDT_CLOCK		(io+12)	/* COUNT2: rd=16.67MHz, wr=2.0833MHz */
+/* inverted opto isolated reset output: */
+#define WDT_OPTONOTRST		(io+13)	/* wr=enable, rd=disable */
+/* opto isolated reset output: */
+#define WDT_OPTORST		(io+14)	/* wr=enable, rd=disable */
+/* programmable outputs: */
+#define WDT_PROGOUT		(io+15)	/* wr=enable, rd=disable */
+
+#define WDC_SR_WCCR		1	/* Active low */
+#define WDC_SR_TGOOD		2
+#define WDC_SR_ISOI0		4
+#define WDC_SR_ISII1		8
+#define WDC_SR_FANGOOD		16
+#define WDC_SR_PSUOVER		32	/* Active low */
+#define WDC_SR_PSUUNDR		64	/* Active low */
+#define WDC_SR_IRQ		128	/* Active low */
+
+#ifndef WDT_IS_PCI
+
+/*
+ *	Feature Map 1 is the active high inputs not supported on your card.
+ *	Feature Map 2 is the active low inputs not supported on your card.
+ */
+
+#ifdef CONFIG_WDT_501		/* Full board */
+
+#ifdef CONFIG_WDT501_FAN	/* Full board, Fan has no tachometer */
+#define FEATUREMAP1		0
+#define WDT_OPTION_MASK		(WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT)
+#else
+#define FEATUREMAP1		WDC_SR_FANGOOD
+#define WDT_OPTION_MASK		(WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER|WDIOF_EXTERN1|WDIOF_EXTERN2)
+#endif
+
+#define FEATUREMAP2		0
+#endif
+
+#ifndef CONFIG_WDT_501
+#define CONFIG_WDT_500
+#endif
+
+#ifdef CONFIG_WDT_500		/* Minimal board */
+#define FEATUREMAP1		(WDC_SR_TGOOD|WDC_SR_FANGOOD)
+#define FEATUREMAP2		(WDC_SR_PSUOVER|WDC_SR_PSUUNDR)
+#define WDT_OPTION_MASK		(WDIOF_OVERHEAT)
+#endif
+
+#else
+
+#define FEATUREMAP1		(WDC_SR_TGOOD|WDC_SR_FANGOOD)
+#define FEATUREMAP2		(WDC_SR_PSUOVER|WDC_SR_PSUUNDR)
+#define WDT_OPTION_MASK		(WDIOF_OVERHEAT)
+#endif
+
+#ifndef FEATUREMAP1
+#error "Config option not set"
+#endif
diff -urN linux-2.5.49/drivers/char/wd501p.h linux-2.5.49-watchdog-patch/drivers/char/wd501p.h
--- linux-2.5.49/drivers/char/wd501p.h	Fri Nov 22 22:40:13 2002
+++ linux-2.5.49-watchdog-patch/drivers/char/wd501p.h	Thu Jan  1 01:00:00 1970
@@ -1,91 +0,0 @@
-/*
- *	Industrial Computer Source WDT500/501 driver for Linux 1.3.x
- *
- *	(c) Copyright 1995	CymruNET Ltd
- *				Innovation Centre
- *				Singleton Park
- *				Swansea
- *				Wales
- *				UK
- *				SA2 8PP
- *
- *	http://www.cymru.net
- *
- *	This driver is provided under the GNU General Public License, incorporated
- *	herein by reference. The driver is provided without warranty or 
- *	support.
- *
- *	Release 0.04.
- *
- */
-
-#include <linux/config.h>
-
-#define WDT_COUNT0		(io+0)
-#define WDT_COUNT1		(io+1)
-#define WDT_COUNT2		(io+2)
-#define WDT_CR			(io+3)
-#define WDT_SR			(io+4)	/* Start buzzer on PCI write */
-#define WDT_RT			(io+5)	/* Stop buzzer on PCI write */
-#define WDT_BUZZER		(io+6)	/* PCI only: rd=disable, wr=enable */
-#define WDT_DC			(io+7)
-
-/* The following are only on the PCI card, they're outside of I/O space on
- * the ISA card: */
-#define WDT_CLOCK		(io+12)	/* COUNT2: rd=16.67MHz, wr=2.0833MHz */
-/* inverted opto isolated reset output: */
-#define WDT_OPTONOTRST		(io+13)	/* wr=enable, rd=disable */
-/* opto isolated reset output: */
-#define WDT_OPTORST		(io+14)	/* wr=enable, rd=disable */
-/* programmable outputs: */
-#define WDT_PROGOUT		(io+15)	/* wr=enable, rd=disable */
-
-#define WDC_SR_WCCR		1	/* Active low */
-#define WDC_SR_TGOOD		2
-#define WDC_SR_ISOI0		4
-#define WDC_SR_ISII1		8
-#define WDC_SR_FANGOOD		16
-#define WDC_SR_PSUOVER		32	/* Active low */
-#define WDC_SR_PSUUNDR		64	/* Active low */
-#define WDC_SR_IRQ		128	/* Active low */
-
-#ifndef WDT_IS_PCI
-
-/*
- *	Feature Map 1 is the active high inputs not supported on your card.
- *	Feature Map 2 is the active low inputs not supported on your card.
- */
- 
-#ifdef CONFIG_WDT_501		/* Full board */
-
-#ifdef CONFIG_WDT501_FAN	/* Full board, Fan has no tachometer */
-#define FEATUREMAP1		0
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT)
-#else
-#define FEATUREMAP1		WDC_SR_FANGOOD
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER|WDIOF_EXTERN1|WDIOF_EXTERN2)
-#endif
-
-#define FEATUREMAP2		0
-#endif
-
-#ifndef CONFIG_WDT_501
-#define CONFIG_WDT_500
-#endif
-
-#ifdef CONFIG_WDT_500		/* Minimal board */
-#define FEATUREMAP1		(WDC_SR_TGOOD|WDC_SR_FANGOOD)
-#define FEATUREMAP2		(WDC_SR_PSUOVER|WDC_SR_PSUUNDR)
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT)
-#endif
-
-#else
-
-#define FEATUREMAP1		(WDC_SR_TGOOD|WDC_SR_FANGOOD)
-#define FEATUREMAP2		(WDC_SR_PSUOVER|WDC_SR_PSUUNDR)
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT)
-#endif
-
-#ifndef FEATUREMAP1
-#error "Config option not set"
-#endif
