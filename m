Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTDGXY5 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263844AbTDGXYf (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:24:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4481
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263819AbTDGXNC (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:13:02 -0400
Date: Tue, 8 Apr 2003 01:31:52 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080031.h380VqOw009188@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: and visws
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-visws/irq_vectors.h linux-2.5.67-ac1/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.67/include/asm-i386/mach-visws/irq_vectors.h	2003-03-03 19:20:16.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-i386/mach-visws/irq_vectors.h	2003-03-14 01:23:56.000000000 +0000
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-visws/smpboot_hooks.h linux-2.5.67-ac1/include/asm-i386/mach-visws/smpboot_hooks.h
--- linux-2.5.67/include/asm-i386/mach-visws/smpboot_hooks.h	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-i386/mach-visws/smpboot_hooks.h	2003-03-14 01:10:39.000000000 +0000
@@ -1,10 +1,21 @@
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	CMOS_WRITE(0xa, 0xf);
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+}
+
 /* for visws do nothing for any of these */
 
 static inline void smpboot_clear_io_apic_irqs(void)
 {
 }
 
-static inline void smpboot_setup_warm_reset_vector(void)
+static inline void smpboot_restore_warm_reset_vector(void)
 {
 }
 
