Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTEGSNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTEGSNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:13:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:387 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264169AbTEGSNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:13:39 -0400
Date: Wed, 7 May 2003 14:28:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: Jonathan Lundell <linux@lundell-bros.com>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <52k7d2pqwm.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0305071424290.13499@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Roland Dreier wrote:

>     Richard> The kernel stack, at least for ix86, is only one, set
>     Richard> upon startup at 8192 bytes above a label called
>     Richard> init_task_unit. The kernel must have a separate stack
>     Richard> and, contrary to what I've been reading on this list, it
>     Richard> can't have more kernel stacks than CPUs and, I don't see
>     Richard> a separate stack allocated for different CPUs.
>
> This is total nonsense.  Please don't confuse matters by spreading
> misinformation like this.  Every task has a separate (8K) kernel
> stack.  Look at the implementation of do_fork() and in particular
> alloc_task_struct().
>
> If there were only one kernel stack, what do you think would happen if
> a process went to sleep in kernel code?
>
>  - Roland
>

No, No. That is a process stack. Every process has it's own, entirely
seperate stack. This stack is used only in user mode. The kernel has
it's own stack. Every time you switch to kernel mode either by
calling the kernel or by a hardware interrupt, the kernel's stack
is used.

When a task sleeps, it sleeps in kernel mode. The kernel schedules
other tasks until the sleeper has been satisfied either by time or
by event.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

