Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVBIV0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVBIV0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVBIV0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:26:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18645 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261929AbVBIVZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:25:49 -0500
Date: Wed, 9 Feb 2005 15:42:32 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Todd Shetter <tshetter-lkml@earthlink.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.4.x kernel BUG at filemap.c:81
Message-ID: <20050209174232.GC15888@logos.cnet>
References: <42099C57.9030306@earthlink.net> <20050209121011.GA13614@logos.cnet> <420A3A8D.9030705@earthlink.net> <20050209130319.GA13986@logos.cnet> <420A76E0.2030604@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420A76E0.2030604@earthlink.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 03:47:28PM -0500, Todd Shetter wrote:

> >>>>Running slackware 10 and 10.1, with kernels 2.4.26, 2.4.27, 2.4.28, 
> >>>>2.4.29 with highmem 4GB, and highmem i/o support enabled, I get a 
> >>>>system lockup. This happens in both X and console. Happens with and 
> >>>>without my Nvidia drivers loaded. I cannot determine what makes this 
> >>>>bug present it self besides highmem and high i/o support enabled. Im 
> >>>>guessing the system is fine until highmem is actually used to some 
> >>>>point and then it borks, but I really have no idea and so im just 
> >>>>making a random guess. I ran memtest86 for a few hours a while ago 
> >>>>thinking that it may be bad memory, but that did not seem to be the 
> >>>>problem.
> >>>>
> >>>>If you need anymore information, or have questions, or wish me to test 
> >>>>anything, PLEASE feel free to contact me, I would really like to see 
> >>>>this bug resolved. =)
> >>>>
> >>>>--
> >>>>Todd Shetter
> >>>>
> >>>>
> >>>>Feb  8 19:49:31 quark kernel: kernel BUG at filemap.c:81!
> >>>>Feb  8 19:49:31 quark kernel: invalid operand: 0000
> >>>>Feb  8 19:49:31 quark kernel: CPU:    0
> >>>>Feb  8 19:49:31 quark kernel: EIP:    0010:[<c01280d1>]    Tainted: P
> >>>> 
> >>>>
> >>>>       
> >>>>
> >>>Hi Todd, 
> >>>
> >>>Why is your kernel tainted ?
> >>>
> >>I had the nvidia 1.0-6629 driver loaded when I got that error. I 
> >>compiled the kernel using the slackware 10.1 config, enabled highmem 4GB 
> >>support, highmem i/o, and then some kernel hacking options including 
> >>debugging for highmen related things.
> >>
> >>I booted, loaded X with KDE, opened firefox a few times, and then 
> >>started running hdparm because some newer 2.4.x kernels dont play nice 
> >>with my SATA, ICH5, and DMA. hdparm segfaulted while running the drive 
> >>read access portion of its tests, and things locked up from there in 
> >>about 30secs.
> >>
> >>I've gotten the same error with the nvidia driver not loaded, so I dont 
> >>think that is part of the problem.
> >>
> >>As I said, if you want me to test or try anything feel free to ask.  =)
> >>   
> >
> >Todd,
> >
> >Would be interesting to have the oops output without the kernel nvidia 
> >module. 
> >Do you have that saved?
> >
> >
> >
> Sorry, it took me FOREVER to get this bug to appear again, and this time 
> its a little different.

Hum, both BUGs are due to a page with alive ->buffers mapping.

Did it crashed right after hdparm now too? 

Can you boot your box without SATA drivers, configuring the interface to IDE 
mode ?

Which problems are you facing with newer v2.4.x kernels and SATA? 


> Feb  9 15:20:37 quark kernel: kernel BUG at page_alloc.c:142!
> Feb  9 15:20:37 quark kernel: invalid operand: 0000
> Feb  9 15:20:37 quark kernel: CPU:    0
> Feb  9 15:20:37 quark kernel: EIP:    0010:[<c0131095>]    Not tainted
> Feb  9 15:20:37 quark kernel: EFLAGS: 00013206
> Feb  9 15:20:37 quark kernel: eax: 01000014   ebx: c17e1160   ecx: 
> 00004000   edx: 00000000
> Feb  9 15:20:37 quark kernel: esi: 00000000   edi: eea037f0   ebp: 
> f0f27f24   esp: f0f27ef0
> Feb  9 15:20:37 quark kernel: ds: 0018   es: 0018   ss: 0018
> Feb  9 15:20:37 quark kernel: Process X (pid: 2206, stackpage=f0f27000)
> Feb  9 15:20:37 quark kernel: Stack: c0324d68 00037000 c1000020 c17e11c0 
> c0324cb8 c1030020 c0324cf0 00003207
> Feb  9 15:20:37 quark kernel:        c17e1160 f0f27f24 2a05c067 001fc000 
> eea037f0 f0f27f68 c012531c c17e1160
> Feb  9 15:20:37 quark kernel:        c17e1160 000001fd 002f0000 49800000 
> 00000000 496f0000 f0eee494 49400000
> Feb  9 15:20:37 quark kernel: Call Trace:    [<c012531c>] [<c0127adf>] 
> [<c0127ba2>] [<c0108d23>]
> Feb  9 15:20:37 quark kernel:
> Feb  9 15:20:37 quark kernel: Code: 0f 0b 8e 00 bf 06 2e c0 8b 53 08 85 
> d2 74 08 0f 0b 90 00 bf
> Feb  9 15:30:41 quark kernel:  <6>SysRq : SAK
