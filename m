Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272666AbRIGOEu>; Fri, 7 Sep 2001 10:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272668AbRIGOEk>; Fri, 7 Sep 2001 10:04:40 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:32388 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S272666AbRIGOEh>; Fri, 7 Sep 2001 10:04:37 -0400
Date: Fri, 7 Sep 2001 10:04:53 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: MTD and Adapter ROMs 
In-Reply-To: <7118.999857612@redhat.com>
Message-ID: <Pine.GSO.4.33.0109070954400.1190-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001, David Woodhouse wrote:
>jfbeam@bluetopia.net said:
>> Has anyone tried adapting any of the MTD code to allow read/write
>> access to adapter EEPROMs like the netboot ROM on some network cards
>> -- or more to the point, HPT adapter cards?
>
>Should be relatively simple if you just provide the appropriate 'map'
>driver to access the flash and set the Vpp line when asked.
>
>See drivers/mtd/maps/l440gx.c in my tree.
>
>There's also the code at http://www.freiburg.linux.de/~stepan/bios/
>which possibly ought to be merged with the MTD code.

Well, just having documentation on how all the spooge in drivers/mtd
actually goes together would go along way to helping people use it.  The
flash chip is an SST 39SF010.  It will appear somewhere in PCI memory
space once I reenable the adapter ROM.  It is a JEDEC compilant device.
I have some code from SST for programming it, but I'd rather go the
general route instead of the one-shot flash-and-run module.

I was playing with the physmap driver but that kept oppsing the machine.
That was with 2.4.7 tho'.

I think it'll be as "simple" as adding the ID to jedec.c.  Load chips/*,
maps/hpt-rom (doctored physmap to enable the rom and use it's location),
and then see if I can get mtdchar to drive the mess.

--Ricky

PS: Never use the PoS "load.exe" from HPT.  It's apparently designed for a
    4MHz 286.  The delay loops are VERY wrong on any modern processor.  A
    PII 233 fails to properly write 10% of the bytes.


