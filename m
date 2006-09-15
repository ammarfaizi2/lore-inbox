Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWIOROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWIOROO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWIOROO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:14:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:21659 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932075AbWIOROM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:14:12 -0400
Message-ID: <450ADF56.4050602@us.ibm.com>
Date: Fri, 15 Sep 2006 12:13:58 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Ingo Molnar <mingo@elte.hu>, Karim Yaghmour <karim@opersys.com>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <20060914151905.GB29906@Krystal>
In-Reply-To: <20060914151905.GB29906@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Ingo Molnar (mingo@elte.hu) wrote:
> > 
> > * Roman Zippel <zippel@linux-m68k.org> wrote:
> > 
> > the key point is that we want _zero_ "static tracepoints". Firstly, 
> > static tracepoints are fundamentally limited:
> > 
> >  - they can only be added at the source code level
> > 
> >  - modifying them requires a reboot which is not practical in a 
> >    production environment
>
> Not for kernel modules : unload/load is enough.
>   

This assumes that the module can be unloaded in the first place.  
Inserting a new probe on the disk controler for your boot drive or in 
the filesystem module would still require a reboot.

> If the trace points are modified with the code by the ones who make the
> original code changes, it lessens the maintainance overhead. Furthermore, if
> there is a major change in a code path that requires rethinking the trace
> points, the person introducing the change has the best knowledge of what to do
> with the trace point. I think that trace point maintainance should be left to
> subsystem maintainers, not a centralised task done by distributions once in a
> while.
>   

I agree with you here, I think is silly to claim dynamic instrumentation 
as a fix for the "constant maintainace overhead" of static trace point.  
Working on LKET, one of the biggest burdens that we've had is mantainig 
the probe points when something in the kernel changes enough to cause a 
breakage of the dynamic instrumentation.  The solution to this is having 
the SystemTap tapsets maintained by the subsystems maintainers so that 
changes in the code can be applied to the dynamic instrumentation as 
well.  This of course means that the subsystem maintainer would need to 
maintain two pieces of code instead of one.  There are a lot of 
advantages to dynamic vs static instrumentation, but I don't think 
maintainace overhead is one of them.

-JRS
