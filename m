Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVBKImI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVBKImI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVBKImH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:42:07 -0500
Received: from waste.org ([216.27.176.166]:60127 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262000AbVBKIlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:41:25 -0500
Date: Fri, 11 Feb 2005 00:41:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211084107.GG15058@waste.org>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211081422.GB2287@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 09:14:22AM +0100, Ingo Molnar wrote:
> 
> > I think it's important to recognize that we're trying to address an
> > issue that has a much wider potential audience than pro audio users,
> > and not very far off - what is high end audio performance today will
> > be expected desktop performance next year.
> 
> i disagree that desktop performance tomorrow will necessarily have to
> utilize SCHED_FIFO. Today's desktop audio applications perform quite
> good at SCHED_NORMAL priorities [with the 2.6.11 kernel that has more
> interactivity/latency fixes such as PREEMPT_BKL].

Desktop performance tomorrow will want realtime audio AND video. 
Think simultaneous record and playback of multiple high-definition
video streams. There's a demand for this; my company already sells it.
 
> the pro applications will always want to have a 100% guarantee (it
> really sucks to generate a nasty audio click during a live performance)
> and want to utilize as much CPU time for audio as needed. They are also
> clearly the most complex creators of audio so they go far above the
> normal (and reasonable) CPU-use/latency expectations and tradeoffs of
> the stock scheduler.

The pro will want to do his work on a stock desktop system. More
importantly, the hobbyist will want to do exactly what the pro is
doing on the same system. 

> > So I think it's critical that we find solution that's appropriate for
> > _every single box_, because realistically vendors are going to ship
> > with this "wholly self-contained" feature turned on by default next
> > year, at which point the "containment" will be nil and whatever warts
> > it has will be with us forever.
> 
> an "RT priorities rlimit" is still not adequate as a desktop solution,
> because it still allows the box to be locked up. Also, if it turns out
> to be a mistake then it's already codified into the ABI, while RT-LSM is
> much less 'persistent' and could be replaced much easier. RT-LSM is also
> more flexible and more practical. (an rlimit needs changes across a
> number of userspace components, delaying its adoptation.)

I'm very suspicious about being able to rip out RT-LSM once it's
introduced. See devfs. And I think the adoption barrier thing is a red
herring as well: the current users are by and large compiling their
own RT-tuned kernels.

> > The rlimit stuff is not perfect, but it's a much better fit for the
> > UNIX model generally, which is a fairly big win. [...]
> 
> a 'locked up box' is as far away from the UNIX model as it gets.

Rlimits are already the favored tool for dealing with the classic UNIX DoS:
the fork bomb. Turn off process limits, tada, locked up box.

-- 
Mathematics is the supreme nostalgia of our time.
