Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWIRPyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWIRPyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWIRPyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:54:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:1242 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750941AbWIRPyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:54:10 -0400
Message-ID: <450EC102.3020402@us.ibm.com>
Date: Mon, 18 Sep 2006 10:53:38 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: karim@opersys.com
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>, Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Guanglei Li <guanglei@cn.ibm.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: The emperor is naked: why *comprehensive* static markup belongs
 in mainline
References: <450D182B.9060300@opersys.com>
In-Reply-To: <450D182B.9060300@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Why, in fact, that's exactly Jose's point of view. Who's
> Jose? Well, just in case you weren't aware of his work,
> Jose maintains LKET. What's LKET? An ltt-equivalent
>   

Small correction.  Li GuangLei maintains LKET, I mostly oversee its 
development and provide guidance to him and his team (and on occasions, 
I like to cause trouble in mailing lists).
> that uses SystemTap to get its events. And what does
> Jose say? Well I couldn't say it better than him:
>
> > I agree with you here, I think is silly to claim dynamic instrumentation 
> > as a fix for the "constant maintainace overhead" of static trace point.  
> > Working on LKET, one of the biggest burdens that we've had is mantainig 
> > the probe points when something in the kernel changes enough to cause a 
> > breakage of the dynamic instrumentation.  The solution to this is having 
> > the SystemTap tapsets maintained by the subsystems maintainers so that 
> > changes in the code can be applied to the dynamic instrumentation as 
> > well.  This of course means that the subsystem maintainer would need to 
> > maintain two pieces of code instead of one.  There are a lot of 
> > advantages to dynamic vs static instrumentation, but I don't think 
> > maintainace overhead is one of them.
>
> Well, well, well. Here's a guy doing *exactly* what I was
> asked to do a couple of years back. And what does he say?
> "I think is silly to claim dynamic instrumentation as a
> fix for the "constant maintainace overhead" of static trace
> point."
>   

My point here was that someone still needs to maintain the tracepoints 
regardless of where they are located.  While I think that the challenges 
of maintaining the tracepoints in kernel are less that maintaining them 
out of kernel (either through dynamic or static tracepoints), the 
maintenance overhead is still not zero for the subsystem maintainers.
> And just in case you missed it the first time in his
> paragraph, he repeats it *again* at the end:
> " There are a lot of advantages to dynamic vs static
> instrumentation, but I don't think maintainace overhead is
> one of them."
>   

One thing I would like to add though, is that base on my experience 
using event tracing tools, I say that the benefits of dynamic 
instrumentation far outweigh its drawbacks.

> But not content with Jose and Frank's first-hand experience
> and testimonials about the cost of outside maintenance of
> dynamically-inserted tracepoint, and obviously outright
> dismissing the feedback from such heretics as Roman, Martin,
> Mathieu, Tim, Karim and others, we have a continued barrage of
> criticism from, shall we say, very orthodox kernel developers
> who insist that the collective experience of the previously
> mentioned people is simply misguided and that, as experienced
> kernel developers, *they* know better.
>   

I think the problem here is that we haven't done a good job in educating 
developers as to the value of event tracing the kernel has for 
developers as well as sysadmins.  For example, Frank has said to me in 
the past that he does not see the value in just printing raw data out to 
user-space the way LKET does.  While him and the SystemTap folks have 
not done anything specifically to block the inclusion of LKET into the 
CVS tree, Frank lack of vision of what I want to achieve with this tool 
is partly a failure on my part.

> Why the emperor is naked:
> -------------------------
>
> Truth be told:
>
> There is no justification why Mathieu should continue
> chasing kernels to allow his users utilize ltt on as
> many kernel versions as possible.
>
> There is no justification why the SystemTap team should
> continue chasing kernels to make sure users can use
> SystemTap on as many kernel versions as possible.
>
> There is no justification why Jose should continue
> chasing kernels to allow his users to use LKET on as
> many kernel versions as possible.
>
> There is, in fact, no justification why Jose, Frank,
> and Mathieu aren't working on the same project.
>   

