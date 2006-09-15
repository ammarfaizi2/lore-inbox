Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWIOUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWIOUyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWIOUyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:54:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54691 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932252AbWIOUyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:54:44 -0400
Message-ID: <450B1309.9020800@us.ibm.com>
Date: Fri, 15 Sep 2006 15:54:33 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal>
In-Reply-To: <20060915194937.GA7133@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Jose R. Santos (jrs@us.ibm.com) wrote:
> > Alan Cox wrote:
> > 
> > With several other trace tools being implemented for the kernel, there 
> > is a great problem with consistencies among these tool.  It is my 
> > opinion that trace are of very little use to _most_ people with out the 
> > availability of post-processing tools to analyses these trace.  While I 
> > wont say that we need one all powerful solution, it would be good if all 
> > solutions would at least be able to talk to the same post-processing 
> > facilities in user-space.  Before LTTng is even considered into the 
> > kernel, there need to be discussion to determine if the trace mechanism 
> > being propose is suitable for all people interested in doing trace 
> > analysis.  The fact the there also exist tool like LKET and LKST seem to 
> > suggest that there other things to be considered when it comes to 
> > implementing a trace mechanism that everyone would be happy with.
> > 
> > It would also be useful for all the trace tool to implement the same 
> > probe points so that post-processing tools can be interchanged between 
> > the various trace implementations.
> > 
> > 
>
> Hi Jose,
>
> I completely agree that there is a crying need for standardisation there. The
> reason why I propose the LTTng infrastructure as a tracing core in the Linux
> kernel is this : the fundamental problem I have found with kernel tracers so
> far is that they perturb the system too much or do not offer enough fine
> grained protection against reentrancy. Ingo's post about tracing statement
> breaking the kernel all the time seems to me like a sufficient proof that this
> is a real problem.
>
>   
I agree with your goal for ltt.

> My goal with LTTng is to provide a reentrant data serialisation mechanism that
> can be called from anywhere in the kernel (ok, the vmalloc path of the page
> fault handler is _the_ exception) that does not use any lock and can therefore
> trace code paths like NMI handlers.
>   

One of the things that I've notice from this thread that neither you or 
Karim sees to have answer is why is LTTng needed if a suitable 
replacement can be developed using SystemTap with static markers.  I am 
personally interested in this answer as well.  If all the things that 
LTT is proposing can be implemented in SystemTap, what then is the 
advantage of accenting such an interface into the kernel.

I don't really care which method is used as long as its the right tool 
for the job.  I see several idea from LTT that could be integrated into 
SystemTap in order to make it a one stop solution for both dynamic and 
static tracing.  Would you care to elaborate why you think having 
separate projects is a better solution?
> I also implemented code that would serialize any type of data structure I could
> think of. If it is too much, well, we can use part of it.
>
> LTTng trace format is explained there. Your comments on it are very welcome.
>
> http://ltt.polymtl.ca/ > LTTV and LTTng developer documentation > format.html
> (http://ltt.polymtl.ca/svn/ltt/branches/poly/doc/developer/format.html)
>   

Trace event headers are very similar between both LTT and LKET which is 
good in other to get some synergy between our projects.  One thing that 
LKET has on each trace event that LTT doesn't is the tid and CPU id of 
each event.  We find this extremely useful for post-processing.  Also, 
why have the event_size on every event taken?  Why not describe the 
event during the trace header and remove this redundant information from 
the event header and save some trace file space.

-JRS
