Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132404AbRAHRV1>; Mon, 8 Jan 2001 12:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132178AbRAHRVS>; Mon, 8 Jan 2001 12:21:18 -0500
Received: from Cantor.suse.de ([194.112.123.193]:31251 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132404AbRAHRVP>;
	Mon, 8 Jan 2001 12:21:15 -0500
Date: Mon, 8 Jan 2001 18:21:06 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add CONFIG_X86_RUNTIME_XMM for 2.4.
Message-ID: <20010108182106.A11978@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

Currently there is no way to get the support for the SSE2 exceptions compiled in
without getting the P3 memory barriers too. The SSE2 exception code correctly
checks all feature flags, but the memory barriers do not. This patch adds a 
CONFIG_X86_RUNTIME_XMM, which enables the SSE2 code, but not the barriers (because
it would be too expensive to check at every barrier, and the old barriers work fine
for now so runtime patching is probably not worth it) 

ATM there is no way to select the CONFIG_X86_RUNTIME_FXSR directly as a 
CPU configuration, the user needs to add a statement to config.in. In the long
run I suspect we'll just need a couple of "GENERIC" cpu templates which e.g.
contain X86_RUNTIME_FXSR or X86_RUNTIME_XMM. Currently no predefined CPU 
is truly generic if you don't want reduced functionality. 

Please consider for 2.4.0-ac5+ 


-Andi


--- linux-work/include/asm-i386/bugs.h-o	Mon Jan  8 17:02:04 2001
+++ linux-work/include/asm-i386/bugs.h	Mon Jan  8 17:30:29 2001
@@ -89,7 +89,7 @@
 		printk("done.\n");
 	}
 #endif
-#ifdef CONFIG_X86_XMM
+#if defined(CONFIG_X86_XMM) || defined(CONFIG_X86_RUNTIME_XMM) 
 	if (cpu_has_xmm) {
 		printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
 		set_in_cr4(X86_CR4_OSXMMEXCPT);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
