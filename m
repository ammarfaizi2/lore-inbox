Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276968AbRJDGhO>; Thu, 4 Oct 2001 02:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277137AbRJDGhE>; Thu, 4 Oct 2001 02:37:04 -0400
Received: from chiara.elte.hu ([157.181.150.200]:21513 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276968AbRJDGgz>;
	Thu, 4 Oct 2001 02:36:55 -0400
Date: Thu, 4 Oct 2001 08:35:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <bcrl@redhat.com>,
        <netdev@oss.sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031828100.7244-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110040831020.1727-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> > i'm worried by the dev->quota variable a bit. As visible now in the
> > 2.4.10-poll.pat and tulip-NAPI-010910.tar.gz code, it keeps calling the
> > ->poll() function until dev->quota is gone. I think it should only keep
> > calling the function until the rx ring is fully processed - and it should
> > re-enable the receiver afterwards, when exiting net_rx_action.
>
> This would result in an unfairness. Think of one device which receives
> packets really fast that it takes most of the CPU capacity just
> processing it.

no, i asked something else.

i'm asking the following thing. dev->quota, as i read the patch now, can
cause extra calls to ->poll() even though the RX ring of that particular
device is empty and the driver has indicated it's done processing RX
packets. (i'm now assuming that the extra-polling-for-a-jiffy line in the
current patch is removed - that one is a showstopper to begin with.) Is
this claim of mine correct?

	Ingo

