Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVF2XDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVF2XDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVF2XDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:03:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45857
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262722AbVF2XDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:03:11 -0400
Date: Thu, 30 Jun 2005 01:03:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050629230308.GC6421@g5.random>
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629225734.GA23793@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 03:57:34PM -0700, Bill Huey wrote:
> Did you compile your host Linux kernel with CONFIG_SMP in place ? That's
> critical since a UP kernel removes both spinlock and blocking locks in
> critical paths makes micro benchmarks sort of invalid.

Why should he compile with CONFIG_SMP when CONFIG_SMP is absolutely
unnecessary without preempt-RT?

If you're an embedded developer, and you're _not_ using preempt-RT, why
in your right mind would you compile your kernel with CONFIG_SMP
enabled if you've only 1 cpu and no SMP in the hardware?

> I suggest that you compile the dual kernel with SMP turned on and try it
> again, otherwise it's not really testing the overhead of any of the locking
> for either the PREEMPT_RT or dual kernel set ups. That's really the only
> outstanding statistic that I've noticed in that benchmark.

On UP the overhead of the spinlocks is measurable but it doesn't have
such huge order of magnitude, so even if you would enable CONFIG_SMP
(which makes absolutely no sense since embedded developers have 1 cpu to
deal with), you'd still underperform greatly compared to only
CONFIG_SMP=y. So even if somebody could buy that the benchmark is unfair
with CONFIG_SMP=n, I can just tell you that comparing against
CONFIG_SMP=y isn't going to save preempt-rt.
