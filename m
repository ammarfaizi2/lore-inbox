Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUFYG3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUFYG3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUFYG3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:29:12 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:10661 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264297AbUFYG3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:29:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Guard declaration of handle_IRQ_event with #ifdef !__ASSEMBLY__ on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040625062900.D395C3CA@mctpc71>
Date: Fri, 25 Jun 2004 15:29:00 +0900 (JST)
From: miles@mctpc71.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/irq.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff -ruN -X../cludes linux-2.6.7-uc0/include/asm-v850/irq.h linux-2.6.7-uc0-v850-20040625/include/asm-v850/irq.h
--- linux-2.6.7-uc0/include/asm-v850/irq.h	2004-05-11 13:20:53.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040625/include/asm-v850/irq.h	2004-06-24 17:20:36.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/irq.h -- Machine interrupt handling
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,04  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,04  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -62,11 +62,8 @@
 /* Disable an irq without waiting. */
 extern void disable_irq_nosync (unsigned int irq);
 
+extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
 #endif /* !__ASSEMBLY__ */
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* __V850_IRQ_H__ */
