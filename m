Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264973AbSJWNPB>; Wed, 23 Oct 2002 09:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJWNPA>; Wed, 23 Oct 2002 09:15:00 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:32326 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264973AbSJWNO7>; Wed, 23 Oct 2002 09:14:59 -0400
Message-ID: <3DB6A212.74D592D0@cinet.co.jp>
Date: Wed, 23 Oct 2002 22:20:18 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrey Panin <pazke@orbita1.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
References: <20021022065028.GA304@pazke.ipt> 
		<3DB5706A.9D3915F0@cinet.co.jp> <1035374538.4033.40.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Tue, 2002-10-22 at 16:36, Osamu Tomita wrote:
> > IORESOURCE98_SPARSE flag means odd or even only addressing.
> > We modify check_region(), request_region() and release_region().
> > If length parameter has negative value, addressing is sparse.
> > For example,
> >  request_region(0x100, -5, "xxx"); gets 0x100, 0x102 and 0x104.
> 
> Does PC-9800 ever have devices on 0x100/2/4/8 overlapping another device
> on 0x101/103/105 ?
Yes.
Here is io resource definition for PC-9800. (extract from patch)
struct resource standard_io_resources[] = {
        { "pic1", 0x00, 0x02, IORESOURCE_BUSY | IORESOURCE98_SPARSE},
        { "dma", 0x01, 0x2d, IORESOURCE_BUSY | IORESOURCE98_SPARSE },
        { "pic2", 0x08, 0x0a, IORESOURCE_BUSY | IORESOURCE98_SPARSE },
        { "calender clock", 0x20, 0x22, IORESOURCE98_SPARSE },
PIC1 uses 0x00 and 0x02.
DMA controler uses 0x01, 0x03, 0x05,....0x2d.
PIC2 uses 0x08 and 0x0a.
RTC uses 0x20 and 0x22.
They are overlapping.

Regards
Osamu Tomita
