Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVBKULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVBKULa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVBKUL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:11:29 -0500
Received: from waste.org ([216.27.176.166]:58250 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262325AbVBKUKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:10:38 -0500
Date: Fri, 11 Feb 2005 12:10:18 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211201018.GM15058@waste.org>
References: <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu> <20050211084107.GG15058@waste.org> <20050211085942.GB3980@elte.hu> <20050211094021.GJ15058@waste.org> <20050211095327.GB6229@elte.hu> <20050211173751.GK15058@waste.org> <20050211174905.GC17387@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211174905.GC17387@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 06:49:05PM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > > > Yes. There's also the whole soft limit thing.
> > > 
> > > i'm curious, how does this 'per-app' rlimit thing work? If a user has
> > > jackd installed and runs it from X unprivileged, how does it get the
> > > elevated rlimit?
> > 
> > It needs a setuid launcher. It would be nice to be able to elevate the
> > rlimits of running processes but the API doesn't exist yet.
> 
> With a setuid launcher you need _zero_ kernel help to get SCHED_FIFO: if
> you have a launcher then already today it can just give SCHED_FIFO to
> jackd and be done with it!

I'm sure you know all this already but I'll spell it out so we're all
clear:

a) rlimits are tracked per-process so they're fundamentally
per-process
b) there are hard and soft limits, with soft always <= hard
c) only root can raise hard rlimits, but normal users can lower them
d) if a user owns a process, he can gain the privileges of that process
by various means, so in the strict sense per-process privileges are
meaningless - all privileges are per-uid
e) so we either need to segregate all privileged processes into
separate uid domains
f) or we're assuming non-malicious users and soft limits are
sufficient.

Now I suspect we don't want to insist people do (e) (though I'd
certainly encourage them to try).

Don't forget that the rlimits approach allows us to reserve the
highest priorities for root. I'm pretty sure an effective watchdog
policy can thus be implemented in userspace, which RT-LSM can't really
offer.

-- 
Mathematics is the supreme nostalgia of our time.
