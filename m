Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWCCP6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWCCP6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCCP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:58:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751228AbWCCP6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:58:44 -0500
Date: Fri, 3 Mar 2006 11:08:06 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2 (mips compile fix)
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603031106010.6067@dhcp83-105.boston.redhat.com>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Mar 2006, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
> 
> 
> - Should be a bit better than 2.6.16-rc5-mm1, but I still had to fix a ton
>   of things to get this to compile and boot.  We're not being careful enough.
> 
> - The procfs rework is getting there, but some problems probably still remain.
> 
> - There will be a number of new warnings at boot time when initcalls fail. 
>   Generally that's OK: it usually indicates that you linked something into
>   vmlinux which you're not actually using.  But sometimes it can indicate
>   kernel bugs.
> 
> - The (much-shrunk) audit git tree is back.
> 
> 

In the audit syscall speedup patch, i messed up the following, if people 
are building on mips. thanks.

-Jason

--- audit-current/arch/mips/kernel/ptrace.c.bak	2006-03-03 10:46:51.000000000 -0500
+++ audit-current/arch/mips/kernel/ptrace.c	2006-03-03 10:55:46.000000000 -0500
@@ -468,7 +468,7 @@ static inline int audit_arch(void)
  */
 asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	if (audit_invoke_exit && entryexit)
+	if (audit_invoke_exit() && entryexit)
 		audit_syscall_exit(current, AUDITSC_RESULT(regs->regs[2]),
 		                   regs->regs[2]);
 
@@ -492,7 +492,7 @@ asmlinkage void do_syscall_trace(struct 
 		current->exit_code = 0;
 	}
  out:
-	if (audit_invoke_entry && !entryexit)
+	if (audit_invoke_entry() && !entryexit)
 		audit_syscall_entry(current, audit_arch(), regs->regs[2],
 				    regs->regs[4], regs->regs[5],
 				    regs->regs[6], regs->regs[7]);
