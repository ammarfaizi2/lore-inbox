Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262132AbTCHSSL>; Sat, 8 Mar 2003 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbTCHSSL>; Sat, 8 Mar 2003 13:18:11 -0500
Received: from vitelus.com ([64.81.243.207]:29702 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S262132AbTCHSSK>;
	Sat, 8 Mar 2003 13:18:10 -0500
Date: Sat, 8 Mar 2003 10:28:21 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030308182821.GB408@vitelus.com>
References: <20030307070005.GB21885@vitelus.com> <Pine.LNX.4.44.0303070832430.4401-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303070832430.4401-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 08:36:12AM +0100, Ingo Molnar wrote:
> > I was able to reproduce them by selecting text in Mathematica (ugh, not
> > a very helpful example). The skips were shorter and about three times as
> > hard to trigger as on 2.5.63.
> 
> okay, just as a data point, could you try to renice the player
> process/thread to -2? Does it make the skipping harder to trigger?
> How about -5, or -10?

Renicing all xmms threads to -2 makes the problem impossible to
trigger in this way. I'm sorry for having such a stupid testcase;
Mathematica is proprietary software, and judging by the way it makes
XMMS skip, it's probably doing something stupid. XMMS also has a "Use
realtime priority" option, which makes it do:

	sparam.sched_priority = sched_get_priority_max(SCHED_RR);
	sched_setscheduler(0, SCHED_RR, &sparam);

Obviously, this requires root privileges, however, it also prevents
the skipping. I wonder if setting CAP_SYS_NICE on xmms and hacking it
to ignore geteuid() would be safe.
