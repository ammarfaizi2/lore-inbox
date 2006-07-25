Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWGYVOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWGYVOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWGYVOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:14:50 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:29135 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964855AbWGYVOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:14:50 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <44C6875F.4090300@zytor.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
	 <20060725182833.GE4608@hmsreliant.homelinux.net>
	 <44C66C91.8090700@zytor.com>
	 <20060725192138.GI4608@hmsreliant.homelinux.net>
	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
	 <20060725194733.GJ4608@hmsreliant.homelinux.net>
	 <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
	 <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <1153861094.1230.20.camel@localhost.localdomain>
	 <44C6875F.4090300@zytor.com>
Content-Type: text/plain
Organization: OLPC
Date: Tue, 25 Jul 2006 17:14:47 -0400
Message-Id: <1153862087.1230.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 14:04 -0700, H. Peter Anvin wrote:

> 
> That's why I'm suggesting adding a cheap, possibly low-res, gettimeofday 
> virtual system call in case there is no way for the kernel to provide 
> userspace with a cheap full-resolution gettimeofday.  Obviously, if a 
> high-quality gettimeofday is available, then they can be linked together 
> by the kernel.

Low res is fine: X Timestamps are 1 millisecond values, and wrap after a
few hundred days.  What we do care about is monotonically increasing
values (until it wraps). On machines of the past, this was very
convenient; we'd just store a 32 bit value for clients to read, and not
bother with locking.  I guess these days, you'd at least have to protect
the store with a memory barrier, maybe....

It was amusing years ago to find toolkit bugs after applications had
been up for that long (32 bits of milliseconds)...  Yes, there are
applications and machines that stay up that long, really there are....

                                   Regards,
                                           - Jim

-- 
Jim Gettys
One Laptop Per Child


