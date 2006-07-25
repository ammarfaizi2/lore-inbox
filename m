Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWGYXXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWGYXXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWGYXXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:23:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17897 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030249AbWGYXXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:23:19 -0400
Message-ID: <44C6A7B7.8010604@zytor.com>
Date: Tue, 25 Jul 2006 16:22:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <44C69C2E.7000609@zytor.com> <20060725231043.GA4661@localhost.localdomain>
In-Reply-To: <20060725231043.GA4661@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
>>>
>> Quick hacks are frowned upon in the Linux universe.  The kernel-user 
>> space interface is supposed to be stable, and thus a hack like this has 
>> to be maintained indefinitely.
>>
>> Putting temporary hacks like this in is not a good idea.
>>
> Only if you make the mental leap that this is a hack; its not.  Its a new
> feature for a driver.  mmap on device drivers is a well known and understood
> interface.  There is nothing hackish about it.  And there is no need for it to
> be temporary either.  Why shouldn't the rtc driver be able to export a monotonic
> counter via the mmap interface? mmtimer does it already, as do many other
> drivers.  Theres nothing unstable about this interface, and it need not be short
> lived.  It can live in perpituity, and applications can choose to use it, or
> migrate away from it should something else more efficient become available (a
> gettimeofday vsyscall).  More importantly, it can continue to be used in those
> situations where a vsyscall is not feasable, or simply maps to the nominal slow
> path kernel trap that one would find to heavy-weight to use in comparison to an
> mmaped page.
> 

The reason it is a hack is because you're hard-coding the fact that 
you're taking a global, periodic interrupt.  Yes, it can be dealt with 
scheduler hacks in tickless case, but that seems really heavyweight.

	-hpa
