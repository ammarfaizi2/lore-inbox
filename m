Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVBKRpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVBKRpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVBKRlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:41:39 -0500
Received: from waste.org ([216.27.176.166]:15059 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261640AbVBKRiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:38:10 -0500
Date: Fri, 11 Feb 2005 09:37:51 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211173751.GK15058@waste.org>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu> <20050211084107.GG15058@waste.org> <20050211085942.GB3980@elte.hu> <20050211094021.GJ15058@waste.org> <20050211095327.GB6229@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211095327.GB6229@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 10:53:27AM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > On Fri, Feb 11, 2005 at 09:59:42AM +0100, Ingo Molnar wrote:
> > > 
> > > think of SCHED_FIFO on the desktop as an ugly wart, a hammer, that
> > > destroys the careful balance of priorities of SCHED_OTHER tasks. Yes, it
> > > can be useful if you _need_ a scheduling guarantee due to physical
> > > constraints, and it can be useful if the hardware (or the kernel) cannot
> > > buffer enough, but otherwise, it only causes problems.
> > 
> > Agreed. I think something short of full SCHED_FIFO will make most
> > desktop folks happy. [...]
> 
> ah, but it's not the desktop folks who have to be happy but users :-)
> Really, if you ask any app designer then obviously 'the more CPU time we
> get for sure, the better our app behaves'. So in that sense SCHED_OTHER
> is a fair playground: if you behave nicely you'll have higher priority
> and shorter latencies.
> 
> (there are things like SCHED_ISO but how good of a solution they are is
> not yet clear.)
> 
> > [...] But a) we still have to figure out exactly how to do that and b)
> > we still have to make everyone else happy. The embedded folks (me
> > included) would prefer to not run our realtime bits as root too..
> 
> you dont have to - you can drop root after startup.
> 
> > > but i'm not sure how rlimits will contain the whole problem - can
> > > rlimits be restricted to a single app (jackd)?
> > 
> > Yes. There's also the whole soft limit thing.
> 
> i'm curious, how does this 'per-app' rlimit thing work? If a user has
> jackd installed and runs it from X unprivileged, how does it get the
> elevated rlimit?

It needs a setuid launcher. It would be nice to be able to elevate the
rlimits of running processes but the API doesn't exist yet.

>From the POV of accidental elevation to RT, soft limits are
sufficient. But we can't stop a user from exploiting an app they own
with RT privileges from elevating other apps via ptrace+exec or
whatever. Nor with RT-LSM.

> (while the rest of his desktop still runs with a safe
> rlimit.) SELinux/RT-LSM could do this, but i'm not sure about how
> rlimits give this to you.

How does it get done with RT-LSM? Setgid binaries? It only
discriminates on a group granularity. Or are you saying "and SELinux"
rather than "or SELinux"?

-- 
Mathematics is the supreme nostalgia of our time.
