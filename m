Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTKFUbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTKFUbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:31:41 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:46050 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263695AbTKFUbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:31:38 -0500
Date: Thu, 6 Nov 2003 14:31:14 -0600
From: Robin Holt <holt@sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>, Matthew Wilcox <willy@debian.org>
Subject: Re: [DMESG] cpumask_t in action
Message-ID: <20031106203114.GA22338@mandrake.americas.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F3751@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F3751@scsmsx401.sc.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 10:56:55AM -0800, Luck, Tony wrote:
> > That'd cut us down to:
> > 
> > > CPU 3: 61 virtual and 50 physical address bits
> > > CPU 3: nasid 2, slice 2, cnode 1
> > > CPU 3: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
> > > Calibrating delay loop... 2241.08 BogoMIPS
> > > CPU3: CPU has booted.
> > > Starting migration thread for cpu 3
> 
> Perhaps we could drop printing the number of virtual/physical address
> bits, and the frequency&ratio information (or maybe just print if they
> are different from the boot cpu ... which would most likely surprise
> the kernel in bad ways, and thus be worthy of printing).  That would
> cut another two lines for all bar one cpu.

Do we need the CPU has booted message?  If it fails to boot, we get
notified.  Can we leave it at that?

As far as I can tell, the nasid and slice is fairly useless.  It might
be helpful, but there should be more user accessible ways of determining
the topology than using boot messages.

The BogoMIPS is another which I would think could be eliminated unless
it is significantly different from the boot cpu.  Maybe say greater
than 10% different.

With these, the boot has been reduced to one migration thread message
when a cpu starts and I believe two lines when one fails to start.
