Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADXIS>; Thu, 4 Jan 2001 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRADXII>; Thu, 4 Jan 2001 18:08:08 -0500
Received: from hera.cwi.nl ([192.16.191.1]:12249 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129370AbRADXH4>;
	Thu, 4 Jan 2001 18:07:56 -0500
Date: Fri, 5 Jan 2001 00:07:53 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101042307.AAA143948.aeb@texel.cwi.nl>
To: haegar@cut.de, maillist@chello.nl
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 4 Jan 2001, Igmar Palsenberg wrote:
>
>> kernel 2.2.18 hates my Maxtor drive :
>> hda: Maxtor 96147H6, 32253MB w/2048kB Cache, CHS=65531/16/63, (U)DMA
>>
>> Actual (correct) parameters : CHS=119112/16/63

No. 2.2.* handles large drives since 2.2.14.
This looks more like you used the jumper to clip the drive to 32GB.
Don't use it and get full capacity.
If your BIOS hangs when it sees such a large drive so that you
cannot avoid using the jumper, use setmax in your boot scripts,
or use a kernel patch that does the same at kernel boot time.

>> Looks like some short int (2 bytes) overflowing. I'll try the ide patches.

The overflow is in certain BIOSes, not in Linux.
(You see in the above: 65531 is not an overflow value.)


Sven Koch replied:

> I had to recompile fdisk as my old suse 6.4 version got the same
> 2byte-wraparound problem.

In the good old days the HDIO_GETGEOM ioctl would give you the disk
geometry. It has a short for cylinders and hence overflows when C
gets above 65535. Since geometry is on its way out - indeed, there has
not been any such thing for many, many years - it would have been
nonsense to introduce new ioctls that report meaningless 32-bit numbers
instead of the present meaningless 16-bit number.
So, instead, the "cylinder" field in the output of this ioctl has been
declared obsolete, and is not used anymore. Programs that want to print
some value, just because they always did and users expect something,
now use BLKGETSIZE to get total size and divide by heads*sectors
to get a cylinder value.
(But again: this cylinder value is not used anywhere, the computed value
is just for the user's eyes.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