In all honesty, I think it is time to kill LTTng, LKET and LKST and use 
the experience gathered for these projects to create a new tool that 
exploits all of the advantages of the previous tools.  The attitude I 
gathered from the OLS tracing bof was that while there was interest in 
making tool A work with tool B, there was absolutely no interest in 
saying "fuck tools A and B and lets create tool C".  I've always 
advocated towards this goal.  I will be the first one to say "fuck my 
tool, lets work on tool C".  It is now up to Mathiue and Hiramatsu-san 
to do the same.  In my view, egos instead of technical issues are the 
thing that are slowing the adoption of a event tracer in Linux"

> There is no justification to any of this but the continued
> *FEAR* by kernel developers that somehow their maintenance
> workload is going to become unmanageable should anybody
> get his way of adding static instrumentation into the
> kernel. And no matter what personal *and* financial cost
> this fear has had on various development teams, actual
> *experience* from even those who have applied the most
> outrageous of kernel developers requirements is but
> grudgingly and conditionally recognized. No value, of
> course, being placed on the experience of those that
> *didn't* follow the orthodox diktat -- say by pointing
> out that ltt tracepoints did not vary on a 5 year timespan.
>   

The fact that tracepoint did not vary in a 5 year timespan just proves 
that the users of LTTng are very few.  The truth is that there is no way 
to have a trace tool that will have all the tracepoints needed to 
diagnose every problem.  If a static instrumentation mechanism where to 
be included into the kernel, every user that had a useful static 
tracepoint for their environment would want to push it into the kernel 
in order to have their tracepoint available in distribution X and avoid 
having to patch and recompile a kernel.  This seems like the fear that 
has been discussed on the thread and I think its well justified.  I know 
I would like to push my tracepoints if the tool was available in 
mainline kernels.

One of the things that we tried to do with LKET was not predict what the 
user would use the tool for.  For this reason, the trace format  and the 
conversion tool was design to be very dynamic.
> For the argument, as it is at this stage of the long
> intertwined thread of this week, is that "dynamic tracing"
> is superior to "static tracing" because, amongst other
> things, "static tracing" requires more instrumentation
> than "dynamic tracing". But that, as I said within said
> thread, is a fallacy. The statement that "static tracing"
> requires more instrumentation than "dynamic tracing" is
> only true in as far as you ignore that there is a cost
> for out-of-tree maintenance of scripts for use by probe
> mechanisms. And as you've read earlier, those doing this
> stuff tell us there *is* cost to this. Not only do they
> say that, but they go as far as telling us that this
> cost is *no different* than that involved in maintaining
> static trace points. That, in itself, flies in the face
> of all accepted orthodox principles on the topic of
> mainlined static tracing.
>   

Improving out-of-tree maintenance of scripts is something that needs to 
improve.  Especially when you need to insert probes in the middle of a 
function.

> And that is but the maintenance aspect, I won't even
> start on the performance issue. Because the current party
> line is that while the kprobes mechanism is slow: a) it's
> fast enough for all applicable uses, b) there's this
> great new mechanism we're working on called djprobes which
> eliminates all of kprobes' performance limitations. Of
> course you are asked to pay no attention to the man behind
> the curtain: a) if there is justification to work on
> djprobes, it's because kprobes is dog-slow, which even
> those using it for systemtap readily acknowledge, b)
> djprobes has been more or less "on its way" for a year or
> two now, and that's for one single architecture.
>   

I think that the performance issues should be better understood.  Right 
now, the thing that cause most of the slowdowns in LKET is not kprobes 
but rather exporting the data.  Gui Jian has done some measurements 
using benchmarks that do real work and found that over head in most 
cases is significantly less than 10%.

A better performance testing methodology needs to be defined in order to 
justifying your argument that kprobes are not suitable for the purposes 
of event tracing.  Something more elaborated than a simple "ping -f 
localhost" would be useful.

Another thing that needs to be considered is how much of an over head is 
acceptable in order for the tool to be useful.  I will argue that in 
most cases, the overhead of kprobes will not inhibit the ability for 
find problems.


-JRS
