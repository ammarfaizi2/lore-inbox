Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268282AbTCFSCI>; Thu, 6 Mar 2003 13:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTCFSCE>; Thu, 6 Mar 2003 13:02:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44981 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268282AbTCFSCA>;
	Thu, 6 Mar 2003 13:02:00 -0500
Date: Thu, 6 Mar 2003 19:11:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061000510.7720-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061905370.16118-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> > okay, here's a patch that merges Linus' "priority boost backmerging" and
> > my CPU-hog-detection-improvement patches.
> 
> I was actually going to suggest making the CPU-hog detector _worse_, to
> see what the extreme behaviour of the "boost balancing" is. One of the
> things I would hope for is that the interactivity balancing would act as
> a damper on the CPU hug detector, and make it less important to get that
> one right in the first place.

this does not appear to happen, at least with the current incarnation,
make -j5 jobs of the kernel tree (on UP), with your patch alone are
hoovering at a considerably higher dynamic priority than they are with my
patch. But interactivity itself is good as far as i can tell, in both
cases - but i think Andrew would be a better tester in this regard.

plus my patch doesnt really change the core CPU-hog detector, what it does
is that it changes the way children/parents will inherit priorities, plus
changes the order of how children get their first timeslice. The
end-effect is that the 'CPU-hog' make job is better recognized as that -
but X itself will not be recognized in any different way.

	Ingo

