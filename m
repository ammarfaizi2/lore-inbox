Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWGYU6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWGYU6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWGYU6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:58:19 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:62598 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751591AbWGYU6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:58:19 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725204736.GK4608@hmsreliant.homelinux.net>
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
Content-Type: text/plain
Organization: OLPC
Date: Tue, 25 Jul 2006 16:58:14 -0400
Message-Id: <1153861094.1230.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 16:47 -0400, Neil Horman wrote:

> > 
> > The i386 vdso right now has only two entry points, as far as I can
> tell: 
> > system call and signal return.
> > 
> > There is no reason it couldn't have more than that.  A
> low-resolution 
> > and a high-resolution gettimeofday might be a good idea.
> > 
> >       -hpa
> 
> Agreed.  How about we take the /dev/rtc patch now (since its an added
> feature
> that doesn't hurt anything if its not used, as far as tickless kernels
> go), and
> I'll start working on doing gettimeofday in vdso for arches other than
> x86_64.
> That will give the X guys what they wanted until such time until all
> the other
> arches have a gettimeofday alternative that doesn't require kernel
> traps.
> 

Some of us want/need both tickless and smart scheduling in the X server.

To give a bit of data: on my machine, a 1x1 rectangle can go almost 2
million rectangles/second; a 500x500 rectangle is only 2800/second.  You
can see the tremendous variation (and this is on accelerated hardware;
the variation can in fact be much larger than this, if the operation has
to be done in software fall-backs). 

This is why the X server needs to know the time so much, so cheaply; we
have to be able to tell how much time a given client has been using, and
it can't be computed from anything but the time; otherwise individual
clients can "starve" other clients, and interactive feel goes to pot.
                               - Jim

-- 
Jim Gettys
One Laptop Per Child


