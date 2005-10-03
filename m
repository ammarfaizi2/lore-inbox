Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVJCTDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVJCTDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbVJCTDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:03:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55556 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932622AbVJCTDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:03:46 -0400
Date: Mon, 3 Oct 2005 21:03:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tony Luck <tony.luck@gmail.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/platform.h
Message-ID: <20051003190345.GH3652@stusta.de>
References: <20050902205204.GU3657@stusta.de> <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net> <20051001233414.GG4212@stusta.de> <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 12:01:08PM -0700, Tony Luck wrote:
> > --- linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c.old      2005-10-02 01:09:11.000000000 +0200
> > +++ linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c  2005-10-02 01:09:15.000000000 +0200
> > @@ -41,7 +41,6 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/efi.h>
> >  #include <linux/initrd.h>
> > -#include <linux/platform.h>
> >  #include <linux/pm.h>
> >
> >  #include <asm/ia32.h>
> 
> NAK.  Without <linux/platform.h> ia64 doesn't compile:
> 
>   CC      arch/ia64/kernel/setup.o
> arch/ia64/kernel/setup.c: In function `cpu_init':
> arch/ia64/kernel/setup.c:855: error: `default_idle' undeclared (first
> use in this function)
> arch/ia64/kernel/setup.c:855: error: (Each undeclared identifier is
> reported only once
> arch/ia64/kernel/setup.c:855: error: for each function it appears in.)
> make[1]: *** [arch/ia64/kernel/setup.o] Error 1
> make: *** [arch/ia64/kernel] Error 2
> 
> So you will need to add a:
> 
> extern void default_idle(void );
> 
> some place in setup.c to fix this.

The default_idle() prototype should stay inside some header file.

@Patrick:
Any suggestion where it should move to?

> -Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

