Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262331AbSITMKN>; Fri, 20 Sep 2002 08:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262338AbSITMKM>; Fri, 20 Sep 2002 08:10:12 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:56797 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262331AbSITMKM>; Fri, 20 Sep 2002 08:10:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: fsync 50 times slower after 2.5.27
Date: Fri, 20 Sep 2002 14:15:12 +0200
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
References: <200209190222.33276.duncan.sands@math.u-psud.fr> <200209192032.25933.duncan.sands@math.u-psud.fr> <3D8A4016.F364B303@digeo.com>
In-Reply-To: <3D8A4016.F364B303@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209201415.12759.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 September 2002 23:22, Andrew Morton wrote:
> > OK!  This seems to fix the problem for 2.5.36.  I will also
> > test it for 2.5.34 since I didn't test 2.5.36 as rigourously
> > as 2.5.34 for the presence of the problem without the patch.
>
> (I dragged you back onto the mailing list)

No problem.

> Thanks for testing.  The semantics of sched_yield() have changed
> significantly in 2.5.  Probably correctly, but it is breaking a
> few things which were tuned for the old semantics.  Amongst those
> things are OpenOffice and, it seems, ext3 transaction batching.

Thanks for solving!  By the way, what does
                        set_current_state(TASK_RUNNING);
                        schedule();
actually do?  I guess it lets higher priority tasks have a go, while the
original yield() let equal priority tasks go first?  My knowledge of
sched_yield is out of date...

> The transaction batching does good things under some situations,
> and we want it to keep working.  I'll sit tight for the while, see
> where shed_yield() behaviour ends up.  If we still have a problem
> then probably a schedule_timeout(1) in there would suffice.
>
> > I will also test using ext2 (does ext2 use transaction.c?).
>
> No. ext2 will not exhibit this problem.

You are right.  I was confused because I thought I had observed
this problem once with ext2, but in fact I didn't test this case properly.
That's what you get for wanting to get some sleep at night...

Thanks again,

Duncan.
