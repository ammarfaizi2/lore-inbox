Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276938AbRJCSZs>; Wed, 3 Oct 2001 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276936AbRJCSZj>; Wed, 3 Oct 2001 14:25:39 -0400
Received: from chiara.elte.hu ([157.181.150.200]:265 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276840AbRJCSZd>;
	Wed, 3 Oct 2001 14:25:33 -0400
Date: Wed, 3 Oct 2001 20:23:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <200110031811.f93IBoN10026@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110032011300.10924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, Linus Torvalds wrote:

> Now test it again with the disk interrupt being shared with the
> network card.
>
> Doesn't happen? It sure does. [...]

yes, disk IRQs might be delayed in that case. Without this mechanizm there
is a lockup.

> Which is why I like the NAPI approach.  If somebody overloads my
> network card, my USB camera doesn't stop working.

i agree that NAPI is a better approach. And IRQ overload does not happen
on cards that have hardware-based irq mitigation support already. (and i
should note that those cards will likely perform even faster with NAPI.)

> I don't disagree with your patch as a last resort when all else fails,
> but I _do_ disagree with it as a network load limiter.

okay - i removed those parts already (kpolld) in today's patch. (It
initially was an experiment to prove that this is the only problem we are
facing under such loads.)

	Ingo

