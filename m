Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbTGFW3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbTGFW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:29:16 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:3508 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S266751AbTGFW3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:29:09 -0400
Date: Mon, 7 Jul 2003 00:43:40 +0200 (MEST)
Message-Id: <200307062243.h66MheGM023893@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: [PATCH][2.4.22-pre3] fix PPC32 compile failure due to SPRN_HID2 being undefined
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.4.22-pre3 for a 6xx-class PowerPC fails in cpu_setup_6xx.S:

ppc-unknown-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/tmp/linux-2.4.22-pre3/include -I/tmp/linux-2.4.22-pre3/arch/ppc   -c -o cpu_setup_6xx.o cpu_setup_6xx.S
cpu_setup_6xx.S: Assembler messages:
cpu_setup_6xx.S:325: Error: unsupported relocation against SPRN_HID2
cpu_setup_6xx.S:416: Error: unsupported relocation against SPRN_HID2
make[1]: *** [cpu_setup_6xx.o] Error 1
make[1]: Leaving directory `/tmp/linux-2.4.22-pre3/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

SPRN_HID2 should be a #defined constant, but it isn't. The patch
below from 2.4.21-ben2 (rediffed for 2.4.22-pre3) fixes the problem.

/Mikael

diff -ruN linux-2.4.22-pre3/include/asm-ppc/processor.h linux-2.4.22-pre3.ppc-hid2-fix/include/asm-ppc/processor.h
--- linux-2.4.22-pre3/include/asm-ppc/processor.h	2003-07-06 18:37:48.000000000 +0200
+++ linux-2.4.22-pre3.ppc-hid2-fix/include/asm-ppc/processor.h	2003-07-06 22:24:10.000000000 +0200
@@ -248,6 +248,7 @@
 #define	  HID0_NOPDST	(1<<1)		/* No-op dst, dstt, etc. instr. */
 #define	  HID0_NOPTI	(1<<0)		/* No-op dcbt and dcbst instr. */
 #define	SPRN_HID1	0x3F1	/* Hardware Implementation Register 1 */
+#define	SPRN_HID2	0x3F8	/* Hardware Implementation Register 2 */
 #define	SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define	SPRN_IAC1	0x3F4	/* Instruction Address Compare 1 */
 #define	SPRN_IAC2	0x3F5	/* Instruction Address Compare 2 */
