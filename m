Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWIPAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWIPAFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWIPAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:05:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4534 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932241AbWIPAFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:05:13 -0400
Date: Sat, 16 Sep 2006 01:57:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915235707.GB29929@elte.hu>
References: <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <1158364161.2352.9.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158364161.2352.9.camel@entropy>
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


* Nicholas Miell <nmiell@comcast.net> wrote:

> You're going to want to be able to trace every function in the kernel, 
> which means they'd all need a __trace -- and in that case, a 
> -fpad-functions-for-tracing gcc option would make more sense then 
> per-function attributes.

the __trace attribute would be a _specific_ replacement for a _specific_ 
static markup at the entry of a function. So no, we would not want to 
add __trace to _every_ function in the kernel: only those which get 
commonly traced. And note that SystemTap can trace the rest too, just 
with slighly higher overhead.

In that sense __trace is not an enabling infrastructure, it's a 
performance tuning infrastructure.

> The option could also insert NOPs before RETs, not just before the 
> prologue so that function returns are equally easy to trace. (It might 
> also inhibit tail calls, assuming being able to trace all function 
> returns is more important than that optimization.)

yeah. __trace_entry and __trace_exit [or both] attributes. Makes sense.

> And SystemTap can already hook into sock_sendmsg() (or any other 
> function) and examine it's arguments -- all of this GCC extension talk 
> is just performance enhancement.

yes, yes, yes, exactly!!! Finally someone reads my mails and understands 
my points. There's hope! ;)

	Ingo
