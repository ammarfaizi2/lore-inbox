Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268559AbRGZRrR>; Thu, 26 Jul 2001 13:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbRGZRrH>; Thu, 26 Jul 2001 13:47:07 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:35077 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268559AbRGZRrB>;
	Thu, 26 Jul 2001 13:47:01 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107261746.VAA31697@ms2.inr.ac.ru>
Subject: Re: 2.4.7 softirq incorrectness.
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 26 Jul 2001 21:46:52 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010726002357.D32148@athlon.random> from "Andrea Arcangeli" at Jul 26, 1 00:23:57 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> At that time I checked loopback that runs under the bh so it's ok too.

Well, it was not alone. I just looked at couple of places, when
netif_rx was used. One is right, another (looping multicasts) is wrong. :-)

So, is plain raising softirq and leaving it raised before return
to normal context not a bug? If so, then no problems.
The worst, which can happen is that it will work as earlier, right?
And we are allowed to yuild bhs at any point, when we desire. Nice.

Actually, also I was afraid opposite thing: netif_rx was used to allow
to restart processing of skb, when we were in wrong context or were afraid
recursion. And the situation, when it is called with disabled irqs and/or
raised spinlock_irq (it was valid very recently!), is undetectable.
Actually, I hope such places are absent, networking core does not use
irq protection at all, except for netif_rx() yet. :-)


> after netif_rx.

But why not to do just local_bh_disable(); netif_rx(); local_bh_enable()?
Is this not right?

Alexey
