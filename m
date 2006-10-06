Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWJFH0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWJFH0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWJFH0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:26:15 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29600 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161088AbWJFH0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:26:14 -0400
Date: Fri, 6 Oct 2006 10:26:12 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, jdike@addtoit.com,
       blaisorblade@yahoo.it
Subject: [PATCH] um: irq changes break build
Message-ID: <Pine.LNX.4.64.0610061025260.29356@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Fixup broken UML build due to 7d12e780e003f93433d49ce78cfedf4b4c52adc5 "IRQ:
Maintain regs pointer globally rather than passing to IRQ handlers".

Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Paolo "Blaisorblade" Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arch/um/kernel/irq.c      |    2 +-
 include/asm-um/irq_regs.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: 2.6/include/asm-um/irq_regs.h
===================================================================
--- /dev/null
+++ 2.6/include/asm-um/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
Index: 2.6/arch/um/kernel/irq.c
===================================================================
--- 2.6.orig/arch/um/kernel/irq.c
+++ 2.6/arch/um/kernel/irq.c
@@ -356,7 +356,7 @@ void forward_interrupts(int pid)
 unsigned int do_IRQ(int irq, union uml_pt_regs *regs)
 {
        irq_enter();
-       __do_IRQ(irq, (struct pt_regs *)regs);
+       __do_IRQ(irq);
        irq_exit();
        return 1;
 }
