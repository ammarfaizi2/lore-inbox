Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbUKXReV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUKXReV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbUKXRYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:24:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:45712 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262780AbUKXRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:10:08 -0500
Subject: kernel builds starving evolution process - scheduler issue? (was
	Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9)
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <1101303204.32068.26.camel@localhost.localdomain>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu>
	 <1101257903.13780.15.camel@krustophenia.net>
	 <20041124034520.GA12785@elte.hu>
	 <1101303204.32068.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 Nov 2004 10:23:25 -0500
Message-Id: <1101309805.1761.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 08:33 -0500, Steven Rostedt wrote:
> On Wed, 2004-11-24 at 04:45 +0100, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > 
> > > The symptom is that CPU bound tasks like kernel compiles will starve
> > > I/O bound tasks like evolution for a _long_ time.  If I have a kernel
> > > build and external modules building at the same time and Evolution
> > > goes to "Update message list...", it can sit and spin with a blank
> > > message pane for a minute or two.  If I suspend the builds, the
> > > message list renders immediately.
> > 
> > could you try the vanilla -rc2-mm2 kernel (with PREEMPT enabled), does
> > it behave in such a way too? At first sight this could be a property of
> > the upstream scheduler, but maybe it's special to PREEMPT_RT.
> > 
> 
> Have you notice this behavior with other interactive (I/O) tasks, such
> as bash.  Evolution is quite a big utility, and might be doing something
> in the background. If you see the same behavior with bash then there is
> no doubt that the compile is slowing down an I/O intensive task.
> 

No.  Only evolution (2.0) exhibits the problem.  But, it looks like
evolution uses a comparable amount of CPU to a kernel build just
updating the message list.  All stracing it shows me is that it spends a
hell of a lot of time polling().  I think this might be a bloat issue.

> Another variable can be memory. Are you running this on something with
> adequate memory, or is you harddrive churning like mad and you're
> constantly thrashing the swap space?
>  

No, I have plenty of RAM (512M).  I am using a 600Mhz C3 so the system
is probably CPU bound.  But, it seems like evolution should make a
little more progress.  I often find myself having to background all
build processes for a few seconds to let the message list render.  Once
the list renders, and I resume the builds, evolution is more or less
usable.  Running gtk-gnutella in the background will also make evolution
horribly slow.

Running the offending, CPU bound processes at a high nice value solves
the problem.  But now I am wasting half my fscking cycles "Updating
message list...".   Grr.

Lee

