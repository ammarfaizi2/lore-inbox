Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTETOJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTETOJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:09:00 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:158
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263787AbTETOI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:08:59 -0400
Date: Tue, 20 May 2003 10:21:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       mbligh@aracnet.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <20030520142158.GA27982@gtf.org>
References: <88560000.1053409990@[10.10.2.4]> <1053412583.13289.322.camel@nighthawk> <20030519.234055.35511478.davem@redhat.com> <200305200907.41443.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305200907.41443.habanero@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 09:07:41AM -0500, Andrew Theurer wrote:
> On Tuesday 20 May 2003 01:40, David S. Miller wrote:
> >    From: Dave Hansen <haveblue@us.ibm.com>
> >    Date: 19 May 2003 23:36:23 -0700
> >
> >    I don't even think we can do that.  That code was being integrated
> >    around the same time that our Specweb setup decided to go south on us
> >    and start physically frying itself.
> >
> > This gets more amusing by the second.  Let's kill this code
> > already.  People who like the current algorithms can push
> > them into the userspace solution.
> 
> Remember this all started with some idea of "fairness" among cpus and very 
> little to do with performance.   particularly on P4 with HT, where the first 
> logical cpu got all the ints and tasks running on that cpu were slower than 
> other cpus.  This was in most cases the highest performing situation, -but- 
> it was unfair to the tasks running on cpu0.  irq_balance fixed this with a 
> random target cpu that was in theory supposed to not change often enough to 
> preserve cache warmth.  In practice is the target cpus changed too often 
> which thrashed cache and the HW overhead of changing the destination that 
> often was way way to high.  

You call that a fix?  ;-)  I call that working around a bug.

If tasks run slower on cpuX than cpuY because of a heavier int load,
that's the fault of the scheduler not the irqbalancer, be it in-kernel
or userspace.  If there's a lesser-utilized cpu the task needs to be
migrated to that cpu from the irq-loaded one, when CPU accounting
notices the kernel interrupt handling having an impact.

	Jeff


