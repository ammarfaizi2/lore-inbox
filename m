Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265354AbSJXJDx>; Thu, 24 Oct 2002 05:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265357AbSJXJDx>; Thu, 24 Oct 2002 05:03:53 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39405 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265354AbSJXJDw>;
	Thu, 24 Oct 2002 05:03:52 -0400
Date: Thu, 24 Oct 2002 11:09:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrey Panin <pazke@orbita1.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
Message-ID: <20021024110927.A2733@ucw.cz>
References: <20021022065028.GA304@pazke.ipt> <3DB5706A.9D3915F0@cinet.co.jp> <1035374538.4033.40.camel@irongate.swansea.linux.org.uk> <3DB6A212.74D592D0@cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DB6A212.74D592D0@cinet.co.jp>; from tomita@cinet.co.jp on Wed, Oct 23, 2002 at 10:20:18PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:20:18PM +0900, Osamu Tomita wrote:
> Alan Cox wrote:
> > 
> > On Tue, 2002-10-22 at 16:36, Osamu Tomita wrote:
> > > IORESOURCE98_SPARSE flag means odd or even only addressing.
> > > We modify check_region(), request_region() and release_region().
> > > If length parameter has negative value, addressing is sparse.
> > > For example,
> > >  request_region(0x100, -5, "xxx"); gets 0x100, 0x102 and 0x104.
> > 
> > Does PC-9800 ever have devices on 0x100/2/4/8 overlapping another device
> > on 0x101/103/105 ?
> Yes.
> Here is io resource definition for PC-9800. (extract from patch)
> struct resource standard_io_resources[] = {
>         { "pic1", 0x00, 0x02, IORESOURCE_BUSY | IORESOURCE98_SPARSE},
>         { "dma", 0x01, 0x2d, IORESOURCE_BUSY | IORESOURCE98_SPARSE },
>         { "pic2", 0x08, 0x0a, IORESOURCE_BUSY | IORESOURCE98_SPARSE },
>         { "calender clock", 0x20, 0x22, IORESOURCE98_SPARSE },
> PIC1 uses 0x00 and 0x02.
> DMA controler uses 0x01, 0x03, 0x05,....0x2d.
> PIC2 uses 0x08 and 0x0a.
> RTC uses 0x20 and 0x22.
> They are overlapping.

For system resources you simply could allocate 0x00-0x2f and be done
without the sparse flag, but if there are any other devices that have
overlapping resources, which need separate drivers (IDE, sound, network,
...) then the sparse ioresource flag is indeed needed. Is it so?

-- 
Vojtech Pavlik
SuSE Labs
