Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVHQAOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVHQAOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVHQAOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:14:37 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48261 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750765AbVHQAOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:14:36 -0400
Date: Tue, 16 Aug 2005 17:14:10 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124236081.8630.110.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0508161710580.9829@schroedinger.engr.sgi.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com>
 <1124236081.8630.110.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, john stultz wrote:

> This is basically what I do in my patch. I directly apply the NTP
> adjustment to the timesource interval, and periodically increment the
> NTP state machine by the timesource interval when we accumulate it.

Is there some way to tell the NTP code how much the time_interpolator time 
deviates from xtime?

If the NTP code would use getnstimeofday or 
do_gettimeofday then it would already get interpolated time.

The curious issue in the current arrangement is that the interpolator 
knows much more accurately how much time has passed between interrupts 
than the timer interrupt but it has no time to make that information 
available to the NTP code.


