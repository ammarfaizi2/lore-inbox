Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVGOKzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVGOKzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVGOKyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:54:49 -0400
Received: from fsmlabs.com ([168.103.115.128]:45765 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262650AbVGOKwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:52:45 -0400
Date: Fri, 15 Jul 2005 04:56:54 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: print processor number in show_regs
Message-ID: <Pine.LNX.4.61.0507150440280.16055@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Up to date i've been using the GS value to determine the processor number 
in dumps from show_regs, however this can be cumbersome to do if you don't 
have the vmlinux to verify with the address of cpu_pda, how about the 
following? I considered using hard_smp_processor_id for robustness but we 
already dereference current so we're already relying on MSR_GS_BASE being 
sane.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c	10 Jul 2005 04:38:46 -0000	1.1.1.1
+++ linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c	15 Jul 2005 10:54:42 -0000
@@ -272,7 +272,7 @@ void __show_regs(struct pt_regs * regs)
 
 	printk("\n");
 	print_modules();
-	printk("Pid: %d, comm: %.20s %s %s\n", 
+	printk("CPU: %d Pid: %d, comm: %.20s %s %s\n", smp_processor_id(),
 	       current->pid, current->comm, print_tainted(), system_utsname.release);
 	printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
 	printk_address(regs->rip); 
