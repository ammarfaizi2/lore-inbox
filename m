Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKIBeD>; Wed, 8 Nov 2000 20:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKIBdn>; Wed, 8 Nov 2000 20:33:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31882 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129033AbQKIBdc>;
	Wed, 8 Nov 2000 20:33:32 -0500
Date: Wed, 8 Nov 2000 17:18:26 -0800
Message-Id: <200011090118.RAA17609@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
CC: morton@nortelnetworks.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011082031.XAA20453@ms2.inr.ac.ru> (kuznet@ms2.inr.ac.ru)
Subject: Re: [patch] NE2000
In-Reply-To: <200011082031.XAA20453@ms2.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Wed, 8 Nov 2000 23:31:28 +0300 (MSK)

   [ Dave, please, look! I will strain brains this night too.
     Indeed, this sounds dubious. ]

It is true disaster to be on multiple wait queues at once.
There are no doubts.

   No, Andrew, this is surely not related to either of puzzles even if it
   is really buggy place. ping does not use either tcp or socket lock. 8)

(BTW, this BUG() case sounds like memory corruption, not logic bug in
 the code.  BUTTT there was hard error in test9, but fixed in test10,
 about wakeups.  It would set task running state back to TASK_RUNNING
 outside of runqueue lock, then add task to runqueue with lock held.
 I assume test10 was tried already though.)

Yes, these multiple wait-queue cases must be repaired.  BTW, look
at fs/pipe.c:pipe_wait(), whoever wrote this understood, even though
second wait queue hides behind semaphore :-)))

Consider next the case of being on some wait queue, and touching user
space, taking fault and sleeping on disk I/O or low memory.  This
issue could have very far reaching consequences.

I will think about this some more.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
