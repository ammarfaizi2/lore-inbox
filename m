Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbUJ1MIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbUJ1MIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbUJ1MID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:08:03 -0400
Received: from opersys.com ([64.40.108.71]:60676 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262977AbUJ1MDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:03:43 -0400
Message-ID: <4180DDFA.1050409@opersys.com>
Date: Thu, 28 Oct 2004 07:54:34 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       rpm@xenomai.org
Subject: Re: [RFC][PATCH] Restricted hard realtime
References: <20041023194721.GB1268@us.ibm.com>	<417F12F1.5010804@opersys.com> <20041026212956.4729ce98.akpm@osdl.org>
In-Reply-To: <20041026212956.4729ce98.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> uber-preemption is the chosen way for the mainline kernel mainly because
> its mechanisms can be largely hidden inside (increasingly ghastly) header
> files and most developers just don't have to worry about it.

Yet, this justification applies readily to the nanokernel approach. The
interrupt pipeline needed by Adeos, for example, is mostly hidden inside
headers and developers have even less to care about it then the increased
concurrency from the uber-preemption patches.

As for how useful the uber-preemption will be, there does not seem to be
any concenssus.
This is your take:
> I have a sneaking suspicion that the day will come when we get nice
> sub-femtosecond latencies in all the trivial benchmarks but it turns out
> that the realtime processes won't be able to *do* anything useful because
> whenever they perform syscalls, those syscalls end up taking long-held
> locks.

This is Ingo's take:
> also, RT applications rarely hit the really complex kernel subsystems
> because 'complex' often means 'has the potential for IO' - on any
> hard-RT OS. 

And this is Bill's take:
> The biggest groups of folks I can identify is the multimedia folks.
> Their applications are the most system loaded out of all of the
> applications on this planet, deterministic latency, heavy CPU usage,
> heavy disk load and manical temporal control via frame schedulers, etc...
> 
> This stuff has direct application to DVRs (digital video recorders)
> and other things that only SGI and BeOS machines could do in their
> day.

In the 3 replies I got, there were 3 different interpretations of how
uber-preemption will be useful:
1- It's good for latency, but apps won't really get much out of it
    because of non-deterministic syscalls.
2- Non-deterministic syscalls aren't a problem as long as they don't
    hit complex subsystems.
3- End-applications that interact with many subsystems, especially
    I/O is exactly where we want to go.

It appears that different parties draw the line at different places,
and if we follow this to its logical conclusion, it brings us to the
first choice I was highlighting:
> a) Most current kernel developers intend to eventually convert the
> entire existing code-base into one that contains deterministic
> code paths only, and therefore impose such constraints on all future
> contributors, in which case the path to follow is the one set by
> the uber-preemption folks; 

IOW, those who need deterministic response times in Linux are unlikely
to be entirely satisfied with uber-preemption, and will want more.
If I read Ingo correctly, greater determinism will come over time as
Linux is made better for SMP systems, and I somewhat agree with this.
However, reduced latencies and increased threading does not in itself
make an OS deterministic in its behavior. For those who really need
a deterministic OS, uber-preemption is therefore but a stepping stone,
and more is likely to be asked for. Yet, more will not be possible
unless there is a change in the kernel's development philosophy (at
least, that's what I can make of it).

> Which does lead me to suggest that we need to identify the target
> application areas for Ingo's current work and confirm that those
> applications are seeing the results which they require.  Empirical results
> from the field do seem to indicate success, but I doubt if they're
> sufficiently comprehensive.

Usually one of the litmus tests for this is to hook a function
generator to the system and inject a square wave through an
interrupt-generating I/O (ex.: parallel port), while measuring the
response time of an interrupt service routine and comparing it to
the input wave using an oscilloscope. One sign that the system is
indeed deterministic is that both square waves should appear
steady regardless of the load.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

