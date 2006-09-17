Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWIQUim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWIQUim (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWIQUim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:38:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20924 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965055AbWIQUil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:38:41 -0400
Date: Sun, 17 Sep 2006 22:37:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
In-Reply-To: <20060917150953.GB20225@elte.hu>
Message-ID: <Pine.LNX.4.64.0609171935070.6761@scrub.home>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
 <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home>
 <20060917150953.GB20225@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> Static tracers also need the 
> guarantee of a _full set_ of static markups. It is that _guarantee_ of a 
> full set that i'm arguing against primarily.

To those who are still reading this, let's fill this with a bit of 
meaning (Ingo is unfortunately rather unspecific here):

What is this "_full set_ of static markups" needed/used by tracers?

A tracer can of course export all kinds of information, a lot of this 
would only be interesting to a few users. Nevertheless there is a set of 
information, which is interesting to many users. Let's take a minimal set 
of just the information "schedule task from A to B", this information is 
needed in many traces in order to understand what's going on in the 
kernel.

Let's use this simple set to look at a few of myths around static tracing, 
which Ingo brings up over and over without really proving it.

Scheduling is one of the basic kernel functions, how the actual scheduling 
is done is in a constant flux, but over the years it always ended up in a 
call to switch_to(), so any kernel developer could easily maintain such a 
tracepoint. The exported information is also that simple that it's easy to 
guarantee that this information is available over many kernel version to 
come.

So what we have now is a minimal set of tracepoints, which is equally 
useful to any tracer, which is easy to maintain and reasonably easy to 
guarantee that it exists. Will there be any absolute guarantees, that this 
set will exist forever? Of course not, but it's not needed, should there 
be any change to it, it will very likely announce itself in a development 
tree and userspace tools can adjust to it.

Static tracing of course has its limitations, it's of course not possible 
to export any kind of information with in a standard way via the standard 
kernel, but nobody is asking for this. The kind of information requested 
is very much like the one above, all that has been asked for is _basic_ 
set of tracing information, which can be easily managed and is likely 
available and as I just proved such set does exist, so why should we not 
make it available to everyone?

Will this set satisfy anyone? Of course not, but anyone can easily add his 
own trace points (statically or dynamically).

Will this set be only for the benefit of static tracers? No, this basic 
set of traces is needed by all tools, so it's not ltt-centric at all. It 
will help in the unification of the various trace tools, so that they can 
share as much as possible.

So why again should this information only available to dynamic tracers?

bye, Roman
