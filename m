Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276921AbRJHPJy>; Mon, 8 Oct 2001 11:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276339AbRJHPJo>; Mon, 8 Oct 2001 11:09:44 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:57348 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276921AbRJHPJe>; Mon, 8 Oct 2001 11:09:34 -0400
Date: Mon, 8 Oct 2001 11:10:04 -0400
Message-Id: <200110081510.f98FA4910571@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20011008023118.L726@athlon.random>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011008023118.L726@athlon.random> andrea@suse.de wrote:

| You're perfectly right that it's not ok for a generic computing
| environment to spend lots of cpu in polling, but it is clear that in a
| dedicated router/firewall we can just shutdown the NIC interrupt forever via
| disable_irq (no matter if the nic supports hw flow control or not, and
| in turn no matter if the kid tries to spam the machine with small
| packets) and dedicate 1 cpu to the polling-work with ksoftirqd polling
| forever the NIC to deliver maximal routing performance or something like
| that.  ksoftirqd will ensure fairness with the userspace load as well.
| You probably wouldn't get a benefit with tux because you would
| potentially lose way too much cpu with true polling and you're traffic
| is mostly going from the server to the clients not the othet way around
| (plus the clients uses delayed acks etc..), but the world isn't just
| tux.
| 
| Of course we agree that such a "polling router/firewall" behaviour must
| not be the default but it must be enabled on demand by the admin via
| sysctl or whatever else userspace API. And I don't see any problem with
| that.

  Depending on implementation, this may be an acceptable default,
assuming that the code can determine when too many irqs are being
serviced. There are many servers, and even workstations in campus
environments, which would benefit from changing to polling under burst
load. I don't know if even a router need be locked in that state, it
should stay there under normal load.

  I'm convinced that polling under heavy load is beneficial or
non-harmful on virtually every type of networked machine. Actually, any
machine subject to interrupt storms, many device interface or control
systems can get high rates due to physical events, networking is just a
common problem.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
