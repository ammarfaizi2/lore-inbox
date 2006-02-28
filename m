Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWB1VTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWB1VTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWB1VTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:19:31 -0500
Received: from hoster904.com ([66.211.137.19]:46305 "EHLO hoster904.com")
	by vger.kernel.org with ESMTP id S932491AbWB1VTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:19:31 -0500
From: Abdulla Bubshait <darkray@ic3man.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Wed, 1 Mar 2006 00:17:04 +0300
User-Agent: KMail/1.9.1
References: <200602280022.40769.darkray@ic3man.com> <20060227222152.GA26541@ti64.telemetry-investments.com> <Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603010017.04242.darkray@ic3man.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 01:47, you wrote:
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

TSC timer is useless and the kernel can't seem to find the hpet, unfortunately 
nosmp doesn't even boot so that workaround is blocked too.

Trying to go through this problem some more, I would have to agree that it 
could be the sata_nv interrupts that are throwing off the time, but what I 
don't seem to understand is how the pmtimer would persist at this new 
interrupt rate of 700/s even after sata_nv interrupts drop off.
