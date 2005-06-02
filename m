Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFBUgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFBUgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFBUfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:35:14 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:4546 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261319AbVFBUcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:32:35 -0400
Date: Thu, 2 Jun 2005 13:32:25 -0700
From: Tony Lindgren <tony@atomide.com>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050602203225.GH21363@atomide.com>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <200506022203.27734.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506022203.27734.mail@earthworm.de>
User-Agent: mutt-ng 1.5.9i (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Hesse <mail@earthworm.de> [050602 13:04]:
> On Thursday 02 June 2005 19:42, Tony Lindgren wrote:
> > * Christian Hesse <mail@earthworm.de> [050602 01:31]:
> > > On Thursday 02 June 2005 03:36, Tony Lindgren wrote:
> > > > Hi all,
> > > >
> > > > Here's an updated version of the dynamic tick patch.
> > > >
> > > > It's mostly clean-up and it's now using the standard
> > > > monotonic_clock() functions as suggested by John Stultz.
> > > >
> > > > Please let me know of any issues with the patch. I'll continue to do
> > > > more clean-up on it, but I think the basic functionality is done.
> > >
> > > I would like to test it, but have some trouble. The patch applies cleanly
> > > and everything compiles fine, but linking fails:
> > >
> > > [ linker errors ]
> >
> > Should be fixed now, the header was defining it as a function un UP
> > system with no local apic. Can you try the following version?
> 
> This one compiles and links without problems.
> 
> The reason I want to use this patch is that I hear a high pitched noise [1] 
> when running with 1000Hz and the processor is idle. With this patch I could 
> use 1000Hz without any noise.

Heh!

> But I found some problems on my system:
> 
> - time does not run the correct speed, it was some minutes in future after I 
> had compiled a new kernel

Could you please post output of the following commands:

$ dmesg | grep -i "time\|tick\|apic"

# for i in 1 2 3 4 5; do ntpdate -b someserver.somewhere && sleep 10; done

Also, please attach your .config file too.

> - pressing a key on the keyboard sometimes results in two or more characters, 
> not only one
>
> - mouse misses some events, e.g. clicks are not recognized (synaptics 
> touchpad)
> 
> - using software suspend 2.1.8.10 I can suspend the system, but it hangs while 
> resuming

None of this should happen...

Tony
