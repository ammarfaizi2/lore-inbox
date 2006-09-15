Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWIOTfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWIOTfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWIOTfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:35:08 -0400
Received: from www.osadl.org ([213.239.205.134]:40420 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751500AbWIOTfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:35:06 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <20060915111644.c857b2cf.akpm@osdl.org>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>
	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
	 <1158332447.5724.423.camel@localhost.localdomain>
	 <20060915111644.c857b2cf.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 21:35:54 +0200
Message-Id: <1158348954.5724.481.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 11:16 -0700, Andrew Morton wrote:
> Me thinks our time would be best spent trying to benefit from his
> experience..

I was involved in tracer development for quite a while and I have used
them in $paying customer projects too.

> Me, I'm not particularly averse to some 50-100 static tracepoints if
> experience tells us that we need such things.  And both Karim's and Frank's
> experience does indicate that such things are needed, which carries weight.

>From my experience the tracepoints usually are not at the place where
you need them to track down a particular problem or analyse a particular
usage scenario in detail. This has been true from a kernel and from an
application programmer POV. Also many of the LTT customer I'm aware of
used their own homebrewed set of trace points.

What I always hated on static tracers is the requirement to recompile /
reboot the kernel in order to gather information. Kprobes / systemtap is
really a conveniant way to avoid this.

I completely agree that the maintenance of the "out of code" trace
scripts is a task which needs a lot of effort, but it does not offload
the maintenance effort to those modifying the code and we have not yet
another pseudo instruction/function set which is interfering with the
goal to have clear and understandable code. Hell, the code in those code
paths which are of common interest for instrumentation is already
complex enough. We really can do without adding some more obfuscated
macro constructs.

When we can maintain a basic set of tracescripts in the kernel tree and
once the necessary infrastructure is in place, I'm quite sure that quite
a lot of kernel developers would keep those fundamental trace scripts in
shape out of their own interest. It might take a while to get this going
but once it is established, distros will ship the scripts along with
dynamic tracing enabled in the kernels.

I see a major advantage over static tracing in that:

Static tracing is usually not enabled in production kernels, but the
dynamic tracing infrastructure can be enabled without costs. So you
can actually request traces (at least for the standard set of
tracepoints) from Joe User to track down complex problems.

One thing which is much more important IMHO is the availablity of
_USEFUL_ postprocessing tools to give users a real value of
instrumentation. This is a much more complex task than this whole kernel
instrumentation business. This also includes the ability to coordinate
user space _and_ kernel space instrumentation, which is necessary to
analyse complex kernel / application code interactions. 

	tglx


