Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAIOl7>; Tue, 9 Jan 2001 09:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRAIOlj>; Tue, 9 Jan 2001 09:41:39 -0500
Received: from chiara.elte.hu ([157.181.150.200]:11788 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131314AbRAIOl1>;
	Tue, 9 Jan 2001 09:41:27 -0500
Date: Tue, 9 Jan 2001 15:40:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        <hch@caldera.de>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109141806.F4284@redhat.com>
Message-ID: <Pine.LNX.4.30.0101091532150.4368-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:

> > i used to think that this is useful, but these days it isnt. It's a waste
> > of PCI bandwidth resources, and it's much cheaper to keep a cache in RAM
> > instead of doing direct disk=>network DMA *all the time* some resource is
> > requested.
>
> No.  I'm certain you're right when talking about things like web
> serving, [...]

yep, i was concentrating on fileserving load.

> but it just doesn't apply when you look at some other applications,
> such as streaming out video data or performing fileserving in a
> high-performance compute cluster where you are serving bulk data.
> The multimedia and HPC worlds typically operate on datasets which are
> far too large to cache, so you want to keep them in memory as little
> as possible when you ship them over the wire.

i'd love to first see these kinds of applications (under Linux) before
designing for them. Eg. if an IO operation (eg. streaming video webcast)
does a DMA from a camera card to an outgoing networking card, would it be
possible to access the packet data in case of a TCP retransmit? Basically
these applications are limited enough in scope to justify even temporary
'hacks' that enable them - and once we *see* things in action, we could
design for them. Not the other way around.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
