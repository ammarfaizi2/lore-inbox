Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbTCFXzr>; Thu, 6 Mar 2003 18:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbTCFXzr>; Thu, 6 Mar 2003 18:55:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261288AbTCFXzq>; Thu, 6 Mar 2003 18:55:46 -0500
Date: Thu, 6 Mar 2003 16:02:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: digitale@digitaleric.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       <rml@tech9.net>, <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <24000000.1046994021@flay>
Message-ID: <Pine.LNX.4.44.0303061554250.9387-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Martin J. Bligh wrote:
> 
> Yes, you should be able to frig with policy decisions from userspace, if
> you really want to BUT the kernel should do something pretty sane by 
> default without user intervention.

Amen, brother!

One thing that I've often disliked about "tuning parameters" is that many 
people take them to be valid excuses for bad behaviour under some load. 
For example, when some benchmark does badly, or something stutters, you'll 
always find somebody pointing out that it can be fixed by doing a

	echo 55 > /proc/sys/mm/dirty_ratio

or similar.  And the fact that you can tune the thing for certain loads 
somehow thus makes the bug ok..

IT AIN'T SO! Tuning constants are wonderfully useful for developers tuning 
their guesses a bit, and to give more information about what knobs make a 
difference.

In other words, it's ok for a developer to say: "Ok, what happens if you
do the above echo?" to figure out whether maybe the problem is due to
excessive spurgel-production in the VM frobnicator, but it is NOT OK to 
say "you can tweak it for your use, so don't complain about the bad
behaviour".

This is the same thing as "'nice -10' the X-server". Something is wrong, 
and we couldn't fix it, so here's the band-aid to avoid that problem for 
hat particular case. It's acceptable as a band-aid, but if you don't 
realize that it's indicative of a problem, then you're just kidding 
yourself.

Can we do perfectly all the time? No. Sometimes best performance _will_
require tuning for the load. But it should be seen as a failure of the
generic algorithm, not as a success.

Btw, "success" is often "being good enough". We shouldn't _suck_, but you 
should always remember the old "perfect is the enemy of good" thing. 
Trying to get perfect behaviour under some circumstances often means that 
you suck under others, and then the right answer is usually not to try to 
be so damn perfect, but "just being good".

		Linus

