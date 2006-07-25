Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWGYUEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWGYUEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWGYUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:04:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:47181 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964847AbWGYUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:04:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ktpdT3mBXZrCfRdJB/GancAka/l92+fNYTW8HWuIQvbj7MwT5MJ1O9o+JTjVVzec37iPPF2yzxGo/ZJX/Q3K7wvMxIYNzYHmCS4mg9dk6BvMd5oFdkZBFpMbfpX0x+Pa1gHt+a1IWmM+EASw+QSBAcE9FdwkBSuFRsRLI+2mkmI=
Message-ID: <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
Date: Wed, 26 Jul 2006 06:04:14 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Neil Horman" <nhorman@tuxdriver.com>
Subject: Re: Re: [PATCH] RTC: Add mmap method to rtc character driver
Cc: "Segher Boessenkool" <segher@kernel.crashing.org>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725194733.GJ4608@hmsreliant.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
	 <20060725182833.GE4608@hmsreliant.homelinux.net>
	 <44C66C91.8090700@zytor.com>
	 <20060725192138.GI4608@hmsreliant.homelinux.net>
	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
	 <20060725194733.GJ4608@hmsreliant.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > But userland cannot know if there is a more efficient option to
> > use than this /dev/rtc way, without using VDSO/vsyscall.
> >
> Sure, but detecting if /dev/rtc via mmap is faster than gettimeofday is an
> orthogonal issue to having the choice in the first place.  I say let the X guys
> write code to determine at run time what is more efficient to get their job
> done.  I really just wanted to give them the ability to avoid making a million
> kernel traps a second for those arches where a userspace gettimeofday is not
> yet implemented, or cannot be implemented.  It won't cost anything to add this
> feature, and if the Xorg people can write code to use gettimeofday if its faster
> than mmaped /dev/rtc (or even configured to do so at compile-time).  This patch
> doesn't create any interrupts that wouldn't be generated already anyway by any
> user using /dev/rtc, and even if X doesn't already use /dev/rtc, the added
> interrupts are in trade for an equally fewer number of kernel traps, which I
> think has to be a net savings.
>
> I'm not saying we shouldn't implement a vsyscall on more platforms to provide a
> speedup for this problem (in fact I'm interested to learn how, since I hadn't
> previously considered that as a possibility), but I think offering the choice is
> a smart thing to do until the latter solution gets propogated to other
> arches/platforms besides x86_64
>

So far the requirements are pretty much not high resolution but is
accurate and increasing. so like 10ms is fine, the current X timer is
in the 20ms range.

I think an mmap'ed page with whatever cgt(CLOCK_MONOTONIC) returns
would be very good, but it might be nice to implement some sort of new
generic /dev that X can mmap and each arch can do what they want in
it,

I'm wondering why x86 doesn't have gettimeofday vDSO (does x86 have
proper vDSO support at all apart from sysenter?),

Dave.
