Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbTC0Rwn>; Thu, 27 Mar 2003 12:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTC0Rwm>; Thu, 27 Mar 2003 12:52:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263362AbTC0Rwk>;
	Thu, 27 Mar 2003 12:52:40 -0500
Date: Thu, 27 Mar 2003 11:00:15 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Swsusp <swsusp@lister.fornax.hu>, Florent Chabaud <fchabaud@free.fr>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Annouce: Initial SWSUSP 2.4 port to 2.5 available.
In-Reply-To: <1048732097.1731.14.camel@laptop-linux.cunninghams>
Message-ID: <Pine.LNX.4.33.0303271051350.1001-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there.

> - HighMem support
> - Multiple swap partiton support
> - Ability to cancel a suspend by pressing ALT.
> - Ability to save what is close a perfect image image of RAM (resulting
> in a very fast, responsive system on resume - assumes enough swap
> available to store your full image)
> - Extensive debugging capabilities
> - Fast and reliable (extensive testing done under 2.4).

I'm glad that you have done this work, and I look forward to merging it 
with the power management infrastructure work I have been doing. However, 
there are several outstanding issues. 

> There are issues still to be dealt with, but these should not in any way
> interfere with testing at this stage. They are:
> 
> - 2 page flags currently used: to be converted to dynamically allocated
> bitmaps

I will not take the code which still relies on the page flag bits. I look
forward to your dynamic bitmap implementation. 

As for the current patch, I was unable to test its actual functionality, 
which I will get to in a moment. 

First, I request that you please name the patches something sensible that 
won't collide with anything else, like swsusp-2.5.66-<n>.diff, not 
'patch-2.5.66-<n>.diff'.

Also, please make it explicitly clear which patch(es) are needed for 
download. On the sourceforge site, both -01 and -02 are highlighted as 
current, though they appear to different versions of the same thing. 

I'm glad to hear that you have completed the full port, but many people 
appreciate incremental patches, especially if the cumulative changes 
touch multiple parts of the kernel. Please consider breaking the one large 
patch into multiple, easily digestible, chunks. 

Finally, with either patch, there are unresolved symbols:

arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x1644): undefined reference to `save_processor_state'
arch/i386/kernel/built-in.o(.data+0x164a): undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x164f): undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x1655): undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x165b): undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1661): undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x1667): undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x166d): undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1673): undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x167a): undefined reference to `saved_context_eflags'

The fix is likely trivial, but it is annoying that it happens in the first 
place.

Thanks,


	-pat

