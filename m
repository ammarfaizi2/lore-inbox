Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWIQQ5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWIQQ5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWIQQ5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 12:57:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48355 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965021AbWIQQ5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 12:57:12 -0400
Date: Sun, 17 Sep 2006 18:45:28 +0200
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
Message-ID: <20060917164528.GA2019@elte.hu>
References: <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171744570.6761@scrub.home>
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

> > to both points i (and others) already replied in great detail - 
> > please follow up on them. (I can quote message-IDs if you cannot 
> > find them.)
> 
> What you basically tell me is (rephrased to make it more clear): 
> Implement kprobes support or fuck off! [...]

What i am saying (again and again) is: "the other option you suggest is 
not acceptable to me because a better solution exists" [for the many 
reasons outlined before]. Think about the STREAMS example: there too 
_that_ particular approach was rejected, because a better solution 
existed. (although it was a _much_ larger body of code that was 
rejected)

I'm not "forcing" kprobes on you: you can invent whatever other approach 
that solves the problems i and others raised, or you can have your own 
separate patchset - this is standard kernel acceptance procedure. 
Granted, kprobes is an existing solution with extensive existing 
infrastructure, so it's IMO the easiest solution technically, but you 
are certainly not 'forced' to do it. You want the feature on your 
architecture _without_ kprobes, solve the problems.

> [...] You make it very clear, that you're unwilling to support static 
> tracers even to point to make _any_ static trace support impossible. 
> It's impossible to discuss this with you, because you're absolutely 
> unwilling to make any concessions. [...]

Because we either accept the concept of static tracing or not - 
unfortunately there's no meaningful middle ground. I'd love it if there 
was some meaningful middle-ground, because then we'd not have this 
lengthy discussion at all. But sometimes such situations do happen. Same 
was true for STREAMS: the only choice was to either it was accepted or 
it was rejected. One cannot get a "little bit pregnant".

The "add some static markups" suggestion is IMO just tactical pretense: 
static tracing will only be fully functional once it grows a 
comprehensive set of static tracepoints, so once we accept a "little 
bit" of static tracing where all the tools are built around a full set 
of tracepoints, we've created an expectance to have all of it.

Hence my suggestion: forget static tracing for the LTT engine and 
concentrate on dynamic tracepoints with _static markups_. Do you realize 
that dynamic tracers can insert _function calls_ into static markups, 
today? [and i'm not talking about djprobes here but current existing 
SystemTap behavior.]

	Ingo
