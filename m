Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWBTJIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWBTJIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBTJIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:08:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26275 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932396AbWBTJIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:08:22 -0500
Date: Mon, 20 Feb 2006 10:06:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Robust futexes
Message-ID: <20060220090639.GC22445@elte.hu>
References: <1140152271.25078.42.camel@localhost.localdomain> <20060216224207.98526b40.pj@sgi.com> <1140160371.25078.81.camel@localhost.localdomain> <20060216232950.efa39e13.pj@sgi.com> <20060217091307.GB22718@elte.hu> <1140234812.2418.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140234812.2418.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> > the fundamental problem i see here: how do you 'declare' a TID as dead?  
> > 32-bit TIDs can be reused, quite fundamentally.
> 
> Yes.  I was asking of we actually need prefect robustness. [...]

yes - we need at a minimum robustness that will work for all sane 
workloads. If we make applications rely on it, we should offer an 
implementation that works under well-specified circumstances. "The 
feature might not work if some other, unrelated application happens 
churn more than 32768 threads" is not well-specified. [not to talk about 
the problems with the upcoming POSIX specification: we certainly wont be 
able to claim to support the feature, if it doesnt reliably work under 
an easily reproducible, normal workload.]

> [...] I'm fairly confident that this approach would work well in 
> practice, since if tids are being churned, the thread with wrapped TID 
> will exit soon anyway.

we cannot assume that - e.g. if there are two unrelated apps, one a 
fast-churner, and another one relying on robust mutexes.

> As an added bonus, the tone of the first response I received (not 
> yours!) reminded me why I am not subscribed to lkml...

hey, if that response is deemed as too confrontational, then i'd have to 
discard 97% of the lkml responses i get to patches ;-) Another thing is 
that this particular topic was pretty hotly discussed from the onset, 
which could easily have carried over into other replies as well. So i'd 
really not take it personal.

	Ingo
