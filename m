Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276165AbRI1Q5j>; Fri, 28 Sep 2001 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276170AbRI1Q5a>; Fri, 28 Sep 2001 12:57:30 -0400
Received: from [195.223.140.107] ([195.223.140.107]:16373 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276165AbRI1Q5Z>;
	Fri, 28 Sep 2001 12:57:25 -0400
Date: Fri, 28 Sep 2001 18:58:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, bcrl@redhat.com
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928185800.M24922@athlon.random>
In-Reply-To: <20010928183244.K24922@athlon.random> <Pine.LNX.4.33.0109281835370.8840-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109281835370.8840-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Sep 28, 2001 at 06:46:16PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 06:46:16PM +0200, Ingo Molnar wrote:
> 
> On Fri, 28 Sep 2001, Andrea Arcangeli wrote:
> 
> > he's allowing to repeat the loop more than once to hide it, [...]
> 
> it's not done to 'hide' it in any way. I removed the mask method because
> it's redundant under the new scheme.

What you are missing is a property provided by the old method.

We have the NET_RX_SOFTIRQ that floods very heavily, so far so good.

Then we have HI_SOFTIRQ, incidentally HI_SOFTIRQ from irq wants to be
executed with very low latency, with your patch it _can_ be postpone to
ksoftirqd processing just because there's the NET_RX_SOFTIRQ cpu hog in
background. With the old method it was guaranteed that the HI_SOFTIRQ
was executed with very low latency within the irq, no matter of the
NET_RX_SOFTIRQ flood.

So there _is_ a difference, and the multiple-loop will tend to "hide"
the difference.

Andrea
