Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVG1I0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVG1I0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVG1I0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:26:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261248AbVG1IZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:25:51 -0400
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: John Reiser <jreiser@BitWagon.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] i386: clean up vDSO alignment padding
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20050728082546.7864A180EB8@magilla.sf.frob.com>
Date: Thu, 28 Jul 2005 01:25:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the vDSO use nops for all its padding around instructions,
rather than sometimes zeros, and nop-pads the end of the area containing
instructions to a 32-byte cache line, to keep text and data in separate lines.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- a/arch/i386/kernel/vsyscall-sigreturn.S
+++ b/arch/i386/kernel/vsyscall-sigreturn.S
@@ -15,7 +15,7 @@
 */
 
 	.text
-	.org	__kernel_vsyscall+32
+	.org __kernel_vsyscall+32,0x90
 	.globl __kernel_sigreturn
 	.type __kernel_sigreturn,@function
 __kernel_sigreturn:
@@ -35,6 +35,7 @@ __kernel_rt_sigreturn:
 	int $0x80
 .LEND_rt_sigreturn:
 	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
+	.balign 32
 	.previous
 
 	.section .eh_frame,"a",@progbits
