Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbUL0QYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUL0QYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUL0QYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:24:32 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:47074 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261924AbUL0QYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:24:25 -0500
Date: Mon, 27 Dec 2004 17:23:11 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@kihontech.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
 -RT-2.6.10-rc2-mm3-V0.7.32-15)
In-Reply-To: <1104161272.20042.96.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004, Steven Rostedt wrote:

> On Mon, 2004-12-27 at 15:35 +0100, Esben Nielsen wrote:
> > I haven't seen much traffic on real-time preemption lately. Is it due
> > to Christmas or lost interest?
> > 
> 
> I think they are on vacation :-)
>
Oh, I thought I would have fun with some kernel programming in my
vacation! :-)
 
> > [...]
> 
> Why just limit to the number of CPUs, but make a configurable limit. I
> would say the default may be 2*CPUs.  Reason being is that once you
> limit the number of readers, you just bound the down_write. Even if
> number of readers allowed is 100, the down_write is now bound to
> O(ceil(n/#cpus)) as you said, but now n is known. Make a
> CONFIG_ALLOWED_READERS or something to that affect, and it would be easy
> to see what is a good optimal configuration (assuming you have the
> proper tests).
> 
I agree with you that it ought to be configureable. But if you set it to
something like 100 it is _not_ deterministic in practise. I.e. during your
tests you have a really hard time making 100 readers at the critical
point. Most likely you only have a handfull. Then when you deploy the
system where you might have a webserver presenting data read under a
rw-lock is overloaded spawns 100 worker tasks. Bang! Your RT application
doesn't run!
It doesn't help you to have something bounded if the bound is insanely
high such you never reach it in tests. And if you try to calculate the
worst case scenarious for such a system you would find it doesn't
schedule. I.e. you have to buy a bigger CPU or do some other drastic
thing!

A limit like 1 reader per CPU on the other hand behaves like a
normal mutex priority inheritance wrt. determinism. And it scales like the
stock Linux rw-lock which in practise is also limited to 1 task per CPU as
preemption is switched off :-)

> [...] 
> I have two SMP machines that I can test on, unfortunately, they both
> have NVIDIA cards, so I cant use them with X, unless I go back to the
> default driver. Which I would do, but I really like the 3d graphics ;-)
> 

Well, these kind of things isn't something you want to combine with 3d
graphics right away anyway!
I have even had problems with crashing on 2.4.xx with a NVidia and
hyperthreading on a machine I helped install :-( 
I am afraid NVidia cards and preempt realtime is far in the future :-(

> 
> -- Steve
> 

Esben

