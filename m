Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVEPTfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVEPTfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVEPTda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:33:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:33415 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261852AbVEPT0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:26:08 -0400
Date: Mon, 16 May 2005 12:24:08 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
Subject: Re: IA64 implementation of timesource for new time of day subsystem
In-Reply-To: <1116269136.26990.67.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> 
 <1116029872.26454.4.camel@cog.beaverton.ibm.com>  <1116029971.26454.7.camel@cog.beaverton.ibm.com>
  <1116030058.26454.10.camel@cog.beaverton.ibm.com> 
 <1116030139.26454.13.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com> 
 <1116264858.26990.39.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
 <1116269136.26990.67.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, john stultz wrote:

> In pseudo code, all you would need to do is something like:
> 
> arch_update_vsyscall_gtod(wall_time, offset_base, timesource, ntp_adj):
> 
> 	fastcall_data.wall = wall_time
> 	fastcall_data.base = offset_base
> 	fastcall_data.ts = timesource
> 	fastcall_data.ntpadj = ntp_adj


Ahh. Thanks.

> > Clock jitter can affect multiple clock sources that may fluctuate
> > in a minor way due to a variety of influences. Jitter compensation may 
> > help in these situations.
> 
> Forgive me as I'm just not aware of these, and am thus hesitant to
> change the core code for two known cases that can be cleanly dealt with
> in the timesource driver code.

I am happy to leave the situation as is since it does not affect SGI. 
We have a memory mapped timer that does not need this jitter compensation.

Other IA64 vendors will see that their timer performance drops 
significantly after the new timer subsystem is in. IBM no longer 
has IA64 systems that rely on ITC?
