Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRJCRIq>; Wed, 3 Oct 2001 13:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276564AbRJCRIg>; Wed, 3 Oct 2001 13:08:36 -0400
Received: from chiara.elte.hu ([157.181.150.200]:57608 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276562AbRJCRIW>;
	Wed, 3 Oct 2001 13:08:22 -0400
Date: Wed, 3 Oct 2001 19:06:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        <Robert.Olsson@data.slu.se>, <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <200110031653.UAA13938@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0110031853220.8633-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001 kuznet@ms2.inr.ac.ru wrote:

> Ingo, "polling" is wrong name. It does not poll. :-)

ok. i was also mislead by a quick hack in the source code :)

> Actually, this misnomer is the worst thing whic I worried about.

i think something like: 'offloading hardirq work into softirqs' covers the
concept better, right?

> Citing my old explanation:
>
> > "Polling" is not a real polling in fact, it just accepts irqs as
> > events waking rx softirq with blocking subsequent irqs.
> > Actual receive happens at softirq.
> >
> > Seems, this approach solves the worst half of livelock problem
> > completely: irqs are throttled and tuned to load automatically.
> > Well, and drivers become cleaner.

i like this approach very much, and indeed this is not polling in any way.

i'm worried by the dev->quota variable a bit. As visible now in the
2.4.10-poll.pat and tulip-NAPI-010910.tar.gz code, it keeps calling the
->poll() function until dev->quota is gone. I think it should only keep
calling the function until the rx ring is fully processed - and it should
re-enable the receiver afterwards, when exiting net_rx_action.

	Ingo

