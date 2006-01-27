Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWA0WwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWA0WwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWA0WwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:52:09 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:48545 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422651AbWA0WwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:52:00 -0500
Date: Sat, 28 Jan 2006 00:51:59 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/11] sh: unknown mach-type updates.
Message-ID: <20060127225159.GF30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial cleanup of the unknown machine type for some of the
recent machvec changes.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/boards/unknown/Makefile |    2 +
 arch/sh/boards/unknown/io.c     |   46 ---------------------------
 arch/sh/boards/unknown/mach.c   |   67 ---------------------------------------
 arch/sh/boards/unknown/setup.c  |   12 ++++++-
 arch/sh/kernel/setup.c          |   13 ++------
 5 files changed, 16 insertions(+), 124 deletions(-)
 delete mode 100644 arch/sh/boards/unknown/io.c
 delete mode 100644 arch/sh/boards/unknown/mach.c

eaa4999ab033f852a67796317073a2d14f31c04d
diff --git a/arch/sh/boards/unknown/Makefile b/arch/sh/boards/unknown/Makefile
index cffc210..7d18f40 100644
--- a/arch/sh/boards/unknown/Makefile
+++ b/arch/sh/boards/unknown/Makefile
@@ -2,5 +2,5 @@
 # Makefile for unknown SH boards 
 #
 
-obj-y	 := mach.o io.o setup.o
+obj-y	 := setup.o
 
diff --git a/arch/sh/boards/unknown/io.c b/arch/sh/boards/unknown/io.c
deleted file mode 100644
index 8f3f172..0000000
--- a/arch/sh/boards/unknown/io.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * linux/arch/sh/kernel/io_unknown.c
- *
- * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * I/O routine for unknown hardware.
- */
-
-static unsigned int unknown_handler(void)
-{
-	return 0;
-}
-
-#define UNKNOWN_ALIAS(fn) \
-	void unknown_##fn(void) __attribute__ ((alias ("unknown_handler")));
-
-UNKNOWN_ALIAS(inb)
-UNKNOWN_ALIAS(inw)
-UNKNOWN_ALIAS(inl)
-UNKNOWN_ALIAS(outb)
-UNKNOWN_ALIAS(outw)
-UNKNOWN_ALIAS(outl)
-UNKNOWN_ALIAS(inb_p)
-UNKNOWN_ALIAS(inw_p)
-UNKNOWN_ALIAS(inl_p)
-UNKNOWN_ALIAS(outb_p)
-UNKNOWN_ALIAS(outw_p)
-UNKNOWN_ALIAS(outl_p)
-UNKNOWN_ALIAS(insb)
-UNKNOWN_ALIAS(insw)
-UNKNOWN_ALIAS(insl)
-UNKNOWN_ALIAS(outsb)
-UNKNOWN_ALIAS(outsw)
-UNKNOWN_ALIAS(outsl)
-UNKNOWN_ALIAS(readb)
-UNKNOWN_ALIAS(readw)
-UNKNOWN_ALIAS(readl)
-UNKNOWN_ALIAS(writeb)
-UNKNOWN_ALIAS(writew)
-UNKNOWN_ALIAS(writel)
-UNKNOWN_ALIAS(isa_port2addr)
-UNKNOWN_ALIAS(ioremap)
-UNKNOWN_ALIAS(iounmap)
diff --git a/arch/sh/boards/unknown/mach.c b/arch/sh/boards/unknown/mach.c
deleted file mode 100644
index ad0bcc6..0000000
--- a/arch/sh/boards/unknown/mach.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * linux/arch/sh/kernel/mach_unknown.c
- *
- * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * Machine specific code for an unknown machine (internal peripherials only)
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-
-#include <asm/machvec.h>
-#include <asm/machvec_init.h>
-
-#include <asm/io_unknown.h>
-
-#include <asm/rtc.h>
-/*
- * The Machine Vector
- */
-
-struct sh_machine_vector mv_unknown __initmv = {
-#if defined(CONFIG_CPU_SH4)
-	.mv_nr_irqs		= 48,
-#elif defined(CONFIG_CPU_SUBTYPE_SH7708)
-	.mv_nr_irqs		= 32,
-#elif defined(CONFIG_CPU_SUBTYPE_SH7709)
-	.mv_nr_irqs		= 61,
-#endif
-
-	.mv_inb			= unknown_inb,
-	.mv_inw			= unknown_inw,
-	.mv_inl			= unknown_inl,
-	.mv_outb		= unknown_outb,
-	.mv_outw		= unknown_outw,
-	.mv_outl		= unknown_outl,
-
-	.mv_inb_p		= unknown_inb_p,
-	.mv_inw_p		= unknown_inw_p,
-	.mv_inl_p		= unknown_inl_p,
-	.mv_outb_p		= unknown_outb_p,
-	.mv_outw_p		= unknown_outw_p,
-	.mv_outl_p		= unknown_outl_p,
-
-	.mv_insb		= unknown_insb,
-	.mv_insw		= unknown_insw,
-	.mv_insl		= unknown_insl,
-	.mv_outsb		= unknown_outsb,
-	.mv_outsw		= unknown_outsw,
-	.mv_outsl		= unknown_outsl,
-
-	.mv_readb		= unknown_readb,
-	.mv_readw		= unknown_readw,
-	.mv_readl		= unknown_readl,
-	.mv_writeb		= unknown_writeb,
-	.mv_writew		= unknown_writew,
-	.mv_writel		= unknown_writel,
-
-	.mv_ioremap		= unknown_ioremap,
-	.mv_iounmap		= unknown_iounmap,
-
-	.mv_isa_port2addr	= unknown_isa_port2addr,
-};
-ALIAS_MV(unknown)
diff --git a/arch/sh/boards/unknown/setup.c b/arch/sh/boards/unknown/setup.c
index 7d772a6..02e84f0 100644
--- a/arch/sh/boards/unknown/setup.c
+++ b/arch/sh/boards/unknown/setup.c
@@ -7,10 +7,20 @@
  * License.  See linux/COPYING for more information.
  *
  * Setup code for an unknown machine (internal peripherials only)
