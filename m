Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVJJOE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVJJOE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVJJOE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:04:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53987 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750806AbVJJOE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:04:27 -0400
Date: Mon, 10 Oct 2005 16:04:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051010140420.GA30736@elte.hu>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509301825290.3728@scrub.home> <20051001112233.GA18462@elte.hu> <Pine.LNX.4.61.0510100155330.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510100155330.3728@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > Do you have any numbers (besides maybe microbenchmarks) that show a 
> > > real advantage by using per cpu data? What kind of usage do you expect 
> > > here?
> > 
> > it has countless advantages, and these days we basically only design 
> > per-CPU data structures within the kernel, unless some limitation (such 
> > as API or hw property) forces us to do otherwise. So i turn around the 
> > question: what would be your reason for _not_ doing this clean per-CPU 
> > design for SMP systems?
> 
> Did I say I'm against it? No, I was just hoping someone put some more 
> thought into it than just "all the other kids are doing it". I was 
> just curious how well it really scales compared to the simple version, 
> e.g. what happens if most timer end up on a single cpu or what happens 
> if we want to start the timer on a different cpu. Is this so wrong 
> that you have to go into attack mode? :(

[ sorry, and i didnt go into 'attack mode'. I believe you'll distinctly 
  notice when i do that :-) ]

just think NUMA, and the generic advantages of PER_CPU become obvious.  
(via PER_CPU the different data structures indexed can properly end up 
on another domain's RAM, and can thus improve caching characteristics.)

	Ingo
