Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275683AbRJAWuk>; Mon, 1 Oct 2001 18:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275686AbRJAWub>; Mon, 1 Oct 2001 18:50:31 -0400
Received: from chiara.elte.hu ([157.181.150.200]:64772 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275683AbRJAWuT>;
	Mon, 1 Oct 2001 18:50:19 -0400
Date: Tue, 2 Oct 2001 00:50:31 +0200 (CEST)
From: Ingo Molnar <mingo@chiara.elte.hu>
To: Tim Hockin <thockin@hockin.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Andrea Arcangeli <andrea@suse.de>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <200110012226.f91MQQe02638@www.hockin.org>
Message-ID: <Pine.LNX.4.21.0110020046430.2260-100000@chiara.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Oct 2001, Tim Hockin wrote:

> Our solution/needs are slightly different - we want to service as many
> interrupts as possible and do as much network traffic as possible, and
> interactive-tasks be damned.

i the patch in fact enables this too: you can more agressively get irqs
and softirqs executed by increasing max_rate just above the 'critical'
rate you can measure. (and the blocked-interrupts period of time will be
enough to let the softirq work to be finished.) So in fact you might even
end up having higher performance by blocking interrupts in a certain
portion of a timer tick - backlogged work will be processed. Via max_rate
you can partition the percentage of CPU time dedicated to softirq and
process work. (which in your case would be softirq-only work - which
should not be underestimated either.)

	Ingo

