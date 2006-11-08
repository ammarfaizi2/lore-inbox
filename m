Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965931AbWKHQEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965931AbWKHQEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965934AbWKHQEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:04:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965931AbWKHQEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:04:02 -0500
Date: Wed, 8 Nov 2006 08:00:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Komuro <komurojun-mbn@nifty.com>
cc: tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com
Subject: Re: Re: 2.6.19-rc5: known regressions
In-Reply-To: <7813413.118221162987983254.komurojun-mbn@nifty.com>
Message-ID: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
References: <1162985578.8335.12.camel@localhost.localdomain>
 <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>  <20061108085235.GT4729@stusta.de>
 <7813413.118221162987983254.komurojun-mbn@nifty.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2006, Komuro wrote:
>
> Intel ISA PCIC probe: 
>   Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
>     host opts [0]: none
>     host opts [1]: none
>     ISA irqs (scanned) = 3,4,5,7,9,11,15 status change on irq 15

This definitely means that the IRQ subsystem works, at least here. That 
"scanned" means that the PCMCIA driver actually tested those interrupts, 
and they worked.

At that point, at least.

Of course, the "they worked" test is fairly simple, so it's by no means 
foolproof, but in general, it does sound like it all really should be ok.

Komuro, if you're a git user (or are willing to learn), and it's reliable 
with one particular card, it really would make most sense to bisect it. 
Just start off with

	git bisect start
	git bisect good v2.6.18
	git bisect bad v2.6.19-rc1

and off you go. That's a lot of commits (abotu 5000), but even if you 
don't ant to do the 12 or 13 kernel compiles and reboots that are needed 
for a full bisection,  doing just 4-5 would cut the number down a lot, and 
then you can send the bisection log out.

But testing 2.6.19-rc5 is still worth it. The APIC fixes might fix it, or 
some other changes might.

		Linus






> warning: process `date' used the removed sysctl system call
> EXT3 FS on hda1, internal journal
> Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1 across:257032k
> warning: process `ls' used the removed sysctl system call
> warning: process `sleep' used the removed sysctl system call
> cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x290-0x297 0x370-0x37f
> cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x290-0x297 0x370-0x37f
> cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> 
> Best Regards
> Komuro
> 
> 
