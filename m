Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVHPXsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVHPXsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVHPXsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:48:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26283 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750746AbVHPXsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:48:06 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 16:48:01 -0700
Message-Id: <1124236081.8630.110.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 11:25 -0700, Christoph Lameter wrote:
> You mentioned that the NTP code has some issues with time interpolation 
> at the KS. This is due to the NTP layer not being aware of actual time 
> differences between timer interrupts that the interpolator knows about.

My understanding of the issue was that when NTP makes an adjustment, it
only affects xtime, and any difference between the adjusted time and the
interpolator's time was just accumulated in the interpolator's offset.
That then, to my understanding, required the bit about adjusting the
interpolator frequency to be slower then what we expect so negative
offsets can be applied. 

Looking at it closer, it may very work, but it does seem to be
addressing the issue somewhat indirectly.

> If the NTP layer would be aware of the actual intervals measured by the 
> timesource (or interpolator) then presumably time could be adjusted in a 
> more accurate way.

This is basically what I do in my patch. I directly apply the NTP
adjustment to the timesource interval, and periodically increment the
NTP state machine by the timesource interval when we accumulate it.

thanks
-john




