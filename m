Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbSKGU7O>; Thu, 7 Nov 2002 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbSKGU7O>; Thu, 7 Nov 2002 15:59:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:52975 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266448AbSKGU7N>;
	Thu, 7 Nov 2002 15:59:13 -0500
Message-ID: <3DCAD5A9.D4D4C1CB@digeo.com>
Date: Thu, 07 Nov 2002 13:05:45 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, jw@pegasys.ws, wa@almesberger.net,
       andersen@codepoet.org, woofwoof@hathway.com
Subject: Re: ps performance sucks
References: <Pine.LNX.3.96.1021107120208.30525E-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Nov 07, 2002 12:19:15 PM <200211072042.gA7KglX121245@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 21:05:45.0712 (UTC) FILETIME=[709EFF00:01C286A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> In case you happen to know where they are, I'm looking for these:
> 
> pages reclaimed

/proc/vmstat:pgsteal

> minor faults

/proc/vmstat:pgfault - /proc/vmstat:pgmajfault

> COW faults
> zero-page faults

These are not available separately

> anticipated short-term memory shortfall

hm.  tricky.

> pages freed

/proc/vmstat:pgfree

This is a little broken in 2.5.46.  pgfree is accumulated
_before_ the per-cpu LIFO queues and pgalloc is accumulated _after_
the per-cpu queues (or vice versa) so they're out of whack.  

> pages scanned by page-replacement algorithm

/proc/vmstat:pgscan

> clock cycles by page replacement algorithm

Not available.  Could sum up the CPU across all kswapd instances,
which is a bit lame.

> number of system calls

Not available

> number of forks (fork, vfork, & clone) and execs

/proc/stat: processes
