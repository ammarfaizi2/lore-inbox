Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSG3VMB>; Tue, 30 Jul 2002 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSG3VMB>; Tue, 30 Jul 2002 17:12:01 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:36852 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S316576AbSG3VMA>; Tue, 30 Jul 2002 17:12:00 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F3B4@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Date: Tue, 30 Jul 2002 16:15:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Check out the title of the thread... Somebody has a real, reproducible 
> > deadlock on a rw_lock where many readers are starving out a writer, and 
> > the system hangs. 

> They have, as you say, "real reproducible" deadlocks because they are 
> not using straight spin-locks. Sombody tried to use cute queued locks. 
> This invention is the cause of the problem. The solution is to not 
> try to play tricks on "Mother Nature". 
> Cheers, 
> Dick Johnson 

Not quite.

The stock kernel hangs using regular reader/writer locks.  The problem
where a series of readers can continue passing a pending writer and
prevent the writer from _ever_ acquiring the lock affects at least i386
and ia64, and probably others, for both 2.4.x AND 2.5.x.

The problem would be fixed (but run very slow) by using normal spinlocks,
EXCEPT for the problem that reader locks are acquired recursivly, which
is the same reason my writer-preference patch could deadlock.

So we have the situation where the current code can deadlock, and the
only patch submitted can also lead to deadlock under a different situation.

It was suggested that a modified lock queue would be able to avoid
the eternal starvation problem, and it was also suggested that having
readers "spin" before acquiring the lock could reduce the problem.

Kevin

