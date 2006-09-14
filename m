Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWINPTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWINPTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWINPTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:19:09 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:53951 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750763AbWINPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:19:07 -0400
Date: Thu, 14 Sep 2006 11:19:05 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>, Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914151905.GB29906@Krystal>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060914135548.GA24393@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:02:51 up 22 days, 12:11,  5 users,  load average: 0.21, 0.28, 0.27
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Roman Zippel <zippel@linux-m68k.org> wrote:
> 
> the key point is that we want _zero_ "static tracepoints". Firstly, 
> static tracepoints are fundamentally limited:
> 
>  - they can only be added at the source code level
> 
>  - modifying them requires a reboot which is not practical in a 
>    production environment

Not for kernel modules : unload/load is enough.

>  - there can only be a limited set of them, while many problems need 
>    finegrained tracepoints tailored to the problem at hand

Not true with the dynamic facility loading. LTTng can register new events upon
module load/unload.

> 
>  - conditional tracepoints are typically either nonexistent or very 
>    limited.
> 
Maybe, but it can be useful to have static instrumentation available for those
limited conditional tracepoints.

> But besides the usability problems, the most important problem is that 
> static tracepoints add a _constant maintainance overhead_ to the kernel. 
> I'm talking from first hand experience: i wrote 'iotrace' (a static 
> tracer) in 1996 and have maintained it for many years, and even today 
> i'm maintaining a handful of tracepoints in the -rt kernel. I _dont_ 
> want static tracepoints in the mainline kernel.
> 

If the trace points are modified with the code by the ones who make the
original code changes, it lessens the maintainance overhead. Furthermore, if
there is a major change in a code path that requires rethinking the trace
points, the person introducing the change has the best knowledge of what to do
with the trace point. I think that trace point maintainance should be left to
subsystem maintainers, not a centralised task done by distributions once in a
while.

Talking about experience, Karim has maintained the original LTT trace points,
which targeted key kernel event, for years without major trace points changes
between kernel versions. I think he already proved that maintainance of static
trace points in not an issue.

However, I restate that my position is that both static and dynamic
instrumentation of the kernel are a necessity and that a tracer core should be
usable by both.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
