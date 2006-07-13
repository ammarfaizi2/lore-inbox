Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWGMHvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWGMHvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGMHvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:51:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55696 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964816AbWGMHvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:51:44 -0400
Date: Thu, 13 Jul 2006 09:46:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: Random panics seen in 2.6.18-rc1
Message-ID: <20060713074609.GA3620@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713004445.cf7d1d96.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Any suggestions of how to avoid the parameter passing? (without ugly 
> > #ifdeffery)
> 
> No, I don't see a way apart from inlining __cache_free(), or inlining 
> cache_free_alien() into both kfree() and kmem_cache_free(), both of 
> which are unattractive.

furthermore, cache_free_alien() is a NOP on non-NUMA, so the cost on 
non-NUMA is really small.

but ... i think gcc ought to be able to figure out that the parameter is 
totally unused on !LOCKDEP - all functions involved are static, and we 
are using -funit-at-a-time already. That should make the parameter 
passing totally zero-cost.

	Ingo
