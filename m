Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWGYVIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWGYVIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWGYVIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:08:15 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56769 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932494AbWGYVIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:08:14 -0400
Message-ID: <44C6875F.4090300@zytor.com>
Date: Tue, 25 Jul 2006 14:04:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: jg@laptop.org
CC: Neil Horman <nhorman@tuxdriver.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net>	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>	 <20060725182833.GE4608@hmsreliant.homelinux.net>	 <44C66C91.8090700@zytor.com>	 <20060725192138.GI4608@hmsreliant.homelinux.net>	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>	 <20060725194733.GJ4608@hmsreliant.homelinux.net>	 <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>	 <44C67E1A.7050105@zytor.com>	 <20060725204736.GK4608@hmsreliant.homelinux.net> <1153861094.1230.20.camel@localhost.localdomain>
In-Reply-To: <1153861094.1230.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gettys wrote:
> 
> Some of us want/need both tickless and smart scheduling in the X server.
> 
> To give a bit of data: on my machine, a 1x1 rectangle can go almost 2
> million rectangles/second; a 500x500 rectangle is only 2800/second.  You
> can see the tremendous variation (and this is on accelerated hardware;
> the variation can in fact be much larger than this, if the operation has
> to be done in software fall-backs). 
> 
> This is why the X server needs to know the time so much, so cheaply; we
> have to be able to tell how much time a given client has been using, and
> it can't be computed from anything but the time; otherwise individual
> clients can "starve" other clients, and interactive feel goes to pot.
>                                - Jim
> 

That's why I'm suggesting adding a cheap, possibly low-res, gettimeofday 
virtual system call in case there is no way for the kernel to provide 
userspace with a cheap full-resolution gettimeofday.  Obviously, if a 
high-quality gettimeofday is available, then they can be linked together 
by the kernel.

	-hpa
