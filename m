Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUKXA7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUKXA7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKXA7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:59:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:44264 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261622AbUKXA6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:58:25 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20041123175823.GA8803@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 19:58:23 -0500
Message-Id: <1101257903.13780.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 18:58 +0100, Ingo Molnar wrote:
> i have released the -V0.7.30-9 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

I have notices some weird interactivity issues with this.  These are
also present in T3.

The symptom is that CPU bound tasks like kernel compiles will starve I/O
bound tasks like evolution for a _long_ time.  If I have a kernel build
and external modules building at the same time and Evolution goes to
"Update message list...", it can sit and spin with a blank message pane
for a minute or two.  If I suspend the builds, the message list renders
immediately.

It seems like the build process is constantly preempting the Evolution
process, preventing the latter from making much progress.  The build on
the other hand progresses fine.

AIUI I/O bound, interactive tasks like a mail client should get
scheduled in preference to CPU bound tasks like builds.  The scheduler
has heuristics to distinguish the two types of tasks and boosts the
dynamic priority of the former, right?  It seems like exactly the
opposite is happening.

Another possibility is that Evolution really DOES use so many cycles to
generate the message list that it looks like a CPU bound process to the
kernel.  Unfortunately I think this seems most likely.  For example,
evolution still consumes a hell of a lot of CPU at a low nice value.  It
just makes other tasks stall this way.

Do I need to just find a better mail client?

Lee

