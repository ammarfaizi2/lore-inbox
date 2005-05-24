Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVEXXpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVEXXpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVEXXpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:45:34 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:63748 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262172AbVEXXom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:44:42 -0400
Date: Tue, 24 May 2005 16:49:11 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: Sven Dietrich <sdietrich@mvista.com>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Esben Nielsen'" <simlo@phys.au.dk>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, "'Philippe Gerum'" <rpm@xenomai.org>
Subject: Re: RT patch acceptance
Message-ID: <20050524234911.GC17781@nietzsche.lynx.com>
References: <001701c560a6$cafbe2b0$c800a8c0@mvista.com> <4293AB4D.4030506@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4293AB4D.4030506@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 06:31:41PM -0400, Karim Yaghmour wrote:
> <repeating-myself>
> From my POV, it just seems that it's worth asking a basic
> question: what is the least intrusive modification to the Linux
> kernel that will allow obtaining hard-rt and what mechanisms
> can we or can we not build on that modification? Again, my
> answer to this question doesn't matter, it's the development
> crowd's collective answer that matters. And in championing
> the hypervisor/nanokernel path, I could turn out to be horribly
> wrong. At this stage, though, I'm yet unconvinced of the
> necessity of anything but the most basic kernel changes (as
> in using function pointers for the interrupt control path,
> which could be a CONFIG_ also).

I know what you're saying and it's kind unaddressed by various
in this discussion.

When I think of the advantages of a single over dual image kernel
system I think of it in terms of how I'm going to implement QoS.
If I need to get access to a special TCP/IP socket in real time
with strong determinancy you run into the problem of crossing to
kernel concurrency domains, one preemptible one not, with a dual
kernel system and have to use queues or other things to
communicate with it. Even with lockless structures, you're still
expressing latency in the Linux kernel personality if you have
some kind of preexisting app that's already running in an atomic
critical section holding non-preemptive spinlocks.

However this is not RTAI as I understand it since it can run N
number of image for each RT task (correct?)

Having multipule images helps out, but fails in scenarios where
you have to have tight data coupling. I have to think about things
like dcache_lock, route tables, access to various IO system like
SCSI and TCP/IP, etc...

A single system image makes access to this direct unlike dual kernel
system where you need some kind of communication coupling. Resource
access is direct. Modifying large grained subsystems in the kernel
is also direct. As preexisting multimedia apps use more RT facilities,
apps are going to need something more of a general purpose OS to make
development easiler. These aren't traditional RT apps at all, but
still require hard RT response times. Keep in mind media apps use
the screen, X11, audio device(s), IDE/SCSI for streaming, networking,
etc... It's a comprehensive use of many of the facilities of kernel
unlike traditional RT apps.

Now, this doesn't necessarily replace RTAI, but a preemptive Linux
kernel can live as a first-class citizen to RTAI. I've been thinking
about merging some of the RTAI scheduler stuff into the RT patch.
uber-preemption Linux doesn't have a sophisticate userspace yet
and here RTAI clearly wins, no decent RT signal handling, etc...
There are other problems with it and the current implementation.
This is going to take time to sort out so RTAI still wins at this
point.

I hope I addressed this properly, but that's the point of view
I'm coming from.

bill

