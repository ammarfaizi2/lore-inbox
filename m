Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTA2SG1>; Wed, 29 Jan 2003 13:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbTA2SG1>; Wed, 29 Jan 2003 13:06:27 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:9482 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266765AbTA2SG0>; Wed, 29 Jan 2003 13:06:26 -0500
Date: Wed, 29 Jan 2003 18:15:36 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
In-Reply-To: <20030129190647.A689@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0301291813330.22973-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Jan 28, 2003 at 06:23:15PM +0100, Benjamin Herrenschmidt wrote:
> > Disabling VGA dynamically depending on the machine have been a real pain
> > until now. With that change, it will now just be a matter for our PPC
> > implementation of pci_request_legacy_resource() to fail on machines
> > where VGA memory can't be reached.
> 
> Here's updated version of yesterday's patch that makes this possible.
> - pci_request_legacy_resource() is supposed to return two error codes:
>   -ENXIO (no such device or address), which must be treated as fatal;
>   -EBUSY, returned by request_resource() in the case of resource conflict,
>   like i386 case where the startup code reserves certain low memory regions
>   including video memory. This error can be ignored for now (at least in the
>   vgacon driver), because resource start/end fields are correctly adjusted
>   anyway.
> - Fixed bug wrt adjusting static struct resource (thanks to Jeff for
>   finding that). The vgacon can be started twice: early on startup and,
>   if this fails because we assumed the wrong bus, after PCI init when we
>   actually located the VGA card. However, static VGA resources are already
>   "fixed" after the first try, so the second attempt fails as well.
> - Make no_vga case to release VGA resources.

As a small note I really like to move vagcon.c to start to use the inline 
functions in include/video/vga.h. I have provisions to even use a specific 
register base region. I like to combine it with your work.


