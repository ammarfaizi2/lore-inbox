Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVBKJ4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVBKJ4H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVBKJ4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:56:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18576 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262237AbVBKJzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:55:33 -0500
Date: Fri, 11 Feb 2005 10:53:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211095327.GB6229@elte.hu>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu> <20050211084107.GG15058@waste.org> <20050211085942.GB3980@elte.hu> <20050211094021.GJ15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211094021.GJ15058@waste.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> On Fri, Feb 11, 2005 at 09:59:42AM +0100, Ingo Molnar wrote:
> > 
> > think of SCHED_FIFO on the desktop as an ugly wart, a hammer, that
> > destroys the careful balance of priorities of SCHED_OTHER tasks. Yes, it
> > can be useful if you _need_ a scheduling guarantee due to physical
> > constraints, and it can be useful if the hardware (or the kernel) cannot
> > buffer enough, but otherwise, it only causes problems.
> 
> Agreed. I think something short of full SCHED_FIFO will make most
> desktop folks happy. [...]

ah, but it's not the desktop folks who have to be happy but users :-)
Really, if you ask any app designer then obviously 'the more CPU time we
get for sure, the better our app behaves'. So in that sense SCHED_OTHER
is a fair playground: if you behave nicely you'll have higher priority
and shorter latencies.

(there are things like SCHED_ISO but how good of a solution they are is
not yet clear.)

> [...] But a) we still have to figure out exactly how to do that and b)
> we still have to make everyone else happy. The embedded folks (me
> included) would prefer to not run our realtime bits as root too..

you dont have to - you can drop root after startup.

> > but i'm not sure how rlimits will contain the whole problem - can
> > rlimits be restricted to a single app (jackd)?
> 
> Yes. There's also the whole soft limit thing.

i'm curious, how does this 'per-app' rlimit thing work? If a user has
jackd installed and runs it from X unprivileged, how does it get the
elevated rlimit? (while the rest of his desktop still runs with a safe
rlimit.) SELinux/RT-LSM could do this, but i'm not sure about how
rlimits give this to you.

	Ingo
