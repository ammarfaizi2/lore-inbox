Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUKPTUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUKPTUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUKPTSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:18:48 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:10636 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262099AbUKPTRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:17:34 -0500
Subject: [PATCH] sysrq and 8250 serial console 2.6.10-rc1-mm3
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 16 Nov 2004 14:17:33 -0500
Message-Id: <1100632653.14403.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if anyone else caught this, but the sysrq doesn't work with
the serial console for 8250.  This is a simple patch, the serial_8250.h
also calls serial_core.h before SUPPORT_SYSRQ is defined. And thus the
inlines in serial core do not support sysrq.

Here's the fix, I was even more paranoid and put the define before all
serial headers.

--- linux-2.6.10-rc1-mm3/drivers/serial/8250.c_orig     2004-11-16 14:07:08.000000000 -0500
+++ linux-2.6.10-rc1-mm3/drivers/serial/8250.c  2004-11-16 14:07:47.000000000 -0500
@@ -27,6 +27,11 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
+
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/serial_reg.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
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
Steven Rostedt
Senior Engineer
Kihon Technologies
