Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSANAs3>; Sun, 13 Jan 2002 19:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288528AbSANAsY>; Sun, 13 Jan 2002 19:48:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29191 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288502AbSANArH>; Sun, 13 Jan 2002 19:47:07 -0500
Date: Sun, 13 Jan 2002 19:46:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108142117.F3221@inspiron.school.suse.de>
Message-ID: <Pine.LNX.3.96.1020113193700.17441G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Andrea Arcangeli wrote:

> I'm not against preemption (I can see the benefits about the mean
> latency for real time DSP) but the claims about preemption making the
> kernel faster doesn't make sense to me. more frequent scheduling,
> overhead of branches in the locks (you've to conditional_schedule after
> the last preemption lock is released and the cachelines for the per-cpu
> preemption locks) and the other preemption stuff can only make the
> kernel slower.  Furthmore for multimedia playback any sane kernel out
> there with lowlatency fixes applied will work as well as a preemption
> kernel that pays for all the preemption overhead.

I'm not sure I have seen claims that it makes the kernel faster, but it
sure makes the latency lower, and improves performance for systems doing a
lot of network activity (DNS servers) with anything else going on in the
systems, such as daily reports and backups.

I will try the low latency kernel stuff, but I think intrinsically that if
you want to service the incoming requests quickly you have to dispatch to
them quickly, not at the end of a time slice. Preempt is a way to avoid
having to play with RT processes, and I think it's desirable in general as
an option where the load will benefit from such behaviour.

I'm not sure it "competes" with low latency, since many of the thing LL is
doing are "good things" in general.

Finally, I doubt that any of this will address my biggest problem with
Linux, which is that as memory gets cheap a program doing significant disk
writing can get buffers VERY full (perhaps a while CD worth) before the
kernel decides to do the write, at which point the system becomes
non-responsive for seconds at a time while the disk light comes on and
stays on. That's another problem, and I did play with some patches this
weekend without making myself really happy :-( Another topic,
unfortunately.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

