Return-Path: <linux-kernel-owner+w=401wt.eu-S932442AbWLMBVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWLMBVQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWLMBVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:21:16 -0500
Received: from fallback.mail.elte.hu ([157.181.151.13]:60378 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbWLMBVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:21:14 -0500
Date: Wed, 13 Dec 2006 02:15:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: fix seqlock_init()
Message-ID: <20061213011555.GB6361@elte.hu>
References: <20061212111028.GA13908@elte.hu> <20061212094820.1049a252.akpm@osdl.org> <20061212205001.GA31445@elte.hu> <20061212130644.5251e9f2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212130644.5251e9f2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > > +#define seqlock_init(x)					\
> > > > +	do {						\
> > > > +		(x)->sequence = 0;			\
> > > > +		spin_lock_init(&(x)->lock);		\
> > > > +	} while (0)
> > > 
> > > This does not have to be a macro, does it?
> > 
> > Maybe it could be an __always_inline inline function (it has to be 
> > inlined to get the callsite based lock class key right)
> 
> the compiler darn better inline it, else we'll have an out-of-line 
> copy of everything in everywhere.

the compiler will do the uninlining happily if it sees a size advantage 
(when a single .c module calls the function several times), and creates 
a private per-object-file uninlined function. So an __always_inline 
would definitely be needed.

> > - but i'm not 
> > sure about the include file dependencies. Will probably work out fine as 
> > seqlock.h is supposed to be a late one in the order of inclusion - but i 
> > didnt want to make a blind bet.
> 
> seqlock.h already includes spinlock.h.

yes ... i just preserved the status quo.

	Ingo
