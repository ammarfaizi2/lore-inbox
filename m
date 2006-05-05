Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWEEGzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEEGzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 02:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWEEGzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 02:55:24 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:27520 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932440AbWEEGzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 02:55:23 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 4 May 2006 23:54:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Fix CONFIG_PRINTK_TIME hangs on some systems
Message-ID: <20060505065457.GA17774@atomide.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0667FF31@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0667FF31@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luck, Tony <tony.luck@intel.com> [060504 09:14]:
> > This issue has been discussed earlier on LKML, but AFAIK
> > there has not been any better solution available:
> > 
> > http://lkml.org/lkml/2005/8/18/173
> 
> I thought that this had been fixed:
> 
> ia64 now has a "printk_clock()" defined in arch/ia64/kernel/time.c
> which overrides the "weak" symbol defined in kernel/printk.c.  This
> calls ia64_printk_clock() ... which defaults to a jiffie based
> routine, but might be an ITC based routine if running on a system
> where the clocks do not drift on different cpus.  Platform code
> can also override this function pointer (which SGI does in their
> sn_setup() routine).
> 
> The ITC based routine still uses sched_clock(), but tries to avoid
> the original problems by not calling sched_clock() until the MMU
> has been set up to map the per-cpu areas (checks whether one of the
> AR.K registers has been set).  Most of this in commit:
> 
>   http://tinyurl.com/ltexa

Thanks, I had missed that patch.

I still think the current printk_clock() approach is broken by
default on an unknown number of platforms.

Probably the best way to fix it would be to make it use jiffies
unless the platform registers a proper printk_clock() function.
 
> Do you still see a problem on some platform?

Yes, on various OMAP boards when 32KHz timer is being used. The 32KHz
timer is not enabled until in timer_init().

Regards,

Tony
