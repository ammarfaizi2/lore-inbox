Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWGYTbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWGYTbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWGYTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:31:42 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:58575 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964843AbWGYTbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:31:40 -0400
In-Reply-To: <20060725192138.GI4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Date: Tue, 25 Jul 2006 21:31:32 +0200
To: Neil Horman <nhorman@tuxdriver.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not really.  This introduces a potentially very difficult support
>> user-visible interface.  Consider a tickless kernel -- you might  
>> end up
>> taking tick interrupts ONLY to update this page, since you don't have
>> any way of knowing when userspace wants to look at it.
>>
> Well, you do actually know when they want to look at it.  The rtc  
> driver only
> unmasks its interrupt when a user space process has opened the  
> device and sent
> it a RTC_UIE ON or RTC_PIE_ON (or other shuch ioctl).  So if you  
> open /dev/rtc,
> and memory map the page, but never enable a timer method, then  
> every read of the
> page returns zero.  The only overhead this patch is currently  
> adding, execution
> time-wise is the extra time it takes to write to a the shared page  
> variable.  If
> the timer tick interrupt is executing, its because someone is  
> reading tick data,
> or plans to very soon.

But userland cannot know if there is a more efficient option to
use than this /dev/rtc way, without using VDSO/vsyscall.


Segher

