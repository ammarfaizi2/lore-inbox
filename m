Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTIILGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTIILGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:06:22 -0400
Received: from [203.145.184.221] ([203.145.184.221]:9235 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S264022AbTIILGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:06:21 -0400
Subject: [PATCH 2.6.0-test5] s/spin_lock_irqrestore/spin_unlock_irqrestore
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: NatureSoft Private Limited
Message-Id: <1063105633.4418.7.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 16:37:14 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of trivial fixes I missed out earlier.

Vinay

diff -urN linux-2.6.0-test5/drivers/scsi/gdth.c linux-2.6.0-test5-nvk/drivers/scsi/gdth.c
--- linux-2.6.0-test5/drivers/scsi/gdth.c	2003-09-09 11:11:36.000000000 +0530
+++ linux-2.6.0-test5-nvk/drivers/scsi/gdth.c	2003-09-09 16:19:32.000000000 +0530
@@ -2048,7 +2048,7 @@
         for (j = 0; j < 12; ++j) 
             rtc[j] = CMOS_READ(j);
     } while (rtc[0] != CMOS_READ(0));
-    spin_lock_irqrestore(&rtc_lock, flags);
+    spin_unlock_irqrestore(&rtc_lock, flags);
     TRACE2(("gdth_search_drives(): RTC: %x/%x/%x\n",*(ulong32 *)&rtc[0],
             *(ulong32 *)&rtc[4], *(ulong32 *)&rtc[8]));
     /* 3. send to controller firmware */
diff -urN linux-2.6.0-test5/arch/ia64/kernel/perfmon.c linux-2.6.0-test5-nvk/arch/ia64/kernel/perfmon.c
--- linux-2.6.0-test5/arch/ia64/kernel/perfmon.c	2003-09-09 11:11:11.000000000 +0530
+++ linux-2.6.0-test5-nvk/arch/ia64/kernel/perfmon.c	2003-09-09 16:20:28.000000000 +0530
@@ -155,7 +155,7 @@
  * in UP:
  * 	- we need to protect against PMU overflow interrupts (local_irq_disable)
  *
- * spin_lock_irqsave()/spin_lock_irqrestore():
+ * spin_lock_irqsave()/spin_unlock_irqrestore():
  * 	in SMP: local_irq_disable + spin_lock
  * 	in UP : local_irq_disable
  *




