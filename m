Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGAJpu>; Mon, 1 Jul 2002 05:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSGAJpt>; Mon, 1 Jul 2002 05:45:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25511 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314546AbSGAJpt>;
	Mon, 1 Jul 2002 05:45:49 -0400
Date: Mon, 1 Jul 2002 11:45:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] sched-2.5.24-D3, batch/idle priority scheduling, SCHED_BATCH
Message-ID: <Pine.LNX.4.44.0207011137330.4167-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0207011137332.4167@e2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the sched-2.5.24-D3 patch is my current scheduler tree against 2.5.24,
which also includes the latest version of SCHED_BATCH support:

	http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.24-D3

the setbatch utility can be found at:

	http://redhat.com/~mingo/O(1)-scheduler/setbatch.c

Changes relative to the previous SCHED_BATCH patch:

 - fix signal delivery - call the 'kick batch processes' code on UP as
   well.

 - simplify and speed up the batch queue handling code: the expired/active
   queues are merged into a single queue. If a SCHED_BATCH process uses up
   all its timeslices then it is queued to the tail of the batch-queue -
   otherwise it's queued to the head of the batch-queue. This simplifies
   the load-balancer as well.

 - add 'default context-switch locking' if prepare_arch_schedule() is not 
   defined. The majority of architectures thus do not have to define the
   context-switch locking macros.

bug reports, success reports, comments, suggestions are welcome,

	Ingo

