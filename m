Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276234AbRI1Stu>; Fri, 28 Sep 2001 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276236AbRI1Stl>; Fri, 28 Sep 2001 14:49:41 -0400
Received: from chiara.elte.hu ([157.181.150.200]:44815 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276234AbRI1StW>;
	Fri, 28 Sep 2001 14:49:22 -0400
Date: Fri, 28 Sep 2001 20:47:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Simon Kirby <sim@netnation.com>
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.10-B2
In-Reply-To: <20010928113648.A21266@netnation.com>
Message-ID: <Pine.LNX.4.33.0109282041390.10458-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Simon Kirby wrote:

> Actually, I just tested my while(1) sendto() UDP spamming program on
> an Acenic card and noticed that it seems to do some sort of batching /
> grouping, because the number of interrupts reported by vmstat is only
> 8,000 while it's easily 75,000 on other eepro100 boxes.
> Interesting...

yes, acenic.c (and the card itself) supports irq-rate limitation and
work-coalescing. Almost all gigabit cards do. Check out the tx_coal_tick,
rx_coal_tick, max_tx_dsc, max_rx_desc tunables that can be set at insmod
time. Note that this does not decrease the amount of work generated, but
it will reduce the irq-processing overhead significantly.

The eepro100 card does not provide such ways - there the only way to stop
future interrupts from happening is to stop the receiver, or to not refill
the rx-skb queue. (or disable the interrupt, which is a pretty crude and
inaccurate method.)

	Ingo

