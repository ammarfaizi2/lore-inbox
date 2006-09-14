Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWINPC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWINPC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWINPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:02:28 -0400
Received: from tomts43.bellnexxia.net ([209.226.175.110]:19332 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750734AbWINPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:02:27 -0400
Date: Thu, 14 Sep 2006 11:02:25 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914150225.GA29906@Krystal>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060914112718.GA7065@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:51:46 up 22 days, 12:00,  5 users,  load average: 0.15, 0.24, 0.31
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > Following an advice Christoph gave me this summer, submitting a 
> > smaller, easier to review patch should make everybody happier. Here is 
> > a stripped down version of LTTng : I removed everything that would 
> > make the code review reluctant (especially kernel instrumentation and 
> > kernel state dump module). I plan to release this "core" version every 
> > few LTTng releases and post it to LKML.
> > 
> > Comments and reviews are very welcome.
> 
> i have one very fundamental question: why should we do this 
> source-intrusive method of adding tracepoints instead of the dynamic, 
> unintrusive (and thus zero-overhead) KProbes+SystemTap method?
> 

Hi Ingo,

First, I never said that this tracing infrastructure was tied to static trace
points in any way. My goal is to provide a robust data serialisation mechanism
that could be used both from static and dynamic trace points.

Zero-overhead for static tracepoints can be achieved by compiling them out.

One problem with the KProbes approach is that is limits what can be instrumented
because of its performance impact when active : traps are very costly and can
limit instrumentation of often triggered code paths : scheduler change, traps,
interrupts...

Also, a major issue with dynamic instrumentation is that it will never be useful
to kernel developers who keep current with the git HEAD. Dynamic instrumentation
has to be defined outside of the kernel tree and cannot follow the code changes
quickly enough to be useful for a developer without himself maintaining his own
dynamic instrumentation.

I do not advocate for a particular approach : I think that dynamic
instrumentation is very well suited for distributions which stick to a
particular kernel version for a long time. However, static probes can be very
useful for kernel developers as they can follow the kernel HEAD because they
are part of the code.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
