Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUJGU2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUJGU2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUJGU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:27:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44777 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268045AbUJGU0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:26:47 -0400
Date: Thu, 7 Oct 2004 13:24:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, jbarnes@sgi.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: <200410071945.i97Jj8lV016039@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410071318060.24477@schroedinger.engr.sgi.com>
References: <200410071945.i97Jj8lV016039@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Roland McGrath wrote:

> All glibc users need is one definition of the most accurate CPU time clock
> available, and that will be provided through the POSIX interfaces
> (CLOCK_THREAD_CPUTIME_ID, CLOCK_PROCESS_CPUTIME_ID, clock_getcpuclockid,
> and pthread_getcpuclockid).  We have no intention of providing detailed
> access to different kinds of hardware clocks in a glibc interface.  If you
> want that, write your own separate interface.  Users I know about are
> interested in the most accurate CPU time tracking that is available on the
> system they are using in a given instance.  This is what they get by
> letting the kernel implementation, configuration, and hardware detection
> choose the optimal way to implement sched_clock, which is what they now get.

CLOCK_*_CPUTIME_ID are not clocks in a real sense. The user should
never choose those for real time. The most accurate time is provided by
CLOCK_REALTIME by the kernel.

> By contrast, your patch provides a new way to access the
> least-common-denominator low-resolution information already available by
> other means, and nothing more.

Yes the information is available also through the /proc filesystem. But it
should also be available through clock_gettime and friends. The patch
makes these calls posix compliant nothing more. Increasing the accuracy
of the timers better be done with the revision of the time handling
proposed by John Stultz.

> I'm sorry that you do not see it.  "My context" is that the actual
> problems, some of which you've talked about and some of which you seem to
> have misunderstood, are indeed solved by the work I've done, and I've
> explained more than once how that is the case.  I'm glad that you are not
> unhappy continuing to discuss the issue.  I don't mind continuing any
> discussion that is making any progress.  I hope you also don't have a
> problem foregoing the ten repetitions of your understanding of the
> situation, which I believe you have already communicated successfully so I
> understand what you think about it, and addressing yourself instead to any
> concrete concerns that remain given a clear understanding of what the new
> situation will in fact be given my kernel implementation and appropriate
> glibc support tailored for it.

I am happy that you are at least discussing the issue.

I did not see a clean implementation of CLOCK_*_CPUTIME_ID,
nor that the issue of providing additional clocks via clock_gettime
was addressed.


