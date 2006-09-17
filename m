Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWIQOUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWIQOUS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 10:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWIQOUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 10:20:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932216AbWIQOUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 10:20:15 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <1158351780.5724.507.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609152236010.6761@scrub.home>
	<20060915204812.GA6909@elte.hu>
	<Pine.LNX.4.64.0609152314250.6761@scrub.home>
	<20060915215112.GB12789@elte.hu>
	<Pine.LNX.4.64.0609160018110.6761@scrub.home>
	<20060915231419.GA24731@elte.hu>
	<Pine.LNX.4.64.0609160139130.6761@scrub.home>
	<20060916082214.GD6317@elte.hu>
	<Pine.LNX.4.64.0609161831270.6761@scrub.home>
	<20060916231407.GA23132@elte.hu>
From: fche@redhat.com (Frank Ch. Eigler)
In-Reply-To: <20060916231407.GA23132@elte.hu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
Date: 17 Sep 2006 10:19:11 -0400
Message-ID: <y0mr6yaefts.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> [...]
> firstly, a factually wrong statement of yours:
> 
> > [...] any tracepoints have an maintainance overhead, which is barely 
> > different between dynamic and static tracing [...]

If one totals the fixup effort required across the programmers who
need to do the work, I would concur with the OP; or if there is a
difference, it is in favour of the static markers.  It is unfortunate
that all the talk about maintenance has been almost entirely aloof and
disconnected from empirical examples.  It would be much better if we
were able to sketch out plausible designs for static instrumentation
and similar dynamic probes, and carry out gedanken experiments aobut
how they would need to adopt to realistic examples of code drift.  It
is not the case that all "maintenance" is alike.

> secondly, a factually wrong statement of yours:
> 
> > [...] at the source level you can remove a static tracepoint as easily 
> > as a dynamic tracepoint, [...]

It is not hard to imagine commenting out a single line; nor inserting
the equivalent of "#define NDEBUG" at the head of the .c file to
disable them all for the whole compilation unit.  The retort that
"this would break the entire tracing system" does not hold water
without far more argument.  Missing events do not necessarily a
totally broken system make.  (Renamed or changed events may even be
mapped back via a translation layer.)  Tracing events need not become
as firmly fixed (unremovable or unchangeable) a user interface as the
syscalls.

> thirdly, a factually wrong statement of yours:
>
> > [...] It would also add virtually no maintainance overhead [...]

Yes, the knife cuts both ways: both cost ongoing effort.  The question
is how much; who would do the work; who is better able to do the work;
who (users/developers) receives value from the work.  The overall
cost/benefit calculation is far more complicated than pithy lines
about "no maintenance" or its opposite.


As for the possibilities of kprobes performance improvements: bring
them on, they're great.  It is however almost certain that, because
reasons like debugging-information imperfection or absence, compiler
optimizations, different deployment scenarios, some un-probable blind
spots would remain kprobes-only probing system.


As for Karim's proposed comment-based markers, I don't have a strong
opinion, not being one whose kernel-side code would be marked up one
way or the other.  My intuition suggests that, if the runtime costs of
a dormant static marker are low enough, they should be just compiled
in by default.  And if they are compiled in, then by golly, compile
them in honestly and don't hide them.  Something like build-time
multilibbing seems like too much effort to trade one eyesore for a
different eyesore.  But that's just my opinion, I could be wrong.


- FChE
