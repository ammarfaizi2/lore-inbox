Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbQKNBbH>; Mon, 13 Nov 2000 20:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbQKNBa5>; Mon, 13 Nov 2000 20:30:57 -0500
Received: from ha2.rdc2.tx.home.com ([24.14.77.21]:17359 "EHLO
	mail.rdc2.tx.home.com") by vger.kernel.org with ESMTP
	id <S129434AbQKNBav>; Mon, 13 Nov 2000 20:30:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Better precision in rusage and virtual itimers?
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 13 Nov 2000 18:01:03 -0600
Message-ID: <m2lmunwhfk.fsf@c469597-a.grlnd1.tx.home.com>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked through the scheduling code and searched pretty much
everywhere I could think of and I've found nothing on this, so it's
time to escalate :-).

The measurement of CPU usage and virtual itimers is crude at best.
It's actually possible to set a relatively short virtual itimer (say,
50ms) and have it use almost no CPU before going off.  I have actually
had this happen.  For larger values and for gross rusage measurements,
this current scheme is probably ok, but for more fine-grained stuff it
is not ok.

Most, if not all, modern CPUs have a high-precision clock that could
easily track CPU usage down to the microsecond level.

My questions are: has anyone done any work on this?  If not, and, if I
was willing to do the work, would it be likely to be accepted?

What I would like to do is the following:

 * Add a way to get to a high-precision clock that architectures can
   provide.

 * Modify fields in task_struct to optionally support higher precision.

 * Add some optional code before and after switch_to() to update the
   timer values and rusage values.

 * Add a way for architectures to report when they enter and leave
   system code (for tracking system verses user usage).

All of this, of course, would be optional and the old way would still
be available.

Corey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
