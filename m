Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269052AbRG3Sup>; Mon, 30 Jul 2001 14:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269079AbRG3Sue>; Mon, 30 Jul 2001 14:50:34 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:27830 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269078AbRG3Su1>; Mon, 30 Jul 2001 14:50:27 -0400
Date: Mon, 30 Jul 2001 14:50:21 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: <kuznet@ms2.inr.ac.ru>
cc: Linus Torvalds <torvalds@transmeta.com>, <andrea@suse.de>,
        <maxk@qualcomm.com>, <linux-kernel@vger.kernel.org>,
        <davem@redhat.com>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
In-Reply-To: <200107291752.VAA19495@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0107301444430.28294-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > I think the latency issue was really the fact that we weren't always
> > running softirqs in a timely fashion after they had been disabled by a
> > "disable_bh()". That is fixed with the new softirq stuff, regardless of
> > the other issues.

nope. i observed latency issues with restart + ksoftirqd as well. [when i
first saw these latency problems i basically had ksoftirqd implemented
independently from your patch, and threw the idea away because it was
insufficient from the latency point of view.] Those latencies are harder
to observe because they are not 1/HZ anymore but several hundred millisecs
at most. Plus, like i said previously, pushing IRQ context work into a
scheduler-level context 'feels' incorrect to me - it only makes the
latencies less visible. I'll do some measurements.

	Ingo

