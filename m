Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSIZGAD>; Thu, 26 Sep 2002 02:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbSIZGAD>; Thu, 26 Sep 2002 02:00:03 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:11237 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262198AbSIZGAC>; Thu, 26 Sep 2002 02:00:02 -0400
Message-ID: <3D92A41F.4000705@snapgear.com>
Date: Thu, 26 Sep 2002 16:07:27 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I just generated a new patch, linux-2.5.38uc2.
Which addresses a lot of your comments. I did a
lot of work cleaning the ethernet driver, would
be very interreted in your thoughts on that now...

Regards
Greg




Matthew Wilcox wrote:
> Thanks for splitting the patch up, makes it easier to see what's going on.
> Let's have another go at making this better...
> 
> Motorola 5272 ethernet driver:
> * In Config.in, let's conditionalise it on CONFIG_PPC or something
> * Can you use module_init() so it doesn't need an entry in Space.c?
> * You're defining CONFIG_* variables in the .c file.  I don't know whether
>   this is something we're still trying to avoid doing ... Greg, you seem
>   to be CodingStyle enforcer, what's the word?
> * Why do you need to EXPORT_SYMBOL fec_register_ph and fec_unregister_ph?
> * There's an awful lot of stuff conditionalised on CONFIG_M5272.  In general,
>   having #ifdefs within functions is frowned upon.
> 
> Motorola 68328 and ColdFire serial drivers:
> * Move to drivers/serial
> * Lose this change from the Makefile:
> -			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
> +			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o \
> * Drop the custom MIN() definition.
> * Port to new serial driver framework.
> 
> MTD driver patches for uClinux supported platforms:
> I don't see any problems.  Submit to Linus via Dave Woodhouse, I guess.
> 
> Motorola 68328 framebuffer:
> Don't see any problems here either.
> 
> uClinux FLAT file format exe loader:
> * Drop the MAX() macro.
> * +#include "../lib/inflate2.c".  Er.  You seem to have missed inflate2.c
>   from your patch, and this really isn't the right way to do it anyway.
>   Can't you share inflate.c these days?
> * I'm also a little unsure about your per-arch #defines.  Could you put
>   comments by each saying why they're necessary?
> 
> I haven't reveiwed the other two patches.
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

