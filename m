Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTJVQc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 12:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTJVQc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 12:32:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:30621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263467AbTJVQcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 12:32:24 -0400
Date: Wed, 22 Oct 2003 09:31:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix x86 subarch breakage by the patch to allow more APIC irq
 sources
In-Reply-To: <1066838206.1781.66.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0310220929350.1586-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Oct 2003, James Bottomley wrote:
>
> I think the best fix is the attached (although you could clean up
> mach-default/irq_vectors.h with this too).

I'd much rather do this the other way: I _detest_ "generic" values that 
architectures can override, when just defining the value in the 
architecture directly is smaller than the test for the generic value.

So I'd rather just see the sub-architectures add their own #defines, like
the appended.

That way there is a direct and clear causal relationship, not some kind of 
"if this value doesn't exist, then we use that other value" indirection.

		Linus

----
===== include/asm-i386/mach-pc9800/irq_vectors.h 1.1 vs edited =====
--- 1.1/include/asm-i386/mach-pc9800/irq_vectors.h	Fri Feb 14 14:59:47 2003
+++ edited/include/asm-i386/mach-pc9800/irq_vectors.h	Wed Oct 22 09:28:54 2003
@@ -18,6 +18,9 @@
  *		The total number of interrupt vectors (including all the
  *		architecture specific interrupts) needed.
  *
+ *	NR_IRQ_VECTORS:
+ *		The total number of IO APIC vector inputs
+ *
  */			
 #ifndef _ASM_IRQ_VECTORS_H
 #define _ASM_IRQ_VECTORS_H
@@ -81,6 +84,8 @@
 #else
 #define NR_IRQS 16
 #endif
+
+#define NR_IRQ_VECTORS NR_IRQS
 
 #define FPU_IRQ			8
 
===== include/asm-i386/mach-visws/irq_vectors.h 1.5 vs edited =====
--- 1.5/include/asm-i386/mach-visws/irq_vectors.h	Thu Mar 13 17:23:56 2003
+++ edited/include/asm-i386/mach-visws/irq_vectors.h	Wed Oct 22 09:28:54 2003
@@ -50,6 +50,7 @@
  * 
  */
 #define NR_IRQS 224
+#define NR_IRQ_VECTORS NR_IRQS
 
 #define FPU_IRQ			13
 
===== include/asm-i386/mach-voyager/irq_vectors.h 1.3 vs edited =====
--- 1.3/include/asm-i386/mach-voyager/irq_vectors.h	Fri Feb 14 15:02:30 2003
+++ edited/include/asm-i386/mach-voyager/irq_vectors.h	Wed Oct 22 09:28:54 2003
@@ -56,6 +56,7 @@
 #define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
 
 #define NR_IRQS 224
+#define NR_IRQ_VECTORS NR_IRQS
 
 #define FPU_IRQ				13
 