+ *
+ * This is the simplest of all boards, and serves only as a quick and dirty
+ * method to start debugging a new board during bring-up until proper board
+ * setup code is written.
  */
-
 #include <linux/config.h>
 #include <linux/init.h>
+#include <asm/machvec.h>
+#include <asm/irq.h>
+
+struct sh_machine_vector mv_unknown __initmv = {
+	.mv_nr_irqs		= NR_IRQS,
+};
+ALIAS_MV(unknown)
 
 const char *get_system_type(void)
 {
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 0f1fbe7..a067a34 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -186,7 +186,7 @@ static inline void parse_cmdline (char *
 
 static int __init sh_mv_setup(char **cmdline_p)
 {
-#if defined(CONFIG_SH_UNKNOWN)
+#ifdef CONFIG_SH_UNKNOWN
 	extern struct sh_machine_vector mv_unknown;
 #endif
 	struct sh_machine_vector *mv = NULL;
@@ -196,7 +196,7 @@ static int __init sh_mv_setup(char **cmd
 
 	parse_cmdline(cmdline_p, mv_name, &mv, &mv_io_base, &mv_mmio_enable);
 
-#ifdef CONFIG_SH_GENERIC
+#ifdef CONFIG_SH_UNKNOWN
 	if (mv == NULL) {
 		mv = &mv_unknown;
 		if (*mv_name != '\0') {
@@ -206,9 +206,6 @@ static int __init sh_mv_setup(char **cmd
 	}
 	sh_mv = *mv;
 #endif
-#ifdef CONFIG_SH_UNKNOWN
-	sh_mv = mv_unknown;
-#endif
 
 	/*
 	 * Manually walk the vec, fill in anything that the board hasn't yet
@@ -231,10 +228,8 @@ static int __init sh_mv_setup(char **cmd
 	mv_set(readb);	mv_set(readw);	mv_set(readl);
 	mv_set(writeb);	mv_set(writew);	mv_set(writel);
 
-	mv_set(ioremap);
-	mv_set(iounmap);
-
-	mv_set(isa_port2addr);
+	mv_set(ioport_map);
+	mv_set(ioport_unmap);
 	mv_set(irq_demux);
 
 #ifdef CONFIG_SH_UNKNOWN
