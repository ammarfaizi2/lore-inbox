Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTLUBki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTLUBki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:40:38 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:53124
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S261950AbTLUBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:40:36 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031220174232.GA29189@elte.hu>
References: <1071885178.1044.227.camel@localhost>
	 <3FE3B61C.4070204@cyberone.com.au> <200312201355.08116.kernel@kolivas.org>
	 <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au>
	 <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au>
	 <1071897314.1363.43.camel@localhost> <20031220111917.GA18267@elte.hu>
	 <1071938978.1025.48.camel@localhost>  <20031220174232.GA29189@elte.hu>
Content-Type: text/plain
Message-Id: <1071970825.1025.87.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 02:40:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 18:42, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > > yep, i've looked at the source too and it doesnt do anything that 
> > > changed in 2.6 from an interactivity POV.
> > 
> > Stefan Bruens pointed out on the gnomemeeting-devel list that pwlib
> > which gnomemeeting is using executes sched_yield and that perhaps
> > there is a problem akin to the openoffice busy-loop on sched_yield()
> > problem earlier this year. I found the following sched_yield code in
> > pwlib 1.5.2 in src/ptlib/unix/tlibthrd.cxx:
> 
> ah! I suspected something like this, that's why i looked at the source,
> but i didnt check dependent libs ...
> 
> >     if (++retry < 1000) {
> > #if defined(P_RTEMS)
> >       sched_yield();
> 
> > Is this obviously broken for 2.6 usage ?
> 
> 
> yes, very definitely broken. For one, it does not provide predictable
> timing - 1000 loops of sched_yield() can be very different on different
> CPUs. But the main problem is that on 2.6 sched_yield() is much more
> agressive. Something like this was fixed in OpenOffice earlier this
> year, and it improved interactivity quite visibly. Could you remove the
> sched_yield() and replace it with a 20 msec nanosleep (and keep the rety
> loop to 100)? Does that make any difference?

I tried to verify your suggestion and found that the P_RTEMS symbol is
not defined on Linux. It seems to be some other kind of realtime
operating system. So the code in question already uses usleep. Now I'm
still digging for other occurances of sched_yield in the pwlib sources.

I'll keep you posted with further facts.


			Christian

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




