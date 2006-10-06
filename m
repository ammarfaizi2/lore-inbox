Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWJFQ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWJFQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWJFQ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:27:24 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:55466
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750993AbWJFQ1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:27:24 -0400
Date: Fri, 6 Oct 2006 17:26:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] fix IRQ register passing for i386 SMP platforms
Message-ID: <20061006162609.GA22640@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix IRQ register passing for i386 SMP platforms

Seems that the i386 SMP conversion for the new global irq regs
is not quite there.  Results in the following compile errors:

    arch/i386/kernel/apic.c: In function `smp_local_timer_interrupt':
    arch/i386/kernel/apic.c:1200: error: `irq_regs' undeclared (first
						    use in this function)
    arch/i386/kernel/apic.c:1200: error: (Each undeclared
					    identifier is reported only once
    arch/i386/kernel/apic.c:1200: error: for each function it appears in.)

Fix it up.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
index 7d500da..2fd4b7d 100644
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -1197,7 +1197,7 @@ inline void smp_local_timer_interrupt(vo
 {
 	profile_tick(CPU_PROFILING);
 #ifdef CONFIG_SMP
-	update_process_times(user_mode_vm(irq_regs));
+	update_process_times(user_mode_vm(get_irq_regs()));
 #endif
 
 	/*
