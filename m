Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWC2H4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWC2H4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWC2H4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:56:11 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:9190 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751150AbWC2H4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:56:09 -0500
Date: Wed, 29 Mar 2006 09:55:57 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Ingo Molnar <mingo@elte.hu>
Cc: Simon Derr <simon.derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10
In-Reply-To: <20060328204944.GA1217@elte.hu>
Message-ID: <Pine.LNX.4.61.0603290953580.15393@openx3.frec.bull.fr>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk>
 <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
 <20060326233530.GA22496@elte.hu> <Pine.LNX.4.58.0603281142410.17504@apollon>
 <20060328204944.GA1217@elte.hu>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 09:58:13,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 09:58:14,
	Serialize complete at 29/03/2006 09:58:14
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Ingo Molnar wrote:

> > Is anyone working on a port of this patch to the IA64 architecture ?
> 
> not that i know of. If someone wants to do that, take a look at the 
> x86_64 changes (or ppc/mips/i386 changes) to get an idea. These are the 
> rough steps needed:
> 
>  - do the raw_spinlock_t/rwlock_t -> __raw_spinlock_t/rwlock_t rename
> 
>  - change the APIs in asm-ia64/semaphore.h (and arch files) to
>    compat_up()/down()/etc.
> 
>  - in the arch Kconfig, turn off RWSEM_XCHGADD_ALGORITHM if PREEMPT_RT.
> 
>  - add the TID_NEED_RESCHED_DELAYED logic to thread_info.h and the entry
>    assembly code.
> 
>  - change most/all spinlocks in arch/ia64 to raw_spinlock / RAW_SPINLOCK
> 
>  - change most/all seqlocks to raw_seqlock / RAW_SEQLOCK
> 
>  - add smp_send_reschedule_allbutself().
> 
>  - take a good look at the arch/x86_64/kernel/process.c changes and port
>    the need_resched_delayed() and __schedule() changes.
> 
> that should be at least 95% of what's needed. (the x86_64 port does a 
> couple of other things too, like latency tracing support, etc., but you 
> dont need those for the initial ia64 port.)

Thanks a lot for your reply, Ingo, and for these hints on how to begin.

	Simon.

