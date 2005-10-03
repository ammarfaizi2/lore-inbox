Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbVJCVu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbVJCVu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVJCVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:50:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17414 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932701AbVJCVu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:50:57 -0400
Date: Mon, 3 Oct 2005 23:50:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tony Luck <tony.luck@gmail.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/platform.h
Message-ID: <20051003215053.GI3652@stusta.de>
References: <20050902205204.GU3657@stusta.de> <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net> <20051001233414.GG4212@stusta.de> <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com> <20051003190345.GH3652@stusta.de> <12c511ca0510031407i5266cf4ak5082ec54f60a3d17@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c511ca0510031407i5266cf4ak5082ec54f60a3d17@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 02:07:12PM -0700, Tony Luck wrote:
> > The default_idle() prototype should stay inside some header file.
> 
> That would be best, yes.
> 
> > @Patrick:
> > Any suggestion where it should move to?
> 
> Of the include files already included directly by arch/ia64/kernel/setup.c,
> <linux/sched.h> looks the most promising.  There's lots of .*idle.* things
> already in there.
> 
> Looking at existing precedent: ppc64 has a definition of default_idle()
> in <asm/machdep.h>

The question whether linux/ or asm/ is the best place for the definition 
boils down to the question whether it is expected that default_idle() is 
present on all architectures or whether it's an architecture-specific 
implementation detail.

In the first case, I'm surprised that there is no platform independent 
code using it.

In the second case, it seems we can kill the default_idle() functions on 
mips (empty) and parisk.

> i396, cris and um already have gone along the route of adding extern
> definitions for default_idle() to ".c" files ... so cleanup creates more
> opportunities for cleanup (but you are probably very experienced in
> this phenomenom :-)

I stumbled across the question whether include/linux/platform.h is still 
required by cleaning up warnings with the -Wmissing-prototypes compiler 
flag I plan to add to the kernel CFLAGS soon that generates warnings 
for such extern constructs...

> -Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

