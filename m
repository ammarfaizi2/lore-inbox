Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWB1Hns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWB1Hns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 02:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWB1Hns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 02:43:48 -0500
Received: from hoster904.com ([66.211.137.19]:47833 "EHLO hoster904.com")
	by vger.kernel.org with ESMTP id S1751913AbWB1Hns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 02:43:48 -0500
From: Abdulla Bubshait <darkray@ic3man.com>
To: Jason Baron <jbaron@redhat.com>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Tue, 28 Feb 2006 10:41:27 +0300
User-Agent: KMail/1.9.1
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <20060227222152.GA26541@ti64.telemetry-investments.com> <Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281041.27960.darkray@ic3man.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 01:47, Jason Baron wrote:
> On Mon, 27 Feb 2006, Bill Rugolsky Jr. wrote:
> > On Tue, Feb 28, 2006 at 12:22:40AM +0300, bubshait wrote:
> > > 	Losing some ticks... checking if CPU frequency changed.
> > > 	warning: many lost ticks.
> > > 	Your time source seems to be instable or some driver is hogging
> > > interupts rip __do_softirq+0x47/0xd1
> > >
> > > adding report_lost_ticks only prints repeating messages like
> > >
> > > 	Lost 3 timer tick(s)! rip __do_softirq+0x47/0xd1
> >
> > I'm seeing tons of these on a Tyan 2895 (Nvidia CKO4) running FC4 with
> > kernel-2.6.15-1.1830 (2.6.15.2) SMP:
> >
> > time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
> > time.c: Lost 2 timer tick(s)! rip __do_softirq+0x55/0xd4)
> >
> > [I've seen the same thing with earlier FC 2.6.14 kernels.]
> >
> > On our systems the __do_softirq messages are strongly correlated with
> > sata_nv interrupts, especially during our nightly tripwire-like fs
> > checksum job.  Unfortunately, the log messages are not very informative.
> > I'm not sure what ever happened to the following patch,
> >
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5
> >.64-mm3/broken-out/report-lost-ticks.patch
> >
> > but it was dropped.
> >
> > Unfortunately, I need to spend tomorrow patching kernels in search of a
> > fix or workaround, as I have to start using these boxes in production,
> > and they need to keep time.
>
> passing 'nohpet' and/or 'nopmtimer' will force the use of a different
> timer...but this is certainly a workaround, if it helps...

Unfortunately, I can't seem to find a way to force it to use hpet. Passing 
'notsc' and 'nopmtimer' I end up using PIT/TSC based timekeeping. TSC is 
already known to have problems with dual core. But I will sit with it for a 
while to see if it fairs better than the pm timer.

Bill, What timer do you use, and do these lost ticks persist after sata_nv 
interrupts stop?
