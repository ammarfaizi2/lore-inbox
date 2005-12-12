Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVLLAJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVLLAJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVLLAJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:09:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbVLLAJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:09:56 -0500
Date: Sun, 11 Dec 2005 16:09:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>, Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
In-Reply-To: <20051210162759.GA15986@aitel.hist.no>
Message-ID: <Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
 <20051210162759.GA15986@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge,
 did this start at any particular point in time?

Also, the most common case is that somebody has reniced the X server, 
which is just _wrong_.  It used to be done by some distributions to try to 
help the scheduler make the right choices, but we've fixed the scheduler 
and it doesn't need it or want it.

So if you actually run with a reniced X server these days, it just means 
that the X server will have much higher priority and the starvation comes 
simply from the fact that you have a process that has been marked as much 
more important than any other process. Which in turn _does_ mean that 
other processes will starve.

		Linus

On Sat, 10 Dec 2005, Helge Hafting wrote:
>
> 2.6.15-rc5 (and earlier 2.6 kernels) seems to have a slight scheduling 
> problem, with some starvation at a load of only 2.
> 
> All it takes is two users with separate X desktops.
> User one plays flash games using firefox. The ill-designed flash stuff
> typically means that his Xorg and firefox divides the cpu 100% between them.
> 
> So I expect that I, as user two, should notice some slowness. I should get only
> 1/2 - 1/3 cpu.  But I get periods of starvation.  Logging in takes a long time,
> bringing iup icewm takes 15s instead of 2, each xterm takes a long time to
> start.  They are usually instantaneous.  Tha machine is unsuitable
> for work in this mode.
> 
> Knowing the root password I renices his Xorg and firefox by 10, and then
> everything is fine.  His games are still ok, and my xterms are snappy again.
> 
> I have tried no preempt, voluntary preempt, and preemptible kernel.  It doesn't
> make a difference.  This is an amd64 kernel on an opteron 244 (1800MHz).  Everyhting
> is 64-bit except firefox+flash which is 32-bit.
> 
> Perhaps the way flash games work, with lots of communication with the xserver,
> makes them get "io boost" even though they are cpu hogs. I still think
> my xterm (or whatever I am starting up) should get its fair third of the cpu
> though, (with firefox and xorg hogging one third each too.)  Even a "600MHz opteron"
> ought to do better than this.
> 
> The machine isn't trashing, it is hardly touching swap.  (512M memory, and swpd=16 
> according to vmstat) The paging-in of a starting executable shouldn't be affected much
> by the cpu load?
> 
> Helge Hafting
> 
