Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266767AbTGFWcw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbTGFWcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:32:52 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17332 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S266767AbTGFWcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:32:50 -0400
Date: Mon, 7 Jul 2003 00:47:13 +0200 (MEST)
Message-Id: <200307062247.h66MlDpD024015@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.22-pre3] i386 cpufeature.h cleanup + comment
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.22-pre3 changelog includes:
>Alan Cox <alan@lxorguk.ukuu.org.uk>:
...
>  o add the extra cpu bit test flags

This added a second cpu_has() macro to cpufeature.h, which
the patch below cleans up.

Note that FEATURE_EST currently mustn't be used: it resides
in the fifth word ([4]) but only four words are allocated
(NCAPINTS). If you bump NCAPINTS, you must also adjust the
hard-coded struct offsets in arch/i386/kernel/head.S or
Very Bad Things happen.

/Mikael

--- linux-2.4.22-pre3/include/asm-i386/cpufeature.h.~1~	2003-07-06 18:37:46.000000000 +0200
+++ linux-2.4.22-pre3/include/asm-i386/cpufeature.h	2003-07-06 19:21:50.000000000 +0200
@@ -67,9 +67,6 @@
 /* Intel defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
 
-#define cpu_has(c, bit)            test_bit(bit, (c)->x86_capability)
-
-
 #define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
 #define boot_cpu_has(bit)	test_bit(bit, boot_cpu_data.x86_capability)
 
