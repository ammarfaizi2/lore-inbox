Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSLaIaE>; Tue, 31 Dec 2002 03:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSLaIaE>; Tue, 31 Dec 2002 03:30:04 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:40124 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262215AbSLaIaD>; Tue, 31 Dec 2002 03:30:03 -0500
Date: Tue, 31 Dec 2002 09:38:25 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix up UP in 2.5-bkcurrent
Message-ID: <20021231083825.GS21097@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following bit is needed to build (and boot) current 2.5 bk on
UP.  The fix just favors a "we may have to do this" comment. <g>

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
--- a/include/asm-i386/hw_irq.h	2002-12-31 09:33:21.000000000 +0100
+++ b/include/asm-i386/hw_irq.h	2002-12-31 09:26:18.000000000 +0100
@@ -131,8 +131,9 @@
 
 #endif /* CONFIG_PROFILING */
  
-#ifdef CONFIG_X86_IO_APIC /*more of this file should probably be ifdefed SMP */
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
+static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
+{
 	if (IO_APIC_IRQ(i))
 		send_IPI_self(IO_APIC_VECTOR(i));
 }
