Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRK0M7o>; Tue, 27 Nov 2001 07:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRK0M7e>; Tue, 27 Nov 2001 07:59:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63974 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S277653AbRK0M7S>;
	Tue, 27 Nov 2001 07:59:18 -0500
Date: Tue, 27 Nov 2001 15:57:03 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] scalable timers implementation, 2.4.16, 2.5.0
Message-ID: <Pine.LNX.4.33.0111271543410.16419-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the 'ultra scalable timers' patch, against 2.4.16 or 2.5.0 is available
at:

  http://redhat.com/~mingo/scalable-timers-patches/smptimers-2.4.16-A0

these are the goals of the patch:

the current 2.4 timer implementation uses a global spinlock for
synchronizing access to the global timer lists. This causes excessive
cacheline ping-pongs and visible performance degradation under very high
TCP networking load (and other, timer-intensive operations).

The new implementation introduces per-CPU timer lists and per-CPU
spinlocks that protect them. All timer operations, add_timer(),
del_timer() and mod_timer() are still O(1) and cause no cacheline
contention at all (because all data structures are separated). All
existing semantics of Linux timers are preserved, so the patch is
'transparent' to all other subsystems.

(The patch does not attempt to change the timer interface in any way -
that might be done via different patches. These timers are compatible with
TIMER_BH & cli() methods of synchronization as well.)

	Ingo

