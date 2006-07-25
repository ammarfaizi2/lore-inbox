Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWGYTWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWGYTWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWGYTV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:21:59 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:33032 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964829AbWGYTV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:21:59 -0400
Date: Tue, 25 Jul 2006 15:21:38 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725192138.GI4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C66C91.8090700@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 12:10:09PM -0700, H. Peter Anvin wrote:
> Neil Horman wrote:
> >
> >In general I agree, but that only works if you operate on a platform that
> >supports virtual syscalls, and has vdso configured.  I'm not overly 
> >familiar
> >with vdso, but I didn't think vdso could be supported on all 
> >platforms/arches.
> >This seems like it might be a nice addition in those cases.
> >
> 
> Not really.  This introduces a potentially very difficult support 
> user-visible interface.  Consider a tickless kernel -- you might end up 
> taking tick interrupts ONLY to update this page, since you don't have 
> any way of knowing when userspace wants to look at it.
> 
Well, you do actually know when they want to look at it.  The rtc driver only
unmasks its interrupt when a user space process has opened the device and sent
it a RTC_UIE ON or RTC_PIE_ON (or other shuch ioctl).  So if you open /dev/rtc,
and memory map the page, but never enable a timer method, then every read of the
page returns zero.  The only overhead this patch is currently adding, execution
time-wise is the extra time it takes to write to a the shared page variable.  If
the timer tick interrupt is executing, its because someone is reading tick data,
or plans to very soon.

Neil

> 	-hpa

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
