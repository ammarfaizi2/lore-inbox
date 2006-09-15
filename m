Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWIOWEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWIOWEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWIOWEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:04:05 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:18610 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932304AbWIOWEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:04:02 -0400
Date: Fri, 15 Sep 2006 17:58:52 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915215852.GC18958@Krystal>
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <20060915213213.GA12789@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060915213213.GA12789@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:48:03 up 23 days, 18:56,  2 users,  load average: 0.25, 0.24, 0.19
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > * Ingo Molnar (mingo@elte.hu) wrote:
> > > sorry, but i disagree. There _is_ a solution that is superior in every 
> > > aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)
> > > 
> > 
> > I am sorry to have to repeat myself, but this is not true for heavy 
> > loads.
> 
> djprobes?
> 

I am fully aware of djprobes limitations towards fully preemptible kernel (and
around branches instructions ? I don't remember if they solved this one). Oh,
yes, and if a trap happen to come at the wrong spot, then the thread gets
scheduled out... well, it cannot be applied everywhere, eh ?

> > > > At this point you've been rather uncompromising [...]
> > > 
> > > yes, i'm rather uncompromising when i sense attempts to push inferior 
> > > concepts into the core kernel _when_ a better concept exists here and 
> > > today. Especially if the concept being pushed adds more than 350 
> > > tracepoints that expose something to user-space that amounts to a 
> > > complex external API, which tracepoints we have little chance of ever 
> > > getting rid of under a static tracing concept.
> > > 
> > From an earlier email from Tim bird :
> > 
> > "I still think that this is off-topic for the patch posted.  I think 
> > we should debate the implementation of tracepoints/markers when 
> > someone posts a patch for some.  I think it's rather scurrilous to 
> > complain about code NOT submitted.  Ingo has even mis-characterized 
> > the not-submitted instrumentation patch, by saying it has 350 
> > tracepoints when it has no such thing.  I counted 58 for one 
> > architecture (with only 8 being arch-specific)."
> 
> i missed that (way too many mails in this thread).
> 
> Here is how i counted them:
> 
>  $ grep "\<trace_.*(" * | wc -l
>  359
> 

This count includes the inline trace functions definitions.

> some of those are not true tracepoints, but there's at least this many 
> of them:
> 
>  $ grep "\<trace_.*(" *instrumentation* | wc -l
>  235
> 

1 - This counts per architecture trace points. It quickly adds up considering
that we support ARM, MIPS, i386, powerpc, ppc and x86_64.
2 - It also counts some experimental trace points that I do not want to submit.
3 - Most of these are instrumentation of the traps handlers, which is
conceptually only one event.

> when judging kernel maintainance overhead, the sum of all patches 
> matters. And i considered all the other patches too (the ones that add 
> actual tracepoints) that will come after the currently offered ones, not 
> just the ones you submitted to lkml.
> 

I plan to rework the instrumentation patches before submitting them to LKML,
don't worry. I just hasn't been my focus until now. Too bad that you take those
as arguments.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
