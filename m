Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAEMdk>; Fri, 5 Jan 2001 07:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAEMda>; Fri, 5 Jan 2001 07:33:30 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:54611 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129401AbRAEMdN>; Fri, 5 Jan 2001 07:33:13 -0500
Date: Fri, 5 Jan 2001 14:40:18 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Andries.Brouwer@cwi.nl
cc: haegar@cut.de, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <UTC200101042307.AAA143948.aeb@texel.cwi.nl>
Message-ID: <Pine.LNX.4.21.0101051436330.5356-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No. 2.2.* handles large drives since 2.2.14.
> This looks more like you used the jumper to clip the drive to 32GB.
> Don't use it and get full capacity.
> If your BIOS hangs when it sees such a large drive so that you
> cannot avoid using the jumper, use setmax in your boot scripts,
> or use a kernel patch that does the same at kernel boot time.
> 
> >> Looks like some short int (2 bytes) overflowing. I'll try the ide patches.
> 
> The overflow is in certain BIOSes, not in Linux.
> (You see in the above: 65531 is not an overflow value.)

The number after clipping was actual - 2^16. Was the reason I was thinking
the kernel was playing games. After applying IDE patches the idesetmax
message showed up :) 

> > I had to recompile fdisk as my old suse 6.4 version got the same
> > 2byte-wraparound problem.
> 
> In the good old days the HDIO_GETGEOM ioctl would give you the disk
> geometry. It has a short for cylinders and hence overflows when C
> gets above 65535. Since geometry is on its way out - indeed, there has
> not been any such thing for many, many years - it would have been
> nonsense to introduce new ioctls that report meaningless 32-bit numbers
> instead of the present meaningless 16-bit number.
> So, instead, the "cylinder" field in the output of this ioctl has been
> declared obsolete, and is not used anymore. Programs that want to print
> some value, just because they always did and users expect something,
> now use BLKGETSIZE to get total size and divide by heads*sectors
> to get a cylinder value.
> (But again: this cylinder value is not used anywhere, the computed value
> is just for the user's eyes.)

all is block adressed indeed.. I need to look at fdisk, because it is
doing things wrong.

The other machine's BIOS can handle 64 GB wihout problems, so I can run
without clipping in that machine.

Linux sees the correct size, but fdisk still sees 32 GB. Probably a
recompile / upgrade.
 
> Andries


	Regards,

		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
