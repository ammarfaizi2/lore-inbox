Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270072AbTGSNHy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270073AbTGSNHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 09:07:54 -0400
Received: from dsl-082-082-136-038.arcor-ip.net ([82.82.136.38]:13060 "HELO
	obi.mine.nu") by vger.kernel.org with SMTP id S270072AbTGSNHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 09:07:51 -0400
Subject: [PATCH] 1/3 Support mpc823 board dbox2 (2.4.22-pre6)
From: Andreas Oberritter <obi@saftware.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-3AQvQY1tjI0NT4Awcqs9"
Message-Id: <1058620870.585.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 19 Jul 2003 15:21:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3AQvQY1tjI0NT4Awcqs9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

This patch adds basic support for the dbox2, a dvb receiver (set top
box). It has been tested by a large user base and is stable since 2.4.2.
The following two patches rely on it.

Regards,
Andreas

--=-3AQvQY1tjI0NT4Awcqs9
Content-Disposition: attachment; filename=linux-2.4.22-pre6-dbox2-board.diff
Content-Type: text/x-patch; name=linux-2.4.22-pre6-dbox2-board.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.4.22-pre6/arch/ppc/boot/simple/embed_config.c linux-2.4.22-pre6-dbox2/arch/ppc/boot/simple/embed_config.c
--- linux-2.4.22-pre6/arch/ppc/boot/simple/embed_config.c	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4.22-pre6-dbox2/arch/ppc/boot/simple/embed_config.c	2003-07-15 09:16:34.000000000 +0200
@@ -755,3 +755,12 @@
 }
 #endif
 
+#ifdef CONFIG_DBOX2
+/* dbox2
+ * doesn't do anything right now */
+void
+embed_config(bd_t **bdp)
+{
+}
+#endif
+
diff -Naur linux-2.4.22-pre6/arch/ppc/config.in linux-2.4.22-pre6-dbox2/arch/ppc/config.in
--- linux-2.4.22-pre6/arch/ppc/config.in	2003-07-15 09:20:53.000000000 +0200
+++ linux-2.4.22-pre6-dbox2/arch/ppc/config.in	2003-07-15 09:16:34.000000000 +0200
@@ -75,6 +75,7 @@
 	 RPX-Classic	CONFIG_RPXCLASSIC	\
 	 BSE-IP		CONFIG_BSEIP		\
 	 FADS		CONFIG_FADS		\
+ 	 DBOX2		CONFIG_DBOX2		\
  	 TQM823L	CONFIG_TQM823L		\
  	 TQM850L	CONFIG_TQM850L		\
  	 TQM855L	CONFIG_TQM855L		\
diff -Naur linux-2.4.22-pre6/arch/ppc/platforms/dbox2.h linux-2.4.22-pre6-dbox2/arch/ppc/platforms/dbox2.h
--- linux-2.4.22-pre6/arch/ppc/platforms/dbox2.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.22-pre6-dbox2/arch/ppc/platforms/dbox2.h	2003-07-15 09:16:34.000000000 +0200
@@ -0,0 +1,24 @@
+/*
+ * D-BOX2 board specific definitions
+ * 
+ * Copyright (c) 2001-2002 Florian Schirmer (jolt@tuxbox.org)
+ */
+
+#ifndef __MACH_DBOX2_H
+#define __MACH_DBOX2_H
+
+#include <linux/config.h>
+ 
+#include <asm/ppcboot.h>
+
+#define	DBOX2_IMMR_BASE	0xFF000000	/* phys. addr of IMMR */
+#define	DBOX2_IMAP_SIZE	(64 * 1024)	/* size of mapped area */
+
+#define	IMAP_ADDR	DBOX2_IMMR_BASE	/* physical base address of IMMR area */
+#define IMAP_SIZE	DBOX2_IMAP_SIZE	/* mapped size of IMMR area */
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+#endif	/* __MACH_DBOX2_H */
diff -Naur linux-2.4.22-pre6/include/asm-ppc/commproc.h linux-2.4.22-pre6-dbox2/include/asm-ppc/commproc.h
--- linux-2.4.22-pre6/include/asm-ppc/commproc.h	2003-06-13 16:51:38.000000000 +0200
+++ linux-2.4.22-pre6-dbox2/include/asm-ppc/commproc.h	2003-07-15 09:16:34.000000000 +0200
@@ -466,6 +466,23 @@
 #define SICR_ENET_CLKRT	((uint)0x0000003d)
 #endif	/* CONFIG_RPXCLASSIC */
 
+/***  D-BOX2  ***********************************************/
+
+#ifdef CONFIG_DBOX2
+
+#define PA_ENET_RXD	((ushort)0x0004)
+#define PA_ENET_TXD	((ushort)0x0008)
+#define PA_ENET_RCLK	((ushort)0x0200)
+#define PA_ENET_TCLK	((ushort)0x0800)
+
+#define PC_ENET_TENA	((ushort)0x0002)
+#define PC_ENET_CLSN	((ushort)0x0040)
+#define PC_ENET_RENA	((ushort)0x0080)
+
+#define SICR_ENET_MASK	((uint)0x0000ff00)
+#define SICR_ENET_CLKRT	((uint)0x00003d00)
+#endif	/* CONFIG_DBOX2 */
+
 /***  TQM823L, TQM850L  ***********************************************/
 
 #if defined(CONFIG_TQM823L) || defined(CONFIG_TQM850L)
diff -Naur linux-2.4.22-pre6/include/asm-ppc/mpc8xx.h linux-2.4.22-pre6-dbox2/include/asm-ppc/mpc8xx.h
--- linux-2.4.22-pre6/include/asm-ppc/mpc8xx.h	2003-06-13 16:51:38.000000000 +0200
+++ linux-2.4.22-pre6-dbox2/include/asm-ppc/mpc8xx.h	2003-07-15 09:16:34.000000000 +0200
@@ -32,6 +32,10 @@
 #include <platforms/rpxclassic.h>
 #endif
 
+#ifdef CONFIG_DBOX2
+#include <platforms/dbox2.h>
+#endif
+
 #if defined(CONFIG_TQM8xxL)
 #include <platforms/tqm8xx.h>
 #endif

--=-3AQvQY1tjI0NT4Awcqs9--

