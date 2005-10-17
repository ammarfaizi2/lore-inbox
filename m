Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVJQSua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVJQSua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVJQSua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:50:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29090 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932218AbVJQSu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:50:29 -0400
Date: Mon, 17 Oct 2005 20:49:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tim Bird <tim.bird@am.sony.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <4353D60E.70901@am.sony.com>
Message-ID: <Pine.LNX.4.61.0510171948040.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
 <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu>
 <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org> <Pine.LNX.4.61.0510171511010.1386@scrub.home>
 <4353D60E.70901@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, Tim Bird wrote:

> > It's rather simple:
> > - "timer API" vs "timeout API": I got absolutely no acknowlegement that this
> > might be a little confusing and in consequence "process timer" may be a
> > better name.
> 
> I agree with Thomas on this one.  Maybe "timer" and "timeout" are too close,
> but I think they are the most descriptive names.
>  - timeout is something used for a timeout.  Timeouts only actually
>  expire infrequently, so they have a host of attributes associated
>  with that characteristic.
>  - timer is something used to time something.  They almost always
>  expire as part of their normal behaviour.  In the ktimer code they
>  have a host of attributes related to this characteristic.

There is of course a difference, but is it big enough that they deserve 
different APIs? Just look into <linux/timer.h> it doesn't mention timeout 
once, but according to Thomas that's our "timeout API". Look at the 
description of mod_timer() in timer.c: "modify a timer's timeout".
It seems I'm not only one who thinks that both are closely related.

> Thomas answered the suggestion to use "process timer" as an alternative name,
> but I didn't see a reply after that from Roman (I may have missed it.)

It was short and painless:

} > > Calling them "process timer" and "kernel timer" would include their main 
} > > usage, although that also means ptimer were the more correct abbreviation.
} > 
} > As said before I think the disctinction between timers and timeouts
} > makes perfectly sense and ktimers are _not_ restricted to process
} > timers. 
} 
} "main usage" != "restricted to"

IOW I didn't say that "process timer" are restricted to processes, but 
it's their intended main usage. "kernel timer" are OTOH the first choice 
for any internal kernel time issues (which are not just timeouts).

> > - I pointed out various (IMO) unnecessary complexities, which were rather
> > quickly brushed off e.g. with a need for further (not closer specified)
> > cleanups.
> 
> This is rather vague.  It is rather easy to raise hypothetical
> issues.  From what I've seen, Thomas has gone to great lengths to
> address specific issues raised.  For example, he actually compiled
> code on 4 different platforms to get the REAL size of the assembly
> fragments, in order to address your concern about CONJECTURED size
> problems.

This was the _only_ issue where he got into any detail, but I also 
mentioned later that this one of the minor issues.
Above was about the size of the ktimer structure and interval timer. 

> > - resolution handling: at what resolution should/does the kernel work and
> > what do we report to user space. The spec allows multiple interpretations
> > and I have a hard time to get at least one coherent interpretation out of
> > Thomas.
> 
> Huh?  I thought Thomas' last answer was pretty clear.

Then I must have missed something. Earlier he just quotes something from 
SUS without any explanation. His last answer was just about user 
expectations without any connection to the different resolutions at the 
kernel side I described in the mail before.

bye, Roman
