Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288979AbSAFQNZ>; Sun, 6 Jan 2002 11:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSAFQNP>; Sun, 6 Jan 2002 11:13:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5783 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288979AbSAFQND>;
	Sun, 6 Jan 2002 11:13:03 -0500
Date: Sun, 6 Jan 2002 19:10:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] O(1) scheduler, 2.5.2-pre9-C1
Message-ID: <Pine.LNX.4.33.0201061901270.6124-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded an updated O(1) scheduler patch, against 2.5.2-pre9:

 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-C1.patch
 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-C1.patch

only minimal fixes were added to the code, the goal is to reach a stable
base.

Changelog:

 - fixed the mozilla crash, forgot to revert the ->prio value in
   setscheduler() which caused a wrong index ... (many thanks go to Pawel
   Kot for testing this out.)

 - fixed a load balancer bug that would get the runqueue count incorrectly
   if there is a RT running. With this fixed a 2-CPU system is completely
   usable even if a RT task is taking up 100% CPU time on one of the CPUs.

 - fix the sys_sched_yield export in ksyms.c (Davide Libenzi)

 - adds an RT event counter to optimize RT scheduling. (Davide, me)

	Ingo

