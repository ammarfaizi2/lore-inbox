Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933047AbWFZVI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933047AbWFZVI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbWFZVI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:08:59 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:20231 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S933047AbWFZVI6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:08:58 -0400
Date: Mon, 26 Jun 2006 23:08:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] Fix warning in do_IRQ (i386)
Message-Id: <20060626230857.e92bc170.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/irq.c: In function `do_IRQ':
arch/i386/kernel/irq.c:104: warning: suggest parentheses around arithmetic in operand of |

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Björn Steinbrink <B.Steinbrink@gmx.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/kernel/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-git.orig/arch/i386/kernel/irq.c	2006-06-26 21:55:03.000000000 +0200
+++ linux-2.6.17-git/arch/i386/kernel/irq.c	2006-06-26 22:54:49.000000000 +0200
@@ -100,8 +100,8 @@
 		 * softirq checks work in the hardirq context.
 		 */
 		irqctx->tinfo.preempt_count =
-			irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK |
-			curctx->tinfo.preempt_count & SOFTIRQ_MASK;
+			(irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
+			(curctx->tinfo.preempt_count & SOFTIRQ_MASK);
 
 		asm volatile(
 			"       xchgl   %%ebx,%%esp      \n"


-- 
Jean Delvare
