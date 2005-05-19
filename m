Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVESXeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVESXeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVESXcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:32:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51947 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261350AbVESX3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:29:22 -0400
Date: Thu, 19 May 2005 16:29:16 -0700
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
       benh@kernel.crashing.org
Subject: Re: [RFC][PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050519232916.GC2673@us.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> <20050517233300.GE2735@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517233300.GE2735@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc4 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2005 [16:33:00 -0700], Nishanth Aravamudan wrote:
> On 13.05.2005 [17:16:35 -0700], john stultz wrote:
> > All,
> > 	This patch implements the architecture independent portion of the new
> > time of day subsystem. For a brief description on the rework, see here:
> > http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
> > easy to understand writeup!)
> > 
> > 	I intend this to be the last RFC release and to submit this patch to
> > Andrew for for testing near the end of this month. So please, if you
> > have any complaints, suggestions, or blocking issues, let me know.
> 
> I have been working closely with John to re-work the soft-timer subsytem
> to use the new timeofday() subsystem. The following patches attempts to
> begin this process. I would greatly appreciate any comments.

<snip>

> I will try to get some current benchmark differentials posted tomorrow.
> The previous patch I released showed little difference between mainline,
> John's timeofday rework and my soft-timer rework in kernbench.

<snip>

Hrm, "tomorrow" became "two days from now," but here they are, kernbench
comparisons (in percent relative to mainline) for x86 and x86_64, 10
iterations each.

The x86_64 machine is a 2-way 2.0 GHz with 3.5 GB of RAM.
The x86 machine is 16-way (32 with HT) 1.4 GHz Xeon with 15 GB of RAM.

				x86

					Elapsed	User	System	CPU

2.6.12-rc4:				100%	100%	100%	100%

2.6.12-rc4 + John's patch:		100.3%	100%	99.8%	99.6%

2.6.12-rc4 + John's patch + my patch:	102.1%	101%	100%	98%

				x86_64

					Elapsed	User	System	CPU

2.6.12-rc4:				100%	100%	100%	100%

2.6.12-rc4 + John's patch:		99.5%	99.5%	99.1%	99.9%

2.6.12-rc4 + John's patch + my patch:	99.7%	99.7%	99.5%	100%

----

All in all, pretty consistent across the board.

Thanks,
Nish
