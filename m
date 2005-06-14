Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFNRAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFNRAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFNRAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:00:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23169 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261257AbVFNRAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:00:18 -0400
Date: Tue, 14 Jun 2005 10:00:11 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: Re: [PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050614170011.GF4180@us.ibm.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com> <20050614034655.GA4180@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614034655.GA4180@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2005 [20:46:55 -0700], Nishanth Aravamudan wrote:
> On 08.06.2005 [20:11:42 -0700], john stultz wrote:
> > Hey Everyone,
> > 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> > current tree for testing. If there's no major issues on Monday, I'll re-
> > diff against Andrew's tree and re-submit the patches for inclusion.
> 
> Here is an update of my soft-timer rework to John's latest patches. I
> have made some major changes in this revision. I would still greatly
> appreciate any comments.

<snip>

> Notes / Blocking Issues:

<snip>

> 	NUMA-Q is definitely broken with my patch, but not NUMA itself.
> 	Honestly not sure why, but timeofday seems to also be broken on
> 	NUMA-Q -- it sets up the TSC as the timesource, even though it
> 	shouldn't be (booting with notsc on NUMA-Qs seems to fix the
> 	problem for John's patches, at least).

Hrm, I just tried the same emulation on NUMA-Q that I did for ppc64:

inline do_monotonic_clock()
{
	return jiffies_to_nsecs(jiffies - INITIAL_JIFFIES);
}

and kernbench ran ok with just my patches on top of 2.6.12-rc6-git5. So,
I think -- not positive, admittedly, the problem may be with John's
patches on NUMA-Q, maybe even just some of the timesources.

Thanks,
Nish
