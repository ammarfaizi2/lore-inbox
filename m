Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289993AbSAKPw2>; Fri, 11 Jan 2002 10:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289994AbSAKPwS>; Fri, 11 Jan 2002 10:52:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46297 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289993AbSAKPwF>;
	Fri, 11 Jan 2002 10:52:05 -0500
Date: Fri, 11 Jan 2002 18:49:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: [patch] O(1) scheduler, -H6
Message-ID: <Pine.LNX.4.33.0201111803580.4987-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -H6 patch is available:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H6.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-H6.patch

the most important fix is from DaveM, we should not send an IPI to
ourselves. That fix was the last bug on Sparc boxes it appears.

overall stability status: all the previous bug reports about runtime
lockups (which happen in -pre11 as well) are fixed in this patchset. The
only open issue is the boot-time lockup some people are seeing with the
2.4 patch only (not the 2.5 patch), there is a chance that it's fixed in
this patch too.

Changes:

 - DaveM's the man: check for p->cpu != smp_processor_id() before doing a
   smp_send_reschedule(p->cpu). Doh!

 - task_interactive() test is done properly now - the H5 would mis-detect
   every nice +19 task as interactive. I'd like to ask everyone who had
   interactivity problems to re-test under -H6. It's all very smooth on my
   systems.

 - Rusty Russell: add comment to expire_task.

 - fix main.c in the 2.4.17 patch. (this should fix the bootup-lockups.)

Bug reports, comments, suggestions welcome. (any patch/fix that is not in
-H6 has gone lost in my mailqueue. The influx is rather high.)

	Ingo

