Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWGHVrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWGHVrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGHVrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:47:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:11672 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750755AbWGHVrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:47:23 -0400
Subject: Re: Hang and Soft Lockup problems with generic time code
From: john stultz <johnstul@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1152333404.3866.80.camel@mulgrave.il.steeleye.com>
References: <1152313879.3866.53.camel@mulgrave.il.steeleye.com>
	 <1152315579.7493.9.camel@localhost.localdomain>
	 <1152333404.3866.80.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 14:47:02 -0700
Message-Id: <1152395222.8636.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 23:36 -0500, James Bottomley wrote:
> > Did you really mean jumps of 200 seconds? Hmmm. The issue Roman and I
> > have been looking into does occur when we lose a number of ticks and
> > that confuses the clocksource adjustment code. The fix we're working
> > on
> > corrects the adjustment confusion, but doesn't fix the lost ticks.
> > 
> > However 200 seconds of lost ticks sounds very off. Could the driver be
> > disabling interrupt for such a long period of time?
> 
> Well, what I was seeing was that 
> 
> clocksource_read(clock) - clock->cycle_last
> 
> is returning a value about 200 x clock->cycle_interval

That then would be ~200 ticks. Is this at HZ=1000 ? 

> According to the debugging printks I put into update_wall_time().  I was
> assuming this was caused by a jump in the TSC count, but I suppose it
> could also be cause by spurious alterations to cycle_last or other
> effects I haven't traced.

Since this issue effected both the TSC and ACPI PM timer, I'd more
likely suspect something is holding off the timer interrupt. This could
be some kernel code like a driver, or it could be something like an SMI
from the BIOS.

thanks
-john

