Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbTCGIKt>; Fri, 7 Mar 2003 03:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbTCGIKt>; Fri, 7 Mar 2003 03:10:49 -0500
Received: from pop.gmx.net ([213.165.65.60]:62712 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261455AbTCGIKs>;
	Fri, 7 Mar 2003 03:10:48 -0500
Message-Id: <5.2.0.9.2.20030307091633.00cfbd28@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 09:26:00 +0100
To: Andrew Morton <akpm@digeo.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Cc: mingo@elte.hu, torvalds@transmeta.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030307001002.74b8662b.akpm@digeo.com>
References: <5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
 <5.2.0.9.2.20030307075851.00cf5448@pop.gmx.net>
 <5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:10 AM 3/7/2003 -0800, Andrew Morton wrote:
>Mike Galbraith <efault@gmx.de> wrote:
> >
> > ...
> > Best would be for other testers to run some tests.  With the make -j30
> > weirdness, I _suspect_ that other oddities (hmm... multi-client db load...
> > query service time) will show.
> >
>
>Yes, this is the second surprise interaction between the CPU scheduler
>and the IO system.
>
>Perhaps.  In your case it seems that you're simply unable to generate
>the amount of concurrency which you used to.  Which would make it purely
>a CPU scheduler thing.

Yes, of this I'm sure.

>It is not necessarily a bad thing (unless your total runtime has increased?)
>but we need to understand what has happened.

Total system throughput is fine, and as expected, the only difference is 
the modest overhead of paging heftily or lightly and/or not at all.  The 
realtime throughput difference between kernels is ~10 seconds... very 
definitely concurrency issue imvho.  And I agree 100% that this is not 
_necessarily_ a bad thing.  The time it takes for _any_ pressure to build 
looks decidedly bad though.  With the combo patch it does look better than 
earlier patches... sudden bursts of paging do not occurr, it's..... 
smoother once it starts acting something resembling normal.

>What filesystem are you using?

The build is running in a small EXt2 partition.

         -Mike 

