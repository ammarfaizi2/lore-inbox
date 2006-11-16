Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423787AbWKPKum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423787AbWKPKum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbWKPKum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:50:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6827 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423787AbWKPKul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:50:41 -0500
Date: Thu, 16 Nov 2006 11:49:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] x86_64: fix CONFIG_CC_STACKPROTECTOR build bug
Message-ID: <20061116104916.GA12863@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0030]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] x86_64: fix CONFIG_CC_STACKPROTECTOR build bug
From: Ingo Molnar <mingo@elte.hu>

on x86_64, the CONFIG_CC_STACKPROTECTOR build fails if used in a
distcc setup that has "CC" defined to "distcc gcc":

 gcc: gcc: linker input file unused because linking not done
 gcc: gcc: linker input file unused because linking not done
 gcc: gcc: linker input file unused because linking not done

this is because the gcc-x86_64-has-stack-protector.sh script
has a 2-parameters assumption. Fix this by passing $(CC) as
a single parameter.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Please-Use-Me-More: make randconfig
---
 arch/x86_64/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/Makefile
===================================================================
--- linux.orig/arch/x86_64/Makefile
+++ linux/arch/x86_64/Makefile
@@ -66,8 +66,8 @@ AFLAGS += $(call as-instr,.cfi_startproc
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 
-cflags-$(CONFIG_CC_STACKPROTECTOR) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) -fstack-protector )
-cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) -fstack-protector-all )
+cflags-$(CONFIG_CC_STACKPROTECTOR) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh "$(CC)" -fstack-protector )
+cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh "$(CC)" -fstack-protector-all )
 
 CFLAGS += $(cflags-y)
 CFLAGS_KERNEL += $(cflags-kernel-y)
