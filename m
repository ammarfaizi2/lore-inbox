Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVEPWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVEPWDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEPV7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:59:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6879 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261896AbVEPV4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:56:37 -0400
Date: Mon, 16 May 2005 14:53:00 -0700 (PDT)
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
In-Reply-To: <1116279338.13867.30.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0505161445020.3010@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> 
 <1116029872.26454.4.camel@cog.beaverton.ibm.com>  <1116029971.26454.7.camel@cog.beaverton.ibm.com>
  <1116030058.26454.10.camel@cog.beaverton.ibm.com> 
 <1116030139.26454.13.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com> 
 <1116264858.26990.39.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com> 
 <1116269136.26990.67.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com> 
 <17032.62615.750699.18847@napali.hpl.hp.com>  <1116273055.13867.5.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.62.0505161325330.2509@schroedinger.engr.sgi.com> 
 <1116276824.13867.15.camel@cog.beaverton.ibm.com>  <17033.2445.545597.210557@napali.hpl.hp.com>
 <1116279338.13867.30.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, john stultz wrote:

> Since its possible to do jitter compensation within the itc timesource
> driver (and within the fastcall code to preserve the existing
> performance), would it be reasonable to deffer making the jitter
> compensation code generic until another timesource needs it? It should
> be a fairly simple change.

Well looks that we will start out with the new time subsystem by putting 
some hacks in. I need to check in the funky routine (for setting up the 
fastcall configuration) if the function pointer passed == jitter-compensated-itc
and depending on that set a special flag that makes the asm code do jitter
compensation.

> Or is this just something I'm being hard-headed about?

Looks like it. Its not that difficult. Add a jitter compensation flag to
timesource. Check on retrieving from a timesource if its less than last if 
flag is set. Pass the field to the funky function to setup the 
vsyscalls.

Maybe add a general flags field? There may be other things that need to be 
added in the future.

