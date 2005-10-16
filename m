Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVJPXDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVJPXDo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVJPXDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 19:03:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57754 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932083AbVJPXDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 19:03:43 -0400
Date: Mon, 17 Oct 2005 01:03:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <1129490809.1728.874.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0510170021050.1386@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509301825290.3728@scrub.home>  <1128168344.15115.496.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
  <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Oct 2005, Thomas Gleixner wrote:

> > The spec is not really clear and Thomas refusal to explain his design 
> > decision is as also not really helpful. :-(
> 
> I did explain, why I did the rounding in the way it is implemented. If
> you define the fact that I have a different interpretation of SUS than
> you as refusal, then we can stop this thread right here.

I have no problem with you having a different opinion, I have a problem 
with your childish behaviour. :-(
You completely ignore the rest of my mail, trying to establish some base 
definitions, which would help to figure out the options we have based on 
the spec. You instead just insist on your interpretation without going 
into any detail.

> > He sets the timer resolution to (NSEC_PER_SEC/HZ) which matches no value 
> > above and this way he basically creates another virtual timer, which has 
> > only little to do with the real kernel timer tick.
> 
> As George explained already we return the resolution of the timer as the
> value which can be assumed to be the resolution of the event source,
> which drives the timer, because that seems to be the only interesting
> value for an application programmer. The theoretical resolution of a
> jiffie based timer system is NSEC_PER_SEC/HZ. 

You still don't explain, how you you get to this conclusion based on the 
spec. Instead you redefine it now to useful assupmtions for application
programmers who can't read the spec...
You still completely leave the question unanswered of the possibility of 
different resolutions. We can still discuss what resolution to return with 
clock_getres(), but first we have to establish with what kind of resoltion 
we're dealing with here.

> I really don't see any sense in returning changing resolution values
> every 5 minutes due to NTP adjustments. I imagine the happiness of
> application programmers which actually do calculations based on such a
> resolution value.

Why are they doing this kind of calculations based on this value?
We can discuss returning a reasonable value for these applications, but I 
don't see how these assumptions should control how the kernel works.

> And in the logical consequence you would have to save the original
> userspace timespec value including the time when the timer is set up and
> redo the rounding and calculation every time NTP changes the
> NSEC_PER_TICK value for _all_ timers which are related to
> CLOCK_MONOTONIC and CLOCK_REALTIME. 

The rounding is done based on your interpretation of the spec, which you 
refuse to discuss. AFAICT the spec leaves enough room to avoid this 
rounding completely.

bye, Roman
