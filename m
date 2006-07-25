Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWGYTEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWGYTEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWGYTEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:04:22 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:6408 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964806AbWGYTEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:04:21 -0400
Date: Tue, 25 Jul 2006 15:03:57 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725190357.GG4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <1153850139.8932.40.camel@laptopd505.fenrus.org> <20060725182208.GD4608@hmsreliant.homelinux.net> <1153852375.8932.41.camel@laptopd505.fenrus.org> <20060725184328.GF4608@hmsreliant.homelinux.net> <1153853596.8932.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153853596.8932.44.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:53:16PM +0200, Arjan van de Ven wrote:
> On Tue, 2006-07-25 at 14:43 -0400, Neil Horman wrote:
> > On Tue, Jul 25, 2006 at 08:32:55PM +0200, Arjan van de Ven wrote:
> > > 
> > > > > 3) this will negate the power gain you get for tickless kernels, since
> > > > > now they need to start ticking again ;( )
> > > > > 
> > > > That is true, but only in the case where someone opens up /dev/rtc, and if they
> > > > open that driver and send it a UIE or PIE ioctl, it will start ticking
> > > > regardless of this patch (or that is at least my impression).
> > > 
> > > but.. if that's X like you said.. then it's basically "always"...
> > > 
> > Well, not always (considering the number of non-X embedded systems out there),
> > but I take your point.  So it really boils down to not having a tickless kernel,
> > or an X server that calls gettimeofday 1 million times per second (I think thats
> > the number that Dave threw out there).  Unless of course, you have a third
> > alternative, which, as I mentioned before I would be happy to take a crack at,
> > if you would elaborate on your idea a little more.
> 
> well the idea that has been tossed about a few times is using a vsyscall
> function that either calls into the kernel, or directly uses the hpet
> page (which can be user mapped) to get time information that way... 
> or even would use rdtsc in a way the kernel knows is safe (eg corrected
> for the local cpu's speed and offset etc etc).
> 
Ok, that makes sense, although thats only going to be supportable on hpet
enabled systems right?  Would a "both" make more sense, so that things like X
can get user space monotonic time regardless of cpu abilities?

Regarsds
Neil

> 
> -- 
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
