Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276347AbRJCPMN>; Wed, 3 Oct 2001 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276349AbRJCPMD>; Wed, 3 Oct 2001 11:12:03 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:57015 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276347AbRJCPLv>;
	Wed, 3 Oct 2001 11:11:51 -0400
Date: Wed, 3 Oct 2001 11:09:33 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <002c01c14c15$f270d6b0$010411ac@local>
Message-ID: <Pine.GSO.4.30.0110031101460.4833-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Manfred Spraul wrote:

> > On Wed, 3 Oct 2001, jamal wrote:
> > > On Wed, 3 Oct 2001, Ingo Molnar wrote:
> > > >
> > > > but the objectives, judging from the description you gave, are i
> > > > think largely orthogonal,  with some overlapping in the polling
> > > > part.
> > >
> > > yes. Weve done a lot of thoroughly thought work in that area and i
> > > think it will be a sin to throw it out.
> > >
> >
> > I hit the send button to fast..
> > The dynamic irq limiting (it must not be set by a system admin to
> > conserve the principle of work) could be used as a last resort.
> > The point is, if you are not generating a lot of interupts to begin
> > with (as is the case with NAPI), i dont see the irq rate limiting
> > kicking in at all.
>
> A few notes as seen for low-end nics:
>
> Forcing an irq limit without asking the driver is bad - it must be the
> opposite way around.
> e.g. the winbond nic contains a bug that forces it to 1 interrupt/packet
> tx, but I can switch to rx polling/mitigation.

Indeed this is a weird case that we have not encountered but it does make
the point that the driver knows best what to do.

> I'm sure the ne2k-pci users would also complain if a fixed irq limit is
> added - I bet the majority of the drivers perform worse with a fixed
> limit, only some perform better, and most perform best if they are given
> a notice that they should reduce their irq rate. (e.g. disable
> rx_packet, tx_packet. Leave the error interrupts on, and do the
> rx_packet, tx_packet work in the poll handler)
>

agreed. The reaction should be left to the driver's policy.

> But a hint for the driver ("now switch mitigation on/off") seems to be a
> good idea. And that hint should not be the return value of netif_rx -
> what if the driver is only sending packets?
> What if it's not even a network driver?

For 2.4, unfortunately there was no other way to pass that feedback
without the driver sending a packet up the stack. Our system feedback
probe is based on sampling the backlog queue.

> NAPI seems to be very promising to fix the total system overload case
> (so many packets arrive that despite irq mitigation the system is still
> overloaded).
>
> But the implementation of irq mitigation is driver specific, and a 10
> millisecond stop is far too long.
>

violent agreement.

cheers,
jamal


