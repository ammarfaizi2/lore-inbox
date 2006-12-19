Return-Path: <linux-kernel-owner+w=401wt.eu-S932731AbWLSJqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWLSJqn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWLSJqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:46:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56077 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932731AbWLSJqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:46:42 -0500
Date: Tue, 19 Dec 2006 10:44:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061219094432.GA1699@elte.hu>
References: <20061216080458.GC16116@elte.hu> <20061219084359.GB1731@ff.dom.local> <20061219093135.GA28269@elte.hu> <20061219094017.GM21070@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219094017.GM21070@parisc-linux.org>
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


* Matthew Wilcox <matthew@wil.cx> wrote:

> On Tue, Dec 19, 2006 at 10:31:35AM +0100, Ingo Molnar wrote:
> > 
> > * Jarek Poplawski <jarkao2@o2.pl> wrote:
> > 
> > > >  	if (unlikely(c)) {						\
> > > > -		if (debug_locks_silent || debug_locks_off())		\
> > > > +		if (!debug_locks_silent && debug_locks_off())		\
> > 
> > btw., updated patch is below - the right order is to first do 
> > debug_locks_off(), then debug_locks_silent.
> 
> Then how does one re-enable lock debugging after running the locking 
> testsuite?

see the lib/locking-selftest.c:locking_selftest() function, if all 
testcases pass then it re-enables lock debugging. If a testcase turns 
off lock debugging because it triggers a bug (as many of them 
legitimately do), then reset_locks()->lockdep_reset() will set 
debug_locks back to 1.

	Ingo
