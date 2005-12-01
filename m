Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVLAQF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVLAQF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVLAQF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:05:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932278AbVLAQF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:05:28 -0500
Date: Thu, 1 Dec 2005 08:05:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kasper Sandberg <lkml@metanurb.dk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
In-Reply-To: <1133445903.16820.1.camel@localhost>
Message-ID: <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
 <1133445903.16820.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Kasper Sandberg wrote:
>
> On Wed, 2005-11-30 at 22:40 -0800, Linus Torvalds wrote:
> <snip>
> > 
> > 		Linus
> > 
> > [ Btw, some drivers will now complain loudly about their nasty mis-use of 
> >   page remapping, and that migh look scary, but it should all be good, and 
> >   we'd love to see the detailed output of dmesg on such machines. ]
> > 
> 
> this is the ati proprietary driver on x86 laptop.
> 
> Backtrace:
>  [<b013d88d>] bad_page+0x7d/0xc0
>  [<b013e124>] free_hot_cold_page+0x44/0x100
>  [<b0148c2c>] zap_pte_range+0xfc/0x220
>  [<b0148e3c>] unmap_page_range+0xec/0x110
>  [<b0148f21>] unmap_vmas+0xc1/0x1e0
>  [<b014cc45>] unmap_region+0x85/0x110
>  [<b014cf39>] do_munmap+0xd9/0x120
>  [<b014cfc7>] sys_munmap+0x47/0x70
>  [<b0102f1b>] sysenter_past_esp+0x54/0x75
> Trying to fix it up, but a reboot is needed

It _should_ have said something before this too. In particular, I'd have 
expected a message like

	X.org does an incomplete pfn remapping
	Backtrace:
	 ....

when the thing started up. Oh, and _just_ before that trace, I'd have 
expected a

	Bad page state at ....
	flags: .....

which is also something I'd like to see.

Oh, and that "Trying to fix it up, but a reboot is needed" message should 
be harmless. We share the same "bad_page()" function with all the 
problems, even though the PageReserved() one should really be harmless 
apart from being scary-noisy. So please keep running, if only to verify 
that I'm not full of crap about that.

(I can silence the nasty warnings easily enough, but I wanted people who 
triggered the new code-paths to be aware of it and report to me what 
drivers to it, so they are _really_ noisy right now).

		Thanks,

				Linus
