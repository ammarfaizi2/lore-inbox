Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbRE0TK4>; Sun, 27 May 2001 15:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbRE0TKq>; Sun, 27 May 2001 15:10:46 -0400
Received: from chiara.elte.hu ([157.181.150.200]:47368 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261535AbRE0TKh>;
	Sun, 27 May 2001 15:10:37 -0400
Date: Sun, 27 May 2001 21:08:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <arjanv@redhat.com>
Subject: Re: [patch] softirq-2.4.5-A1
In-Reply-To: <20010527191249.I676@athlon.random>
Message-ID: <Pine.LNX.4.33.0105272106340.5852-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 May 2001, Andrea Arcangeli wrote:

> an irq that could mark the softirq active under entry.S will also run
> do_softirq itself before iret to entry.S. [...]

yep.

> [...] If the softirq remains active after an irq it it because it was
> marked active again under do_softirq and ksoftirq is the way to go for
> fixing that case I think.

i took at look at your ksoftirq stuff yesterday, and i think it's
completely unnecessery and adds serious overhead to softirq handling. The
whole point of softirqs is to have maximum scalability and no
serialization. Why did you add ksoftirqd, would you mind explaining it?

	Ingo

