Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUIYF0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUIYF0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 01:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUIYF0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 01:26:07 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60844 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269240AbUIYF0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 01:26:03 -0400
Date: Fri, 24 Sep 2004 22:25:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and
 CLOCK_PROCESS_CPUTIME_ID
In-Reply-To: <4154F349.1090408@redhat.com>
Message-ID: <Pine.LNX.4.58.0409242214140.12816@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Ulrich Drepper wrote:

> This is pretty useless.  Why would you need kernel support for this, it
> just measures realtime.

Glibc cannot do that reliably on an SMP system with its HP_TIMING
technique. Even systems with "synchronized" CPU timers typically have an
offset between the timers of different CPUs.

> We have an implementation of the CPU time in glibc which can easily be
> changed to support clocks of this precision if there are no usable
> timestamp counters (which is what is currently used).

Sorry it cannot be easily changed as I have repeatedly experienced.
I have posted lots of patches to address that issue for SMP systems which
were all rejected and you got insulted by my attempt to discuss the
problem and insisted that it was "solved".

> And all this is not really what was really meant by "CPU time" in the
> POSIX spec.  We hijacked this symbol, maybe incorrectly so.  What is
> really meant is how much time a process/thread actually _uses_ the CPU
> (hence the name).  I.e., the information contained in struct rusage.
>
> For this I would love to get kernel support and we hopefully have soon a
> patch for this.

Yes this may be easily addressed in the kernel. clock_gettime belongs
completely into the kernel. Could we get glibc to no longer handle clocks
on its own? The glibc code has always been horribly broken on SMP systems
and I fear that lots of software now assumes that CLOCK_PROCESS_CPUTIME_ID
gets you the runtime of the current process. The patch would allow this
software to run reliably on an SMP system.
