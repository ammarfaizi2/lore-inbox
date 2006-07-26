Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWGZAOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWGZAOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWGZAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:14:34 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:36621 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030288AbWGZAOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:14:33 -0400
Date: Tue, 25 Jul 2006 20:10:42 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060726001042.GD5147@localhost.localdomain>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <B7D3442E-3874-488A-9A01-C126BAFF9A88@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7D3442E-3874-488A-9A01-C126BAFF9A88@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:26:07AM +0200, Segher Boessenkool wrote:
> >>But userland cannot know if there is a more efficient option to
> >>use than this /dev/rtc way, without using VDSO/vsyscall.
> >>
> >Sure, but detecting if /dev/rtc via mmap is faster than  
> >gettimeofday is an
> >orthogonal issue to having the choice in the first place.
> 
> No it's not.  Userland can not detect things it doesn't know
> about, and then when there is a great choice, it won't see it,
> and use the 6000kW solution (or any other really bad thing)
> instead.
> 
You're right, it won't be easy for an application to detect if gettimeofday uses
a vdso that is more lightweight than a regular syscall, but it can measure how
much cpu a periodic call to gettimeofday uses vs. how much cpu a periodic rtc
interrupt uses.  It can use that information to make an informed decision about
which interface to use.  Alternatively, a package can be built with sane
defaults in mind (always use RTC vs. always use gettimeofday).
 
> Using the old old legacy stuff when there's nothing better around
> is a fine idea; please just implement an x86 VDSO that does just
> that.  x86 is what you care about IIUC.  Don't saddle up non-x86
> systems that just happen to have a legacy RTC around, and perhaps
> x86 systems that don't sanely expose their better interfaces, with
> this quite suboptimal solution for years to come.
> 
Yes, I intend to (I've got a steep learning curve, since I've not worked much
with glibc, and I've never implemented a vdso call before), but I think thats a
great idea.  My point is, why not have both interfaces available?  That way,
implementations which can't do any better via a vdso call can still get a
speedup through the legacy interface.

Neil

> 
> Segher
