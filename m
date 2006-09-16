Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWIPI3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWIPI3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWIPI3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:29:22 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49286 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932319AbWIPI3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:29:21 -0400
Date: Sat, 16 Sep 2006 10:20:54 +0200
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
Message-ID: <20060916082054.GA6317@elte.hu>
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

> > this tracepoint, under a dynamic tracing concept, can be replaced with:
> > 
> >  int __trace sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>
> A nice example where you make life more difficult for static tracers 
> for no reason, [...]

No, it's simply a clever feature: "halve the impact of static markups".

What you say will be _precisely_ the kind of situations that make me 
very wary of static tracers. Someone does something smart that enables 
us to remove half of the tracepoints from the kernel source code, while 
you will go on and complain: "why do you make the life harder for static 
tracers". You, perhaps inwillingly, are giving the perfect demonstration 
of why static tracepoints are a maintainance problem: once added _they 
can not be removed without breaking static tracers_.

And i see you didnt reply to (and you didnt even quote) the paragraph 
that i believe answers your point:

> > the user of course does not care about kernel internal design and 
> > maintainance issues. Think about the many reasons why STREAMS was 
> > rejected - users wanted that too. And note that users dont want 
> > "static tracers" or any design detail of LTT in particular: what 
> > they want is the _functionality_ of LTT.

The kernel tree is not there to make it easier for inferior approaches. 
How hard is it for the static tracer folks to take a look at dynamic 
tracers and realize that it's the fundamentally better approach, for the 
reasons above and for other reasons, and pick the concept up and 
integrate it with their code? Just like the STREAMS folks had a chance 
to look at the existing TCP/IP implementation in the Linux kernel and 
had the chance to realize that it's the better approach. Yet they 
insisted on just adding a few hooks here and there, to "make the life 
easier for STREAMS".

	Ingo
