Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286121AbRLJAbo>; Sun, 9 Dec 2001 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286120AbRLJAbe>; Sun, 9 Dec 2001 19:31:34 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:43789 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286111AbRLJAbY>; Sun, 9 Dec 2001 19:31:24 -0500
Date: Sun, 9 Dec 2001 16:33:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC] Scheduler queue implementation ...
Message-ID: <Pine.LNX.4.40.0112091558190.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've spent some time reading interesting ( someone yes, someone not )
papers about different scheduler implementations, policies, queues, etc..
A concept that i've found common in all these works is that, and it's easy
to agree, CPU bound ( batch ) tasks do not need a strict execution order.
So we can have simply two queues ( per CPU ), one that stores I/O bound (
counter > K for example ) and RT tasks that is walked entirely searching
for the better tasks, the other queue will store CPU bound tasks that are
executed in a FIFO policy.
In this way we'll have a better behavior for I/O bound tasks due the
shortest run queue to loop while the FIFO policy on CPU bound tasks does
not affect the system as long as these tasks will have the same amount of
virtual time.
The problem of having long runqueue is automatically solved by the
assumption that long_runqueue == lot_of_cpubound_tasks, that will find
home inside the FIFO queue by assuring a low latency for I/O bound and RT
tasks.
What we lose is the mm ( + 1) goodness() but the eventual cost of
switching mm is melted inside the long execution time ( 50-60 ms ) typical
of CPU bound tasks ( note that matching MMs does not mean matching cache
image ).




- Davide



