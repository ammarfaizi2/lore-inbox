Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317132AbSEXPKj>; Fri, 24 May 2002 11:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317146AbSEXPKi>; Fri, 24 May 2002 11:10:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34831 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317132AbSEXPKe>; Fri, 24 May 2002 11:10:34 -0400
Message-ID: <3CEE4905.5010503@evision-ventures.com>
Date: Fri, 24 May 2002 16:07:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
In-Reply-To: <Pine.SOL.4.30.0205241620440.16894-100000@mion.elka.pw.edu.pl> <20020524165021.B10656@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Vojtech Pavlik napisa?:
> On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
>>Hi!
>>
>>I have a very quick look over patch/driver... looks quite ok...
>>
>>But it doesn't support multiple controllers.
> 
> 
> Yes, right! That's a bug. Ahh, that's why all the drivers use the PCI
> device id over and over and over in the sources ...
> 
> 
>>We should add 'unsigned long private' to 'ata_channel struct' and
>>store index in the chipset table there.
> 
> 
> That'd be great. Though I prefer void*. Looks like "drive_data" is
> intended for that purpose. Martin: How about renaming this to "private"
> and a comment "solely for use by chip-specific drivers"?

Indeed strcut ata_channel should be virtualized this way.
However you can't reuse drive_data for this purpose - that
get's consumed by ide-scsi already if I remember correctly.
(Will have to double check.)

> 
> A private member in the ata_pci_device[] struct would be also very
> useful. Or is the "extra" field for that?

extra is it already for host chip driver specific flags.
pdc202xx is the only one using it. Indeed this should be moved
to a void *private as well.

But anyway principally I agree with all the suggestions.
BTW.> Please note that right now we have a bit
of dichotomy about where the actual driver
methods get stored, after I have generalized the registration
of the driver. This should be unified at some point in time as well.
(xxxproc and udma_xxx method famili is what I have in mind here.)

>>You can remove duplicate entries from module data table.
> 
> 
> I wonder how they got there ...

Already gone in nr. 70.

>>BTW: please don't touch pdc202xx.c I am playing with it...
> 
> 
> Ok, I won't. Send it to me for comments later.

You guys are reducing me more and more to a spinnlock for
synchronization ;-).

