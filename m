Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVEYJZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVEYJZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVEYJZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 05:25:21 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:27143 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261919AbVEYJZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 05:25:05 -0400
Date: Wed, 25 May 2005 02:27:37 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Sven Dietrich <sdietrich@mvista.com>,
       "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Andrew Morton'" <akpm@osdl.org>, dwalker@mvista.com, mingo@elte.hu,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance (scheduler)
Message-ID: <20050525092737.GA28976@nietzsche.lynx.com>
References: <005801c560da$ec624f50$c800a8c0@mvista.com> <429407B6.1000105@yahoo.com.au> <20050525060919.GA25959@nietzsche.lynx.com> <4294228D.1040809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4294228D.1040809@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 05:00:29PM +1000, Nick Piggin wrote:
> Err, no. Please read what was written.
> 
> "With multiple disks on a chain, you can see transients that
> lock up the CPU in IRQ mode for human-perceptible time,
> especially on slower CPUs... "

ok, yeah, I thought you were talking about something else. Email
is a tricky medium at times.

> I was pointing out that this will be a throughput rather than
> latency issue. Unless you're saying that an interrupt handler
> will run for 30ms or more?

Don't know. For non-DMA IDE access data copies are CPU driven
which can create tons of latency problems for that case. irq-threads
run as SCHED_FIFO and can freeze the system under heavy IO load
in that situation.

The way I interpreted the comment originally was irq-threads suck
which is why these latency happens. This is not what you ment. The
fear here is that there would be a push in the discussion to revert
some of this preemption work away from full preemption to more
conservative techniques like preemption points, which would drive
me absolutely bonkers right now.

> It is relevant because code complexity is relevant. Have you
> been reading what has been said? Don't take my word for it, read
> what Andrew is saying.

I reread those comments.

I suggest that you read the patch for the answer to softirq
complexity. You'll find the implementation sane. It's a simple add-on
to how softirqs are handled currently with but pushed all ksoftirqd.
What was non-preemptible execution at the end of an IRQ handler in
the normal kernel is now pushed all to that thread. There's no mystery
magic here.

> I haven't looked at *any* part of *any* patch, nor commented on
> any patch. I described the type of discussion and acceptance
> that needs to happen before a large patch (like this) gets merged.

I interpreted the ksoftirqd comment/worry you said was just that,
inserting a concern about something you percieved as a possible
problem, therefore doubt.

> I also backed up Andrew's assertion that better interrupt latencies
> wouldn't really help interactivity (the scheduler is a *far* bigger
> factor here)

This is a complicated problem and I'm not sure what folks are getting
at with the irq latency track other than it exists and it effects
overall latency in the system. Running above the priority of the
irq-thread handlers in a fully preemptible kernel should permit that
thread to run that task and service that thread at hand. Having the
ability to do that *could* help with overall system interactivity,
but it would require proper userspace apps to exploit it.
 
> I don't know what you're talking about, sorry.

I thought you were doing some kind of scheduler CPU NUMA migration
stuff ?

> Why are people so touchy about this subject? I didn't even anywhere
> criticize anyone's patches or any approach or idea!! :\

Because it's a radical conceptual change to the kernel and this
development group has been classically resistent to these kind of
changes from what I've seen. There's also an insane amount of pressure
from commericial circle to blow this patch out of the water before
inclusion. Just because you haven't seen it yet doesn't mean it's not
going to happen. You can bet that RTOS folks are going to be all over
it in a negative way and they aren't as friendly as you.

Just about everybody in the RTOS works knows this is going to be an
atomic bomb to the industry for better or worse. This is excluding
the freakout nature of the SGI-ish stuff you'll be able to do with
this patch. Just wait until somebody gets a frame locked Doom3 out. :)

> The best way to get anything to happen is to get a common
> understanding going through constructive discussion. Please stick to
> that. Thanks.

Sorry, yeah, I'm a bit jumpy from dealing with chronic irrationality
from the FreeBSD group, which has created low expectations from various
open source groups at times. Interaction with other jumpy kernel
conservatives in this community doesn't the help the matter.

Basically, the more you read http://linuxdevices.com the more you'll
understand why folks are edgy about this. :)

bill

