Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbUKLW2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbUKLW2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbUKLW2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:28:00 -0500
Received: from waste.org ([209.173.204.2]:62393 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262647AbUKLW1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:27:46 -0500
Date: Fri, 12 Nov 2004 14:27:11 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] include ordering breaks sysrq on 8250 serial
Message-ID: <20041112222710.GD8040@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been pestering me for a couple days, finally dug into it:

serial_8250.h was including serial_core.h before SUPPORT_SYSRQ was
getting set up. I suspect this problem exists elsewhere. Tested
against latest bk snapshot.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l-bk20/drivers/serial/8250.c
===================================================================
--- l-bk20.orig/drivers/serial/8250.c	Fri Nov 12 13:03:25 2004
+++ l-bk20/drivers/serial/8250.c	Fri Nov 12 14:19:04 2004
@@ -20,6 +20,11 @@
  *  membase is an 'ioremapped' cookie.
  */
 #include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/tty.h>
@@ -37,10 +42,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include "8250.h"
 


-- 
Mathematics is the supreme nostalgia of our time.
