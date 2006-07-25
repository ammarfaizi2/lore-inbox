Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWGYUsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWGYUsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWGYUsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:48:17 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:1546 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750798AbWGYUsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:48:16 -0400
Date: Tue, 25 Jul 2006 16:47:36 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725204736.GK4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C67E1A.7050105@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 01:24:58PM -0700, H. Peter Anvin wrote:
> Dave Airlie wrote:
> >
> >So far the requirements are pretty much not high resolution but is
> >accurate and increasing. so like 10ms is fine, the current X timer is
> >in the 20ms range.
> >
> >I think an mmap'ed page with whatever cgt(CLOCK_MONOTONIC) returns
> >would be very good, but it might be nice to implement some sort of new
> >generic /dev that X can mmap and each arch can do what they want in
> >it,
> >
> >I'm wondering why x86 doesn't have gettimeofday vDSO (does x86 have
> >proper vDSO support at all apart from sysenter?),
> >
> 
> The i386 vdso right now has only two entry points, as far as I can tell: 
> system call and signal return.
> 
> There is no reason it couldn't have more than that.  A low-resolution 
> and a high-resolution gettimeofday might be a good idea.
> 
> 	-hpa

Agreed.  How about we take the /dev/rtc patch now (since its an added feature
that doesn't hurt anything if its not used, as far as tickless kernels go), and
I'll start working on doing gettimeofday in vdso for arches other than x86_64.
That will give the X guys what they wanted until such time until all the other
arches have a gettimeofday alternative that doesn't require kernel traps.

Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
