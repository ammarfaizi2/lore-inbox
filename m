Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293527AbSCGO7S>; Thu, 7 Mar 2002 09:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293552AbSCGO7J>; Thu, 7 Mar 2002 09:59:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53633 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293527AbSCGO64>; Thu, 7 Mar 2002 09:58:56 -0500
Date: Thu, 7 Mar 2002 09:58:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_YIELD undeclared with Trond's NFS patch w/2.4.19-pre2-ac2
In-Reply-To: <3C877710.CAE1AFD3@redhat.com>
Message-ID: <Pine.LNX.3.95.1020307094743.19968A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Arjan van de Ven wrote:

>  
> > You need to change loops that do something like:
> > 
> >     while(something)
> >     {
> >         current->policy |= SCHED_YIELD;
> >         schedule();
> >     }
> > 
> >     to:
> > 
> >     while(something)
> >         sys_sched_yield();
> > 
> 
> such loops are a great way to create livelock and other nasties in the
> kernel
> and should be avoided at all cost (esp if you use preemptable kernels)
> -

Hardly.  The "something" is a bit in some hardware port that is
guaranteed to come true sometime. The driver should not spin on
the port, wasting valuable CPU cycles.

That said, if the kernel wants to control everything about how
it uses otherwise wasted CPU cycles, then we need a kernel
procedure that will execute a user-defined procedure, sort
of like wait_for_timeout(), but not waiting for a semaphore
because there are no CPU cycles available to change the semaphore.
Instead, the procedure takes a pointer to a procedure to be
executed. The procedure returns TRUE or FALSE. When true, the
wait_for_procedure() returns, when FALSE, it will be executed
again (or timeout). The actual procedure should be defined as
something that takes a (void *) to user's parameters and returns
an int. This makes it universal.

Also, it is well understood that these 'wait_for' thingies are
NOT executed in interrupt context.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

