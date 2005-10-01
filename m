Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVJALWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVJALWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 07:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVJALWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 07:22:22 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29403 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750797AbVJALWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 07:22:22 -0400
Date: Sat, 1 Oct 2005 13:22:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051001112233.GA18462@elte.hu>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509301825290.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509301825290.3728@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > +/* The time bases */
> > +#define MAX_KTIMER_BASES	2
> > +static DEFINE_PER_CPU(struct ktimer_base, ktimer_bases[MAX_KTIMER_BASES]) =
> 
> Do you have any numbers (besides maybe microbenchmarks) that show a 
> real advantage by using per cpu data? What kind of usage do you expect 
> here?

it has countless advantages, and these days we basically only design 
per-CPU data structures within the kernel, unless some limitation (such 
as API or hw property) forces us to do otherwise. So i turn around the 
question: what would be your reason for _not_ doing this clean per-CPU 
design for SMP systems?

> The other thing is that this assumes, that all time sources are 
> programmable per cpu, otherwise it will be more complicated for a time 
> source to run the timers for every cpu, I don't know how safe that 
> assumption is. Changing the array of structures into an array of 
> pointers to the structures would allow to switch between percpu bases 
> and a single base.

yeah, and that's an assumption that simplifies things on SMP 
significantly. PIT on SMP systems for HRT is so gross that it's not 
funny. If anyone wants to revive that notion, please do a separate patch 
and make the case convincing enough ...

	Ingo
