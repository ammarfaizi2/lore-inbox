Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWIPIc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWIPIc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWIPIc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:32:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60616 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964776AbWIPIcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:32:22 -0400
Date: Sat, 16 Sep 2006 10:23:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916082347.GG6317@elte.hu>
References: <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609160139130.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > Why don't you leave the choice to the users? Why do you constantly 
> > > make it an exclusive choice? [...]
> > 
> > as i outlined it tons of times before: once we add markups for static 
> > tracers, we cannot remove them. That is a constant kernel maintainance 
> > drag that i feel uncomfortable about.
> 
> As many, many people have already said, any tracepoints have an 
> maintainance overhead, which is barely different between dynamic and 
> static tracing and only increases the further away the tracepoints are 
> from the source.

i have demonstrated that with dynamic tracers it's possible to have: 
"half the number of tracepoints" or "no tracepoints at all", right in 
the traced kernel source. That way we are able to shift away the 
maintainance overhead from the subsystem which is being traced to the 
person who _wants_ to do the tracing (instead of on the person who 
maintains the code that is being traced), in a finegrained way.

But even the secondary metric, the "sum of all maintainance, including 
the maintanance of tracepoints" can become lower with dynamic tracers: 
if a subsystem changes with a much higher frequency than the tracing 
scripts follow.

Let me try to explain it to you with other words: if all tracing is done 
via scripts and no in-source tracepoints at all, then we could for 
example update the tracing scripts only once per release. A subsystem 
might undergo a heavy cycle of updates, changing functions that are 
traced many times: i call this a "high frequency update to the source 
code".

If tracing is done via tracepoints for static tracers, then such "high 
frequency updates to the source code" have to "carry with them" all the 
markups. It might be zero overhead if a subsystem has no tracepoints, 
but it might be alot more complex too.

For example, I can tell you that the -rt tree has a number of very 
useful scheduling tracepoints but which are also a constant maintainance 
hindrance. For example i even have a separate _function_ that is a 
helper to one of the tracepoints. And this was the _bare minimum_ of 
static tracepoints i needed for the purposes of visualizing and 
analyzing scheduling patterns in the -rt tree (either on my boxes or on 
users' boxes). Occasionally users needed alot more tracepoints. So i am 
talking from first-hand experience. This maintainance overhead occured 
(and still occurs) to /me/, so please dont try to tell me that the 
maintainance overhead is minimal. Even "half the tracepoints" would be 
great. And i only have a dozen tracepoints, not hundreds!

	Ingo
