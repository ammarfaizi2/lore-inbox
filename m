Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbULOSwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbULOSwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbULOSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:49:48 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31424 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262450AbULOStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:49:09 -0500
Date: Wed, 15 Dec 2004 11:49:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: [PATCH][PPC32] Add uImage to default targets
Message-ID: <20041215114904.A3696@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like to get a uImage when just using 'make' on many
targets. After some discussion, it made sense to simply
add uImage to the default targets since it adds minimal
build overhead and will work on all platforms. Also,
fix a dependency in the boot stuff.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/Makefile 1.66 vs edited =====
--- 1.66/arch/ppc/Makefile	2004-10-05 17:28:57 -07:00
+++ edited/arch/ppc/Makefile	2004-12-15 10:27:30 -07:00
@@ -68,7 +68,7 @@
 
 .PHONY: $(BOOT_TARGETS)
 
-all: zImage
+all: uImage zImage
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
===== arch/ppc/boot/simple/misc.c 1.24 vs edited =====
--- 1.24/arch/ppc/boot/simple/misc.c	2004-10-08 02:57:32 -07:00
+++ edited/arch/ppc/boot/simple/misc.c	2004-12-15 10:25:10 -07:00
@@ -102,7 +102,7 @@
 	com_port = serial_init(0, NULL);
 #endif
 
-#ifdef CONFIG_44x
+#if defined(CONFIG_44x) && defined(PPC44x_EMAC0_MR0)
 	/* Reset MAL */
 	mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);
 	/* Wait for reset */
