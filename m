Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULOPGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULOPGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbULOPGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:06:15 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23699 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261167AbULOPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:06:05 -0500
Date: Wed, 15 Dec 2004 08:06:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-rc3] ppc32: Compile classic PPC specific ASM only on CONFIG_6xx
Message-ID: <20041215150603.GD22316@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I hope this can go in prior to 2.6.10 ]

Newer binutils (2.15) when they know they aren't assembling for a
classic target (say e500 instead of 750) disallow certain opcodes,
causing the compile to fail.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

---
 util.S |    2 ++
 1 files changed, 2 insertions(+)
---
Index: 2.6.10-rc3/arch/ppc/boot/common/util.S
===================================================================
--- 2.6.10-rc3/arch/ppc/boot/common/util.S	(revision 11)
+++ 2.6.10-rc3/arch/ppc/boot/common/util.S	(working copy)
@@ -27,6 +27,7 @@
 
 	.text
 
+#ifdef CONFIG_6xx
 	.globl	disable_6xx_mmu
 disable_6xx_mmu:
 	/* Establish default MSR value, exception prefix 0xFFF.
@@ -94,6 +95,7 @@
 	sync
 	isync
 	blr
+#endif
 
 	.globl	_setup_L2CR
 _setup_L2CR:

-- 
Tom Rini
http://gate.crashing.org/~trini/
