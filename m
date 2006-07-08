Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWGHWNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWGHWNL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWGHWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:13:11 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:48305 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751239AbWGHWNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:13:09 -0400
Subject: Re: Hang and Soft Lockup problems with generic time code
From: James Bottomley <James.Bottomley@SteelEye.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1152395222.8636.7.camel@localhost>
References: <1152313879.3866.53.camel@mulgrave.il.steeleye.com>
	 <1152315579.7493.9.camel@localhost.localdomain>
	 <1152333404.3866.80.camel@mulgrave.il.steeleye.com>
	 <1152395222.8636.7.camel@localhost>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 17:13:05 -0500
Message-Id: <1152396785.12020.33.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 14:47 -0700, john stultz wrote:
> > Well, what I was seeing was that 
> > 
> > clocksource_read(clock) - clock->cycle_last
> > 
> > is returning a value about 200 x clock->cycle_interval
> 
> That then would be ~200 ticks. Is this at HZ=1000 ? 

no, 250.

> > According to the debugging printks I put into update_wall_time().  I was
> > assuming this was caused by a jump in the TSC count, but I suppose it
> > could also be cause by spurious alterations to cycle_last or other
> > effects I haven't traced.
> 
> Since this issue effected both the TSC and ACPI PM timer, I'd more
> likely suspect something is holding off the timer interrupt. This could
> be some kernel code like a driver, or it could be something like an SMI
> from the BIOS.

The driver takes only ~10s to insert and these cycle jumps occur within
that time frame, so it's not a real 200s.  The timer system has somehow
manufactured the cycle jump.

James


