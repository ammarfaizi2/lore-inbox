Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSIMFd5>; Fri, 13 Sep 2002 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319525AbSIMFd4>; Fri, 13 Sep 2002 01:33:56 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:65252 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S316182AbSIMFd4>; Fri, 13 Sep 2002 01:33:56 -0400
Message-ID: <005a01c25ae9$0a0bcae0$750806c0@rambha>
From: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
To: "Andries Brouwer" <aebr@win.tue.nl>, "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com> <20020911171934.GA12449@win.tue.nl> <3D7FF3E7.61772A26@digeo.com> <20020912202314.GA12775@win.tue.nl>
Subject: Re: [PATCH] pid_max hang again...
Date: Fri, 13 Sep 2002 11:17:25 +0530
Organization: Wipro Technologies
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Again. We have 2^30 = 10^9 pids. In reality there are fewer than 10^4
> > > processes. So once in 10^5 pid allocations do we make a scan over
> > > these 10^4 processes,
> > 
> > Inside tasklist_lock?  That's pretty bad from a latency point of
> > view.  A significant number of users would take the slower common
> > case to avoid this.
> 
> That would be unwise of all these users.
> As soon as people have so many processes that this becomes a problem,
> then instead of making things slower they should make things faster
> still, at the cost of a little bit of extra code.

This was my initial impression. When Manfred clarified me that, a pid
can be in use (as session for example) even if the process corresponding
to that pid has died. The proposed approaches don't make things slower.
It is not just targeted towards get_pid() avoiding re-scan. One of the main
goals was to reduce contention for tasklist_lock.

> Similarly, people that need real-time guarantees will probably add
> that extra code.
> Now that things are ten thousand times better than they were very
> recently I find it a bit surprising that people worry. But yes, when
> needed it is very easy to come with further improvements.
> Once people stand up and say that they need Linux machines with 10^6
> processes, or with 10^4 processes and real time guarantees, then we
> must have a discussion about data structures, and a discussion about
> standards.

This doesn't sound good for me (I am sure for most of others too). 

> 
> The standards part is this: what values are allowed for p->pgrp,
> p->tgid, p->session? Can these be arbitrary numbers? 

They can't be arbitrary numbers. POSIX has defined what p->pgrp
and p->session should be.

> But these future discussions must not be about get_pid() but about
> task list handling, scheduling, sending signals, all places that
> today have for_each_task(p) ...

Whatever approaches proposed don't stop at making get_pid() better.
They improve/change stuff a lot ofcourse !!

~Hanu



