Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWIQXO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWIQXO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWIQXO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:14:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52908 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965153AbWIQXO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:14:58 -0400
Date: Mon, 18 Sep 2006 01:06:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917230623.GD8791@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158524390.2471.49.camel@entropy>
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

> On my system, Solaris has 49 "real" static probes (with actual 
> documentation[1]). They are as follows:

yeah, _some_ static markers are OK, as long as they are within a dynamic 
tracing framework! (and are thus constantly "kept in check" by the easy 
availability of dynamic probes)

what is being proposed here is entirely different from dprobes though: 
Roman suggests that he doesnt want to implement kprobes on his arch, and 
he wants LTT to remain an _all-static_ tracer. That's the point where i 
beg to differ: static markers are fine (but they should be kept to a 
minimum), but generic static /tracers/ need alot more than just a few 
static markers to be meaningful.

So if we accepted static tracers into the kernel, we'd automatically 
commit (for a long period of time) to a much larger body of static 
markers - and i'm highly uncomfortable about that. (for the many reasons 
outlined before)

Even if the LTT folks proposed to "compromise" to 50 tracepoints - users 
of static tracers would likely _not_ be willing to compromise, so there 
would be a constant (and I say unnecessary) battle going on for the 
increase of the number of static markers. Static markers, if done for 
static tracers, have "viral" (Roman: here i mean "auto-spreading", not 
"disease") properties in that sense - they want to spread to alot larger 
area of code than they start out from.

While if we only have a dynamic tracing framework (which is a mix of 
static markers and dynamic probes) then pretty much the only user 
pressure would be: "implement kprobes!". (which is already implemented 
for 5 major arches and takes only between 500 and 1000 lines of per-arch 
code for most of them.)

( furthermore, from what you've described it seems to me that 
  kprobes/kretprobes/djprobes+SystemTap is already more capable than 
  dprobes is - hence the number of static markes needed in Linux might 
  in fact be lower in the end than in Solaris. )

> This is the important part: In a dynamic tracing system, the number of 
> static probes necessary for the tracing system to be useful is 
> drastically, dramatically, absurdly lower than in a purely static 
> tracing system. Hell, you don't even need the static probes for it to 
> be useful, they're just a convenience for events which happen in 
> multiple places or a high-level name for a low-level implementation 
> detail.

yeah, precisely my point.

> In order for the static tracing system to be as useful as the dynamic 
> system, all of those dynamically generated probe points would have to 
> be manually added to the kernel. The maintenance burden of this number 
> of probes is stupidly high. In reality, no static system would ever 
> reach that level of coverage.

yeah, agreed.

	Ingo
