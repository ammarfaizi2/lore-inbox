Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWF0MTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWF0MTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWF0MTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:19:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32693 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932175AbWF0MTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:19:03 -0400
Date: Tue, 27 Jun 2006 14:14:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-ID: <20060627121410.GA2251@elte.hu>
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org> <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org> <20060626223526.GA18579@elte.hu> <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org> <20060627110954.GA23672@elte.hu> <44A12190.40806@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A12190.40806@linux.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> Ingo Molnar wrote:
> >at copy_strings_kernel() time we dont yet know where in the target VM to 
> >install the pages. A binformat might want to install all sorts of stuff 
> >on the stack first, before it constructs the envp and copies the strings 
> >themselves. So we dont know the precise alignment needed.
> >
> >delaying the copying to setup_arg_pages() time does not seem to work 
> >either, because that gets called after the old MM has been destroyed.
> >
> >[ delaying the copying will also change behavior in error cases - 
> >  instead of returning with an error if the string pointers are bad 
> >  we'll have to kill the execve()ing process. ]
> >
> >am i missing something?
> 
> we could always just have the binfmt use mremap() equivalent to move 
> it into the place it wants...

i dont think so, these things on the stack are not page aligned.

	Ingo
