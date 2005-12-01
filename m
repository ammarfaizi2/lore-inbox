Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVLAS54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVLAS54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbVLAS54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:57:56 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:24948 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751690AbVLAS54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:57:56 -0500
Subject: Re: Linux 2.6.15-rc4
From: Kasper Sandberg <lkml@metanurb.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
	 <1133445903.16820.1.camel@localhost>
	 <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 19:57:53 +0100
Message-Id: <1133463473.16820.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 08:05 -0800, Linus Torvalds wrote:
> 
> On Thu, 1 Dec 2005, Kasper Sandberg wrote:
> >
> > On Wed, 2005-11-30 at 22:40 -0800, Linus Torvalds wrote:
> > <snip>
> > > 
> > > 		Linus
> > > 
> > > [ Btw, some drivers will now complain loudly about their nasty mis-use of 
> > >   page remapping, and that migh look scary, but it should all be good, and 
> > >   we'd love to see the detailed output of dmesg on such machines. ]
> > > 
> > 
> > this is the ati proprietary driver on x86 laptop.
> > 
> > Backtrace:
> >  [<b013d88d>] bad_page+0x7d/0xc0
> >  [<b013e124>] free_hot_cold_page+0x44/0x100
> >  [<b0148c2c>] zap_pte_range+0xfc/0x220
> >  [<b0148e3c>] unmap_page_range+0xec/0x110
> >  [<b0148f21>] unmap_vmas+0xc1/0x1e0
> >  [<b014cc45>] unmap_region+0x85/0x110
> >  [<b014cf39>] do_munmap+0xd9/0x120
> >  [<b014cfc7>] sys_munmap+0x47/0x70
> >  [<b0102f1b>] sysenter_past_esp+0x54/0x75
> > Trying to fix it up, but a reboot is needed
> 
> It _should_ have said something before this too. In particular, I'd have 
> expected a message like
> 
> 	X.org does an incomplete pfn remapping
> 	Backtrace:
> 	 ....
> 
> when the thing started up. Oh, and _just_ before that trace, I'd have 
> expected a
> 
> 	Bad page state at ....
> 	flags: .....
> 
> which is also something I'd like to see.
> 
> Oh, and that "Trying to fix it up, but a reboot is needed" message should 
> be harmless. We share the same "bad_page()" function with all the 
> problems, even though the PageReserved() one should really be harmless 
> apart from being scary-noisy. So please keep running, if only to verify 
> that I'm not full of crap about that.
> 
> (I can silence the nasty warnings easily enough, but I wanted people who 
> triggered the new code-paths to be aware of it and report to me what 
> drivers to it, so they are _really_ noisy right now).
im not sure its a good idea to silence this, because this seems to be a
genuine error, the ati proprietary driver is not working.. if i try to
use 3d, it will display this message again, and the process trying to
use 3d will freeze, and become unkillable.

> 
> 		Thanks,
> 
> 				Linus
> 

