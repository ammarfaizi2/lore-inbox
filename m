Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130738AbRBWXHJ>; Fri, 23 Feb 2001 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130772AbRBWXG7>; Fri, 23 Feb 2001 18:06:59 -0500
Received: from comunit.de ([195.21.213.33]:39754 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S130768AbRBWXGq>;
	Fri, 23 Feb 2001 18:06:46 -0500
Date: Sat, 24 Feb 2001 00:06:44 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: <haegar@space.comunit.de>
To: <Linux-kernel@vger.kernel.org>
Subject: Alpha compile error on 2.4.2-ac3 (irq_err_count)
Message-ID: <Pine.LNX.4.32.0102232354060.722-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

Machine: DEC-Alpha XL300 (Alcor/XLT)
Kernel: 2.4.2-ac3

Compile-Error:
make[1]: Entering directory `/usr/src/linux-2.4.2-ac3/arch/alpha/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.2-ac3/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mno-fp-regs -ffixed-8 -Wa,-mev6    -c -o irq_alpha.o irq_alpha.c
irq_alpha.c: In function `dummy_perf':
irq_alpha.c:33: `irq_err_count' undeclared (first use in this function)
irq_alpha.c:33: (Each undeclared identifier is reported only once
irq_alpha.c:33: for each function it appears in.)
irq_alpha.c: In function `do_entInt':
irq_alpha.c:54: `irq_err_count' undeclared (first use in this function)
irq_alpha.c: In function `process_mcheck_info':
irq_alpha.c:152: warning: unused variable `cpu'
make[1]: *** [irq_alpha.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac3/arch/alpha/kernel'
make: *** [_dir_arch/alpha/kernel] Error 2


Temporary fix to get it compiling again:
--- linux/include/asm-alpha/hw_irq.h~	Fri Feb 23 23:45:39 2001
+++ linux/include/asm-alpha/hw_irq.h	Fri Feb 23 23:59:51 2001
@@ -5,6 +5,8 @@

 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}

+extern volatile unsigned long irq_err_count;
+
 #ifdef CONFIG_ALPHA_GENERIC
 #define ACTUAL_NR_IRQS	alpha_mv.nr_irqs
 #else


But the real bug seems to be that the changes to irq_err_count ("atomic_t"
instead of "volatile unsigned long", and moving it from linux/irq.h to
asm/hw_irq.h are done for i386 but not for the other architectures.


c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

