Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274964AbRJDJYs>; Thu, 4 Oct 2001 05:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbRJDJYj>; Thu, 4 Oct 2001 05:24:39 -0400
Received: from chiara.elte.hu ([157.181.150.200]:42505 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S274964AbRJDJYZ>;
	Thu, 4 Oct 2001 05:24:25 -0400
Date: Thu, 4 Oct 2001 11:22:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBC29A4.7080209@wipro.com>
Message-ID: <Pine.LNX.4.33.0110041119060.5309-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Oct 2001, BALBIR SINGH wrote:

> Ingo, is it possible to provide an interface (optional interface) to
> drivers, so that they can decide how many interrupts are too much.

well, it existed, and i can add it back - i dont have any strong feelings
either.

> Drivers who feel that they should go in for interrupt mitigation have
> the option of deciding to go for it.

in those cases the 'irq overload' code should not trigger. It's not the
rate of interrupts that matters, it's the amount of time we spend in irq
contexts. The code counts the number of times we 'interrupt and interrupt
context'. Interrupting an irq-context is a sign of irq overload. The code
goes into 'overload mode' (and disables that particular interrupt source
for the rest of the current timer tick) only if more than 97% of all
interrupts from that source 'interrupt and irq context'. (ie. irq load is
really high.) As any statistical method it has some inaccuracy, but
'statistically' it gets things right.

	Ingo

