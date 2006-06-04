Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932226AbWFDKzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWFDKzy (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWFDKzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:55:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16094 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932226AbWFDKzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:55:54 -0400
Date: Sun, 4 Jun 2006 12:55:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch, -rc5-mm3] lock validator: sparc64, sparc, m68k, alpha, cris, irqtrace build fix
Message-ID: <20060604105519.GA17564@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5081]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: sparc64, sparc, m68k, alpha, cris, irqtrace build fix
From: Ingo Molnar <mingo@elte.hu>

early_init_irq_lock_type() should only be provided by an architecture
if it offers CONFIG_TRACE_IRQFLAGS.

this makes sparc64 (and probably the other non-genirq arches) build.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h |    2 ++
 init/main.c             |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -226,9 +226,11 @@ struct lockdep_type_key { };
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+extern void early_init_irq_lock_type(void);
 extern void early_boot_irqs_off(void);
 extern void early_boot_irqs_on(void);
 #else
+# define early_init_irq_lock_type()		do { } while (0)
 # define early_boot_irqs_off()			do { } while (0)
 # define early_boot_irqs_on()			do { } while (0)
 #endif
Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -82,7 +82,6 @@
 
 static int init(void *);
 
-extern void early_init_irq_lock_type(void);
 extern void init_IRQ(void);
 extern void fork_init(unsigned long);
 extern void mca_init(void);
