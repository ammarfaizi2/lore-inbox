Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSHBPnh>; Fri, 2 Aug 2002 11:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSHBPnh>; Fri, 2 Aug 2002 11:43:37 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:13306 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315430AbSHBPng>; Fri, 2 Aug 2002 11:43:36 -0400
Message-ID: <3D4AAA87.8050508@snapgear.com>
Date: Sat, 03 Aug 2002 01:51:35 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.30uc0 MMU-less patches
References: <20020802145034.B24631@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Matthew Wilcox wrote:
> Some constructive criticism...

Thanks :-)


>  - the Makefile changes seem terribly inappropriate.

They are messy. Some are certainly required, for exmaple
to support the mmnommu directory. Some simplify cross compilation
(like the ARCH and CROSS_COMPILE changes). Some are just pedantic,
creating a binary named linux since this not a vmlinux system.

I'll look at simplify that.


>  - you probably didn't mean to include page_alloc2.hack in the diff

Removed.


>  - Do you really need your own copy of fbcon.c?  Can it be merged with the
>    one in drivers/video?

Looking at it I think it could.


>  - arch/m68knommu/console/68328fb.c should probably move to drivers/video
>    too.
>  - ditto most of the other files in the console directory ... 

Yep, looks like the whole thing should be merged/moved into
drivers/video.


>  - Why are the changes to rd.c required?

The include of linux/mm.h is too get some missing includes
(this is probably due to slightly different includes in something
in include/asm-m68knommu, but I haven't tracked it down yet).

The other change is too work around a compiler bug. Unfortunately
this just appeared in 2.5.30. Gcc is generating incorrect addressing
modes for the ColdFire arhcitecture. This is a short term fix until
the compiler is fixed right.


>  - I'm not sure it's appropriate to include the changes to nfs2xdr.c --
>    is this a toolchain bug you're working around?

Yes, same as above. I wouldn't expect anyone would want these
changes other than those specifically using ColdFire targets.


>  - drivers/char/mcfserial.c needs to be converted to the new serial core
>    and moved to drivers/serial.
>  - ditto arch/m68knommu/platform/68360/quicc/uart.c

Yep, I am looking at that now. That will take me a little
effort and time to put together.


> I'll look at the change you want to make to locks.c - I'm not terribly
> fond of that interaction either.

Thanks for the tips.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

