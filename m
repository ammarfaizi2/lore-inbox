Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVBKI0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVBKI0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVBKI0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:26:11 -0500
Received: from waste.org ([216.27.176.166]:23518 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262218AbVBKI0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:26:02 -0500
Date: Fri, 11 Feb 2005 00:25:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211082536.GF15058@waste.org>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain> <20050211065753.GE15058@waste.org> <20050211075417.GA2287@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211075417.GA2287@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 08:54:17AM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > Eh? Chris Wright's original rlimits patch was very straightforward
> > [...]
> 
> the problem is that it didnt solve the problem (unprivileged user can
> lock up the system) in any way.

There are two separate but related problems:

a) need a way to give non-root access to SCHED_FIFO without other
privileges

b) would like a way to have RT-like capabilities without risk of DoS

The original rlimits patch solves (a), which is the pressing concern.

The existence of a satisfactory solution to related problem (b) has
yet to be demonstrated. And even if a solution for (b) is found that
is satisfactory for, say, high end audio users, it may not necessarily
be sufficient for everyone who might have wanted SCHED_FIFO for
non-root processes. So we still need a solution for (a).

> So after it became visible that all the
> existing 'dont allow users to lock up' solutions are too invasive, we
> went to recommend the solution that introduces the least architectural
> problems: RT-LSM.

RT-LSM introduces architectural problems in the form of bogus API. And
I claim that if RT-LSM becomes part of the mainline kernel, it -will-
become a default feature on the desktop in short order. The fact that
it's implemented as an LSM is meaningless if Redhat and SuSE ship it
on by default.

So the comparison boils down to putting a magic gid in a sysfs
file/module parameter or setting an rlimit with standard tools (PAM,
etc). I'm really boggled that anyone could prefer the former,
especially since we had almost this exact debate over what became the
mlock rlimit!

Here's Chris' patch for reference:

http://groups-beta.google.com/group/linux.kernel/msg/6408569e13ed6e80

-- 
Mathematics is the supreme nostalgia of our time.
