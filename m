Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWG2XSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWG2XSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWG2XSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:18:23 -0400
Received: from mail.gmx.net ([213.165.64.21]:36251 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750751AbWG2XSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:18:22 -0400
X-Authenticated: #271361
Date: Sun, 30 Jul 2006 01:18:15 +0200
From: Edgar Toernig <froese@gmx.de>
To: Keith Packard <keithp@keithp.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, keithp@keithp.com,
       Bill Huey <billh@gnuppy.monkey.org>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-Id: <20060730011815.486ced4f.froese@gmx.de>
In-Reply-To: <1154213119.28839.76.camel@neko.keithp.com>
References: <44C67E1A.7050105@zytor.com>
	<20060725204736.GK4608@hmsreliant.homelinux.net>
	<1153861094.1230.20.camel@localhost.localdomain>
	<44C6875F.4090300@zytor.com>
	<1153862087.1230.38.camel@localhost.localdomain>
	<44C68AA8.6080702@zytor.com>
	<1153863542.1230.41.camel@localhost.localdomain>
	<20060729042820.GA16133@gnuppy.monkey.org>
	<20060729125427.GA6669@localhost.localdomain>
	<20060729204107.GA20890@gnuppy.monkey.org>
	<20060729214334.GA8624@localhost.localdomain>
	<1154213119.28839.76.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Packard wrote:
>
> A jiffy counter is sufficient for the X server; all I need is some
> indication that time has passed with a resolution of 10 to 20 ms. I
> check this after each X request is processed as that is the scheduling
> granularity. An X request can range in time from .1us to 100 seconds, so
> I really want to just check after each request rather than attempt some
> heuristic.

That's exactly what the mmap interface of /dev/itimer does.
See: http://marc.theaimsgroup.com/?m=115412412427996

Example code:

    volatile unsigned long *counter;
    ...
    fd=open("/dev/itimer", O_RDWR);
    write(fd, "20/1000\n", 8);
    counter = mmap(0, sizeof(*counter), PROT_READ, MAP_PRIVATE, fd, 0);
    close(fd);

Now, "*counter" is incremented every 20 ms by the kernel.

Ciao, ET.
