Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTAQUwN>; Fri, 17 Jan 2003 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbTAQUwN>; Fri, 17 Jan 2003 15:52:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:10235 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261337AbTAQUwM>;
	Fri, 17 Jan 2003 15:52:12 -0500
Date: Fri, 17 Jan 2003 13:00:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] Database results 2.4 versus 2.5
Message-Id: <20030117130046.0f73d6d6.akpm@digeo.com>
In-Reply-To: <200301171921.h0HJLSA17204@mail.osdl.org>
References: <200301171921.h0HJLSA17204@mail.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 21:01:04.0817 (UTC) FILETIME=[8C861210:01C2BE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> 
> We have found some very nice database performance improvements in the
> OSDL-DBT-2 database workload comparing the latest 2.4 kernel with 2.5.49
> on a 8-way Profusion Xeon 700MHz Pentium III system with 4GB of memory.
> We suspect there will be I/O improvements after moving to the latest
> 2.5 releases.  We would like to optimize our memory utilization before
> moving on to those experiments.

So it sounds like DBT2 is stabilised now, and producing repeatable results? 
That's excellent.

> ...
> We did several runs of each variant (cached and non-cached) on each of
> the two OS versions (2.4.21-pre3 and 2.5.49*).  Run variances were low
> compared to the differences we saw between OS versions.  Results are as
> follows (numbers represent average over the runs):

I notice you're using an extremeraid 2000?  I have one of those, and
immediately shelved it when I saw how slow it is ;)

> 
> Linux       DBT2      Metric  Wrkld %memused            iostats
> Version     Workload (bigger Speedup on4GB   %user %sys  total
>                       better)                            iops
> ___________________________________________________________________
> 2.4.21-pre3 cached     4479          99.73    74.24 3.64  **     
> 2.5.49 (*)  cached     5040          99.73    85.37 2.85  381   
>             cached            12.5%     
> ___________________________________________________________________     
> 2.4.21-pre3 noncached  1407.8        95.11    25.75 9.68   **
> 2.5.49 (*)  noncached  1667.5        99.68    49.12 7.2   1461          
>            non-cached        18.4%      
> ___________________________________________________________________
> ** iostats is broken at 2.4 due to driver problems.  

Interesting.  All the gains here are due to reduced idle time.

So either the I/O scheduler is doing a better job, or the VM page
replacement decisions are agreeable for this load.

> The %sys drops going from 2.4 to 2.5 in both cases.  We suspect this is
> due to lack of paging in the 2.5 runs.

Yup.  Do you have all the vmstat traces and all the other goodies?  The
pgpgin/pgpgout numbers, etc seem to be wrong there.


This could easily be a complete fluke, and you may find that with
smaller/larger working sets or smaller/larger physical memory, the difference
goes away.


