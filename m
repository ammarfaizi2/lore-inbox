Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268222AbTCFR7Q>; Thu, 6 Mar 2003 12:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268224AbTCFR7P>; Thu, 6 Mar 2003 12:59:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24074 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268222AbTCFR7O>; Thu, 6 Mar 2003 12:59:14 -0500
Date: Thu, 6 Mar 2003 10:07:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Levon <levon@movementarian.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030306175533.GA29400@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0303061003110.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, John Levon wrote:
> On Thu, Mar 06, 2003 at 09:42:03AM -0800, Linus Torvalds wrote:
> 
> > But it was definitely there. 3-5 second _pauses_. Not slowdowns.
> 
> It's still there. Red Hat 8.0, 2.5.63. The  thing can pause for 15+
> seconds (and during this time madplay quite happily trundled on playing
> an mp3). Workload was KDE, gcc, nothing exciting...

Oh, well. I didn't actually even verify that UNIX domain sockets will
cause synchronous wakeups, so the patch may literally be doing nothing at
all. You can try that theory out by just removing the test for 
"in_interrupt()".

It will also almost certainly be totally ineffective if you use TCP 
sockets for the same reason. So if your DISPLAY variable is set to 
"localhost:0" instead of ":0.0", you'd definitely have to remove the 
"in_interrupt()" test.

But it may also just be that the theory is just broken.

		Linus

