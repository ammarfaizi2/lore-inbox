Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263446AbRFFByP>; Tue, 5 Jun 2001 21:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263450AbRFFByF>; Tue, 5 Jun 2001 21:54:05 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5648 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263446AbRFFBxz>; Tue, 5 Jun 2001 21:53:55 -0400
Date: Tue, 5 Jun 2001 18:53:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.6-B4
In-Reply-To: <Pine.LNX.4.33.0106051223010.3033-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.31.0106051850180.1990-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, what the heck are you up to?

entry.S:

+       xorl %ecx,%ecx; \
        testl SYMBOL_NAME(irq_stat)+4(,%eax),%ecx

That will always test as false. "testl" is an "and", not a "cmp". And a
binary "and" with zero always results in zero.

I would suggest:
 - remove the "cli". It only slow things down. If an interrupt comes in
   and causes a softirq, that interrupt routine will also run the softirq.

   (The "cli" may help the need_resched thing, but I doubt it matters, and
   if that's what you're trying to do then you should move it there,
   instead of having it at the softirq place).

 - fix the "testl"

 - send me a patch (relative to your B4 - I've applied it, but I want this
   fixed before I do a "pre2".

Thanks,

		Linus

