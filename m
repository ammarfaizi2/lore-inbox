Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbRHJNfz>; Fri, 10 Aug 2001 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268053AbRHJNff>; Fri, 10 Aug 2001 09:35:35 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:14084 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268042AbRHJNfb>; Fri, 10 Aug 2001 09:35:31 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108101336.PAA01313@green.mif.pg.gda.pl>
Subject: Compile Error in 2.4.7-ac10
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Fri, 10 Aug 2001 15:36:21 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   What is the rason of the following messages:

> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
>   -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
>   -pipe  -march=i586    -c -o traps.o traps.c
> {standard input}: Assembler messages:
> {standard input}:451: Error: suffix or operands invalid for `jmp'
> {standard input}:537: Error: suffix or operands invalid for `jmp'

or others with newer binutils:

: {standard input}: Assembler messages:
: {standard input}:461: Warning: indirect jmp without `*'
: {standard input}:547: Warning: indirect jmp without `*'

?

The following one-liner fixes them generating identical binary code with
egcs-2.91.66 and binutils-2.10.91.0.4.

Similar warnings about lcall also appear and seem to be fixable the same
way.

Andrzej

******************
diff -ur linux-2.4.7-ac10/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.4.7-ac10/arch/i386/kernel/traps.c	Sun Aug  5 21:15:51 2001
+++ linux/arch/i386/kernel/traps.c	Fri Aug 10 11:05:03 2001
@@ -282,7 +282,7 @@
 		printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
 		__asm__ volatile(
 			"movl %0, %%esp\n\t"
-			"jmp %1\n\t"
+			"jmp *%1\n\t"
 			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
 		panic("do_trap: can't hit this");
 	}


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
