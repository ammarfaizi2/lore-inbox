Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbRE0UGP>; Sun, 27 May 2001 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbRE0UGF>; Sun, 27 May 2001 16:06:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262114AbRE0UFq>; Sun, 27 May 2001 16:05:46 -0400
Date: Sun, 27 May 2001 22:05:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, arjanv@redhat.com
Subject: Re: [patch] softirq-2.4.5-A1
Message-ID: <20010527220536.B731@athlon.random>
In-Reply-To: <20010527191249.I676@athlon.random> <Pine.LNX.4.33.0105272106340.5852-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105272106340.5852-100000@localhost.localdomain>; from mingo@elte.hu on Sun, May 27, 2001 at 09:08:51PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 09:08:51PM +0200, Ingo Molnar wrote:
> i took at look at your ksoftirq stuff yesterday, and i think it's
> completely unnecessery and adds serious overhead to softirq handling. The
> whole point of softirqs is to have maximum scalability and no
> serialization. Why did you add ksoftirqd, would you mind explaining it?

The only case ksoftirqd runs is when the stock kernel does the wrong
thing and potentially delays the softirq of 1/HZ. Nothing else.

When current kernel does the right thing ksoftirq cannot generate any
scalability problem and furthmore ksoftirqd is a per-cpu thing so if you
face a scalability problem with it that simply means you need to fix the
scheduler because then it means you would face a scalability issue as
well every time a tux thread calls schedule().

90% of the time ksoftirqd will never run, when it runs it means you want
to pay for a scheduler run to get it running. The price of the scheduler
is just the price for the logic that balance the softirq load in a fair
manner and without buggy latencies.

Andrea
