Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263871AbUDVIge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUDVIge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbUDVIg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:36:29 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:19386 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S263183AbUDVIgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:36:21 -0400
Date: Thu, 22 Apr 2004 10:36:20 +0200 (CEST)
Message-Id: <20040422.103620.607961025.rene@rocklinux-consulting.de>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: trini@mvista.com, valentin@rocklinux-consulting.de
Subject: [PATCH] fix compilation of ppc embedded configs
From: Rene Rebe <rene@rocklinux-consulting.de>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, the attached patch converts some
	arch/ppc/platforms/*_setup.c files to the new openpic_init argument
	cleanups and additional fixes the includes of platforms/pplus.c.
	prpmc750 config and pplus config tested and booted. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the attached patch converts some arch/ppc/platforms/*_setup.c files to
the new openpic_init argument cleanups and additional fixes the
includes of platforms/pplus.c.

prpmc750 config and pplus config tested and booted.

--- linux-2.6.6-rc2/arch/ppc/platforms/gemini_setup.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.5-wip/arch/ppc/platforms/gemini_setup.c	2004-04-19 18:02:39.000000000 +0200
@@ -324,7 +324,7 @@
 void __init gemini_init_IRQ(void)
 {
 	/* gemini has no 8259 */
-	openpic_init(1, 0, 0, -1);
+	openpic_init(0);
 }
 
 #define gemini_rtc_read(x)       (readb(GEMINI_RTC+(x)))
--- linux-2.6.6-rc2/arch/ppc/platforms/mvme5100_setup.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.5-wip/arch/ppc/platforms/mvme5100_setup.c	2004-04-19 18:03:09.000000000 +0200
@@ -137,14 +137,14 @@
 		ppc_md.progress("init_irq: enter", 0);
 
 #ifdef CONFIG_MVME5100_IPMC761_PRESENT
-	openpic_init(1, NUM_8259_INTERRUPTS, NULL, -1);
+	openpic_init(NUM_8259_INTERRUPTS);
 
 	for(i=0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
 
 	i8259_init(NULL);
 #else
-	openpic_init(1, 0, NULL, -1);
+	openpic_init(0);
 #endif
 
 	if ( ppc_md.progress )
--- linux-2.6.6-rc2/arch/ppc/platforms/powerpmc250.c	2004-03-11 03:55:23.000000000 +0100
+++ linux-2.6.5-wip/arch/ppc/platforms/powerpmc250.c	2004-04-19 18:03:28.000000000 +0200
@@ -197,7 +197,7 @@
 
 	OpenPIC_InitSenses = powerpmc250_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(powerpmc250_openpic_initsenses);
-	openpic_init(1, 0, 0, -1);
+	openpic_init(0);
 }
 
 /*
--- linux-2.6.6-rc2/arch/ppc/platforms/pplus.c	2004-04-22 10:27:16.000000000 +0200
+++ linux-2.6.5-wip/arch/ppc/platforms/pplus.c	2004-04-18 22:36:08.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/initrd.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/pci.h>
--- linux-2.6.6-rc2/arch/ppc/platforms/prpmc750_setup.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.5-wip/arch/ppc/platforms/prpmc750_setup.c	2004-04-18 22:09:44.000000000 +0200
@@ -39,7 +39,7 @@
 #include <platforms/prpmc750.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
-#include <asm/pplus.h>
+#include "pplus.h"
 
 extern void prpmc750_find_bridges(void);
 extern int mpic_init(void);
@@ -203,7 +203,7 @@
 static void __init
 prpmc750_init_IRQ(void)
 {
-	openpic_init(1, 0, 0, -1);
+	openpic_init(0);
 }
 
 /*
--- linux-2.6.6-rc2/arch/ppc/platforms/prpmc800_setup.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.5-wip/arch/ppc/platforms/prpmc800_setup.c	2004-04-19 18:03:51.000000000 +0200
@@ -197,7 +197,7 @@
 static void __init
 prpmc800_init_IRQ(void)
 {
-	openpic_init(1, 0, 0, -1);
+	openpic_init(0);
 
 #define PRIORITY	15
 #define VECTOR	 	16


Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

