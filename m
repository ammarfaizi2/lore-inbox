Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWFSLon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWFSLon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFSLon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:44:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28841 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932362AbWFSLom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:44:42 -0400
Date: Mon, 19 Jun 2006 13:39:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to 1 min
Message-ID: <20060619113943.GA18321@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com> <20060617100710.ec05131f.akpm@osdl.org> <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org> <20060619081252.GA13176@elte.hu> <20060619013238.6d19570f.akpm@osdl.org> <20060619083518.GA14265@elte.hu> <20060619021314.a6ce43f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619021314.a6ce43f5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5454]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > The write_trylock + __delay in the loop is not a problem or a bug, as 
> > the trylock will at most _increase_ the delay - and our goal is to not 
> > have a false positive, not to be absolutely accurate about the 
> > measurement here.
> 
> Precisely.  We have delays of over a second (but we don't know how 
> much more than a second).  Let's say two seconds.  The NMI watchdog 
> timeout is, what?  Five seconds?

i dont see the problem. We'll have tried that lock hundreds of thousands 
of times before this happens. The NMI watchdog will only trigger if we 
do this with IRQs disabled. And it's not like the normal 
__write_lock_failed codepath would be any different: for heavily 
contended workloads the overhead is likely in the cacheline bouncing, 
not in the __delay().

> That's getting too close.  The result will be a total system crash.  
> And RH are shipping this.

I dont see a connection. Pretty much the only thing the loop condition 
impacts is the condition under which we print out a 'i think we 
deadlocked' message. Have i missed your point perhaps?

	Ingo
