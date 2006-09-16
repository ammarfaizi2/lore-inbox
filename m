Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWIPUA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWIPUA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIPUA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 16:00:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55985 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932069AbWIPUAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 16:00:25 -0400
Date: Sat, 16 Sep 2006 21:58:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060916082214.GD6317@elte.hu>
Message-ID: <Pine.LNX.4.64.0609161831270.6761@scrub.home>
References: <1158348954.5724.481.camel@localhost.localdomain>
 <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu>
 <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu>
 <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu>
 <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know why you split this into multiple subthreads and instead of 
delving further into secondary issues, please let me get back to the 
primary issues to put everything a little into perspective.

The foremost issue is still that there is only limited kprobes support. 
The way you ignore this and try to make this a non-issue makes it appear 
to me rather arrogant, I appreciate it that you want to push technology 
forward, but it's rather ignorant how you leave people behind in the dust 
who can't keep up, by making it very hard for them to easily get access to 
tracing in the kernel.
Since I have a quite good idea of the amount of work needed to implement 
second rate kprobes hack, first rate kprobes support and first rate 
ltt(ng) support, it's a quite simple decision what I'm going to do. Since 
your "incentive" to add kprobes support is not very high, it's more likely 
to backfire in making you the jerk denying me easy access to tracing 
technologies.

Since my options are right now limited to a static tracer in first place, 
most of the issues you mentioned over the various mails become really 
moot, e.g. why should I care about the overhead of inactive traces? We can 
happily discuss the merits of dynamic tracers forever, but it does _not_ 
change my current situation, that I have no access to one on some machines 
I care about.

The main issue in supporting static tracers are the tracepoints and so far 
I haven't seen any convincing proof that the maintainance overhead of 
dynamic and static tracepoints has to be significantly different. What you 
did is constructing a worst case scenario, which only proves that it's 
possible, what it doesn't prove is that there are no measures to prevent 
this from happining. This means nobody proved so far that it's not 
possible to create and enforce a set of rules to keep the amount and 
effect of tracepoints under control.
Let's take your example of a tracepoint in an area of high development 
activity, since such development should happen in -mm, it would be no 
problem to drop the trace and add it back once development calmed down, 
exactly like you would do for a dynamic trace. OTOH it's very well 
possible some people might find the trace useful during development.
So the problem here is now that you simply work from the unproven premiss, 
that static tracepoints automatically lead to uncontrolled chaos. This 
makes a reasonable discussion about managing tracepoints impossible, since 
you don't want to support static tracepoints at all.

Ingo, as long as you don't give up this zero tolerance strategy, it 
doesn't make much sense to discuss details and I can only hope there are 
other people who are more reasonable...

bye, Roman
