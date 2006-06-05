Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751351AbWFEUU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWFEUU2 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWFEUU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:20:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36502 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751351AbWFEUU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:20:27 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606050141120.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 13:20:10 -0700
Message-Id: <1149538810.9226.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 01:50 +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 4 Jun 2006, Andrew Morton wrote:
> 
> > time-use-clocksource-infrastructure-for-update_wall_time.patch
> 
> I still disagree with the update_wall_time() changes, they should be kept 
> the new separate from this. 

Is this directly related to the next item (if so, how?), or just
preference? I'd really like to avoid having multiple code paths for the
timekeeping core, so I'd like to see this unified. I'm willing to
optimize out bits w/ constants and whatnot, but I worry it will be a
nightmare to maintain if we have multiple generic update_wall_time
implementations.

> The error algorithm is a somewhat old version 
> and can cause oscillation and thus a confused clock.

Would you mind elaborating on this? Which aspect of the error algorithm
is off? How does the clock become confused? Could you point to the line
numbers, etc?  I assume your last patchset contains the current version?

> > time-let-user-request-precision-from-current_tick_length.patch
> 
> This is broken, as it simply throws away resolution depending on the 
> clock.

So if the clock shift value is less then 12 (SHIFT_SCALE - 10), this is
true, and currently that's only the jiffies case.

Just to be clear, are you then suggesting that the accumulation in
update_wall_time should be done in a fixed shifted nanosecond unit
regardless of the clock shift value? Is SHIFT_SCALE-10, good enough in
your mind for this?

That seems not too difficult to do, and can be done w/ an incremental
patch. I'll try to crank that out today.

> These are two key problems, the rest can be fixed incrementally.

If these are really blockers, I want to get them resolved in the next
day or so (I'd really like to avoid having Andrew carry them for yet
another cycle). So I'd appreciate your help in correcting these issues.

thanks
-john

