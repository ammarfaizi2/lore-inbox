Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKIQhP>; Thu, 9 Nov 2000 11:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbQKIQhG>; Thu, 9 Nov 2000 11:37:06 -0500
Received: from [62.172.234.2] ([62.172.234.2]:45719 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129030AbQKIQgy>;
	Thu, 9 Nov 2000 11:36:54 -0500
Date: Thu, 9 Nov 2000 16:36:59 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
cc: Petko Manolov <petkan@dce.bg>, linux-kernel@vger.kernel.org,
        sanjay kumar <satendra_patna@yahoo.com>
Subject: Re: is there a limit on bss size?
In-Reply-To: <20001006232601.G3388@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0011091633320.1549-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2000, Philipp Rumpf wrote:

> On Fri, Oct 06, 2000 at 12:32:35PM +0300, Petko Manolov wrote:
> > It is not so difficult as it looks.
> 
> I don't see it being difficult at all ...
> 
> > The master pgd looking as:
> > 
> > .org 0x1000
> > ENTRY(swapper_pg_dir)
> >         .long 0x00102007
> >         .long 0x00103007
> >         .fill BOOT_USER_PGD_PTRS-2,4,0
> >         /* default: 766 entries */
> >         .long 0x00102007
> >         .long 0x00103007
> >         /* default: 254 entries */
> >         .fill BOOT_KERNEL_PGD_PTRS-2,4,0
> > 
> > 
> > should become:
> > 
> > 
> > .org 0x1000
> > ENTRY(swapper_pg_dir)
> >         .long 0x00102007
> >         .long 0x00103007
> > 	....			# every entry addresses 4 MB exactly
> > 	....			# so add as much as you want
> > 	.long 0x0010X007
> >         .fill BOOT_USER_PGD_PTRS-X+2,4,0
> 
> I'm unconvinced we need to map more than 4 MB into low virtual addresses;
> nothing seems to break with
> 
> ENTRY(swapper_pg_dir)
>  	.long 0x00102007
> 	.fill BOOT_USER_PGD_PTRS-1,4,0
> 

Hi Phillip,

Ah, _now_ I understand what you are talking about (took me only slightly
over a month ;) and so can answer -- try making a huge bzImage (a few
megs) and boot with it. That was the main reason Werner added the extra
stuff somewhere around 2.3.99-preX.

Having said that, I still don't see why we actually need a specific label
(like pg1) for each successive page worth of pte's if we are filling them
with data starting from pg0 until we hit empty_zero_page (as I asked in my
other message).

Regards,
Tigran

PS. I cc'd the guy who was looking to extend the page tables for booting
with huge bss also...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
