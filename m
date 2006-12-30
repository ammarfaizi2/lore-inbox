Return-Path: <linux-kernel-owner+w=401wt.eu-S1752957AbWL3LWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbWL3LWx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 06:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbWL3LWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 06:22:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39290 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbWL3LWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 06:22:51 -0500
Date: Sat, 30 Dec 2006 12:19:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: "Chen, Tim C" <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14 slowdown compared to 2.6.19]
Message-ID: <20061230111940.GA8412@elte.hu>
References: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com> <20061229232618.GA11239@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229232618.GA11239@gnuppy.monkey.org>
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


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> On Tue, Dec 26, 2006 at 04:51:21PM -0800, Chen, Tim C wrote:
> > Ingo Molnar wrote:
> > > If you'd like to profile this yourself then the lowest-cost way of
> > > profiling lock contention on -rt is to use the yum kernel and run the
> > > attached trace-it-lock-prof.c code on the box while your workload is
> > > in 'steady state' (and is showing those extended idle times):
> > > 
> > >   ./trace-it-lock-prof > trace.txt
> >
> > Thanks for the pointer.  Will let you know of any relevant traces.
> 
> Tim,
> 	http://mmlinux.sourceforge.net/public/patch-2.6.20-rc2-rt2.lock_stat.patch
> 
> You can also apply this patch to get more precise statistics down to
> the lock. [...]

your patch looks pretty ok to me in principle. A couple of suggestions 
to make it more mergable:

 - instead of BUG_ON()s please use DEBUG_LOCKS_WARN_ON() and make sure 
   the code is never entered again if one assertion has been triggered.
   Pass down a return result of '0' to signal failure. See
   kernel/lockdep.c about how to do this. One thing we dont need are
   bugs in instrumentation bringing down a machine.

 - remove dead (#if 0) code

 - Documentation/CodingStyle compliance - the code is not ugly per se
   but still looks a bit 'alien' - please try to make it look Linuxish,
   if i apply this we'll probably stick with it forever. This is the
   major reason i havent applied it yet.

 - the xfs/wrap_lock change looks bogus - the lock is initialized
   already. What am i missing?

	Ingo
