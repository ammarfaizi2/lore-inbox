Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTILS2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbTILS1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:27:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:61103 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261799AbTILSW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:22:59 -0400
Date: Fri, 12 Sep 2003 11:11:48 -0700
From: Tim Hockin <thockin@hockin.org>
To: Andi Kleen <ak@suse.de>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912111148.A15308@hockin.org>
References: <20030911192550.7dfaf08c.ak@suse.de.suse.lists.linux.kernel> <1063308053.4430.37.camel@huykhoi.suse.lists.linux.kernel> <20030912162713.GA4852@sgi.com.suse.lists.linux.kernel> <20030912174807.GA629@sgi.com.suse.lists.linux.kernel> <p73y8wtlwf0.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73y8wtlwf0.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Sep 12, 2003 at 08:00:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 08:00:03PM +0200, Andi Kleen wrote:
> jbarnes@sgi.com (Jesse Barnes) writes:
> 
> > Ok, Andi asked for benchmarks, so I ran some.  Let this should be a
> > lesson on why you shouldn't use port I/O :)  I ran these on an SGI Altix
> > w/900 MHz McKinley processors.
> > 
> > Just straight calls to the routines (all of these are based on the
> > average of 100 iterations):
> >   writeq(val, reg) time: 64 cycles
> >   outl(val, reg) time: 2126 cycles
>                          ^^^^^
> > 
> > A simple branch:
> >   if (use_mmio)
> > 	writeq(val, reg) time: 132 cycles
> >   else
> > 	outl(val, reg) time: 1990 cycles
>                              ^^^^^
> Something seems to be wrong in your numbers.
> 
> Surely the outl in the if () cannot be faster than the pure outl() ?

Also - a perhaps more useful test is a write followed by a read.

-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

