Return-Path: <linux-kernel-owner+w=401wt.eu-S932271AbXAFXwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbXAFXwv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXAFXwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 18:52:51 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:46245 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932271AbXAFXwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 18:52:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=W3m3T9hJpoTbXxkbSlypLR9BiiJJ8gph6h3ns2it5XgePMcKGqOhEiFMGnFb5owUtVTlKLxMrvyRu2SOIkUD/bG9N8Yr77cUbCduYCTGXWh7TUunPRc9a5JXRykW7Ccjj0RaJh1S7I1SGYUy0cESmGigZbqvbNivkyDXZgq40T8=  ;
X-YMail-OSG: HSAnl_oVM1klZ6EwyO4IUvxX2.42FHNADYRIRAjytQpb7QBmDm6JJ61vvey3XF_Zy9.fn_ohyYNBxL_LQZNDVLPoaIx3gWQWh3_zHCAKWfiSthwm2iy1cXso46rJ9EJuJWhXC3OnCyvvVWI-
From: David Brownell <david-b@pacbell.net>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: RTC subsystem and fractions of seconds
Date: Sat, 6 Jan 2007 15:52:43 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200701051949.00662.david-b@pacbell.net> <20070106232633.GA8535@ingate.macqel.be>
In-Reply-To: <20070106232633.GA8535@ingate.macqel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701061552.43654.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2007 3:26 pm, Philippe De Muyter wrote:
> On Fri, Jan 05, 2007 at 07:49:00PM -0800, David Brownell wrote:
> > >  	Those rtc's actually have a 1/100th of second
> > > register.  Should the generic rtc interface not support that?
> > 
> > Are you implying a new userspace API, or just an in-kernel update?
> 
> My only concern at the moment is initializing linux's timeofday from the rtc
> quickly and with a good precision. 

There will necessarily be a bit of fuzz there since it can take time to
get that RTC's mutex, and the task setting that time can be preempted.
Plus, there can also be delays at the I2C or SPI transaction level.


> The way it is done currently 
> in drivers/rtc/hctosys.c is 0.5 sec off.  We could obtain a much better
> precision by looping there until the next change (next second for old clocks,
> next 0.01 second for m41t81, maybe even better for other ones).

Hmm ... "looping" fights against "quickly"; as would "wait for next
update IRQ" (on RTCs that support that).  But it would improve precision,
at least in the sense of having the system clock and that RTC spending
less time with the lowest "seconds" digit disagreeing.

This is something you could write a patch for, n'est-ce pas?

- Dave



