Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280586AbRKSSd1>; Mon, 19 Nov 2001 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280556AbRKSSdU>; Mon, 19 Nov 2001 13:33:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45042 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S280572AbRKSSdH>; Mon, 19 Nov 2001 13:33:07 -0500
Message-ID: <3BF95037.EEE6F7C3@mvista.com>
Date: Mon, 19 Nov 2001 10:32:23 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Mike Kravetz <kravetz@us.ibm.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com> <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com> <20011119173022.A19740@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Fri, Nov 16, 2001 at 04:32:24PM -0800, Mike Kravetz wrote:
> > The reason I ask is that we went through the pains of a separate
> > realtime RQ in our MQ scheduler.  And yes, it does hurt the common
> > case, not to mention the extra/complex code paths.  I was hoping
> > that someone in the know could enlighten us as to how RT semantics
> > apply to SMP systems.  If the semantics I suggest above are required,
> > then it implies support must be added to any possible future
> > scheduler implementations.
> 
> It seems a lot of applications/APIs do not care about global RT semantics,
> but about RT semantics for groups of threads or processes (e.g. java
> or ada applications). Linux currently simulates this only for root
> and with a global runqueue. 

Why do you say only root?  Since the schedule type and priority are
inherited one only needs to be root to set the progenitors real time
priority.  Also, a programs priority/ schedule type can be set by
another (root) program without the target program being root.  I
routinely set inetd to real time, for example, to let telnet sessions
run at real time.

> I don't think it makes too much sense to have
> an global rt queue on a multi processor system, but there should be some
> way to define "scheduling groups" where rt semantics are followed inside.

Still, the customer is king.

> Such a scheduling group could be a clone flag or default to CLONE_VM for
> example for compatibility.  A scheduling group would also make it possible
> to support simple rt semantics for thread groups as non root.  Then one
> could run a rt queue per scheduling group, and simulate global rt run queue
> or per cpu rt run queue as needed by appropiate setup.

My first thought is that this is fairly high overhead to put in the
schedule path.  May be if I knew more....


-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
