Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbTCGGFi>; Fri, 7 Mar 2003 01:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbTCGGFi>; Fri, 7 Mar 2003 01:05:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18053 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261379AbTCGGFh>;
	Fri, 7 Mar 2003 01:05:37 -0500
Date: Fri, 7 Mar 2003 07:15:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030306124257.4bf29c6c.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303070706410.3211-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Andrew Morton wrote:

> So I'm a happy camper, and will be using Ingo's combo patch.  But I do
> not use XMMS and xine and things like that - they may be running like
> crap with these patches. [...]

one thing the -A5 patch does is that it decreases the default timeslice
value from 150 msecs to 100 msecs. While increasing the timeslice seemed
like a good idea originally (and even with -A5 it's still higher than in
2.4), 150 msecs was too much, it did end up causing just that little bit
of extra latency to audio apps that made them skip more likely. So audio
apps might as well perform a bit better. Certain gaming related problems i
suspect are related to the too long timeslice length as well.

one of the problems with XMMS is that it's often not just an audio app -
it has plugins with fancy graphics, which take up much more CPU time than
the audio decoding/feeding itself, and it's not as threaded as eg. xine.  
It was _this_ interaction that was the root of many XMMS complaints - not
the fact that XMMS does audio.

the xine situation i dont think will change with these patches, xine
simply uses up 90% of CPU time soft-playing a DVD from the DVD player, on
a 500 MHz x86 CPU, and that makes it qualify as a CPU-hog no matter what.  
Furthermore, it uses the Xv extension which makes it communicate much less
with X itself. But xine's problems are not due to interactive tasks, xine
is hurting due to other CPU-hogs (stuff that triggers in desktops
regularly) taking away timeslices. I believe we should still enable
application programmers to give certain apps _some_ minor priority boost,
so that other CPU hogs cannot starve xine. The fact that xine was playing
back perfectly with a +2 boost shows that this could be a quite powerful
tool.

But indeed this all needs to be re-checked with the latest scheduler.

	Ingo

