Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSFQDfZ>; Sun, 16 Jun 2002 23:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSFQDfY>; Sun, 16 Jun 2002 23:35:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:495 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316675AbSFQDfY>; Sun, 16 Jun 2002 23:35:24 -0400
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
From: Robert Love <rml@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206170503380.2941-100000@e2>
References: <Pine.LNX.4.44.0206170503380.2941-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jun 2002 20:35:00 -0700
Message-Id: <1024284900.3090.44.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 20:24, Ingo Molnar wrote:

> On 16 Jun 2002, Robert Love wrote:
> 
> > > +int idle_cpu(int cpu)
> > > +{
> > > +	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
> > > +}
> > > +
> > 
> > I did not include this in my original O(1) backport update because
> > nothing in 2.4-ac seems to use it... so why include it?
> 
> i have planned to submit the irqbalance patch for 2.4-ac real soon, which
> needs this function - current IRQ distribution on P4 SMP boxes is a
> showstopper.

Fair enough.

> > >  - sched_setaffinity() & sched_getaffinity() syscalls on x86.
> >
> > Do we want to introduce this into 2.4 now?  I realize 2.4-ac is not 2.4
> > proper, but if there is a chance this interface could change...
> 
> the setaffinity()/getaffinity() interface looks pretty robust, i dont
> expect any changes - there's just so many ways to set an affinity mask for
> an opaque set of CPUs. And being able to set affinities is something that
> was frequently asked for by application developers.

I agree it seems robust and there have been no complaints, although
there could always be changes to the interface.  Personally I'd like the
interfaces in 2.4/2.4-ac sooner rather than later too - I just want to
make sure we do not "etch it in stone" prematurely.

> IMO BUG_ON() is just an ugly way of doing an assert(), i dont like code
> with magic conditionals embedded within. But, the main reason was that
> 2.5-mainline has the code so that's being used.

Heh I like BUG_ON :-)

> like above, 2.5 is the reference base. Especially for 100% nonfunctional
> things like this it makes no sense to apply them to 2.4-ac only. But i
> agree that existing comment fixes should be forward ported into 2.5, i've
> applied them to my tree.

I agree the changes are nonfunctional and thus not a big deal...but I
didn't see a point in pushing erroneous changes onto 2.4-ac, whether
they are in 2.5 or not.

Although now it is all a moot point - Linus merged the patch I posted
earlier with the 2.4-ac bits against 2.5... so now a diff of 2.4-ac and
2.5 will be proper. ;-)

	Robert Love

