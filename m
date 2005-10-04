Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVJDFu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVJDFu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVJDFu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:50:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17590 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932354AbVJDFu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:50:58 -0400
Date: Tue, 4 Oct 2005 07:51:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051004055111.GA20208@elte.hu>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509301825290.3728@scrub.home> <20051001112233.GA18462@elte.hu> <4341E206.3090204@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4341E206.3090204@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> > yeah, and that's an assumption that simplifies things on SMP 
> > significantly. PIT on SMP systems for HRT is so gross that it's not 
> > funny. If anyone wants to revive that notion, please do a separate 
> > patch and make the case convincing enough ...
>
> Lets not talk about PIT, but, a lot of SMP platforms do NOT have per 
> cpu timers.  For those, it would seem having per cpu lists to handle 
> the timer is not really reasonable.

frankly, such systems are rare, and are an afterthought at most. Think 
about it: 8 CPUs and only one hres timer source? It cannot work nor 
scale well.

i agree that they might eventually be handled (although i think we 
shouldnt bother, all sane SMP designs have per-CPU timers), but we 
definite wont design for them. What such an architecture has to do is to 
provide the proper do_hr_timer_int() and arch_hrtimer_reprogram() 
semantics, via locking around that timer source (naturally), and via 
cross-CPU calls - as if they were per-CPU timers.

	Ingo
