Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbTCSCsc>; Tue, 18 Mar 2003 21:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262916AbTCSCsc>; Tue, 18 Mar 2003 21:48:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:44974 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262908AbTCSCsb>;
	Tue, 18 Mar 2003 21:48:31 -0500
Date: Tue, 18 Mar 2003 18:59:35 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
Message-Id: <20030318185935.2735c583.akpm@digeo.com>
In-Reply-To: <3E77D7DE.6090004@mvista.com>
References: <Pine.LNX.4.33.0303182123510.30255-100000@gans.physik3.uni-rostock.de>
	<3E77D107.30406@mvista.com>
	<20030318203125.054b2704.akpm@digeo.com>
	<3E77D7DE.6090004@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 02:59:18.0314 (UTC) FILETIME=[886E70A0:01C2EDC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> > There is currently a mysterious timer lockup happening on power4 machines. 
> > I'd like to keep these changes well-separated in time so we can get an
> > understanding of what code changes correlate with changed behaviour.
> 
> Tell me more...

Don't know much more really.  Anton has a machine which fairly repeatably
locks up at jiffies = 0x100104100.

> Latest BK. Ive been getting this lockup for a while,
> It _always_ triggers when jiffies = 0x100104100.
> 
> c000000000068a14 cascade+0x74
> c0000000000694a4 run_timer_softirq+0x244
> c0000000000614f0 do_softirq+0x174
> c000000000012c10 timer_interrupt+0x1a8
> c000000000012a0c cpu_idle+0xc0

This _might_ be the timer-handler-does-add_timer(right now) lockup which was
fixed in Linus's tree today.
