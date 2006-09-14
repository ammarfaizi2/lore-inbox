Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWINP1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWINP1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWINP1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:27:23 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:24976 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S1750772AbWINP1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:27:22 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Michel Dagenais <michel.dagenais@polymtl.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
In-Reply-To: <Pine.LNX.4.64.0609141623570.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 11:26:36 -0400
Message-Id: <1158247596.5068.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Poly-FromMTA: (saorge.dgi.polymtl.ca [132.207.169.35]) at Thu, 14 Sep 2006 15:26:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-14-09 at 16:33 +0200, Roman Zippel wrote:
> On Thu, 14 Sep 2006, Ingo Molnar wrote:
> > > On Thu, 14 Sep 2006, Ingo Molnar wrote:

> > > > i have one very fundamental question: why should we do this 
> > > > source-intrusive method of adding tracepoints instead of the dynamic, 
> > > > unintrusive (and thus zero-overhead) KProbes+SystemTap method?

> Using alternatives this could be near zero as well and it will likely 
> have less overhead when it's actually used.

This is the crucial point. Using an INT3 at each dynamic tracepoint is
both costly and is a larger perturbation on the system under study.
Static tracepoints can be achieved by various means, including a few
NOPs to reserve space which get patched dynamically for activation. They
may also be compiled out completely. By the way, there are quite a few
tracers already in device drivers in the kernel.

> BTW I don't mind KProbes as an option, but I have huge problem with making 
> it the only option.

Indeed, KProbes SystemTAP and LTTng are complementary and people
involved in the three projects are cooperating.

> > But besides the usability problems, the most important problem is that 
> > static tracepoints add a _constant maintainance overhead_ to the kernel. 
> > I'm talking from first hand experience: i wrote 'iotrace' (a static 
> > tracer) in 1996 and have maintained it for many years, and even today 
> > i'm maintaining a handful of tracepoints in the -rt kernel. I _dont_ 
> > want static tracepoints in the mainline kernel.
> 
> Even dynamic tracepoints have a maintainance overhead and I doubt there is 
> much difference. The big problem is having to maintain them outside the 
> mainline kernel, that's why it's so important to get them into the 
> mainline kernel.

Indeed, dynamic tracepoints are like code patches, when the kernel
source changes they may or not apply to newer versions. Mainline kernel
"static" tracepoints are more like the existing 70000+ printk
statements!

