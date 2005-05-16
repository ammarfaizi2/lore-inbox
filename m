Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVEPVk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVEPVk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVEPViq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:38:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44462 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261904AbVEPVfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:35:51 -0400
Subject: Re: IA64 implementation of timesource for new time of day subsystem
From: john stultz <johnstul@us.ibm.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
In-Reply-To: <17033.2445.545597.210557@napali.hpl.hp.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
	 <1116264858.26990.39.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
	 <1116269136.26990.67.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
	 <17032.62615.750699.18847@napali.hpl.hp.com>
	 <1116273055.13867.5.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161325330.2509@schroedinger.engr.sgi.com>
	 <1116276824.13867.15.camel@cog.beaverton.ibm.com>
	 <17033.2445.545597.210557@napali.hpl.hp.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 14:35:38 -0700
Message-Id: <1116279338.13867.30.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 13:58 -0700, David Mosberger wrote:
> >>>>> On Mon, 16 May 2005 13:53:44 -0700, john stultz <johnstul@us.ibm.com> said:
>   John> You've only pointed out two timesources that could want this
>   John> (ITC and TSC), so I think its reasonable to do your jitter
>   John> handling in the timesource driver. If there are other arches
>   John> that have non hardware synced per-cpu counters, then it would
>   John> be something to consider.
> 
> I think Christopher's point is that _all_ time-sources which require
> software syncing will need this since it is not possible to sync
> perfectly, even if there is no drift.

Yes, but to my knowledge it is only the ITC that does software syncing. 
The TSC could use it as well, but doesn't. Other then that I haven't
heard of any other timesource that would use such functionality.

Since its possible to do jitter compensation within the itc timesource
driver (and within the fastcall code to preserve the existing
performance), would it be reasonable to deffer making the jitter
compensation code generic until another timesource needs it? It should
be a fairly simple change.

Or is this just something I'm being hard-headed about?

thanks
-john






