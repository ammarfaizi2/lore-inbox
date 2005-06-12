Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVFLI4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVFLI4h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 04:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFLI4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 04:56:37 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36949 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261917AbVFLI4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 04:56:34 -0400
Date: Sun, 12 Jun 2005 10:56:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [PATCH] Remove obsolete HAVE_ARCH_GET_SIGNAL_TO_DELIVER?
Message-ID: <Pine.LNX.4.62.0506121051360.29300@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now m68k no longer sets HAVE_ARCH_GET_SIGNAL_TO_DELIVER, can it be removed
completely? Or may ARM26 still need it? Note that its usage was removed from
kernel/signal.c about 2 months ago.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 asm-arm26/signal.h |    3 ---
 linux/signal.h     |    2 --
 2 files changed, 5 deletions(-)

--- linux-2.6.12-rc6/include/asm-arm26/signal.h	2005-05-07 09:50:54.000000000 +0200
+++ linux-m68k-2.6.12-rc6/include/asm-arm26/signal.h	2005-05-07 18:23:23.000000000 +0200
@@ -166,9 +166,6 @@ typedef struct sigaltstack {
 #include <asm/sigcontext.h>
 
 #define sigmask(sig)	(1UL << ((sig) - 1))
-//FIXME!!!
-//#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
-
 #endif
 
 
--- linux-2.6.12-rc6/include/linux/signal.h	2005-05-07 09:51:06.000000000 +0200
+++ linux-m68k-2.6.12-rc6/include/linux/signal.h	2005-05-07 11:01:49.000000000 +0200
@@ -231,10 +231,8 @@ extern int __group_send_sig_info(int, st
 extern long do_sigpending(void __user *, unsigned long);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 
-#ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
-#endif
 
 #endif /* __KERNEL__ */
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
