Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268171AbTCFSFo>; Thu, 6 Mar 2003 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTCFSFo>; Thu, 6 Mar 2003 13:05:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:694 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268171AbTCFSFn>;
	Thu, 6 Mar 2003 13:05:43 -0500
Date: Thu, 6 Mar 2003 19:15:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061003110.7720-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061914250.16561-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> > It's still there. Red Hat 8.0, 2.5.63. The  thing can pause for 15+
> > seconds (and during this time madplay quite happily trundled on playing
> > an mp3). Workload was KDE, gcc, nothing exciting...
> 
> Oh, well. I didn't actually even verify that UNIX domain sockets will
> cause synchronous wakeups, so the patch may literally be doing nothing
> at all. You can try that theory out by just removing the test for
> "in_interrupt()".

you are not referring to the 'synchronous wakeups' as used by fs/pipe.c,
right? in_interrupt() isolates interrupt-context wakeups (asynchronous
wakeups) and process-context wakeups - which can also be called
synchronous, in a way.

so i think your current patch should cover unix domain sockets just as
well, they certain dont use IRQ-context wakeups.

	Ingo

