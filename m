Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289167AbSAGKdf>; Mon, 7 Jan 2002 05:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289169AbSAGKd0>; Mon, 7 Jan 2002 05:33:26 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:21774 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S289167AbSAGKdU>; Mon, 7 Jan 2002 05:33:20 -0500
Date: Mon, 7 Jan 2002 11:33:18 +0100 (CET)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Andrew Morton <akpm@zip.com.au>
cc: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <3C3973D9.CF689345@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201071131330.17279-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Andrew Morton wrote:

> Richard Guenther wrote:
> >
> > On Mon, 7 Jan 2002, Oliver Paukstadt wrote:
> >
> > > Heavy traffic on ext3 seems to cause short system freezes.
> >
> > I see dropped frames while watching TV (bttv chip, xawtv in overlay mode,
> > XFree 4.1.0)
> > since I use ext3 (2.4.16&17). Always during disk activity (IDE, umask irq
> > and dma enabled). From what I know the bttv driver does it seems to loose
> > interrupts!? This doesnt happen with ext2.
>
> ext3 never blocks interrupts.  It _may_ cause increased interrupt
> latency than ext2 by the very large linear writes which it does.  These
> may cause other parts of the kernel to block interrupts for longer.
>
> However, more likely that it's a scheduling latency problem.  Sigh.
> I spent *ages* on the ext3 buffer writeout code and it's still not
> ideal.  Can you test with this patch applied?
>
> http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre1/mini-ll.patch

I'll check that later tonight.

> > ...
> > By any chance, is some global lock held during any IO intensive part of
> > ext3?
>
> Yes, a couple.  But on uniprocessor it's more a matter of the kernel
> failing to context switch promptly.

Umm, I doubt that - the bttv driver does overlay grabbing completely
within an interrupt handler. I'll look if the bttv card shares with
the IDE interrupt or maybe the drivers way of operation changed. Oh well.

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

