Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWGCUIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWGCUIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWGCUIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:08:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:51155 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751279AbWGCUIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:08:11 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Daniel Walker <dwalker@mvista.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607030220.k632KqmK027679@turing-police.cc.vt.edu>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <200607030220.k632KqmK027679@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 13:08:08 -0700
Message-Id: <1151957288.5325.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 22:20 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 02 Jul 2006 18:56:22 PDT, Daniel Walker said:
> 
> > I was reviewing these new ntp adjustment functions, and it seems like it
> > would be a lot easier to just switch to a better clocksource. These new
> > functions seems to compensate for a clock that has a high rating but is
> > actually quite poor..
> 
> It is indeed poor - a few -mm's ago I tripped over a bug that kept it from
> recognizing the PM timer clocksource, and it refused to NTP sync because
> the clock drift was well outside the 500 ppm that NTP wants.  All the same,
> it's *one* thing for a clock to be drifting 10 seconds per hour.  It's
> something else to totally explode when handed a drifting clock.

Yes, the TSC is a very poor clocksource. Although its high resolution
and very quick access time makes it hard to quit. 

> Currently, the kernel is build with CONFIG_RTC=m, and the clock starts
> behaving as soom as rc.sysinit modprobes it.  Questions this raises:
> 
> 1) What's up with *that*?

Hmmm. Thats an interesting observation. Let me look to see if maybe
something is going oddly in the settimeofday() path.

> 2) Anybody want to place bets that building with CONFIG_RTC=y will make
> the clock work right off the bat?

No bets here, but please let us know if you see any change in behavior.

thanks
-john

