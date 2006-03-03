Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWCCLJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWCCLJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWCCLJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:09:18 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:61174 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751371AbWCCLJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:09:18 -0500
Message-ID: <4408235E.4090406@metro.cx>
Date: Fri, 03 Mar 2006 12:07:10 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 12/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start of s3c2412 dsc support.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/arch/arm/mach-s3c2410/s3c2412-dsc.c    1970-01-01 
01:00:00.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/s3c2412-dsc.c    2006-02-27 
17:12:40.000000000 +0100
@@ -0,0 +1,60 @@
+/* linux/arch/arm/mach-s3c2410/s3c2440-dsc.c
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *   Ben Dooks <ben@simtec.co.uk>
+ *
+ * Samsung S3C2412 Drive Strength Control support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modifications:
+ *     29-Aug-2004 BJD  Start of drive-strength control
+ *     09-Nov-2004 BJD  Added symbol export
+ *     11-Jan-2005 BJD  Include fix
+ *     27-Feb-2006 KM   Start of S3C2412 support
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/regs-dsc.h>
+
+#include "cpu.h"
+#include "s3c2412.h"
+
+int s3c2412_set_dsc(unsigned int pin, unsigned int value)
+{
+    void __iomem *base;
+    unsigned long val;
+    unsigned long flags;
+    unsigned long mask;
+
+    base = (pin & S3C2412_SELECT_DSC1) ? S3C2412_DSC1 : S3C2412_DSC0;
+    mask = 3 << S3C2440_DSC_GETSHIFT(pin);
+
+    local_irq_save(flags);
+
+    val = __raw_readl(base);
+    val &= ~mask;
+    val |= value & mask;
+    __raw_writel(val, base);
+
+    local_irq_restore(flags);
+    return 0;
+}
+
+EXPORT_SYMBOL(s3c2412_set_dsc);

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

