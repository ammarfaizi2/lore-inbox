Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUGVSx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUGVSx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266908AbUGVSx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:53:57 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:2979 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266900AbUGVSxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:53:46 -0400
Date: Thu, 22 Jul 2004 14:53:08 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722185308.GC4774@yoda.timesys>
References: <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722074034.GC7553@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 09:40:34AM +0200, Ingo Molnar wrote:
> * Scott Wood <scott@timesys.com> wrote:
> > This sort of substitution is what we did in 2.4, though we made this
> > type the default and gave the real spinlocks a new name to be used in
> > those few places where it was really needed.  Of course, this resulted
> > in a lot of places using a mutex where a spinlock would have been
> > fine.
> 
> what are those few places where a spinlock was really needed?

Places that inherently cannot sleep, such as inside the scheduler,
the unthreadable part of the hard IRQ code, inside the mutex
implementation, etc.

> I'm a bit uneasy about making mutexes the default not due to performance
> but due to e.g. some hardware being very timing-sensitive. 

In practice, this didn't turn out to be an issue; most modern
hardware seems to be pretty tolerant of that (and you already have to
deal with things like interrupts getting in the way), and drivers
which do local_irq_disable() or to ensure timing will still work.

Has this sort of problem been seen with RT-Linux and such, which
would cause similar delays?

-Scott
