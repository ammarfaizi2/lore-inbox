Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUDHU3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUDHU3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:29:04 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12188 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261794AbUDHU2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 16:28:14 -0400
Date: Thu, 8 Apr 2004 22:28:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] obsolete asm/hdreg.h [3/5]
In-Reply-To: <200404081809.09937.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.58.0404082226270.19951@waterleaf.sonytel.be>
References: <200404080023.04460.bzolnier@elka.pw.edu.pl>
 <Pine.GSO.4.58.0404081048270.9729@waterleaf.sonytel.be>
 <200404081809.09937.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 08 of April 2004 10:49, Geert Uytterhoeven wrote:
> > On Thu, 8 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > > [IDE] asm/ide.h: ide_ioreg_t cleanup
> > >
> > > ide_ioreg_t is deprecated and hasn't been used by IDE driver for some
> > > time. Use unsigned long directly on alpha, arm26, arm, mips, parisc,
> > > ppc64 and sh.
> > >
> > > asm-ia64/ide.h (ide_ioreg_t is unsigned short) and asm-m68knommu/ide.h
> > > (broken - ide_ioreg_t is not defined) are the only users of ide_ioreg_t
> > > left.
> >
> > Why do you consider asm-m68knommu/ide.h broken?
> >
> > It just includes <asm-m68k/hdreg.h>, which is definitely not broken since
> > it's happily (albeit very slowly) running apt-get upgrade right now ;-)
>
> Well...
>
> In kernel 2.5.70 ide_ioreg_t typedef was removed from
> <asm-m68k/hdreg.h> and it is used all over <asm-m68knommu/ide.h>.

Ah, now I see. I didn't really notice you were also talking about ide.h, not
hdreg.h ;-)

> I see that this is fixed in linux-m68k-cvs but...
>
> <asm-m68knommu/ide.h> hasn't been updated since kernel 2.5.46
> and still depends on inlines which were removed from IDE code:
> - ide_request_irq() (special case for COLDFIRE)
> - ide_{request, release}_region(),
>   which are empty because M68K use memory IO
> - ide_fix_driveid() (special case for COLDFIRE),
>   conflicts with generic version in drivers/ide/ide-iops.c
> - maybe more
>
> This issues are not fixed in linux-m68k-cvs tree.
> [ Is there a separate m68knommu tree? ]

The uClinux tree? But I don't think these issues were solved there yet, since
the latest uc patch is quite small.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
