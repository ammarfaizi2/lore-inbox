Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVHXTQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVHXTQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVHXTQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:16:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23801 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751420AbVHXTQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:16:10 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508242043220.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>
	 <1124830262.20464.26.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508232321530.3728@scrub.home>
	 <1124838847.20617.11.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508240134050.3743@scrub.home>
	 <1124906422.20820.16.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508242043220.3728@scrub.home>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 12:15:52 -0700
Message-Id: <1124910953.20820.34.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 20:48 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 24 Aug 2005, john stultz wrote:
> 
> > Ok, so then to clarify the above (as you mention gettimeofday uses
> > system_time), would your gettimeofday look something like:
> > 
> > gettiemofday():
> > 	return (system_time + (cycle_offset * mult) + error)>> shift
> > 
> > ?
> 
> No.
> 
> 	reference_time = xtime;
> 	system_time = xtime + error >> shift;
> 	gettimeofday = system_time + (cycle_offset * mult) >> shift;

Eh? In your example code from before you look to be keeping the
system_time and error values in shifted nsec units.

from your example:
>		// at init: system_update = update_cycles * mult;
> 		system_time += system_update;

and:
> 	error = system_time - (xtime.tv_nsec << shift);

This doesn't seem to make sense with the above.  Could you clarify?

thanks
-john

