Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbUL0Qjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUL0Qjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUL0Qjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:39:37 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:39662 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261926AbUL0Qjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:39:33 -0500
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.32-15)
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
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
In-Reply-To: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 27 Dec 2004 11:39:20 -0500
Message-Id: <1104165560.20042.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 17:23 +0100, Esben Nielsen wrote:


> > > [...]
> > 
> > Why just limit to the number of CPUs, but make a configurable limit. I
> > would say the default may be 2*CPUs.  Reason being is that once you
> > limit the number of readers, you just bound the down_write. Even if
> > number of readers allowed is 100, the down_write is now bound to
> > O(ceil(n/#cpus)) as you said, but now n is known. Make a
> > CONFIG_ALLOWED_READERS or something to that affect, and it would be easy
> > to see what is a good optimal configuration (assuming you have the
> > proper tests).
> > 
> I agree with you that it ought to be configureable. But if you set it to
> something like 100 it is _not_ deterministic in practise. I.e. during your
> tests you have a really hard time making 100 readers at the critical
> point. Most likely you only have a handfull. Then when you deploy the
> system where you might have a webserver presenting data read under a
> rw-lock is overloaded spawns 100 worker tasks. Bang! Your RT application
> doesn't run!
> It doesn't help you to have something bounded if the bound is insanely
> high such you never reach it in tests. And if you try to calculate the
> worst case scenarious for such a system you would find it doesn't
> schedule. I.e. you have to buy a bigger CPU or do some other drastic
> thing!
> 

I wasn't saying that 100 was a GOOD number, but that was just an
example. I'm one of those that don't like the program, application,
kernel, to limit you on how you want to shoot yourself in the foot. But
always have the default set to something that prevents the idiot from
doing something too idiotic.  

> A limit like 1 reader per CPU on the other hand behaves like a
> normal mutex priority inheritance wrt. determinism. And it scales like the
> stock Linux rw-lock which in practise is also limited to 1 task per CPU as
> preemption is switched off :-)
> 

Do you think 2/cpu is too high? I'd figure that reads usually happen way
more than writes, and writes can usually last longer than reads, but
having the default to two, you can test your code, on a UP.

> > [...] 
> > I have two SMP machines that I can test on, unfortunately, they both
> > have NVIDIA cards, so I cant use them with X, unless I go back to the
> > default driver. Which I would do, but I really like the 3d graphics ;-)
> > 
> 
> Well, these kind of things isn't something you want to combine with 3d
> graphics right away anyway!
> I have even had problems with crashing on 2.4.xx with a NVidia and
> hyperthreading on a machine I helped install :-( 
> I am afraid NVidia cards and preempt realtime is far in the future :-(
> 

Actually, I've had some success with NVIDIA on all my kernels (except of
course the realtime ones). Unfortunately, there are the little crashes
here and there, but those usually happen with screen savers so I don't
lose data. I just come back to the machine and say WTF, I'm at a login
prompt! I am one of those that save everything within seconds of
modifying, and use subversion commits like crazy :-)

-- Steve

