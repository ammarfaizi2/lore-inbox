Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbVIBVWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVIBVWR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbVIBVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:22:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8092 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161047AbVIBVWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:22:15 -0400
Subject: Re: [PATCH 2/3] dyntick - Fix lost tick calculation in timer pm.c
From: john stultz <johnstul@us.ibm.com>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>
In-Reply-To: <200509022218.04796.thomas.schlichter@web.de>
References: <20050831165843.GA4974@in.ibm.com>
	 <200509030145.18368.kernel@kolivas.org> <20050902172504.GB4650@in.ibm.com>
	 <200509022218.04796.thomas.schlichter@web.de>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 14:21:36 -0700
Message-Id: <1125696096.22448.23.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 22:18 +0200, Thomas Schlichter wrote:
> 2. Can we really assure that the monotonic clock is still monotonic?
> I think with your new code we estimate the monotonic clock value and the 
> offset_last at the last tick.
> But if we underestimate monotonic_base or overestimate offset_last (even 
> simply by rounding errors), the time will make a small step backwards with 
> the value-update.
> And as far as I understand the monotonic clock its not that bad if it drifts a 
> bit, but it is really bad if time makes steps backward...
> 
> But maybe you can show me that I am wrong with my second point.
> I hope I don't bother you too much with this kind of stuff...
> 
>   Thomas
> 
> P.S.: I CC'd John because he knows the monotonic clock better than I do... :-)


Thanks Thomas, that's a good catch. Since monotonic_clock has no real
notion of interrupt edges (it was designed to be constant regardless if
we miss ticks), I would keep accumulating the full inter-tick intervals
converted to usecs into the monotonic_base.

thanks
-john


