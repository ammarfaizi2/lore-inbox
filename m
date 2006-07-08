Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWGHEgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWGHEgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 00:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWGHEgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 00:36:52 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:55693 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932509AbWGHEgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 00:36:51 -0400
Subject: Re: Hang and Soft Lockup problems with generic time code
From: James Bottomley <James.Bottomley@SteelEye.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1152315579.7493.9.camel@localhost.localdomain>
References: <1152313879.3866.53.camel@mulgrave.il.steeleye.com>
	 <1152315579.7493.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 23:36:44 -0500
Message-Id: <1152333404.3866.80.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 16:39 -0700, john stultz wrote:
> Yep. This has been seen where a large number of ticks are lost. Roman
> and I are working on a solution for this (I sent a patch out to the
> list
> earlier today for it, and Roman *just* posted his version a moment ago
> -
> if you can give one or both of them a try it would be appreciated).

Well, the patch you posted here:

Message-ID: 1152298515.5330.12.camel () localhost ! localdomain

Seems to work fine, thanks.  I'm not sure what I'm looking for for the
other one.


> Did you really mean jumps of 200 seconds? Hmmm. The issue Roman and I
> have been looking into does occur when we lose a number of ticks and
> that confuses the clocksource adjustment code. The fix we're working
> on
> corrects the adjustment confusion, but doesn't fix the lost ticks.
> 
> However 200 seconds of lost ticks sounds very off. Could the driver be
> disabling interrupt for such a long period of time?

Well, what I was seeing was that 

clocksource_read(clock) - clock->cycle_last

is returning a value about 200 x clock->cycle_interval

According to the debugging printks I put into update_wall_time().  I was
assuming this was caused by a jump in the TSC count, but I suppose it
could also be cause by spurious alterations to cycle_last or other
effects I haven't traced.

James


