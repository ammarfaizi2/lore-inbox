Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWCYSgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWCYSgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCYSgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:36:42 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:11484
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1750764AbWCYSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:36:41 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe (load_module) kernel oops)
Date: Sat, 25 Mar 2006 10:36:40 -0800
User-Agent: KMail/1.5.2
References: <200603212005.58274.jzb@aexorsyst.com> <200603240936.13178.jzb@aexorsyst.com> <20060324163237.5743bd3c.rdunlap@xenotime.net>
In-Reply-To: <20060324163237.5743bd3c.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251036.40379.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 16:32, Randy.Dunlap wrote:
> > Here it is:
> >
> > fails with cmdline:
> >
> > Kernel command line: ro root=/dev/sda1 rootdelay=10 mem=0x200M
> > console=ttyS0,115200n8
> >
> > works with:
> >
> > Kernel command line: ro root=/dev/sda1 rootdelay=10
> > console=ttyS0,115200n8
> >
> > Note the "mem=" being the differentiator!
>
> OK, that is memory map difference.
>
> Can you test a more recent kernel to see if it has the same problem?
> (like 2.6.16 or 2.6.16-git9)

No luck, or difference, for that matter.  2.6.16 behaves identically.  I'm
trying a few different options, such as disabling MSI/MSI-X support,
because what I've seen is that it all works fine with it as long as the h/w
has MSI support, but in all the case I've seen fail, the common denominator
is no MSI (and also all ICH4 platforms).  The cases where I can't make it fail
is where the h/w has MSI support.  One other noteworthy difference is that the
failures all occur on Intel graphics chipsets, while the successes are non-graphics.
Still trying to find out whether the failure follows graphics or the ICH4.

Anyway, what would help me is if someone could tell me if the page fault is a normal and
expected code path by design, in order to page in the area setup by __vmalloc_area()
as triggered by the module_alloc() call.  I'd really rather not have to trace through the
page fault handler to identify the difference between success/failure unless I have to.

