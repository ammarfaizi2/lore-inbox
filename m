Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWIOWM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWIOWM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWIOWM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:12:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36331 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932172AbWIOWMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:12:25 -0400
Date: Sat, 16 Sep 2006 00:03:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915220345.GC12789@elte.hu>
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450B164B.7090404@us.ibm.com>
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


* Jose R. Santos <jrs@us.ibm.com> wrote:

> [...]  While it is true that static probes will provide less overhead 
> compared to dynamic probes, [...]

that is not true at all. Yes, an INT3 based kprobe might be expensive if 
+0.5 usecs per tracepoint (on a 1GHz CPU) is an issue to you - but that 
is "only" an implementation detail, not a conceptual property. 
Especially considering that help (djprobes) is on the way. And in the 
future, as more and more code gets generated (and regenerated) on the 
fly, dynamic probes will be _faster_ than static probes - plainly 
because they adapt better to the environment they plug into.

so there's basically nothing to balance. My point is that dynamic probes 
have won or will win on every front, and we shouldnt tie us down with 
static tracers. 5 years ago with no kprobes, had someone submitted a 
clean static tracer patchset, we could probably not have resisted it (i 
though probably would have resisted it on the grounds of maintainance 
overhead) and would have added it because tracing makes sense in 
general. But today there's just no reason to add static tracers anymore.

NOTE: i still accept the temporary (or non-temporary) introduction of 
static markers, to help dynamic tracing. But my expectation is that 
these markers will be less intrusive than static tracepoints, and a lot 
more flexible.

	Ingo
