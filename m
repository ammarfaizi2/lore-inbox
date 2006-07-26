Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWGZAHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWGZAHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWGZAHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:07:03 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:29965 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030272AbWGZAHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:07:01 -0400
Date: Tue, 25 Jul 2006 20:03:14 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060726000314.GB5147@localhost.localdomain>
References: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <44C69C2E.7000609@zytor.com> <20060725231043.GA4661@localhost.localdomain> <44C6A7B7.8010604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6A7B7.8010604@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 04:22:31PM -0700, H. Peter Anvin wrote:
> Neil Horman wrote:
> >>>
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
> >
> 
> The reason it is a hack is because you're hard-coding the fact that 
> you're taking a global, periodic interrupt.  Yes, it can be dealt with 
> scheduler hacks in tickless case, but that seems really heavyweight.
>
I think that is an enormous overstatement.

My patch most certainly does not export that fact.  The only thing it provides
to userspace is a regular monotonically increasing counter independent of any
userspace scheduling.  The implementation using a regular interrupt is
completely hidden from userspace.  The rtc driver itself is whats responsible
for the global periodic interrupt.  By your logic the driver itself is a hack.

Honestly, this patch doesn't do any harm.  Any application using it currently
creates the same interrupt behavior that it would if it used the mmap interface.
I think the only argument here is that applications using other timing
facilities would create additional interrupts, but given that those applications
are using interfaces with more overhead than this one, making the switch would
be a net gain.

Neil

> 	-hpa
