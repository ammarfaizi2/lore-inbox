Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWGYW3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWGYW3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWGYW3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:29:38 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:35339 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932503AbWGYW3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:29:36 -0400
Date: Tue, 25 Jul 2006 18:25:47 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725222547.GA3973@localhost.localdomain>
References: <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6842C.8020501@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 01:50:52PM -0700, H. Peter Anvin wrote:
> Neil Horman wrote:
> >
> >Agreed.  How about we take the /dev/rtc patch now (since its an added 
> >feature
> >that doesn't hurt anything if its not used, as far as tickless kernels 
> >go), and
> >I'll start working on doing gettimeofday in vdso for arches other than 
> >x86_64.
> >That will give the X guys what they wanted until such time until all the 
> >other
> >arches have a gettimeofday alternative that doesn't require kernel traps.
> >
> 
> It hurts if it DOES get used.
> 
Yes, but if its in trade for something thats being used currently which hurts
more (case in point being the X server), using this solution is a net gain.

I'm not arguing with you that adding a low res gettimeofday vsyscall is a better
long term solution, but doing that requires potentially several implementations
in the C library accross a range of architectures, some of which may not be able
to provide a time solution any better than what the gettimeofday syscall
provides today.  The /dev/rtc solution is easy, available right now, and applies
to all arches.  It has zero impact for systems which do not use it, and for
those applications which make a decision to use it instead of an alternate
method, the result I expect will be a net gain, until such time as we code up,
test and roll out a vsyscall solution 

Thanks & Regards
Neil 
> 	-hpa
