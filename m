Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWGZAWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWGZAWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWGZAWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:22:11 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:53261 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932325AbWGZAWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:22:09 -0400
Date: Tue, 25 Jul 2006 20:18:15 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: David Lang <dlang@digitalinsight.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060726001815.GE5147@localhost.localdomain>
References: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <44C69C2E.7000609@zytor.com> <20060725231043.GA4661@localhost.localdomain> <Pine.LNX.4.63.0607251625400.9159@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607251625400.9159@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 04:29:27PM -0700, David Lang wrote:
> On Tue, 25 Jul 2006, Neil Horman wrote:
> 
> >>
> >>Quick hacks are frowned upon in the Linux universe.  The kernel-user
> >>space interface is supposed to be stable, and thus a hack like this has
> >>to be maintained indefinitely.
> >>
> >>Putting temporary hacks like this in is not a good idea.
> >>
> >Only if you make the mental leap that this is a hack; its not.  Its a new
> >feature for a driver.  mmap on device drivers is a well known and 
> >understood
> >interface.  There is nothing hackish about it.  And there is no need for 
> >it to
> >be temporary either.  Why shouldn't the rtc driver be able to export a 
> >monotonic
> >counter via the mmap interface? mmtimer does it already, as do many other
> >drivers.  Theres nothing unstable about this interface, and it need not be 
> >short
> >lived.  It can live in perpituity, and applications can choose to use it, 
> >or
> >migrate away from it should something else more efficient become available 
> >(a
> >gettimeofday vsyscall).  More importantly, it can continue to be used in 
> >those
> >situations where a vsyscall is not feasable, or simply maps to the nominal 
> >slow
> >path kernel trap that one would find to heavy-weight to use in comparison 
> >to an
> >mmaped page.
> 
> given that this won't go into 2.6.18 at this point, isn't there time to 
> figure out the gettimeofday vsyscall before the 2.6.19 merge window? (in a 
> month or so). even if you have to wait until 2.6.20 it's unlikly that any 
> apps could be released with an interface to /dev/rtc rather then waiting a 
> little bit for the better interface.
> 
> David Lang
 
My primary concern is my skill level.  I normally work in the kernel, and I'm
not too familiar with glibc, and completely unfamiliar with vdso
implementations.  I'm interested to do it, but I have no idea how long it will
take to understand vsyscall implementations, code one up, and get it right.  If
you think a month is sufficient, I'll take your word for it, but I'm starting
from zero in this area.
Neil

