Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752302AbWCNHbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbWCNHbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbWCNHbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:31:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:25549 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752271AbWCNHbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:31:50 -0500
Date: Tue, 14 Mar 2006 08:29:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: Which kernel is the best for a small linux system?
Message-ID: <20060314072921.GA13969@elte.hu>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org> <20060314062144.GC21493@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314062144.GC21493@w.ods.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Willy Tarreau <willy@w.ods.org> wrote:

> scheduler is still a big problem. Not only we occasionally see people 
> complaining about unfair CPU distribution across processes (may be 
> fixed now), but the scheduler still gives a huge boost to I/O 
> intensive tasks which do lots of select() with small time-outs, which 
> makes it practically unusable in network-intensive environments. I've 
> observed systems on which it was nearly impossible to log in via SSH 
> because of this, and I could reproduce the problem locally to create a 
> local DoS where a single user could prevent anybody from logging in.  
> 2.6.15 has improved a lot on this (pauses have reduced from 35 seconds 
> to 4 seconds) but it's still not very good.

i think we've talked about your specific case before, and lets not drop 
it on the floor. IIRC you have some special workload (driven by serial 
lines?) which behaves interactively and which thus gets too much 
boosting.

the passive methods: did you try to mute its impact by renicing it to +5 
or +10? If you know that a workload is not interactive, despite it 
behaving so, you can always prevent it from getting too much attention.  
There's also SCHED_BATCH in 2.6.16-ish kernels.

and there are some active methods as well: you might want to try Mike 
Galbraith's scheduler throttling feature:

 http://lkml.org/lkml/2006/3/3/59
 http://lkml.org/lkml/2006/3/3/63

(which we could try in -mm too perhaps, perhaps Mike has an updated 
patch for 2.6.16-rc6-mm1?)

	Ingo
