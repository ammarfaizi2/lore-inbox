Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVE0MO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVE0MO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVE0MOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:14:38 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:37385 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262447AbVE0MOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:14:24 -0400
Date: Fri, 27 May 2005 05:08:12 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527120812.GA375@nietzsche.lynx.com>
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296ADE9.50805@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 03:19:37PM +1000, Nick Piggin wrote:
> For example, suppose you have preemptible everything, and priority
> inheritance and that's all nice. But the actual time in which
> some thread holds a lock is time that no other thread can take
> that lock either, regardless of its priority.

Ingo just answered it and I commonly touch on this subject off and on
and including this thread recently.

> So in that sense, if you do hard RT in the Linux kernel, it surely
> is always going to be some subset of operations, dependant on
> exact locking implementation, other tasks running and resource usage,
> right?
... 
> It appears to me (uneducated bystander, remember) that a nanokernel
> running a small hard-rt kernel and Linux together might be "better"
> for people that want real realtime.

I answered this already in this thread with the digression about RTAI.
I believe that it is a clear explanation but it's a bit out of the box
so to speak since it's looking towards more sophisticated uses of this
patch from an overall software design point of view.

> Just from the point of view of making the RT kernel as small and easy
> to verify as possible, and not having to provide for general purpose
> non-RT tasks. Then you also get the benefit of not having to make the
> general purpose Linux support hard real time.

There's really no good reason why this kernel can't get the same latency
as a nanokernel. The scheduler paths are riddled with SMP rebalancing
stuff and the like which contributes to overall system latency. Remove
those things and replace it with things like direct CPU pining and you'll
start seeing those numbers collapse. There are also TLB issues, but there
are many way of reducing and stripping down this kernel to reach so called
nanokernel times. Nanokernel times are overidealized IMO. It's not
because of design necessarily, but because of implementation issues that
add more latency to the deterministic latency time constant.

Just a thread wake operation under an 2x SMP box flattens the latency
histogram from a 8 usec spike to a 10-22 usec spread (800mhz p3 2x)
roughly. There are many more spots that contribute to latency that can
be made static or precomputed in some way.

RT priority thread rebalancing and IPI send off adds to this rescheduling
latency as well.
 
> For example, if your RT kernel had something like a tasklist lock, it
> may have an upper limit on the number of processes, or put in restart
> points where lower priority processes drop the lock and restart what
> they were doing if a high prio process one comes along - obviously
> neither solution would fly for the Linux tasklist lock.
> 
> Or have I missed something completely? You RT guys have thought about
> it - so what are some pros of the Linux-RT patch and/or cons of the
> nanokernel approach, please?

Again, I think I answered this in the RTAI discussion in this thread.
If you can groke my lingo then it should lay a kind of design track
where this kind of kernel design can be easier and more flexible to
work with in regards to future kernel subsystem alterations.
 
> [ And again, please don't say why Ingo's RT patch should go in, I'm
>   not talking about any patch, any merging of patches or even that
>   some hypothetical patch *shouldn't* go in - even if it does have
>   above problem ;) ]

Shut up :)
 
> Thanks very much,

bill

