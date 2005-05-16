Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVEPUbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVEPUbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEPUbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:31:14 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:15322 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261719AbVEPUbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:31:02 -0400
Date: Mon, 16 May 2005 13:27:36 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: David Mosberger <davidm@hpl.hp.com>, lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: IA64 implementation of timesource for new time of day subsystem
In-Reply-To: <1116273055.13867.5.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0505161325330.2509@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> 
 <1116029872.26454.4.camel@cog.beaverton.ibm.com>  <1116029971.26454.7.camel@cog.beaverton.ibm.com>
  <1116030058.26454.10.camel@cog.beaverton.ibm.com> 
 <1116030139.26454.13.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com> 
 <1116264858.26990.39.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com> 
 <1116269136.26990.67.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com> 
 <17032.62615.750699.18847@napali.hpl.hp.com> <1116273055.13867.5.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, john stultz wrote:

> 
> No. I intend to preserve the existing functionality (and performance) of
> the current code. The current timeofday core should allow for this (as I
> described in my last mail), so really its just a matter of either me or
> someone else getting around to properly converting that arch with the
> help of the arch maintainer. Until the arch is really ready to use the
> new timeofday core, no changes are necessary.

Its not an arch specific issue. The time sources need to have a field that 
specifies that jitter protection is needed and there needs to be some 
logic to implement it. Otherwise we have to develop special functions for 
each timesource that deal with jitter protection. Function will make a 
fastcall for the clocks that use jitter protection not possible and thus 
timer access will slow down.

> What I'm trying to shake out, with Christoph's help, is any major
> limitations in the core timeofday code that would keep an arch from
> being able to use it.  I feel Christoph's concerns have been addressed,
> but please let me know if you disagree.

Please add jitter protection to the arch independent code.

