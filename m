Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263308AbVGOLEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbVGOLEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVGOLAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:00:55 -0400
Received: from fsmlabs.com ([168.103.115.128]:4294 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261884AbVGOLAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:00:09 -0400
Date: Fri, 15 Jul 2005 05:04:57 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: print processor number in show_regs
In-Reply-To: <Pine.LNX.4.61.0507150440280.16055@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0507150500410.16053@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0507150440280.16055@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Zwane Mwaikambo wrote:

> Up to date i've been using the GS value to determine the processor number 
> in dumps from show_regs, however this can be cumbersome to do if you don't 
> have the vmlinux to verify with the address of cpu_pda, how about the 
> following? I considered using hard_smp_processor_id for robustness but we 
> already dereference current so we're already relying on MSR_GS_BASE being 
> sane.
> 
> Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Sorry, i sent off an older patch, here is the correct one;

Index: linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c	10 Jul 2005 04:38:46 -0000	1.1.1.1
+++ linux-2.6.13-rc2-mm1/arch/x86_64/kernel/process.c	15 Jul 2005 11:00:28 -0000
@@ -311,6 +311,7 @@ void __show_regs(struct pt_regs * regs)
 
 void show_regs(struct pt_regs *regs)
 {
+	printk("CPU %d:", smp_processor_id());
 	__show_regs(regs);
 	show_trace(&regs->rsp);
 }
