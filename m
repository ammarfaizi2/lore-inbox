Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278688AbRJVToJ>; Mon, 22 Oct 2001 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278844AbRJVToD>; Mon, 22 Oct 2001 15:44:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47622 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S278688AbRJVTne>; Mon, 22 Oct 2001 15:43:34 -0400
Date: Mon, 22 Oct 2001 15:44:09 -0400
Message-Id: <200110221944.f9MJi9916137@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A nicer nice scheduling
X-Newsgroups: linux.dev.kernel
In-Reply-To: <yam8695.480.153891320@mail.inwind.it>
Organization: TMR Associates, Schenectady NY
Cc: robertoragusa@technologist.com
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <yam8695.480.153891320@mail.inwind.it> robertoragusa@technologist.com wrote:

| So nice=19 vs. nice=0 has a 1:6 CPU ratio ( 14% - 86% ).
| 
| As we can't decrease 1 (n=19), we could increase 6 (n=0), with a more
| aggressive linear dependence. But this way the time-slice would also
| increase.
| 
| To balance this effect, we could also increase HZ (ref. TICK_SCALE).
| But this way an n=19 process would run frequently and for a very little
| time (with greater process switching overhead).
| 
| The right solution is IMHO to give an n=19 process less time and less
| often than an n=0 process.

| And we have a nice=19 vs. nice=0 ratio of 0.05:6 CPU
| ratio ( 0.8% - 99.2% ).
| 
| 
| So, this patch really solves the problem.
| And yes, it is a problem: who wants dnetc/setiathome to slow
| down (by 15%) apps like mozilla or gcc?
| 
| We don't want a "don't install dnetc on Linux 2.4.x, because it
| does not multitask well" rumour around; that is true for MacOS 9
| but should not for Linux. :-)
| 
| So, I think we should consider applying this patch (if noone
| has some better solution).
| 
| Please CC to me any replies.

  I will probably try this patch, assuming it applies nicely to newer
kernels. But such an aggressive nice does have a downside as given, it
can result in a process in memory which doesn't get scheduled. Or one
which gets run only long enough to get the next page fault, and which
takes resources while never getting anything done.

  So this is useful, but I hope people won't consider this as a complete
colution. I still think we need a real idle process to do the low
priority task feature in the most useful way. I think this would not
provide good results in a system with significant memory pressure.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
