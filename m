Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVBBVjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVBBVjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVBBVfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:35:43 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:4109 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262601AbVBBVeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:34:25 -0500
Date: Wed, 2 Feb 2005 13:34:02 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050202213402.GB14023@nietzsche.lynx.com>
References: <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <87is5ahpy1.fsf@sulphur.joq.us> <20050202211405.GA13941@nietzsche.lynx.com> <20050202212100.GA12808@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202212100.GA12808@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:21:00PM +0100, Ingo Molnar wrote:
> yes and no. You are right in that the individual workloads (e.g.
> softirqs) are not separated and identified/credited to the thread that
> requested them. (in part due to the fact that you cannot e.g. credit a
> thread for e.g. unrequested workloads like incoming sockets, or for
> 'merged' workloads like writeout of a commonly accessed file.)

What's not being addressed here is a need for pervasive QoS across all
kernel systems. The power of this patch is multiplicative. It's not
about a specific component of the system having microsecond latencies,
it's about how all parts, softirqs, hardirqs, VM, etc... work together
so that the entire system is suitable for (near) hard real time. It's
unconstrained, unlike dual kernel RT systems, across all component
boundaries. Those constraints create large chunks of glue logic between
systems, which is exploded the complexity of things that app folks
much deal with.

This is where properly written Linux apps (non exist right now because
of kernel issues) can really overtake competing apps from other OSes
(ignoring how crappy X11 is).
 
> but Jack is right in practical terms: the audio folks achieved pretty
> good results with the current IRQ threading mechanism, partly due to the
> fact that the audio stack doesnt use softirqs, so all the
> latency-critical activities are in the audio IRQ thread and the
> application itself.

It's clever that they do that, but additional control is needed in the
future. jackd isn't the most sophisticate media app on this planet (not
too much of an insult :)) and the demands from this group is bound to
increase as their group and competing projects get more and more
sophisticated. When I mean kernel folks needs to be proactive, I really
mean it. The Linux kernel latency issues and poor driver support is
largely why media apps are way below even being second rate with regard
to other operating systems such as Apple's OS X for instance.

bill

