Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318725AbSH1FeQ>; Wed, 28 Aug 2002 01:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSH1FeP>; Wed, 28 Aug 2002 01:34:15 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:19719 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S318725AbSH1FeJ>; Wed, 28 Aug 2002 01:34:09 -0400
Date: Wed, 28 Aug 2002 13:37:42 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Chua <jchua@fedex.com>, Erik Andersen <andersen@codepoet.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
In-Reply-To: <20020827103047.A13528@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208281329150.9089-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/28/2002
 01:38:17 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/28/2002
 01:38:23 PM,
	Serialize complete at 08/28/2002 01:38:23 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Aug 2002, Russell King wrote:

> The other possibility is this little critter:
>
> static int __init fill_inbuf(void)
> {
>         if (exit_code) return -1;
>
>         insize = read(crd_infd, inbuf, INBUFSIZ);
>         if (insize == 0) return -1;
>
>         inptr = 1;
>
>         return inbuf[0];
> }
>
> You could put printks in the paths that return -1 and see if you're
> hitting any of those.
>
> However, returning '-1' is asking for trouble.  When I was looking at
> how to handle the "out of space" in the ramdisk issue, I found that
> there appears to be NO value that fill_inbuf() can return that will
> guarantee to terminate inflate.c at an arbitary point in the
> decompression.
>
> In gzip, we abort the program on error.  In the kernel, we don't
> have that luxury.  (Luckily initramfs uses a cut-down gzip to do
> the decompression, which can exit on error.)


What I found when I ran ram18.gz and ram24.gz was ...

ram18.gz has 18MB filled of available 28MB [6MB gzipped]

ram24.gz has 24MB filled of available 28MB [8MB gzipped]

in the case of ram24.gz, "inflate_stored" from lib/inflate.c was called,
but ram18.gz never called this function ... meaning the gzipped was
corrupted during boot up for ram24.gz. Where ... I don't know.


