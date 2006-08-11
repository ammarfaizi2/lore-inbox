Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWHKVCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWHKVCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWHKVCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:02:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750951AbWHKVCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:02:36 -0400
Date: Fri, 11 Aug 2006 17:01:04 -0400
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
Message-ID: <20060811210104.GL26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DCEAF7.5020005@rtr.ca>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 04:39:19PM -0400, Mark Lord wrote:
 > Ahhh...
 > 
 > >From the trace, I see a bunch of "userspace" lines appearing.
 > And sure enough, something called "powernowd" is running,
 > and probably conflicting with the "ondemand" governor.

It'll override it, you can't run both at the same time.
Well, unless you have a dual-core/multi-cpu system, where you
could have a different governor per-core. But that would be loony,
and we should probably disallow that possibility before someone
gets any bright ideas.

Looking at your log however, you only have a single CPU, so it'll
be using userspace exclusively.

 > I'm nuking powernowd, and that'll probably cure it for this box.
 > I guess the distro (kubuntu) must have started "powernowd"
 > even though I told it (the distro) to use "ondemand".
 > 
 > Does it make sense that this could change the upper limit, though?

A userspace governor can pretty much invent its own rules. I'm not
familiar with what constraints powernowd has.  It may even have
limits defined in a config file someplace.

Is it behaving again with ondemand ?

		Dave

-- 
http://www.codemonkey.org.uk
