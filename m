Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTCJWYA>; Mon, 10 Mar 2003 17:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCJWYA>; Mon, 10 Mar 2003 17:24:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:19176 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261874AbTCJWX6>;
	Mon, 10 Mar 2003 17:23:58 -0500
Date: Mon, 10 Mar 2003 14:29:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: torvalds@transmeta.com, cobra@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030310142944.2dff3422.akpm@digeo.com>
In-Reply-To: <3E6D0FD5.2090707@mvista.com>
References: <Pine.LNX.4.44.0303101147200.2542-100000@home.transmeta.com>
	<3E6D0FD5.2090707@mvista.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2003 22:34:29.0793 (UTC) FILETIME=[36D48910:01C2E755]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Linus Torvalds wrote:
> > On Mon, 10 Mar 2003, george anzinger wrote:
> > 
> >>Lets consider this one on its own merits.  What SHOULD sleep do when 
> >>asked to sleep for MAX_INT number of jiffies or more, i.e. when 
> >>jiffies overflows?  My notion, above, it that it is clearly an error. 
> > 
> > 
> > My suggestion (in order of preference):
> >  - sleep the max amount, and then restart as if a signal had happened
> 
> I think this will require a 64-bit expire in the timer_struct 
> (actually it would not be treated as such, but the struct would still 
> need the added bits).  Is this ok?
> 
> I will look at the problem in detail and see if there might be another 
> way without the need of the added bits.

Is it not possible to just sit in a loop, sleeping for 0x7fffffff jiffies
on each iteration?  (Until the final partial bit of course)

> Hm...  I changed it to what it is to make it easier to track down 
> problems in the test code... and this was user code.  My thinking was 
> that such large values are clear errors, and having the code "hang" in 
> the sleep just hides the problem.  But then, I NEVER make a system 
> call without checking for errors....  And, I was making a LOT of sleep 
> calls and wanted to know which one(s) were wrong.

If an app wants to sleep forever, calling

	while (1)
		sleep(MAX_INT);

seems like a reasonable approach.  I'd expect quite a lot of applications
would be doing that.

