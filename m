Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131383AbQLXXPz>; Sun, 24 Dec 2000 18:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbQLXXPp>; Sun, 24 Dec 2000 18:15:45 -0500
Received: from mout1.freenet.de ([194.97.50.132]:32709 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S131383AbQLXXPg>;
	Sun, 24 Dec 2000 18:15:36 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Sun, 24 Dec 2000 23:49:00 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.Linu.4.10.10012231826350.645-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10012231826350.645-100000@mikeg.weiden.de>
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Cc: Mike Galbraith <mikeg@wen-online.de>
MIME-Version: 1.0
Message-Id: <00122423490000.00575@dg1kfa.ampr.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike, hello linux-kernel hackers,

Mike Galbraith wrote:

> Yes, hmm indeed.  Try these two things.
> 
> 1. make DECLARE_MUTEX_LOCKED(sem) in bdflush_init() static.
> 2. compile with frame pointers.  (normal case for IKD)
> 
> My IKD tree works with either option, but not with neither.  I haven't
> figured out why yet.

1 worked for me, too - with the same effect as compiling buffer.c with 
2.95.2, thus meaning successful boot and heavy crashing later on. 
I haven't tried to boot 2 yet, but this looks seriously fishy to me. It would 
be nice if we could make a simpler testcase to reproduce it, as it's much 
work to boot the kernel over and over again.

I have now printed out the buffer.c:bdflush_init assembly for all four cases, 
2.95.2, 2.97 without patch, 2.97 with static DECLARE... and 2.97 with frame 
pointer, and will try to figure out what's going wrong - it would still be 
nice to know if its a gcc problem or if some kernel assumption about GCC 
behaviour triggered this bug, which seems equally likely, as kernel_thread 
and the mutex/semaphore stuff involve some nontrivial (at least for beginners 
like me...) hand-made assembly code.

A nice evening and still merry christmas to the people westward of Europe :-)

Andreas

-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
