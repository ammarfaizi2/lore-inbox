Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSIYP0Q>; Wed, 25 Sep 2002 11:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262004AbSIYP0P>; Wed, 25 Sep 2002 11:26:15 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:34254 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262003AbSIYP0K>; Wed, 25 Sep 2002 11:26:10 -0400
Message-ID: <3D91D749.40106@snapgear.com>
Date: Thu, 26 Sep 2002 01:33:29 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
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

Matthew Wilcox wrote:
> Thanks for splitting the patch up, makes it easier to see what's going on.
> Let's have another go at making this better...

:-)


> Motorola 5272 ethernet driver:
> * In Config.in, let's conditionalise it on CONFIG_PPC or something

The FEC ethernet core has been used by Motorola in both PowerPC parts
(the MPC860) and the ColdFire (5272). But it could be conditional
on either of these.


> * Can you use module_init() so it doesn't need an entry in Space.c?

Easy done :-)


> * You're defining CONFIG_* variables in the .c file.  I don't know whether
>   this is something we're still trying to avoid doing ... Greg, you seem
>   to be CodingStyle enforcer, what's the word?

To be honest I don't know why all of these are not always included.
The extra code size is not that significant (tehse rae just PHY 
definitions).

Some history:
I didn't write this driver. It is Dan Malek's driver for the ethernet
core in the PowerPC 860. I took that code and generalizd it for use
on the ColdFire 5272 which also uses the same ethernet core design.

By and large I have tried to leave the original drivers functionalty
"as it was", conditionalizing the 5272 support as required (there are
a few key differences to be dealt with).

I approached Dan in the past about merging the code, and he was not
interrested.


> * Why do you need to EXPORT_SYMBOL fec_register_ph and fec_unregister_ph?

I can't see any use for this...


> * There's an awful lot of stuff conditionalised on CONFIG_M5272.  In general,
>   having #ifdefs within functions is frowned upon.

Yeah, there is a bit of that. All due to trying to handle the
silicon implementation differences on the 860 and 5272.
I'll see if I can clean it up some.


> Motorola 68328 and ColdFire serial drivers:
> * Move to drivers/serial
> * Lose this change from the Makefile:
> -			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
> +			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o \
> * Drop the custom MIN() definition.
> * Port to new serial driver framework.

This is on my todo list :-)


> MTD driver patches for uClinux supported platforms:
> I don't see any problems.  Submit to Linus via Dave Woodhouse, I guess.

Already done. They have just not hit the mailline tree yet.
But David has it in his CVS now.


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

I'll look at cleaning this up too. This code has been hacked
on by so many people, I am still cleaning the chewy bits of it :-)


> I haven't reveiwed the other two patches.

mmnommu is probably the most contenious, and effects the most
files. I am still looking at merging the separated mmnommu
directory at the top level back into the mm directory. Just
thinking about the cleanest way to do that.

The m68knommu is purely architecture support, doesn't mess
with anything else in the kernel.

Thanks for the feedback, much appreciated!

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

