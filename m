Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVKBSNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVKBSNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVKBSNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:13:53 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:23762 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S965165AbVKBSNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:13:52 -0500
Subject: Re: 2.6.14-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 10:13:00 -0800
Message-Id: <1130955180.21315.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 21:55 -0500, Carlos Antunes wrote:
> On 11/1/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> > On Tue, 2005-11-01 at 12:18 -0800, Fernando Lopez-Lezcano wrote:
> > > On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote:
> > > > i have released the 2.6.14-rt1 tree, which can be downloaded from the
> > > > usual place:
> > > >
> > > >    http://redhat.com/~mingo/realtime-preempt/
> > > >
> > > > this release is mainly about ktimer fixes: it updates to the latest
> > > > ktimer tree from Thomas Gleixner (which includes John Stultz's latest
> > > > GTOD tree), it fixes TSC synchronization problems on HT systems, and
> > > > updates the ktimers debugging code.
> > > >
> > > > These together could fix most of the timer warnings and annoyances
> > > > reported for 2.6.14-rc5-rt kernels. In particular the new
> > > > TSC-synchronization code could fix SMP systems: the upstream TSC
> > > > synchronization method is fine for 1 usec resolution, but it was not
> > > > good enough for 1 nsec resolution and likely caused the SMP bugs
> > > > reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> > > >
> > > > Please re-report any bugs that remain.
> > >
> > > 2.6.14-rt2 seems to be running fine on my athlon x2 smp system. Apart
> > > from some time warp messages when starting up it looks fine so far (this
> > > is on fc4).
> >
> > Actually, after enough time logged in (or maybe just with the kernel
> > running without a reboot) I still get the usual Jack warnings:
> >
> > delay of 5469.000 usecs exceeds estimated spare time of 2641.000;
> > restart ...
> >
> 
> I'm also having some when using SCHED_FIFO and SCHED_RR. When running
> several hundred threads, each sleeping on a loop for 20ms, SCHED_OTHER
> performs ok with latencies of less than 10ms while with SCHED_FIFO or
> SCHED_RR, I see latencies exceeding 1 full second!

Wow...
I still have to find time to try to get more data, but I'm _not_ getting
xruns. Something in the kernel timekeeping or the way Jack uses it is
wrong. The messages appear to be bogus as far as I can tell, but they
should not be there in the first place. As before they depend on the
kernel being running for a while, they don't happen right after a
reboot.

-- Fernando


