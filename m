Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTH0PhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTH0PhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:37:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263453AbTH0Pgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:36:53 -0400
Date: Wed, 27 Aug 2003 11:37:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <200308271511.h7RFBFHu017520@wildsau.idv.uni.linz.at>
Message-ID: <Pine.LNX.4.53.0308271123480.659@chaos>
References: <200308271511.h7RFBFHu017520@wildsau.idv.uni.linz.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, H.Rosmanith (Kernel Mailing List) wrote:

> > > "after the first write the flash device failed entirely". That doen't
> >
> > no, I wrote several data to it, like partitioning it, writing /dev/zero
> > to it and so on. I moved it from computer to computer to try booting from
> > it, installed lilo on it and so on. After several hours of messing around
> > with the device, it failed.
>
> okidok.... I got an new flashdisk from the vendor, but managed to ruin
> it again. anyway, I also managed to repair it again. the vendor ships
> a seperate formating-tool, which will repair the device, even when you
> get "SCSI sense key errors".
>
> however, I still don't understand what's going on and *why* it is not
> allowed to format the drive "at will". I'd also would like to know how
> this vendor supplied formating-tool works. Possibly some vendor-specific
> usb-commands to ... do what? hm. I can only guess.
>
> I purchased another driver (TraxData, USB-1, 6 euros cheaper and it
> my mainboard can even boot from this device).
>
> by the way: the manufacturer is Panram, www.panram.com.tw/ ... does anyone
> of you have experience with them? Is it likely that one gets documentation
> from them?
>
> thx
> h.rosmanith
>

Remember when AT Class machines had a BIOS that allowed you
to low-level format hard drives? When early IDE drives came
out, persons tried to format them and they got destroyed.
So, BIOS vendors took away the format capability.

The IDE drive companies started a lie that was repeated so
often that it seemed true. It was that IDE drives didn't
have 'formatters' and, therefore, could only be formatted
at the factory. Of course, if this was true, how come
the format command did anything??  The truth was that
these drives stored their parameters on the disk platters.
If you re-wrote the first real sectors on the drive, the
drive no longer 'knew' what its parameters were and the
drive was broken forever. The actual seeks to various
logical sectors would bypass these private sectors so,
normally, this was invisible to the end-user. However,
if you re-wrote a whole track (what format does), these
invisible sectors would be overwritten.

With your NVRAM drive, it is likely that the drive parameters
are 'protected' by a partition table. If you overwrite this
partition table, the drive becomes broken. This means that,
whatever you do, you can't modify some important portion
of that table.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


