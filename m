Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWINOeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWINOeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWINOeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:34:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29083 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750805AbWINOeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:34:05 -0400
Date: Thu, 14 Sep 2006 16:33:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914135548.GA24393@elte.hu>
Message-ID: <Pine.LNX.4.64.0609141623570.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
 <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Ingo Molnar wrote:

> > On Thu, 14 Sep 2006, Ingo Molnar wrote:
> > 
> > > i have one very fundamental question: why should we do this 
> > > source-intrusive method of adding tracepoints instead of the dynamic, 
> > > unintrusive (and thus zero-overhead) KProbes+SystemTap method?
> > 
> > Could you define "zero-overhead"?
> 
> zero overhead when not used: not a single instruction added to the 
> kernel codepath that is to be traced, anywhere. (which will be the case 
> on 99% of the systems)

Using alternatives this could be near zero as well and it will likely 
have less overhead when it's actually used.

> > Actual implementation aside having a core number of tracepoints is far 
> > more portable than KProbes.
> 
> the key point is that we want _zero_ "static tracepoints". Firstly, 
> static tracepoints are fundamentally limited:

BTW I don't mind KProbes as an option, but I have huge problem with making 
it the only option.

> But besides the usability problems, the most important problem is that 
> static tracepoints add a _constant maintainance overhead_ to the kernel. 
> I'm talking from first hand experience: i wrote 'iotrace' (a static 
> tracer) in 1996 and have maintained it for many years, and even today 
> i'm maintaining a handful of tracepoints in the -rt kernel. I _dont_ 
> want static tracepoints in the mainline kernel.

Even dynamic tracepoints have a maintainance overhead and I doubt there is 
much difference. The big problem is having to maintain them outside the 
mainline kernel, that's why it's so important to get them into the 
mainline kernel.
You didn't address my main issue at all - kprobes is only available for a 
few archs...

bye, Roman
