Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTEGSe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTEGSe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:34:29 -0400
Received: from webmail.hamiltonfunding.la ([12.162.17.40]:19496 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264201AbTEGSeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:34:25 -0400
To: root@chaos.analogic.com
Cc: Jonathan Lundell <linux@lundell-bros.com>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<20030507135657.GC18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305071008080.11871@chaos>
	<p05210601badeeb31916c@[207.213.214.37]>
	<Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
	<Pine.LNX.4.53.0305071424290.13499@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 07 May 2003 11:46:56 -0700
In-Reply-To: <Pine.LNX.4.53.0305071424290.13499@chaos>
Message-ID: <52bryeppb3.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 May 2003 18:46:59.0030 (UTC) FILETIME=[0A4CE760:01C314C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

    Richard> On Wed, 7 May 2003, Roland Dreier wrote: The kernel
    Richard> stack, at least for ix86, is only one, set upon startup
    Richard> at 8192 bytes above a label called init_task_unit. The
    Richard> kernel must have a separate stack and, contrary to what
    Richard> I've been reading on this list, it can't have more kernel
    Richard> stacks than CPUs and, I don't see a separate stack
    Richard> allocated for different CPUs.

    Roland> This is total nonsense.  Please don't confuse matters by
    Roland> spreading misinformation like this.  Every task has a
    Roland> separate (8K) kernel stack.  Look at the implementation of
    Roland> do_fork() and in particular alloc_task_struct().

    Roland> If there were only one kernel stack, what do you think
    Roland> would happen if a process went to sleep in kernel code?

    Richard> No, No. That is a process stack. Every process has it's
    Richard> own, entirely seperate stack. This stack is used only in
    Richard> user mode. The kernel has it's own stack. Every time you
    Richard> switch to kernel mode either by calling the kernel or by
    Richard> a hardware interrupt, the kernel's stack is used.

Again, this is nonsense and misinformation.  Look at do_fork() and
alloc_task_struct().  Do you see how alloc_task_struct() is just
defined to be __get_free_pages(GFP_KERNEL,1) for i386?  Do you
understand that that just allocates two pages (8K) of kernel memory?
Do you see that it is never mapped into userspace, and that anyway
a userspace process can use far more than 8K of stack?

That 8K of memory is used for the kernel stack for a particular
process.  When a process makes a system call, that specific stack is
used as the kernel stack.

    Richard> When a task sleeps, it sleeps in kernel mode. The kernel
    Richard> schedules other tasks until the sleeper has been
    Richard> satisfied either by time or by event.

Right.  Now think about where the kernel stack for the process that is
sleeping in the kernel is kept.

 - Roland
