Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbTCIBr7>; Sat, 8 Mar 2003 20:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbTCIBr7>; Sat, 8 Mar 2003 20:47:59 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:7296 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262344AbTCIBr6>; Sat, 8 Mar 2003 20:47:58 -0500
Date: Sun, 9 Mar 2003 10:58:03 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question about VISWS 2.5.64-ac3
Message-ID: <20030309015803.GA981@yuzuki.cinet.co.jp>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.64-ac might need patch for VISWS below?
I'm not sure. Because I don't know about VISWS.
Please check.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac3/arch/i386/mach-visws/visws_apic.c linux/arch/i386/mach-visws/visws_apic.c
--- linux-2.5.64-ac3/arch/i386/mach-visws/visws_apic.c	2003-03-08 13:54:20.000000000 +0900
+++ linux/arch/i386/mach-visws/visws_apic.c	2003-03-08 14:49:53.000000000 +0900
@@ -230,12 +230,12 @@
 	cached_irq_mask |= 1 << realirq;
 	if (unlikely(realirq > 7)) {
 		inb(0xa1);
-		outb(cached_A1, 0xa1);
+		outb(cached_slave_mask, 0xa1);
 		outb(0x60 + (realirq & 7), 0xa0);
 		outb(0x60 + 2, 0x20);
 	} else {
 		inb(0x21);
-		outb(cached_21, 0x21);
+		outb(cached_master_mask, 0x21);
 		outb(0x60 + realirq, 0x20);
 	}
 
diff -Nru linux-2.5.64-ac3/include/asm-i386/mach-visws/irq_vectors.h linux/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.64-ac3/include/asm-i386/mach-visws/irq_vectors.h	2003-03-08 13:54:58.000000000 +0900
+++ linux/include/asm-i386/mach-visws/irq_vectors.h	2003-03-08 14:08:33.000000000 +0900
@@ -51,4 +51,10 @@
  */
 #define NR_IRQS 224
 
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
 #endif /* _ASM_IRQ_VECTORS_H */
