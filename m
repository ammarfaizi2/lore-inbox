Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWDETF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWDETF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDETF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 15:05:28 -0400
Received: from xenotime.net ([66.160.160.81]:1471 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751333AbWDETF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 15:05:28 -0400
Date: Wed, 5 Apr 2006 12:07:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jzb@aexorsyst.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe
 (load_module) kernel oops)
Message-Id: <20060405120742.ee9af120.rdunlap@xenotime.net>
In-Reply-To: <200603251036.40379.jzb@aexorsyst.com>
References: <200603212005.58274.jzb@aexorsyst.com>
	<200603240936.13178.jzb@aexorsyst.com>
	<20060324163237.5743bd3c.rdunlap@xenotime.net>
	<200603251036.40379.jzb@aexorsyst.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006 10:36:40 -0800 John Z. Bohach wrote:

> On Friday 24 March 2006 16:32, Randy.Dunlap wrote:
> > > Here it is:
> > >
> > > fails with cmdline:
> > >
> > > Kernel command line: ro root=/dev/sda1 rootdelay=10 mem=0x200M
> > > console=ttyS0,115200n8
> > >
> > > works with:
> > >
> > > Kernel command line: ro root=/dev/sda1 rootdelay=10
> > > console=ttyS0,115200n8
> > >
> > > Note the "mem=" being the differentiator!
> >
> > OK, that is memory map difference.
> >
> > Can you test a more recent kernel to see if it has the same problem?
> > (like 2.6.16 or 2.6.16-git9)
> 
> No luck, or difference, for that matter.  2.6.16 behaves identically.  I'm
> trying a few different options, such as disabling MSI/MSI-X support,
> because what I've seen is that it all works fine with it as long as the h/w
> has MSI support, but in all the case I've seen fail, the common denominator
> is no MSI (and also all ICH4 platforms).  The cases where I can't make it fail
> is where the h/w has MSI support.  One other noteworthy difference is that the
> failures all occur on Intel graphics chipsets, while the successes are non-graphics.
> Still trying to find out whether the failure follows graphics or the ICH4.
> 
> Anyway, what would help me is if someone could tell me if the page fault is a normal and
> expected code path by design, in order to page in the area setup by __vmalloc_area()
> as triggered by the module_alloc() call.  I'd really rather not have to trace through the
> page fault handler to identify the difference between success/failure unless I have to.

AFAIK the page fault is not expected, but I would be happier if someone else
confirmed that.

BTW, Documentation/kernel-parameters.txt suggests using mem= and memmap=
together, so maybe you could use memmap=.... to prevent this problem.

---
~Randy
