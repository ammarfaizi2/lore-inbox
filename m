Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWAQHFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWAQHFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 02:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAQHFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 02:05:32 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:63644 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751286AbWAQHFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 02:05:31 -0500
Date: Tue, 17 Jan 2006 16:05:34 +0900
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] changes about Call Trace:
Message-ID: <20060117070534.GA10785@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com> <200601161322.12209.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601161322.12209.ak@suse.de>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 01:22:11PM +0100, Andi Kleen wrote:
> > b) I can't find useful usage for the symbol size in print_symbol().
> >    And symbolsize seems to be fixed when vmlinux or modules are compiled.
> >    So we can calculate it from vmlinux or modules.
> >    How about removing the field of symbolsize in print_symbol()?
> > 
> >    [<ffffffffa008ef6c>] kjournald+0x406 [jbd]
> 
> It's a double check that the oops is matching the vmlinux you're looking 
> at.

If we add system_utsname.version in oops so that we can compare with
linux_banner[] in vmlinux, Will it be more precise and easier way to
double check than checking symbolsize?

--- 2.6-git/arch/i386/kernel/traps.c.orig	2006-01-17 12:45:41.000000000 +0900
+++ 2.6-git/arch/i386/kernel/traps.c	2006-01-17 12:49:35.000000000 +0900
@@ -239,9 +239,10 @@ void show_registers(struct pt_regs *regs
 	}
 	print_modules();
 	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
-			"EFLAGS: %08lx   (%s) \n",
+			"EFLAGS: %08lx   (%s %s) \n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
-		print_tainted(), regs->eflags, system_utsname.release);
+		print_tainted(), regs->eflags, system_utsname.release,
+		system_utsname.version);
 	print_symbol(KERN_EMERG "EIP is at %s\n", regs->eip);
 	printk(KERN_EMERG "eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
