Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTILS2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTILS1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:27:12 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:35943 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261809AbTILSZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:25:20 -0400
Date: Fri, 12 Sep 2003 11:24:30 -0700
To: Tim Hockin <thockin@hockin.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912182430.GA1043@sgi.com>
Mail-Followup-To: Tim Hockin <thockin@hockin.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20030911192550.7dfaf08c.ak@suse.de.suse.lists.linux.kernel> <1063308053.4430.37.camel@huykhoi.suse.lists.linux.kernel> <20030912162713.GA4852@sgi.com.suse.lists.linux.kernel> <20030912174807.GA629@sgi.com.suse.lists.linux.kernel> <p73y8wtlwf0.fsf@oldwotan.suse.de> <20030912111148.A15308@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912111148.A15308@hockin.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 11:11:48AM -0700, Tim Hockin wrote:
> On Fri, Sep 12, 2003 at 08:00:03PM +0200, Andi Kleen wrote:
> > jbarnes@sgi.com (Jesse Barnes) writes:
> > 
> > > Ok, Andi asked for benchmarks, so I ran some.  Let this should be a
> > > lesson on why you shouldn't use port I/O :)  I ran these on an SGI Altix
> > > w/900 MHz McKinley processors.
> > > 
> > > Just straight calls to the routines (all of these are based on the
> > > average of 100 iterations):
> > >   writeq(val, reg) time: 64 cycles
> > >   outl(val, reg) time: 2126 cycles
> >                          ^^^^^
> > > 
> > > A simple branch:
> > >   if (use_mmio)
> > > 	writeq(val, reg) time: 132 cycles
> > >   else
> > > 	outl(val, reg) time: 1990 cycles
> >                              ^^^^^
> > Something seems to be wrong in your numbers.
> > 
> > Surely the outl in the if () cannot be faster than the pure outl() ?
> 
> Also - a perhaps more useful test is a write followed by a read.

Well, someone else will have to run that test.  On Altix, a read() is
freakishly expensive, and I'm not really interested in showing everyone
how bad it is ;)

Jesse
