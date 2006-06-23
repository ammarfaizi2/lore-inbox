Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933010AbWFWKtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbWFWKtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933008AbWFWKtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:49:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:22942 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933010AbWFWKtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:49:06 -0400
Date: Fri, 23 Jun 2006 12:44:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 27/61] lock validator: prove spinlock/rwlock locking correctness
Message-ID: <20060623104411.GP4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212523.GA3155@elte.hu> <20060529183512.38a6e367.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183512.38a6e367.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 29 May 2006 23:25:23 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > +# define spin_lock_init_key(lock, key)				\
> > +	__spin_lock_init((lock), #lock, key)
> 
> erk.  This adds a whole new layer of obfuscation on top of the 
> existing spinlock header files.  You already need to run the 
> preprocessor and disassembler to even work out which flavour you're 
> presently using.
> 
> Ho hum.

agreed. I think the API we started using in latest -mm 
(lockdep_init_key()) is the cleaner approach - that also makes it 
trivially sure that lockdep doesnt impact non-lockdep code. I'll fix the 
current lockdep_init_key() shortcomings and i'll get rid of the 
*_init_key() APIs.

	Ingo
