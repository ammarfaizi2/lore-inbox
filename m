Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVHWHTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVHWHTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVHWHTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:19:07 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:52455 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750845AbVHWHTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:19:05 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 23 Aug 2005 00:18:43 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
Message-ID: <20050823071842.GB29951@atomide.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com> <20050821021322.3986dd4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821021322.3986dd4a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [050821 02:15]:
> "Luck, Tony" <tony.luck@intel.com> wrote:
> >
> > It has been pointed out to me that ia64 doesn't boot
> > with CONFIG_PRINTK_TIME=y.  The issue is the call to
> > sched_clock() ... which on ia64 accesses some per-cpu
> > data to adjust for possible variations in processor
> > speed between different cpus.  Since the per-cpu page
> > is not set up for the first few printk() calls, we die.
> > 
> > Is this an issue on any other architecture?  Most versions
> > of sched_clock() seem to just scale jiffies into nanoseconds,
> > so I guess they don't.  s390, sparc64, x86 and x86_64 all
> > have more sophisticated versions but they don't appear to me
> > to have limitations on how early they might be called.

CONFIG_PRINTK_TIME also has a problem on at least ARM OMAP where
the IO mapping to read the clock may not be initialized when
sched_clock() is called for the first time.

I'd hate to have to test for something for CONFIG_PRINTK_TIME
every time sched_clock() is being called.

The quick fix would seem to be to only allow CONFIG_PRINTK_TIME
from kernel cmdline to make it happen a bit later. So basically
make int printk_time = 0 until command line is evaluated.

Tony
