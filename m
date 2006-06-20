Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWFTJjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWFTJjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWFTJjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:39:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38106 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965095AbWFTJjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:39:36 -0400
Date: Tue, 20 Jun 2006 11:34:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org, Dave Olson <olson@unixfolk.com>
Subject: Re: [patch] fix spinlock-debug looping
Message-ID: <20060620093433.GB11037@elte.hu>
References: <20060619081252.GA13176@elte.hu> <20060619013238.6d19570f.akpm@osdl.org> <20060619083518.GA14265@elte.hu> <20060619021314.a6ce43f5.akpm@osdl.org> <20060619113943.GA18321@elte.hu> <20060619125531.4c72b8cc.akpm@osdl.org> <20060620084001.GC7899@elte.hu> <20060620015259.dab285d5.akpm@osdl.org> <20060620091505.GA9749@elte.hu> <20060620023216.4995edb9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620023216.4995edb9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Spinlocks are alot fairer. Or as a simple experiment, 
> > s/read_lock/write_lock, as the patch below (against rc6-mm2) does. 
> > This is phase #1, if it works out we can switch tree_lock to a 
> > spinlock. [write_lock()s are roughly as fair to each other as 
> > spinlocks - it's a bit more expensive but not significantly] Builds 
> > & boots fine here.
> 
> tree_lock was initially an rwlock.  Then we made it a spinlock.  Then 
> we made it an rwlock.  We change the dang thing so often we should 
> make it a macro ;)

ha! In -rt we can change types of locks by changing the type definition 
and the declaration only ;-) [It makes for some confusing reading though 
if done without restraint]

> Let's just make it a spinlock and be done with it.  Hopefully Dave or 
> ccb@acm.org (?) will be able to test it.  I was planning on doing a 
> patch tomorrowish.

ok. Until that happens the patch i sent can be used for testing.

	Ingo
