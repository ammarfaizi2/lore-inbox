Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWIPAnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWIPAnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWIPAnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:43:20 -0400
Received: from sccrmhc14.comcast.net ([63.240.77.84]:55955 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932285AbWIPAnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:43:19 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Nicholas Miell <nmiell@comcast.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <20060915235707.GB29929@elte.hu>
References: <1158348954.5724.481.camel@localhost.localdomain>
	 <450B0585.5070700@opersys.com>
	 <1158351780.5724.507.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609152236010.6761@scrub.home>
	 <20060915204812.GA6909@elte.hu>
	 <Pine.LNX.4.64.0609152314250.6761@scrub.home>
	 <20060915215112.GB12789@elte.hu>
	 <Pine.LNX.4.64.0609160018110.6761@scrub.home>
	 <20060915231419.GA24731@elte.hu> <1158364161.2352.9.camel@entropy>
	 <20060915235707.GB29929@elte.hu>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 17:41:22 -0700
Message-Id: <1158367282.2352.18.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 01:57 +0200, Ingo Molnar wrote:
> * Nicholas Miell <nmiell@comcast.net> wrote:
> 
> > You're going to want to be able to trace every function in the kernel, 
> > which means they'd all need a __trace -- and in that case, a 
> > -fpad-functions-for-tracing gcc option would make more sense then 
> > per-function attributes.
> 
> the __trace attribute would be a _specific_ replacement for a _specific_ 
> static markup at the entry of a function. So no, we would not want to 
> add __trace to _every_ function in the kernel: only those which get 
> commonly traced. And note that SystemTap can trace the rest too, just 
> with slighly higher overhead.
> 
> In that sense __trace is not an enabling infrastructure, it's a 
> performance tuning infrastructure.
> 
> > The option could also insert NOPs before RETs, not just before the 
> > prologue so that function returns are equally easy to trace. (It might 
> > also inhibit tail calls, assuming being able to trace all function 
> > returns is more important than that optimization.)
> 
> yeah. __trace_entry and __trace_exit [or both] attributes. Makes sense.
> 
> > And SystemTap can already hook into sock_sendmsg() (or any other 
> > function) and examine it's arguments -- all of this GCC extension talk 
> > is just performance enhancement.
> 
> yes, yes, yes, exactly!!! Finally someone reads my mails and understands 
> my points. There's hope! ;)

I'm not sure that I do, actually.

You seem to be opposed to all static probe markers in general, but I
think that they'd be useful for big abstract things like "new thread
created" (which would encompass fork/vfork/clone and probably consist of
a single marker in do_fork) or for similar things that happen all over
the kernel (for example, I imagine that all filesystems would want to
use the same set of probe names just to make I/O tracing easier for
userspace).




-- 
Nicholas Miell <nmiell@comcast.net>

