Return-Path: <linux-kernel-owner+w=401wt.eu-S1751583AbWLLUwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWLLUwJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWLLUwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:52:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39849 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbWLLUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:52:07 -0500
Date: Tue, 12 Dec 2006 21:50:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: fix seqlock_init()
Message-ID: <20061212205001.GA31445@elte.hu>
References: <20061212111028.GA13908@elte.hu> <20061212094820.1049a252.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212094820.1049a252.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 12 Dec 2006 12:10:28 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > +#define seqlock_init(x)					\
> > +	do {						\
> > +		(x)->sequence = 0;			\
> > +		spin_lock_init(&(x)->lock);		\
> > +	} while (0)
> 
> This does not have to be a macro, does it?

Maybe it could be an __always_inline inline function (it has to be 
inlined to get the callsite based lock class key right) - but i'm not 
sure about the include file dependencies. Will probably work out fine as 
seqlock.h is supposed to be a late one in the order of inclusion - but i 
didnt want to make a blind bet.

	Ingo
