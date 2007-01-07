Return-Path: <linux-kernel-owner+w=401wt.eu-S932465AbXAGKC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbXAGKC7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbXAGKC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:02:59 -0500
Received: from mail.macqel.be ([194.78.208.39]:19546 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932465AbXAGKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:02:58 -0500
Date: Sun, 7 Jan 2007 11:02:56 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RTC subsystem and fractions of seconds
Message-ID: <20070107100256.GA24013@ingate.macqel.be>
References: <200701051949.00662.david-b@pacbell.net> <20070106232633.GA8535@ingate.macqel.be> <200701061552.43654.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701061552.43654.david-b@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 03:52:43PM -0800, David Brownell wrote:
> On Saturday 06 January 2007 3:26 pm, Philippe De Muyter wrote:
> > On Fri, Jan 05, 2007 at 07:49:00PM -0800, David Brownell wrote:
> > > >  	Those rtc's actually have a 1/100th of second
> > > > register.  Should the generic rtc interface not support that?
> > > 
> > > Are you implying a new userspace API, or just an in-kernel update?
> > 
> > My only concern at the moment is initializing linux's timeofday from the rtc
> > quickly and with a good precision. 
> 
> There will necessarily be a bit of fuzz there since it can take time to
> get that RTC's mutex, and the task setting that time can be preempted.
> Plus, there can also be delays at the I2C or SPI transaction level.
> 
> 
> > The way it is done currently 
> > in drivers/rtc/hctosys.c is 0.5 sec off.  We could obtain a much better
> > precision by looping there until the next change (next second for old clocks,
> > next 0.01 second for m41t81, maybe even better for other ones).
> 
> Hmm ... "looping" fights against "quickly"; as would "wait for next
> update IRQ" (on RTCs that support that).  But it would improve precision,
> at least in the sense of having the system clock and that RTC spending
> less time with the lowest "seconds" digit disagreeing.
> 
> This is something you could write a patch for, n'est-ce pas?

That would require changing the interface provided by the rtc class, but
I'll look at it.

> 
> - Dave
> 
> 

-- 
