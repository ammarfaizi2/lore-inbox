Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSHJGIr>; Sat, 10 Aug 2002 02:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHJGIr>; Sat, 10 Aug 2002 02:08:47 -0400
Received: from vic7-adsl-050.tpgi.com.au ([203.213.71.50]:38556 "EHLO
	coralshark.bluereef.com.au") by vger.kernel.org with ESMTP
	id <S316595AbSHJGIq>; Sat, 10 Aug 2002 02:08:46 -0400
Message-ID: <085301c24035$e2797450$2b01010a@bluereef.local>
From: "Andrew Hall" <andrew.hall@bluereef.com.au>
To: "Mike Galbraith" <EFAULT@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
References: <079d01c23f7b$e3cf34d0$2b01010a@bluereef.local> <3D53B951.2070304@gmx.de>
Subject: Re: 2.2.20 ramdisk(initrd) not found by kernel
Date: Sat, 10 Aug 2002 16:19:29 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This infact seems to be correct. After investigation it turns out that it is
lilo that baulks at anything bigger than 16MB of initrd (after
decompression). I have confirmed this using 2.2.20, 2.2.21, 2.4.7 and a few
printks to see if these images are actually getting the start_initrd value
passed. Anything bigger than 16MB and lilo will either:

a. Seem to complete the load but not pass the ramdisk_start value to the
kernel
or
b. Cold hang during the copy of the compressed image into memory

I've had a bit of a look at the lilo source but the assembly stuff is
meaningless to me. Can anyone please tell me if this is the intended
function of lilo (to be limited to a 16MB initrd?) or point me in the right
direction as to where I might start looking for this bug in the lilo source.
>From what Mike says, below it would seem that this problem is not specific
to Lilo, but effects Loadlin aswell. I will try grub next.

Thanks,

Andrew.
----- Original Message -----
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Andrew" <temp01@bluereef.com.au>
Sent: Friday, August 09, 2002 10:45 PM
Subject: Re: 2.2.20 ramdisk(initrd) not found by kernel


> Andrew wrote:
>
> >I have a problem that I have been wrestling with now for a number of days
> >with no solution, and I'm hoping someone can help.
> >
> >My problem is that when the 2.2.20 kernel loads, lilo doesn't seem to
load
> >the rootfs.img into RAM or it gets dropped before the kernel finds it.
That
> >is I don't get the
> >kernel message 'RAMDISK found at block 0' message and thus Linux panics
with
> >something like "root file system not found on dev 1:0".
> >
> >I have a stock 2.2.20 kernel with ramdisk and initrd support compiled in.
> >RAMdisk size is 64MB although I've also tried 32MB and 128MB.
> >I have tried kernel builds with module support and without (everything
> >compiled in)
> >I'm using the latest lilo I can find with the following config:
> >
> >boot=/dev/hdc
> >disk=/dev/hdc
> > bios=0x80
> >map=/map
> >install=/boot.b
> >backup=/boot.1600
> >prompt
> >linear
> >timeout=50
> >password=maintenance
> >restricted
> >image=/vmlinuz-2.2.20up
> >        label=test
> >        ramdisk=65536
> >        initrd=/rootfs.img
> >        root=/dev/ram
> >
> >The server is a uni processor PIII server with 512MB of RAM
> >
> >The sizes of my rootfs.img and kernel are:
> > 8713856 Aug  7 12:55 rootfs.img (this is an ext2 compressed image)
> > 787022 Aug  7 12:17 vmlinuz-2.2.20up (this is a monolithic bzImage
kernel)
> >
> >Lilo when building doesn't report any errors in fact it says it
successfully
> >maps the RAMdisk ok
> >
> >It almost seems like there is some finite size or block limit that my
> >rootfs.img+kernel is greater than, that stops the
> >RAMdisk being loaded or being found if it is infact being loaded at all.
> >
> >Is there a finite limit on the size initrd can be? Enlarging the ramdisk
> >size or altering the block size of the image doesn't seem to make any
> >difference.
> >
>
> 16MB was the largest I could ever load.  (but that could have been a
> loadlin limitation)
>
>     -Mike
>
>
>
>

