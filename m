Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbSKQTyW>; Sun, 17 Nov 2002 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267570AbSKQTyW>; Sun, 17 Nov 2002 14:54:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12467 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267569AbSKQTyU>;
	Sun, 17 Nov 2002 14:54:20 -0500
Date: Sun, 17 Nov 2002 22:17:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037562875.1597.107.camel@ldb>
Message-ID: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Nov 2002, Luca Barbieri wrote:

> The new definition of the clone flags is binary incompatible with older
> 2.5 kernels.

we broke binary compatibility several times, for the benefit of having a
cleaner interface. Ulrich has no problems with this approach and NPTL is
the only user of these interfaces currently. But i think you are one of
the few peoples who are running an NPTL system (ie. with the new
NPTL-glibc actually installed as the default system glibc) - is binary
compatibility important to you for this specific case?

> > -#if CONFIG_SMP || CONFIG_PREEMPT
> > +asmlinkage void FASTCALL(schedule_tail(task_t *prev));
> >  asmlinkage void schedule_tail(task_t *prev)
> >  {
> >  	finish_arch_switch(this_rq(), prev);
> Maybe finish_arch_switch should only be called if CONFIG_SMP ||
> CONFIG_PREEMPT, like what happened without this patch?

finish_arch_switch() is a no-op on UP. (well, almost, i'll fix that.)

> > +	if (clone_flags & CLONE_PARENT_SETTID)
> > +		put_user(p->pid, parent_tidptr);
> How about failing if put_user fails?

we could do that - although we cannot fail the CHILD_SETTID variant, and i
wanted to keep it symmetric.

	Ingo

