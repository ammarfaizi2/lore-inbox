Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280556AbRKSSk1>; Mon, 19 Nov 2001 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbRKSSkS>; Mon, 19 Nov 2001 13:40:18 -0500
Received: from ns.suse.de ([213.95.15.193]:2311 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280583AbRKSSkJ>;
	Mon, 19 Nov 2001 13:40:09 -0500
Date: Mon, 19 Nov 2001 19:40:08 +0100
From: Andi Kleen <ak@suse.de>
To: george anzinger <george@mvista.com>
Cc: Andi Kleen <ak@suse.de>, Mike Kravetz <kravetz@us.ibm.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
Message-ID: <20011119194008.A29396@wotan.suse.de>
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com> <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com> <20011119173022.A19740@wotan.suse.de> <3BF95037.EEE6F7C3@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3BF95037.EEE6F7C3@mvista.com>; from george@mvista.com on Mon, Nov 19, 2001 at 10:32:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 10:32:23AM -0800, george anzinger wrote:
> Andi Kleen wrote:
> > 
> > On Fri, Nov 16, 2001 at 04:32:24PM -0800, Mike Kravetz wrote:
> > > The reason I ask is that we went through the pains of a separate
> > > realtime RQ in our MQ scheduler.  And yes, it does hurt the common
> > > case, not to mention the extra/complex code paths.  I was hoping
> > > that someone in the know could enlighten us as to how RT semantics
> > > apply to SMP systems.  If the semantics I suggest above are required,
> > > then it implies support must be added to any possible future
> > > scheduler implementations.
> > 
> > It seems a lot of applications/APIs do not care about global RT semantics,
> > but about RT semantics for groups of threads or processes (e.g. java
> > or ada applications). Linux currently simulates this only for root
> > and with a global runqueue. 
> 
> Why do you say only root?  Since the schedule type and priority are

You effectively need to be root to set up the priorities at least once.
setuid programs are a big pain to use and a lot of people don't want them.

Also it is useful to change priorities on the fly, e.g. to avoid
priority inheritance problems. 

> > I don't think it makes too much sense to have
> > an global rt queue on a multi processor system, but there should be some
> > way to define "scheduling groups" where rt semantics are followed inside.
> 
> Still, the customer is king.

Hmm?

> 
> > Such a scheduling group could be a clone flag or default to CLONE_VM for
> > example for compatibility.  A scheduling group would also make it possible
> > to support simple rt semantics for thread groups as non root.  Then one
> > could run a rt queue per scheduling group, and simulate global rt run queue
> > or per cpu rt run queue as needed by appropiate setup.
> 
> My first thought is that this is fairly high overhead to put in the
> schedule path.  May be if I knew more....

The only overhead as far as I can see would be a few more pointer
references for RT processes (task->runqueue-> ...). I guess with
some care it can be even kept out of the non RT fast path. 

-Andi
