Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277054AbRJDA4P>; Wed, 3 Oct 2001 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277057AbRJDA4F>; Wed, 3 Oct 2001 20:56:05 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:54712 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277054AbRJDAzr>;
	Wed, 3 Oct 2001 20:55:47 -0400
Date: Wed, 3 Oct 2001 20:53:28 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031749030.8633-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110031848220.7244-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ingo Molnar wrote:

>
> On Wed, 3 Oct 2001, jamal wrote:
>
> > use the netif_rx() return code and hardware flowcontrol to fix it.
>
> i'm using hardware flowcontrol in the patch, but at a different, higher
> level. This part of the do_IRQ() code disables the offending IRQ source:
>
> 	[...]
>         desc->status |= IRQ_MITIGATED|IRQ_PENDING;
>         __disable_irq(desc, irq);
>
> which in turn stops that device as well sooner or later. Optionally, in
> the future, this can be made more finegrained for chipsets that support
> device-independent IRQ mitigation features, like the USB 2.0 EHCI feature
> mentioned by David Brownell.
>

I think each subsytem should be in charge of its own fate. USB applies in
whatever subsystem it belongs to. Cooperating subsystems doing what os
best for the system.

> i'd prefer it if all subsystems and drivers in the kernel behaved properly
> and limited their IRQ load - but this does not always happen and users are
> hit by irq overload situations.
>

Your patch with Linus' idea of "flag mask" would be more acceptable as a
last resort. All subsytems should be cooperative and we resort to this to
send misbehaving kids to their room.

> Your NAPI patch, or any driver/subsystem that does flowcontrol accurately
> should never be affected by it in any way. No overhead, no performance
> hit.

so far your appraoch is that of a shotgun i.e  "let me fire in
that crowd and i'll hit my target but dont care if i take down a few
more"; regardless of how noble the reasoning is, it's  as Linus described
it -- a sledge hammer.

cheers,
jamal


