Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTJVP5h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 11:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTJVP5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 11:57:36 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:5 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263487AbTJVP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 11:57:35 -0400
Subject: Fix x86 subarch breakage by the patch to allow more APIC irq sources
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: jamesclv@us.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Oct 2003 10:56:31 -0500
Message-Id: <1066838206.1781.66.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with this patch was that it defined a new quantity
NR_IRQ_VECTORS.  However, the definition of NR_IRQ_VECTORS is only in
mach-default/irq_vectors.h.  Every subarch which defines it's own
irq_vectors.h (that's voyager, visws and pc9800) now won't compile.

I think the best fix is the attached (although you could clean up
mach-default/irq_vectors.h with this too).

James

===== include/asm-i386/irq.h 1.9 vs edited =====
--- 1.9/include/asm-i386/irq.h	Wed Apr 23 02:49:34 2003
+++ edited/include/asm-i386/irq.h	Wed Oct 22 10:49:21 2003
@@ -15,6 +15,10 @@
 /* include comes from machine specific directory */
 #include "irq_vectors.h"
 
+#ifndef NR_IRQ_VECTORS
+#define NR_IRQ_VECTORS NR_IRQS
+#endif
+
 static __inline__ int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);

