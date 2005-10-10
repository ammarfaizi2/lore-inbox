Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVJJMnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVJJMnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 08:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVJJMnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 08:43:06 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13793 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750761AbVJJMnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 08:43:05 -0400
Date: Mon, 10 Oct 2005 14:42:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051001112233.GA18462@elte.hu>
Message-ID: <Pine.LNX.4.61.0510100155330.3728@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509301825290.3728@scrub.home> <20051001112233.GA18462@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 1 Oct 2005, Ingo Molnar wrote:

> > Do you have any numbers (besides maybe microbenchmarks) that show a 
> > real advantage by using per cpu data? What kind of usage do you expect 
> > here?
> 
> it has countless advantages, and these days we basically only design 
> per-CPU data structures within the kernel, unless some limitation (such 
> as API or hw property) forces us to do otherwise. So i turn around the 
> question: what would be your reason for _not_ doing this clean per-CPU 
> design for SMP systems?

Did I say I'm against it? No, I was just hoping someone put some more 
thought into it than just "all the other kids are doing it".
I was just curious how well it really scales compared to the simple 
version, e.g. what happens if most timer end up on a single cpu or what 
happens if we want to start the timer on a different cpu. Is this so wrong 
that you have to go into attack mode? :(

> > The other thing is that this assumes, that all time sources are 
> > programmable per cpu, otherwise it will be more complicated for a time 
> > source to run the timers for every cpu, I don't know how safe that 
> > assumption is. Changing the array of structures into an array of 
> > pointers to the structures would allow to switch between percpu bases 
> > and a single base.
> 
> yeah, and that's an assumption that simplifies things on SMP 
> significantly. PIT on SMP systems for HRT is so gross that it's not 
> funny. If anyone wants to revive that notion, please do a separate patch 
> and make the case convincing enough ...

Why do use "PIT on SMP" as an extreme example to reject the general 
concept completely? This doesn't explain, why first such a (simple) SMP 
design shouldn't exist and why secondly my suggestion is such a big 
problem.

bye, Roman
