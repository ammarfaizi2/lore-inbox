Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282920AbRK0T66>; Tue, 27 Nov 2001 14:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282923AbRK0T6s>; Tue, 27 Nov 2001 14:58:48 -0500
Received: from law2-oe31.hotmail.com ([216.32.180.24]:22280 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S282921AbRK0T6n> convert rfc822-to-8bit;
	Tue, 27 Nov 2001 14:58:43 -0500
X-Originating-IP: [62.98.82.94]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <chaffee@cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <LAW2-OE64dLLZfOfAD200002cce@hotmail.com> <20011127091137.Z5129@suse.de>
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Date: Tue, 27 Nov 2001 20:59:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <LAW2-OE31k2VkJBQmE000002f0a@hotmail.com>
X-OriginalArrivalTime: 27 Nov 2001 19:58:35.0355 (UTC) FILETIME=[E5D392B0:01C1777D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have applied your patch against kernel 2.4.16
This was the message:

(Stripping trailing CRs from patch.)
patching file drivers/scsi/aic7xxx/aic7xxx_linux.c
Hunk #1 succeeded at 625 (offset 1 line).
Hunk #3 succeeded at 1714 (offset 1 line).

Then I built a kernel with hi mem support, and vfat driver built as a module.
reboot machine with new kernel.

Root login, modprobe vfat (modutils 2.4.12) and I always get this message:

Warning: loading /lib/modules/2.4.16/kernel/fs/vfat/vfat.o will taint the kernel: no license

Then I try I mount the vfat filesystem:

mount /dev/sda2 /mnt

and when I try to copy a file from the vfat FS to the linux root FS I get this kernel panic message

code: 0f 0b 80 4f 07 80 8b 03 8b 53 2c 83 ca 82 89 50 14 8b 13 8b
too few segs for dma mapping increase ahc-nseg
invalid operand: 0000
cpu: 0
eip: 0010 : [<c017f8b5>] tainted: P
eflags: 000010046
eax: ffffffff ebx: f7ea58f0 ecx: c0214000 edx: 00000000
esi: 00001000 edi: e3062800 ebp: f7ea1b40 esp: c0215e08
ds: 0018 es: 0018 ss: 0018
process swapper (pid:0, stackpage=c0215000)

<0>Kernel panic: Aiee, killing interrupt handler!
in interrupt handler_not syncing.


ebx, edi, ebp values change at every panic.

Hope this help you.

----- Original Message ----- 
From: "Jens Axboe" <axboe@suse.de>
To: "Marco Berizzi" <pupilla@hotmail.com>
Cc: <chaffee@cs.berkeley.edu>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 27, 2001 9:11 AM
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG


> On Tue, Nov 27 2001, Marco Berizzi wrote:
> > I have upgraded my PC from 768MB RAM to 1GB.
> > I have recompiled the kernel (2.4.16) for hi mem support (4GB).
> >
> > I have several file system on the same disk (vfat file system). I have
> > compiled vfat driver both in the main kernel and as a module. When I
> > load the module I issue a
> > 'modprobe vfat' and I get this message (only with hi mem kernel
> > support):
> >
> > Warning: loading /lib/modules/2.4.16/kernel/fs/vfat/vfat.o will taint
> > the kernel: no license
> >  I'm using Slackware 8.0. + modutils 2.4.12
> >
> > Then if I try to copy a file from that filesystem to the root filesystem
> > I get this error:
> >
> > Kernel panic: too few segs for DMA mappings increase AHC_NSEG
> >
> > Kernel panic: too few segs for DMA mappings increase AHC_NSEG
> 
> You still haven't applied the patch I sent? Sending the same report
> without this extra added infor 2 or 3 times isn't doing any good, sorry.
> 
> --
> Jens Axboe
> 
> 
