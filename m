Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUJFBXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUJFBXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUJFBXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:23:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34992 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266613AbUJFBXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:23:30 -0400
Date: Tue, 5 Oct 2004 18:21:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, jbarnes@sgi.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: <200410060035.i960Z1Iv007864@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410051809590.30594@schroedinger.engr.sgi.com>
References: <200410060035.i960Z1Iv007864@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Roland McGrath wrote:

> > Maybe its best then to restrict this definition to glibc?
>
> I can't figure out what problem you think exists or what you are trying to
> gain here.

If clockid_t with your proposed bitfields would be restricted to glibc
alone then we would not have to deal with these bits on the kernel level.

The clock_gettime function calls would take a clock number, not a
clockid_t  in the way that you want to use it. That would allow us to keep
the interface clear of pids mixed with clock numbers.

> > How will you provide the necessary hardware interface for the kernel
> > clocks?
>
> You again seem to be asking a question that makes no sense in the context
> that I have already explained.

The question is pretty acute. Currently glibc accesses CPU timers on its
own bypassing the kernel. Most of the times it works but on lots of
systems this is royally screwed up and CLOCK_*_CPUTIME_ID returns funky
values.

User needs to be able to use the specialized clocks provided by the
kernel. Currently CLOCK_REALTIME and CLOCK_MONOTONIC are the only clocks
that glibc will use. It seems that some people have tried to convince the
glibc maintainers to allow more clocks (in particular CLOCK_REALTIME_HR
and CLOCK_REALTIME_HR). The current patch in mm provides for
CLOCK_SGI_CYCLE.

We have been trying to get a resolution on these issues for a long time
from the glibc folks (I can trace the CPUTIME issue back at least 1 1/2
years).

Would be possible to define a clean interface that would get glibc out of
the business of accessing hardware directly and allow some sanity in terms
of clock access?

Does this fit not into your context? I have stated the problem a gazillion
times, I probably have no problem in explaining it another ten times to you.

I do not see that you are solving the most urgent problems. Instead we get
funky forms of pid's mixed with clockid's.


