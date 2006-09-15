Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWIOXXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWIOXXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWIOXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:23:05 -0400
Received: from opersys.com ([64.40.108.71]:46349 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932356AbWIOXXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:23:02 -0400
Message-ID: <450B382C.9070202@opersys.com>
Date: Fri, 15 Sep 2006 19:33:00 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <450B29FB.7000301@opersys.com> <20060915224338.GA22126@elte.hu>
In-Reply-To: <20060915224338.GA22126@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> i actually think djprobes are pretty darn inventive.

So do I. While there is a language barrier, the Hitachi folks,
especially Hiramatsu-san, are very talented.

> I also think that 
> the tracebuffer management portion of LTT is better than the hacks in 
> SystemTap, and that LTT's visualization tools are better (for example 
> they do exist :-) - so clearly there's synergy possible.

Great, because I believe all those involved would like to see this
happen. I personally am convinced that none of those involved want
to continue wasting their time in parallel.

> But i have no 
> faith at all, for the many reasons outlined before, in the concept of 
> static tracing, because i see no possible future path out of its many 
> limitations and because i see no possible future way to get rid of their 
> dependencies.

Yes, I do so believe that this is what you most sincerely think. And
I'm ok with that. We don't have to approach the problem from the
same direction. In my view we should at least settle for working on
the most basic thing we *do* agree on: having a markup mechanism for
necessary instrumentation.

> So i'd rather wait some time for dynamic tracers to 
> outgrow static tracers in even the last final area, than let static 
> tracing into the kernel - which would add dependencies that we'd have to 
> live with almost until eternity.

I genuinely understand your concern. And I repeat that ltt's initial
design cared little of the provenance of the events. It just needed
key events to present an intelligent picture to the user. The
patches have since grown to include stuff which was essential as
development went ahead. But there's no reason things cannot be
refactored into an acceptable format to all by review on the lkml.

> it would clearly reduce the number of places where static markup would 
> still be necessary. With static tracers i see no such mechanism that 
> gradually moves the markups out of the kernel.

Again, I strongly believe that this issue isn't about static vs.
dynamic. The goal, and that's what's important, is to allow users
to have access to a set of tools they can use on *any* kernel
they get their hands on, without having to edit anything anywhere
or fix any script. For having spent considerable effort into this,
I don't see any other way that using static markup. Here's a
simple case: you ask someone who's got a bug report on a kernel
crashing because of his user-space realtime task, and you ask him
to dump you a trace, and that trace actually ends up misleading
because his out-of-tree instrumentation was inserted in the wrong
location.

Again, the goal is to obtain tools that users can use on *any*
kernel they get their hands on.

> So you dispute that markups for dynamic tracing will be more flexible 
> and you dispute that they will be less intrusive than markups for static 
> tracing?

No, I'm saying that the flexibility of the markup is not tied to the
instrumentation "grab" mechanism (direct call or binary editing.)
That's the "arbitrary" I'm talking about.

Karim

