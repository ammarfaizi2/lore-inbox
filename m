Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSD3HhH>; Tue, 30 Apr 2002 03:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSD3HhG>; Tue, 30 Apr 2002 03:37:06 -0400
Received: from krynn.axis.se ([193.13.178.10]:15492 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S313122AbSD3HhF>;
	Tue, 30 Apr 2002 03:37:05 -0400
From: johan.adolfsson@axis.com
Message-ID: <00a601c1f01a$19443180$87b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Daniel Quinlan" <quinlan@transmeta.com>
Cc: "Johan Adolfsson" <johan.adolfsson@axis.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204291553570.25892-100000@ado-2.axis.se>
Subject: Re: [RFC/FYI] cramfs 6/6 - boot/root stuff
Date: Tue, 30 Apr 2002 09:39:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Daniel Quinlan" <quinlan@transmeta.com> wrote in message
news:6yy9f6rw5q.fsf@transmeta.com...
> Johan Adolfsson <johan.adolfsson@axis.com> writes:
>
> > <ugly hack warning>
> > 6. (RFC/FYI) In our tree we have a hack that allows us
> >    to append the cramfs image to the kernel image and use it to boot
from.
> > [...]
> > Any hints of other approaches?
>
> It seems much cleaner to use the padding option to put some boot code
> in the first 512 bytes of the cramfs image which you can use to jump
> to anywhere in the image.
>
> What we did for x86 was to put boot code in the first 512 bytes (the
> "-p" option to mkcramfs), then jump to 512 bytes after the superblock
> start (offset 1024) which was where we put the kernel (put there via the
> "-i" option to mkcramfs, just a normal kernel image padded at the
> beginning by 436 bytes so it would start at offset 1024).
>
> We could have just jumped to offset 588 instead of 1024 and not padded
> the kernel, but we used even numbers for some (aesthetic?) reason that I
> can't recall.
>
> Dan

That wouldn't work that well for us, I think, or at least we
probably couldn't use the same cramfs image for development
(network boot) as for flash boot.

Our normal flash image looks something like this:
64k bootblock
partition table (with code that jumps over it)
decompressor
compressed kernel
cramfs image
padding
JFFS partition

the compressed kernel is decompressed to RAM and started.
I agree that having the compressed kernel as part of the
cramfs image would be nice, but is the image exposed in the
filesystem as well?
It doesn't look like it when I look at the code.
That could be a nice feature as well.

During development, we download an image to RAM directly without
flashing it which takes two seconds or so instead of waiting for the
flash chips to be erased. That image contains the kernel (not compressed)
with an appended cramfs image.
I don't think we can waste that additional amount of RAM by having
the kernel both uncompressed and then compressed in the cramfs image,
at least not for hardware with only 8MB RAM.

I did some fiddling with the MTD RAM yesterday and think I got it
to work after some editing, patches will be submitted to the mtd list.

/Johan


