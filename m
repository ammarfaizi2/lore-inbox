Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVAFKSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVAFKSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 05:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVAFKSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 05:18:14 -0500
Received: from mail.renesas.com ([202.234.163.13]:17614 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262805AbVAFKSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 05:18:06 -0500
Date: Thu, 06 Jan 2005 19:17:58 +0900 (JST)
Message-Id: <20050106.191758.424252800.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-mm2] m32r: build fix
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
References: <20050106002240.00ac4611.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is required to fix compile errors of 2.6.10-bk8 and 2.6.10-mm2
for m32r.  Please apply.

This was originally given by the following patch:
  [PATCH] move irq_enter and irq_exit to common code
  http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/1738.html

I think it was maybe accidentally dropped only for the m32r arch
due to a patching conflict with the other patches or something like that...

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/include/asm-m32r/hardirq.h b/include/asm-m32r/hardirq.h
--- a/include/asm-m32r/hardirq.h	2005-01-06 18:07:14.000000000 +0900
+++ b/include/asm-m32r/hardirq.h	2005-01-06 18:31:01.000000000 +0900
@@ -27,18 +27,6 @@ typedef struct {
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define nmi_enter()		(irq_enter())
-#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
-
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
 static inline void ack_bad_irq(int irq)
 {
 	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
