Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWGYX0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWGYX0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWGYX0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:26:16 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:47061 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030236AbWGYX0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:26:15 -0400
In-Reply-To: <20060725194733.GJ4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B7D3442E-3874-488A-9A01-C126BAFF9A88@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Date: Wed, 26 Jul 2006 01:26:07 +0200
To: Neil Horman <nhorman@tuxdriver.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But userland cannot know if there is a more efficient option to
>> use than this /dev/rtc way, without using VDSO/vsyscall.
>>
> Sure, but detecting if /dev/rtc via mmap is faster than  
> gettimeofday is an
> orthogonal issue to having the choice in the first place.

No it's not.  Userland can not detect things it doesn't know
about, and then when there is a great choice, it won't see it,
and use the 6000kW solution (or any other really bad thing)
instead.

Using the old old legacy stuff when there's nothing better around
is a fine idea; please just implement an x86 VDSO that does just
that.  x86 is what you care about IIUC.  Don't saddle up non-x86
systems that just happen to have a legacy RTC around, and perhaps
x86 systems that don't sanely expose their better interfaces, with
this quite suboptimal solution for years to come.


Segher

